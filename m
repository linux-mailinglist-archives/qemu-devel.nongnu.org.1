Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E01976951B
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 13:41:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQRGp-0005Mu-7W; Mon, 31 Jul 2023 07:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qQRGm-0005Jo-Er
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 07:41:00 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qQRGk-00047D-0c
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 07:41:00 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-267fabc8465so2498059a91.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 04:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1690803535; x=1691408335;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ekwMlhWRUPDz6ieNKXXMKv+Ieku0hKLHcG+apOM1tYg=;
 b=JSpqjkRqCUTO9H+ge86KlYbsYL0IYK6QDgonSiqwtRoFQWBpQnDPXu6WFymtX7ZrHm
 jW3HGedmmUwdGFhAUxpgwUp6CEWiQszwA//OISnvLMIFqiYvmCx6cRk0Sv29M5LquTew
 A4PaAw2IBy4/A06mkrDjocS1btTtjCBll7yPyIsQLzcnXrohJohomU5ohU/dnFgmnmVs
 JDWxMXdViC6ogn7ZC2G0SbHVwMIVlrLouImRMnUKbhASxl1hwfQJmJkcUzv0bD0yanmT
 Fah5LTAWEyETtlTfIwiWVRwSibC0F4DCIQULj4D5Ae9xiN2LQgl0XV/S/lfJ3Uf5JajP
 AZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690803535; x=1691408335;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ekwMlhWRUPDz6ieNKXXMKv+Ieku0hKLHcG+apOM1tYg=;
 b=CcLxkPuBjy3h/elczmhTxlPYQyqRvO8Sa/pEYouInQyP6lb6p63FEQuWe/HyeCyaKw
 gQYIGulzRbIlp/iUKWsjnLlmHiqkWeemeM8Wct+WydGvUvPdvzZvpDRYAQXxEz/xRKyT
 d0S0thJR/zk48Zbov161VjmmO01zmQ8Xiv2jKY2eYIMOtXnxiA1M+9P2Orp7y76dUdLQ
 ot6gwihjYCuIzmZJ46kIhNOj2Iu8Ksw/ikE6EXvLwzYRnWXhO1wu+A6aHQegHMOK0yfL
 60McMhL07i5RgNoBjPAJWUw/AQO4BxK+SYkTRNg5qiLHmos5wJWDtPijT9xuorHV2z20
 bc3w==
X-Gm-Message-State: ABy/qLY/PxWmeYszs3cceGrzJG3KnTO1OHnDGaJeC2ennV6QONJQ+Q6l
 pm/mnizDbTt5WDznpXBln16lzQ==
X-Google-Smtp-Source: APBJJlGtc0jhFApMVXXHa/FC9pq0v1WmGsmgIZKX0iaWyB4A9fbFa6PW5pNcfmcU4begaosyYKw6Ag==
X-Received: by 2002:a17:90b:3e89:b0:268:1222:6fef with SMTP id
 rj9-20020a17090b3e8900b0026812226fefmr9084641pjb.23.1690803534558; 
 Mon, 31 Jul 2023 04:38:54 -0700 (PDT)
Received: from smtpclient.apple ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 bu5-20020a17090aee4500b00268dac826d4sm478526pjb.0.2023.07.31.04.38.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Jul 2023 04:38:54 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
Message-Id: <8D0EABBD-CB21-4BF4-A96F-CC64CA92C99B@smartx.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_5B62229F-CA9F-4AB2-9AA1-32009DF91599"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH v2 2/4] vhost-user-common: send get_inflight_fd once
Date: Mon, 31 Jul 2023 19:38:37 +0800
In-Reply-To: <70D32B59-8B40-45E2-AFEC-0E3395867D15@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230725104256.4861-1-fengli@smartx.com>
 <20230725104256.4861-3-fengli@smartx.com>
 <20230728020156-mutt-send-email-mst@kernel.org>
 <09BB8CEC-26F4-4FC5-A2DB-479FCD5F0548@smartx.com>
 <70D32B59-8B40-45E2-AFEC-0E3395867D15@nutanix.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=fengli@smartx.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


--Apple-Mail=_5B62229F-CA9F-4AB2-9AA1-32009DF91599
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2023=E5=B9=B47=E6=9C=8831=E6=97=A5 06:13=EF=BC=8CRaphael Norwitz =
<raphael.norwitz@nutanix.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>>=20
>> On Jul 28, 2023, at 3:49 AM, Li Feng <fengli@smartx.com> wrote:
>>=20
>>=20
>>=20
>>> 2023=E5=B9=B47=E6=9C=8828=E6=97=A5 =E4=B8=8B=E5=8D=882:04=EF=BC=8CMich=
ael S. Tsirkin <mst@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On Tue, Jul 25, 2023 at 06:42:45PM +0800, Li Feng wrote:
>>>> Get_inflight_fd is sent only once. When reconnecting to the =
backend,
>>>> qemu sent set_inflight_fd to the backend.
>>>=20
>>> I don't understand what you are trying to say here.
>>> Should be:
>>> Currently ABCD. This is wrong/unnecessary because EFG. This patch =
HIJ.
>>=20
>> Thanks, I will reorganize the commit message in v3.
>>>=20
>>>> Signed-off-by: Li Feng <fengli@smartx.com>
>>>> ---
>>>> hw/scsi/vhost-scsi-common.c | 37 =
++++++++++++++++++-------------------
>>>> 1 file changed, 18 insertions(+), 19 deletions(-)
>>>>=20
>>>> diff --git a/hw/scsi/vhost-scsi-common.c =
b/hw/scsi/vhost-scsi-common.c
>>>> index a06f01af26..664adb15b4 100644
>>>> --- a/hw/scsi/vhost-scsi-common.c
>>>> +++ b/hw/scsi/vhost-scsi-common.c
>>>> @@ -52,20 +52,28 @@ int vhost_scsi_common_start(VHostSCSICommon =
*vsc)
>>>>=20
>>>>    vsc->dev.acked_features =3D vdev->guest_features;
>>>>=20
>>>> -    assert(vsc->inflight =3D=3D NULL);
>>>> -    vsc->inflight =3D g_new0(struct vhost_inflight, 1);
>>>> -    ret =3D vhost_dev_get_inflight(&vsc->dev,
>>>> -                                 vs->conf.virtqueue_size,
>>>> -                                 vsc->inflight);
>>>> +    ret =3D vhost_dev_prepare_inflight(&vsc->dev, vdev);
>>>>    if (ret < 0) {
>>>> -        error_report("Error get inflight: %d", -ret);
>>>> +        error_report("Error setting inflight format: %d", -ret);
>>>>        goto err_guest_notifiers;
>>>>    }
>>>>=20
>>>> -    ret =3D vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
>>>> -    if (ret < 0) {
>>>> -        error_report("Error set inflight: %d", -ret);
>>>> -        goto err_guest_notifiers;
>>>> +    if (vsc->inflight) {
>>>> +        if (!vsc->inflight->addr) {
>>>> +            ret =3D vhost_dev_get_inflight(&vsc->dev,
>>>> +                                        vs->conf.virtqueue_size,
>>>> +                                        vsc->inflight);
>>>> +            if (ret < 0) {
>>>> +                error_report("Error get inflight: %d", -ret);
>>>=20
>>> As long as you are fixing this - should be "getting inflight=E2=80=9D.=

>> I will fix it in v3.
>>>=20
>>>> +                goto err_guest_notifiers;
>>>> +            }
>>>> +        }
>>>> +
>=20
> Looks like you reworked this a bit so to avoid a potential crash if =
vsc->inflight is NULL
>=20
> Should we fix it for vhost-user-blk too?
>=20
This check is mainly for the vhost-scsi code, that doesn=E2=80=99t need =
allocate the inflight memory.

The vhost-user-blk doesn=E2=80=99t need this check, because there isn't =
a vhost-blk device that reuse the code.

>>>> +        ret =3D vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
>>>> +        if (ret < 0) {
>>>> +            error_report("Error set inflight: %d", -ret);
>>>> +            goto err_guest_notifiers;
>>>> +        }
>>>>    }
>>>>=20
>>>>    ret =3D vhost_dev_start(&vsc->dev, vdev, true);
>>>> @@ -85,9 +93,6 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>>>>    return ret;
>>>>=20
>>>> err_guest_notifiers:
>>>> -    g_free(vsc->inflight);
>>>> -    vsc->inflight =3D NULL;
>>>> -
>>>>    k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
>>>> err_host_notifiers:
>>>>    vhost_dev_disable_notifiers(&vsc->dev, vdev);
>>>> @@ -111,12 +116,6 @@ void vhost_scsi_common_stop(VHostSCSICommon =
*vsc)
>>>>    }
>>>>    assert(ret >=3D 0);
>>>>=20
>=20
> As I said before, I think this introduces a leak.
I have answered in the previous mail.

>=20
>>>> -    if (vsc->inflight) {
>>>> -        vhost_dev_free_inflight(vsc->inflight);
>>>> -        g_free(vsc->inflight);
>>>> -        vsc->inflight =3D NULL;
>>>> -    }
>>>> -
>>>>    vhost_dev_disable_notifiers(&vsc->dev, vdev);
>>>> }
>>>>=20
>>>> --=20
>>>> 2.41.0


--Apple-Mail=_5B62229F-CA9F-4AB2-9AA1-32009DF91599
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: =
after-white-space;"><br><div><br><blockquote =
type=3D"cite"><div>2023=E5=B9=B47=E6=9C=8831=E6=97=A5 06:13=EF=BC=8CRaphae=
l Norwitz &lt;raphael.norwitz@nutanix.com&gt; =E5=86=99=E9=81=93=EF=BC=9A<=
/div><br class=3D"Apple-interchange-newline"><div><meta =
charset=3D"UTF-8"><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
class=3D"Apple-interchange-newline">On Jul 28, 2023, at 3:49 AM, Li Feng =
&lt;fengli@smartx.com&gt; wrote:<br><br><br><br><blockquote =
type=3D"cite">2023=E5=B9=B47=E6=9C=8828=E6=97=A5 =E4=B8=8B=E5=8D=882:04=EF=
=BC=8CMichael S. Tsirkin &lt;mst@redhat.com&gt; =E5=86=99=E9=81=93=EF=BC=9A=
<br><br>On Tue, Jul 25, 2023 at 06:42:45PM +0800, Li Feng =
wrote:<br><blockquote type=3D"cite">Get_inflight_fd is sent only once. =
When reconnecting to the backend,<br>qemu sent set_inflight_fd to the =
backend.<br></blockquote><br>I don't understand what you are trying to =
say here.<br>Should be:<br>Currently ABCD. This is wrong/unnecessary =
because EFG. This patch HIJ.<br></blockquote><br>Thanks, I will =
reorganize the commit message in v3.<br><blockquote =
type=3D"cite"><br><blockquote type=3D"cite">Signed-off-by: Li Feng =
&lt;fengli@smartx.com&gt;<br>---<br>hw/scsi/vhost-scsi-common.c | 37 =
++++++++++++++++++-------------------<br>1 file changed, 18 =
insertions(+), 19 deletions(-)<br><br>diff --git =
a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c<br>index =
a06f01af26..664adb15b4 100644<br>--- =
a/hw/scsi/vhost-scsi-common.c<br>+++ b/hw/scsi/vhost-scsi-common.c<br>@@ =
-52,20 +52,28 @@ int vhost_scsi_common_start(VHostSCSICommon =
*vsc)<br><br>&nbsp;&nbsp;&nbsp;vsc-&gt;dev.acked_features =3D =
vdev-&gt;guest_features;<br><br>- =
&nbsp;&nbsp;&nbsp;assert(vsc-&gt;inflight =3D=3D NULL);<br>- =
&nbsp;&nbsp;&nbsp;vsc-&gt;inflight =3D g_new0(struct vhost_inflight, =
1);<br>- &nbsp;&nbsp;&nbsp;ret =3D =
vhost_dev_get_inflight(&amp;vsc-&gt;dev,<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vs-&gt;conf.virtqueue_size,<br=
>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vsc-&gt;inflight);<br>+ =
&nbsp;&nbsp;&nbsp;ret =3D vhost_dev_prepare_inflight(&amp;vsc-&gt;dev, =
vdev);<br>&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("Error get =
inflight: %d", -ret);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("Error setting =
inflight format: %d", =
-ret);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
err_guest_notifiers;<br>&nbsp;&nbsp;&nbsp;}<br><br>- =
&nbsp;&nbsp;&nbsp;ret =3D vhost_dev_set_inflight(&amp;vsc-&gt;dev, =
vsc-&gt;inflight);<br>- &nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("Error set =
inflight: %d", -ret);<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto err_guest_notifiers;<br>+ =
&nbsp;&nbsp;&nbsp;if (vsc-&gt;inflight) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(!vsc-&gt;inflight-&gt;addr) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_dev_get_inflight(&amp;vsc-&gt;dev,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;vs-&gt;conf.virtqueue_size,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;vsc-&gt;inflight);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(ret &lt; 0) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;error_report("Error get inflight: %d", =
-ret);<br></blockquote><br>As long as you are fixing this - should be =
"getting inflight=E2=80=9D.<br></blockquote>I will fix it in =
v3.<br><blockquote type=3D"cite"><br><blockquote type=3D"cite">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;goto err_guest_notifiers;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+<br></blockquote></blockqu=
ote></blockquote><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">Looks like you reworked =
this a bit so to avoid a potential crash if vsc-&gt;inflight is =
NULL</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">Should we fix it for =
vhost-user-blk too?</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"></div></blockquote>This check is mainly for the =
vhost-scsi code, that doesn=E2=80=99t need allocate the inflight =
memory.</div><div><br>The vhost-user-blk doesn=E2=80=99t need this =
check, because there isn't a vhost-blk device that reuse the =
code.</div><div><br><blockquote type=3D"cite"><div><blockquote =
type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><blockquote =
type=3D"cite"><blockquote type=3D"cite">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_dev_set_inflight(&amp;vsc-&gt;dev, vsc-&gt;inflight);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_re=
port("Error set inflight: %d", -ret);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
err_guest_notifiers;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;}<br><br>=
&nbsp;&nbsp;&nbsp;ret =3D vhost_dev_start(&amp;vsc-&gt;dev, vdev, =
true);<br>@@ -85,9 +93,6 @@ int vhost_scsi_common_start(VHostSCSICommon =
*vsc)<br>&nbsp;&nbsp;&nbsp;return ret;<br><br>err_guest_notifiers:<br>- =
&nbsp;&nbsp;&nbsp;g_free(vsc-&gt;inflight);<br>- =
&nbsp;&nbsp;&nbsp;vsc-&gt;inflight =3D =
NULL;<br>-<br>&nbsp;&nbsp;&nbsp;k-&gt;set_guest_notifiers(qbus-&gt;parent,=
 vsc-&gt;dev.nvqs, =
false);<br>err_host_notifiers:<br>&nbsp;&nbsp;&nbsp;vhost_dev_disable_noti=
fiers(&amp;vsc-&gt;dev, vdev);<br>@@ -111,12 +116,6 @@ void =
vhost_scsi_common_stop(VHostSCSICommon =
*vsc)<br>&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;assert(ret &gt;=3D =
0);<br><br></blockquote></blockquote></blockquote><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">As I said before, I think this introduces a =
leak.</span></div></blockquote>I have answered in the previous =
mail.</div><div><br></div><div><blockquote type=3D"cite"><div><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><blockquote =
type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><blockquote =
type=3D"cite"><blockquote type=3D"cite">- &nbsp;&nbsp;&nbsp;if =
(vsc-&gt;inflight) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_dev_free_inflight(vsc-&gt;=
inflight);<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;g_free(vsc-&gt;inflight);<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vsc-&gt;inflight =3D =
NULL;<br>- =
&nbsp;&nbsp;&nbsp;}<br>-<br>&nbsp;&nbsp;&nbsp;vhost_dev_disable_notifiers(=
&amp;vsc-&gt;dev, vdev);<br>}<br><br>--<span =
class=3D"Apple-converted-space">&nbsp;</span><br>2.41.0</blockquote></bloc=
kquote></blockquote></div></blockquote></div><br></body></html>=

--Apple-Mail=_5B62229F-CA9F-4AB2-9AA1-32009DF91599--

