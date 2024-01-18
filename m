Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD918831E3E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 18:16:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQVzZ-0005sr-3Q; Thu, 18 Jan 2024 12:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3vFypZQ0JCk80Br4.7Bz4Av2rx3rz2.t537v3B-uvCv2454x4B.58x@calendar-server.bounces.google.com>)
 id 1rQVzV-0005m8-Al
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 12:15:45 -0500
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3vFypZQ0JCk80Br4.7Bz4Av2rx3rz2.t537v3B-uvCv2454x4B.58x@calendar-server.bounces.google.com>)
 id 1rQVzS-0002sO-IP
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 12:15:45 -0500
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-40e6668d9e1so49458635e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 09:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1705598140; x=1706202940; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yQaBy/Spxkcj3aMaJVHPcvpnhK9p6FxdpW+WO0tVOrI=;
 b=J2ErFbdTHlnN9O21AZAYNqzv1q4cmziC1McsRstiMfxEQ6CCDJsOUnz6QaH1l0Jiug
 gI6kwW1dImpsMw1AZxOkMSz1s+JkMJj7d/2fmG+mXb2B89WpS8N5Z6E5ynA5dekDgG9p
 +qG+IMAyfCTg5OH5wCijCuYLShyzf1Z4rcFYw3aY7JZfv8dlQYSW38Tw20tD/24tknSD
 TQ8M448e/je3nCObMns/gvAnhAC3TtKkD06uYyNwQ++RdR9+NH0r5mHbDb6m95vMz9mN
 5Bes4MxcDE41zW0NRaIjX67kjXSpui6qu8JykmrNcvBDkZpZycZEfVuTo8PWgLUzPX1/
 JzZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705598140; x=1706202940; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yQaBy/Spxkcj3aMaJVHPcvpnhK9p6FxdpW+WO0tVOrI=;
 b=WCGGR0ErKJ0C3Q8UkgHoCuqixGg2H/x8VVnpS1uLh0nea1tWi1RJ7Y7ThFGlwKvQr1
 8yeCDXTg1mwRds9qWXqLqmlLVajwWLAs2JyKtWtdmFrYPCmzePvLyW6aI3we7MzZFKKv
 q1UBcOd6q89kpBT+sEnRFDQ2tP937mUf0CCG+gPs2kRc1G2q3uK/eZzieDEjByTflznx
 nLgkj/5XmoTV0+dgWXjlm7hhf1ZPAGWUprKpRGlh+oNakb6+u+79giZfUFB805fNjlU6
 ADUe3Ct4vJdmNWekYEgAYtKe00gSwyk/wzIPvUNNwED80l89dU3PxEZSZr1qrNa8rYKi
 lnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705598140; x=1706202940;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yQaBy/Spxkcj3aMaJVHPcvpnhK9p6FxdpW+WO0tVOrI=;
 b=vfC2hqeQfNrC5xDJxREgGvhUf4gXAtD6ImeTj9diWJM3gj+/IMLmgXnD42qPmToqAq
 oCPIvnLnc3v2B1/F8ox95VbgIq5RUiNcrh2Iv30Xm3vHhlYRB3eU4VmqlSVqnHzmWsDS
 t9ApFQTcpkrV/oD0luepO8tRnjYLUO3xM8m9xQ7OkqMsnSWSLjOTkqQEjkwJRVyUXV0h
 zsGqq/lDjfZjVZhG+fLleCoccUo2JO2ugEuBSZbAqgxNY9KjF27oxtHNK85gQPdALmiY
 nivYFzy8+ns+mvPTz/A9Nps4JYptT9swlar/+7GqWsFapoapw16m747IF/ATrDl8f3uQ
 JOjA==
X-Gm-Message-State: AOJu0Yy4JTq6pb3nlAijf3PFab98btJpdHxijNHvdlP2YXaEkFpWu8Ar
 Vca264d/dvAjya768eWvmb4knupucuKQQnbyCDDBKT2Ei7FgarK8U6SR8f0txZYt37NUFI1LFH9
 D62AEq2ozIQD9lbPwWYY1xt3Z5tMoqL3f8Q==
X-Google-Smtp-Source: AGHT+IHQusy6KqnQlr76PD/2TzYSzULHn+GRLKAG0iZlzj4q1ubpRETfaMb01pZsKg5etX8r3iu/vzHAqIwCMXaIktq9
MIME-Version: 1.0
X-Received: by 2002:a05:600c:6549:b0:40c:83f:9460 with SMTP id
 dn9-20020a05600c654900b0040c083f9460mr715325wmb.116.1705598140601; Thu, 18
 Jan 2024 09:15:40 -0800 (PST)
Auto-Submitted: auto-generated
Message-ID: <calendar-1d872b3f-1d93-4a54-a839-31c8e1c8accc@google.com>
Date: Thu, 18 Jan 2024 17:15:40 +0000
Subject: Updated invitation: QEMU developers fortnightly conference call @
 Every 2 weeks from 15:00 to 16:00 on Tuesday from Tue 2024-01-23 to Wed
 2023-02-22 (GMT+1) (qemu-devel@nongnu.org)
From: Juan Quintela <juan.quintela@gmail.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, mdean@redhat.com, 
 felipe@nutanix.com, cw@f00f.org, eblake@redhat.com, edgar.iglesias@gmail.com, 
 iggy@theiggy.com, jidong.xiao@gmail.com, peter.maydell@linaro.org, 
 richard.henderson@linaro.org, stefanha@gmail.com, imp@bsdimp.com, 
 zwu.kernel@gmail.com, jgg@nvidia.com, cjia@nvidia.com, konrad.wilk@oracle.com, 
 ale@rev.ng, wei.w.wang@intel.com, mburton@qti.qualcomm.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, 
 Joao Martins <joao.m.martins@oracle.com>, afaerber@suse.de, bbauman@redhat.com,
 eric.auger@redhat.com, jan.kiszka@web.de, jjherne@linux.vnet.ibm.com, 
 mimu@linux.vnet.ibm.com, z.huo@139.com, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, anjo@rev.ng, 
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, 
 Chao Peng <chao.p.peng@linux.intel.com>
Content-Type: multipart/mixed; boundary="0000000000004ce0cd060f3b83bb"
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3vFypZQ0JCk80Br4.7Bz4Av2rx3rz2.t537v3B-uvCv2454x4B.58x@calendar-server.bounces.google.com;
 helo=mail-wm1-x34a.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, HTML_FONT_LOW_CONTRAST=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--0000000000004ce0cd060f3b83bb
Content-Type: multipart/alternative; boundary="0000000000004ce0cb060f3b83b9"

--0000000000004ce0cb060f3b83b9
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBldmVudCBoYXMgYmVlbiB1cGRhdGVkDQpDaGFuZ2VkOiB0aW1lDQoNCg0KUUVNVSBkZXZl
bG9wZXJzIGZvcnRuaWdodGx5IGNvbmZlcmVuY2UgY2FsbA0KRXZlcnkgMiB3ZWVrcyBmcm9tIDE1
OjAwIHRvIDE2OjAwIG9uIFR1ZXNkYXkgZnJvbSBUdWVzZGF5IDIwMjQtMDEtMjMgdG8gIA0KV2Vk
bmVzZGF5IDIwMjMtMDItMjINCkNlbnRyYWwgRXVyb3BlYW4gVGltZSAtIE1hZHJpZA0KDQpMb2Nh
dGlvbg0KaHR0cHM6Ly9tZWV0LmppdC5zaS9rdm1jYWxsbWVldGluZwkNCmh0dHBzOi8vd3d3Lmdv
b2dsZS5jb20vdXJsP3E9aHR0cHMlM0ElMkYlMkZtZWV0LmppdC5zaSUyRmt2bWNhbGxtZWV0aW5n
JnNhPUQmdXN0PTE3MDYwMzAxMDAwMDAwMDAmdXNnPUFPdlZhdzFEa2lsaVZJVDZzcmE2cDdGTldX
bzANCg0KDQoNCklmIHlvdSBuZWVkIGNhbGwgZGV0YWlscywgcGxlYXNlIGNvbnRhY3QgbWU6IHF1
aW50ZWxhQHJlZGhhdC5jb20NCg0KR3Vlc3RzDQpxdWludGVsYUByZWRoYXQuY29tDQptZGVhbkBy
ZWRoYXQuY29tDQpmZWxpcGVAbnV0YW5peC5jb20NCmN3QGYwMGYub3JnDQplYmxha2VAcmVkaGF0
LmNvbQ0KZWRnYXIuaWdsZXNpYXNAZ21haWwuY29tDQppZ2d5QHRoZWlnZ3kuY29tDQpqaWRvbmcu
eGlhb0BnbWFpbC5jb20NCnBldGVyLm1heWRlbGxAbGluYXJvLm9yZw0KcmljaGFyZC5oZW5kZXJz
b25AbGluYXJvLm9yZw0Kc3RlZmFuaGFAZ21haWwuY29tDQppbXBAYnNkaW1wLmNvbQ0Kend1Lmtl
cm5lbEBnbWFpbC5jb20NCmpnZ0BudmlkaWEuY29tDQpjamlhQG52aWRpYS5jb20NCmtvbnJhZC53
aWxrQG9yYWNsZS5jb20NCmFsZUByZXYubmcNCndlaS53LndhbmdAaW50ZWwuY29tDQptYnVydG9u
QHF0aS5xdWFsY29tbS5jb20NClBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpDQpKb2FvIE1hcnRpbnMN
CmFmYWVyYmVyQHN1c2UuZGUNCmJiYXVtYW5AcmVkaGF0LmNvbQ0KZXJpYy5hdWdlckByZWRoYXQu
Y29tDQpqYW4ua2lzemthQHdlYi5kZQ0KampoZXJuZUBsaW51eC52bmV0LmlibS5jb20NCm1pbXVA
bGludXgudm5ldC5pYm0uY29tDQp6Lmh1b0AxMzkuY29tDQpFbGVuYSBVZmltdHNldmENCmFuam9A
cmV2Lm5nDQpTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQpDaGFvIFBlbmcNCnFlbXUtZGV2ZWxA
bm9uZ251Lm9yZw0KVmlldyBhbGwgZ3Vlc3QgaW5mbyAgDQpodHRwczovL2NhbGVuZGFyLmdvb2ds
ZS5jb20vY2FsZW5kYXIvZXZlbnQ/YWN0aW9uPVZJRVcmZWlkPWJtMXBkWEV5YlRBeGNHb3phbTVv
YTNReGRHZHFhVEJuY1RNZ2NXVnRkUzFrWlhabGJFQnViMjVuYm5VdWIzSm4mdG9rPU5USWpaV2Rs
WkRkamEya3dOV3h0ZFRGMGJtZDJhMnd6ZEdocFpITkFaM0p2ZFhBdVkyRnNaVzVrWVhJdVoyOXZa
MnhsTG1OdmJXTmhNRFF4TXpKaU5UUmlNV0prWldFd01HSmtPR0kxT0RVd1lUTmxaREl6TkRSaE56
aGlabVkmY3R6PUV1cm9wZSUyRk1hZHJpZCZobD1lbiZlcz0wDQoNClJlcGx5IGZvciBxZW11LWRl
dmVsQG5vbmdudS5vcmcgYW5kIHZpZXcgbW9yZSBkZXRhaWxzICANCmh0dHBzOi8vY2FsZW5kYXIu
Z29vZ2xlLmNvbS9jYWxlbmRhci9ldmVudD9hY3Rpb249VklFVyZlaWQ9Ym0xcGRYRXliVEF4Y0dv
emFtNW9hM1F4ZEdkcWFUQm5jVE1nY1dWdGRTMWtaWFpsYkVCdWIyNW5iblV1YjNKbiZ0b2s9TlRJ
alpXZGxaRGRqYTJrd05XeHRkVEYwYm1kMmEyd3pkR2hwWkhOQVozSnZkWEF1WTJGc1pXNWtZWEl1
WjI5dloyeGxMbU52YldOaE1EUXhNekppTlRSaU1XSmtaV0V3TUdKa09HSTFPRFV3WVRObFpESXpO
RFJoTnpoaVptWSZjdHo9RXVyb3BlJTJGTWFkcmlkJmhsPWVuJmVzPTANCllvdXIgYXR0ZW5kYW5j
ZSBpcyBvcHRpb25hbC4NCg0Kfn4vL35+DQpJbnZpdGF0aW9uIGZyb20gR29vZ2xlIENhbGVuZGFy
OiBodHRwczovL2NhbGVuZGFyLmdvb2dsZS5jb20vY2FsZW5kYXIvDQoNCllvdSBhcmUgcmVjZWl2
aW5nIHRoaXMgZW1haWwgYmVjYXVzZSB5b3UgYXJlIGFuIGF0dGVuZGVlIG9uIHRoZSBldmVudC4g
VG8gIA0Kc3RvcCByZWNlaXZpbmcgZnV0dXJlIHVwZGF0ZXMgZm9yIHRoaXMgZXZlbnQsIGRlY2xp
bmUgdGhpcyBldmVudC4NCg0KRm9yd2FyZGluZyB0aGlzIGludml0YXRpb24gY291bGQgYWxsb3cg
YW55IHJlY2lwaWVudCB0byBzZW5kIGEgcmVzcG9uc2UgdG8gIA0KdGhlIG9yZ2FuaXplciwgYmUg
YWRkZWQgdG8gdGhlIGd1ZXN0IGxpc3QsIGludml0ZSBvdGhlcnMgcmVnYXJkbGVzcyBvZiAgDQp0
aGVpciBvd24gaW52aXRhdGlvbiBzdGF0dXMsIG9yIG1vZGlmeSB5b3VyIFJTVlAuDQoNCkxlYXJu
IG1vcmUgaHR0cHM6Ly9zdXBwb3J0Lmdvb2dsZS5jb20vY2FsZW5kYXIvYW5zd2VyLzM3MTM1I2Zv
cndhcmRpbmcNCg==
--0000000000004ce0cb060f3b83b9
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
/InformAction"><span itemprop=3D"object" itemscope itemtype=3D"http://schem=
a.org/Event"><meta itemprop=3D"eventStatus" content=3D"http://schema.org/Ev=
entRescheduled"/><span itemprop=3D"publisher" itemscope itemtype=3D"http://=
schema.org/Organization"><meta itemprop=3D"name" content=3D"Google Calendar=
"/></span><meta itemprop=3D"eventId/googleCalendar" content=3D"nmiuq2m01pj3=
jnhkt1tgji0gq3"/><span style=3D"display: none; font-size: 1px; color: #fff;=
 line-height: 1px; height: 0; max-height: 0; width: 0; max-width: 0; opacit=
y: 0; overflow: hidden;" itemprop=3D"name">QEMU developers fortnightly conf=
erence call</span><meta itemprop=3D"url" content=3D"https://calendar.google=
.com/calendar/event?action=3DVIEW&amp;eid=3Dbm1pdXEybTAxcGozam5oa3QxdGdqaTB=
ncTMgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2w=
zdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbWNhMDQxMzJiNTRiMWJkZWEwMGJkOGI1OD=
UwYTNlZDIzNDRhNzhiZmY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0"/><s=
pan aria-hidden=3D"true"><time itemprop=3D"startDate" datetime=3D"20240123T=
140000Z"></time><time itemprop=3D"endDate" datetime=3D"20240123T150000Z"></=
time></span><div style=3D"display: none; font-size: 1px; color: #fff; line-=
height: 1px; height: 0; max-height: 0; width: 0; max-width: 0; opacity: 0; =
overflow: hidden;">If you need call details, please contact me: quintela@re=
dhat.com</div><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D"body-cont=
ainer"><tbody><tr><td style=3D"" class=3D"" align=3D"left"><!--[if mso | IE=
]><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentat=
ion"><tr><td height=3D"16" style=3D"height:16px;"><![endif]--><div style=3D=
"height:16px;" aria-hidden=3D"true"> &nbsp; </div><!--[if mso | IE]></td></=
tr></table><![endif]--><table border=3D"0" cellpadding=3D"0" cellspacing=3D=
"0" role=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D""=
><tbody><tr><td style=3D"background-color: #e6f4ea;color: #0d5327;padding: =
12px 32px; border-radius: 8px;font-family: Roboto, sans-serif;font-size: 14=
px; line-height: 20px;text-align: left;" class=3D"info-bar-inner"><span sty=
le=3D"font-weight: 700;">This event has been updated</span><br/><span style=
=3D"display:none" itemprop=3D"about" itemscope itemtype=3D"http://schema.or=
g/Thing/Clock"><meta itemprop=3D"description" content=3D"Time updated"/></s=
pan><div style=3D""><span style=3D"font-weight: 700;">Changed:</span> time<=
/div></td></tr></tbody></table><!--[if mso | IE]><table border=3D"0" cellpa=
dding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><td height=3D"12" s=
tyle=3D"height:12px;"><![endif]--><div style=3D"height:12px;" aria-hidden=
=3D"true"> &nbsp; </div><!--[if mso | IE]></td></tr></table><![endif]--><ta=
ble border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" =
align=3D"center" style=3D"width:100%;" class=3D""><tbody><tr><td style=3D"b=
order: solid 1px #dadce0; border-radius: 8px; direction: rtl; font-size: 0;=
 padding: 24px 32px; text-align: left; vertical-align: top;" class=3D"main-=
container-inner"><!--[if mso | IE]><table border=3D"0" cellpadding=3D"0" ce=
llspacing=3D"0" role=3D"presentation"><tr><![endif]--><div class=3D"" style=
=3D"font-size: 13px; text-align: left; direction: ltr; display: inline-bloc=
k; vertical-align: top; width: 100%;overflow: hidden; word-wrap: break-word=
;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presenta=
tion" width=3D"100%" class=3D"main-column-table-ltr" style=3D"padding-right=
: 32px; padding-left: 0;;table-layout: fixed;"><tbody><tr><td class=3D"main=
-column-td" style=3D"padding:0; vertical-align:top;"><table border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"100%" styl=
e=3D"table-layout: fixed;"><tr><td style=3D"font-size: 0; padding: 0; text-=
align: left; word-break: break-word;;padding-bottom:24px;"><div style=3D"fo=
nt-family: Roboto, sans-serif;font-style: normal; font-weight: 400; font-si=
ze: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-dec=
oration: none;" class=3D"primary-text" role=3D"presentation"><span>If you n=
eed call details, please contact me: <a href=3D"mailto:quintela@redhat.com"=
 target=3D"_blank">quintela@redhat.com</a></span><meta itemprop=3D"descript=
ion" content=3D"If you need call details, please contact me: quintela@redha=
t.com"/></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-ali=
gn: left; word-break: break-word;;padding-bottom:24px;"><div style=3D"font-=
family: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size:=
 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decora=
tion: none;" class=3D"primary-text" role=3D"presentation"><span aria-hidden=
=3D"true"><time itemprop=3D"startDate" datetime=3D"20240123T140000Z"></time=
><time itemprop=3D"endDate" datetime=3D"20240123T150000Z"></time></span><ta=
ble border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" =
style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"=
font-size: 14px;color: #3c4043; text-decoration: none;font-weight: 700;-web=
kit-font-smoothing: antialiased;margin: 0; padding: 0;">When</h2></td><td s=
tyle=3D"width: 8px;"></td><td style=3D"padding-top: 2px; padding-bottom: 3p=
x;"><div style=3D"background-color: #1e8e3e; border-radius: 10px; padding: =
1px 5px; line-height: 13px;"><span style=3D"color: white; font-size: 11px; =
font-weight: 700; letter-spacing: 0.8px; text-transform: uppercase; vertica=
l-align: top;">CHANGED</span></div></td></tr></table><span>Every 2 weeks fr=
om 15:00 to 16:00 on Tuesday from Tuesday 2024-01-23 to Wednesday 2023-02-2=
2 (Central European Time - Madrid)<br/><span style=3D"text-decoration: line=
-through;"><del><span style=3D"display: none; font-size: 1px; color: #fff; =
line-height: 1px; height: 0; max-height: 0; width: 0; max-width: 0; opacity=
: 0; overflow: hidden;font-size: 0; display: block;">Old: </span>Every 2 we=
eks from 15:00 to 16:00 on Tuesday (Central European Time - Madrid)</del></=
span></span></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text=
-align: left; word-break: break-word;;padding-bottom:24px;"><div style=3D"f=
ont-family: Roboto, sans-serif;font-style: normal; font-weight: 400; font-s=
ize: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-de=
coration: none;" class=3D"primary-text" role=3D"presentation"><table border=
=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"p=
adding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size:=
 14px;color: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-s=
moothing: antialiased;margin: 0; padding: 0;">Location</h2></td></tr></tabl=
e><span itemprop=3D"location" itemscope itemtype=3D"http://schema.org/Place=
"><span itemprop=3D"name" class=3D"primary-text notranslate" style=3D"font-=
family: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size:=
 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decora=
tion: none;">https://meet.jit.si/kvmcallmeeting</span><br/><a href=3D"https=
://www.google.com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=
=3DD&amp;ust=3D1706030100000000&amp;usg=3DAOvVaw1DkiliVIT6sra6p7FNWWo0" cla=
ss=3D"accent-text underline-on-hover" style=3D"display: inline-block;;color=
: #1a73e8; text-decoration: none;font-weight: 700;" target=3D"_blank" itemp=
rop=3D"map">View map</a></span></div></td></tr><tr><td style=3D"font-size: =
0; padding: 0; text-align: left; word-break: break-word;;padding-bottom:24p=
x;"><div style=3D"font-family: Roboto, sans-serif;font-style: normal; font-=
weight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;colo=
r: #3c4043; text-decoration: none;" class=3D"primary-text" role=3D"presenta=
tion"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"prese=
ntation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" =
style=3D"font-size: 14px;color: #3c4043; text-decoration: none;font-weight:=
 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">Guests</h2=
></td></tr></table><div style=3D"padding-bottom: 4px; text-align: left;;col=
or: #3c4042;"><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:/=
/schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:quintela@redhat.com">quint=
ela@redhat.com</a></span><meta itemprop=3D"email" content=3D"quintela@redha=
t.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:mdean@re=
dhat.com">mdean@redhat.com</a></span><meta itemprop=3D"email" content=3D"md=
ean@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" =
itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cla=
ss=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"di=
splay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto=
:felipe@nutanix.com">felipe@nutanix.com</a></span><meta itemprop=3D"email" =
content=3D"felipe@nutanix.com"/></span><span class=3D"secondary-text" style=
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
=3D"mailto:eblake@redhat.com">eblake@redhat.com</a></span><meta itemprop=3D=
"email" content=3D"eblake@redhat.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:edgar.iglesias@gmail.com">edgar.iglesias@gmail.com</=
a></span><meta itemprop=3D"email" content=3D"edgar.iglesias@gmail.com"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:iggy@theiggy.com"=
>iggy@theiggy.com</a></span><meta itemprop=3D"email" content=3D"iggy@theigg=
y.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:jidong.x=
iao@gmail.com">jidong.xiao@gmail.com</a></span><meta itemprop=3D"email" con=
tent=3D"jidong.xiao@gmail.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a></spa=
n><meta itemprop=3D"email" content=3D"peter.maydell@linaro.org"/></span><sp=
an class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;=
"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:=
//schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:richard.henderson@linaro.o=
rg">richard.henderson@linaro.org</a></span><meta itemprop=3D"email" content=
=3D"richard.henderson@linaro.org"/></span><span class=3D"secondary-text" st=
yle=3D"color: #70757a; text-decoration: none;"></span></div><div><span item=
prop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span ite=
mprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-=
hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: non=
e;" href=3D"mailto:stefanha@gmail.com">stefanha@gmail.com</a></span><meta i=
temprop=3D"email" content=3D"stefanha@gmail.com"/></span><span class=3D"sec=
ondary-text" style=3D"color: #70757a; text-decoration: none;"></span></div>=
<div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pe=
rson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-tex=
t underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-=
decoration: none;" href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a></span>=
<meta itemprop=3D"email" content=3D"imp@bsdimp.com"/></span><span class=3D"=
secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></d=
iv><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org=
/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-=
text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; te=
xt-decoration: none;" href=3D"mailto:zwu.kernel@gmail.com">zwu.kernel@gmail=
.com</a></span><meta itemprop=3D"email" content=3D"zwu.kernel@gmail.com"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:jgg@nvidia.com">j=
gg@nvidia.com</a></span><meta itemprop=3D"email" content=3D"jgg@nvidia.com"=
/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decor=
ation: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemt=
ype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransla=
te"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-b=
lock;;color: #3c4043; text-decoration: none;" href=3D"mailto:cjia@nvidia.co=
m">cjia@nvidia.com</a></span><meta itemprop=3D"email" content=3D"cjia@nvidi=
a.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:konrad.w=
ilk@oracle.com">konrad.wilk@oracle.com</a></span><meta itemprop=3D"email" c=
ontent=3D"konrad.wilk@oracle.com"/></span><span class=3D"secondary-text" st=
yle=3D"color: #70757a; text-decoration: none;"></span></div><div><span item=
prop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span ite=
mprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-=
hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: non=
e;" href=3D"mailto:ale@rev.ng">ale@rev.ng</a></span><meta itemprop=3D"email=
" content=3D"ale@rev.ng"/></span><span class=3D"secondary-text" style=3D"co=
lor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"a=
ttendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"=
name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" st=
yle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:wei.w.wang@intel.com">wei.w.wang@intel.com</a></span><meta itemp=
rop=3D"email" content=3D"wei.w.wang@intel.com"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:mburton@qti.qualcomm.com">mburton@qti.qualc=
omm.com</a></span><meta itemprop=3D"email" content=3D"mburton@qti.qualcomm.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:f4bug@amsa=
t.org">Philippe Mathieu-Daud=C3=A9</a></span><meta itemprop=3D"email" conte=
nt=3D"f4bug@amsat.org"/></span><span class=3D"secondary-text" style=3D"colo=
r: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"att=
endee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"na=
me" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" styl=
e=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D=
"mailto:joao.m.martins@oracle.com">Joao Martins</a></span><meta itemprop=3D=
"email" content=3D"joao.m.martins@oracle.com"/></span><span class=3D"second=
ary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><di=
v><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Perso=
n"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text u=
nderline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-dec=
oration: none;" href=3D"mailto:afaerber@suse.de">afaerber@suse.de</a></span=
><meta itemprop=3D"email" content=3D"afaerber@suse.de"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:bbauman@redhat.com">bbauman@redhat=
.com</a></span><meta itemprop=3D"email" content=3D"bbauman@redhat.com"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:eric.auger@redhat=
.com">eric.auger@redhat.com</a></span><meta itemprop=3D"email" content=3D"e=
ric.auger@redhat.com"/></span><span class=3D"secondary-text" style=3D"color=
: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"atte=
ndee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"nam=
e" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:jan.kiszka@web.de">jan.kiszka@web.de</a></span><meta itemprop=3D"ema=
il" content=3D"jan.kiszka@web.de"/></span><span class=3D"secondary-text" st=
yle=3D"color: #70757a; text-decoration: none;"></span></div><div><span item=
prop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span ite=
mprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-=
hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: non=
e;" href=3D"mailto:jjherne@linux.vnet.ibm.com">jjherne@linux.vnet.ibm.com</=
a></span><meta itemprop=3D"email" content=3D"jjherne@linux.vnet.ibm.com"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:mimu@linux.vnet.i=
bm.com">mimu@linux.vnet.ibm.com</a></span><meta itemprop=3D"email" content=
=3D"mimu@linux.vnet.ibm.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:z.huo@139.com">z.huo@139.com</a></span><meta itemprop=3D"em=
ail" content=3D"z.huo@139.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:elena.ufimtseva@oracle.com">Elena Ufimtseva</a></span><meta=
 itemprop=3D"email" content=3D"elena.ufimtseva@oracle.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:anjo@rev.ng">anjo@rev.ng</a></s=
pan><meta itemprop=3D"email" content=3D"anjo@rev.ng"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:shameerali.kolothum.thodi@huawei.com"=
>Shameerali Kolothum Thodi</a></span><meta itemprop=3D"email" content=3D"sh=
ameerali.kolothum.thodi@huawei.com"/></span><span class=3D"secondary-text" =
style=3D"color: #70757a; text-decoration: none;"></span></div><div><span it=
emprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span i=
temprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-o=
n-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: n=
one;" href=3D"mailto:chao.p.peng@linux.intel.com">Chao Peng</a></span><meta=
 itemprop=3D"email" content=3D"chao.p.peng@linux.intel.com"/></span><span c=
lass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></=
span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sc=
hema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"=
primary-text underline-on-hover" style=3D"display: inline-block;;color: #3c=
4043; text-decoration: none;" href=3D"mailto:qemu-devel@nongnu.org">qemu-de=
vel@nongnu.org</a></span><meta itemprop=3D"email" content=3D"qemu-devel@non=
gnu.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; te=
xt-decoration: none;"></span></div></div><a href=3D"https://calendar.google=
.com/calendar/event?action=3DVIEW&amp;eid=3Dbm1pdXEybTAxcGozam5oa3QxdGdqaTB=
ncTMgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2w=
zdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbWNhMDQxMzJiNTRiMWJkZWEwMGJkOGI1OD=
UwYTNlZDIzNDRhNzhiZmY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" sty=
le=3D"display: inline-block;;color: #1a73e8; text-decoration: none;font-wei=
ght: 700;" target=3D"_blank" class=3D"accent-text underline-on-hover">View =
all guest info</a></div></td></tr><tr><td style=3D"font-size: 0; padding: 0=
; text-align: left; word-break: break-word;;padding-bottom:0px;"><div style=
=3D"color: #3c4043; text-decoration: none;;font-family: Roboto, sans-serif;=
font-size: 14px; line-height: 20px; mso-line-height-rule: exactly; text-ali=
gn: left;" class=3D"primary-text"><div><span style=3D"font-weight: 700;-web=
kit-font-smoothing: antialiased;">RSVP</span><span class=3D"secondary-text"=
 style=3D"color: #70757a; text-decoration: none;"> for <a class=3D"secondar=
y-text underline-on-hover" style=3D"display: inline-block;;color: #70757a; =
text-decoration: none;" href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@no=
ngnu.org</a> for all events in this series</span></div></div></td></tr><tr>=
<td style=3D"font-size: 0; padding: 0; text-align: left; word-break: break-=
word;;padding-bottom:16px;"><div style=3D"font-family: Roboto, sans-serif;f=
ont-size: 14px; line-height: 20px; mso-line-height-rule: exactly; text-alig=
n: left;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"p=
resentation" style=3D"border-collapse: separate;"><tr><td style=3D"padding-=
top: 8px; padding-left: 0; padding-right: 12px;"><!-- RSVP buttons --><tabl=
e border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" st=
yle=3D"border: solid 1px #dadce0; border-radius: 16px; border-collapse: sep=
arate;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;;display: inli=
ne-block;;margin-right: 12px; margin-left: 0;"><tr><td align=3D"center" ver=
tical-align=3D"middle" role=3D"presentation"><span itemprop=3D"potentialact=
ion" itemscope itemtype=3D"http://schema.org/RsvpAction"><meta itemprop=3D"=
attendance" content=3D"http://schema.org/RsvpAttendance/Yes"/><span itempro=
p=3D"handler" itemscope itemtype=3D"http://schema.org/HttpActionHandler"><l=
ink itemprop=3D"method" href=3D"http://schema.org/HttpRequestMethod/GET"/><=
span style=3D"color: #5f6367;"><a href=3D"https://calendar.google.com/calen=
dar/event?action=3DRESPOND&amp;eid=3Dbm1pdXEybTAxcGozam5oa3QxdGdqaTBncTMgcW=
VtdS1kZXZlbEBub25nbnUub3Jn&amp;rst=3D1&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bm=
d2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbWNhMDQxMzJiNTRiMWJkZWEwMGJkO=
GI1ODUwYTNlZDIzNDRhNzhiZmY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0=
" style=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, san=
s-serif;color: #5f6368; font-size: 14px; line-height: 120%; mso-line-height=
-rule: exactly; margin: 0; text-decoration: none; text-transform: none;" cl=
ass=3D"grey-button-text" itemprop=3D"url" target=3D"_blank"><table border=
=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><td al=
ign=3D"center" role=3D"presentation" valign=3D"middle" style=3D"padding: 6p=
x 0; padding-left: 16px; padding-right: 12px; white-space: nowrap;"><!--[if=
 mso]><a href=3D"https://calendar.google.com/calendar/event?action=3DRESPON=
D&amp;eid=3Dbm1pdXEybTAxcGozam5oa3QxdGdqaTBncTMgcWVtdS1kZXZlbEBub25nbnUub3J=
n&amp;rst=3D1&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2F=
sZW5kYXIuZ29vZ2xlLmNvbWNhMDQxMzJiNTRiMWJkZWEwMGJkOGI1ODUwYTNlZDIzNDRhNzhiZm=
Y&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-te=
xt" itemprop=3D"url" target=3D"_blank"><![endif]--><span class=3D"grey-butt=
on-text" style=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Robo=
to, sans-serif;color: #5f6368; font-size: 14px; line-height: 120%; mso-line=
-height-rule: exactly; margin: 0; text-decoration: none; text-transform: no=
ne;">Yes</span><!--[if mso]></a><![endif]--></td></tr></table></a></span></=
span></span></td><td align=3D"center" vertical-align=3D"middle" role=3D"pre=
sentation" style=3D"border-left: solid 1px #dadce0; border-right: solid 1px=
 #dadce0;"><span itemprop=3D"potentialaction" itemscope itemtype=3D"http://=
schema.org/RsvpAction"><meta itemprop=3D"attendance" content=3D"http://sche=
ma.org/RsvpAttendance/No"/><span itemprop=3D"handler" itemscope itemtype=3D=
"http://schema.org/HttpActionHandler"><link itemprop=3D"method" href=3D"htt=
p://schema.org/HttpRequestMethod/GET"/><span style=3D"color: #5f6367;"><a h=
ref=3D"https://calendar.google.com/calendar/event?action=3DRESPOND&amp;eid=
=3Dbm1pdXEybTAxcGozam5oa3QxdGdqaTBncTMgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;rst=
=3D2&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIu=
Z29vZ2xlLmNvbWNhMDQxMzJiNTRiMWJkZWEwMGJkOGI1ODUwYTNlZDIzNDRhNzhiZmY&amp;ctz=
=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" style=3D"font-weight: 400;font-f=
amily: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size:=
 14px; line-height: 120%; mso-line-height-rule: exactly; margin: 0; text-de=
coration: none; text-transform: none;" class=3D"grey-button-text" itemprop=
=3D"url" target=3D"_blank"><table border=3D"0" cellpadding=3D"0" cellspacin=
g=3D"0" role=3D"presentation"><tr><td align=3D"center" role=3D"presentation=
" valign=3D"middle" style=3D"padding: 6px 12px; white-space: nowrap;"><!--[=
if mso]><a href=3D"https://calendar.google.com/calendar/event?action=3DRESP=
OND&amp;eid=3Dbm1pdXEybTAxcGozam5oa3QxdGdqaTBncTMgcWVtdS1kZXZlbEBub25nbnUub=
3Jn&amp;rst=3D2&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY=
2FsZW5kYXIuZ29vZ2xlLmNvbWNhMDQxMzJiNTRiMWJkZWEwMGJkOGI1ODUwYTNlZDIzNDRhNzhi=
ZmY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-=
text" itemprop=3D"url" target=3D"_blank"><![endif]--><span class=3D"grey-bu=
tton-text" style=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Ro=
boto, sans-serif;color: #5f6368; font-size: 14px; line-height: 120%; mso-li=
ne-height-rule: exactly; margin: 0; text-decoration: none; text-transform: =
none;">No</span><!--[if mso]></a><![endif]--></td></tr></table></a></span><=
/span></span></td><td align=3D"center" vertical-align=3D"middle" role=3D"pr=
esentation"><span itemprop=3D"potentialaction" itemscope itemtype=3D"http:/=
/schema.org/RsvpAction"><meta itemprop=3D"attendance" content=3D"http://sch=
ema.org/RsvpAttendance/Maybe"/><span itemprop=3D"handler" itemscope itemtyp=
e=3D"http://schema.org/HttpActionHandler"><link itemprop=3D"method" href=3D=
"http://schema.org/HttpRequestMethod/GET"/><span style=3D"color: #5f6367;">=
<a href=3D"https://calendar.google.com/calendar/event?action=3DRESPOND&amp;=
eid=3Dbm1pdXEybTAxcGozam5oa3QxdGdqaTBncTMgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;=
rst=3D3&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kY=
XIuZ29vZ2xlLmNvbWNhMDQxMzJiNTRiMWJkZWEwMGJkOGI1ODUwYTNlZDIzNDRhNzhiZmY&amp;=
ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" style=3D"font-weight: 400;fon=
t-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-si=
ze: 14px; line-height: 120%; mso-line-height-rule: exactly; margin: 0; text=
-decoration: none; text-transform: none;" class=3D"grey-button-text" itempr=
op=3D"url" target=3D"_blank"><table border=3D"0" cellpadding=3D"0" cellspac=
ing=3D"0" role=3D"presentation"><tr><td align=3D"center" role=3D"presentati=
on" valign=3D"middle" style=3D"padding: 6px 0; padding-left: 12px; padding-=
right: 16px; white-space: nowrap;"><!--[if mso]><a href=3D"https://calendar=
.google.com/calendar/event?action=3DRESPOND&amp;eid=3Dbm1pdXEybTAxcGozam5oa=
3QxdGdqaTBncTMgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;rst=3D3&amp;tok=3DNTIjZWdlZ=
Ddja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbWNhMDQxMzJi=
NTRiMWJkZWEwMGJkOGI1ODUwYTNlZDIzNDRhNzhiZmY&amp;ctz=3DEurope%2FMadrid&amp;h=
l=3Den&amp;es=3D0" class=3D"grey-button-text" itemprop=3D"url" target=3D"_b=
lank"><![endif]--><span class=3D"grey-button-text" style=3D"font-weight: 40=
0;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; fo=
nt-size: 14px; line-height: 120%; mso-line-height-rule: exactly; margin: 0;=
 text-decoration: none; text-transform: none;">Maybe</span><!--[if mso]></a=
><![endif]--></td></tr></table></a></span></span></span></td></tr></table><=
!-- More options --><a href=3D"https://calendar.google.com/calendar/event?a=
ction=3DVIEW&amp;eid=3Dbm1pdXEybTAxcGozam5oa3QxdGdqaTBncTMgcWVtdS1kZXZlbEBu=
b25nbnUub3Jn&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2Fs=
ZW5kYXIuZ29vZ2xlLmNvbWNhMDQxMzJiNTRiMWJkZWEwMGJkOGI1ODUwYTNlZDIzNDRhNzhiZmY=
&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" style=3D"display: inline=
-block;;font-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-s=
erif;color: #5f6368; font-size: 14px; line-height: 120%; mso-line-height-ru=
le: exactly; margin: 0; text-decoration: none; text-transform: none;" class=
=3D"grey-button-text" target=3D"_blank"><table border=3D"0" cellpadding=3D"=
0" cellspacing=3D"0" role=3D"presentation" style=3D"border: solid 1px #dadc=
e0; border-radius: 16px; border-collapse: separate;font-family: &#39;Google=
 Sans&#39;, Roboto, sans-serif;"><tr><td align=3D"center" vertical-align=3D=
"middle" role=3D"presentation" style=3D"padding: 6px 0; padding-left: 16px;=
 padding-right: 12px; white-space: nowrap;;color: #5f6367;"><!--[if mso]><a=
 href=3D"https://calendar.google.com/calendar/event?action=3DVIEW&amp;eid=
=3Dbm1pdXEybTAxcGozam5oa3QxdGdqaTBncTMgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;tok=
=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNv=
bWNhMDQxMzJiNTRiMWJkZWEwMGJkOGI1ODUwYTNlZDIzNDRhNzhiZmY&amp;ctz=3DEurope%2F=
Madrid&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-text" target=3D"_blank"=
><![endif]--><span class=3D"grey-button-text" style=3D"font-weight: 400;fon=
t-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-si=
ze: 14px; line-height: 120%; mso-line-height-rule: exactly; margin: 0; text=
-decoration: none; text-transform: none;">More options</span><!--[if mso]><=
/a><![endif]--></td></tr></table></a></td></tr></table></div></td></tr></ta=
ble></td></tr></tbody></table></div><!--[if mso | IE]></tr></table><![endif=
]--></td></tr></tbody></table><table border=3D"0" cellpadding=3D"0" cellspa=
cing=3D"0" role=3D"presentation" align=3D"center" style=3D"width:100%;" cla=
ss=3D""><tbody><tr><td style=3D"font-size: 0; padding: 0; text-align: left;=
 word-break: break-word;;padding:4px 12px;" class=3D"" align=3D"left"><div =
class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;fon=
t-family: Roboto, sans-serif;font-size: 12px; line-height: 16px; mso-line-h=
eight-rule: exactly; text-align: left;"><p>Invitation from <a href=3D"https=
://calendar.google.com/calendar/" class=3D"accent-text underline-on-hover" =
style=3D"font-family: Roboto, sans-serif;font-size: 12px; line-height: 16px=
; mso-line-height-rule: exactly;;color: #1a73e8; text-decoration: none;" ta=
rget=3D"_blank">Google Calendar</a></p><p>You are receiving this email beca=
use you are an attendee on the event. To stop receiving future updates for =
this event, decline this event.</p><p>Forwarding this invitation could allo=
w any recipient to send a response to the organizer, be added to the guest =
list, invite others regardless of their own invitation status, or modify yo=
ur RSVP. <a class=3D"accent-text underline-on-hover" style=3D"font-family: =
Roboto, sans-serif;font-size: 12px; line-height: 16px; mso-line-height-rule=
: exactly;;color: #1a73e8; text-decoration: none;" href=3D"https://support.=
google.com/calendar/answer/37135#forwarding">Learn more</a></p></div></td><=
/tr></tbody></table></td></tr></tbody></table></span></span></body></html>
--0000000000004ce0cb060f3b83b9
Content-Type: text/calendar; charset="UTF-8"; method=REQUEST
Content-Transfer-Encoding: 7bit

BEGIN:VCALENDAR
PRODID:-//Google Inc//Google Calendar 70.9054//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:REQUEST
BEGIN:VTIMEZONE
TZID:America/New_York
X-LIC-LOCATION:America/New_York
BEGIN:DAYLIGHT
TZOFFSETFROM:-0500
TZOFFSETTO:-0400
TZNAME:EDT
DTSTART:19700308T020000
RRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=2SU
END:DAYLIGHT
BEGIN:STANDARD
TZOFFSETFROM:-0400
TZOFFSETTO:-0500
TZNAME:EST
DTSTART:19701101T020000
RRULE:FREQ=YEARLY;BYMONTH=11;BYDAY=1SU
END:STANDARD
END:VTIMEZONE
BEGIN:VEVENT
DTSTART;TZID=America/New_York:20240123T090000
DTEND;TZID=America/New_York:20240123T100000
RRULE:FREQ=WEEKLY;WKST=MO;UNTIL=20230222T045959Z;INTERVAL=2;BYDAY=TU
DTSTAMP:20240118T171540Z
ORGANIZER;CN=KVM call for qemu developers:mailto:eged7cki05lmu1tngvkl3thids
 @group.calendar.google.com
UID:nmiuq2m01pj3jnhkt1tgji0gq3@google.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=quintela@redhat.com;X-NUM-GUESTS=0:mailto:quintela@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=mdean@redhat.com;X-NUM-GUESTS=0:mailto:mdean@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=felipe@nutanix.com;X-NUM-GUESTS=0:mailto:felipe@nutanix.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=cw@f00f.org;X-NUM-GUESTS=0:mailto:cw@f00f.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=eblake@redhat.com;X-NUM-GUESTS=0:mailto:eblake@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=edgar.iglesias@gmail.com;X-NUM-GUESTS=0:mailto:edgar.iglesias@gmail
 .com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=iggy@theiggy.com;X-NUM-GUESTS=0:mailto:iggy@theiggy.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=jidong.xiao@gmail.com;X-NUM-GUESTS=0:mailto:jidong.xiao@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=peter.maydell@linaro.org;X-NUM-GUESTS=0:mailto:peter.maydell@linaro
 .org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=richard.henderson@linaro.org;X-NUM-GUESTS=0:mailto:richard.henderso
 n@linaro.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=stefanha@gmail.com;X-NUM-GUESTS=0:mailto:stefanha@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=imp@bsdimp.com;X-NUM-GUESTS=0:mailto:imp@bsdimp.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=zwu.kernel@gmail.com;X-NUM-GUESTS=0:mailto:zwu.kernel@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=jgg@nvidia.com;X-NUM-GUESTS=0:mailto:jgg@nvidia.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=cjia@nvidia.com;X-NUM-GUESTS=0:mailto:cjia@nvidia.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=konrad.wilk@oracle.com;X-NUM-GUESTS=0:mailto:konrad.wilk@oracle.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=ale@rev.ng;X-NUM-GUESTS=0:mailto:ale@rev.ng
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=wei.w.wang@intel.com;X-NUM-GUESTS=0:mailto:wei.w.wang@intel.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=mburton@qti.qualcomm.com;X-NUM-GUESTS=0:mailto:mburton@qti.qualcomm
 .com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;X-NUM-GUESTS=0:mailto:f4bug@amsat.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Joao Martins;X-NUM-GUESTS=0:mailto:joao.m.martins@oracle.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=afaerber@suse.de;X-NUM-GUESTS=0:mailto:afaerber@suse.de
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=bbauman@redhat.com;X-NUM-GUESTS=0:mailto:bbauman@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=eric.auger@redhat.com;X-NUM-GUESTS=0:mailto:eric.auger@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=jan.kiszka@web.de;X-NUM-GUESTS=0:mailto:jan.kiszka@web.de
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=jjherne@linux.vnet.ibm.com;X-NUM-GUESTS=0:mailto:jjherne@linux.vnet
 .ibm.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=mimu@linux.vnet.ibm.com;X-NUM-GUESTS=0:mailto:mimu@linux.vnet.ibm.c
 om
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=z.huo@139.com;X-NUM-GUESTS=0:mailto:z.huo@139.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Elena Ufimtseva;X-NUM-GUESTS=0:mailto:elena.ufimtseva@oracle.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=anjo@rev.ng;X-NUM-GUESTS=0:mailto:anjo@rev.ng
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Shameerali Kolothum Thodi;X-NUM-GUESTS=0:mailto:shameerali.kolothum
 .thodi@huawei.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Chao Peng;X-NUM-GUESTS=0:mailto:chao.p.peng@linux.intel.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=qemu-devel@nongnu.org;X-NUM-GUESTS=0:mailto:qemu-devel@nongnu.org
X-MICROSOFT-CDO-OWNERAPPTID:-1130186283
CLASS:PUBLIC
CREATED:20220823T150022Z
DESCRIPTION:If you need call details\, please contact me: quintela@redhat.c
 om
LAST-MODIFIED:20240118T171529Z
LOCATION:https://meet.jit.si/kvmcallmeeting
SEQUENCE:2
STATUS:CONFIRMED
SUMMARY:QEMU developers fortnightly conference call
TRANSP:OPAQUE
END:VEVENT
END:VCALENDAR

--0000000000004ce0cb060f3b83b9--

--0000000000004ce0cd060f3b83bb
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VlRJTUVaT05FDQpUWklEOkFtZXJpY2EvTmV3X1lvcmsNClgtTElDLUxPQ0FUSU9O
OkFtZXJpY2EvTmV3X1lvcmsNCkJFR0lOOkRBWUxJR0hUDQpUWk9GRlNFVEZST006LTA1MDANClRa
T0ZGU0VUVE86LTA0MDANClRaTkFNRTpFRFQNCkRUU1RBUlQ6MTk3MDAzMDhUMDIwMDAwDQpSUlVM
RTpGUkVRPVlFQVJMWTtCWU1PTlRIPTM7QllEQVk9MlNVDQpFTkQ6REFZTElHSFQNCkJFR0lOOlNU
QU5EQVJEDQpUWk9GRlNFVEZST006LTA0MDANClRaT0ZGU0VUVE86LTA1MDANClRaTkFNRTpFU1QN
CkRUU1RBUlQ6MTk3MDExMDFUMDIwMDAwDQpSUlVMRTpGUkVRPVlFQVJMWTtCWU1PTlRIPTExO0JZ
REFZPTFTVQ0KRU5EOlNUQU5EQVJEDQpFTkQ6VlRJTUVaT05FDQpCRUdJTjpWRVZFTlQNCkRUU1RB
UlQ7VFpJRD1BbWVyaWNhL05ld19Zb3JrOjIwMjQwMTIzVDA5MDAwMA0KRFRFTkQ7VFpJRD1BbWVy
aWNhL05ld19Zb3JrOjIwMjQwMTIzVDEwMDAwMA0KUlJVTEU6RlJFUT1XRUVLTFk7V0tTVD1NTztV
TlRJTD0yMDIzMDIyMlQwNDU5NTlaO0lOVEVSVkFMPTI7QllEQVk9VFUNCkRUU1RBTVA6MjAyNDAx
MThUMTcxNTQwWg0KT1JHQU5JWkVSO0NOPUtWTSBjYWxsIGZvciBxZW11IGRldmVsb3BlcnM6bWFp
bHRvOmVnZWQ3Y2tpMDVsbXUxdG5ndmtsM3RoaWRzDQogQGdyb3VwLmNhbGVuZGFyLmdvb2dsZS5j
b20NClVJRDpubWl1cTJtMDFwajNqbmhrdDF0Z2ppMGdxM0Bnb29nbGUuY29tDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047UlNWUD0NCiBUUlVFO0NOPXF1aW50ZWxhQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFp
bHRvOnF1aW50ZWxhQHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9
UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049bWRl
YW5AcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWRlYW5AcmVkaGF0LmNvbQ0KQVRU
RU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1mZWxpcGVAbnV0YW5peC5jb207WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOmZlbGlwZUBudXRhbml4LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7
Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtD
Tj1jd0BmMDBmLm9yZztYLU5VTS1HVUVTVFM9MDptYWlsdG86Y3dAZjAwZi5vcmcNCkFUVEVOREVF
O0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFD
VElPTjtSU1ZQPQ0KIFRSVUU7Q049ZWJsYWtlQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFp
bHRvOmVibGFrZUByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWVkZ2Fy
LmlnbGVzaWFzQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZWRnYXIuaWdsZXNpYXNA
Z21haWwNCiAuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJ
UEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWlnZ3lAdGhlaWdneS5j
b207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmlnZ3lAdGhlaWdneS5jb20NCkFUVEVOREVFO0NVVFlQ
RT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtS
U1ZQPQ0KIFRSVUU7Q049amlkb25nLnhpYW9AZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0
bzpqaWRvbmcueGlhb0BnbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9
UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049cGV0
ZXIubWF5ZGVsbEBsaW5hcm8ub3JnO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpwZXRlci5tYXlkZWxs
QGxpbmFybw0KIC5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJ
Q0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049cmljaGFyZC5oZW5k
ZXJzb25AbGluYXJvLm9yZztYLU5VTS1HVUVTVFM9MDptYWlsdG86cmljaGFyZC5oZW5kZXJzbw0K
IG5AbGluYXJvLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElD
SVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1zdGVmYW5oYUBnbWFp
bC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnN0ZWZhbmhhQGdtYWlsLmNvbQ0KQVRURU5ERUU7
Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNU
SU9OO1JTVlA9DQogVFJVRTtDTj1pbXBAYnNkaW1wLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86
aW1wQGJzZGltcC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJ
Q0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049end1Lmtlcm5lbEBn
bWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnp3dS5rZXJuZWxAZ21haWwuY29tDQpBVFRF
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVE
Uy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWpnZ0BudmlkaWEuY29tO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzpqZ2dAbnZpZGlhLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEt
UEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1jamlhQG52
aWRpYS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmNqaWFAbnZpZGlhLmNvbQ0KQVRURU5ERUU7
Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNU
SU9OO1JTVlA9DQogVFJVRTtDTj1rb25yYWQud2lsa0BvcmFjbGUuY29tO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzprb25yYWQud2lsa0BvcmFjbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVF
O0NOPWFsZUByZXYubmc7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmFsZUByZXYubmcNCkFUVEVOREVF
O0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFD
VElPTjtSU1ZQPQ0KIFRSVUU7Q049d2VpLncud2FuZ0BpbnRlbC5jb207WC1OVU0tR1VFU1RTPTA6
bWFpbHRvOndlaS53LndhbmdAaW50ZWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NO
PW1idXJ0b25AcXRpLnF1YWxjb21tLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWJ1cnRvbkBx
dGkucXVhbGNvbW0NCiAuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1Q
QVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO1gtTlVNLUdVRVNU
Uz0wOm1haWx0bzpmNGJ1Z0BhbXNhdC5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JP
TEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049
Sm9hbyBNYXJ0aW5zO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqb2FvLm0ubWFydGluc0BvcmFjbGUu
Y29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJU
U1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWFmYWVyYmVyQHN1c2UuZGU7WC1OVU0t
R1VFU1RTPTA6bWFpbHRvOmFmYWVyYmVyQHN1c2UuZGUNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklE
VUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRS
VUU7Q049YmJhdW1hbkByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpiYmF1bWFuQHJl
ZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5U
O1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049ZXJpYy5hdWdlckByZWRoYXQu
Y29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzplcmljLmF1Z2VyQHJlZGhhdC5jb20NCkFUVEVOREVF
O0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFD
VElPTjtSU1ZQPQ0KIFRSVUU7Q049amFuLmtpc3prYUB3ZWIuZGU7WC1OVU0tR1VFU1RTPTA6bWFp
bHRvOmphbi5raXN6a2FAd2ViLmRlDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWpqaGVy
bmVAbGludXgudm5ldC5pYm0uY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqamhlcm5lQGxpbnV4
LnZuZXQNCiAuaWJtLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1taW11QGxpbnV4
LnZuZXQuaWJtLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWltdUBsaW51eC52bmV0LmlibS5j
DQogb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BB
UlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049ei5odW9AMTM5LmNvbTtYLU5VTS1H
VUVTVFM9MDptYWlsdG86ei5odW9AMTM5LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7
Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtD
Tj1FbGVuYSBVZmltdHNldmE7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVsZW5hLnVmaW10c2V2YUBv
cmFjbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWFuam9AcmV2Lm5nO1gtTlVN
LUdVRVNUUz0wOm1haWx0bzphbmpvQHJldi5uZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7
Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtD
Tj1TaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpzaGFtZWVy
YWxpLmtvbG90aHVtDQogLnRob2RpQGh1YXdlaS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklE
VUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRS
VUU7Q049Q2hhbyBQZW5nO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpjaGFvLnAucGVuZ0BsaW51eC5p
bnRlbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5U
O1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049cWVtdS1kZXZlbEBub25nbnUu
b3JnO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpxZW11LWRldmVsQG5vbmdudS5vcmcNClgtTUlDUk9T
T0ZULUNETy1PV05FUkFQUFRJRDotMTEzMDE4NjI4Mw0KQ0xBU1M6UFVCTElDDQpDUkVBVEVEOjIw
MjIwODIzVDE1MDAyMloNCkRFU0NSSVBUSU9OOklmIHlvdSBuZWVkIGNhbGwgZGV0YWlsc1wsIHBs
ZWFzZSBjb250YWN0IG1lOiBxdWludGVsYUByZWRoYXQuYw0KIG9tDQpMQVNULU1PRElGSUVEOjIw
MjQwMTE4VDE3MTUyOVoNCkxPQ0FUSU9OOmh0dHBzOi8vbWVldC5qaXQuc2kva3ZtY2FsbG1lZXRp
bmcNClNFUVVFTkNFOjINClNUQVRVUzpDT05GSVJNRUQNClNVTU1BUlk6UUVNVSBkZXZlbG9wZXJz
IGZvcnRuaWdodGx5IGNvbmZlcmVuY2UgY2FsbA0KVFJBTlNQOk9QQVFVRQ0KRU5EOlZFVkVOVA0K
RU5EOlZDQUxFTkRBUg0K
--0000000000004ce0cd060f3b83bb--

