Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 326DB76F360
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 21:25:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRdv9-0006we-8k; Thu, 03 Aug 2023 15:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qRdv7-0006wM-Jz
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 15:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qRdv5-0007bg-T6
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 15:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691090613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=or0t88r4PbJdpXbrWHWXweK+AAswnVkxq1Jtckh9sTM=;
 b=Zy53pfat3TYn+PLyDS8aLAb+TAqjKSaqEy01MWcckRontTxUYoVBw6LU2xw8Zw4uHZkS2j
 0JHhSvvrObFCDZ32A2TfiUQhgxxqOPL/xQDwIR4MLV8KuD5k+jo1wmXiDD8zQaUBULpH5t
 O93O5Dba1KrcMpUmQZx1C+/Wy/5yiBo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-Lq7szy4XNdGNNLM4V50DTA-1; Thu, 03 Aug 2023 15:23:31 -0400
X-MC-Unique: Lq7szy4XNdGNNLM4V50DTA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ba0f27a4c9so11700811fa.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 12:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691090610; x=1691695410;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=or0t88r4PbJdpXbrWHWXweK+AAswnVkxq1Jtckh9sTM=;
 b=WEniQiuM2vQRhInJpP3bJB/+ocV6eu5pNxFMmtE2z60v1S2Zwr0CDZ9pX2bGs4e6RX
 e/nagOVZLHUVPLTWl/G14o5vQzKgx3xOgBDoN5bmZ2ceNOhXi6OKfdFJZ0v+dJQ0Enik
 J98yFPMa2trWbZKeXg1Pm6/O3Nj2lj/OxPbSkqLCy4qgPsP2qsIgMzvBTLFGL6IL/XIJ
 9EfUCxaeO6GJvbuwp/GfOi+Zvfks2sE7JDC72S1SvZU/or9/XiHmcGaNZnooUllnnzub
 2JZl9zCnm9XVSV0l+JpaqmWpGicbFtRJJyPhDJzbAI5bhH0QcpKBE2Ql8jJk2IdrRHzo
 MzMw==
X-Gm-Message-State: ABy/qLZFv2FWz1Qdj2EDI6aztzV9shln5r8ytjec8B0MfwbPiT4xOuQz
 i71SVQcWzDgwG0GJNKZC5qTMsE++tSrueFBH+kPF5+Pnb37c0VAaQ/xTVZ6mDrnwsyfur/DMNpT
 t3Yhu65WmvL1oCPMxCLOJhWoG45RTjHs=
X-Received: by 2002:a05:6512:224a:b0:4f3:93d6:f969 with SMTP id
 i10-20020a056512224a00b004f393d6f969mr8139716lfu.59.1691090609913; 
 Thu, 03 Aug 2023 12:23:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFxwiH9JPOq1qL7BeRaJCTHeFdFla9xk8JeQ6cz7zo6sFoH6QrqqvhNGqMw+78XME7NfRYv9jmb+hLSMKkVKew=
X-Received: by 2002:a05:6512:224a:b0:4f3:93d6:f969 with SMTP id
 i10-20020a056512224a00b004f393d6f969mr8139709lfu.59.1691090609509; Thu, 03
 Aug 2023 12:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <mailman.213.1690396551.25301.qemu-devel@nongnu.org>
 <75578ecf-4aed-7201-ca83-83e2dd523403@intel.com>
In-Reply-To: <75578ecf-4aed-7201-ca83-83e2dd523403@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 3 Aug 2023 23:23:18 +0400
Message-ID: <CAMxuvawZtfb1zzGoUGXr=L4UVkv1HAranxKz0T=iu_Q5tiZdKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-gpu: reset gfx resources in main thread
To: 20230726173929.690601-3-marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi

On Thu, Aug 3, 2023 at 10:23=E2=80=AFPM Kim, Dongwon <dongwon.kim@intel.com=
> wrote:
>
> Looking good. By the way, what does 'BH' stand for?
>

BH: bottom-half, it's a kind of delayed callback.

> Acked-by: Dongwon Kim <dongwon.kim@intel.com>

thanks

>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Calling OpenGL from different threads can have bad consequences if not
> carefully reviewed. It's not generally supported. In my case, I was
> debugging a crash in glDeleteTextures from OPENGL32.DLL, where I asked
> qemu for gl=3Des, and thus ANGLE implementation was expected. libepoxy di=
d
> resolution of the global pointer for glGenTexture to the GLES version
> from the main thread. But it resolved glDeleteTextures to the GL
> version, because it was done from a different thread without correct
> context. Oops.
>
> Let's stick to the main thread for GL calls by using a BH.
>
> Note: I didn't use atomics for reset_finished check, assuming the BQL
> will provide enough of sync, but I might be wrong.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   include/hw/virtio/virtio-gpu.h |  3 +++
>   hw/display/virtio-gpu.c        | 38 +++++++++++++++++++++++++++-------
>   2 files changed, 34 insertions(+), 7 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index 05bee09e1a..390c4642b8 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -169,6 +169,9 @@ struct VirtIOGPU {
>
>       QEMUBH *ctrl_bh;
>       QEMUBH *cursor_bh;
> +    QEMUBH *reset_bh;
> +    QemuCond reset_cond;
> +    bool reset_finished;
>
>       QTAILQ_HEAD(, virtio_gpu_simple_resource) reslist;
>       QTAILQ_HEAD(, virtio_gpu_ctrl_command) cmdq;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index b1f5d392bb..bbd5c6561a 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -14,6 +14,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/units.h"
>   #include "qemu/iov.h"
> +#include "sysemu/cpus.h"
>   #include "ui/console.h"
>   #include "trace.h"
>   #include "sysemu/dma.h"
> @@ -41,6 +42,7 @@ virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t r=
esource_id,
>
>   static void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
>                                          struct virtio_gpu_simple_resourc=
e *res);
> +static void virtio_gpu_reset_bh(void *opaque);
>
>   void virtio_gpu_update_cursor_data(VirtIOGPU *g,
>                                      struct virtio_gpu_scanout *s,
> @@ -1387,6 +1389,8 @@ void virtio_gpu_device_realize(DeviceState *qdev, E=
rror **errp)
>                                        &qdev->mem_reentrancy_guard);
>       g->cursor_bh =3D qemu_bh_new_guarded(virtio_gpu_cursor_bh, g,
>                                          &qdev->mem_reentrancy_guard);
> +    g->reset_bh =3D qemu_bh_new(virtio_gpu_reset_bh, g);
> +    qemu_cond_init(&g->reset_cond);
>       QTAILQ_INIT(&g->reslist);
>       QTAILQ_INIT(&g->cmdq);
>       QTAILQ_INIT(&g->fenceq);
> @@ -1398,20 +1402,44 @@ static void virtio_gpu_device_unrealize(DeviceSta=
te *qdev)
>
>       g_clear_pointer(&g->ctrl_bh, qemu_bh_delete);
>       g_clear_pointer(&g->cursor_bh, qemu_bh_delete);
> +    g_clear_pointer(&g->reset_bh, qemu_bh_delete);
> +    qemu_cond_destroy(&g->reset_cond);
>       virtio_gpu_base_device_unrealize(qdev);
>   }
>
> -void virtio_gpu_reset(VirtIODevice *vdev)
> +static void virtio_gpu_reset_bh(void *opaque)
>   {
> -    VirtIOGPU *g =3D VIRTIO_GPU(vdev);
> +    VirtIOGPU *g =3D VIRTIO_GPU(opaque);
>       struct virtio_gpu_simple_resource *res, *tmp;
> -    struct virtio_gpu_ctrl_command *cmd;
>       int i =3D 0;
>
>       QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
>           virtio_gpu_resource_destroy(g, res);
>       }
>
> +    for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
> +        dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
> +    }
> +
> +    g->reset_finished =3D true;
> +    qemu_cond_signal(&g->reset_cond);
> +}
> +
> +void virtio_gpu_reset(VirtIODevice *vdev)
> +{
> +    VirtIOGPU *g =3D VIRTIO_GPU(vdev);
> +    struct virtio_gpu_ctrl_command *cmd;
> +
> +    if (qemu_in_vcpu_thread()) {
> +        g->reset_finished =3D false;
> +        qemu_bh_schedule(g->reset_bh);
> +        while (!g->reset_finished) {
> +            qemu_cond_wait_iothread(&g->reset_cond);
> +        }
> +    } else {
> +        virtio_gpu_reset_bh(g);
> +    }
> +
>       while (!QTAILQ_EMPTY(&g->cmdq)) {
>           cmd =3D QTAILQ_FIRST(&g->cmdq);
>           QTAILQ_REMOVE(&g->cmdq, cmd, next);
> @@ -1425,10 +1453,6 @@ void virtio_gpu_reset(VirtIODevice *vdev)
>           g_free(cmd);
>       }
>
> -    for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
> -        dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
> -    }
> -
>       virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
>   }
>
> --
> 2.41.0
>
>


