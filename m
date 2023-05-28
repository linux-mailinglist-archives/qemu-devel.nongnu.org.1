Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CD0713B66
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 19:52:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3KXW-0001NH-S4; Sun, 28 May 2023 13:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1q3KXU-0001J8-7I
 for qemu-devel@nongnu.org; Sun, 28 May 2023 13:50:44 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1q3KXS-0006YK-2g
 for qemu-devel@nongnu.org; Sun, 28 May 2023 13:50:43 -0400
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-3f5fb41bc42so10531905e9.1
 for <qemu-devel@nongnu.org>; Sun, 28 May 2023 10:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1685296240; x=1687888240;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BYIEid6oiWHifUZsDkagThFS/Jo6r5QVDJuOBobxWWo=;
 b=ntCM6eIU6/bdNyT+1MSBMIL4N5j1cSimbS8clxBaH7WaarUV5BGWDFkSk3aUqCZNwb
 Hc51zftceXG+/DRjvL631Ktkf6rGiNr0YDz/VmaT9l9ZHmjXpWEaEl3QZI7aXO6rqEx5
 RVfUanJ9hjriAhbV8n7j9NxmOWr074i62l/RTAc9WqhZ3zaVkVpTZ7sPPKcXTQxAXLi6
 rABW2QDTF3GEhEPFLZr+hPxIBAGtzLzkoKscsxpueecA0YBz4vnDpnyvOl6YXK1Jb2/Q
 wtpSDxNJRJs3CHJr/WaVj2hVh6SGZdqsLCP3FtZ1HRSnpWwlIrZlKMS32ns7g2WdB7lK
 tGSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685296240; x=1687888240;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BYIEid6oiWHifUZsDkagThFS/Jo6r5QVDJuOBobxWWo=;
 b=ZhJ5dwdcWydRhVbLmyR3O+jdWiHv5IegA+j7TEVobwUOIhqcseCHWZXYDIJtU2UoqP
 zXCz/ISJkWlpqqsU2XOZQ+iQmDdAXZFnNPeZzhDhoZ/zidQdwBo8YA27++zZpjrYteaF
 GPEsVvqQOKIURiuea7I60XQbrI/4G0VQc+7cAaJ5Q06UG3Ke+VC1xNEXsKMfyXoFRvza
 4BPEIRcKd7tosmBjOfdJ8akG5aNwIxz1wG2KO0TsKDbd6UPS2CETIA+u+GvRhv8MN0dK
 ZEox5Hx6xpPUIgJgFNaM+l4QBREjh3zpLxp1OZhc80mrWlYE0nmHudDSEdJYM0EutIq/
 gBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685296240; x=1687888240;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BYIEid6oiWHifUZsDkagThFS/Jo6r5QVDJuOBobxWWo=;
 b=bugUTRvLLEZRxj4Jyg3UtoVPiJxMf4Iz2Ach8/1Ewa8CJEUNDzYmW6jDMEviYr/DY8
 6rL7BUtOJEK/xgdOsaqZ0Gxalo6TKfP71hc1hFd8PadKzuBBu8N9MQxJzanZOyvWqDdJ
 O+J54hqsI1gyGAvCP2iWggfeEue+QXZqNCn2UESl5ZWeYXRi+aA2+dMoN7iSX5tfdUpe
 6EPCZfPmf8P7f57FyfNRD5SQUxnsiRQKiTk8Oh9RzuFt1AXz0fVIDfBRauj/1Iqfcjch
 7tgLTruaTsqc2y7MJT1PCETk/pdr3xpxQHcvajFYbQpeaP3IbYU/StdjPPa3hsiwNZcn
 ekbA==
X-Gm-Message-State: AC+VfDykLU/ZQzCm21VVVa/2BujfUnsUyBunCWKBoU7A9qY3gtdF1Ao5
 CoAODBfvfpjslV3tS33ZcgH6to/VoNMyPPQcqDJc
X-Google-Smtp-Source: ACHHUZ75GtvaMUhVE317LXddbCeHa3BHA4Ke/tfxfmpcqmfY8+wfWxHpQUZM6yhpqUGh5YkmXzqhdVjsB2WSM4oPEOJ7
MIME-Version: 1.0
X-Received: by 2002:a05:600c:3648:b0:3f6:3bc:8567 with SMTP id
 y8-20020a05600c364800b003f603bc8567mr1462394wmq.2.1685296239705; Sun, 28 May
 2023 10:50:39 -0700 (PDT)
Message-ID: <calendar-ce7061a5-eb12-4714-b952-732b206d497a@google.com>
Date: Sun, 28 May 2023 17:50:39 +0000
Subject: QEMU developers fortnightly call for agenda - 2023-05-29
From: juan.quintela@gmail.com
To: afaerber@suse.de, ale@rev.ng, anjo@rev.ng, bazulay@redhat.com, 
 bbauman@redhat.com, chao.p.peng@linux.intel.com, cjia@nvidia.com, cw@f00f.org, 
 david.edmondson@oracle.com, dustin.kirkland@canonical.com, eblake@redhat.com, 
 edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com, eric.auger@redhat.com, 
 f4bug@amsat.org, Felipe Franciosi <felipe.franciosi@nutanix.com>, 
 "iggy@theiggy.com" <iggy@kws1.com>, Warner Losh <wlosh@bsdimp.com>,
 jan.kiszka@web.de, jgg@nvidia.com, 
 jidong.xiao@gmail.com, jjherne@linux.vnet.ibm.com, joao.m.martins@oracle.com, 
 konrad.wilk@oracle.com, kvm@vger.kernel.org, mburton@qti.qualcomm.com, 
 mdean@redhat.com, mimu@linux.vnet.ibm.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org, quintela@redhat.com, richard.henderson@linaro.org, 
 shameerali.kolothum.thodi@huawei.com, stefanha@gmail.com, 
 wei.w.wang@intel.com, z.huo@139.com, zwu.kernel@gmail.com, 
 juan.quintela@gmail.com
Content-Type: multipart/alternative; boundary="000000000000b5864c05fcc49b25"
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=juan.quintela@gmail.com; helo=mail-wm1-x34a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: juan.quintela@gmail.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--000000000000b5864c05fcc49b25
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

SGkgSWYgeW91IGhhZCBhbnkgdG9waWNzIGZvciBUdWVzZGF5IGNhbGwsIHBsZWFzZSBsZXQncyB1
cyBrbm93LiBUaGFua3MsICANCkp1YW4uDQoNClFFTVUgZGV2ZWxvcGVycyBmb3J0bmlnaHRseSBj
b25mZXJlbmNlIGNhbGwNClR1ZXNkYXkgMjAyMy0wNS0zMCDii4UgMTU6MDAg4oCTIDE2OjAwDQpD
ZW50cmFsIEV1cm9wZWFuIFRpbWUgLSBNYWRyaWQNCg0KTG9jYXRpb24NCmh0dHBzOi8vbWVldC5q
aXQuc2kva3ZtY2FsbG1lZXRpbmcJDQpodHRwczovL3d3dy5nb29nbGUuY29tL3VybD9xPWh0dHBz
JTNBJTJGJTJGbWVldC5qaXQuc2klMkZrdm1jYWxsbWVldGluZyZzYT1EJnVzdD0xNjg1NzI4MjAw
MDAwMDAwJnVzZz1BT3ZWYXcyemdveGxONGgyd0JaVlNiTGRRNnVSDQoNCg0KDQpJZiB5b3UgbmVl
ZCBjYWxsIGRldGFpbHMsIHBsZWFzZSBjb250YWN0IG1lOiBxdWludGVsYUByZWRoYXQuY29tDQoN
Ckd1ZXN0cw0KUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kNCkpvYW8gTWFydGlucw0KcXVpbnRlbGFA
cmVkaGF0LmNvbQ0KTWVpcmF2IERlYW4NCkZlbGlwZSBGcmFuY2lvc2kNCmFmYWVyYmVyQHN1c2Uu
ZGUNCmJhenVsYXlAcmVkaGF0LmNvbQ0KYmJhdW1hbkByZWRoYXQuY29tDQpjd0BmMDBmLm9yZw0K
ZHVzdGluLmtpcmtsYW5kQGNhbm9uaWNhbC5jb20NCmVibGFrZUByZWRoYXQuY29tDQplZGdhci5p
Z2xlc2lhc0BnbWFpbC5jb20NCmVyaWMuYXVnZXJAcmVkaGF0LmNvbQ0KaWdneUB0aGVpZ2d5LmNv
bQ0KamFuLmtpc3prYUB3ZWIuZGUNCmppZG9uZy54aWFvQGdtYWlsLmNvbQ0KampoZXJuZUBsaW51
eC52bmV0LmlibS5jb20NCm1pbXVAbGludXgudm5ldC5pYm0uY29tDQpQZXRlciBNYXlkZWxsDQpy
aWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnDQpzdGVmYW5oYUBnbWFpbC5jb20NCldhcm5lciBM
b3NoDQp6Lmh1b0AxMzkuY29tDQp6d3Uua2VybmVsQGdtYWlsLmNvbQ0KSmFzb24gR3VudGhvcnBl
DQpOZW8gSmlhDQpEYXZpZCBFZG1vbmRzb24NCkVsZW5hIFVmaW10c2V2YQ0KS29ucmFkIFdpbGsN
CmFsZUByZXYubmcNCmFuam9AcmV2Lm5nDQpTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQpXYW5n
LCBXZWkgVw0KQ2hhbyBQZW5nDQprdm0tZGV2ZWwNCnFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KbWJ1
cnRvbkBxdGkucXVhbGNvbW0uY29tDQoNCg0K
--000000000000b5864c05fcc49b25
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!doctype html><html xmlns=3D"http://www.w3.org/1999/xhtml" xmlns:v=3D"urn:=
schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-microsoft-com:office:offi=
ce"><head><title></title><!--[if !mso]><meta http-equiv=3D"X-UA-Compatible"=
 content=3D"IE=3Dedge"><![endif]--><meta http-equiv=3D"Content-Type" conten=
t=3D"text/html; charset=3DUTF-8"><meta name=3D"viewport" content=3D"width=
=3Ddevice-width,initial-scale=3D1"><meta name=3D"color-scheme" content=3D"l=
ight dark"><meta name=3D"supported-color-schemes" content=3D"light dark">
    <style>
      body, html {
        font-family: Roboto, Helvetica, Arial, sans-serif;
      }

      body {
        margin: 0;
        padding: 0;
        -webkit-font-smoothing: antialiased;
        -webkit-text-size-adjust: 100%;
        -ms-text-size-adjust: 100%;
      }

      #outlook a {
        padding: 0;
      }

      .ReadMsgBody {
        width: 100%;
      }

      .ExternalClass {
        width: 100%;
      }

      .ExternalClass * {
        line-height: 100%;
      }

      table,
      td {
        mso-table-lspace: 0pt;
        mso-table-rspace: 0pt;
      }

      img {
        border: 0;
        height: auto;
        line-height: 100%;
        outline: none;
        text-decoration: none;
        -ms-interpolation-mode: bicubic;
      }

      p {
        display: block;
        margin: 13px 0;
      }
    </style>
    <!--[if !mso]><!-->
    <style>
      @media only screen and (max-width:580px) {
        @-ms-viewport {
          width: 320px;
        }

        @viewport {
          width: 320px;
        }
      }
    </style>
    <!--<![endif]-->
    <!--[if mso]>
          <xml>
          <o:OfficeDocumentSettings>
            <o:AllowPNG/>
            <o:PixelsPerInch>96</o:PixelsPerInch>
          </o:OfficeDocumentSettings>
          </xml>
          <![endif]-->
    <!--[if lte mso 11]>
          <style>
            .outlook-group-fix { width:100% !important; }
          </style>
    <![endif]-->

    <!--[if !mso]><!-- -->
  <style>body, html {font-family:Roboto,Helvetica,Arial,sans-serif;}@font-f=
ace {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/roboto/v18/KFOmCnqEu92Fr1Mu4mxP.ttf) forma=
t('truetype');
}
@font-face {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 500;
  src: url(//fonts.gstatic.com/s/roboto/v18/KFOlCnqEu92Fr1MmEU9fBBc9.ttf) f=
ormat('truetype');
}
@font-face {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  src: url(//fonts.gstatic.com/s/roboto/v18/KFOlCnqEu92Fr1MmWUlfBBc9.ttf) f=
ormat('truetype');
}
@font-face {
  font-family: 'Material Icons Extended';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/materialiconsextended/v149/kJEjBvgX7BgnkSr=
UwT8UnLVc38YydejYY-oE_LvM.ttf) format('truetype');
}
@font-face {
  font-family: 'Google Material Icons';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/googlematerialicons/v137/Gw6kwdfw6UnXLJCcm=
afZyFRXb3BL9rvi0QZG3g.otf) format('opentype');
}

.google-material-icons {
  font-family: 'Google Material Icons';
  font-weight: normal;
  font-style: normal;
  font-size: 24px;
  line-height: 1;
  letter-spacing: normal;
  text-transform: none;
  display: inline-block;
  white-space: nowrap;
  word-wrap: normal;
  direction: ltr;
}
@font-face {
  font-family: 'Google Material Icons Filled';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/googlematerialiconsfilled/v113/WWXFlimHYg6=
HKI3TavMkbKdhBmDvgach8TVpeGsuueSZJH4.otf) format('opentype');
}

.google-material-icons-filled {
  font-family: 'Google Material Icons Filled';
  font-weight: normal;
  font-style: normal;
  font-size: 24px;
  line-height: 1;
  letter-spacing: normal;
  text-transform: none;
  display: inline-block;
  white-space: nowrap;
  word-wrap: normal;
  direction: ltr;
}
@font-face {
  font-family: 'Google Sans';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/googlesans/v14/4UaGrENHsxJlGDuGo1OIlL3Owps=
.ttf) format('truetype');
}
@font-face {
  font-family: 'Google Sans';
  font-style: normal;
  font-weight: 500;
  src: url(//fonts.gstatic.com/s/googlesans/v14/4UabrENHsxJlGDuGo1OIlLU94Yt=
zCwM.ttf) format('truetype');
}
@font-face {
  font-family: 'Google Sans';
  font-style: normal;
  font-weight: 700;
  src: url(//fonts.gstatic.com/s/googlesans/v14/4UabrENHsxJlGDuGo1OIlLV154t=
zCwM.ttf) format('truetype');
}
</style><!--<![endif]-->
      <style>
        .body-container {
          padding-left: 16px;
          padding-right: 16px;
        }
      </style>
 =20
      <style>
        u+.body .body-container,
        body[data-outlook-cycle] .body-container,
        #MessageViewBody .body-container {
          padding-left: 0;
          padding-right: 0;
        }
      </style>
 =20
    <style>
      @media only screen and (min-width:580px) {
        .column-per-37 {
          width: 37% !important;
          max-width: 37%;
        }

        .column-per-63 {
          width: 63% !important;
          max-width: 63%;
        }
      }
    </style>
 =20
    <style>
      .appointment-buttons th {
        display: block;
        clear: both;
        float: left;
        margin-top: 12px;
      }

      .appointment-buttons th a {
        float: left;
      }

      #MessageViewBody .appointment-buttons th {
       margin-top: 24px;
      }
    </style>
 =20
    <style>
      @media only screen and (max-width:580px) {
        table.full-width-mobile {
          width: 100% !important;
        }

        td.full-width-mobile {
          width: auto !important;
        }
      }
    </style>
    <style>
      .main-container-inner,
      .info-bar-inner {
        padding: 12px 16px !important;
      }

      .main-column-table-ltr {
        padding-right: 0 !important;
      }

      .main-column-table-rtl {
        padding-left: 0 !important;
      }

      @media only screen and (min-width:580px) {
        .main-container-inner {
          padding: 24px 32px !important;
        }

        .info-bar-inner {
          padding: 12px 32px !important;
        }

        .main-column-table-ltr {
          padding-right: 32px !important;
        }

        .main-column-table-rtl {
          padding-left: 32px !important;
        }

        .appointment-buttons th {
          display: table-cell;
          clear: none;
        }
      }

      .primary-text {
        color: #3c4043 !important;
      }

      .secondary-text,
      .phone-number a {
        color: #70757a !important;
      }

      .accent-text {
        color: #1a73e8 !important;
      }

      .accent-text-dark {
        color: #185abc !important;
      }

      .grey-button-text,
      .attachment-chip a {
        color: #5f6368 !important;
      }

      .primary-button {
        background-color: #1a73e8 !important;
      }

      .primary-button-text {
        color: #fff !important;
      }

      .underline-on-hover:hover {
        text-decoration: underline !important;
      }

      .grey-infobar-text {
        color: #202124 !important;
      }

      @media (prefers-color-scheme: dark) {
        .primary-text:not([class^=3D"x_"]) {
          color: #e8eaed !important;
        }

        .secondary-text:not([class^=3D"x_"]),
        .phone-number:not([class^=3D"x_"]) a {
          color: #9aa0a6 !important;
        }

        .grey-button-text:not([class^=3D"x_"]),
        .attachment-chip:not([class^=3D"x_"]) a {
          color: #bdc1c6 !important;
        }

        .accent-text:not([class^=3D"x_"]),
        .hairline-button-text:not([class^=3D"x_"]) {
          color: #8ab4f8 !important;
        }

        .primary-button:not([class^=3D"x_"]) {
          background-color: #8ab4f8 !important;
        }

        .primary-button-text:not([class^=3D"x_"]) {
          color: #202124 !important;
        }
      }
    </style>
    <style>
      @media (prefers-color-scheme: dark) {
        .cse-banner:not([class^=3D"x_"]) {
          background-color: #3c4043 !important; /* Google Grey 800 */
        }

        .encryption-icon:not([class^=3D"x_"]) {
          /* WARNING: This causes the whole style tag to get stripped in Gm=
ail. */
          background-image: url('https://fonts.gstatic.com/s/i/googlemateri=
aliconsfilled/encrypted/v3/gm_grey200-24dp/2x/gm_filled_encrypted_gm_grey20=
0_24dp.png') !important;
        }
      }
    </style>
    <!--[if !mso]><!-->
    <style>
      .prevent-link a {
        color: inherit !important;
        text-decoration: none !important;
        font-size: inherit !important;
        font-family: inherit !important;
        font-weight: inherit !important;
        line-height: inherit !important;
      }
    </style>
    <!--<![endif]-->

    <!--[if mso | IE]>
      <style>
        .main-container-inner {
          padding: 24px 32px !important;
        }

        .info-bar-inner {
          padding: 12px 32px !important;
        }

        .cse-banner .encryption-icon {
          /* We use the IE workaround instead. */
          background-image: none !important;
        }

        .cse-banner .encryption-icon .ms-fallback {
          display: block !important;
        }

        /* NB: Some MS clients ignore dark-scheme styling and apply their o=
wn, so there's nothing we can do to help there. */
        @media (prefers-color-scheme: dark) {
          .cse-banner:not([class^=3D"x_"]) .encryption-icon .ms-fallback {
            display: none !important;
          }

          .cse-banner:not([class^=3D"x_"]) .encryption-icon .ms-fallback-da=
rk {
            display: block !important;
          }
        }
      </style>
    <![endif]-->
  </head><body class=3D"body"><span itemscope itemtype=3D"http://schema.org=
/InformAction"><span style=3D"display:none" itemprop=3D"about" itemscope it=
emtype=3D"http://schema.org/EmailMessage"><meta itemprop=3D"description" co=
ntent=3D"juan.quintela@gmail.com: Hi If you had any topics for Tuesday call=
, please let&#39;s us know. Thanks, Juan."/></span><span itemprop=3D"object=
" itemscope itemtype=3D"http://schema.org/Event"><meta itemprop=3D"eventSta=
tus" content=3D"http://schema.org/EventScheduled"/><span itemprop=3D"publis=
her" itemscope itemtype=3D"http://schema.org/Organization"><meta itemprop=
=3D"name" content=3D"Google Calendar"/></span><meta itemprop=3D"eventId/goo=
gleCalendar" content=3D"5dt5ji87j5qrc00o63ktq7ghou_20230530T130000Z"/><span=
 style=3D"display: none; font-size: 1px; color: #fff; line-height: 1px; hei=
ght: 0; max-height: 0; width: 0; max-width: 0; opacity: 0; overflow: hidden=
;" itemprop=3D"name">QEMU developers fortnightly conference call</span><spa=
n aria-hidden=3D"true"><time itemprop=3D"startDate" datetime=3D"20230530T13=
0000Z"></time><time itemprop=3D"endDate" datetime=3D"20230530T140000Z"></ti=
me></span><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"p=
resentation" align=3D"center" style=3D"width:100%;" class=3D"body-container=
"><tbody><tr><td style=3D"" class=3D"" align=3D"left"><!--[if mso | IE]><ta=
ble border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation">=
<tr><td height=3D"16" style=3D"height:16px;"><![endif]--><div style=3D"heig=
ht:16px;" aria-hidden=3D"true"> &nbsp; </div><!--[if mso | IE]></td></tr></=
table><![endif]--><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" r=
ole=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D""><tbo=
dy><tr><td style=3D"" class=3D"" align=3D"left"><span itemscope itemtype=3D=
"http://schema.org/EmailMessage"><p itemprop=3D"description">Hi<br>If you h=
ad any topics for Tuesday call, please let&#39;s us know.<p>Thanks, Juan.</=
p></span></td></tr></tbody></table><table border=3D"0" cellpadding=3D"0" ce=
llspacing=3D"0" role=3D"presentation" align=3D"center" style=3D"width:100%;=
" class=3D""><tbody><tr><td style=3D"border: solid 1px #dadce0; border-radi=
us: 8px; direction: rtl; font-size: 0; padding: 24px 32px; text-align: left=
; vertical-align: top;" class=3D"main-container-inner"><!--[if mso | IE]><t=
able border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"=
><tr><![endif]--><div class=3D"" style=3D"font-size: 13px; text-align: left=
; direction: ltr; display: inline-block; vertical-align: top; width: 100%;o=
verflow: hidden; word-wrap: break-word;"><table border=3D"0" cellpadding=3D=
"0" cellspacing=3D"0" role=3D"presentation" width=3D"100%" class=3D"main-co=
lumn-table-ltr" style=3D"padding-right: 32px; padding-left: 0;;table-layout=
: fixed;"><tbody><tr><td class=3D"main-column-td" style=3D"padding:0; verti=
cal-align:top;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" rol=
e=3D"presentation" width=3D"100%" style=3D"table-layout: fixed;"><tr><td st=
yle=3D"font-size: 0; padding: 0; text-align: left; word-break: break-word;;=
padding-bottom:2px;"><div style=3D"font-family: &#39;Google Sans&#39;, Robo=
to, sans-serif;font-weight: 400; font-size: 22px; line-height: 28px;color: =
#3c4043; text-decoration: none;" class=3D"primary-text" role=3D"presentatio=
n"><span itemprop=3D"name">QEMU developers fortnightly conference call</spa=
n></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: le=
ft; word-break: break-word;;padding-bottom:24px;"><div style=3D"font-family=
: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14px;=
 line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: =
none;" class=3D"primary-text" role=3D"presentation"><span aria-hidden=3D"tr=
ue"><time itemprop=3D"startDate" datetime=3D"20230530T130000Z"></time><time=
 itemprop=3D"endDate" datetime=3D"20230530T140000Z"></time></span><span>Tue=
sday 2023-05-30 =E2=8B=85 15:00 =E2=80=93 16:00 (Central European Time - Ma=
drid)</span></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text=
-align: left; word-break: break-word;;padding-bottom:24px;"><div style=3D"f=
ont-family: Roboto, sans-serif;font-style: normal; font-weight: 400; font-s=
ize: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-de=
coration: none;" class=3D"primary-text" role=3D"presentation"><span>If you =
need call details, please contact me: <a href=3D"mailto:quintela@redhat.com=
" target=3D"_blank">quintela@redhat.com</a></span><meta itemprop=3D"descrip=
tion" content=3D"If you need call details, please contact me: quintela@redh=
at.com"/></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-al=
ign: left; word-break: break-word;;padding-bottom:24px;"><div style=3D"font=
-family: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size=
: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decor=
ation: none;" class=3D"primary-text" role=3D"presentation"><table border=3D=
"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padd=
ing-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14=
px;color: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoo=
thing: antialiased;margin: 0; padding: 0;">Location</h2></td></tr></table><=
span itemprop=3D"location" itemscope itemtype=3D"http://schema.org/Place"><=
span itemprop=3D"name" class=3D"primary-text notranslate" style=3D"font-fam=
ily: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14=
px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoratio=
n: none;">https://meet.jit.si/kvmcallmeeting</span><br/><a href=3D"https://=
www.google.com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=3D=
D&amp;ust=3D1685728200000000&amp;usg=3DAOvVaw2zgoxlN4h2wBZVSbLdQ6uR" class=
=3D"accent-text underline-on-hover" style=3D"display: inline-block;;color: =
#1a73e8; text-decoration: none;font-weight: 700;" target=3D"_blank" itempro=
p=3D"map">View map</a></span></div></td></tr><tr><td style=3D"font-size: 0;=
 padding: 0; text-align: left; word-break: break-word;;padding-bottom:24px;=
"><div style=3D"font-family: Roboto, sans-serif;font-style: normal; font-we=
ight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color:=
 #3c4043; text-decoration: none;" class=3D"primary-text" role=3D"presentati=
on"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"present=
ation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" st=
yle=3D"font-size: 14px;color: #3c4043; text-decoration: none;font-weight: 7=
00;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">Guests</h2><=
/td></tr></table><div style=3D"padding-bottom: 4px; text-align: left;;color=
: #3c4042;"><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://s=
chema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D=
"primary-text underline-on-hover" style=3D"display: inline-block;;color: #3=
c4043; text-decoration: none;" href=3D"mailto:f4bug@amsat.org">Philippe Mat=
hieu-Daud=C3=A9</a></span><meta itemprop=3D"email" content=3D"f4bug@amsat.o=
rg"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-de=
coration: none;"></span></div><div><span itemprop=3D"attendee" itemscope it=
emtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notran=
slate"><a class=3D"primary-text underline-on-hover" style=3D"display: inlin=
e-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:joao.m.mart=
ins@oracle.com">Joao Martins</a></span><meta itemprop=3D"email" content=3D"=
joao.m.martins@oracle.com"/></span><span class=3D"secondary-text" style=3D"=
color: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D=
"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=
=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover=
" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" h=
ref=3D"mailto:quintela@redhat.com">quintela@redhat.com</a></span><meta item=
prop=3D"email" content=3D"quintela@redhat.com"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:mdean@redhat.com">Meirav Dean</a></span><me=
ta itemprop=3D"email" content=3D"mdean@redhat.com"/></span><span class=3D"s=
econdary-text" style=3D"color: #70757a; text-decoration: none;"></span></di=
v><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/=
Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-t=
ext underline-on-hover" style=3D"display: inline-block;;color: #3c4043; tex=
t-decoration: none;" href=3D"mailto:felipe@nutanix.com">Felipe Franciosi</a=
></span><meta itemprop=3D"email" content=3D"felipe@nutanix.com"/></span><sp=
an class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;=
"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:=
//schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:afaerber@suse.de">afaerber=
@suse.de</a></span><meta itemprop=3D"email" content=3D"afaerber@suse.de"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:bazulay@redhat.co=
m">bazulay@redhat.com</a></span><meta itemprop=3D"email" content=3D"bazulay=
@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a=
; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" ite=
mscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:b=
bauman@redhat.com">bbauman@redhat.com</a></span><meta itemprop=3D"email" co=
ntent=3D"bbauman@redhat.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:cw@f00f.org">cw@f00f.org</a></span><meta itemprop=3D"email"=
 content=3D"cw@f00f.org"/></span><span class=3D"secondary-text" style=3D"co=
lor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"a=
ttendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"=
name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" st=
yle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:dustin.kirkland@canonical.com">dustin.kirkland@canonical.com</a>=
</span><meta itemprop=3D"email" content=3D"dustin.kirkland@canonical.com"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:eblake@redhat.co=
m">eblake@redhat.com</a></span><meta itemprop=3D"email" content=3D"eblake@r=
edhat.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:edga=
r.iglesias@gmail.com">edgar.iglesias@gmail.com</a></span><meta itemprop=3D"=
email" content=3D"edgar.iglesias@gmail.com"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:eric.auger@redhat.com">eric.auger@redhat.com</=
a></span><meta itemprop=3D"email" content=3D"eric.auger@redhat.com"/></span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:iggy@theiggy.com">iggy=
@theiggy.com</a></span><meta itemprop=3D"email" content=3D"iggy@theiggy.com=
"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-deco=
ration: none;"></span></div><div><span itemprop=3D"attendee" itemscope item=
type=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransl=
ate"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-=
block;;color: #3c4043; text-decoration: none;" href=3D"mailto:jan.kiszka@we=
b.de">jan.kiszka@web.de</a></span><meta itemprop=3D"email" content=3D"jan.k=
iszka@web.de"/></span><span class=3D"secondary-text" style=3D"color: #70757=
a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" it=
emscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:j=
idong.xiao@gmail.com">jidong.xiao@gmail.com</a></span><meta itemprop=3D"ema=
il" content=3D"jidong.xiao@gmail.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:jjherne@linux.vnet.ibm.com">jjherne@linux.vnet.ibm.c=
om</a></span><meta itemprop=3D"email" content=3D"jjherne@linux.vnet.ibm.com=
"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-deco=
ration: none;"></span></div><div><span itemprop=3D"attendee" itemscope item=
type=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransl=
ate"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-=
block;;color: #3c4043; text-decoration: none;" href=3D"mailto:mimu@linux.vn=
et.ibm.com">mimu@linux.vnet.ibm.com</a></span><meta itemprop=3D"email" cont=
ent=3D"mimu@linux.vnet.ibm.com"/></span><span class=3D"secondary-text" styl=
e=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempr=
op=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemp=
rop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-ho=
ver" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;=
" href=3D"mailto:peter.maydell@linaro.org">Peter Maydell</a></span><meta it=
emprop=3D"email" content=3D"peter.maydell@linaro.org"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:richard.henderson@linaro.org">rich=
ard.henderson@linaro.org</a></span><meta itemprop=3D"email" content=3D"rich=
ard.henderson@linaro.org"/></span><span class=3D"secondary-text" style=3D"c=
olor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:stefanha@gmail.com">stefanha@gmail.com</a></span><meta itemprop=
=3D"email" content=3D"stefanha@gmail.com"/></span><span class=3D"secondary-=
text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><s=
pan itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><=
span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text under=
line-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorat=
ion: none;" href=3D"mailto:imp@bsdimp.com">Warner Losh</a></span><meta item=
prop=3D"email" content=3D"imp@bsdimp.com"/></span><span class=3D"secondary-=
text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><s=
pan itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><=
span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text under=
line-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorat=
ion: none;" href=3D"mailto:z.huo@139.com">z.huo@139.com</a></span><meta ite=
mprop=3D"email" content=3D"z.huo@139.com"/></span><span class=3D"secondary-=
text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><s=
pan itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><=
span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text under=
line-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorat=
ion: none;" href=3D"mailto:zwu.kernel@gmail.com">zwu.kernel@gmail.com</a></=
span><meta itemprop=3D"email" content=3D"zwu.kernel@gmail.com"/></span><spa=
n class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"=
></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:/=
/schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:jgg@nvidia.com">Jason Gunt=
horpe</a></span><meta itemprop=3D"email" content=3D"jgg@nvidia.com"/></span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:cjia@nvidia.com">Neo J=
ia</a></span><meta itemprop=3D"email" content=3D"cjia@nvidia.com"/></span><=
span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: non=
e;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"htt=
p://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cla=
ss=3D"primary-text underline-on-hover" style=3D"display: inline-block;;colo=
r: #3c4043; text-decoration: none;" href=3D"mailto:david.edmondson@oracle.c=
om">David Edmondson</a></span><meta itemprop=3D"email" content=3D"david.edm=
ondson@oracle.com"/></span><span class=3D"secondary-text" style=3D"color: #=
70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attende=
e" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D=
"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mai=
lto:elena.ufimtseva@oracle.com">Elena Ufimtseva</a></span><meta itemprop=3D=
"email" content=3D"elena.ufimtseva@oracle.com"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:konrad.wilk@oracle.com">Konrad Wilk</a></sp=
an><meta itemprop=3D"email" content=3D"konrad.wilk@oracle.com"/></span><spa=
n class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"=
></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:/=
/schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:ale@rev.ng">ale@rev.ng</a>=
</span><meta itemprop=3D"email" content=3D"ale@rev.ng"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:anjo@rev.ng">anjo@rev.ng</a></span=
><meta itemprop=3D"email" content=3D"anjo@rev.ng"/></span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"></span></div=
><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/P=
erson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-te=
xt underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text=
-decoration: none;" href=3D"mailto:shameerali.kolothum.thodi@huawei.com">Sh=
ameerali Kolothum Thodi</a></span><meta itemprop=3D"email" content=3D"shame=
erali.kolothum.thodi@huawei.com"/></span><span class=3D"secondary-text" sty=
le=3D"color: #70757a; text-decoration: none;"></span></div><div><span itemp=
rop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span item=
prop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-h=
over" style=3D"display: inline-block;;color: #3c4043; text-decoration: none=
;" href=3D"mailto:wei.w.wang@intel.com">Wang, Wei W</a></span><meta itempro=
p=3D"email" content=3D"wei.w.wang@intel.com"/></span><span class=3D"seconda=
ry-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div=
><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person=
"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text un=
derline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-deco=
ration: none;" href=3D"mailto:chao.p.peng@linux.intel.com">Chao Peng</a></s=
pan><meta itemprop=3D"email" content=3D"chao.p.peng@linux.intel.com"/></spa=
n><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: =
none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"=
http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a =
class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;c=
olor: #3c4043; text-decoration: none;" href=3D"mailto:kvm@vger.kernel.org">=
kvm-devel</a></span><meta itemprop=3D"email" content=3D"kvm@vger.kernel.org=
"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-deco=
ration: none;"></span></div><div><span itemprop=3D"attendee" itemscope item=
type=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransl=
ate"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-=
block;;color: #3c4043; text-decoration: none;" href=3D"mailto:qemu-devel@no=
ngnu.org">qemu-devel@nongnu.org</a></span><meta itemprop=3D"email" content=
=3D"qemu-devel@nongnu.org"/></span><span class=3D"secondary-text" style=3D"=
color: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D=
"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=
=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover=
" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" h=
ref=3D"mailto:mburton@qti.qualcomm.com">mburton@qti.qualcomm.com</a></span>=
<meta itemprop=3D"email" content=3D"mburton@qti.qualcomm.com"/></span><span=
 class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;">=
</span></div></div></div></td></tr></table></td></tr></tbody></table></div>=
<!--[if mso | IE]></tr></table><![endif]--></td></tr></tbody></table></td><=
/tr></tbody></table></span></span></body></html>
--000000000000b5864c05fcc49b25--

