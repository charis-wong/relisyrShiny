header <- dashboardHeader(title = "ReLiSyR-MND")

dashboardSidebar <- dashboardSidebar(sidebarMenu(
  
  menuItem("About ReLiSyR-MND", 
           tabName = "about", 
           icon = icon("info")),
  
  menuItem("About Us",
           tabName="aboutus",
           icon = icon("address-card")),
  
  menuItem("Contributors",
           tabName = "contributors",
           icon = icon("users")),
  
  menuItem("Outputs",
           tabName = "publications",
           icon = icon("file")),
  
  menuItem("Code",
           tabName = "code",
           icon = icon("code")),
  
  menuItem("Contact us",
           tabName = "contact",
           icon = icon("envelope"))
))

body <- dashboardBody(
  tabItems(
    
    # ---- about ReLiSyR tab-------------------------------------
    tabItem(
      tabName = "about",
      fluidRow(
        column(width=12,
               box(
                 title="What is ReLiSyR-MND?", width=NULL,  status="info",
                 strong("Repurposing Living Systematic Review-MND (ReLiSyR-MND)"),  
                 "is a project by", 
                 tags$a(href="https://www.ed.ac.uk/clinical-brain-sciences/research/camarades/", "CAMARADES"),
                 "and ",
                 tags$a(href="https://mnd-smart.org.uk", "MND-SMART"),
                 ". ",
                 p("ReLiSyR-MND is a crowdsourced three-part machine learning assisted living systematic review of:",
                   tags$ul(
                     tags$li("Clinical literature of MND and other neurodegenerative diseases which may share common pivotal pathways, namely, Alzheimer's disease (AD), Frontotemporal dementia (FTD), Huntington's disease (HD), Multiple Sclerosis (MS) and Parkinson's disease (PD)."),
                     tags$li("Animal in vivo literature of MND and FTD models."),
                     tags$li("In vitro studies of MND and FTD models including induced pluripotent stem cell studies.")
                   ),
                   
                   p("We use ReLiSyR-MND as part of our, ", 
                     strong("Systematic Living Evidence for Clinical Trials (SyLECT) framework"), 
                     "to inform identification and prioritisation of candidate drugs by our expert panel for",
                     tags$a(href="https://mnd-smart.org.uk", "MND-SMART"),
                     ". Using SyLECT, we generate, synthesise and report data for longlisted drugs from different domains of data. Other domains include:",
                     tags$ul(
                       tags$li("Experimental drug screening"),
                       tags$li("Pathway and network analysis"),
                       tags$li("Mining of drug and trial databases, such as", tags$a(href = "https://www.ebi.ac.uk/chembl/", "ChEMBL database"), ","
                               , tags$a(href = "https://www.clinicaltrials.gov/", "clinicaltrials.gov"), "and the", tags$a(href = "https://www.bnf.nice.org.uk", "British National Formulary"), ".")
                     )
                   ), 
                   
                   img(src = "drug selection framework lay slide.png", height = 350, align = "center"),
                   p("SyLECT: Systematic Living Evidence for Clinical Trials framework"),
                   
                   p("We use the Integrated Candidate Drug List for MND (ICAN-MND) and MND-SOLES-CT (MND Systematic Online Living Evidence Summary for Clinical Trials) to summarise and report evidence synthesised.
                   Demo versions of these apps are available below:"),
                   tags$ul(
                     tags$li(tags$a(href = "https://camarades.shinyapps.io/ICAN-MND-demo", "Demo for ICAN-MND")),
                     tags$li(tags$a(href = "https://camarades.shinyapps.io/MND-SOLES-CT-demo", "Demo for MND-SOLES-CT"))
                   )),
                 
                 
                 box(title="ReLiSyR-MND Methodology", width=NULL,status="info",
                     p("Our methodology is detailed in our",
                       tags$a(href="https://osf.io/bkscj", "protocol."),
                       "We adopted a systematic approach of evaluating drug candidates which we have previously used to guide drug selection for the Multple Sclerosis Secondary Progressive Multi-Arm Randomisation Trial (MS-SMART) a  multi-arm phase IIb randomised controlled trial comparing the efficacy of three neuroprotective drugs in secondary progressive multiple sclerosis. These principles of drug selection were published by",
                       tags$a(href="https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0117705","Vesterinen et al."),
                       "in 2015."),
                     p("This approach, which adopts a structured, systematic method combined with independent expert(s) evaluation, was designed to identify candidate drugs for evaluation in clinical trials for people with neurodegenerative diseases, including MND, on account of the compelling evidence for shared dysregulated pathways and processes across neurodegenerative disorders. 
                     Critically, the structured evaluation takes into account not only biological plausibility and efficacy but also safety and quality of previous studies. This includes adopting benchmark practice such as Delphi and PICOS framework."),
                     p("1.", strong("Living Search"), 
                       ": We use the",
                       tags$a(href="https://syrf.org.uk","Systematic Review Facility (SyRF) platform"),
                       ", taking as its starting point automatic updating of the PubMed search."),
                     p("2.", strong("Citation Screening"),
                       ": Using a machine learning algorithm which has been trained and validated using human decisions, publications are screened for inclusion based on title and abstract."), 
                     p("3.", strong("Filtering drugs by inclusion logic"),
                       ": Text mining approaches (Regular Expressions deployed in R and taking as source material title and abstract) are used to identify disease and drug studied. A second algorithm is used to identify drugs which have been tested in at least one clinical study in MND; or have been tested clinically in two of the other specified conditions."),
                     p("4.", strong("Longlisting by trial investigators"),
                       ": Trial investigators reviewed the drugs filtered, excluding drugs which met the following critera: (i) previously considered unsuitable by expert panel due to lack of biological plausibility, drugs with unfavourable safety profiles in MND patients and drugs tested more than 3 times in MND population; (ii) drugs available over-the-counter as these may affect trial integrity; (iii) compounds which are not feasible for the next arms due to supply issues, such as compopunds not listed in the current version of the British National Formulary; (iv) drugs without oral preparations; and (v) drugs that are deemed by investigators to be unsafe/inappropriate for clinical trial in the current setting."),
                     p("5.", strong("Data extraction"), 
                       ": Our team of reviewers extract data specified in our protocol on the",
                       tags$a(href="https://syrf.org.uk", "SyRF platform"),
                       "from all included publications for longlisted drugs. Each publication will be annotated by at least two reviewers, with any differences reconciled by a third reviewer."),
                     p("6.", strong("Data Analysis"),
                       ": We will analyse the results as follows:",
                       tags$ul(
                         tags$li("Clinical review:","For each publication, we calculated a",
                                 tags$a(href = "https://mfr.de-1.osf.io/render?url=https://osf.io/8k4h2/?direct%26mode=render%26action=download%26mode=render", "distance score"),
                                 "based on Euclidean distance of efficacy and safety scores weighted by quality and study size. For each drug, we calculate a drug score using the number of publications describing the drug (n) and median publication distance score for all publications describing data for that drug:", withMathJax("$$\\text{drug score}\\ = log10{(n+1)} \\times {(\\text{median distance score})}$$"),
                                 
                                 "Separately, we will calculate median subscores for efficacy, safety, quality and study size across all publications for each drug."),
                         tags$li("Animal invivo review and in vitro review: An individual meta‐analysis will be carried out for each intervention identified. We will summarise the effects of interventions where there are 3 or more publications in which that intervention has been tested reporting findings from at least 5 experiments. Depending on the nature of the outcomes reported we will use either standardised mean difference (SMD) or normalised mean difference (NMD) random effects meta-analysis with REML estimates of tau. Specifically, if fewer than 70% of outcomes are suitable for NMD analysis we will use SMD. Differences between groups of studies will be identified using meta-regression."
                         ))
                     )))))),
    
    # ---- contributor tab------------------------------
    tabItem(
      tabName="contributors",
      fluidPage(
        fluidRow(
          
          box(width=12,status = "primary",
              h3("Reviewers"),
              p("The ReLiSyR-MND project includes a crowd-sourcing element to the systematic reviews. We have an expanding group of reviewers who have contributed in various stages of this project including screening and annotation."),
              p("All registered reviewers past and present are listed here."),
              p(strong("Clinical Reviewers:"), textOutput("clinicalReviewers")),
              p(strong("Preclinical Reviewers:"), textOutput("preclinicalReviewers"))
          )),
        h3("Data extraction leaderboards"),
        fluidRow(
          column(width=12,height=1010,
                 box(width=6,status = "warning", height=800,
                     title="Monthly leaderboard",
                     p("Our top reviewers for the month of", month(Sys.time(), label=TRUE, abbr = FALSE), " ", year(Sys.time())),
                     DT::dataTableOutput('monthleaderboard') %>% withSpinner(color="#0dc5c1")),
                 box(width=6, status = "success", height=800,
                     title="All-time Leaderboard",
                     DT::dataTableOutput('alltimeleaderboard') %>% withSpinner(color="#0dc5c1"))
          ))
      )
    ),
    
    # ---- about us tab------------------------------
    
    tabItem(
      tabName = "aboutus",
      fluidRow(
        box(title = "CAMARADES", width=6, status="danger", 
            tags$a(href= "https://www.ed.ac.uk/clinical-brain-sciences/research/camarades/", img(src = "camaradeslogo_1500x275.jpg", width = "100%", height = "100%", align = "left")),
            p("The", tags$a(href="https://www.ed.ac.uk/clinical-brain-sciences/research/camarades/", "CAMARADES"), "(Collaborative Approach to Meta-Analysis and Review of 
                     Animal Data from Experimental Studies) group specialise in performing", strong("systematic review and meta-analysis"), "of data
                     from experimental studies. Our interests range from identifying potential sources of bias in in vivo and in vitro studies; 
                     developing automation tools for evidence synthesis; developing recommendations for improvements in the design and
                     reporting; through to developing meta-analysis methodology to better apply to in basic research studies."),
            p("Follow us on twitter", tags$a(href="https://twitter.com/camarades_?", "@CAMARADES_")),
            
            p("CAMARADES have produced other projects providing curated online evidence summaries in other disease areas including:",
              tags$ul(
                tags$li(tags$a(href="https://camarades.shinyapps.io/COVID-19-SOLES", "COVID-19 Systematic Online Living Evidence Summary (SOLES) project"), ","),
                tags$li(tags$a(href="https://camarades.shinyapps.io/AD-SOLES", "Transgenic Animal Models of Alzheimer's Disease")), 
                tags$li(tags$a(href="https://khair.shinyapps.io/STROKE-SOLES", "Stroke"), ".")
              )
            )),
        box(title = "MND-SMART", width=6, status="primary",
            tags$a(href = "https://mnd-smart.org/", img(src = "MND-SMART logo.jpg", width = "100%", height = "100%", align = "left")),
            p("ReLiSyR-MND is a collaboration with investigators of the", tags$a(href="https://mnd-smart.org","Motor Neurone Disease – Systematic Multi-arm Adaptive Randomised Trial (MND-SMART)"),
              "team to inform selection of the drugs for future arms of the trial. MND-SMART is registered on clinicaltrials.gov",
              tags$a(href="https://www.clinicaltrials.gov/ct2/show/NCT04302870", "(NCT04302870)"),
              ". MND-SMART is an adaptive multi-arm multi-stage clinical trial aiming to efficiently evaluate repurposed drugs in MND. It is led by the",
              tags$a (href="http://euanmacdonaldcentre.org/", "Euan MacDonald Centre"),
              "based at the",
              tags$a(href="https://www.ed.ac.uk/", "University of Edinburgh"),
              "alongside colleagues from",
              tags$a(href = "https://www.mrcctu.ucl.ac.uk/", "MRC Clinical Trials Unit"),
              ", ",
              tags$a (href="https://www.ucl.ac.uk/", "University College London"),
              ", and the",
              tags$a (href="https://warwick.ac.uk/", "University of Warwick"),
              ". MND-SMART is part of the",
              tags$a(href = "https://www.mrcctu.ucl.ac.uk/our-research/neurodegenerative-diseases/acord-collaboration/", "ACORD collaboration"),
              " (A collaboration of groups developing, running and reporting multi-arm multi-stage (MAMS) platform trials in neurodegenerative diseases). The trial receives funding from the",
              tags$a( href="http://euanmacdonaldcentre.org/", "Euan MacDonald Centre for MND Research"),
              ",",
              tags$a(href="https://www.mndscotland.org.uk/", "MND Scotland"), 
              "and",
              tags$a(href="https://www.myname5doddie.co.uk/", "My Name'5 Doddie Foundation"),
              "."
            ))
        
      )),
    
    tabItem(
      tabName = "publications", 
      
      fluidRow(
        box(title = "Poster",
            status = "primary",
            width = 8,
            tags$iframe(style="height: 1200px; width:100%", 
                        src="2022-05-04ENCALS2022CWongPosterV2.pdf")
        ),
        
        
        box(title = "Publication",
            status = "primary",
            width = 4,
            
            "Please see our manuscript on our approach towards selecting the first two arms of MND-SMART:",
            
            
            p("Wong C, Gregory JM, Liao J, et. al. Systematic, comprehensive, evidence-based approach to identify neuroprotective interventions for motor neuron disease: using systematic reviews to inform expert consensus. 
          BMJ Open. 2023 Feb 1;13(2):e064169.", 
              tags$a(href =  "https://doi.org/10.1136/bmjopen-2022-064169", "doi: 10.1136/bmjopen-2022-064169."),
              "PMID: 36725099; PMCID: PMC9896226."
            ))
      )
    ),
    
    tabItem(
      tabName = "code",
      box(title = "Source code",
          status="primary",
          solidHeader = TRUE,
          width = 12, 
          p("Source code for this app is available on",
            tags$a(href = "https://github.com/charis-wong/relisyrShiny", "GitHub", .noWS = "after"),
            ".")
      )
    ),
    
    
    tabItem(
      tabName = "contact",
      box(title = "Contact us",
          status="primary",
          solidHeader = TRUE,
          width = 12, 
          p("For queries, please contact", 
            tags$a(href = "mailto:charis.wong@ed.ac.uk", 
                   "charis.wong@ed.ac.uk", .noWS = "after"),
            "."
          ),
          p("Follow us on twitter", tags$a(href="https://twitter.com/RelisyrMND", "@RelisyrMND")),
          
      )
    )
    
    
  ))

shinyUI(dashboardPage(skin = "blue",
                      header,
                      dashboardSidebar,
                      body))

