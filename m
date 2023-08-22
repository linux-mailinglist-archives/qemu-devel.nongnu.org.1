Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0827838E9
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 06:51:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYJM5-0001O5-Vx; Tue, 22 Aug 2023 00:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qYJLz-0001Lu-3G
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:50:55 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qYJLw-0004tR-4s
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:50:54 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99c4923195dso523288066b.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 21:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1692679729; x=1693284529;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c2CXrnqyH5UmybjqCIDfRdsw0i037XnkTicpJkhOVDA=;
 b=LH3ruYDKl1go4B9AR7/vGjg5ulKL62OKwQANM177GD4Wn3l50zWIBbYCU/c6YlmGzg
 MdLbc9OTj6P/oER2w9Ejc+tYwvHUGxzf0bF6f74q5zdy2qcgLQvPXJZ7g+RXVBcD8g1m
 soDL/GuR8Vhye7bgUhu4KIE+BV1GS0l0ye3O3TtdBQVRA1g6wRG01qESNC4hKpXfXfem
 fEttARUruazloJPvk4DrmzR4/QTCIZCLwtlsY0/A3PjaPu+CXZjZak0ZvImutA2Q4JxA
 cC4L7GYM1TU1WnB5xYdv0jtDnvVV3BYT3BujgfIQEtCKWnkOaF3561Lyda5bBgYpS9xw
 iOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692679729; x=1693284529;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c2CXrnqyH5UmybjqCIDfRdsw0i037XnkTicpJkhOVDA=;
 b=TUGiPjt5m3UZgoVuC3Fk6CG9YzXKR9krd7IV6IK4w/PdHH86bVMkCKuhM6pU2/AzgQ
 P2dDiEQ+KwqFZpgjWWG+HT6BIWRpVMtBCz8eLBL1yzKSOzO+vNFvBvo5Ny94Qsu8qxhI
 VKKCkMIe64YXLY0DBhXuwDkJ3952Vkgsh3wL1Jbsdiv6NElCKd4tSBh8Fsj9R/jRYTxl
 uNWHZsy1dAV8a5E7kdoR+ISo/9MwQ2jFF3WzbrjMhsbtDtj9FrNz18YoXIaAVG12L63u
 XPuWMlYL4u5Z7Fg3rUm291v4wSA9VHs+qnIY/KrITuqtF3XxXOprVP7kzTBGMUPR1+W6
 XisQ==
X-Gm-Message-State: AOJu0Yxr7wjy7z5Hm4aU57kuYKK/wPAK6ex39YESMKyYHWsJ5IFH4M3Z
 QeSTWBfS6hFoP0v/TlI40ZNAFzNDjlSBmb5RISUBsA==
X-Google-Smtp-Source: AGHT+IH2rwXE8ThnKfsJhTtBDvTiJ1uIMKHoFNGMhcJ/h0KmpeWDZQPSnai/dXF8w8okg4v8DVa5EZkSe+zV0UzWYB0=
X-Received: by 2002:a17:906:31c1:b0:99d:a6b9:fd04 with SMTP id
 f1-20020a17090631c100b0099da6b9fd04mr6227095ejf.46.1692679728725; Mon, 21 Aug
 2023 21:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230804052954.2918915-2-fengli@smartx.com>
 <894CEF7E-9523-444F-8459-330BE4236B7A@nutanix.com>
 <F0FCF1EC-8E24-4515-A800-BD01D9D3D526@smartx.com>
 <2D662C4C-B636-453A-B2D0-F4EDA4B43041@nutanix.com>
In-Reply-To: <2D662C4C-B636-453A-B2D0-F4EDA4B43041@nutanix.com>
From: Li Feng <fengli@smartx.com>
Date: Tue, 22 Aug 2023 12:49:38 +0800
Message-ID: <CAHckoCxZFe78ghhuxrxF-SzO4XHvAOry993f-rH+kFdK6OPE0w@mail.gmail.com>
Subject: Re: [PATCH 1/2] vhost-user: fix lost reconnect
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000f312ed06037bb54a"
Received-SPF: none client-ip=2a00:1450:4864:20::632;
 envelope-from=fengli@smartx.com; helo=mail-ej1-x632.google.com
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

--000000000000f312ed06037bb54a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 22 Aug 2023, at 8:38 AM, Raphael Norwitz <raphael.norwitz@nutanix.com>
wrote:


On Aug 17, 2023, at 2:40 AM, Li Feng <fengli@smartx.com> wrote:


2023=E5=B9=B48=E6=9C=8814=E6=97=A5 =E4=B8=8B=E5=8D=888:11=EF=BC=8CRaphael N=
orwitz <raphael.norwitz@nutanix.com> =E5=86=99=E9=81=93=EF=BC=9A

Why can=E2=80=99t we rather fix this by adding a =E2=80=9Cevent_cb=E2=80=9D=
 param to
vhost_user_async_close and then call qemu_chr_fe_set_handlers in
vhost_user_async_close_bh()?

Even if calling vhost_dev_cleanup() twice is safe today I worry future
changes may easily stumble over the reconnect case and introduce crashes or
double frees.

I think add a new event_cb is not good enough. =E2=80=98qemu_chr_fe_set_han=
dlers=E2=80=99
has been called in vhost_user_async_close, and will be called in event->cb,
so why need add a
new event_cb?


I=E2=80=99m suggesting calling the data->event_cb instead of the data->cb i=
f we hit
the error case where vhost->vdev is NULL. Something like:

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 8dcf049d42..edf1dccd44 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2648,6 +2648,10 @@ typedef struct {
static void vhost_user_async_close_bh(void *opaque)
{
    VhostAsyncCallback *data =3D opaque;
+
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(data->dev);
+    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
+
    struct vhost_dev *vhost =3D data->vhost;

    /*
@@ -2657,6 +2661,9 @@ static void vhost_user_async_close_bh(void *opaque)
     */
    if (vhost->vdev) {
        data->cb(data->dev);
+    } else if (data->event_cb) {
+        qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, data->event_cb,
+                                 NULL, data->dev, NULL, true);
    }

    g_free(data);

data->event_cb would be vhost_user_blk_event().

I think that makes the error path a lot easier to reason about and more
future proof.

For avoiding to call the vhost_dev_cleanup() twice, add a =E2=80=98inited=
=E2=80=99 in
struct vhost-dev to mark if it=E2=80=99s inited like this:


This is better than the original, but let me know what you think of my
alternative.


The vhost_user_async_close_bh() is a common function in vhost-user.c, and
vhost_user_async_close() is used by vhost-user-scsi/blk/gpio,
However, in your patch it=E2=80=99s limited to VhostUserBlk, so I think my =
fix is
more reasonable.

Thanks,
LI


diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e2f6ffb446..edc80c0231 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1502,6 +1502,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void
*opaque,
       goto fail_busyloop;
   }

+    hdev->inited =3D true;
   return 0;

fail_busyloop:
@@ -1520,6 +1521,10 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
{
   int i;

+    if (!hdev->inited) {
+        return;
+    }
+    hdev->inited =3D false;
   trace_vhost_dev_cleanup(hdev);

   for (i =3D 0; i < hdev->nvqs; ++i) {
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index ca3131b1af..74b1aec960 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -123,6 +123,7 @@ struct vhost_dev {
   /* @started: is the vhost device started? */
   bool started;
   bool log_enabled;
+    bool inited;
   uint64_t log_size;
   Error *migration_blocker;
   const VhostOps *vhost_ops;

Thanks.


On Aug 4, 2023, at 1:29 AM, Li Feng <fengli@smartx.com> wrote:

When the vhost-user is reconnecting to the backend, and if the vhost-user
fails
at the get_features in vhost_dev_init(), then the reconnect will fail
and it will not be retriggered forever.

The reason is:
When the vhost-user fail at get_features, the vhost_dev_cleanup will be
called
immediately.

vhost_dev_cleanup calls 'memset(hdev, 0, sizeof(struct vhost_dev))'.

The reconnect path is:
vhost_user_blk_event
vhost_user_async_close(.. vhost_user_blk_disconnect ..)
 qemu_chr_fe_set_handlers <----- clear the notifier callback
   schedule vhost_user_async_close_bh

The vhost->vdev is null, so the vhost_user_blk_disconnect will not be
called, then the event fd callback will not be reinstalled.

With this patch, the vhost_user_blk_disconnect will call the
vhost_dev_cleanup() again, it's safe.

All vhost-user devices have this issue, including vhost-user-blk/scsi.

Fixes: 71e076a07d ("hw/virtio: generalise CHR_EVENT_CLOSED handling")

Signed-off-by: Li Feng <fengli@smartx.com>
---
hw/virtio/vhost-user.c | 10 +---------
1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 8dcf049d42..697b403fe2 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2648,16 +2648,8 @@ typedef struct {
static void vhost_user_async_close_bh(void *opaque)
{
 VhostAsyncCallback *data =3D opaque;
-    struct vhost_dev *vhost =3D data->vhost;

-    /*
-     * If the vhost_dev has been cleared in the meantime there is
-     * nothing left to do as some other path has completed the
-     * cleanup.
-     */
-    if (vhost->vdev) {
-        data->cb(data->dev);
-    }
+    data->cb(data->dev);

 g_free(data);
}
--=20
2.41.0

--000000000000f312ed06037bb54a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto" style=3D"line-break:after-white-space"><=
div style=3D"line-break:after-white-space"><br><div><br><blockquote type=3D=
"cite"><div>On 22 Aug 2023, at 8:38 AM, Raphael Norwitz &lt;<a href=3D"mail=
to:raphael.norwitz@nutanix.com" target=3D"_blank">raphael.norwitz@nutanix.c=
om</a>&gt; wrote:</div><br><div><blockquote type=3D"cite" style=3D"font-fam=
ily:Monaco;font-size:12px;font-style:normal;font-variant-caps:normal;font-w=
eight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-trans=
form:none;white-space:normal;word-spacing:0px;text-decoration:none"><br>On =
Aug 17, 2023, at 2:40 AM, Li Feng &lt;<a href=3D"mailto:fengli@smartx.com" =
target=3D"_blank">fengli@smartx.com</a>&gt; wrote:<br><br><br><blockquote t=
ype=3D"cite">2023=E5=B9=B48=E6=9C=8814=E6=97=A5 =E4=B8=8B=E5=8D=888:11=EF=
=BC=8CRaphael Norwitz &lt;<a href=3D"mailto:raphael.norwitz@nutanix.com" ta=
rget=3D"_blank">raphael.norwitz@nutanix.com</a>&gt; =E5=86=99=E9=81=93=EF=
=BC=9A<br><br>Why can=E2=80=99t we rather fix this by adding a =E2=80=9Ceve=
nt_cb=E2=80=9D param to vhost_user_async_close and then call qemu_chr_fe_se=
t_handlers in vhost_user_async_close_bh()?<br><br>Even if calling vhost_dev=
_cleanup() twice is safe today I worry future changes may easily stumble ov=
er the reconnect case and introduce crashes or double frees.<br><br></block=
quote>I think add a new event_cb is not good enough. =E2=80=98qemu_chr_fe_s=
et_handlers=E2=80=99 has been called in vhost_user_async_close, and will be=
 called in event-&gt;cb, so why need add a<br>new event_cb?<br><br></blockq=
uote><br style=3D"font-family:Monaco;font-size:12px;font-style:normal;font-=
variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;=
text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;tex=
t-decoration:none"><span style=3D"font-family:Monaco;font-size:12px;font-st=
yle:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;t=
ext-align:start;text-indent:0px;text-transform:none;white-space:normal;word=
-spacing:0px;text-decoration:none;float:none;display:inline!important">I=E2=
=80=99m suggesting calling the data-&gt;event_cb instead of the data-&gt;cb=
 if we hit the error case where vhost-&gt;vdev is NULL. Something like:</sp=
an><br style=3D"font-family:Monaco;font-size:12px;font-style:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-=
decoration:none"><br style=3D"font-family:Monaco;font-size:12px;font-style:=
normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-=
align:start;text-indent:0px;text-transform:none;white-space:normal;word-spa=
cing:0px;text-decoration:none"><span style=3D"font-family:Monaco;font-size:=
12px;font-style:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;white-space=
:normal;word-spacing:0px;text-decoration:none;float:none;display:inline!imp=
ortant">diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c</span>=
<br style=3D"font-family:Monaco;font-size:12px;font-style:normal;font-varia=
nt-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-=
indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-dec=
oration:none"><span style=3D"font-family:Monaco;font-size:12px;font-style:n=
ormal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-a=
lign:start;text-indent:0px;text-transform:none;white-space:normal;word-spac=
ing:0px;text-decoration:none;float:none;display:inline!important">index 8dc=
f049d42..edf1dccd44 100644</span><br style=3D"font-family:Monaco;font-size:=
12px;font-style:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;white-space=
:normal;word-spacing:0px;text-decoration:none"><span style=3D"font-family:M=
onaco;font-size:12px;font-style:normal;font-variant-caps:normal;font-weight=
:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:=
none;white-space:normal;word-spacing:0px;text-decoration:none;float:none;di=
splay:inline!important">--- a/hw/virtio/vhost-user.c</span><br style=3D"fon=
t-family:Monaco;font-size:12px;font-style:normal;font-variant-caps:normal;f=
ont-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;white-space:normal;word-spacing:0px;text-decoration:none"><s=
pan style=3D"font-family:Monaco;font-size:12px;font-style:normal;font-varia=
nt-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-=
indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-dec=
oration:none;float:none;display:inline!important">+++ b/hw/virtio/vhost-use=
r.c</span><br style=3D"font-family:Monaco;font-size:12px;font-style:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;text-decoration:none"><span style=3D"font-family:Monaco;font-size:12px;fo=
nt-style:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;white-space:normal=
;word-spacing:0px;text-decoration:none;float:none;display:inline!important"=
>@@ -2648,6 +2648,10 @@ typedef struct {</span><br style=3D"font-family:Mon=
aco;font-size:12px;font-style:normal;font-variant-caps:normal;font-weight:4=
00;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;text-decoration:none"><span style=3D=
"font-family:Monaco;font-size:12px;font-style:normal;font-variant-caps:norm=
al;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;white-space:normal;word-spacing:0px;text-decoration:none=
;float:none;display:inline!important">static void vhost_user_async_close_bh=
(void *opaque)</span><br style=3D"font-family:Monaco;font-size:12px;font-st=
yle:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;t=
ext-align:start;text-indent:0px;text-transform:none;white-space:normal;word=
-spacing:0px;text-decoration:none"><span style=3D"font-family:Monaco;font-s=
ize:12px;font-style:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-s=
pace:normal;word-spacing:0px;text-decoration:none;float:none;display:inline=
!important">{</span><br style=3D"font-family:Monaco;font-size:12px;font-sty=
le:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;te=
xt-align:start;text-indent:0px;text-transform:none;white-space:normal;word-=
spacing:0px;text-decoration:none"><span style=3D"font-family:Monaco;font-si=
ze:12px;font-style:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;text-decoration:none;float:none;display:inline!=
important">=C2=A0=C2=A0=C2=A0=C2=A0VhostAsyncCallback *data =3D opaque;</sp=
an><br style=3D"font-family:Monaco;font-size:12px;font-style:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-=
decoration:none"><span style=3D"font-family:Monaco;font-size:12px;font-styl=
e:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;text-decoration:none;float:none;display:inline!important">+</spa=
n><br style=3D"font-family:Monaco;font-size:12px;font-style:normal;font-var=
iant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;tex=
t-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-d=
ecoration:none"><span style=3D"font-family:Monaco;font-size:12px;font-style=
:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text=
-align:start;text-indent:0px;text-transform:none;white-space:normal;word-sp=
acing:0px;text-decoration:none;float:none;display:inline!important">+ =C2=
=A0=C2=A0=C2=A0VirtIODevice *vdev =3D VIRTIO_DEVICE(data-&gt;dev);</span><b=
r style=3D"font-family:Monaco;font-size:12px;font-style:normal;font-variant=
-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-in=
dent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decor=
ation:none"><span style=3D"font-family:Monaco;font-size:12px;font-style:nor=
mal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;white-space:normal;word-spacin=
g:0px;text-decoration:none;float:none;display:inline!important">+ =C2=A0=C2=
=A0=C2=A0VHostUserBlk *s =3D VHOST_USER_BLK(vdev);</span><br style=3D"font-=
family:Monaco;font-size:12px;font-style:normal;font-variant-caps:normal;fon=
t-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tr=
ansform:none;white-space:normal;word-spacing:0px;text-decoration:none"><spa=
n style=3D"font-family:Monaco;font-size:12px;font-style:normal;font-variant=
-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-in=
dent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decor=
ation:none;float:none;display:inline!important">+</span><br style=3D"font-f=
amily:Monaco;font-size:12px;font-style:normal;font-variant-caps:normal;font=
-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tra=
nsform:none;white-space:normal;word-spacing:0px;text-decoration:none"><span=
 style=3D"font-family:Monaco;font-size:12px;font-style:normal;font-variant-=
caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decora=
tion:none;float:none;display:inline!important">=C2=A0=C2=A0=C2=A0=C2=A0stru=
ct vhost_dev *vhost =3D data-&gt;vhost;</span><br style=3D"font-family:Mona=
co;font-size:12px;font-style:normal;font-variant-caps:normal;font-weight:40=
0;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;white-space:normal;word-spacing:0px;text-decoration:none"><br style=3D"fo=
nt-family:Monaco;font-size:12px;font-style:normal;font-variant-caps:normal;=
font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text=
-transform:none;white-space:normal;word-spacing:0px;text-decoration:none"><=
span style=3D"font-family:Monaco;font-size:12px;font-style:normal;font-vari=
ant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text=
-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-de=
coration:none;float:none;display:inline!important">=C2=A0=C2=A0=C2=A0=C2=A0=
/*</span><br style=3D"font-family:Monaco;font-size:12px;font-style:normal;f=
ont-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px=
;text-decoration:none"><span style=3D"font-family:Monaco;font-size:12px;fon=
t-style:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;white-space:normal;=
word-spacing:0px;text-decoration:none;float:none;display:inline!important">=
@@ -2657,6 +2661,9 @@ static void vhost_user_async_close_bh(void *opaque)</=
span><br style=3D"font-family:Monaco;font-size:12px;font-style:normal;font-=
variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;=
text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;tex=
t-decoration:none"><span style=3D"font-family:Monaco;font-size:12px;font-st=
yle:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;t=
ext-align:start;text-indent:0px;text-transform:none;white-space:normal;word=
-spacing:0px;text-decoration:none;float:none;display:inline!important">=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0*/</span><br style=3D"font-family:Monaco;font-si=
ze:12px;font-style:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;text-decoration:none"><span style=3D"font-famil=
y:Monaco;font-size:12px;font-style:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;text-decoration:none;float:none=
;display:inline!important">=C2=A0=C2=A0=C2=A0=C2=A0if (vhost-&gt;vdev) {</s=
pan><br style=3D"font-family:Monaco;font-size:12px;font-style:normal;font-v=
ariant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;t=
ext-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text=
-decoration:none"><span style=3D"font-family:Monaco;font-size:12px;font-sty=
le:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;te=
xt-align:start;text-indent:0px;text-transform:none;white-space:normal;word-=
spacing:0px;text-decoration:none;float:none;display:inline!important">=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data-&gt;cb(data-&gt;dev);</sp=
an><br style=3D"font-family:Monaco;font-size:12px;font-style:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-=
decoration:none"><span style=3D"font-family:Monaco;font-size:12px;font-styl=
e:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;text-decoration:none;float:none;display:inline!important">+ =C2=
=A0=C2=A0=C2=A0} else if (data-&gt;event_cb) {</span><br style=3D"font-fami=
ly:Monaco;font-size:12px;font-style:normal;font-variant-caps:normal;font-we=
ight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transf=
orm:none;white-space:normal;word-spacing:0px;text-decoration:none"><span st=
yle=3D"font-family:Monaco;font-size:12px;font-style:normal;font-variant-cap=
s:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoratio=
n:none;float:none;display:inline!important">+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0qemu_chr_fe_set_handlers(&amp;s-&gt;chardev, NULL, NULL, dat=
a-&gt;event_cb,</span><br style=3D"font-family:Monaco;font-size:12px;font-s=
tyle:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;text-decoration:none"><span style=3D"font-family:Monaco;font-=
size:12px;font-style:normal;font-variant-caps:normal;font-weight:400;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-=
space:normal;word-spacing:0px;text-decoration:none;float:none;display:inlin=
e!important">+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NULL, data-&gt;dev=
, NULL, true);</span><br style=3D"font-family:Monaco;font-size:12px;font-st=
yle:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;t=
ext-align:start;text-indent:0px;text-transform:none;white-space:normal;word=
-spacing:0px;text-decoration:none"><span style=3D"font-family:Monaco;font-s=
ize:12px;font-style:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-s=
pace:normal;word-spacing:0px;text-decoration:none;float:none;display:inline=
!important">=C2=A0=C2=A0=C2=A0=C2=A0}</span><br style=3D"font-family:Monaco=
;font-size:12px;font-style:normal;font-variant-caps:normal;font-weight:400;=
letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;=
white-space:normal;word-spacing:0px;text-decoration:none"><br style=3D"font=
-family:Monaco;font-size:12px;font-style:normal;font-variant-caps:normal;fo=
nt-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-t=
ransform:none;white-space:normal;word-spacing:0px;text-decoration:none"><sp=
an style=3D"font-family:Monaco;font-size:12px;font-style:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-deco=
ration:none;float:none;display:inline!important">=C2=A0=C2=A0=C2=A0=C2=A0g_=
free(data);</span><br style=3D"font-family:Monaco;font-size:12px;font-style=
:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text=
-align:start;text-indent:0px;text-transform:none;white-space:normal;word-sp=
acing:0px;text-decoration:none"><br style=3D"font-family:Monaco;font-size:1=
2px;font-style:normal;font-variant-caps:normal;font-weight:400;letter-spaci=
ng:normal;text-align:start;text-indent:0px;text-transform:none;white-space:=
normal;word-spacing:0px;text-decoration:none"><span style=3D"font-family:Mo=
naco;font-size:12px;font-style:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;white-space:normal;word-spacing:0px;text-decoration:none;float:none;dis=
play:inline!important">data-&gt;event_cb would be vhost_user_blk_event().</=
span><br style=3D"font-family:Monaco;font-size:12px;font-style:normal;font-=
variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;=
text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;tex=
t-decoration:none"><br style=3D"font-family:Monaco;font-size:12px;font-styl=
e:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;text-decoration:none"><span style=3D"font-family:Monaco;font-siz=
e:12px;font-style:normal;font-variant-caps:normal;font-weight:400;letter-sp=
acing:normal;text-align:start;text-indent:0px;text-transform:none;white-spa=
ce:normal;word-spacing:0px;text-decoration:none;float:none;display:inline!i=
mportant">I think that makes the error path a lot easier to reason about an=
d more future proof.</span><br style=3D"font-family:Monaco;font-size:12px;f=
ont-style:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;text-decoration:none"><br style=3D"font-family:Monaco;fo=
nt-size:12px;font-style:normal;font-variant-caps:normal;font-weight:400;let=
ter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whi=
te-space:normal;word-spacing:0px;text-decoration:none"><blockquote type=3D"=
cite" style=3D"font-family:Monaco;font-size:12px;font-style:normal;font-var=
iant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;tex=
t-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-d=
ecoration:none">For avoiding to call the vhost_dev_cleanup() twice, add a =
=E2=80=98inited=E2=80=99 in struct vhost-dev to mark if it=E2=80=99s inited=
 like this:<br><br></blockquote><br style=3D"font-family:Monaco;font-size:1=
2px;font-style:normal;font-variant-caps:normal;font-weight:400;letter-spaci=
ng:normal;text-align:start;text-indent:0px;text-transform:none;white-space:=
normal;word-spacing:0px;text-decoration:none"><span style=3D"font-family:Mo=
naco;font-size:12px;font-style:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;white-space:normal;word-spacing:0px;text-decoration:none;float:none;dis=
play:inline!important">This is better than the original, but let me know wh=
at you think of my alternative.</span><br style=3D"font-family:Monaco;font-=
size:12px;font-style:normal;font-variant-caps:normal;font-weight:400;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-=
space:normal;word-spacing:0px;text-decoration:none"></div></blockquote><div=
><br></div>The vhost_user_async_close_bh() is a common function in vhost-us=
er.c, and vhost_user_async_close() is used by vhost-user-scsi/blk/gpio,=C2=
=A0</div><div>However, in your patch it=E2=80=99s limited to VhostUserBlk, =
so I think my fix is more reasonable.</div><div><br></div><div>Thanks,</div=
><div>LI</div><div><blockquote type=3D"cite"><div><br style=3D"font-family:=
Monaco;font-size:12px;font-style:normal;font-variant-caps:normal;font-weigh=
t:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform=
:none;white-space:normal;word-spacing:0px;text-decoration:none"><blockquote=
 type=3D"cite" style=3D"font-family:Monaco;font-size:12px;font-style:normal=
;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:=
start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0=
px;text-decoration:none">diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c=
<br>index e2f6ffb446..edc80c0231 100644<br>--- a/hw/virtio/vhost.c<br>+++ b=
/hw/virtio/vhost.c<br>@@ -1502,6 +1502,7 @@ int vhost_dev_init(struct vhost=
_dev *hdev, void *opaque,<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto=
 fail_busyloop;<br>=C2=A0=C2=A0=C2=A0}<br><br>+ =C2=A0=C2=A0=C2=A0hdev-&gt;=
inited =3D true;<br>=C2=A0=C2=A0=C2=A0return 0;<br><br>fail_busyloop:<br>@@=
 -1520,6 +1521,10 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)<br>{<br=
>=C2=A0=C2=A0=C2=A0int i;<br><br>+ =C2=A0=C2=A0=C2=A0if (!hdev-&gt;inited) =
{<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;<br>+ =C2=A0=C2=A0=
=C2=A0}<br>+ =C2=A0=C2=A0=C2=A0hdev-&gt;inited =3D false;<br>=C2=A0=C2=A0=
=C2=A0trace_vhost_dev_cleanup(hdev);<br><br>=C2=A0=C2=A0=C2=A0for (i =3D 0;=
 i &lt; hdev-&gt;nvqs; ++i) {<br>diff --git a/include/hw/virtio/vhost.h b/i=
nclude/hw/virtio/vhost.h<br>index ca3131b1af..74b1aec960 100644<br>--- a/in=
clude/hw/virtio/vhost.h<br>+++ b/include/hw/virtio/vhost.h<br>@@ -123,6 +12=
3,7 @@ struct vhost_dev {<br>=C2=A0=C2=A0=C2=A0/* @started: is the vhost de=
vice started? */<br>=C2=A0=C2=A0=C2=A0bool started;<br>=C2=A0=C2=A0=C2=A0bo=
ol log_enabled;<br>+ =C2=A0=C2=A0=C2=A0bool inited;<br>=C2=A0=C2=A0=C2=A0ui=
nt64_t log_size;<br>=C2=A0=C2=A0=C2=A0Error *migration_blocker;<br>=C2=A0=
=C2=A0=C2=A0const VhostOps *vhost_ops;<br><br>Thanks.<br><br><blockquote ty=
pe=3D"cite"><br><blockquote type=3D"cite">On Aug 4, 2023, at 1:29 AM, Li Fe=
ng &lt;<a href=3D"mailto:fengli@smartx.com" target=3D"_blank">fengli@smartx=
.com</a>&gt; wrote:<br><br>When the vhost-user is reconnecting to the backe=
nd, and if the vhost-user fails<br>at the get_features in vhost_dev_init(),=
 then the reconnect will fail<br>and it will not be retriggered forever.<br=
><br>The reason is:<br>When the vhost-user fail at get_features, the vhost_=
dev_cleanup will be called<br>immediately.<br><br>vhost_dev_cleanup calls &=
#39;memset(hdev, 0, sizeof(struct vhost_dev))&#39;.<br><br>The reconnect pa=
th is:<br>vhost_user_blk_event<br>vhost_user_async_close(.. vhost_user_blk_=
disconnect ..)<br>=C2=A0qemu_chr_fe_set_handlers &lt;----- clear the notifi=
er callback<br>=C2=A0=C2=A0=C2=A0schedule vhost_user_async_close_bh<br><br>=
The vhost-&gt;vdev is null, so the vhost_user_blk_disconnect will not be<br=
>called, then the event fd callback will not be reinstalled.<br><br>With th=
is patch, the vhost_user_blk_disconnect will call the<br>vhost_dev_cleanup(=
) again, it&#39;s safe.<br><br>All vhost-user devices have this issue, incl=
uding vhost-user-blk/scsi.<br><br>Fixes: 71e076a07d (&quot;hw/virtio: gener=
alise CHR_EVENT_CLOSED handling&quot;)<br><br>Signed-off-by: Li Feng &lt;<a=
 href=3D"mailto:fengli@smartx.com" target=3D"_blank">fengli@smartx.com</a>&=
gt;<br>---<br>hw/virtio/vhost-user.c | 10 +---------<br>1 file changed, 1 i=
nsertion(+), 9 deletions(-)<br><br>diff --git a/hw/virtio/vhost-user.c b/hw=
/virtio/vhost-user.c<br>index 8dcf049d42..697b403fe2 100644<br>--- a/hw/vir=
tio/vhost-user.c<br>+++ b/hw/virtio/vhost-user.c<br>@@ -2648,16 +2648,8 @@ =
typedef struct {<br>static void vhost_user_async_close_bh(void *opaque)<br>=
{<br>=C2=A0VhostAsyncCallback *data =3D opaque;<br>- =C2=A0=C2=A0=C2=A0stru=
ct vhost_dev *vhost =3D data-&gt;vhost;<br><br>- =C2=A0=C2=A0=C2=A0/*<br>- =
=C2=A0=C2=A0=C2=A0=C2=A0* If the vhost_dev has been cleared in the meantime=
 there is<br>- =C2=A0=C2=A0=C2=A0=C2=A0* nothing left to do as some other p=
ath has completed the<br>- =C2=A0=C2=A0=C2=A0=C2=A0* cleanup.<br>- =C2=A0=
=C2=A0=C2=A0=C2=A0*/<br>- =C2=A0=C2=A0=C2=A0if (vhost-&gt;vdev) {<br>- =C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data-&gt;cb(data-&gt;dev);<br>- =C2=
=A0=C2=A0=C2=A0}<br>+ =C2=A0=C2=A0=C2=A0data-&gt;cb(data-&gt;dev);<br><br>=
=C2=A0g_free(data);<br>}<br>--<span>=C2=A0</span><br>2.41.0</blockquote></b=
lockquote></blockquote></div></blockquote></div><br></div></div></div>

--000000000000f312ed06037bb54a--

