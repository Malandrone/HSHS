![alt text](https://raw.githubusercontent.com/Malandrone/HSHS/main/Logo.PNG)
# HSHS 
HSHS(HTTP Security Headers Scanner) is a simple PowerShell tool which helps to improve websites's security regarding http headers.
The tool analyzes http headers configuration of a website and compares it with a compliant configuration from an input file (conf.txt).
By default the compliant configuration is the one proposed by [OWASP](https://owasp.org/).
The comparison highlights the deviation of the detected configuration from the compliant one. Based on this, the score is calculated.
Scan results can be exported on a HTML report file.

**WARNING**:
If there is a proxy in your network, this might avoid the tool from working properly.

### How to use the tool
Click on HSHS.bat to start the GUI. 
The main menu includes the following options:
- **[1]-Analyze HTTP Headers:** Requires to specify a URL and performs http headers scan on it. Finally results are displayed.
- **[2]-View compliant configuration:** Shows the headers configuration which will be compared with the one of scanned websites. It can be changed editing the conf.txt file.
- **[3]-Set proxy credentials:** Allows to set username and password for proxy authentication.
- **[0]-Exit:** terminates the program.

### Scoring criteria
The overall score (between 0 and 100) is calculated referring to the compliant configuration defined on the conf.txt file.
Following security headers are taken into account:
- HTTP Strict Transport Security (HSTS)   ( +5 points if detected and +5 points for each compliant directive )
- X-Frame-Options                         ( +5 points if detected and +5 points for each compliant directive )
- X-Content-Type-Options                  ( +5 points if detected and +5 points for each compliant directive )
- Content-Security-Policy                 ( +5 points if detected and +1 points for each compliant directive )
- X-Permitted-Cross-Domain-Policies       ( +5 points if detected and +5 points for each compliant directive )
- Referrer-Policy                         ( +5 points if detected and +5 points for each compliant directive )
- Clear-Site-Data                         ( +5 points if detected and +1 points for each compliant directive )
- Cross-Origin-Embedder-Policy (COEP)     ( +1 points if detected and +1 points for each compliant directive )
- Cross-Origin-Opener-Policy (COOP)       ( +1 points if detected and +1 points for each compliant directive )
- Cross-Origin-Resource-Policy (CORP)     ( +1 points if detected and +1 points for each compliant directive )
- Permissions-Policy                      ( +5 points if detected and +0.1 points for each compliant directive )
- Cache-Control                           ( +5 points if detected and +2.5 points for each compliant directive )
- Pragma                                  ( +1 points if detected and +1 points for each compliant directive )

In order to obtain the overall score in hundredths, the sum of the points assigned in this way, is normalized with respect to the maximum value of 100.

### License
GPL-3.0

### References
[OWASP Secure Headers Project](https://owasp.org/www-project-secure-headers/)
