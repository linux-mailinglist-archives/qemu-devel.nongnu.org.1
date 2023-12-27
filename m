Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3307981EFE4
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 16:50:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIWAB-00034y-DU; Wed, 27 Dec 2023 10:49:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1rIWA8-00034f-4T
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 10:49:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1rIWA2-0000g1-AA
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 10:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703692171;
 h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type; bh=G1S7/ileLiyjGTk01c6OIolkuG7L6U3lDW43KQFRHYQ=;
 b=JLOf9IjsU6S1AYV3O6B1LI4kcqCubT/DODMvemU55GXTJ4X3wo8QmWHD4JyMQGnDm8BdZt
 U245QXbqVHCZ6zqXj4wOPz/zSibHf/bSp9D3V6vAv14qTGsvGwc4qrK2ZmcqK/hx6LKOj3
 n5rvVydL3T7nLNyeoytYQWCBKNx0BeM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-Y5ItJYs4PUWV89zNzD6DMw-1; Wed, 27 Dec 2023 10:49:28 -0500
X-MC-Unique: Y5ItJYs4PUWV89zNzD6DMw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50e032e0012so3850596e87.2
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 07:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1703692167; x=1704296967; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G1S7/ileLiyjGTk01c6OIolkuG7L6U3lDW43KQFRHYQ=;
 b=F4v+yjOBK5rkmKgpC8GoUTal2VWJIgTcoquMP7WcQ+TnhXcv+FeRbw4hPXzVByEueL
 EUSAo+peZhhv+rq7X/DsFwjlsHjQ/kKi1I3AsHTP3D2bMmQ/UpX2KPoRRhNEyMBL80zO
 uKhcc1sD8asCWhD8aa7YpMRXVsE1hRzQw4kkd85GPAHG8Rz3mOigYoyAnmHqsEFCbd3i
 C7FzbCVSU9BVFx+1HrkHe2AAgkSDR1s9ZWauE6xVVfalErHhsPsgpAUrclHol+3dWCPM
 hbZGI0twFgM0JxvloYp7lhL3e6XKegP8QKcF87vUMEIpMgXRxmJ37+pnCXQMEeTYq8rh
 I4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703692167; x=1704296967;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G1S7/ileLiyjGTk01c6OIolkuG7L6U3lDW43KQFRHYQ=;
 b=jyOwd//YbGpn3wPp3qgyVcvv0feuA/NqRWo+rAnBgeuDgsoAEl4p3pmPXQ3wNmj7v4
 tcSxSgP3pM+czuapHaJE1XIQWIxZ87xbhXF3ttpQZyZd1I1UyZA8kUdFFPSPeC19eH/M
 hM6jOYtdZHsXX4z+KSG4Qc2TIgFS64jPy5emKeLFIGR4XJ3pB/Kg+SjNztPxgN83jC7V
 fVOWJ97e72IDgdt9LPpIuTfDgVIZk8KcOIwwqpgbTsnYtqtuSW5jgkuo7wp0LxvIW5Xg
 Ip3F6GdiSHnEwXZCM8yrRc0ARkRIfWc5QCPdcOdOmq37jGsCvAtMMIWwfbTVRX4Ftkbn
 kw6w==
X-Gm-Message-State: AOJu0YwPQN7sR0h9sV4USFI9FtHAyOwWIn2jzBeNzSw8AtBAfd+ZlIS+
 sR98eIiqY9gB21ONtSWd1wQvwftB2nsPIQ3Wk+ddwdqq8upKtLFHmg/OI+RMCgdGxTXD5Rj/LNf
 Z7WIOQ3yBHWq6HCc5gpThhqBQ56sxMUOjzD0Ncq+8rD51y6u+W9CaXkP+aReM7kzk6UI+GQWl2e
 IgJXlIvLMj3klWN43mUBnaK5+z818=
X-Received: by 2002:a05:6512:23a2:b0:50e:385f:2041 with SMTP id
 c34-20020a05651223a200b0050e385f2041mr3102156lfv.72.1703692167153; 
 Wed, 27 Dec 2023 07:49:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqSgoU0M9FZGcIJob1Eo28EOuXvDVak/hqxeHYfDztkIQj1UUhv8jFZKuSYeSeKDR7F4G00+AKOvgMeoWwz0Tl
MIME-Version: 1.0
X-Received: by 2002:a05:6512:23a2:b0:50e:385f:2041 with SMTP id
 c34-20020a05651223a200b0050e385f2041mr3102152lfv.72.1703692166855; Wed, 27
 Dec 2023 07:49:26 -0800 (PST)
Auto-Submitted: auto-generated
Message-ID: <calendar-cce52706-97e0-4b1a-89eb-7cb4df068031@google.com>
Date: Wed, 27 Dec 2023 15:49:26 +0000
Subject: Updated invitation: QEMU developers fortnightly conference call @
 Every 2 weeks from 15:00 to 16:00 on Tuesday (CEST) (qemu-devel@nongnu.org)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, 
 Joao Martins <joao.m.martins@oracle.com>, Meirav Dean <mdean@redhat.com>,
 felipe@nutanix.com, afaerber@suse.de, bbauman@redhat.com, cw@f00f.org, 
 Eric Blake <eblake@redhat.com>, edgar.iglesias@gmail.com, eric.auger@redhat.com,
 iggy@theiggy.com, jan.kiszka@web.de, jidong.xiao@gmail.com, 
 jjherne@linux.vnet.ibm.com, mimu@linux.vnet.ibm.com, peter.maydell@linaro.org, 
 richard.henderson@linaro.org, stefanha@gmail.com, imp@bsdimp.com, 
 z.huo@139.com, zwu.kernel@gmail.com, jgg@nvidia.com, cjia@nvidia.com, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, konrad.wilk@oracle.com,
 ale@rev.ng, 
 anjo@rev.ng, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 wei.w.wang@intel.com, 
 Chao Peng <chao.p.peng@linux.intel.com>, mburton@qti.qualcomm.com
Content-Type: multipart/mixed; boundary="000000000000699598060d7fbecf"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.755,
 DKIMWL_WL_MED=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--000000000000699598060d7fbecf
Content-Type: multipart/alternative; boundary="000000000000699597060d7fbecd"

--000000000000699597060d7fbecd
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBldmVudCBoYXMgYmVlbiB1cGRhdGVkDQoNClFFTVUgZGV2ZWxvcGVycyBmb3J0bmlnaHRs
eSBjb25mZXJlbmNlIGNhbGwNCkV2ZXJ5IDIgd2Vla3MgZnJvbSAxNTowMCB0byAxNjowMCBvbiBU
dWVzZGF5DQpDZW50cmFsIEV1cm9wZWFuIFRpbWUgLSBNYWRyaWQNCg0KTG9jYXRpb24NCmh0dHBz
Oi8vbWVldC5qaXQuc2kva3ZtY2FsbG1lZXRpbmcJDQpodHRwczovL3d3dy5nb29nbGUuY29tL3Vy
bD9xPWh0dHBzJTNBJTJGJTJGbWVldC5qaXQuc2klMkZrdm1jYWxsbWVldGluZyZzYT1EJnVzdD0x
NzA0MTI0MTQwMDAwMDAwJnVzZz1BT3ZWYXcwYk5Ud3FoLW93SkcwenZIMWVGZnpFDQoNCg0KDQpJ
ZiB5b3UgbmVlZCBjYWxsIGRldGFpbHMsIHBsZWFzZSBjb250YWN0IG1lOiBxdWludGVsYUByZWRo
YXQuY29tDQoNCkd1ZXN0cw0KUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kNCkpvYW8gTWFydGlucw0K
SnVhbiBRdWludGVsYQ0KTWVpcmF2IERlYW4NCmZlbGlwZUBudXRhbml4LmNvbQ0KYWZhZXJiZXJA
c3VzZS5kZQ0KYmJhdW1hbkByZWRoYXQuY29tDQpjd0BmMDBmLm9yZw0KRXJpYyBCbGFrZQ0KZWRn
YXIuaWdsZXNpYXNAZ21haWwuY29tDQplcmljLmF1Z2VyQHJlZGhhdC5jb20NCmlnZ3lAdGhlaWdn
eS5jb20NCmphbi5raXN6a2FAd2ViLmRlDQpqaWRvbmcueGlhb0BnbWFpbC5jb20NCmpqaGVybmVA
bGludXgudm5ldC5pYm0uY29tDQptaW11QGxpbnV4LnZuZXQuaWJtLmNvbQ0KcGV0ZXIubWF5ZGVs
bEBsaW5hcm8ub3JnDQpyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnDQpzdGVmYW5oYUBnbWFp
bC5jb20NCmltcEBic2RpbXAuY29tDQp6Lmh1b0AxMzkuY29tDQp6d3Uua2VybmVsQGdtYWlsLmNv
bQ0KamdnQG52aWRpYS5jb20NCmNqaWFAbnZpZGlhLmNvbQ0KRWxlbmEgVWZpbXRzZXZhDQprb25y
YWQud2lsa0BvcmFjbGUuY29tDQphbGVAcmV2Lm5nDQphbmpvQHJldi5uZw0KU2hhbWVlcmFsaSBL
b2xvdGh1bSBUaG9kaQ0Kd2VpLncud2FuZ0BpbnRlbC5jb20NCkNoYW8gUGVuZw0KcWVtdS1kZXZl
bEBub25nbnUub3JnDQptYnVydG9uQHF0aS5xdWFsY29tbS5jb20NClZpZXcgYWxsIGd1ZXN0IGlu
Zm8gIA0KaHR0cHM6Ly9jYWxlbmRhci5nb29nbGUuY29tL2NhbGVuZGFyL2V2ZW50P2FjdGlvbj1W
SUVXJmVpZD1OV1IwTldwcE9EZHFOWEZ5WXpBd2J6WXphM1J4TjJkb2IzVWdjV1Z0ZFMxa1pYWmxi
RUJ1YjI1bmJuVXViM0puJnRvaz1OVElqWldkbFpEZGphMmt3Tld4dGRURjBibWQyYTJ3emRHaHBa
SE5BWjNKdmRYQXVZMkZzWlc1a1lYSXVaMjl2WjJ4bExtTnZiVGxoWldJMk9XWTBNbUUwWlRBM05q
UXpPR014T1dSaE5tTTNOREZtWkRjeFpUZzFObUV5WkdZJmN0ej1FdXJvcGUlMkZNYWRyaWQmaGw9
ZW4mZXM9MA0KDQpSZXBseSBmb3IgcWVtdS1kZXZlbEBub25nbnUub3JnIGFuZCB2aWV3IG1vcmUg
ZGV0YWlscyAgDQpodHRwczovL2NhbGVuZGFyLmdvb2dsZS5jb20vY2FsZW5kYXIvZXZlbnQ/YWN0
aW9uPVZJRVcmZWlkPU5XUjBOV3BwT0RkcU5YRnlZekF3YnpZemEzUnhOMmRvYjNVZ2NXVnRkUzFr
WlhabGJFQnViMjVuYm5VdWIzSm4mdG9rPU5USWpaV2RsWkRkamEya3dOV3h0ZFRGMGJtZDJhMnd6
ZEdocFpITkFaM0p2ZFhBdVkyRnNaVzVrWVhJdVoyOXZaMnhsTG1OdmJUbGhaV0kyT1dZME1tRTBa
VEEzTmpRek9HTXhPV1JoTm1NM05ERm1aRGN4WlRnMU5tRXlaR1kmY3R6PUV1cm9wZSUyRk1hZHJp
ZCZobD1lbiZlcz0wDQpZb3VyIGF0dGVuZGFuY2UgaXMgb3B0aW9uYWwuDQoNCn5+Ly9+fg0KSW52
aXRhdGlvbiBmcm9tIEdvb2dsZSBDYWxlbmRhcjogaHR0cHM6Ly9jYWxlbmRhci5nb29nbGUuY29t
L2NhbGVuZGFyLw0KDQpZb3UgYXJlIHJlY2VpdmluZyB0aGlzIGVtYWlsIGJlY2F1c2UgeW91IGFy
ZSBhbiBhdHRlbmRlZSBvbiB0aGUgZXZlbnQuIFRvICANCnN0b3AgcmVjZWl2aW5nIGZ1dHVyZSB1
cGRhdGVzIGZvciB0aGlzIGV2ZW50LCBkZWNsaW5lIHRoaXMgZXZlbnQuDQoNCkZvcndhcmRpbmcg
dGhpcyBpbnZpdGF0aW9uIGNvdWxkIGFsbG93IGFueSByZWNpcGllbnQgdG8gc2VuZCBhIHJlc3Bv
bnNlIHRvICANCnRoZSBvcmdhbml6ZXIsIGJlIGFkZGVkIHRvIHRoZSBndWVzdCBsaXN0LCBpbnZp
dGUgb3RoZXJzIHJlZ2FyZGxlc3Mgb2YgIA0KdGhlaXIgb3duIGludml0YXRpb24gc3RhdHVzLCBv
ciBtb2RpZnkgeW91ciBSU1ZQLg0KDQpMZWFybiBtb3JlIGh0dHBzOi8vc3VwcG9ydC5nb29nbGUu
Y29tL2NhbGVuZGFyL2Fuc3dlci8zNzEzNSNmb3J3YXJkaW5nDQo=
--000000000000699597060d7fbecd
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
"/></span><meta itemprop=3D"eventId/googleCalendar" content=3D"5dt5ji87j5qr=
c00o63ktq7ghou"/><span style=3D"display: none; font-size: 1px; color: #fff;=
 line-height: 1px; height: 0; max-height: 0; width: 0; max-width: 0; opacit=
y: 0; overflow: hidden;" itemprop=3D"name">QEMU developers fortnightly conf=
erence call</span><meta itemprop=3D"url" content=3D"https://calendar.google=
.com/calendar/event?action=3DVIEW&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2d=
ob3UgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2w=
zdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTlhZWI2OWY0MmE0ZTA3NjQzOGMxOWRhNm=
M3NDFmZDcxZTg1NmEyZGY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0"/><s=
pan aria-hidden=3D"true"><time itemprop=3D"startDate" datetime=3D"20220823T=
130000Z"></time><time itemprop=3D"endDate" datetime=3D"20220823T140000Z"></=
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
le=3D"font-weight: 700;">This event has been updated</span></td></tr></tbod=
y></table><!--[if mso | IE]><table border=3D"0" cellpadding=3D"0" cellspaci=
ng=3D"0" role=3D"presentation"><tr><td height=3D"12" style=3D"height:12px;"=
><![endif]--><div style=3D"height:12px;" aria-hidden=3D"true"> &nbsp; </div=
><!--[if mso | IE]></td></tr></table><![endif]--><table border=3D"0" cellpa=
dding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"center" style=
=3D"width:100%;" class=3D""><tbody><tr><td style=3D"border: solid 1px #dadc=
e0; border-radius: 8px; direction: rtl; font-size: 0; padding: 24px 32px; t=
ext-align: left; vertical-align: top;" class=3D"main-container-inner"><!--[=
if mso | IE]><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation"><tr><![endif]--><div class=3D"" style=3D"font-size: 13px;=
 text-align: left; direction: ltr; display: inline-block; vertical-align: t=
op; width: 100%;overflow: hidden; word-wrap: break-word;"><table border=3D"=
0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"100%"=
 class=3D"main-column-table-ltr" style=3D"padding-right: 32px; padding-left=
: 0;;table-layout: fixed;"><tbody><tr><td class=3D"main-column-td" style=3D=
"padding:0; vertical-align:top;"><table border=3D"0" cellpadding=3D"0" cell=
spacing=3D"0" role=3D"presentation" width=3D"100%" style=3D"table-layout: f=
ixed;"><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-br=
eak: break-word;;padding-bottom:24px;"><div style=3D"font-family: Roboto, s=
ans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-heigh=
t: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" clas=
s=3D"primary-text" role=3D"presentation"><span>If you need call details, pl=
ease contact me: <a href=3D"mailto:quintela@redhat.com" target=3D"_blank">q=
uintela@redhat.com</a></span><meta itemprop=3D"description" content=3D"If y=
ou need call details, please contact me: quintela@redhat.com"/></div></td><=
/tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-break=
: break-word;;padding-bottom:24px;"><div style=3D"font-family: Roboto, sans=
-serif;font-style: normal; font-weight: 400; font-size: 14px; line-height: =
20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" class=
=3D"primary-text" role=3D"presentation"><span aria-hidden=3D"true"><time it=
emprop=3D"startDate" datetime=3D"20220823T130000Z"></time><time itemprop=3D=
"endDate" datetime=3D"20220823T140000Z"></time></span><table border=3D"0" c=
ellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-b=
ottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;co=
lor: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoothing=
: antialiased;margin: 0; padding: 0;">When</h2></td></tr></table><span>Ever=
y 2 weeks from 15:00 to 16:00 on Tuesday (Central European Time - Madrid)</=
span></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align:=
 left; word-break: break-word;;padding-bottom:24px;"><div style=3D"font-fam=
ily: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14=
px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoratio=
n: none;" class=3D"primary-text" role=3D"presentation"><table border=3D"0" =
cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-=
bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;c=
olor: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoothin=
g: antialiased;margin: 0; padding: 0;">Location</h2></td></tr></table><span=
 itemprop=3D"location" itemscope itemtype=3D"http://schema.org/Place"><span=
 itemprop=3D"name" class=3D"primary-text notranslate" style=3D"font-family:=
 Roboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; =
line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: n=
one;">https://meet.jit.si/kvmcallmeeting</span><br/><a href=3D"https://www.=
google.com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=3DD&am=
p;ust=3D1704124140000000&amp;usg=3DAOvVaw0bNTwqh-owJG0zvH1eFfzE" class=3D"a=
ccent-text underline-on-hover" style=3D"display: inline-block;;color: #1a73=
e8; text-decoration: none;font-weight: 700;" target=3D"_blank" itemprop=3D"=
map">View map</a></span></div></td></tr><tr><td style=3D"font-size: 0; padd=
ing: 0; text-align: left; word-break: break-word;;padding-bottom:24px;"><di=
v style=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight:=
 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4=
043; text-decoration: none;" class=3D"primary-text" role=3D"presentation"><=
table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation=
" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=
=3D"font-size: 14px;color: #3c4043; text-decoration: none;font-weight: 700;=
-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">Guests</h2></td=
></tr></table><div style=3D"padding-bottom: 4px; text-align: left;;color: #=
3c4042;"><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sche=
ma.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pr=
imary-text underline-on-hover" style=3D"display: inline-block;;color: #3c40=
43; text-decoration: none;" href=3D"mailto:f4bug@amsat.org">Philippe Mathie=
u-Daud=C3=A9</a></span><meta itemprop=3D"email" content=3D"f4bug@amsat.org"=
/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decor=
ation: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemt=
ype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransla=
te"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-b=
lock;;color: #3c4043; text-decoration: none;" href=3D"mailto:joao.m.martins=
@oracle.com">Joao Martins</a></span><meta itemprop=3D"email" content=3D"joa=
o.m.martins@oracle.com"/></span><span class=3D"secondary-text" style=3D"col=
or: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"at=
tendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"n=
ame" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" sty=
le=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:quintela@redhat.com">Juan Quintela</a></span><meta itemprop=3D"e=
mail" content=3D"quintela@redhat.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:mdean@redhat.com">Meirav Dean</a></span><meta itempr=
op=3D"email" content=3D"mdean@redhat.com"/></span><span class=3D"secondary-=
text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><s=
pan itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><=
span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text under=
line-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorat=
ion: none;" href=3D"mailto:felipe@nutanix.com">felipe@nutanix.com</a></span=
><meta itemprop=3D"email" content=3D"felipe@nutanix.com"/></span><span clas=
s=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></spa=
n></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schem=
a.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pri=
mary-text underline-on-hover" style=3D"display: inline-block;;color: #3c404=
3; text-decoration: none;" href=3D"mailto:afaerber@suse.de">afaerber@suse.d=
e</a></span><meta itemprop=3D"email" content=3D"afaerber@suse.de"/></span><=
span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: non=
e;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"htt=
p://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cla=
ss=3D"primary-text underline-on-hover" style=3D"display: inline-block;;colo=
r: #3c4043; text-decoration: none;" href=3D"mailto:bbauman@redhat.com">bbau=
man@redhat.com</a></span><meta itemprop=3D"email" content=3D"bbauman@redhat=
.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-=
decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope =
itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notr=
anslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inl=
ine-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:cw@f00f.o=
rg">cw@f00f.org</a></span><meta itemprop=3D"email" content=3D"cw@f00f.org"/=
></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decora=
tion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemty=
pe=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslat=
e"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bl=
ock;;color: #3c4043; text-decoration: none;" href=3D"mailto:eblake@redhat.c=
om">Eric Blake</a></span><meta itemprop=3D"email" content=3D"eblake@redhat.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:edgar.igle=
sias@gmail.com">edgar.iglesias@gmail.com</a></span><meta itemprop=3D"email"=
 content=3D"edgar.iglesias@gmail.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:eric.auger@redhat.com">eric.auger@redhat.com</a></sp=
an><meta itemprop=3D"email" content=3D"eric.auger@redhat.com"/></span><span=
 class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;">=
</span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://=
schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:iggy@theiggy.com">iggy@the=
iggy.com</a></span><meta itemprop=3D"email" content=3D"iggy@theiggy.com"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:jan.kiszka@web.de=
">jan.kiszka@web.de</a></span><meta itemprop=3D"email" content=3D"jan.kiszk=
a@web.de"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:jidon=
g.xiao@gmail.com">jidong.xiao@gmail.com</a></span><meta itemprop=3D"email" =
content=3D"jidong.xiao@gmail.com"/></span><span class=3D"secondary-text" st=
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
xt-decoration: none;" href=3D"mailto:z.huo@139.com">z.huo@139.com</a></span=
><meta itemprop=3D"email" content=3D"z.huo@139.com"/></span><span class=3D"=
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
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:elena.uf=
imtseva@oracle.com">Elena Ufimtseva</a></span><meta itemprop=3D"email" cont=
ent=3D"elena.ufimtseva@oracle.com"/></span><span class=3D"secondary-text" s=
tyle=3D"color: #70757a; text-decoration: none;"></span></div><div><span ite=
mprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span it=
emprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on=
-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: no=
ne;" href=3D"mailto:konrad.wilk@oracle.com">konrad.wilk@oracle.com</a></spa=
n><meta itemprop=3D"email" content=3D"konrad.wilk@oracle.com"/></span><span=
 class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;">=
</span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://=
schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
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
;" href=3D"mailto:wei.w.wang@intel.com">wei.w.wang@intel.com</a></span><met=
a itemprop=3D"email" content=3D"wei.w.wang@intel.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:chao.p.peng@linux.intel.com">Chao =
Peng</a></span><meta itemprop=3D"email" content=3D"chao.p.peng@linux.intel.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:qemu-devel=
@nongnu.org">qemu-devel@nongnu.org</a></span><meta itemprop=3D"email" conte=
nt=3D"qemu-devel@nongnu.org"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:mburton@qti.qualcomm.com">mburton@qti.qualcomm.com</a></spa=
n><meta itemprop=3D"email" content=3D"mburton@qti.qualcomm.com"/></span><sp=
an class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;=
"></span></div></div><a href=3D"https://calendar.google.com/calendar/event?=
action=3DVIEW&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3UgcWVtdS1kZXZlbEB=
ub25nbnUub3Jn&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2F=
sZW5kYXIuZ29vZ2xlLmNvbTlhZWI2OWY0MmE0ZTA3NjQzOGMxOWRhNmM3NDFmZDcxZTg1NmEyZG=
Y&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" style=3D"display: inlin=
e-block;;color: #1a73e8; text-decoration: none;font-weight: 700;" target=3D=
"_blank" class=3D"accent-text underline-on-hover">View all guest info</a></=
div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; =
word-break: break-word;;padding-bottom:0px;"><div style=3D"color: #3c4043; =
text-decoration: none;;font-family: Roboto, sans-serif;font-size: 14px; lin=
e-height: 20px; mso-line-height-rule: exactly; text-align: left;" class=3D"=
primary-text"><div><span style=3D"font-weight: 700;-webkit-font-smoothing: =
antialiased;">RSVP</span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"> for <a class=3D"secondary-text underline-on-=
hover" style=3D"display: inline-block;;color: #70757a; text-decoration: non=
e;" href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a> for all=
 events in this series</span></div></div></td></tr><tr><td style=3D"font-si=
ze: 0; padding: 0; text-align: left; word-break: break-word;;padding-bottom=
:16px;"><div style=3D"font-family: Roboto, sans-serif;font-size: 14px; line=
-height: 20px; mso-line-height-rule: exactly; text-align: left;"><table bor=
der=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=
=3D"border-collapse: separate;"><tr><td style=3D"padding-top: 8px; padding-=
left: 0; padding-right: 12px;"><!-- RSVP buttons --><table border=3D"0" cel=
lpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"border: sol=
id 1px #dadce0; border-radius: 16px; border-collapse: separate;font-family:=
 &#39;Google Sans&#39;, Roboto, sans-serif;;display: inline-block;;margin-r=
ight: 12px; margin-left: 0;"><tr><td align=3D"center" vertical-align=3D"mid=
dle" role=3D"presentation"><span itemprop=3D"potentialaction" itemscope ite=
mtype=3D"http://schema.org/RsvpAction"><meta itemprop=3D"attendance" conten=
t=3D"http://schema.org/RsvpAttendance/Yes"/><span itemprop=3D"handler" item=
scope itemtype=3D"http://schema.org/HttpActionHandler"><link itemprop=3D"me=
thod" href=3D"http://schema.org/HttpRequestMethod/GET"/><span style=3D"colo=
r: #5f6367;"><a href=3D"https://calendar.google.com/calendar/event?action=
=3DRESPOND&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3UgcWVtdS1kZXZlbEBub2=
5nbnUub3Jn&amp;rst=3D1&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3=
JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTlhZWI2OWY0MmE0ZTA3NjQzOGMxOWRhNmM3NDFmZDcxZ=
Tg1NmEyZGY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" style=3D"font-=
weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #=
5f6368; font-size: 14px; line-height: 120%; mso-line-height-rule: exactly; =
margin: 0; text-decoration: none; text-transform: none;" class=3D"grey-butt=
on-text" itemprop=3D"url" target=3D"_blank"><table border=3D"0" cellpadding=
=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><td align=3D"center" rol=
e=3D"presentation" valign=3D"middle" style=3D"padding: 6px 0; padding-left:=
 16px; padding-right: 12px; white-space: nowrap;"><!--[if mso]><a href=3D"h=
ttps://calendar.google.com/calendar/event?action=3DRESPOND&amp;eid=3DNWR0NW=
ppODdqNXFyYzAwbzYza3RxN2dob3UgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;rst=3D1&amp;=
tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlL=
mNvbTlhZWI2OWY0MmE0ZTA3NjQzOGMxOWRhNmM3NDFmZDcxZTg1NmEyZGY&amp;ctz=3DEurope=
%2FMadrid&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-text" itemprop=3D"ur=
l" target=3D"_blank"><![endif]--><span class=3D"grey-button-text" style=3D"=
font-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;col=
or: #5f6368; font-size: 14px; line-height: 120%; mso-line-height-rule: exac=
tly; margin: 0; text-decoration: none; text-transform: none;">Yes</span><!-=
-[if mso]></a><![endif]--></td></tr></table></a></span></span></span></td><=
td align=3D"center" vertical-align=3D"middle" role=3D"presentation" style=
=3D"border-left: solid 1px #dadce0; border-right: solid 1px #dadce0;"><span=
 itemprop=3D"potentialaction" itemscope itemtype=3D"http://schema.org/RsvpA=
ction"><meta itemprop=3D"attendance" content=3D"http://schema.org/RsvpAtten=
dance/No"/><span itemprop=3D"handler" itemscope itemtype=3D"http://schema.o=
rg/HttpActionHandler"><link itemprop=3D"method" href=3D"http://schema.org/H=
ttpRequestMethod/GET"/><span style=3D"color: #5f6367;"><a href=3D"https://c=
alendar.google.com/calendar/event?action=3DRESPOND&amp;eid=3DNWR0NWppODdqNX=
FyYzAwbzYza3RxN2dob3UgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;rst=3D2&amp;tok=3DNT=
IjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTlhZ=
WI2OWY0MmE0ZTA3NjQzOGMxOWRhNmM3NDFmZDcxZTg1NmEyZGY&amp;ctz=3DEurope%2FMadri=
d&amp;hl=3Den&amp;es=3D0" style=3D"font-weight: 400;font-family: &#39;Googl=
e Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-heigh=
t: 120%; mso-line-height-rule: exactly; margin: 0; text-decoration: none; t=
ext-transform: none;" class=3D"grey-button-text" itemprop=3D"url" target=3D=
"_blank"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"pr=
esentation"><tr><td align=3D"center" role=3D"presentation" valign=3D"middle=
" style=3D"padding: 6px 12px; white-space: nowrap;"><!--[if mso]><a href=3D=
"https://calendar.google.com/calendar/event?action=3DRESPOND&amp;eid=3DNWR0=
NWppODdqNXFyYzAwbzYza3RxN2dob3UgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;rst=3D2&am=
p;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2x=
lLmNvbTlhZWI2OWY0MmE0ZTA3NjQzOGMxOWRhNmM3NDFmZDcxZTg1NmEyZGY&amp;ctz=3DEuro=
pe%2FMadrid&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-text" itemprop=3D"=
url" target=3D"_blank"><![endif]--><span class=3D"grey-button-text" style=
=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif=
;color: #5f6368; font-size: 14px; line-height: 120%; mso-line-height-rule: =
exactly; margin: 0; text-decoration: none; text-transform: none;">No</span>=
<!--[if mso]></a><![endif]--></td></tr></table></a></span></span></span></t=
d><td align=3D"center" vertical-align=3D"middle" role=3D"presentation"><spa=
n itemprop=3D"potentialaction" itemscope itemtype=3D"http://schema.org/Rsvp=
Action"><meta itemprop=3D"attendance" content=3D"http://schema.org/RsvpAtte=
ndance/Maybe"/><span itemprop=3D"handler" itemscope itemtype=3D"http://sche=
ma.org/HttpActionHandler"><link itemprop=3D"method" href=3D"http://schema.o=
rg/HttpRequestMethod/GET"/><span style=3D"color: #5f6367;"><a href=3D"https=
://calendar.google.com/calendar/event?action=3DRESPOND&amp;eid=3DNWR0NWppOD=
dqNXFyYzAwbzYza3RxN2dob3UgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;rst=3D3&amp;tok=
=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNv=
bTlhZWI2OWY0MmE0ZTA3NjQzOGMxOWRhNmM3NDFmZDcxZTg1NmEyZGY&amp;ctz=3DEurope%2F=
Madrid&amp;hl=3Den&amp;es=3D0" style=3D"font-weight: 400;font-family: &#39;=
Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-=
height: 120%; mso-line-height-rule: exactly; margin: 0; text-decoration: no=
ne; text-transform: none;" class=3D"grey-button-text" itemprop=3D"url" targ=
et=3D"_blank"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation"><tr><td align=3D"center" role=3D"presentation" valign=3D"=
middle" style=3D"padding: 6px 0; padding-left: 12px; padding-right: 16px; w=
hite-space: nowrap;"><!--[if mso]><a href=3D"https://calendar.google.com/ca=
lendar/event?action=3DRESPOND&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3U=
gcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;rst=3D3&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF=
0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTlhZWI2OWY0MmE0ZTA3NjQzOG=
MxOWRhNmM3NDFmZDcxZTg1NmEyZGY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=
=3D0" class=3D"grey-button-text" itemprop=3D"url" target=3D"_blank"><![endi=
f]--><span class=3D"grey-button-text" style=3D"font-weight: 400;font-family=
: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px=
; line-height: 120%; mso-line-height-rule: exactly; margin: 0; text-decorat=
ion: none; text-transform: none;">Maybe</span><!--[if mso]></a><![endif]-->=
</td></tr></table></a></span></span></span></td></tr></table><!-- More opti=
ons --><a href=3D"https://calendar.google.com/calendar/event?action=3DVIEW&=
amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3UgcWVtdS1kZXZlbEBub25nbnUub3Jn&=
amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ=
2xlLmNvbTlhZWI2OWY0MmE0ZTA3NjQzOGMxOWRhNmM3NDFmZDcxZTg1NmEyZGY&amp;ctz=3DEu=
rope%2FMadrid&amp;hl=3Den&amp;es=3D0" style=3D"display: inline-block;;font-=
weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #=
5f6368; font-size: 14px; line-height: 120%; mso-line-height-rule: exactly; =
margin: 0; text-decoration: none; text-transform: none;" class=3D"grey-butt=
on-text" target=3D"_blank"><table border=3D"0" cellpadding=3D"0" cellspacin=
g=3D"0" role=3D"presentation" style=3D"border: solid 1px #dadce0; border-ra=
dius: 16px; border-collapse: separate;font-family: &#39;Google Sans&#39;, R=
oboto, sans-serif;"><tr><td align=3D"center" vertical-align=3D"middle" role=
=3D"presentation" style=3D"padding: 6px 0; padding-left: 16px; padding-righ=
t: 12px; white-space: nowrap;;color: #5f6367;"><!--[if mso]><a href=3D"http=
s://calendar.google.com/calendar/event?action=3DVIEW&amp;eid=3DNWR0NWppODdq=
NXFyYzAwbzYza3RxN2dob3UgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;tok=3DNTIjZWdlZDdj=
a2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTlhZWI2OWY0MmE=
0ZTA3NjQzOGMxOWRhNmM3NDFmZDcxZTg1NmEyZGY&amp;ctz=3DEurope%2FMadrid&amp;hl=
=3Den&amp;es=3D0" class=3D"grey-button-text" target=3D"_blank"><![endif]-->=
<span class=3D"grey-button-text" style=3D"font-weight: 400;font-family: &#3=
9;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; lin=
e-height: 120%; mso-line-height-rule: exactly; margin: 0; text-decoration: =
none; text-transform: none;">More options</span><!--[if mso]></a><![endif]-=
-></td></tr></table></a></td></tr></table></div></td></tr></table></td></tr=
></tbody></table></div><!--[if mso | IE]></tr></table><![endif]--></td></tr=
></tbody></table><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" ro=
le=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D""><tbod=
y><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-break: =
break-word;;padding:4px 12px;" class=3D"" align=3D"left"><div class=3D"seco=
ndary-text" style=3D"color: #70757a; text-decoration: none;font-family: Rob=
oto, sans-serif;font-size: 12px; line-height: 16px; mso-line-height-rule: e=
xactly; text-align: left;"><p>Invitation from <a href=3D"https://calendar.g=
oogle.com/calendar/" class=3D"accent-text underline-on-hover" style=3D"font=
-family: Roboto, sans-serif;font-size: 12px; line-height: 16px; mso-line-he=
ight-rule: exactly;;color: #1a73e8; text-decoration: none;" target=3D"_blan=
k">Google Calendar</a></p><p>You are receiving this email because you are a=
n attendee on the event. To stop receiving future updates for this event, d=
ecline this event.</p><p>Forwarding this invitation could allow any recipie=
nt to send a response to the organizer, be added to the guest list, invite =
others regardless of their own invitation status, or modify your RSVP. <a c=
lass=3D"accent-text underline-on-hover" style=3D"font-family: Roboto, sans-=
serif;font-size: 12px; line-height: 16px; mso-line-height-rule: exactly;;co=
lor: #1a73e8; text-decoration: none;" href=3D"https://support.google.com/ca=
lendar/answer/37135#forwarding">Learn more</a></p></div></td></tr></tbody><=
/table></td></tr></tbody></table></span></span></body></html>
--000000000000699597060d7fbecd
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
DTSTART;TZID=America/New_York:20220823T090000
DTEND;TZID=America/New_York:20220823T100000
RRULE:FREQ=WEEKLY;WKST=MO;UNTIL=20240109T045959Z;INTERVAL=2;BYDAY=TU
DTSTAMP:20231227T154926Z
ORGANIZER;CN=KVM call for qemu developers:mailto:eged7cki05lmu1tngvkl3thids
 @group.calendar.google.com
UID:5dt5ji87j5qrc00o63ktq7ghou@google.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;X-NUM-GUESTS=0:mailto:f4bug@amsat.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Joao Martins;X-NUM-GUESTS=0:mailto:joao.m.martins@oracle.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE
 ;CN=Juan Quintela;X-NUM-GUESTS=0:mailto:quintela@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Meirav Dean;X-NUM-GUESTS=0:mailto:mdean@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=felipe@nutanix.com;X-NUM-GUESTS=0:mailto:felipe@nutanix.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=afaerber@suse.de;X-NUM-GUESTS=0:mailto:afaerber@suse.de
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=bbauman@redhat.com;X-NUM-GUESTS=0:mailto:bbauman@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=cw@f00f.org;X-NUM-GUESTS=0:mailto:cw@f00f.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Eric Blake;X-NUM-GUESTS=0:mailto:eblake@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=edgar.iglesias@gmail.com;X-NUM-GUESTS=0:mailto:edgar.iglesias@gmail
 .com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=eric.auger@redhat.com;X-NUM-GUESTS=0:mailto:eric.auger@redhat.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=iggy@theiggy.com;X-NUM-GUESTS=0:mailto:iggy@theiggy.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=jan.kiszka@web.de;X-NUM-GUESTS=0:mailto:jan.kiszka@web.de
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=jidong.xiao@gmail.com;X-NUM-GUESTS=0:mailto:jidong.xiao@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=jjherne@linux.vnet.ibm.com;X-NUM-GUESTS=0:mailto:jjherne@linux.vnet
 .ibm.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=mimu@linux.vnet.ibm.com;X-NUM-GUESTS=0:mailto:mimu@linux.vnet.ibm.c
 om
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=peter.maydell@linaro.org;X-NUM-GUESTS=0:mailto:peter.maydell@linaro
 .org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=richard.henderson@linaro.org;X-NUM-GUESTS=0:mailto:richard.henderso
 n@linaro.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=stefanha@gmail.com;X-NUM-GUESTS=0:mailto:stefanha@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=TENTATIVE;RSVP=TRU
 E;CN=imp@bsdimp.com;X-NUM-GUESTS=0:mailto:imp@bsdimp.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=z.huo@139.com;X-NUM-GUESTS=0:mailto:z.huo@139.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=zwu.kernel@gmail.com;X-NUM-GUESTS=0:mailto:zwu.kernel@gmail.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=jgg@nvidia.com;X-NUM-GUESTS=0:mailto:jgg@nvidia.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=cjia@nvidia.com;X-NUM-GUESTS=0:mailto:cjia@nvidia.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Elena Ufimtseva;X-NUM-GUESTS=0:mailto:elena.ufimtseva@oracle.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=konrad.wilk@oracle.com;X-NUM-GUESTS=0:mailto:konrad.wilk@oracle.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=ale@rev.ng;X-NUM-GUESTS=0:mailto:ale@rev.ng
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=anjo@rev.ng;X-NUM-GUESTS=0:mailto:anjo@rev.ng
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Shameerali Kolothum Thodi;X-NUM-GUESTS=0:mailto:shameerali.kolothum
 .thodi@huawei.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE
 ;CN=wei.w.wang@intel.com;X-NUM-GUESTS=0:mailto:wei.w.wang@intel.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Chao Peng;X-NUM-GUESTS=0:mailto:chao.p.peng@linux.intel.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=qemu-devel@nongnu.org;X-NUM-GUESTS=0:mailto:qemu-devel@nongnu.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=mburton@qti.qualcomm.com;X-NUM-GUESTS=0:mailto:mburton@qti.qualcomm
 .com
X-MICROSOFT-CDO-OWNERAPPTID:-1326661108
CLASS:PUBLIC
CREATED:20220823T150022Z
DESCRIPTION:If you need call details\, please contact me: quintela@redhat.c
 om
LAST-MODIFIED:20231227T154922Z
LOCATION:https://meet.jit.si/kvmcallmeeting
SEQUENCE:1
STATUS:CONFIRMED
SUMMARY:QEMU developers fortnightly conference call
TRANSP:OPAQUE
END:VEVENT
END:VCALENDAR

--000000000000699597060d7fbecd--

--000000000000699598060d7fbecf
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
UlQ7VFpJRD1BbWVyaWNhL05ld19Zb3JrOjIwMjIwODIzVDA5MDAwMA0KRFRFTkQ7VFpJRD1BbWVy
aWNhL05ld19Zb3JrOjIwMjIwODIzVDEwMDAwMA0KUlJVTEU6RlJFUT1XRUVLTFk7V0tTVD1NTztV
TlRJTD0yMDI0MDEwOVQwNDU5NTlaO0lOVEVSVkFMPTI7QllEQVk9VFUNCkRUU1RBTVA6MjAyMzEy
MjdUMTU0OTI2Wg0KT1JHQU5JWkVSO0NOPUtWTSBjYWxsIGZvciBxZW11IGRldmVsb3BlcnM6bWFp
bHRvOmVnZWQ3Y2tpMDVsbXUxdG5ndmtsM3RoaWRzDQogQGdyb3VwLmNhbGVuZGFyLmdvb2dsZS5j
b20NClVJRDo1ZHQ1amk4N2o1cXJjMDBvNjNrdHE3Z2hvdUBnb29nbGUuY29tDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047UlNWUD0NCiBUUlVFO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpmNGJ1Z0BhbXNhdC5vcmcNCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049Sm9hbyBNYXJ0aW5zO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzpqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtSU1ZQPVRSVUUNCiA7Q049
SnVhbiBRdWludGVsYTtYLU5VTS1HVUVTVFM9MDptYWlsdG86cXVpbnRlbGFAcmVkaGF0LmNvbQ0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1NZWlyYXYgRGVhbjtYLU5VTS1HVUVTVFM9MDpt
YWlsdG86bWRlYW5AcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1S
RVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1mZWxp
cGVAbnV0YW5peC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmZlbGlwZUBudXRhbml4LmNvbQ0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1hZmFlcmJlckBzdXNlLmRlO1gtTlVNLUdVRVNU
Uz0wOm1haWx0bzphZmFlcmJlckBzdXNlLmRlDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NO
PWJiYXVtYW5AcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86YmJhdW1hbkByZWRoYXQu
Y29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJU
U1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWN3QGYwMGYub3JnO1gtTlVNLUdVRVNU
Uz0wOm1haWx0bzpjd0BmMDBmLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1S
RVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1Fcmlj
IEJsYWtlO1gtTlVNLUdVRVNUUz0wOm1haWx0bzplYmxha2VAcmVkaGF0LmNvbQ0KQVRURU5ERUU7
Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNU
SU9OO1JTVlA9DQogVFJVRTtDTj1lZGdhci5pZ2xlc2lhc0BnbWFpbC5jb207WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOmVkZ2FyLmlnbGVzaWFzQGdtYWlsDQogLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlO
RElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9
DQogVFJVRTtDTj1lcmljLmF1Z2VyQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVy
aWMuYXVnZXJAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEt
UEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1pZ2d5QHRo
ZWlnZ3kuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzppZ2d5QHRoZWlnZ3kuY29tDQpBVFRFTkRF
RTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1B
Q1RJT047UlNWUD0NCiBUUlVFO0NOPWphbi5raXN6a2FAd2ViLmRlO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzpqYW4ua2lzemthQHdlYi5kZQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1S
RVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1qaWRv
bmcueGlhb0BnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmppZG9uZy54aWFvQGdtYWls
LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1qamhlcm5lQGxpbnV4LnZuZXQuaWJt
LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ampoZXJuZUBsaW51eC52bmV0DQogLmlibS5jb20N
CkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFU
PU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049bWltdUBsaW51eC52bmV0LmlibS5jb207WC1O
VU0tR1VFU1RTPTA6bWFpbHRvOm1pbXVAbGludXgudm5ldC5pYm0uYw0KIG9tDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047UlNWUD0NCiBUUlVFO0NOPXBldGVyLm1heWRlbGxAbGluYXJvLm9yZztYLU5VTS1HVUVTVFM9
MDptYWlsdG86cGV0ZXIubWF5ZGVsbEBsaW5hcm8NCiAub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5E
SVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0N
CiBUUlVFO0NOPXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc7WC1OVU0tR1VFU1RTPTA6bWFp
bHRvOnJpY2hhcmQuaGVuZGVyc28NCiBuQGxpbmFyby5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJ
VklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0K
IFRSVUU7Q049c3RlZmFuaGFAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpzdGVmYW5o
YUBnbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQ
QU5UO1BBUlRTVEFUPVRFTlRBVElWRTtSU1ZQPVRSVQ0KIEU7Q049aW1wQGJzZGltcC5jb207WC1O
VU0tR1VFU1RTPTA6bWFpbHRvOmltcEBic2RpbXAuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJ
RFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBU
UlVFO0NOPXouaHVvQDEzOS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnouaHVvQDEzOS5jb20N
CkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFU
PU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049end1Lmtlcm5lbEBnbWFpbC5jb207WC1OVU0t
R1VFU1RTPTA6bWFpbHRvOnp3dS5rZXJuZWxAZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5E
SVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0N
CiBUUlVFO0NOPWpnZ0BudmlkaWEuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqZ2dAbnZpZGlh
LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1jamlhQG52aWRpYS5jb207WC1OVU0t
R1VFU1RTPTA6bWFpbHRvOmNqaWFAbnZpZGlhLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJV
RTtDTj1FbGVuYSBVZmltdHNldmE7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVsZW5hLnVmaW10c2V2
YUBvcmFjbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJ
UEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWtvbnJhZC53aWxrQG9y
YWNsZS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmtvbnJhZC53aWxrQG9yYWNsZS5jb20NCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049YWxlQHJldi5uZztYLU5VTS1HVUVTVFM9MDptYWls
dG86YWxlQHJldi5uZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElD
SVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1hbmpvQHJldi5uZztY
LU5VTS1HVUVTVFM9MDptYWlsdG86YW5qb0ByZXYubmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklE
VUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRS
VUU7Q049U2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaTtYLU5VTS1HVUVTVFM9MDptYWlsdG86c2hh
bWVlcmFsaS5rb2xvdGh1bQ0KIC50aG9kaUBodWF3ZWkuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5E
SVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtSU1ZQPVRSVUUN
CiA7Q049d2VpLncud2FuZ0BpbnRlbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOndlaS53Lndh
bmdAaW50ZWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJ
UEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUNoYW8gUGVuZztYLU5V
TS1HVUVTVFM9MDptYWlsdG86Y2hhby5wLnBlbmdAbGludXguaW50ZWwuY29tDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047UlNWUD0NCiBUUlVFO0NOPXFlbXUtZGV2ZWxAbm9uZ251Lm9yZztYLU5VTS1HVUVTVFM9MDpt
YWlsdG86cWVtdS1kZXZlbEBub25nbnUub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NO
PW1idXJ0b25AcXRpLnF1YWxjb21tLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWJ1cnRvbkBx
dGkucXVhbGNvbW0NCiAuY29tDQpYLU1JQ1JPU09GVC1DRE8tT1dORVJBUFBUSUQ6LTEzMjY2NjEx
MDgNCkNMQVNTOlBVQkxJQw0KQ1JFQVRFRDoyMDIyMDgyM1QxNTAwMjJaDQpERVNDUklQVElPTjpJ
ZiB5b3UgbmVlZCBjYWxsIGRldGFpbHNcLCBwbGVhc2UgY29udGFjdCBtZTogcXVpbnRlbGFAcmVk
aGF0LmMNCiBvbQ0KTEFTVC1NT0RJRklFRDoyMDIzMTIyN1QxNTQ5MjJaDQpMT0NBVElPTjpodHRw
czovL21lZXQuaml0LnNpL2t2bWNhbGxtZWV0aW5nDQpTRVFVRU5DRToxDQpTVEFUVVM6Q09ORklS
TUVEDQpTVU1NQVJZOlFFTVUgZGV2ZWxvcGVycyBmb3J0bmlnaHRseSBjb25mZXJlbmNlIGNhbGwN
ClRSQU5TUDpPUEFRVUUNCkVORDpWRVZFTlQNCkVORDpWQ0FMRU5EQVINCg==
--000000000000699598060d7fbecf--


