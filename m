Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4572E81EFE5
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 16:50:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIWAE-00035J-GX; Wed, 27 Dec 2023 10:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1rIWA8-00034e-4O
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 10:49:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1rIWA2-0000fz-9j
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 10:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703692171;
 h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type; bh=AB5jhWrEFUfoWA8KvEYr4PpRVVhOF8iwemYpDrWYJQs=;
 b=Nx1CnlfjV2QFBCJKYg1FxwbAtmdy0zpgaf4TcRKTPjRK1YIQuMvAhf5g9Lq5icQz0cSShQ
 SBItAxJ479ZHgcFlFdqyuJgAy2U1t5boxmLzcb62CDKHIhGa1AIXlCpVuMSl2lz29X8UDt
 ggz6L10fOjztlbYse8FNVwhvLybiizU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-JIRFzXUPNF6aLEc8kDeUEQ-1; Wed, 27 Dec 2023 10:49:28 -0500
X-MC-Unique: JIRFzXUPNF6aLEc8kDeUEQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-50e86a0debcso639003e87.1
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 07:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1703692166; x=1704296966; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AB5jhWrEFUfoWA8KvEYr4PpRVVhOF8iwemYpDrWYJQs=;
 b=2TGaV9R9dDiAIC7Or9ESi0Q6qwxJ47QbIYelTutoomveWElIA3f0C7/78jkbRtmyMb
 /S/3ySSnNFGK13Cy8QJSaYxx8hzIlUlF3jkZ0xQHNocCLdm7Hg3XlcvipUAYynirLd+q
 hBLwReR9nKB1HkI7FGzWC1mJL9Pa1ugpXyu7Q/Q4qIxVU+WEbhSKp7CreFTdLmTsyuAB
 Oj4bJZ39pKAu/OYAk76OOi9TkQnqm9pEe8Y6w/YgoWSFjsJmP/f6bEdh/kO24P23h1BN
 1nIyFl4S3c7JwL86c3rvr2td4Q89B9TmhH2pWIl7N37zF1t4G8RtUEmWoHFIeRGRrhCS
 9ANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703692166; x=1704296966;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AB5jhWrEFUfoWA8KvEYr4PpRVVhOF8iwemYpDrWYJQs=;
 b=ilelDQzldLT2s2CCAzodMsGWBjvBbgL1ek0OBEiH/7LCXNzou7n/5CSx1TVqQkd7dB
 QsO6mol2pDt0R1hn3Rj/O/L78jFuF1yNnyz6WYMjNBlHi5iof/T5ZwLKvEi6HyiLOc/Y
 IYbYDuq+j2a23v/xD3lOnofZ4esOLlanEJStHl9j3v3ZbwDAzRmSPF3PnWvqvOWgEO5w
 xIoYVCNjq48LbiDu7ZSqjexw4xIzR/KmHJJysGdwJMVD746rQ+mJXpv7SZFcWFX3tQbW
 LDLE+v+QAnMQO++wAg7PHqtdD8X1HsZKcjSc9eHRiYj+nGEpjUaGLuACxr4Snyf/3dBn
 c88Q==
X-Gm-Message-State: AOJu0Yz0QnDbAxchAvfPyBPPR3vCirgzjVWafusf9e9DRlZviuGo6NBu
 EbQrxJzrAcZD3VoHxpcbRNpiE9lzc9Cu57mNhzORJvWlNpWqM47HM13wJ68AsUmiGzmmyoO7xCj
 J6TKzKZ2VR0EE0BJ0Dn7c4+qfJVE0XYSxt4kl2d6A5snqFIobqJ9bA87Uq2k37J+mOAh/tuxAvN
 O+SYNmv0EpwI0tD24/quuOlQ7uTrc=
X-Received: by 2002:a05:6512:31d6:b0:50e:7fae:d5ac with SMTP id
 j22-20020a05651231d600b0050e7faed5acmr1576416lfe.21.1703692166726; 
 Wed, 27 Dec 2023 07:49:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/ZKvKPzSJWt1Jz0CX7oDL6XGY59h0lJfj3elDKxtDLEPOT4YRpbjKCyBeGSh0Trk3aw3cCEIwdSOwp95JocAC
MIME-Version: 1.0
X-Received: by 2002:a05:6512:31d6:b0:50e:7fae:d5ac with SMTP id
 j22-20020a05651231d600b0050e7faed5acmr1576405lfe.21.1703692166298; Wed, 27
 Dec 2023 07:49:26 -0800 (PST)
Auto-Submitted: auto-generated
Message-ID: <calendar-e71c2743-a63d-4e6b-b258-4e4a4206f3c7@google.com>
Date: Wed, 27 Dec 2023 15:49:26 +0000
Subject: Updated invitation: QEMU developers fortnightly conference call @
 Every 2 weeks from 15:00 to 16:00 on Tuesday (CET) (qemu-devel@nongnu.org)
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
Content-Type: multipart/mixed; boundary="000000000000611645060d7fbe96"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.755,
 DKIMWL_WL_MED=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--000000000000611645060d7fbe96
Content-Type: multipart/alternative; boundary="000000000000611644060d7fbe94"

--000000000000611644060d7fbe94
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
SUVXJmVpZD1OV1IwTldwcE9EZHFOWEZ5WXpBd2J6WXphM1J4TjJkb2IzVmZVakl3TWpRd01UQTVW
REUwTURBd01DQnhaVzExTFdSbGRtVnNRRzV2Ym1kdWRTNXZjbWMmdG9rPU5USWpaV2RsWkRkamEy
a3dOV3h0ZFRGMGJtZDJhMnd6ZEdocFpITkFaM0p2ZFhBdVkyRnNaVzVrWVhJdVoyOXZaMnhsTG1O
dmJUVmlPVEpqWkRCallqTTFZV0l4WVdNeVlUUXdZVFEzTkRJME5tRTJObUZtWW1ZME9XUTJPVFkm
Y3R6PUV1cm9wZSUyRk1hZHJpZCZobD1lbiZlcz0wDQoNClJlcGx5IGZvciBxZW11LWRldmVsQG5v
bmdudS5vcmcgYW5kIHZpZXcgbW9yZSBkZXRhaWxzICANCmh0dHBzOi8vY2FsZW5kYXIuZ29vZ2xl
LmNvbS9jYWxlbmRhci9ldmVudD9hY3Rpb249VklFVyZlaWQ9TldSME5XcHBPRGRxTlhGeVl6QXdi
ell6YTNSeE4yZG9iM1ZmVWpJd01qUXdNVEE1VkRFME1EQXdNQ0J4WlcxMUxXUmxkbVZzUUc1dmJt
ZHVkUzV2Y21jJnRvaz1OVElqWldkbFpEZGphMmt3Tld4dGRURjBibWQyYTJ3emRHaHBaSE5BWjNK
dmRYQXVZMkZzWlc1a1lYSXVaMjl2WjJ4bExtTnZiVFZpT1RKalpEQmpZak0xWVdJeFlXTXlZVFF3
WVRRM05ESTBObUUyTm1GbVltWTBPV1EyT1RZJmN0ej1FdXJvcGUlMkZNYWRyaWQmaGw9ZW4mZXM9
MA0KWW91ciBhdHRlbmRhbmNlIGlzIG9wdGlvbmFsLg0KDQp+fi8vfn4NCkludml0YXRpb24gZnJv
bSBHb29nbGUgQ2FsZW5kYXI6IGh0dHBzOi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxlbmRhci8N
Cg0KWW91IGFyZSByZWNlaXZpbmcgdGhpcyBlbWFpbCBiZWNhdXNlIHlvdSBhcmUgYW4gYXR0ZW5k
ZWUgb24gdGhlIGV2ZW50LiBUbyAgDQpzdG9wIHJlY2VpdmluZyBmdXR1cmUgdXBkYXRlcyBmb3Ig
dGhpcyBldmVudCwgZGVjbGluZSB0aGlzIGV2ZW50Lg0KDQpGb3J3YXJkaW5nIHRoaXMgaW52aXRh
dGlvbiBjb3VsZCBhbGxvdyBhbnkgcmVjaXBpZW50IHRvIHNlbmQgYSByZXNwb25zZSB0byAgDQp0
aGUgb3JnYW5pemVyLCBiZSBhZGRlZCB0byB0aGUgZ3Vlc3QgbGlzdCwgaW52aXRlIG90aGVycyBy
ZWdhcmRsZXNzIG9mICANCnRoZWlyIG93biBpbnZpdGF0aW9uIHN0YXR1cywgb3IgbW9kaWZ5IHlv
dXIgUlNWUC4NCg0KTGVhcm4gbW9yZSBodHRwczovL3N1cHBvcnQuZ29vZ2xlLmNvbS9jYWxlbmRh
ci9hbnN3ZXIvMzcxMzUjZm9yd2FyZGluZw0K
--000000000000611644060d7fbe94
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
c00o63ktq7ghou_R20240109T140000"/><span style=3D"display: none; font-size: =
1px; color: #fff; line-height: 1px; height: 0; max-height: 0; width: 0; max=
-width: 0; opacity: 0; overflow: hidden;" itemprop=3D"name">QEMU developers=
 fortnightly conference call</span><meta itemprop=3D"url" content=3D"https:=
//calendar.google.com/calendar/event?action=3DVIEW&amp;eid=3DNWR0NWppODdqNX=
FyYzAwbzYza3RxN2dob3VfUjIwMjQwMTA5VDE0MDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&a=
mp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2=
xlLmNvbTViOTJjZDBjYjM1YWIxYWMyYTQwYTQ3NDI0NmE2NmFmYmY0OWQ2OTY&amp;ctz=3DEur=
ope%2FMadrid&amp;hl=3Den&amp;es=3D0"/><span aria-hidden=3D"true"><time item=
prop=3D"startDate" datetime=3D"20240109T140000Z"></time><time itemprop=3D"e=
ndDate" datetime=3D"20240109T150000Z"></time></span><div style=3D"display: =
none; font-size: 1px; color: #fff; line-height: 1px; height: 0; max-height:=
 0; width: 0; max-width: 0; opacity: 0; overflow: hidden;">If you need call=
 details, please contact me: quintela@redhat.com</div><table border=3D"0" c=
ellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"center" s=
tyle=3D"width:100%;" class=3D"body-container"><tbody><tr><td style=3D"" cla=
ss=3D"" align=3D"left"><!--[if mso | IE]><table border=3D"0" cellpadding=3D=
"0" cellspacing=3D"0" role=3D"presentation"><tr><td height=3D"16" style=3D"=
height:16px;"><![endif]--><div style=3D"height:16px;" aria-hidden=3D"true">=
 &nbsp; </div><!--[if mso | IE]></td></tr></table><![endif]--><table border=
=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"c=
enter" style=3D"width:100%;" class=3D""><tbody><tr><td style=3D"background-=
color: #e6f4ea;color: #0d5327;padding: 12px 32px; border-radius: 8px;font-f=
amily: Roboto, sans-serif;font-size: 14px; line-height: 20px;text-align: le=
ft;" class=3D"info-bar-inner"><span style=3D"font-weight: 700;">This event =
has been updated</span></td></tr></tbody></table><!--[if mso | IE]><table b=
order=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><=
td height=3D"12" style=3D"height:12px;"><![endif]--><div style=3D"height:12=
px;" aria-hidden=3D"true"> &nbsp; </div><!--[if mso | IE]></td></tr></table=
><![endif]--><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D""><tbody>=
<tr><td style=3D"border: solid 1px #dadce0; border-radius: 8px; direction: =
rtl; font-size: 0; padding: 24px 32px; text-align: left; vertical-align: to=
p;" class=3D"main-container-inner"><!--[if mso | IE]><table border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><![endif]--><di=
v class=3D"" style=3D"font-size: 13px; text-align: left; direction: ltr; di=
splay: inline-block; vertical-align: top; width: 100%;overflow: hidden; wor=
d-wrap: break-word;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0=
" role=3D"presentation" width=3D"100%" class=3D"main-column-table-ltr" styl=
e=3D"padding-right: 32px; padding-left: 0;;table-layout: fixed;"><tbody><tr=
><td class=3D"main-column-td" style=3D"padding:0; vertical-align:top;"><tab=
le border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" w=
idth=3D"100%" style=3D"table-layout: fixed;"><tr><td style=3D"font-size: 0;=
 padding: 0; text-align: left; word-break: break-word;;padding-bottom:24px;=
"><div style=3D"font-family: Roboto, sans-serif;font-style: normal; font-we=
ight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color:=
 #3c4043; text-decoration: none;" class=3D"primary-text" role=3D"presentati=
on"><span>If you need call details, please contact me: <a href=3D"mailto:qu=
intela@redhat.com" target=3D"_blank">quintela@redhat.com</a></span><meta it=
emprop=3D"description" content=3D"If you need call details, please contact =
me: quintela@redhat.com"/></div></td></tr><tr><td style=3D"font-size: 0; pa=
dding: 0; text-align: left; word-break: break-word;;padding-bottom:24px;"><=
div style=3D"font-family: Roboto, sans-serif;font-style: normal; font-weigh=
t: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3=
c4043; text-decoration: none;" class=3D"primary-text" role=3D"presentation"=
><span aria-hidden=3D"true"><time itemprop=3D"startDate" datetime=3D"202401=
09T140000Z"></time><time itemprop=3D"endDate" datetime=3D"20240109T150000Z"=
></time></span><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"prima=
ry-text" style=3D"font-size: 14px;color: #3c4043; text-decoration: none;fon=
t-weight: 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">W=
hen</h2></td></tr></table><span>Every 2 weeks from 15:00 to 16:00 on Tuesda=
y (Central European Time - Madrid)</span></div></td></tr><tr><td style=3D"f=
ont-size: 0; padding: 0; text-align: left; word-break: break-word;;padding-=
bottom:24px;"><div style=3D"font-family: Roboto, sans-serif;font-style: nor=
mal; font-weight: 400; font-size: 14px; line-height: 20px; letter-spacing: =
0.2px;color: #3c4043; text-decoration: none;" class=3D"primary-text" role=
=3D"presentation"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" r=
ole=3D"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"pr=
imary-text" style=3D"font-size: 14px;color: #3c4043; text-decoration: none;=
font-weight: 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;=
">Location</h2></td></tr></table><span itemprop=3D"location" itemscope item=
type=3D"http://schema.org/Place"><span itemprop=3D"name" class=3D"primary-t=
ext notranslate" style=3D"font-family: Roboto, sans-serif;font-style: norma=
l; font-weight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.=
2px;color: #3c4043; text-decoration: none;">https://meet.jit.si/kvmcallmeet=
ing</span><br/><a href=3D"https://www.google.com/url?q=3Dhttps%3A%2F%2Fmeet=
.jit.si%2Fkvmcallmeeting&amp;sa=3DD&amp;ust=3D1704124140000000&amp;usg=3DAO=
vVaw0bNTwqh-owJG0zvH1eFfzE" class=3D"accent-text underline-on-hover" style=
=3D"display: inline-block;;color: #1a73e8; text-decoration: none;font-weigh=
t: 700;" target=3D"_blank" itemprop=3D"map">View map</a></span></div></td><=
/tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-break=
: break-word;;padding-bottom:24px;"><div style=3D"font-family: Roboto, sans=
-serif;font-style: normal; font-weight: 400; font-size: 14px; line-height: =
20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" class=
=3D"primary-text" role=3D"presentation"><table border=3D"0" cellpadding=3D"=
0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-bottom: 4px;"><=
tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;color: #3c4043; =
text-decoration: none;font-weight: 700;-webkit-font-smoothing: antialiased;=
margin: 0; padding: 0;">Guests</h2></td></tr></table><div style=3D"padding-=
bottom: 4px; text-align: left;;color: #3c4042;"><div><span itemprop=3D"atte=
ndee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"nam=
e" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:f4bug@amsat.org">Philippe Mathieu-Daud=C3=A9</a></span><meta itempro=
p=3D"email" content=3D"f4bug@amsat.org"/></span><span class=3D"secondary-te=
xt" style=3D"color: #70757a; text-decoration: none;"></span></div><div><spa=
n itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><sp=
an itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underli=
ne-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoratio=
n: none;" href=3D"mailto:joao.m.martins@oracle.com">Joao Martins</a></span>=
<meta itemprop=3D"email" content=3D"joao.m.martins@oracle.com"/></span><spa=
n class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"=
></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:/=
/schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:quintela@redhat.com">Juan =
Quintela</a></span><meta itemprop=3D"email" content=3D"quintela@redhat.com"=
/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decor=
ation: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemt=
ype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransla=
te"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-b=
lock;;color: #3c4043; text-decoration: none;" href=3D"mailto:mdean@redhat.c=
om">Meirav Dean</a></span><meta itemprop=3D"email" content=3D"mdean@redhat.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:felipe@nut=
anix.com">felipe@nutanix.com</a></span><meta itemprop=3D"email" content=3D"=
felipe@nutanix.com"/></span><span class=3D"secondary-text" style=3D"color: =
#70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attend=
ee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name"=
 class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:afaerber@suse.de">afaerber@suse.de</a></span><meta itemprop=3D"email=
" content=3D"afaerber@suse.de"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:bbauman@redhat.com">bbauman@redhat.com</a></span><meta item=
prop=3D"email" content=3D"bbauman@redhat.com"/></span><span class=3D"second=
ary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><di=
v><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Perso=
n"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text u=
nderline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-dec=
oration: none;" href=3D"mailto:cw@f00f.org">cw@f00f.org</a></span><meta ite=
mprop=3D"email" content=3D"cw@f00f.org"/></span><span class=3D"secondary-te=
xt" style=3D"color: #70757a; text-decoration: none;"></span></div><div><spa=
n itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><sp=
an itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underli=
ne-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoratio=
n: none;" href=3D"mailto:eblake@redhat.com">Eric Blake</a></span><meta item=
prop=3D"email" content=3D"eblake@redhat.com"/></span><span class=3D"seconda=
ry-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div=
><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person=
"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text un=
derline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-deco=
ration: none;" href=3D"mailto:edgar.iglesias@gmail.com">edgar.iglesias@gmai=
l.com</a></span><meta itemprop=3D"email" content=3D"edgar.iglesias@gmail.co=
m"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-dec=
oration: none;"></span></div><div><span itemprop=3D"attendee" itemscope ite=
mtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notrans=
late"><a class=3D"primary-text underline-on-hover" style=3D"display: inline=
-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:eric.auger@r=
edhat.com">eric.auger@redhat.com</a></span><meta itemprop=3D"email" content=
=3D"eric.auger@redhat.com"/></span><span class=3D"secondary-text" style=3D"=
color: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D=
"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=
=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover=
" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" h=
ref=3D"mailto:iggy@theiggy.com">iggy@theiggy.com</a></span><meta itemprop=
=3D"email" content=3D"iggy@theiggy.com"/></span><span class=3D"secondary-te=
xt" style=3D"color: #70757a; text-decoration: none;"></span></div><div><spa=
n itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><sp=
an itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underli=
ne-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoratio=
n: none;" href=3D"mailto:jan.kiszka@web.de">jan.kiszka@web.de</a></span><me=
ta itemprop=3D"email" content=3D"jan.kiszka@web.de"/></span><span class=3D"=
secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></d=
iv><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org=
/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-=
text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; te=
xt-decoration: none;" href=3D"mailto:jidong.xiao@gmail.com">jidong.xiao@gma=
il.com</a></span><meta itemprop=3D"email" content=3D"jidong.xiao@gmail.com"=
/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decor=
ation: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemt=
ype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransla=
te"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-b=
lock;;color: #3c4043; text-decoration: none;" href=3D"mailto:jjherne@linux.=
vnet.ibm.com">jjherne@linux.vnet.ibm.com</a></span><meta itemprop=3D"email"=
 content=3D"jjherne@linux.vnet.ibm.com"/></span><span class=3D"secondary-te=
xt" style=3D"color: #70757a; text-decoration: none;"></span></div><div><spa=
n itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><sp=
an itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underli=
ne-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoratio=
n: none;" href=3D"mailto:mimu@linux.vnet.ibm.com">mimu@linux.vnet.ibm.com</=
a></span><meta itemprop=3D"email" content=3D"mimu@linux.vnet.ibm.com"/></sp=
an><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration:=
 none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D=
"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a=
 class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;=
color: #3c4043; text-decoration: none;" href=3D"mailto:peter.maydell@linaro=
.org">peter.maydell@linaro.org</a></span><meta itemprop=3D"email" content=
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
:imp@bsdimp.com">imp@bsdimp.com</a></span><meta itemprop=3D"email" content=
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
ext-decoration: none;" href=3D"mailto:elena.ufimtseva@oracle.com">Elena Ufi=
mtseva</a></span><meta itemprop=3D"email" content=3D"elena.ufimtseva@oracle=
.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-=
decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope =
itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notr=
anslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inl=
ine-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:konrad.wi=
lk@oracle.com">konrad.wilk@oracle.com</a></span><meta itemprop=3D"email" co=
ntent=3D"konrad.wilk@oracle.com"/></span><span class=3D"secondary-text" sty=
le=3D"color: #70757a; text-decoration: none;"></span></div><div><span itemp=
rop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span item=
prop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-h=
over" style=3D"display: inline-block;;color: #3c4043; text-decoration: none=
;" href=3D"mailto:ale@rev.ng">ale@rev.ng</a></span><meta itemprop=3D"email"=
 content=3D"ale@rev.ng"/></span><span class=3D"secondary-text" style=3D"col=
or: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"at=
tendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"n=
ame" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" sty=
le=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:anjo@rev.ng">anjo@rev.ng</a></span><meta itemprop=3D"email" cont=
ent=3D"anjo@rev.ng"/></span><span class=3D"secondary-text" style=3D"color: =
#70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attend=
ee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name"=
 class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:shameerali.kolothum.thodi@huawei.com">Shameerali Kolothum Thodi</a><=
/span><meta itemprop=3D"email" content=3D"shameerali.kolothum.thodi@huawei.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:wei.w.wang=
@intel.com">wei.w.wang@intel.com</a></span><meta itemprop=3D"email" content=
=3D"wei.w.wang@intel.com"/></span><span class=3D"secondary-text" style=3D"c=
olor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:chao.p.peng@linux.intel.com">Chao Peng</a></span><meta itemprop=
=3D"email" content=3D"chao.p.peng@linux.intel.com"/></span><span class=3D"s=
econdary-text" style=3D"color: #70757a; text-decoration: none;"></span></di=
v><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/=
Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-t=
ext underline-on-hover" style=3D"display: inline-block;;color: #3c4043; tex=
t-decoration: none;" href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongn=
u.org</a></span><meta itemprop=3D"email" content=3D"qemu-devel@nongnu.org"/=
></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decora=
tion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemty=
pe=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslat=
e"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bl=
ock;;color: #3c4043; text-decoration: none;" href=3D"mailto:mburton@qti.qua=
lcomm.com">mburton@qti.qualcomm.com</a></span><meta itemprop=3D"email" cont=
ent=3D"mburton@qti.qualcomm.com"/></span><span class=3D"secondary-text" sty=
le=3D"color: #70757a; text-decoration: none;"></span></div></div><a href=3D=
"https://calendar.google.com/calendar/event?action=3DVIEW&amp;eid=3DNWR0NWp=
pODdqNXFyYzAwbzYza3RxN2dob3VfUjIwMjQwMTA5VDE0MDAwMCBxZW11LWRldmVsQG5vbmdudS=
5vcmc&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXI=
uZ29vZ2xlLmNvbTViOTJjZDBjYjM1YWIxYWMyYTQwYTQ3NDI0NmE2NmFmYmY0OWQ2OTY&amp;ct=
z=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" style=3D"display: inline-block;=
;color: #1a73e8; text-decoration: none;font-weight: 700;" target=3D"_blank"=
 class=3D"accent-text underline-on-hover">View all guest info</a></div></td=
></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-bre=
ak: break-word;;padding-bottom:0px;"><div style=3D"color: #3c4043; text-dec=
oration: none;;font-family: Roboto, sans-serif;font-size: 14px; line-height=
: 20px; mso-line-height-rule: exactly; text-align: left;" class=3D"primary-=
text"><div><span style=3D"font-weight: 700;-webkit-font-smoothing: antialia=
sed;">RSVP</span><span class=3D"secondary-text" style=3D"color: #70757a; te=
xt-decoration: none;"> for <a class=3D"secondary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #70757a; text-decoration: none;" href=
=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a> for all events =
in this series</span></div></div></td></tr><tr><td style=3D"font-size: 0; p=
adding: 0; text-align: left; word-break: break-word;;padding-bottom:16px;">=
<div style=3D"font-family: Roboto, sans-serif;font-size: 14px; line-height:=
 20px; mso-line-height-rule: exactly; text-align: left;"><table border=3D"0=
" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"border=
-collapse: separate;"><tr><td style=3D"padding-top: 8px; padding-left: 0; p=
adding-right: 12px;"><!-- RSVP buttons --><table border=3D"0" cellpadding=
=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"border: solid 1px #=
dadce0; border-radius: 16px; border-collapse: separate;font-family: &#39;Go=
ogle Sans&#39;, Roboto, sans-serif;;display: inline-block;;margin-right: 12=
px; margin-left: 0;"><tr><td align=3D"center" vertical-align=3D"middle" rol=
e=3D"presentation"><span itemprop=3D"potentialaction" itemscope itemtype=3D=
"http://schema.org/RsvpAction"><meta itemprop=3D"attendance" content=3D"htt=
p://schema.org/RsvpAttendance/Yes"/><span itemprop=3D"handler" itemscope it=
emtype=3D"http://schema.org/HttpActionHandler"><link itemprop=3D"method" hr=
ef=3D"http://schema.org/HttpRequestMethod/GET"/><span style=3D"color: #5f63=
67;"><a href=3D"https://calendar.google.com/calendar/event?action=3DRESPOND=
&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3VfUjIwMjQwMTA5VDE0MDAwMCBxZW11=
LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D1&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a=
2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTViOTJjZDBjYjM1YWIxYWMyYTQwYTQ3=
NDI0NmE2NmFmYmY0OWQ2OTY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" s=
tyle=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-s=
erif;color: #5f6368; font-size: 14px; line-height: 120%; mso-line-height-ru=
le: exactly; margin: 0; text-decoration: none; text-transform: none;" class=
=3D"grey-button-text" itemprop=3D"url" target=3D"_blank"><table border=3D"0=
" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><td align=
=3D"center" role=3D"presentation" valign=3D"middle" style=3D"padding: 6px 0=
; padding-left: 16px; padding-right: 12px; white-space: nowrap;"><!--[if ms=
o]><a href=3D"https://calendar.google.com/calendar/event?action=3DRESPOND&a=
mp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3VfUjIwMjQwMTA5VDE0MDAwMCBxZW11LW=
RldmVsQG5vbmdudS5vcmc&amp;rst=3D1&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2w=
zdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTViOTJjZDBjYjM1YWIxYWMyYTQwYTQ3ND=
I0NmE2NmFmYmY0OWQ2OTY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" cla=
ss=3D"grey-button-text" itemprop=3D"url" target=3D"_blank"><![endif]--><spa=
n class=3D"grey-button-text" style=3D"font-weight: 400;font-family: &#39;Go=
ogle Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-he=
ight: 120%; mso-line-height-rule: exactly; margin: 0; text-decoration: none=
; text-transform: none;">Yes</span><!--[if mso]></a><![endif]--></td></tr><=
/table></a></span></span></span></td><td align=3D"center" vertical-align=3D=
"middle" role=3D"presentation" style=3D"border-left: solid 1px #dadce0; bor=
der-right: solid 1px #dadce0;"><span itemprop=3D"potentialaction" itemscope=
 itemtype=3D"http://schema.org/RsvpAction"><meta itemprop=3D"attendance" co=
ntent=3D"http://schema.org/RsvpAttendance/No"/><span itemprop=3D"handler" i=
temscope itemtype=3D"http://schema.org/HttpActionHandler"><link itemprop=3D=
"method" href=3D"http://schema.org/HttpRequestMethod/GET"/><span style=3D"c=
olor: #5f6367;"><a href=3D"https://calendar.google.com/calendar/event?actio=
n=3DRESPOND&amp;eid=3DNWR0NWppODdqNXFyYzAwbzYza3RxN2dob3VfUjIwMjQwMTA5VDE0M=
DAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D2&amp;tok=3DNTIjZWdlZDdja2kwNW=
xtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbTViOTJjZDBjYjM1YWIxY=
WMyYTQwYTQ3NDI0NmE2NmFmYmY0OWQ2OTY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&am=
p;es=3D0" style=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Rob=
oto, sans-serif;color: #5f6368; font-size: 14px; line-height: 120%; mso-lin=
e-height-rule: exactly; margin: 0; text-decoration: none; text-transform: n=
one;" class=3D"grey-button-text" itemprop=3D"url" target=3D"_blank"><table =
border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr>=
<td align=3D"center" role=3D"presentation" valign=3D"middle" style=3D"paddi=
ng: 6px 12px; white-space: nowrap;"><!--[if mso]><a href=3D"https://calenda=
r.google.com/calendar/event?action=3DRESPOND&amp;eid=3DNWR0NWppODdqNXFyYzAw=
bzYza3RxN2dob3VfUjIwMjQwMTA5VDE0MDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=
=3D2&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIu=
Z29vZ2xlLmNvbTViOTJjZDBjYjM1YWIxYWMyYTQwYTQ3NDI0NmE2NmFmYmY0OWQ2OTY&amp;ctz=
=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-text" itemp=
rop=3D"url" target=3D"_blank"><![endif]--><span class=3D"grey-button-text" =
style=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-=
serif;color: #5f6368; font-size: 14px; line-height: 120%; mso-line-height-r=
ule: exactly; margin: 0; text-decoration: none; text-transform: none;">No</=
span><!--[if mso]></a><![endif]--></td></tr></table></a></span></span></spa=
n></td><td align=3D"center" vertical-align=3D"middle" role=3D"presentation"=
><span itemprop=3D"potentialaction" itemscope itemtype=3D"http://schema.org=
/RsvpAction"><meta itemprop=3D"attendance" content=3D"http://schema.org/Rsv=
pAttendance/Maybe"/><span itemprop=3D"handler" itemscope itemtype=3D"http:/=
/schema.org/HttpActionHandler"><link itemprop=3D"method" href=3D"http://sch=
ema.org/HttpRequestMethod/GET"/><span style=3D"color: #5f6367;"><a href=3D"=
https://calendar.google.com/calendar/event?action=3DRESPOND&amp;eid=3DNWR0N=
WppODdqNXFyYzAwbzYza3RxN2dob3VfUjIwMjQwMTA5VDE0MDAwMCBxZW11LWRldmVsQG5vbmdu=
dS5vcmc&amp;rst=3D3&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3Jvd=
XAuY2FsZW5kYXIuZ29vZ2xlLmNvbTViOTJjZDBjYjM1YWIxYWMyYTQwYTQ3NDI0NmE2NmFmYmY0=
OWQ2OTY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" style=3D"font-wei=
ght: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6=
368; font-size: 14px; line-height: 120%; mso-line-height-rule: exactly; mar=
gin: 0; text-decoration: none; text-transform: none;" class=3D"grey-button-=
text" itemprop=3D"url" target=3D"_blank"><table border=3D"0" cellpadding=3D=
"0" cellspacing=3D"0" role=3D"presentation"><tr><td align=3D"center" role=
=3D"presentation" valign=3D"middle" style=3D"padding: 6px 0; padding-left: =
12px; padding-right: 16px; white-space: nowrap;"><!--[if mso]><a href=3D"ht=
tps://calendar.google.com/calendar/event?action=3DRESPOND&amp;eid=3DNWR0NWp=
pODdqNXFyYzAwbzYza3RxN2dob3VfUjIwMjQwMTA5VDE0MDAwMCBxZW11LWRldmVsQG5vbmdudS=
5vcmc&amp;rst=3D3&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXA=
uY2FsZW5kYXIuZ29vZ2xlLmNvbTViOTJjZDBjYjM1YWIxYWMyYTQwYTQ3NDI0NmE2NmFmYmY0OW=
Q2OTY&amp;ctz=3DEurope%2FMadrid&amp;hl=3Den&amp;es=3D0" class=3D"grey-butto=
n-text" itemprop=3D"url" target=3D"_blank"><![endif]--><span class=3D"grey-=
button-text" style=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, =
Roboto, sans-serif;color: #5f6368; font-size: 14px; line-height: 120%; mso-=
line-height-rule: exactly; margin: 0; text-decoration: none; text-transform=
: none;">Maybe</span><!--[if mso]></a><![endif]--></td></tr></table></a></s=
pan></span></span></td></tr></table><!-- More options --><a href=3D"https:/=
/calendar.google.com/calendar/event?action=3DVIEW&amp;eid=3DNWR0NWppODdqNXF=
yYzAwbzYza3RxN2dob3VfUjIwMjQwMTA5VDE0MDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&am=
p;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2x=
lLmNvbTViOTJjZDBjYjM1YWIxYWMyYTQwYTQ3NDI0NmE2NmFmYmY0OWQ2OTY&amp;ctz=3DEuro=
pe%2FMadrid&amp;hl=3Den&amp;es=3D0" style=3D"display: inline-block;;font-we=
ight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f=
6368; font-size: 14px; line-height: 120%; mso-line-height-rule: exactly; ma=
rgin: 0; text-decoration: none; text-transform: none;" class=3D"grey-button=
-text" target=3D"_blank"><table border=3D"0" cellpadding=3D"0" cellspacing=
=3D"0" role=3D"presentation" style=3D"border: solid 1px #dadce0; border-rad=
ius: 16px; border-collapse: separate;font-family: &#39;Google Sans&#39;, Ro=
boto, sans-serif;"><tr><td align=3D"center" vertical-align=3D"middle" role=
=3D"presentation" style=3D"padding: 6px 0; padding-left: 16px; padding-righ=
t: 12px; white-space: nowrap;;color: #5f6367;"><!--[if mso]><a href=3D"http=
s://calendar.google.com/calendar/event?action=3DVIEW&amp;eid=3DNWR0NWppODdq=
NXFyYzAwbzYza3RxN2dob3VfUjIwMjQwMTA5VDE0MDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc=
&amp;tok=3DNTIjZWdlZDdja2kwNWxtdTF0bmd2a2wzdGhpZHNAZ3JvdXAuY2FsZW5kYXIuZ29v=
Z2xlLmNvbTViOTJjZDBjYjM1YWIxYWMyYTQwYTQ3NDI0NmE2NmFmYmY0OWQ2OTY&amp;ctz=3DE=
urope%2FMadrid&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-text" target=3D=
"_blank"><![endif]--><span class=3D"grey-button-text" style=3D"font-weight:=
 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368;=
 font-size: 14px; line-height: 120%; mso-line-height-rule: exactly; margin:=
 0; text-decoration: none; text-transform: none;">More options</span><!--[i=
f mso]></a><![endif]--></td></tr></table></a></td></tr></table></div></td><=
/tr></table></td></tr></tbody></table></div><!--[if mso | IE]></tr></table>=
<![endif]--></td></tr></tbody></table><table border=3D"0" cellpadding=3D"0"=
 cellspacing=3D"0" role=3D"presentation" align=3D"center" style=3D"width:10=
0%;" class=3D""><tbody><tr><td style=3D"font-size: 0; padding: 0; text-alig=
n: left; word-break: break-word;;padding:4px 12px;" class=3D"" align=3D"lef=
t"><div class=3D"secondary-text" style=3D"color: #70757a; text-decoration: =
none;font-family: Roboto, sans-serif;font-size: 12px; line-height: 16px; ms=
o-line-height-rule: exactly; text-align: left;"><p>Invitation from <a href=
=3D"https://calendar.google.com/calendar/" class=3D"accent-text underline-o=
n-hover" style=3D"font-family: Roboto, sans-serif;font-size: 12px; line-hei=
ght: 16px; mso-line-height-rule: exactly;;color: #1a73e8; text-decoration: =
none;" target=3D"_blank">Google Calendar</a></p><p>You are receiving this e=
mail because you are an attendee on the event. To stop receiving future upd=
ates for this event, decline this event.</p><p>Forwarding this invitation c=
ould allow any recipient to send a response to the organizer, be added to t=
he guest list, invite others regardless of their own invitation status, or =
modify your RSVP. <a class=3D"accent-text underline-on-hover" style=3D"font=
-family: Roboto, sans-serif;font-size: 12px; line-height: 16px; mso-line-he=
ight-rule: exactly;;color: #1a73e8; text-decoration: none;" href=3D"https:/=
/support.google.com/calendar/answer/37135#forwarding">Learn more</a></p></d=
iv></td></tr></tbody></table></td></tr></tbody></table></span></span></body=
></html>
--000000000000611644060d7fbe94
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
DTSTART;TZID=America/New_York:20240109T090000
DTEND;TZID=America/New_York:20240109T100000
RRULE:FREQ=WEEKLY;WKST=MO;INTERVAL=2;BYDAY=TU
DTSTAMP:20231227T154926Z
ORGANIZER;CN=KVM call for qemu developers:mailto:eged7cki05lmu1tngvkl3thids
 @group.calendar.google.com
UID:5dt5ji87j5qrc00o63ktq7ghou_R20240109T140000@google.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;X-NUM-GUESTS=0:mailto:f4bug@amsat.org
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=
 TRUE;CN=Joao Martins;X-NUM-GUESTS=0:mailto:joao.m.martins@oracle.com
ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=DECLINED;RSVP=TRUE
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
X-MICROSOFT-CDO-OWNERAPPTID:-1610811808
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

--000000000000611644060d7fbe94--

--000000000000611645060d7fbe96
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
UlQ7VFpJRD1BbWVyaWNhL05ld19Zb3JrOjIwMjQwMTA5VDA5MDAwMA0KRFRFTkQ7VFpJRD1BbWVy
aWNhL05ld19Zb3JrOjIwMjQwMTA5VDEwMDAwMA0KUlJVTEU6RlJFUT1XRUVLTFk7V0tTVD1NTztJ
TlRFUlZBTD0yO0JZREFZPVRVDQpEVFNUQU1QOjIwMjMxMjI3VDE1NDkyNloNCk9SR0FOSVpFUjtD
Tj1LVk0gY2FsbCBmb3IgcWVtdSBkZXZlbG9wZXJzOm1haWx0bzplZ2VkN2NraTA1bG11MXRuZ3Zr
bDN0aGlkcw0KIEBncm91cC5jYWxlbmRhci5nb29nbGUuY29tDQpVSUQ6NWR0NWppODdqNXFyYzAw
bzYza3RxN2dob3VfUjIwMjQwMTA5VDE0MDAwMEBnb29nbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9
SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNW
UD0NCiBUUlVFO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpmNGJ1Z0BhbXNhdC5vcmcNCkFUVEVOREVF
O0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFD
VElPTjtSU1ZQPQ0KIFRSVUU7Q049Sm9hbyBNYXJ0aW5zO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpq
b2FvLm0ubWFydGluc0BvcmFjbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xF
PVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ERUNMSU5FRDtSU1ZQPVRSVUUNCiA7Q049SnVhbiBR
dWludGVsYTtYLU5VTS1HVUVTVFM9MDptYWlsdG86cXVpbnRlbGFAcmVkaGF0LmNvbQ0KQVRURU5E
RUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMt
QUNUSU9OO1JTVlA9DQogVFJVRTtDTj1NZWlyYXYgRGVhbjtYLU5VTS1HVUVTVFM9MDptYWlsdG86
bWRlYW5AcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1mZWxpcGVAbnV0
YW5peC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmZlbGlwZUBudXRhbml4LmNvbQ0KQVRURU5E
RUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMt
QUNUSU9OO1JTVlA9DQogVFJVRTtDTj1hZmFlcmJlckBzdXNlLmRlO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzphZmFlcmJlckBzdXNlLmRlDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWJiYXVt
YW5AcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86YmJhdW1hbkByZWRoYXQuY29tDQpB
VFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1O
RUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWN3QGYwMGYub3JnO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzpjd0BmMDBmLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1FcmljIEJsYWtl
O1gtTlVNLUdVRVNUUz0wOm1haWx0bzplYmxha2VAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBF
PUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JT
VlA9DQogVFJVRTtDTj1lZGdhci5pZ2xlc2lhc0BnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFp
bHRvOmVkZ2FyLmlnbGVzaWFzQGdtYWlsDQogLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJV
RTtDTj1lcmljLmF1Z2VyQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVyaWMuYXVn
ZXJAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElD
SVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1pZ2d5QHRoZWlnZ3ku
Y29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzppZ2d5QHRoZWlnZ3kuY29tDQpBVFRFTkRFRTtDVVRZ
UEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047
UlNWUD0NCiBUUlVFO0NOPWphbi5raXN6a2FAd2ViLmRlO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpq
YW4ua2lzemthQHdlYi5kZQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1qaWRvbmcueGlh
b0BnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmppZG9uZy54aWFvQGdtYWlsLmNvbQ0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1qamhlcm5lQGxpbnV4LnZuZXQuaWJtLmNvbTtY
LU5VTS1HVUVTVFM9MDptYWlsdG86ampoZXJuZUBsaW51eC52bmV0DQogLmlibS5jb20NCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURT
LUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049bWltdUBsaW51eC52bmV0LmlibS5jb207WC1OVU0tR1VF
U1RTPTA6bWFpbHRvOm1pbXVAbGludXgudm5ldC5pYm0uYw0KIG9tDQpBVFRFTkRFRTtDVVRZUEU9
SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNW
UD0NCiBUUlVFO0NOPXBldGVyLm1heWRlbGxAbGluYXJvLm9yZztYLU5VTS1HVUVTVFM9MDptYWls
dG86cGV0ZXIubWF5ZGVsbEBsaW5hcm8NCiAub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVF
O0NOPXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnJp
Y2hhcmQuaGVuZGVyc28NCiBuQGxpbmFyby5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFM
O1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7
Q049c3RlZmFuaGFAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpzdGVmYW5oYUBnbWFp
bC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BB
UlRTVEFUPVRFTlRBVElWRTtSU1ZQPVRSVQ0KIEU7Q049aW1wQGJzZGltcC5jb207WC1OVU0tR1VF
U1RTPTA6bWFpbHRvOmltcEBic2RpbXAuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NO
PXouaHVvQDEzOS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnouaHVvQDEzOS5jb20NCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURT
LUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049end1Lmtlcm5lbEBnbWFpbC5jb207WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOnp3dS5rZXJuZWxAZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVF
O0NOPWpnZ0BudmlkaWEuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqZ2dAbnZpZGlhLmNvbQ0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1jamlhQG52aWRpYS5jb207WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOmNqaWFAbnZpZGlhLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9M
RT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1F
bGVuYSBVZmltdHNldmE7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVsZW5hLnVmaW10c2V2YUBvcmFj
bGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWtvbnJhZC53aWxrQG9yYWNsZS5j
b207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmtvbnJhZC53aWxrQG9yYWNsZS5jb20NCkFUVEVOREVF
O0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFD
VElPTjtSU1ZQPQ0KIFRSVUU7Q049YWxlQHJldi5uZztYLU5VTS1HVUVTVFM9MDptYWlsdG86YWxl
QHJldi5uZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7
UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1hbmpvQHJldi5uZztYLU5VTS1H
VUVTVFM9MDptYWlsdG86YW5qb0ByZXYubmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JP
TEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049
U2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaTtYLU5VTS1HVUVTVFM9MDptYWlsdG86c2hhbWVlcmFs
aS5rb2xvdGh1bQ0KIC50aG9kaUBodWF3ZWkuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtSU1ZQPVRSVUUNCiA7Q049
d2VpLncud2FuZ0BpbnRlbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOndlaS53LndhbmdAaW50
ZWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUNoYW8gUGVuZztYLU5VTS1HVUVT
VFM9MDptYWlsdG86Y2hhby5wLnBlbmdAbGludXguaW50ZWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9
SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNW
UD0NCiBUUlVFO0NOPXFlbXUtZGV2ZWxAbm9uZ251Lm9yZztYLU5VTS1HVUVTVFM9MDptYWlsdG86
cWVtdS1kZXZlbEBub25nbnUub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPW1idXJ0
b25AcXRpLnF1YWxjb21tLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWJ1cnRvbkBxdGkucXVh
bGNvbW0NCiAuY29tDQpYLU1JQ1JPU09GVC1DRE8tT1dORVJBUFBUSUQ6LTE2MTA4MTE4MDgNCkNM
QVNTOlBVQkxJQw0KQ1JFQVRFRDoyMDIyMDgyM1QxNTAwMjJaDQpERVNDUklQVElPTjpJZiB5b3Ug
bmVlZCBjYWxsIGRldGFpbHNcLCBwbGVhc2UgY29udGFjdCBtZTogcXVpbnRlbGFAcmVkaGF0LmMN
CiBvbQ0KTEFTVC1NT0RJRklFRDoyMDIzMTIyN1QxNTQ5MjJaDQpMT0NBVElPTjpodHRwczovL21l
ZXQuaml0LnNpL2t2bWNhbGxtZWV0aW5nDQpTRVFVRU5DRToxDQpTVEFUVVM6Q09ORklSTUVEDQpT
VU1NQVJZOlFFTVUgZGV2ZWxvcGVycyBmb3J0bmlnaHRseSBjb25mZXJlbmNlIGNhbGwNClRSQU5T
UDpPUEFRVUUNCkVORDpWRVZFTlQNCkVORDpWQ0FMRU5EQVINCg==
--000000000000611645060d7fbe96--


