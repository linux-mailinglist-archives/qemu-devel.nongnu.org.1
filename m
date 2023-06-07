Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D307261BB
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 15:55:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6tdD-0002su-SL; Wed, 07 Jun 2023 09:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1q6td6-0002sd-Tj
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 09:55:17 -0400
Received: from mail-ej1-x64a.google.com ([2a00:1450:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1q6td3-0007bH-Pe
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 09:55:16 -0400
Received: by mail-ej1-x64a.google.com with SMTP id
 a640c23a62f3a-970e0152da7so662733066b.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1686146112; x=1688738112;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cTaACRcPi8VnBYCnCv7xOGmLlBuiaHGF+87/3wr38+M=;
 b=hQFRFe+Jl/mAN52yzR7mbiM1Q49RLn7YszNZa5lrzhl4u6AzMGtZGjpqNEEAx2KUAR
 x+wbqDhx/YJENlvYxvByPD7eNkwVlqq3VggG4fwQjKGWAqcsewf87FfI0AcNcKEa2991
 T6oTwU89dn5nLjDjsfq8ER2PW+BU0gkDZV+i45Vo9vqJ+md+4XSEIPcf0ijpr8fR0B4r
 OSWF/IXl8kP2ymaNEEL6CKrJbNbUTHUfCkBsfm86dtpslDZTCX6YE9mUaq5eLasuvj6o
 fNlTms1ke8sJxPTCdechdeAPWMsMLcUWU4fNDaNV4OoMcAsmzC2hBwUKQxhA+N6ErJIg
 3yiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686146112; x=1688738112;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cTaACRcPi8VnBYCnCv7xOGmLlBuiaHGF+87/3wr38+M=;
 b=JuoG5gs1jHfXArZvMVVJ5Rhjg/CSwAmC3nlBKPNXXOVX2jhyEanh6QidWteho4fA1z
 cGkrVRfdA5ubYjSE4Gedjy6tKwK3trvx5qwm5VC5iBpydzE8o6Q35L0LPBOyc2o5TCNd
 cJe36KVdbcCdYZLxzXj6ieoGn8po6RjIQNdCRu4Pc+vaC8iLV8oglE7ID7HkFhL2z2Eo
 rMQ4LZCMW8+11Bt/qXX+yKt8fH/OcRhw/v6QP6pDyiQa92PhJbNe/g6oBv1G//fDHTvl
 LkAmvWPJi32uMio8vq3e3GgxwUB3rbXw5VhG+tcIRuyQBrSGYj5DS2jZesw2QIUdQ3yA
 FUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686146112; x=1688738112;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cTaACRcPi8VnBYCnCv7xOGmLlBuiaHGF+87/3wr38+M=;
 b=P/qp+L7T231UgM32746OhOAk4kLSw/rv7toQ3meiwy3Xd/0AiippA03lDcIxoaJ8vX
 9mhynkaMuOxGOl3vEF1cURwVgez8QUQnsUeqYP6VFp7RioAu79sVuKUYCWysBvkjCPJd
 ktnxBWgikVomB0tjIQ0+hDY/QVXmqgxLCkF40vEuKDt2psyya6FbE6cgyeb61j9MtGOO
 7m0r6X3Ee9yHBeKychy75MWuNDjX5SqMI7gtb+YL20Z1RuszbI0ypSw27wXQRcuoJxCU
 10LmoJONXo+/xuidjaDvCU0NJSJTR3MHs9xz8CMcAhbzDOHKHbIw5kwpOqD2Tba8aaKh
 wofA==
X-Gm-Message-State: AC+VfDyvipS8REanlUZNdcyOhCL5p5wAugoJMVCi0r24fwi6/KkLVHo+
 tlnZYClWhcl/ESqcv/EcmSfzQUiPmtx639K4qq2E
X-Google-Smtp-Source: ACHHUZ764hRgYZet1Ef6OLkTaH7Npp1MJnls5jYAfeoyVpHAyvLhHltaaWUQmifDgqJoneoURR6dMPZdkuM5RFUCg5A/
MIME-Version: 1.0
X-Received: by 2002:a17:906:8a5c:b0:978:8e00:9dc with SMTP id
 gx28-20020a1709068a5c00b009788e0009dcmr113497ejc.8.1686146111986; Wed, 07 Jun
 2023 06:55:11 -0700 (PDT)
Message-ID: <calendar-123b3e98-a357-4d85-ac0b-ecce92087a35@google.com>
Date: Wed, 07 Jun 2023 13:55:11 +0000
Subject: QEMU developers fortnightly conference call for 2023-06-13
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
Content-Type: multipart/alternative; boundary="0000000000000b63dd05fd8a7ce1"
Received-SPF: pass client-ip=2a00:1450:4864:20::64a;
 envelope-from=juan.quintela@gmail.com; helo=mail-ej1-x64a.google.com
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

--0000000000000b63dd05fd8a7ce1
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

SGkgSGVyZSBpcyB0aGUgd2lraSBmb3Igd2hvdmVyIHRoYXQgd2FudHMgdG8gYWRkIHRvcGljcyB0
byB0aGUgYWdlbmRhLiAgDQpodHRwczovL3dpa2kucWVtdS5vcmcvUUVNVUNhbGwjQ2FsbF9mb3Jf
YWdlbmRhX2Zvcl8yMDIzLTA2LTEzIFdlIGFscmVhZHkgIA0KaGF2ZSBhIHRvcGljIHRoYXQgaXMg
IkxpdmUgVXBkYXRlIiwgc28gcGxlYXNlIGpvaW4uIExhdGVyLCBKdWFuLg0KDQpRRU1VIGRldmVs
b3BlcnMgZm9ydG5pZ2h0bHkgY29uZmVyZW5jZSBjYWxsDQpUdWVzZGF5IDIwMjMtMDYtMTMg4ouF
IDE1OjAwIOKAkyAxNjowMA0KQ2VudHJhbCBFdXJvcGVhbiBUaW1lIC0gTWFkcmlkDQoNCkxvY2F0
aW9uDQpodHRwczovL21lZXQuaml0LnNpL2t2bWNhbGxtZWV0aW5nCQ0KaHR0cHM6Ly93d3cuZ29v
Z2xlLmNvbS91cmw/cT1odHRwcyUzQSUyRiUyRm1lZXQuaml0LnNpJTJGa3ZtY2FsbG1lZXRpbmcm
c2E9RCZ1c3Q9MTY4NjU3ODEwMDAwMDAwMCZ1c2c9QU92VmF3MlhjX2g5MlE5dDdZeHdiVHQ2Wlpp
eQ0KDQoNCg0KSWYgeW91IG5lZWQgY2FsbCBkZXRhaWxzLCBwbGVhc2UgY29udGFjdCBtZTogcXVp
bnRlbGFAcmVkaGF0LmNvbQ0KDQpHdWVzdHMNCnF1aW50ZWxhQHJlZGhhdC5jb20NCk1laXJhdiBE
ZWFuDQpGZWxpcGUgRnJhbmNpb3NpDQpjd0BmMDBmLm9yZw0KZWJsYWtlQHJlZGhhdC5jb20NCmVk
Z2FyLmlnbGVzaWFzQGdtYWlsLmNvbQ0KaWdneUB0aGVpZ2d5LmNvbQ0Kamlkb25nLnhpYW9AZ21h
aWwuY29tDQpQZXRlciBNYXlkZWxsDQpyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnDQpzdGVm
YW5oYUBnbWFpbC5jb20NCldhcm5lciBMb3NoDQp6d3Uua2VybmVsQGdtYWlsLmNvbQ0KSmFzb24g
R3VudGhvcnBlDQpOZW8gSmlhDQpLb25yYWQgV2lsaw0KYWxlQHJldi5uZw0KV2FuZywgV2VpIFcN
Cmt2bS1kZXZlbA0KbWJ1cnRvbkBxdGkucXVhbGNvbW0uY29tDQpQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqQ0KSm9hbyBNYXJ0aW5zDQphZmFlcmJlckBzdXNlLmRlDQpiYXp1bGF5QHJlZGhhdC5jb20N
CmJiYXVtYW5AcmVkaGF0LmNvbQ0KZHVzdGluLmtpcmtsYW5kQGNhbm9uaWNhbC5jb20NCmVyaWMu
YXVnZXJAcmVkaGF0LmNvbQ0KamFuLmtpc3prYUB3ZWIuZGUNCmpqaGVybmVAbGludXgudm5ldC5p
Ym0uY29tDQptaW11QGxpbnV4LnZuZXQuaWJtLmNvbQ0Kei5odW9AMTM5LmNvbQ0KRGF2aWQgRWRt
b25kc29uDQpFbGVuYSBVZmltdHNldmENCmFuam9AcmV2Lm5nDQpTaGFtZWVyYWxpIEtvbG90aHVt
IFRob2RpDQpDaGFvIFBlbmcNCnFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KDQoNCg==
--0000000000000b63dd05fd8a7ce1
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
ntent=3D"juan.quintela@gmail.com: Hi Here is the wiki for whover that wants=
 to add topics to the agenda. https://wiki.qemu.org/QEMUCall#Call_for_agend=
a_for_2023-06-13 We already have a topic that is &quot;Live Update&quot;, s=
o please join. Later, Juan."/></span><span itemprop=3D"object" itemscope it=
emtype=3D"http://schema.org/Event"><meta itemprop=3D"eventStatus" content=
=3D"http://schema.org/EventScheduled"/><span itemprop=3D"publisher" itemsco=
pe itemtype=3D"http://schema.org/Organization"><meta itemprop=3D"name" cont=
ent=3D"Google Calendar"/></span><meta itemprop=3D"eventId/googleCalendar" c=
ontent=3D"5dt5ji87j5qrc00o63ktq7ghou_20230613T130000Z"/><span style=3D"disp=
lay: none; font-size: 1px; color: #fff; line-height: 1px; height: 0; max-he=
ight: 0; width: 0; max-width: 0; opacity: 0; overflow: hidden;" itemprop=3D=
"name">QEMU developers fortnightly conference call</span><span aria-hidden=
=3D"true"><time itemprop=3D"startDate" datetime=3D"20230613T130000Z"></time=
><time itemprop=3D"endDate" datetime=3D"20230613T140000Z"></time></span><ta=
ble border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" =
align=3D"center" style=3D"width:100%;" class=3D"body-container"><tbody><tr>=
<td style=3D"" class=3D"" align=3D"left"><!--[if mso | IE]><table border=3D=
"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><td heigh=
t=3D"16" style=3D"height:16px;"><![endif]--><div style=3D"height:16px;" ari=
a-hidden=3D"true"> &nbsp; </div><!--[if mso | IE]></td></tr></table><![endi=
f]--><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presen=
tation" align=3D"center" style=3D"width:100%;" class=3D""><tbody><tr><td st=
yle=3D"" class=3D"" align=3D"left"><span itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><p itemprop=3D"description">Hi<br>Here is the wiki for =
whover that wants to add topics to the agenda.<br><a href=3D"https://wiki.q=
emu.org/QEMUCall#Call_for_agenda_for_2023-06-13">https://wiki.qemu.org/QEMU=
Call#Call_for_agenda_for_2023-06-13</a><p>We already have a topic that is &=
quot;Live Update&quot;, so please join.<p>Later, Juan.</p></span></td></tr>=
</tbody></table><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" rol=
e=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D""><tbody=
><tr><td style=3D"border: solid 1px #dadce0; border-radius: 8px; direction:=
 rtl; font-size: 0; padding: 24px 32px; text-align: left; vertical-align: t=
op;" class=3D"main-container-inner"><!--[if mso | IE]><table border=3D"0" c=
ellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><![endif]--><d=
iv class=3D"" style=3D"font-size: 13px; text-align: left; direction: ltr; d=
isplay: inline-block; vertical-align: top; width: 100%;overflow: hidden; wo=
rd-wrap: break-word;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"=
0" role=3D"presentation" width=3D"100%" class=3D"main-column-table-ltr" sty=
le=3D"padding-right: 32px; padding-left: 0;;table-layout: fixed;"><tbody><t=
r><td class=3D"main-column-td" style=3D"padding:0; vertical-align:top;"><ta=
ble border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" =
width=3D"100%" style=3D"table-layout: fixed;"><tr><td style=3D"font-size: 0=
; padding: 0; text-align: left; word-break: break-word;;padding-bottom:2px;=
"><div style=3D"font-family: &#39;Google Sans&#39;, Roboto, sans-serif;font=
-weight: 400; font-size: 22px; line-height: 28px;color: #3c4043; text-decor=
ation: none;" class=3D"primary-text" role=3D"presentation"><span itemprop=
=3D"name">QEMU developers fortnightly conference call</span></div></td></tr=
><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-break: b=
reak-word;;padding-bottom:24px;"><div style=3D"font-family: Roboto, sans-se=
rif;font-style: normal; font-weight: 400; font-size: 14px; line-height: 20p=
x; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" class=3D"p=
rimary-text" role=3D"presentation"><span aria-hidden=3D"true"><time itempro=
p=3D"startDate" datetime=3D"20230613T130000Z"></time><time itemprop=3D"endD=
ate" datetime=3D"20230613T140000Z"></time></span><span>Tuesday 2023-06-13 =
=E2=8B=85 15:00 =E2=80=93 16:00 (Central European Time - Madrid)</span></di=
v></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; wo=
rd-break: break-word;;padding-bottom:24px;"><div style=3D"font-family: Robo=
to, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-=
height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;"=
 class=3D"primary-text" role=3D"presentation"><span>If you need call detail=
s, please contact me: <a href=3D"mailto:quintela@redhat.com" target=3D"_bla=
nk">quintela@redhat.com</a></span><meta itemprop=3D"description" content=3D=
"If you need call details, please contact me: quintela@redhat.com"/></div><=
/td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-=
break: break-word;;padding-bottom:24px;"><div style=3D"font-family: Roboto,=
 sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-hei=
ght: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" cl=
ass=3D"primary-text" role=3D"presentation"><table border=3D"0" cellpadding=
=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-bottom: 4px=
;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;color: #3c40=
43; text-decoration: none;font-weight: 700;-webkit-font-smoothing: antialia=
sed;margin: 0; padding: 0;">Location</h2></td></tr></table><span itemprop=
=3D"location" itemscope itemtype=3D"http://schema.org/Place"><span itemprop=
=3D"name" class=3D"primary-text notranslate" style=3D"font-family: Roboto, =
sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-heig=
ht: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;">htt=
ps://meet.jit.si/kvmcallmeeting</span><br/><a href=3D"https://www.google.co=
m/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=3DD&amp;ust=3D1=
686578100000000&amp;usg=3DAOvVaw2Xc_h92Q9t7YxwbTt6ZZiy" class=3D"accent-tex=
t underline-on-hover" style=3D"display: inline-block;;color: #1a73e8; text-=
decoration: none;font-weight: 700;" target=3D"_blank" itemprop=3D"map">View=
 map</a></span></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; t=
ext-align: left; word-break: break-word;;padding-bottom:24px;"><div style=
=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight: 400; f=
ont-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; te=
xt-decoration: none;" class=3D"primary-text" role=3D"presentation"><table b=
order=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=
=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-=
size: 14px;color: #3c4043; text-decoration: none;font-weight: 700;-webkit-f=
ont-smoothing: antialiased;margin: 0; padding: 0;">Guests</h2></td></tr></t=
able><div style=3D"padding-bottom: 4px; text-align: left;;color: #3c4042;">=
<div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pe=
rson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-tex=
t underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-=
decoration: none;" href=3D"mailto:quintela@redhat.com">quintela@redhat.com<=
/a></span><meta itemprop=3D"email" content=3D"quintela@redhat.com"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:mdean@redhat.com">Meira=
v Dean</a></span><meta itemprop=3D"email" content=3D"mdean@redhat.com"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:felipe@nutanix.co=
m">Felipe Franciosi</a></span><meta itemprop=3D"email" content=3D"felipe@nu=
tanix.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:cw@f=
00f.org">cw@f00f.org</a></span><meta itemprop=3D"email" content=3D"cw@f00f.=
org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:eblake@red=
hat.com">eblake@redhat.com</a></span><meta itemprop=3D"email" content=3D"eb=
lake@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:edgar.iglesias@gmail.com">edgar.iglesias@gmail.com</a></span><meta itempr=
op=3D"email" content=3D"edgar.iglesias@gmail.com"/></span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"></span></div=
><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/P=
erson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-te=
xt underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text=
-decoration: none;" href=3D"mailto:iggy@theiggy.com">iggy@theiggy.com</a></=
span><meta itemprop=3D"email" content=3D"iggy@theiggy.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:jidong.xiao@gmail.com">jidong.x=
iao@gmail.com</a></span><meta itemprop=3D"email" content=3D"jidong.xiao@gma=
il.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; tex=
t-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscop=
e itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"no=
translate"><a class=3D"primary-text underline-on-hover" style=3D"display: i=
nline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:peter.m=
aydell@linaro.org">Peter Maydell</a></span><meta itemprop=3D"email" content=
=3D"peter.maydell@linaro.org"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org<=
/a></span><meta itemprop=3D"email" content=3D"richard.henderson@linaro.org"=
/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decor=
ation: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemt=
ype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransla=
te"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-b=
lock;;color: #3c4043; text-decoration: none;" href=3D"mailto:stefanha@gmail=
.com">stefanha@gmail.com</a></span><meta itemprop=3D"email" content=3D"stef=
anha@gmail.com"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" =
itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cla=
ss=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"di=
splay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto=
:imp@bsdimp.com">Warner Losh</a></span><meta itemprop=3D"email" content=3D"=
imp@bsdimp.com"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" =
itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cla=
ss=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"di=
splay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto=
:zwu.kernel@gmail.com">zwu.kernel@gmail.com</a></span><meta itemprop=3D"ema=
il" content=3D"zwu.kernel@gmail.com"/></span><span class=3D"secondary-text"=
 style=3D"color: #70757a; text-decoration: none;"></span></div><div><span i=
temprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-=
on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: =
none;" href=3D"mailto:jgg@nvidia.com">Jason Gunthorpe</a></span><meta itemp=
rop=3D"email" content=3D"jgg@nvidia.com"/></span><span class=3D"secondary-t=
ext" style=3D"color: #70757a; text-decoration: none;"></span></div><div><sp=
an itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><s=
pan itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underl=
ine-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorati=
on: none;" href=3D"mailto:cjia@nvidia.com">Neo Jia</a></span><meta itemprop=
=3D"email" content=3D"cjia@nvidia.com"/></span><span class=3D"secondary-tex=
t" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span=
 itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><spa=
n itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underlin=
e-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration=
: none;" href=3D"mailto:konrad.wilk@oracle.com">Konrad Wilk</a></span><meta=
 itemprop=3D"email" content=3D"konrad.wilk@oracle.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:ale@rev.ng">ale@rev.ng</a></span><=
meta itemprop=3D"email" content=3D"ale@rev.ng"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:wei.w.wang@intel.com">Wang, Wei W</a></span=
><meta itemprop=3D"email" content=3D"wei.w.wang@intel.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:kvm@vger.kernel.org">kvm-devel<=
/a></span><meta itemprop=3D"email" content=3D"kvm@vger.kernel.org"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:mburton@qti.qualcomm.co=
m">mburton@qti.qualcomm.com</a></span><meta itemprop=3D"email" content=3D"m=
burton@qti.qualcomm.com"/></span><span class=3D"secondary-text" style=3D"co=
lor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"a=
ttendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"=
name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" st=
yle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:f4bug@amsat.org">Philippe Mathieu-Daud=C3=A9</a></span><meta ite=
mprop=3D"email" content=3D"f4bug@amsat.org"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:joao.m.martins@oracle.com">Joao Martins</a></s=
pan><meta itemprop=3D"email" content=3D"joao.m.martins@oracle.com"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:afaerber@suse.de">afaer=
ber@suse.de</a></span><meta itemprop=3D"email" content=3D"afaerber@suse.de"=
/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decor=
ation: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemt=
ype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransla=
te"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-b=
lock;;color: #3c4043; text-decoration: none;" href=3D"mailto:bazulay@redhat=
.com">bazulay@redhat.com</a></span><meta itemprop=3D"email" content=3D"bazu=
lay@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" =
itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cla=
ss=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"di=
splay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto=
:bbauman@redhat.com">bbauman@redhat.com</a></span><meta itemprop=3D"email" =
content=3D"bbauman@redhat.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:dustin.kirkland@canonical.com">dustin.kirkland@canonical.co=
m</a></span><meta itemprop=3D"email" content=3D"dustin.kirkland@canonical.c=
om"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-de=
coration: none;"></span></div><div><span itemprop=3D"attendee" itemscope it=
emtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notran=
slate"><a class=3D"primary-text underline-on-hover" style=3D"display: inlin=
e-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:eric.auger@=
redhat.com">eric.auger@redhat.com</a></span><meta itemprop=3D"email" conten=
t=3D"eric.auger@redhat.com"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:jan.kiszka@web.de">jan.kiszka@web.de</a></span><meta itempro=
p=3D"email" content=3D"jan.kiszka@web.de"/></span><span class=3D"secondary-=
text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><s=
pan itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><=
span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text under=
line-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorat=
ion: none;" href=3D"mailto:jjherne@linux.vnet.ibm.com">jjherne@linux.vnet.i=
bm.com</a></span><meta itemprop=3D"email" content=3D"jjherne@linux.vnet.ibm=
.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-=
decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope =
itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notr=
anslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inl=
ine-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:mimu@linu=
x.vnet.ibm.com">mimu@linux.vnet.ibm.com</a></span><meta itemprop=3D"email" =
content=3D"mimu@linux.vnet.ibm.com"/></span><span class=3D"secondary-text" =
style=3D"color: #70757a; text-decoration: none;"></span></div><div><span it=
emprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span i=
temprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-o=
n-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: n=
one;" href=3D"mailto:z.huo@139.com">z.huo@139.com</a></span><meta itemprop=
=3D"email" content=3D"z.huo@139.com"/></span><span class=3D"secondary-text"=
 style=3D"color: #70757a; text-decoration: none;"></span></div><div><span i=
temprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-=
on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: =
none;" href=3D"mailto:david.edmondson@oracle.com">David Edmondson</a></span=
><meta itemprop=3D"email" content=3D"david.edmondson@oracle.com"/></span><s=
pan class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none=
;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http=
://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a clas=
s=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color=
: #3c4043; text-decoration: none;" href=3D"mailto:elena.ufimtseva@oracle.co=
m">Elena Ufimtseva</a></span><meta itemprop=3D"email" content=3D"elena.ufim=
tseva@oracle.com"/></span><span class=3D"secondary-text" style=3D"color: #7=
0757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee=
" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" c=
lass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"=
display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mail=
to:anjo@rev.ng">anjo@rev.ng</a></span><meta itemprop=3D"email" content=3D"a=
njo@rev.ng"/></span><span class=3D"secondary-text" style=3D"color: #70757a;=
 text-decoration: none;"></span></div><div><span itemprop=3D"attendee" item=
scope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:s=
hameerali.kolothum.thodi@huawei.com">Shameerali Kolothum Thodi</a></span><m=
eta itemprop=3D"email" content=3D"shameerali.kolothum.thodi@huawei.com"/></=
span><span class=3D"secondary-text" style=3D"color: #70757a; text-decoratio=
n: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:chao.p.peng@linux=
.intel.com">Chao Peng</a></span><meta itemprop=3D"email" content=3D"chao.p.=
peng@linux.intel.com"/></span><span class=3D"secondary-text" style=3D"color=
: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"atte=
ndee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"nam=
e" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a></span><meta itempro=
p=3D"email" content=3D"qemu-devel@nongnu.org"/></span><span class=3D"second=
ary-text" style=3D"color: #70757a; text-decoration: none;"></span></div></d=
iv></div></td></tr></table></td></tr></tbody></table></div><!--[if mso | IE=
]></tr></table><![endif]--></td></tr></tbody></table></td></tr></tbody></ta=
ble></span></span></body></html>
--0000000000000b63dd05fd8a7ce1--

