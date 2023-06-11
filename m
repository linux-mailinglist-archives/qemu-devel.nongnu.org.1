Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B4972B3DC
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 21:52:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8R6A-0003Fw-1z; Sun, 11 Jun 2023 15:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q8R64-0003FX-GC; Sun, 11 Jun 2023 15:51:32 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q8R62-0001p8-KH; Sun, 11 Jun 2023 15:51:32 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-bb167972cffso4106638276.1; 
 Sun, 11 Jun 2023 12:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686513089; x=1689105089;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vk4VpIncPLAIpKaRwr8sD+lAj3oHOOWDbZBX8QX9Blk=;
 b=occ6YVburNZS7KVO+lgNsojc2BLXKHeyfhGs42ErxG9IgGDjeqfi+wCKReqZlaM1Cl
 DR9rPp1s0+s8vdv6oUS27KV9AxaI17aSqEpYb/wQerv7BQHiRGMUFoyf/JeF6M4xZ7gr
 ozYtpD+MxV0PVzBh96GPzs9JXdDtug6lJde6uUU2+LbPTtGI6/bMFNEYI+WYupb+8TYp
 JFAEsI8sdnzOCMSLXL1NBpPk9GmRP0Lu9vBGd2jYtNBI1Ozpr2c5CWuPbGjW7L8qZRN/
 eEPtceaUucs+ZY0y/MGlXoyGQ1Dh3rThxqQgezeYSEaxKwql8mcGyN7PXiolYCO6AzS6
 xnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686513089; x=1689105089;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vk4VpIncPLAIpKaRwr8sD+lAj3oHOOWDbZBX8QX9Blk=;
 b=hA3eBPU2yfaEB4jn1tk403/XeYud+Tpv9arzPoV9E5jMoYIiK57GwSTUJ3p+R7t1v3
 9jRUlOPeSkKZpjHHGwuVIMAXMmTyt++oyxlyB0jeQgANiR1HWjAocZkxYJyMAi+SvqYS
 WLodLcSiYMslRuB6dypmqLV5Lqw19DSdXLVAKcMs3HMG7UXRFfoOpt1RrKpL/SvSi2TU
 XxBgLUnfY9H7eM5E5gZ1IeGlI137mWTGE65EmdrUZMXf/MElrbf9KX5/Av+BKrUMBpAX
 R8ZSvCEkKJ7i48KXY803h9wUdcBNktiz91tgxwmyUFXgUGf8+JEue6FXksRRxHCcLojF
 kSdg==
X-Gm-Message-State: AC+VfDzoHFs/ev1aayQI+/lhtia17Dg3mi+27nlq0KO1btVGuudzNDlx
 XEsqTVosgzGMhe+J+EnNfUDc1zyIRCMKNPnoOY0=
X-Google-Smtp-Source: ACHHUZ7LpX3z4beQ3iZPGYxW1iJUuGJxLanlaJFUSBdh/RPWLx+6Lvyw3WHOEcKdlMWu3M/k6BNBY1JKoISVo4s9Yf8=
X-Received: by 2002:a0d:c782:0:b0:565:ee22:5c25 with SMTP id
 j124-20020a0dc782000000b00565ee225c25mr7930810ywd.30.1686513088785; Sun, 11
 Jun 2023 12:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230611193924.2444914-1-stefanha@redhat.com>
In-Reply-To: <20230611193924.2444914-1-stefanha@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 11 Jun 2023 15:51:17 -0400
Message-ID: <CAJSP0QXxzD2jSjuWwSxW7S3quWHThHp4+ZqRf5bYmjsJOun08Q@mail.gmail.com>
Subject: Re: [PATCH] virtio-scsi: avoid dangling host notifier in
 ->ioeventfd_stop()
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu block <qemu-block@nongnu.org>,
 Fam Zheng <fam@euphon.net>, Jean-Louis Dupond <jean-louis@dupond.be>
Content-Type: multipart/alternative; boundary="00000000000090f26005fddfedcc"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=stefanha@gmail.com; helo=mail-yb1-xb29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000090f26005fddfedcc
Content-Type: text/plain; charset="UTF-8"

Buglink: https://gitlab.com/qemu-project/qemu/-/issues/1680

On Sun, Jun 11, 2023, 15:39 Stefan Hajnoczi <stefanha@redhat.com> wrote:

> virtio_scsi_dataplane_stop() calls blk_drain_all(), which invokes
> ->drained_begin()/->drained_end() after we've already detached the host
> notifier. virtio_scsi_drained_end() currently attaches the host notifier
> again and leaves it dangling after dataplane has stopped.
>
> This results in the following assertion failure because
> virtio_scsi_defer_to_dataplane() is called from the IOThread instead of
> the main loop thread:
>
>   qemu-system-x86_64: ../softmmu/memory.c:1111:
> memory_region_transaction_commit: Assertion `qemu_mutex_iothread_locked()'
> failed.
>
> Reported-by: Jean-Louis Dupond <jean-louis@dupond.be>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/scsi/virtio-scsi.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 9c8ef0aaa6..45b95ea070 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -1125,7 +1125,16 @@ static void virtio_scsi_drained_begin(SCSIBus *bus)
>      uint32_t total_queues = VIRTIO_SCSI_VQ_NUM_FIXED +
>                              s->parent_obj.conf.num_queues;
>
> -    if (!s->dataplane_started) {
> +    /*
> +     * Drain is called when stopping dataplane but the host notifier has
> +     * already been detached. Detaching multiple times is a no-op if
> nothing
> +     * else is using the monitoring same file descriptor, but avoid it
> just in
> +     * case.
> +     *
> +     * Also, don't detach if dataplane has not even been started yet
> because
> +     * the host notifier isn't attached.
> +     */
> +    if (s->dataplane_stopping || !s->dataplane_started) {
>          return;
>      }
>
> @@ -1143,7 +1152,14 @@ static void virtio_scsi_drained_end(SCSIBus *bus)
>      uint32_t total_queues = VIRTIO_SCSI_VQ_NUM_FIXED +
>                              s->parent_obj.conf.num_queues;
>
> -    if (!s->dataplane_started) {
> +    /*
> +     * Drain is called when stopping dataplane. Keep the host notifier
> detached
> +     * so it's not left dangling after dataplane is stopped.
> +     *
> +     * Also, don't attach if dataplane has not even been started yet.
> We're not
> +     * ready.
> +     */
> +    if (s->dataplane_stopping || !s->dataplane_started) {
>          return;
>      }
>
> --
> 2.40.1
>
>
>

--00000000000090f26005fddfedcc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Buglink:=C2=A0<a href=3D"https://gitlab.com/qemu-project/=
qemu/-/issues/1680">https://gitlab.com/qemu-project/qemu/-/issues/1680</a><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Sun, Jun 11, 2023, 15:39 Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@r=
edhat.com">stefanha@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">virtio_scsi_dataplane_stop() calls blk_drain_all(), which invoke=
s<br>
-&gt;drained_begin()/-&gt;drained_end() after we&#39;ve already detached th=
e host<br>
notifier. virtio_scsi_drained_end() currently attaches the host notifier<br=
>
again and leaves it dangling after dataplane has stopped.<br>
<br>
This results in the following assertion failure because<br>
virtio_scsi_defer_to_dataplane() is called from the IOThread instead of<br>
the main loop thread:<br>
<br>
=C2=A0 qemu-system-x86_64: ../softmmu/memory.c:1111: memory_region_transact=
ion_commit: Assertion `qemu_mutex_iothread_locked()&#39; failed.<br>
<br>
Reported-by: Jean-Louis Dupond &lt;<a href=3D"mailto:jean-louis@dupond.be" =
target=3D"_blank" rel=3D"noreferrer">jean-louis@dupond.be</a>&gt;<br>
Signed-off-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/scsi/virtio-scsi.c | 20 ++++++++++++++++++--<br>
=C2=A01 file changed, 18 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c<br>
index 9c8ef0aaa6..45b95ea070 100644<br>
--- a/hw/scsi/virtio-scsi.c<br>
+++ b/hw/scsi/virtio-scsi.c<br>
@@ -1125,7 +1125,16 @@ static void virtio_scsi_drained_begin(SCSIBus *bus)<=
br>
=C2=A0 =C2=A0 =C2=A0uint32_t total_queues =3D VIRTIO_SCSI_VQ_NUM_FIXED +<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;parent_obj.conf.num_queues;<br>
<br>
-=C2=A0 =C2=A0 if (!s-&gt;dataplane_started) {<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Drain is called when stopping dataplane but the host=
 notifier has<br>
+=C2=A0 =C2=A0 =C2=A0* already been detached. Detaching multiple times is a=
 no-op if nothing<br>
+=C2=A0 =C2=A0 =C2=A0* else is using the monitoring same file descriptor, b=
ut avoid it just in<br>
+=C2=A0 =C2=A0 =C2=A0* case.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* Also, don&#39;t detach if dataplane has not even bee=
n started yet because<br>
+=C2=A0 =C2=A0 =C2=A0* the host notifier isn&#39;t attached.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (s-&gt;dataplane_stopping || !s-&gt;dataplane_started) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -1143,7 +1152,14 @@ static void virtio_scsi_drained_end(SCSIBus *bus)<br=
>
=C2=A0 =C2=A0 =C2=A0uint32_t total_queues =3D VIRTIO_SCSI_VQ_NUM_FIXED +<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;parent_obj.conf.num_queues;<br>
<br>
-=C2=A0 =C2=A0 if (!s-&gt;dataplane_started) {<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Drain is called when stopping dataplane. Keep the ho=
st notifier detached<br>
+=C2=A0 =C2=A0 =C2=A0* so it&#39;s not left dangling after dataplane is sto=
pped.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* Also, don&#39;t attach if dataplane has not even bee=
n started yet. We&#39;re not<br>
+=C2=A0 =C2=A0 =C2=A0* ready.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (s-&gt;dataplane_stopping || !s-&gt;dataplane_started) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.40.1<br>
<br>
<br>
</blockquote></div>

--00000000000090f26005fddfedcc--

