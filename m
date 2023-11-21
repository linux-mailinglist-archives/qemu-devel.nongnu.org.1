Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B387F2E21
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 14:17:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5QbF-0008Si-KG; Tue, 21 Nov 2023 08:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1r5Qb8-0008Rg-RA
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 08:15:26 -0500
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1r5Qb5-0001YY-Nb
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 08:15:26 -0500
Received: by mail-ed1-x54a.google.com with SMTP id
 4fb4d7f45d1cf-548e0501cf2so1312246a12.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 05:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1700572519; x=1701177319; darn=nongnu.org;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IztjlMD9sq0NI86ofnc8YT3YjPzaelyxvlLJDZOBqaM=;
 b=HdUbxOWOEkByuNfzX6EBl4Whl/5UI4j1M+8A3bhJ2lmek/w+hffDnDbhbpif649rpQ
 uSjMlT/MHeoeTkWrZXTCa3kPL7ijN8HGsGMTRLSEYO5bO80KviDugRO26b51fH511dOc
 dYqIL7RZeg2n/K3pjRHUBhTYTgP+Mn0sE5lwuvw5/Zgo/sujcarqoYdVkrK/NdlXQfd2
 B0W8d9eUkY/96Ks5bzoG8JUhDCDMY0iOK5stcLsJ9WvaKLfuAwfaMoPXRSFuHV4tLQD7
 dvyXzb+hMXesTTPZNWwDdWQ/+I467Qw0LXrX0MryZHRnmQLZjL2+M1R+e9l4bFMfJYsf
 bm/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700572519; x=1701177319; darn=nongnu.org;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IztjlMD9sq0NI86ofnc8YT3YjPzaelyxvlLJDZOBqaM=;
 b=WV/IQHBXjP3CSC0MtYZOT+Wg1cOTK/7GrBbdfa0bBmYpxF9mQ7IsG5K6EV1dj+/QT9
 8RdwoRfbTEFpqIoXNwNeL80EMuUby3zuv7BMYzEs/Qil3/p6EIZQo4krWnVqhxAzdD6G
 HHytK7l99JBGNOoywPsUTi7vKU/dDwGrnERS7rYTGCNxJrE1+4gP/Dt6Gi6aqqyYQl31
 cVOWf1VPZaqW8DpaXM2dnnpfH+y6uoAy568QZi6nTL5O3FF5omQsVRK6c3oij9BIab4N
 myCVQJrGnMJnYS+v2pjno257l1b2g+QWGp3JUph+bJes6h3P+wdph6XtQRIBKhrKk+If
 5aRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700572519; x=1701177319;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IztjlMD9sq0NI86ofnc8YT3YjPzaelyxvlLJDZOBqaM=;
 b=k/6wLTz0OJrwfEZU4/R5U4zLZTFqtNx/6WQK7JrT4ODUAzRosV7JcN2hEGzPXfuscG
 L39PYe334V+Oygzpc/gppO7Web73ioy6AlJmA1+GH+zxT59hNn7bAFcbXnG9EcT2lxQ8
 X435K/G6BUlc2Z4F/v+sZOAHcbir73EfRcnYkknjo4tiMISxWWwwLtUuhSWO+qRRz6GE
 bo++ndzB7XhZJ6QSWmnwIvd0RYSJa2EVJedSTp2eIE2VLzvsDW2H75AdouhvyQ23yb2S
 KRXSxsLG8egdD0FwpcwyuaXCD2KMUJD31fDajKK0lL3KyNur7UX42shHheFdMMquxZJV
 RckQ==
X-Gm-Message-State: AOJu0YwXtW6fmf279KvJ+FK1oRgo4IogYExb9U6IBsqk9jUTc3dsX8IV
 y0wqTHyPOwOZsK1xIxX/y8+5JEDJBGyWV9W+8T7I
X-Google-Smtp-Source: AGHT+IFFijHY/ofJtA+7fpLgv/2+1+uAFNwvIs1oXBu0kQNXUlx6sOSyYTdwMfyjnGK31VHsX28XxFMEaim1JqRabYaD
MIME-Version: 1.0
X-Received: by 2002:a05:6402:292:b0:548:68a3:618e with SMTP id
 l18-20020a056402029200b0054868a3618emr1700376edv.9.1700572519453; Tue, 21 Nov
 2023 05:15:19 -0800 (PST)
Message-ID: <calendar-4bd99537-7c40-41b9-bab7-79e983173a81@google.com>
Date: Tue, 21 Nov 2023 13:15:19 +0000
Subject: QEMU developers fortnightly conference call for agenda for 2023-11-28
From: Juan Quintela <juan.quintela@gmail.com>
To: afaerber@suse.de, ale@rev.ng, anjo@rev.ng, bazulay@redhat.com, 
 bbauman@redhat.com, chao.p.peng@linux.intel.com, cjia@nvidia.com, cw@f00f.org, 
 david.edmondson@oracle.com, dustin.kirkland@canonical.com, eblake@redhat.com, 
 edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com, eric.auger@redhat.com, 
 f4bug@amsat.org, "felipe@nutanix.com" <felipe.franciosi@nutanix.com>, 
 "iggy@theiggy.com" <iggy@kws1.com>, "imp@bsdimp.com" <wlosh@bsdimp.com>,
 jan.kiszka@web.de, jgg@nvidia.com, 
 jidong.xiao@gmail.com, jjherne@linux.vnet.ibm.com, joao.m.martins@oracle.com, 
 konrad.wilk@oracle.com, mburton@qti.qualcomm.com, mdean@redhat.com, 
 mimu@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, 
 quintela@redhat.com, richard.henderson@linaro.org, 
 shameerali.kolothum.thodi@huawei.com, stefanha@gmail.com, 
 wei.w.wang@intel.com, z.huo@139.com, zwu.kernel@gmail.com, 
 Juan Quintela <juan.quintela@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000efd9d8060aa96420"
Received-SPF: pass client-ip=2a00:1450:4864:20::54a;
 envelope-from=juan.quintela@gmail.com; helo=mail-ed1-x54a.google.com
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
Reply-To: Juan Quintela <juan.quintela@gmail.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--000000000000efd9d8060aa96420
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

SGkgVGhpcyBpcyBhIGNhbGwgZm9yIHRvcGljcyBmb3IgdGhlIGFnZW5kYSBmb3IgMjAyMy0xMS0y
OC4gSSBoYXZlIGFza2VkICANClN0ZXZlbiBTaXN0YXJlIHRvIGRlc2NyaWJlIGl0cyBwbGFucyBm
b3IgbWVyZ2luZyBwYXRjaGVzIGZvciBDUFIgYW5kIG90aGVyICANCnVwZGF0ZXMgaW4gcGxhY2Uu
IExhdGVyLCBKdWFuLg0KDQpRRU1VIGRldmVsb3BlcnMgZm9ydG5pZ2h0bHkgY29uZmVyZW5jZSBj
YWxsDQpUdWVzZGF5IDIwMjMtMTEtMjgg4ouFIDE1OjAwIOKAkyAxNjowMA0KQ2VudHJhbCBFdXJv
cGVhbiBUaW1lIC0gTWFkcmlkDQoNCkxvY2F0aW9uDQpodHRwczovL21lZXQuaml0LnNpL2t2bWNh
bGxtZWV0aW5nCQ0KaHR0cHM6Ly93d3cuZ29vZ2xlLmNvbS91cmw/cT1odHRwcyUzQSUyRiUyRm1l
ZXQuaml0LnNpJTJGa3ZtY2FsbG1lZXRpbmcmc2E9RCZ1c3Q9MTcwMTAwNDUwMDAwMDAwMCZ1c2c9
QU92VmF3MjhMVGJWRnR0TUdkXy1Xa05BM1Zuaw0KDQoNCg0KSWYgeW91IG5lZWQgY2FsbCBkZXRh
aWxzLCBwbGVhc2UgY29udGFjdCBtZTogcXVpbnRlbGFAcmVkaGF0LmNvbQ0KDQpHdWVzdHMNClBo
aWxpcHBlIE1hdGhpZXUtRGF1ZMOpDQpKb2FvIE1hcnRpbnMNCnF1aW50ZWxhQHJlZGhhdC5jb20N
Cm1kZWFuQHJlZGhhdC5jb20NCmZlbGlwZUBudXRhbml4LmNvbQ0KYWZhZXJiZXJAc3VzZS5kZQ0K
YmF6dWxheUByZWRoYXQuY29tDQpiYmF1bWFuQHJlZGhhdC5jb20NCmN3QGYwMGYub3JnDQpkdXN0
aW4ua2lya2xhbmRAY2Fub25pY2FsLmNvbQ0KZWJsYWtlQHJlZGhhdC5jb20NCmVkZ2FyLmlnbGVz
aWFzQGdtYWlsLmNvbQ0KZXJpYy5hdWdlckByZWRoYXQuY29tDQppZ2d5QHRoZWlnZ3kuY29tDQpq
YW4ua2lzemthQHdlYi5kZQ0Kamlkb25nLnhpYW9AZ21haWwuY29tDQpqamhlcm5lQGxpbnV4LnZu
ZXQuaWJtLmNvbQ0KbWltdUBsaW51eC52bmV0LmlibS5jb20NCnBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZw0KcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZw0Kc3RlZmFuaGFAZ21haWwuY29tDQpp
bXBAYnNkaW1wLmNvbQ0Kei5odW9AMTM5LmNvbQ0Kend1Lmtlcm5lbEBnbWFpbC5jb20NCmpnZ0Bu
dmlkaWEuY29tDQpjamlhQG52aWRpYS5jb20NCmRhdmlkLmVkbW9uZHNvbkBvcmFjbGUuY29tDQpF
bGVuYSBVZmltdHNldmENCmtvbnJhZC53aWxrQG9yYWNsZS5jb20NCmFsZUByZXYubmcNCmFuam9A
cmV2Lm5nDQpTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQp3ZWkudy53YW5nQGludGVsLmNvbQ0K
Q2hhbyBQZW5nDQpxZW11LWRldmVsQG5vbmdudS5vcmcNCm1idXJ0b25AcXRpLnF1YWxjb21tLmNv
bQ0KDQoNCg==
--000000000000efd9d8060aa96420
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
ntent=3D"Juan Quintela: Hi This is a call for topics for the agenda for 202=
3-11-28. I have asked Steven Sistare to describe its plans for merging patc=
hes for CPR and other updates in place. Later, Juan."/></span><span itempro=
p=3D"object" itemscope itemtype=3D"http://schema.org/Event"><meta itemprop=
=3D"eventStatus" content=3D"http://schema.org/EventScheduled"/><span itempr=
op=3D"publisher" itemscope itemtype=3D"http://schema.org/Organization"><met=
a itemprop=3D"name" content=3D"Google Calendar"/></span><meta itemprop=3D"e=
ventId/googleCalendar" content=3D"5dt5ji87j5qrc00o63ktq7ghou_20231128T14000=
0Z"/><span style=3D"display: none; font-size: 1px; color: #fff; line-height=
: 1px; height: 0; max-height: 0; width: 0; max-width: 0; opacity: 0; overfl=
ow: hidden;" itemprop=3D"name">QEMU developers fortnightly conference call<=
/span><span aria-hidden=3D"true"><time itemprop=3D"startDate" datetime=3D"2=
0231128T140000Z"></time><time itemprop=3D"endDate" datetime=3D"20231128T150=
000Z"></time></span><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0"=
 role=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D"body=
-container"><tbody><tr><td style=3D"" class=3D"" align=3D"left"><!--[if mso=
 | IE]><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"pres=
entation"><tr><td height=3D"16" style=3D"height:16px;"><![endif]--><div sty=
le=3D"height:16px;" aria-hidden=3D"true"> &nbsp; </div><!--[if mso | IE]></=
td></tr></table><![endif]--><table border=3D"0" cellpadding=3D"0" cellspaci=
ng=3D"0" role=3D"presentation" align=3D"center" style=3D"width:100%;" class=
=3D""><tbody><tr><td style=3D"" class=3D"" align=3D"left"><span itemscope i=
temtype=3D"http://schema.org/EmailMessage"><p itemprop=3D"description">Hi<b=
r>This is a call for topics for the agenda for 2023-11-28. <br>I have asked=
 Steven Sistare to describe its plans for merging patches for CPR and other=
 updates in place.<p>Later, Juan.</p></span></td></tr></tbody></table><tabl=
e border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" al=
ign=3D"center" style=3D"width:100%;" class=3D""><tbody><tr><td style=3D"bor=
der: solid 1px #dadce0; border-radius: 8px; direction: rtl; font-size: 0; p=
adding: 24px 32px; text-align: left; vertical-align: top;" class=3D"main-co=
ntainer-inner"><!--[if mso | IE]><table border=3D"0" cellpadding=3D"0" cell=
spacing=3D"0" role=3D"presentation"><tr><![endif]--><div class=3D"" style=
=3D"font-size: 13px; text-align: left; direction: ltr; display: inline-bloc=
k; vertical-align: top; width: 100%;overflow: hidden; word-wrap: break-word=
;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presenta=
tion" width=3D"100%" class=3D"main-column-table-ltr" style=3D"padding-right=
: 32px; padding-left: 0;;table-layout: fixed;"><tbody><tr><td class=3D"main=
-column-td" style=3D"padding:0; vertical-align:top;"><table border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"100%" styl=
e=3D"table-layout: fixed;"><tr><td style=3D"font-size: 0; padding: 0; text-=
align: left; word-break: break-word;;padding-bottom:2px;"><div style=3D"fon=
t-family: &#39;Google Sans&#39;, Roboto, sans-serif;font-weight: 400; font-=
size: 22px; line-height: 28px;color: #3c4043; text-decoration: none;" class=
=3D"primary-text" role=3D"presentation"><span itemprop=3D"name">QEMU develo=
pers fortnightly conference call</span></div></td></tr><tr><td style=3D"fon=
t-size: 0; padding: 0; text-align: left; word-break: break-word;;padding-bo=
ttom:24px;"><div style=3D"font-family: Roboto, sans-serif;font-style: norma=
l; font-weight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.=
2px;color: #3c4043; text-decoration: none;" class=3D"primary-text" role=3D"=
presentation"><span aria-hidden=3D"true"><time itemprop=3D"startDate" datet=
ime=3D"20231128T140000Z"></time><time itemprop=3D"endDate" datetime=3D"2023=
1128T150000Z"></time></span><span>Tuesday 2023-11-28 =E2=8B=85 15:00 =E2=80=
=93 16:00 (Central European Time - Madrid)</span></div></td></tr><tr><td st=
yle=3D"font-size: 0; padding: 0; text-align: left; word-break: break-word;;=
padding-bottom:24px;"><div style=3D"font-family: Roboto, sans-serif;font-st=
yle: normal; font-weight: 400; font-size: 14px; line-height: 20px; letter-s=
pacing: 0.2px;color: #3c4043; text-decoration: none;" class=3D"primary-text=
" role=3D"presentation"><span>If you need call details, please contact me: =
<a href=3D"mailto:quintela@redhat.com" target=3D"_blank">quintela@redhat.co=
m</a></span><meta itemprop=3D"description" content=3D"If you need call deta=
ils, please contact me: quintela@redhat.com"/></div></td></tr><tr><td style=
=3D"font-size: 0; padding: 0; text-align: left; word-break: break-word;;pad=
ding-bottom:24px;"><div style=3D"font-family: Roboto, sans-serif;font-style=
: normal; font-weight: 400; font-size: 14px; line-height: 20px; letter-spac=
ing: 0.2px;color: #3c4043; text-decoration: none;" class=3D"primary-text" r=
ole=3D"presentation"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0=
" role=3D"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D=
"primary-text" style=3D"font-size: 14px;color: #3c4043; text-decoration: no=
ne;font-weight: 700;-webkit-font-smoothing: antialiased;margin: 0; padding:=
 0;">Location</h2></td></tr></table><span itemprop=3D"location" itemscope i=
temtype=3D"http://schema.org/Place"><span itemprop=3D"name" class=3D"primar=
y-text notranslate" style=3D"font-family: Roboto, sans-serif;font-style: no=
rmal; font-weight: 400; font-size: 14px; line-height: 20px; letter-spacing:=
 0.2px;color: #3c4043; text-decoration: none;">https://meet.jit.si/kvmcallm=
eeting</span><br/><a href=3D"https://www.google.com/url?q=3Dhttps%3A%2F%2Fm=
eet.jit.si%2Fkvmcallmeeting&amp;sa=3DD&amp;ust=3D1701004500000000&amp;usg=
=3DAOvVaw28LTbVFttMGd_-WkNA3Vnk" class=3D"accent-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #1a73e8; text-decoration: none;font-w=
eight: 700;" target=3D"_blank" itemprop=3D"map">View map</a></span></div></=
td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-b=
reak: break-word;;padding-bottom:24px;"><div style=3D"font-family: Roboto, =
sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-heig=
ht: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" cla=
ss=3D"primary-text" role=3D"presentation"><table border=3D"0" cellpadding=
=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-bottom: 4px=
;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;color: #3c40=
43; text-decoration: none;font-weight: 700;-webkit-font-smoothing: antialia=
sed;margin: 0; padding: 0;">Guests</h2></td></tr></table><div style=3D"padd=
ing-bottom: 4px; text-align: left;;color: #3c4042;"><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
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
or: #3c4043; text-decoration: none;" href=3D"mailto:quintela@redhat.com">qu=
intela@redhat.com</a></span><meta itemprop=3D"email" content=3D"quintela@re=
dhat.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:mdean=
@redhat.com">mdean@redhat.com</a></span><meta itemprop=3D"email" content=3D=
"mdean@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #=
70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attende=
e" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D=
"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mai=
lto:felipe@nutanix.com">felipe@nutanix.com</a></span><meta itemprop=3D"emai=
l" content=3D"felipe@nutanix.com"/></span><span class=3D"secondary-text" st=
yle=3D"color: #70757a; text-decoration: none;"></span></div><div><span item=
prop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span ite=
mprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-=
hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: non=
e;" href=3D"mailto:afaerber@suse.de">afaerber@suse.de</a></span><meta itemp=
rop=3D"email" content=3D"afaerber@suse.de"/></span><span class=3D"secondary=
-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><=
span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person">=
<span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text unde=
rline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decora=
tion: none;" href=3D"mailto:bazulay@redhat.com">bazulay@redhat.com</a></spa=
n><meta itemprop=3D"email" content=3D"bazulay@redhat.com"/></span><span cla=
ss=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></sp=
an></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sche=
ma.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pr=
imary-text underline-on-hover" style=3D"display: inline-block;;color: #3c40=
43; text-decoration: none;" href=3D"mailto:bbauman@redhat.com">bbauman@redh=
at.com</a></span><meta itemprop=3D"email" content=3D"bbauman@redhat.com"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:cw@f00f.org">cw@f=
00f.org</a></span><meta itemprop=3D"email" content=3D"cw@f00f.org"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:dustin.kirkland@canonic=
al.com">dustin.kirkland@canonical.com</a></span><meta itemprop=3D"email" co=
ntent=3D"dustin.kirkland@canonical.com"/></span><span class=3D"secondary-te=
xt" style=3D"color: #70757a; text-decoration: none;"></span></div><div><spa=
n itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><sp=
an itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underli=
ne-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoratio=
n: none;" href=3D"mailto:eblake@redhat.com">eblake@redhat.com</a></span><me=
ta itemprop=3D"email" content=3D"eblake@redhat.com"/></span><span class=3D"=
secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></d=
iv><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org=
/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-=
text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; te=
xt-decoration: none;" href=3D"mailto:edgar.iglesias@gmail.com">edgar.iglesi=
as@gmail.com</a></span><meta itemprop=3D"email" content=3D"edgar.iglesias@g=
mail.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:eric.=
auger@redhat.com">eric.auger@redhat.com</a></span><meta itemprop=3D"email" =
content=3D"eric.auger@redhat.com"/></span><span class=3D"secondary-text" st=
yle=3D"color: #70757a; text-decoration: none;"></span></div><div><span item=
prop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span ite=
mprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-=
hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: non=
e;" href=3D"mailto:iggy@theiggy.com">iggy@theiggy.com</a></span><meta itemp=
rop=3D"email" content=3D"iggy@theiggy.com"/></span><span class=3D"secondary=
-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><=
span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person">=
<span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text unde=
rline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decora=
tion: none;" href=3D"mailto:jan.kiszka@web.de">jan.kiszka@web.de</a></span>=
<meta itemprop=3D"email" content=3D"jan.kiszka@web.de"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:jidong.xiao@gmail.com">jidong.xiao=
@gmail.com</a></span><meta itemprop=3D"email" content=3D"jidong.xiao@gmail.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:jjherne@li=
nux.vnet.ibm.com">jjherne@linux.vnet.ibm.com</a></span><meta itemprop=3D"em=
ail" content=3D"jjherne@linux.vnet.ibm.com"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:mimu@linux.vnet.ibm.com">mimu@linux.vnet.ibm.c=
om</a></span><meta itemprop=3D"email" content=3D"mimu@linux.vnet.ibm.com"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:peter.maydell@li=
naro.org">peter.maydell@linaro.org</a></span><meta itemprop=3D"email" conte=
nt=3D"peter.maydell@linaro.org"/></span><span class=3D"secondary-text" styl=
e=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempr=
op=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemp=
rop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-ho=
ver" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;=
" href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org=
</a></span><meta itemprop=3D"email" content=3D"richard.henderson@linaro.org=
"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-deco=
ration: none;"></span></div><div><span itemprop=3D"attendee" itemscope item=
type=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransl=
ate"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-=
block;;color: #3c4043; text-decoration: none;" href=3D"mailto:stefanha@gmai=
l.com">stefanha@gmail.com</a></span><meta itemprop=3D"email" content=3D"ste=
fanha@gmail.com"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:imp@bsdimp.com">imp@bsdimp.com</a></span><meta itemprop=3D"email" content=
=3D"imp@bsdimp.com"/></span><span class=3D"secondary-text" style=3D"color: =
#70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attend=
ee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name"=
 class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:z.huo@139.com">z.huo@139.com</a></span><meta itemprop=3D"email" cont=
ent=3D"z.huo@139.com"/></span><span class=3D"secondary-text" style=3D"color=
: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"atte=
ndee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"nam=
e" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:zwu.kernel@gmail.com">zwu.kernel@gmail.com</a></span><meta itemprop=
=3D"email" content=3D"zwu.kernel@gmail.com"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:jgg@nvidia.com">jgg@nvidia.com</a></span><meta=
 itemprop=3D"email" content=3D"jgg@nvidia.com"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:cjia@nvidia.com">cjia@nvidia.com</a></span>=
<meta itemprop=3D"email" content=3D"cjia@nvidia.com"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:david.edmondson@oracle.com">david.edm=
ondson@oracle.com</a></span><meta itemprop=3D"email" content=3D"david.edmon=
dson@oracle.com"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:elena.ufimtseva@oracle.com">Elena Ufimtseva</a></span><meta itemprop=3D"e=
mail" content=3D"elena.ufimtseva@oracle.com"/></span><span class=3D"seconda=
ry-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div=
><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person=
"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text un=
derline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-deco=
ration: none;" href=3D"mailto:konrad.wilk@oracle.com">konrad.wilk@oracle.co=
m</a></span><meta itemprop=3D"email" content=3D"konrad.wilk@oracle.com"/></=
span><span class=3D"secondary-text" style=3D"color: #70757a; text-decoratio=
n: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:ale@rev.ng">ale@r=
ev.ng</a></span><meta itemprop=3D"email" content=3D"ale@rev.ng"/></span><sp=
an class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;=
"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:=
//schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:anjo@rev.ng">anjo@rev.ng</=
a></span><meta itemprop=3D"email" content=3D"anjo@rev.ng"/></span><span cla=
ss=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></sp=
an></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sche=
ma.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pr=
imary-text underline-on-hover" style=3D"display: inline-block;;color: #3c40=
43; text-decoration: none;" href=3D"mailto:shameerali.kolothum.thodi@huawei=
.com">Shameerali Kolothum Thodi</a></span><meta itemprop=3D"email" content=
=3D"shameerali.kolothum.thodi@huawei.com"/></span><span class=3D"secondary-=
text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><s=
pan itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><=
span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text under=
line-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorat=
ion: none;" href=3D"mailto:wei.w.wang@intel.com">wei.w.wang@intel.com</a></=
span><meta itemprop=3D"email" content=3D"wei.w.wang@intel.com"/></span><spa=
n class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"=
></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:/=
/schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:chao.p.peng@linux.intel.co=
m">Chao Peng</a></span><meta itemprop=3D"email" content=3D"chao.p.peng@linu=
x.intel.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a=
; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" ite=
mscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:q=
emu-devel@nongnu.org">qemu-devel@nongnu.org</a></span><meta itemprop=3D"ema=
il" content=3D"qemu-devel@nongnu.org"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:mburton@qti.qualcomm.com">mburton@qti.qualcomm.com</=
a></span><meta itemprop=3D"email" content=3D"mburton@qti.qualcomm.com"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div></div></div></td></tr></table></td></tr></tbody></tab=
le></div><!--[if mso | IE]></tr></table><![endif]--></td></tr></tbody></tab=
le></td></tr></tbody></table></span></span></body></html>
--000000000000efd9d8060aa96420--

