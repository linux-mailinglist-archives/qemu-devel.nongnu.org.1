Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 849BE7838E6
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 06:49:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYJKY-0000TU-2d; Tue, 22 Aug 2023 00:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qYJKS-0000T6-RT
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:49:20 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qYJKO-0004Zw-7T
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:49:20 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99bcf2de59cso519860866b.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 21:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1692679631; x=1693284431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ySsWaGuEY5YQfBNQz+8tDooPdWk58ZSNeKqVjUSiT2Q=;
 b=wBAza1yFaInlqNl1kPZH6u1DHkr3fjI+Ba1u8w9JCDGtjd05nSR/Ty6FuHlDIgwe+L
 TQ9gw2KE5P5iDBiWouDgmVCdpBIJeyil5HzbfxurYUtS/H+H0v30hP9YY4pg0e5BZ1i9
 8cOxC4g2auIKBxg6Qmv9vCzGPf5ZHZOQ1to6gUfOaVJwcNcYX79pCsj0oV+08ZmQTxf9
 Ig5pI8+/kWxNzMZ96jRewwFSjjzri7tNbsxKR4aPYSLela0xIBLXoKOpxzd6CF3u8XrE
 SoovfLh4RxWMtiNpFtq0PLqwbWTPJb16jbDkubVeGb9KZuT8ubF1TyyJN2QB4BkqYxmg
 GmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692679631; x=1693284431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ySsWaGuEY5YQfBNQz+8tDooPdWk58ZSNeKqVjUSiT2Q=;
 b=WNZPD6md+QRv0HGe7vGet5VOFOVx+C35jaLJgNCsuYZt8j/SB8klkXj4QyhLRwImrF
 +48VeOqGOJWmHIxVFzditcw5c7hVHC1866Egjad3CknVGy7e38on+rNccKnlT+Gyctfa
 nQAlRBh2RCPI6wN2UtvLa/bJLxdETZUeQixD1yaOWXz9lFyMboMJAa1Cw8ElESZYJB6m
 F9Vgi8Bq3StfR+IwdKIkAKReG0nOM+qn9jNwOZ2IIWNvzss7Kcd6NEkr2H7HNDLLKR+5
 nnB1lPGymrBKngwYgRqrIZJKK26qnpk6Udq6JzqsrJ4bqCMy6siYh5rAHYiLHhNnhXHe
 POWA==
X-Gm-Message-State: AOJu0YxMZMZKNROHqRYlXoEjrFznRCyYq+0cmEDIxPokEJ4zY+KWMNe5
 m0NVLJf62EYb/lnTq4/0wJXk8vkKAeoifSGZbcZT9A==
X-Google-Smtp-Source: AGHT+IGLffajbCzbfvL+xLCLmW0TsFTCbpyQnPT1VXNVuXKY2UB6ofUs3/ZKleKHuIh6eDVdz0t+/8HJ6eFM4SUhKZg=
X-Received: by 2002:a17:906:73da:b0:98d:5ae2:f1c with SMTP id
 n26-20020a17090673da00b0098d5ae20f1cmr6526269ejl.34.1692679630491; Mon, 21
 Aug 2023 21:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230804052954.2918915-3-fengli@smartx.com>
 <C026BA6F-63E7-4BE8-8FC0-69372A14FFAB@nutanix.com>
 <844CBDD0-E0A9-4097-904E-5CD74C2884AD@smartx.com>
 <87o7j0egve.fsf@pond.sub.org>
In-Reply-To: <87o7j0egve.fsf@pond.sub.org>
From: Li Feng <fengli@smartx.com>
Date: Tue, 22 Aug 2023 12:47:59 +0800
Message-ID: <CAHckoCxNS_FHUtMcaV0PdV+gPOC0Ffg+fhx3rVDatseknAmuiA@mail.gmail.com>
Subject: Re: [PATCH 2/2] vhost: Add Error parameter to
 vhost_scsi_common_start()
To: Markus Armbruster <armbru@redhat.com>
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000018263706037bb04f"
Received-SPF: none client-ip=2a00:1450:4864:20::62e;
 envelope-from=fengli@smartx.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--00000000000018263706037bb04f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 21 Aug 2023, at 8:09 PM, Markus Armbruster <armbru@redhat.com> wrote:

Li Feng <fengli@smartx.com> writes:

2023=E5=B9=B48=E6=9C=8814=E6=97=A5 =E4=B8=8B=E5=8D=888:11=EF=BC=8CRaphael N=
orwitz <raphael.norwitz@nutanix.com> =E5=86=99=E9=81=93=EF=BC=9A

Thanks for the cleanup! A few comments.

On Aug 4, 2023, at 1:29 AM, Li Feng <fengli@smartx.com> wrote:

Add a Error parameter to report the real error, like vhost-user-blk.

Signed-off-by: Li Feng <fengli@smartx.com>
---
hw/scsi/vhost-scsi-common.c           | 17 ++++++++++-------
hw/scsi/vhost-scsi.c                  |  5 +++--
hw/scsi/vhost-user-scsi.c             | 14 ++++++++------
include/hw/virtio/vhost-scsi-common.h |  2 +-
4 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index a61cd0e907..392587dfb5 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -16,6 +16,7 @@
*/

#include "qemu/osdep.h"
+#include "qapi/error.h"
#include "qemu/error-report.h"
#include "qemu/module.h"
#include "hw/virtio/vhost.h"
@@ -25,7 +26,7 @@
#include "hw/virtio/virtio-access.h"
#include "hw/fw-path-provider.h"

-int vhost_scsi_common_start(VHostSCSICommon *vsc)
+int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp)
{
int ret, i;
VirtIODevice *vdev =3D VIRTIO_DEVICE(vsc);
@@ -35,18 +36,19 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
VirtIOSCSICommon *vs =3D (VirtIOSCSICommon *)vsc;

if (!k->set_guest_notifiers) {
-        error_report("binding does not support guest notifiers");
+        error_setg(errp, "binding does not support guest notifiers");
    return -ENOSYS;
}

ret =3D vhost_dev_enable_notifiers(&vsc->dev, vdev);
if (ret < 0) {
+        error_setg_errno(errp, -ret, "Error enabling host notifiers");
    return ret;
}

ret =3D k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, true);
if (ret < 0) {
-        error_report("Error binding guest notifier");
+        error_setg_errno(errp, -ret, "Error binding guest notifier");
    goto err_host_notifiers;
}

@@ -54,7 +56,7 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)

ret =3D vhost_dev_prepare_inflight(&vsc->dev, vdev);
if (ret < 0) {
-        error_report("Error setting inflight format: %d", -ret);


Curious why you=E2=80=99re adding the error value to the string. Isn=E2=80=
=99t it redundant
since we pass it in as the second param?

+        error_setg_errno(errp, -ret, "Error setting inflight format: %d",
-ret);


I don=E2=80=99t understand. Here I put the error message in errp, where is
redundant?


The error message will come out like

 Error setting inflight format: 22: Invalid argument

You need to drop ": %d".

Two remarks:

1. The #1 reason for bad error messages is neglecting to *test* them.

2. Printing errno as a number is needlessly unfriendly to users.

[...]

Understood! Very thanks, I will fix it in the v2.

--00000000000018263706037bb04f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto" style=3D"line-break:after-white-space"><=
div><br><br><blockquote type=3D"cite">On 21 Aug 2023, at 8:09 PM, Markus Ar=
mbruster &lt;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@=
redhat.com</a>&gt; wrote:<br><br>Li Feng &lt;<a href=3D"mailto:fengli@smart=
x.com" target=3D"_blank">fengli@smartx.com</a>&gt; writes:<br><br><blockquo=
te type=3D"cite"><blockquote type=3D"cite">2023=E5=B9=B48=E6=9C=8814=E6=97=
=A5 =E4=B8=8B=E5=8D=888:11=EF=BC=8CRaphael Norwitz &lt;<a href=3D"mailto:ra=
phael.norwitz@nutanix.com" target=3D"_blank">raphael.norwitz@nutanix.com</a=
>&gt; =E5=86=99=E9=81=93=EF=BC=9A<br><br>Thanks for the cleanup! A few comm=
ents.<br><br><blockquote type=3D"cite">On Aug 4, 2023, at 1:29 AM, Li Feng =
&lt;<a href=3D"mailto:fengli@smartx.com" target=3D"_blank">fengli@smartx.co=
m</a>&gt; wrote:<br><br>Add a Error parameter to report the real error, lik=
e vhost-user-blk.<br><br>Signed-off-by: Li Feng &lt;<a href=3D"mailto:fengl=
i@smartx.com" target=3D"_blank">fengli@smartx.com</a>&gt;<br>---<br>hw/scsi=
/vhost-scsi-common.c =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0| 17 ++++++++++-------<br>hw/scsi/vhost-scsi.c =C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0| =C2=A05 +++--<br>hw/scsi/vhost-user-scsi.c =C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 14 ++++++++------<br>incl=
ude/hw/virtio/vhost-scsi-common.h | =C2=A02 +-<br>4 files changed, 22 inser=
tions(+), 16 deletions(-)<br><br>diff --git a/hw/scsi/vhost-scsi-common.c b=
/hw/scsi/vhost-scsi-common.c<br>index a61cd0e907..392587dfb5 100644<br>--- =
a/hw/scsi/vhost-scsi-common.c<br>+++ b/hw/scsi/vhost-scsi-common.c<br>@@ -1=
6,6 +16,7 @@<br>*/<br><br>#include &quot;qemu/osdep.h&quot;<br>+#include &q=
uot;qapi/error.h&quot;<br>#include &quot;qemu/error-report.h&quot;<br>#incl=
ude &quot;qemu/module.h&quot;<br>#include &quot;hw/virtio/vhost.h&quot;<br>=
@@ -25,7 +26,7 @@<br>#include &quot;hw/virtio/virtio-access.h&quot;<br>#inc=
lude &quot;hw/fw-path-provider.h&quot;<br><br>-int vhost_scsi_common_start(=
VHostSCSICommon *vsc)<br>+int vhost_scsi_common_start(VHostSCSICommon *vsc,=
 Error **errp)<br>{<br> int ret, i;<br> VirtIODevice *vdev =3D VIRTIO_DEVIC=
E(vsc);<br>@@ -35,18 +36,19 @@ int vhost_scsi_common_start(VHostSCSICommon =
*vsc)<br> VirtIOSCSICommon *vs =3D (VirtIOSCSICommon *)vsc;<br><br> if (!k-=
&gt;set_guest_notifiers) {<br>- =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0e=
rror_report(&quot;binding does not support guest notifiers&quot;);<br>+ =C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_setg(errp, &quot;binding does =
not support guest notifiers&quot;);<br> =C2=A0=C2=A0=C2=A0=C2=A0return -ENO=
SYS;<br> }<br><br> ret =3D vhost_dev_enable_notifiers(&amp;vsc-&gt;dev, vde=
v);<br> if (ret &lt; 0) {<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0er=
ror_setg_errno(errp, -ret, &quot;Error enabling host notifiers&quot;);<br> =
=C2=A0=C2=A0=C2=A0=C2=A0return ret;<br> }<br><br> ret =3D k-&gt;set_guest_n=
otifiers(qbus-&gt;parent, vsc-&gt;dev.nvqs, true);<br> if (ret &lt; 0) {<br=
>- =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_report(&quot;Error bindi=
ng guest notifier&quot;);<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0er=
ror_setg_errno(errp, -ret, &quot;Error binding guest notifier&quot;);<br> =
=C2=A0=C2=A0=C2=A0=C2=A0goto err_host_notifiers;<br> }<br><br>@@ -54,7 +56,=
7 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)<br><br> ret =3D vhos=
t_dev_prepare_inflight(&amp;vsc-&gt;dev, vdev);<br> if (ret &lt; 0) {<br>- =
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_report(&quot;Error setting =
inflight format: %d&quot;, -ret);<br></blockquote><br>Curious why you=E2=80=
=99re adding the error value to the string. Isn=E2=80=99t it redundant sinc=
e we pass it in as the second param?<br><br><blockquote type=3D"cite">+ =C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_setg_errno(errp, -ret, &quot;E=
rror setting inflight format: %d&quot;, -ret);<br></blockquote></blockquote=
><br>I don=E2=80=99t understand. Here I put the error message in errp, wher=
e is redundant?<br></blockquote><br>The error message will come out like<br=
><br> =C2=A0Error setting inflight format: 22: Invalid argument<br><br>You =
need to drop &quot;: %d&quot;.<br><br>Two remarks:<br><br>1. The #1 reason =
for bad error messages is neglecting to *test* them.<br><br>2. Printing err=
no as a number is needlessly unfriendly to users.<br><br>[...]<br><br></blo=
ckquote>Understood! Very thanks, I will fix it in the v2.<br><br></div></di=
v></div>

--00000000000018263706037bb04f--

