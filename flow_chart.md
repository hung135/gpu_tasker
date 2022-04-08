```mermaid
graph TD
    A["JSON #128193;"] -->|SCP| F
    B -->|SCP| F
    C -->|SCP| F   
    B["python code #128193;"]
    C["Training Data #128193;"]
    D["RunTime #128193;"] 
    E["Completed #128193;"]
    F{UploadResource.sh}-->|Config, Code, Data|G
    F -->|Copy Config|D
    G(GPU SERVER)
    H{run.sh}-->|Move Each Config|E 
    H-->|Trigger Python Per Config File|G 
    D -->|SUB FOLDER| H
    G-->II["Data OutPut #128193;"]-->I
    I{Download.sh}-->|"Copy Down T:/"|J
    J("#128193;")
    
    
    
```
    
