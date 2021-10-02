#!/bin/bash
# PoC Email Account Checker - Checks for emails that don't exist so they can be (re)created
# Use Chrome's Network tab to view the URL that makes these type of requests.
# This is just a PoC, you can add in other email services along with other domains the current ones provide.
# URLs have been working all night, but might need to be updated in the future.
# 
# Usage: ./account_checker.sh <email_list>

function google() {
  # Post data
  data=$(echo "continue=https%3A%2F%2Fmail.google.com%2Fmail%2F&service=mail&rip=1&flowName=GlifWebSignIn&flowEntry=ServiceLogin&f.req=%5B%22$1%22%2C%22AEThLlyIe_NE6hsc-RZLM1yf4i3sxNVIWMfKJh1ZBTaWVmedPJH9g2PevUirRqkUkUBW8SY8BOgrU_bj9eWNcyQh1Lx67IIni7xWWPaay3eUqV7bEdKzeCM68RiSgf6hoCHRpk0ft0Y5jXmPQn7k38QWllMEydDt9g%22%2C%5B%5D%2Cnull%2C%22US%22%2Cnull%2Cnull%2C2%2Cfalse%2Ctrue%2C%5Bnull%2Cnull%2C%5B2%2C1%2Cnull%2C1%2C%22https%3A%2F%2Faccounts.google.com%2FServiceLogin%3Fcontinue%3Dhttps%253A%252F%252Fmail.google.com%252Fmail%252F%26service%3Dmail%26sacu%3D1%26rip%3D1%26flowName%3DGlifWebSignIn%26flowEntry%3DServiceLogin%22%2Cnull%2C%5B%5D%2C4%5D%2C1%2C%5Bnull%2Cnull%2C%5B%5D%5D%2Cnull%2Cnull%2Cnull%2Ctrue%5D%2C%22$1%22%5D&bgRequest=%5B%22identifier%22%2C%22!3t2l3fxCrGbeAIqulZBESKxL7Ag_7B0CAAAAMFIAAAAamQFyvifcswrWstdeU9DuOGG4Tr2ZuaTQFR3XZGTcGX6v0wlNNJ8j71rRzE7yIfXx4lNYWEzB6N-VBH1OUT1rAisjaHNH2XjXonrnkpOib-xdKANaty3bckSYeJ88p9Z_J0_KwtCj6nQKV3CVZRNUjZa48H4rwyAD1752H0jty5unB6YepbcdGveaSGgFfSTN0ASEg2JEmdbL0CbjFXI_ZArf75ypKA6olDPeKk_MKCNHfWXn3F0dVjHBdLFSSfeif9F8eIFA-whgprLZ6SqzX8W7P2Dya-1r8nW7gxzo3UOPQ6xOoPBnmF1cJkKLdU7GSssduI04GyiNWBWdL5NiGqSeA_IcVUEry10I1H94rN9cqzEP7B_SCkBdnbx7Zz3msrZNBl0ZTqgkGVEPx_9lcOHkOn4ivJ3fFA_CcjpwFALTXlKQDBoMqpTqLvGCbH1cUTErbKvjkQar4QTnXcLYDPPIkG_-mQLT0UWNf31FSoS7--mX_g%22%5D&azt=AFoagUXY1TjmBb8ilL3USd72opbUFeW_wQ%3A1517376320095&cookiesDisabled=false&deviceinfo=%5Bnull%2Cnull%2Cnull%2C%5B%5D%2Cnull%2C%22US%22%2Cnull%2Cnull%2C%5B%5D%2C%22GlifWebSignIn%22%2Cnull%2C%5Bnull%2Cnull%2C%5B%5D%5D%5D&gmscoreversion=undefined&checkConnection=youtube%3A601%3A1&checkedDomains=youtube&pstMsg=1")
  
  # Request to accounts.google.com
  lines=$(curl -s 'https://accounts.google.com/_/signin/sl/lookup?hl=en&_reqid=1524&rt=j' -H 'cookie: __utmx=173272373.NsRgTn8iQf-MYLOX8BH_qA$0:1; __utmxx=173272373.NsRgTn8iQf-MYLOX8BH_qA$0:1517368307:8035200; NID=122=BFvhCUC91Ouv2JSon7hCthjSLIFcMVr4xC_rFlQVdfBM2tX2Qk2DxpLo4mJjpiq9KnBeFk3UBBJiBK8cMhhC6hj-yPTtO5qVAbPFYJlmYg3Legyizsc0oFjHRi3wb1ce; 1P_JAR=2018-1-31-4; GAPS=1:aphXL8Pq78iDUwyvos0EnnsDaCax_A:7fOKSRgItT3vXT7t' -H 'x-same-domain: 1' -H 'origin: https://accounts.google.com' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/63.0.3239.84 Chrome/63.0.3239.84 Safari/537.36' -H 'content-type: application/x-www-form-urlencoded;charset=UTF-8' -H 'accept: */*' -H 'referer: https://accounts.google.com/signin/v2/identifier?continue=https%3A%2F%2Fmail.google.com%2Fmail%2F&service=mail&sacu=1&rip=1&flowName=GlifWebSignIn&flowEntry=ServiceLogin' -H 'authority: accounts.google.com' -H 'google-accounts-xsrf: 1' --data $data --compressed | wc -l)
  
  # Accounts that exist will return 16
  if [ $lines -eq 6 ]; then
    echo "$1@gmail.com"
  fi
}

function yahoo() {
  # This might work with other Yahoo domain extensions; however, you can only create yahoo.com emails for now...
  data=$(echo "crumb=hlQdMQOI43i&acrumb=60xFzK2A&sessionIndex=QQ--&username=$1&passwd=&signin=Next&persistent=y")

  lines=$(curl -s 'https://login.yahoo.com/?.src=ym&.intl=us&.done=https%3A%2F%2Fmail.yahoo.com%2F' -H 'cookie: B=bk9gv59d7284k&b=3&s=a6; ucs=lnct=1517363352; AS=v=1&s=60xFzK2A&d=A5a72abfe|Ij3l0bj.2cLKr0kdqztbdYI7XtjD.2mjDsCx3EZPm9kdkHg2iUFyzSMXr8A65Z2NRSuvzDy2HOlVWoUilC7R0.TTyX6nOTx_npmNsQLVxhKoLLen58dql5wbDZrM79owMbIoj6kBCixyqzaEr0bmtI_7gdZu6rvrNvVLCA.TNJJbsVyD5ZrDTOSgEuhydWo3zTBXOQ9yejGfDU7.rpdH6Kdu355EK7k2XRVju31OwZWL7wz0akW.j1lXOydmVONtiWdGImjDrRBDB4hYi5op.OJVLGCC1ocLmItKugCblJB6rZ7jrzJ7NQ7vaEL5yERS8qmBFeiB0fq0fyYycz7eJjzzcC3IkPjA2rhf3xkYnaFe9OUMxzCR0mWekJKAS3v6S0evNH_hdYtJSHgsTJ.KGG.xfeHt2C20z.fJBpe8Br.7OcfPhPrjnFMcQZgn4yvxgnwHxFhMOtc9QlWCFb5OWoJ5LItNoUWSA50xSQ109ubIQ7rK1S8OC0aG4QNc1mRf_wUDhe.QJVzp2Z3feWJcw64H6ljG7JZBhm9XhKgre15OL_3vrgMhNP.jADpuAA8cpJaDrKNdvLdSBeewD5uM15JMih3RzXKPxgvbSp2o3Poec89opDj.JwRoczsptMqOK0grgjxhrBKcAsQmVZYkQVx3SaZymGDDiAjzcXsT6gMcOEbV4BPUk3jRV7vRB1zMQ3TE1zGw1DWBXSBJoL.7SPV.5oCod7eN6KoFCKRDNotiU4QVL2B0yk1.5YhUYSTDONgY1ZTNvm5Z2o_bVVBkI4qos5suPZ9YufF1WyPu3wI0Iz.QQacN8N8Rcie8gDrwhyMiDpwcjqFvKo4fWKFhqMAYO_mqMg_GmKhHF6CMVofMVO_xp_RIkCenTE9FhLuKZtm6KfiFxoGN_WNxxwEso6TV~A|D5a715dcd|0rdrFf3.2QLRzmekNZO2e4FjR.IfJtnhihUefcJ8AMNz5rYMtuzv7mwI4v8h0m.jsPOeO53ZkRkk8c6hXMwZssXy3c5V5CjsHf_G0NK2VUmOivaucuJXgWfFu7Qr0pn2SB2S51YpfoCZbhGg30B3qL69owbOSxZ1Y9POd1PekBVP8mHt4FpmUpAVXymMm.UMmWy3gBNYxcwrTut6jJFLrYufNaPAtlZD_sdqqSuxe_xl5e.4cC6ZcEYXxPx96DCgOKbZoP.4I.vK365emfOZwVk4phTlgzzfJBPXMHW6sLKwliI5c8aSp_2B3TZhLfBoLb2QKmFZCb.10McsnHz6d.egeFYTjSG8Aa6VNCXxLhtK6KxKu9Elo6wKCUDGVcO20kzf6xHrpMbnFASP9kE2qfw.SfWwqmfdUxXKu4rdoy3c91R4c4vrJi6oVlRLEJvr7bm5lTGqX3LtBkFcCEtm294KkZtONWBmh6iQFgSu7_l_VBdzgge0gir3o1vli9kp5MdqBQNI67RMOqbkXNYmSWfA0h6M7evLVfz6Ha7PQCAPzL2iPR2s5ZGFj_K0QJ6HTPtOWEwshgcTBxgSS4N8gDanyHbyZWdMOp3UltHdiyAMLvGi6LLX5nJW49zEu9v9wbtakr5YvR1a_aQ83ZV_e1EdPzJM9PFhVbeX3jiKKRMBJ53Y5WGkSMsljCoJCikhTLTkQI7wdu6Wu5JWb2WZMh0OqAm7D7DcdvdU05QtU8W_URO0NHpdiRdYO9N4DwXwoLURFu1OpqdFysldOtLwke4E8Hrrn7.Uaz1wTlzf135ePs_EFncYoW6ZuqRkFPQwKu4gH4Z8Z3fZfA2MNan4QDAaiJw9SXrboa5IpyaGE4xd3nz0yQ0aK4w0k_LeAtzEoOeZaHFO7KI8Mtmkrgq2JOWNG858A9PmkjkPV0wnRARZxpO1h6bPcss4m._X2OptVlqVobN285otyBD0T9SRad8IDb6bKBUwjwpjALCWUGlF5eVudndFRVTT_CY2FZxJ0cgEvIaZevVRjCeN5t5ZbN0joJwiUTgHSxPTFC0O8fCW8agqcwgQGJ0dP5at8m8tAPJBI8ucXXTmoSAI.096_xiQJixApmZXriml0CKRSUfA_1ejlnShJSCcqRKSVVS6itcWzr5KtwVvcsEDLHCAKVtO91._Q6VgGouLVOPF0zIDsmJHVrwceHDh1BZQ--~A' -H 'origin: https://login.yahoo.com' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/63.0.3239.84 Chrome/63.0.3239.84 Safari/537.36' -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' -H 'accept: */*' -H 'referer: https://login.yahoo.com/?.src=ym&.intl=us&.done=https%3A%2F%2Fmail.yahoo.com%2F' -H 'authority: login.yahoo.com' -H 'x-requested-with: XMLHttpRequest' --data $data --compressed)

  if echo $lines | grep -q "recognize this account"; then
    echo "$1@yahoo.com"
  fi
}

function mail() {
  data=$(echo "z1662687459=$1&")

  lines=$(curl -s 'https://service.mail.com/registration.html?wicket:interface=:0:FormRegistration:ListRegistrationData:1:ItemRegistrationData:BorderBoxRegistrationData:PanelRegistrationData:Row101:Field:LinkCheckAvailability::IBehaviorListener:0:-1&random=0.9112488590924492&time=1517391320407' -H 'Origin: https://service.mail.com' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9' -H 'Wicket-FocusedElementId: id20' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/63.0.3239.84 Chrome/63.0.3239.84 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/xml' -H 'Referer: https://service.mail.com/registration.html?edition=us&lang=en&' -H 'Cookie: cookieKID=kid%40autoref%40mail.com; cookiePartner=kid%40autoref%40mail.com; JSESSIONID=F9E573C37CBFA32FE3607221535E8B3F.jport-lx05; cookieUUID=d74b1de4-a21a-4cda-90d5-fa126f4863fd' -H 'Connection: keep-alive' -H 'Wicket-Ajax: true' --data $data --compressed)

  if echo $lines | grep -q "is available"; then
    echo "$1@mail.com"
  fi
}

function outlook() {
  # With Outlook the entire domain needed to be added in the post data, for the other services it was just the username.
  data=$(echo "{"username":"$1","uaid":"8ff625b9dce84b9d972f2359ff6bee7c","isOtherIdpSupported":false,"checkPhones":false,"isRemoteNGCSupported":true,"isCookieBannerShown":false,"isFidoSupported":false,"flowToken":"DYhvtaK2lZyeO!Kc3ttc636RI8axORgXGvo"}")

  lines=$(curl -s 'https://login.live.com/GetCredentialType.srf?wa=wsignin1.0&rpsnv=13&ct=1517379761&rver=6.7.6640.0&wp=MBI_SSL&wreply=https%3a%2f%2foutlook.live.com%2fowa%2f%3fnlp%3d1%26RpsCsrfState%3d822c9e18-d3b1-fed5-d007-8d8d0f95dbdb&id=292841&CBCXT=out&lw=1&fl=dob%2cflname%2cwld&cobrandid=90015&vv=1600&mkt=EN-US&lc=1033' -H 'Origin: https://login.live.com' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/63.0.3239.84 Chrome/63.0.3239.84 Safari/537.36' -H 'client-request-id: 8ff625b9dce84b9d972f2359ff6bee7c' -H 'Content-type: application/json; charset=UTF-8' -H 'hpgid: 33' -H 'Accept: application/json' -H 'Referer: https://login.live.com/login.srf?wa=wsignin1.0&rpsnv=13&ct=1517379761&rver=6.7.6640.0&wp=MBI_SSL&wreply=https%3a%2f%2foutlook.live.com%2fowa%2f%3fnlp%3d1%26RpsCsrfState%3d822c9e18-d3b1-fed5-d007-8d8d0f95dbdb&id=292841&CBCXT=out&lw=1&fl=dob%2cflname%2cwld&cobrandid=90015' -H 'Cookie: uaid=8ff625b9dce84b9d972f2359ff6bee7c; logonLatency=LGN01=636529765618374065; MSPRequ=lt=1517379762&co=1&id=292841; MSPOK=$uuid-a54693ba-3880-486b-803b-f445709ca39f; CkTst=G1517379764371' -H 'Connection: keep-alive' -H 'hpgact: 0' --data-binary $data --compressed)

  if echo $lines | grep -q '"IfExistsResult":1'; then
    echo $1
  fi
}

function mailru() {
  data=$(echo "RegistrationDomain=mail.ru&Signup_utf8=1&LANG=en_US&x_1b05097e082eb4f7=$1&x_reg_id=pq0ET2xGhGqDtuxL&x_c0f00db9620ad058=&BirthMonth=&x_f31cc6d7e4345b65=&x_99812016be9887a5=&x_c922543d1bd93be5=")

  lines=$(curl -s 'https://e.mail.ru/cgi-bin/checklogin' -H 'Cookie: mrcu=199D59FA9C311684C47CA730F4AD; act=902bf43644e046dc95e0fbff9a92f4e1; s=ww=1600|wh=787; gmt=-5' -H 'Origin: https://e.mail.ru' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/63.0.3239.84 Chrome/63.0.3239.84 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' -H 'Accept: */*' -H 'Referer: https://e.mail.ru/signup?from=main&rf=auth.mail.ru' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' --data $data --compressed)

  # The returned data also shows what emails are available for the other domains they offer.
  if echo $lines | grep -q "0$"; then 
    echo "$1@mail.ru"
  fi
}

# Read email list
for i in `cat $1`; do
  # This section checks for the email domain.
  # As of January 2018, you can still add @live.* email as aliases, so we're going to look for those too.
  if echo $i | grep -qi "@gmail.com$"; then
    # Strip the "+inbox" specification and the domain
    username=$(echo $i | awk -F'@gmail.com' '{print $1}' | awk -F'+' '{print $1}')
    google $username
  elif echo $i | grep -qi "@yahoo.com"; then
    username=$(echo $i | awk -F'@yahoo.com' '{print $1}' | awk -F'+' '{print $1}')
    yahoo $username
  elif echo $i | grep -qi "@mail.com"; then
    username=$(echo $i | awk -F'mail.com' '{print $1}' | awk -F'+' '{print $1}')
    mail $username
  elif echo $i | grep -qiE "@outlook\.|@live\.|@windowslive\.|@msn\.|@hotmail\."; then
    outlook $i
  elif echo $i | grep -qi "mail.ru"; then
    username=$(echo $i | awk -F'mail.ru' '{print $1}' | awk -F'+' '{print $1}')
    mailru $i
  fi
done