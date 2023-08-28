shinyServer(function(input, output, session) {

  reviewerSession <-reactive({
    sessions <- googlesheets4::read_sheet(googleSheetId, sheet = "reviewerSession")  
    sessions$DateCreated<-as.Date(sessions$DateTimeCreated)
    sessions <- sessions[!is.na(sessions$Name),]
    sessions[grepl("Heffernan", sessions$Name),]$Name <- "Aine Heffernan"
    
    return(sessions)
  })
  
  reviewerList <- reactive({
    reviewerList <- googlesheets4::read_sheet(googleSheetId, sheet = "reviewerList")
    reviewerList[grepl("Heffernan", reviewerList$Name),]$Name <- "Aine Heffernan"
    return(reviewerList)
  })
  
  clinicalReviewers <- reactive({
    reviewers1 <- reviewerSession()%>%
      filter(project == "clinical")%>%
      group_by(Name)%>%
      summarise(nSession = length(unique(StudyIdStr)))%>%
      arrange(desc(nSession))%>%
      select(Name)
    
    reviewers2<- reviewerList()%>%
      filter(project == "clinical")%>%
      select(Name)
    
    reviewers <- c(unlist(reviewers1), unlist(reviewers2))%>%unique()
    
    reviewers <- reviewers[reviewers != "CAMARADES Edinburgh"]
    return(reviewers)
  })
  
  
  preclinicalReviewers <- reactive({
    reviewers1 <- reviewerSession()%>%
      filter(project == "in vivo")%>%
      group_by(Name)%>%
      summarise(nSession = length(unique(StudyIdStr)))%>%
      arrange(desc(nSession))%>%
      select(Name)
    
    reviewers2<- reviewerList()%>%
      filter(project == "in vivo")%>%
      select(Name)
    
    reviewers <- c(unlist(reviewers1), unlist(reviewers2))%>%unique()%>%replace_non_ascii()
    
    reviewers <- reviewers[reviewers != "CAMARADES Edinburgh"]
    
    return(reviewers)
  })
  
  
  reviewerRewardSettings <- reactive({googlesheets4::read_sheet(googleSheetId, sheet = "reviewerRewardSettings", col_types = "c")})
  
  
  
  output$clinicalReviewers <- renderText({
    paste(as.data.frame(clinicalReviewers())[,1], collapse = ", ")
  })
  
  output$preclinicalReviewers <- renderText(
    paste(as.data.frame(preclinicalReviewers())[,1], collapse = ", ")
  )
  
  
  #contributors-------------
  alltimereviews<-reactive({
    alltimereviews <- reviewerSession() %>%
      dplyr::group_by(InvestigatorIdStr, Name) %>%
      dplyr::summarise(AllTimeReviews = n(),.groups="drop")%>%
      dplyr::arrange(desc(AllTimeReviews)) %>%
      rename(Reviewer = Name)
    return(alltimereviews[,c("Reviewer", "AllTimeReviews")])
  })
  
  rewardreviews<-reactive({
    reviewerRewardSettings <- data.table::first(reviewerRewardSettings()[reviewerRewardSettings()$current == "Yes",])
    rewardreviews <- reviewerSession() %>%
      dplyr::filter(DateTimeCreated > as.POSIXct(reviewerRewardSettings$StartTime) & DateTimeCreated < as.POSIXct(reviewerRewardSettings$EndTime) & !StageIdStr %in% reviewerRewardSettings$excludeStage &  !InvestigatorIdStr %in% strsplit(reviewerRewardSettings$excludIdStr, ";")[[1]] ) %>%
      dplyr::group_by(InvestigatorIdStr,  Name) %>%
      dplyr::summarise(RewardReviews = n(),.groups="drop") %>%
      dplyr::arrange(desc(RewardReviews)) %>%
      dplyr::rename(Reviewer = Name) %>%
      dplyr::mutate(Reviewer = ifelse(RewardReviews>=200, paste(Reviewer,"<img src=", "'", "goldmedal.png", "'", "height=30, width=30></img>"), ifelse(RewardReviews>=100, paste(Reviewer,"<img src=", "'", "silvermedal.png", "'","height=30, width=30></img>"), ifelse(RewardReviews >= 10, paste(Reviewer,"<img src=","'","bronzemedal.png", "'", "height=30, width=30></img>"), Reviewer))))
    # dplyr::mutate(Reviewer = ifelse(RewardReviews >= 10, paste0(Reviewer,"<img src=","'","bronzemedal.png", "'", "height=40, width=40></img>"), ""))%>%
    # dplyr::mutate(Reviewer = ifelse(RewardReviews>=100, paste0(Reviewer,"<img src=", "'", "silvermedal.png", "'","height=40, width=40></img>"), paste(Reviewer)))%>%
    # dplyr::mutate(Reviewer = ifelse(RewardReviews>=200, paste0(Reviewer,"<img src=", "'", "goldmedal.png", "'", "height=40, width=40></img>"), paste(Reviewer)))
    # rewardreviews<-leaderboard%>%
    #   select(Reviewer,RewardReviews)%>%
    #   arrange(desc(RewardReviews))%>%
    #   mutate(Badge = ifelse(RewardReviews >= 10, paste0("<img src=","'","bronzemedal.png", "'", "height=40, width=40></img>"), ""))%>%
    #   mutate(Badge = ifelse(RewardReviews>=100, paste0("<img src=", "'", "silvermedal.png", "'","height=40, width=40></img>"), paste(Badge)))%>%
    #   mutate(Badge = ifelse(RewardReviews>=200, paste0("<img src=", "'", "goldmedal.png", "'", "height=40, width=40></img>"), paste(Badge)))
    return(rewardreviews[,c("Reviewer", "RewardReviews")])
  })
  
  monthreviews <- reactive({
    monthreviews <- reviewerSession() %>%
      #    dplyr::filter(DateCreated >= lubridate::today() - lubridate::days(30)) %>%
      #    dplyr::group_by(InvestigatorIdStr,  Name) %>%
      #    dplyr::summarise(MonthReviews = n(),.groups="drop") %>%    
      #    dplyr::arrange(desc(MonthReviews))%>%
      #    dplyr::rename(Reviewer = Name)
      # monthreviews<-leaderboard%>%
      #   select(Reviewer, MonthReviews)%>%
      #   arrange(desc(MonthReviews))%>%
      #   top_n(n=5)
      # month<-reviewerSession() %>%
      dplyr::filter(year(DateTimeCreated) == year(Sys.time()) & month(DateTimeCreated) == month(Sys.time())) %>%
      dplyr::group_by(InvestigatorIdStr,  Name) %>%
      dplyr::summarise(MonthReviews = n(),.groups="drop") %>%    
      dplyr::arrange(desc(MonthReviews))%>%
      dplyr::rename(Reviewer = Name) 
    # 
    # month
    return(monthreviews[c("Reviewer", "MonthReviews")])
  })
  
  output$alltimeleaderboard<-
    DT::renderDataTable(DT::datatable(
      alltimereviews(),# rownames = FALSE,
      colnames=c("Reviewer", "N"  # "Number of reviews (all time)"
      ),
      options = list(
        pageLength = 10,dom = 'tp'
      )    ))
  
  output$monthleaderboard<-
    DT::renderDataTable(DT::datatable(
      monthreviews(), # rownames = FALSE,
      colnames=c("Reviewer","N" # "Number of reviews (all time)"
      ) # c(  "Number of reviews (past 30 days)" 
      ,
      options = list(
        pageLength = 10,dom = 'tp'
      )    ))
  
  output$rewardleaderboard<-
    DT::renderDataTable(DT::datatable(
      rewardreviews(), # rownames = FALSE,
      colnames=c("Reviewer", "N" # "Number of reviews", "Badge"
      ),
      escape=F    ,
      options = list(
        pageLength = 10,dom = 'tp'
      )
    ))
  })