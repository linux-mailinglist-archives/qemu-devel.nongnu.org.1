Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07607766680
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 10:11:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPIFP-0004x4-E6; Fri, 28 Jul 2023 03:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qPIFK-0004wB-48
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 03:50:46 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qPIFI-00051G-0J
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 03:50:45 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-686ed1d2594so1767848b3a.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 00:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1690530522; x=1691135322;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mCH+nmn66CoaR2OP8IWJDMZKXVg0TkpeuymStfGb0EM=;
 b=ligpwT2MTn32+KzWk87y81/9IZS0c/Y5dPPkT/in1pmgFXu5Va5wbv2DAhK+80LbmW
 /pw3Sfjs+ANlJJ4rxtKaHMn54Y7FNa6X+8LGEdtj205JFTvrAOODqTcwW9ZsBAVP9hC7
 n/bEmM2fIg2MqKdEvlR4HjNaR1UzLqe8ShvOaDOfFKK+RYKxuoXe+w44XPB2Eshpmm5r
 ScDCTEvTFWJxj04XOveeRx+4gIy+CcFkM4W4EguyjPRUkIDYmiikkUb2nmzyIuJdhA/B
 CUr8Ixtns+RBSs6bnxvtV1QcagsCBiWxWKnWDhjWgGbNh59bSpUfuW4LkvbXiGeqSOSN
 BrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690530522; x=1691135322;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mCH+nmn66CoaR2OP8IWJDMZKXVg0TkpeuymStfGb0EM=;
 b=h0IEX/Yn8z13kED46VGgc1Fbuqrw1EtnwAtFqb4oFJruFnfUCdwCsKsdaoX9SH9O/l
 lEM4UC6ss4AqIKbRRJeLZ6+A2WvK0WztBNv5BsqbzwJQQyD8eEnccyfH5jJrL4VGnB28
 5mGIao10Uid8juLZ9XIg7a6EUW7Fmm1v3oeyKAa2uy3avhmHKXrh0t8hU7rwY9SPqeQl
 2I5qQpmVz/vW93ZdVVpJqUTxOgycZpKoQ0CQddVtQgXZBTSGs1e67iAvR95wgWe+kPeg
 VLUowu3ELVnFrl+e4nqIC4+8pzGUxNZIKWvUA8CZxe2KBH7H2MYZHjxqBfR6it78o1su
 oopA==
X-Gm-Message-State: ABy/qLbvUyexeTF7gyniyDkwmMddG2cDeDYDxp1hNNMamUfbvnt9ADLQ
 ajq7VfG5CBD8tagPqoKkeoxMmA==
X-Google-Smtp-Source: APBJJlHxyG8S2M6zmArNRlTdjfj7i9gWhVi7hXINRtxlnqPK30hZ75Gm6WcGMWoWAyzcV6aiUE42SA==
X-Received: by 2002:a05:6300:8082:b0:133:d1b:a880 with SMTP id
 ap2-20020a056300808200b001330d1ba880mr1198525pzc.23.1690530522399; 
 Fri, 28 Jul 2023 00:48:42 -0700 (PDT)
Received: from smtpclient.apple ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a62ed03000000b00682a839d0aesm2622934pfh.112.2023.07.28.00.48.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Jul 2023 00:48:41 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
Message-Id: <09BB8CEC-26F4-4FC5-A2DB-479FCD5F0548@smartx.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_FEDE57A7-0C95-4B67-A6D1-7730607A6DCC"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH v2 2/4] vhost-user-common: send get_inflight_fd once
Date: Fri, 28 Jul 2023 15:49:02 +0800
In-Reply-To: <20230728020156-mutt-send-email-mst@kernel.org>
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230725104256.4861-1-fengli@smartx.com>
 <20230725104256.4861-3-fengli@smartx.com>
 <20230728020156-mutt-send-email-mst@kernel.org>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x42f.google.com
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


--Apple-Mail=_FEDE57A7-0C95-4B67-A6D1-7730607A6DCC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2023=E5=B9=B47=E6=9C=8828=E6=97=A5 =E4=B8=8B=E5=8D=882:04=EF=BC=8CMichae=
l S. Tsirkin <mst@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, Jul 25, 2023 at 06:42:45PM +0800, Li Feng wrote:
>> Get_inflight_fd is sent only once. When reconnecting to the backend,
>> qemu sent set_inflight_fd to the backend.
>=20
> I don't understand what you are trying to say here.
> Should be:
> Currently ABCD. This is wrong/unnecessary because EFG. This patch HIJ.

Thanks, I will reorganize the commit message in v3.
>=20
>> Signed-off-by: Li Feng <fengli@smartx.com>
>> ---
>> hw/scsi/vhost-scsi-common.c | 37 =
++++++++++++++++++-------------------
>> 1 file changed, 18 insertions(+), 19 deletions(-)
>>=20
>> diff --git a/hw/scsi/vhost-scsi-common.c =
b/hw/scsi/vhost-scsi-common.c
>> index a06f01af26..664adb15b4 100644
>> --- a/hw/scsi/vhost-scsi-common.c
>> +++ b/hw/scsi/vhost-scsi-common.c
>> @@ -52,20 +52,28 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>>=20
>>     vsc->dev.acked_features =3D vdev->guest_features;
>>=20
>> -    assert(vsc->inflight =3D=3D NULL);
>> -    vsc->inflight =3D g_new0(struct vhost_inflight, 1);
>> -    ret =3D vhost_dev_get_inflight(&vsc->dev,
>> -                                 vs->conf.virtqueue_size,
>> -                                 vsc->inflight);
>> +    ret =3D vhost_dev_prepare_inflight(&vsc->dev, vdev);
>>     if (ret < 0) {
>> -        error_report("Error get inflight: %d", -ret);
>> +        error_report("Error setting inflight format: %d", -ret);
>>         goto err_guest_notifiers;
>>     }
>>=20
>> -    ret =3D vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
>> -    if (ret < 0) {
>> -        error_report("Error set inflight: %d", -ret);
>> -        goto err_guest_notifiers;
>> +    if (vsc->inflight) {
>> +        if (!vsc->inflight->addr) {
>> +            ret =3D vhost_dev_get_inflight(&vsc->dev,
>> +                                        vs->conf.virtqueue_size,
>> +                                        vsc->inflight);
>> +            if (ret < 0) {
>> +                error_report("Error get inflight: %d", -ret);
>=20
> As long as you are fixing this - should be "getting inflight=E2=80=9D.
I will fix it in v3.
>=20
>> +                goto err_guest_notifiers;
>> +            }
>> +        }
>> +
>> +        ret =3D vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
>> +        if (ret < 0) {
>> +            error_report("Error set inflight: %d", -ret);
>> +            goto err_guest_notifiers;
>> +        }
>>     }
>>=20
>>     ret =3D vhost_dev_start(&vsc->dev, vdev, true);
>> @@ -85,9 +93,6 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>>     return ret;
>>=20
>> err_guest_notifiers:
>> -    g_free(vsc->inflight);
>> -    vsc->inflight =3D NULL;
>> -
>>     k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
>> err_host_notifiers:
>>     vhost_dev_disable_notifiers(&vsc->dev, vdev);
>> @@ -111,12 +116,6 @@ void vhost_scsi_common_stop(VHostSCSICommon =
*vsc)
>>     }
>>     assert(ret >=3D 0);
>>=20
>> -    if (vsc->inflight) {
>> -        vhost_dev_free_inflight(vsc->inflight);
>> -        g_free(vsc->inflight);
>> -        vsc->inflight =3D NULL;
>> -    }
>> -
>>     vhost_dev_disable_notifiers(&vsc->dev, vdev);
>> }
>>=20
>> --=20
>> 2.41.0


--Apple-Mail=_FEDE57A7-0C95-4B67-A6D1-7730607A6DCC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: =
after-white-space;"><br><div><br><blockquote =
type=3D"cite"><div>2023=E5=B9=B47=E6=9C=8828=E6=97=A5 =
=E4=B8=8B=E5=8D=882:04=EF=BC=8CMichael S. Tsirkin &lt;mst@redhat.com&gt; =
=E5=86=99=E9=81=93=EF=BC=9A</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">On Tue, Jul 25, 2023 at 06:42:45PM +0800, =
Li Feng wrote:</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><blockquote type=3D"cite" style=3D"font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;">Get_inflight_fd =
is sent only once. When reconnecting to the backend,<br>qemu sent =
set_inflight_fd to the backend.<br></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">I don't =
understand what you are trying to say here.</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Should be:</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">Currently ABCD. This is wrong/unnecessary because EFG. This =
patch HIJ.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote><div><br></div>Thanks, I will reorganize the =
commit message in v3.<br><blockquote type=3D"cite"><div><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><blockquote =
type=3D"cite" style=3D"font-family: Monaco; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; =
text-decoration: none;">Signed-off-by: Li Feng =
&lt;fengli@smartx.com&gt;<br>---<br>hw/scsi/vhost-scsi-common.c | 37 =
++++++++++++++++++-------------------<br>1 file changed, 18 =
insertions(+), 19 deletions(-)<br><br>diff --git =
a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c<br>index =
a06f01af26..664adb15b4 100644<br>--- =
a/hw/scsi/vhost-scsi-common.c<br>+++ b/hw/scsi/vhost-scsi-common.c<br>@@ =
-52,20 +52,28 @@ int vhost_scsi_common_start(VHostSCSICommon =
*vsc)<br><br>&nbsp;&nbsp;&nbsp;&nbsp;vsc-&gt;dev.acked_features =3D =
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
vdev);<br>&nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("Error get =
inflight: %d", -ret);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("Error setting =
inflight format: %d", =
-ret);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
err_guest_notifiers;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>- =
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
-ret);<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Monaco; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">As long =
as you are fixing this - should be "getting inflight=E2=80=9D.</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Monaco; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote>I will fix it in v3.<br><blockquote =
type=3D"cite"><div><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Monaco; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><blockquote type=3D"cite" style=3D"font-family: Monaco; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;goto err_guest_notifiers;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_dev_set_inflight(&amp;vsc-&gt;dev, vsc-&gt;inflight);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_re=
port("Error set inflight: %d", -ret);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
err_guest_notifiers;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;}<b=
r><br>&nbsp;&nbsp;&nbsp;&nbsp;ret =3D vhost_dev_start(&amp;vsc-&gt;dev, =
vdev, true);<br>@@ -85,9 +93,6 @@ int =
vhost_scsi_common_start(VHostSCSICommon =
*vsc)<br>&nbsp;&nbsp;&nbsp;&nbsp;return =
ret;<br><br>err_guest_notifiers:<br>- =
&nbsp;&nbsp;&nbsp;g_free(vsc-&gt;inflight);<br>- =
&nbsp;&nbsp;&nbsp;vsc-&gt;inflight =3D =
NULL;<br>-<br>&nbsp;&nbsp;&nbsp;&nbsp;k-&gt;set_guest_notifiers(qbus-&gt;p=
arent, vsc-&gt;dev.nvqs, =
false);<br>err_host_notifiers:<br>&nbsp;&nbsp;&nbsp;&nbsp;vhost_dev_disabl=
e_notifiers(&amp;vsc-&gt;dev, vdev);<br>@@ -111,12 +116,6 @@ void =
vhost_scsi_common_stop(VHostSCSICommon =
*vsc)<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;assert(ret =
&gt;=3D 0);<br><br>- &nbsp;&nbsp;&nbsp;if (vsc-&gt;inflight) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_dev_free_inflight(vsc-&gt;=
inflight);<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;g_free(vsc-&gt;inflight);<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vsc-&gt;inflight =3D =
NULL;<br>- =
&nbsp;&nbsp;&nbsp;}<br>-<br>&nbsp;&nbsp;&nbsp;&nbsp;vhost_dev_disable_noti=
fiers(&amp;vsc-&gt;dev, vdev);<br>}<br><br>--<span =
class=3D"Apple-converted-space">&nbsp;</span><br>2.41.0</blockquote></div>=
</blockquote></div><br></body></html>=

--Apple-Mail=_FEDE57A7-0C95-4B67-A6D1-7730607A6DCC--

