Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B112A74D148
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:22:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIn69-00070Y-85; Mon, 10 Jul 2023 05:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qIn66-0006zH-JU
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qIn64-0008Oe-2Q
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688980939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UHeyEQSJ0qco/L/bPYWHx5dcdGMknSthBbZ0OLxdZUI=;
 b=D9mxo3FXR92EnVGJAMYUtxBagB4TWp40JVwAOtIzIMHWzN1Hr4F7YadrksNv8PpFfzEZLU
 ldTVGB84NvO542eEFtPHVjCuk78bXd9W6Veb9xfuPnxFflOUBmWWC6mx5NHG/3bgsSFuUb
 2pp31RZIW5SKLubMQu2KqABfQTbzAY8=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-i75kOIDFPSOOcroCdsykdA-1; Mon, 10 Jul 2023 05:22:17 -0400
X-MC-Unique: i75kOIDFPSOOcroCdsykdA-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-c4e0342c50dso5489292276.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 02:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688980937; x=1691572937;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UHeyEQSJ0qco/L/bPYWHx5dcdGMknSthBbZ0OLxdZUI=;
 b=GQZ/BExRIjKoQRqyxQMQS9wCO/7ow0C384h/jQkMfSSz47s/6bCG/XA9gTC2S+goRQ
 PLmGppEvCUnkD4s/QiqAtDJVoPBCKsIiWctBM2wjPNAU/yfqVCUR/M/gBbyf6T5/Q2Q/
 MK0aJK0nZSuEkvfle3PvRXdrpFfsFlivVr3BfFloK4QaiL9TKONy36dLwmSXgAzHchLv
 CNI5f1HN2+nBNgV6bU6+8yXJgJsWSW0d3fzk1Iezwmya35uLCw+MnwHw5B0iPtXm9s14
 9WIZe6Clq3oU31iSXr15lwQvQDB46CpueF6KsrBZJmROy91/Es7NI61W5WYhHATYU1Sv
 ggzQ==
X-Gm-Message-State: ABy/qLbxlNtBSVC6WR5xzWubgvwlX+JA0w1XJZ4pwVZj023L4R1O0n21
 10/PNRnEXcWaAtYC5mqA/l1ke4pgERtmzHYcMDDkQtEdAmVY1e1LFHBMBwqYyoFxgEWxkOua7xn
 jH4SQonOlsL782oJVu5FohKY1oXzkHR0=
X-Received: by 2002:a25:86c7:0:b0:c85:d8b7:2056 with SMTP id
 y7-20020a2586c7000000b00c85d8b72056mr1798512ybm.13.1688980937381; 
 Mon, 10 Jul 2023 02:22:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGrD2o0Kr55/iqiFBKwyFHTu6UWgUChM93AYD81uAQnpJ9fOHNnv9c9CWZViW656MFarNVvr0DENtCEgSm2FDg=
X-Received: by 2002:a25:86c7:0:b0:c85:d8b7:2056 with SMTP id
 y7-20020a2586c7000000b00c85d8b72056mr1798505ybm.13.1688980937148; Mon, 10 Jul
 2023 02:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230710165333.17506-1-lingshan.zhu@intel.com>
In-Reply-To: <20230710165333.17506-1-lingshan.zhu@intel.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 10 Jul 2023 11:21:41 +0200
Message-ID: <CAJaqyWddhB5F88k_4CZSoHrRhQfp+WhJ89uK0+6Z_eFVmJe+Zw@mail.gmail.com>
Subject: Re: [PATCH V2] vhost_vdpa: no need to fetch vring base when poweroff
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 10, 2023 at 10:54=E2=80=AFAM Zhu Lingshan <lingshan.zhu@intel.c=
om> wrote:
>
> In the poweroff routine, no need to fetch last available index.
>
> This commit also provides a better debug message in the vhost
> caller vhost_virtqueue_stop, because if vhost does not fetch
> the last avail idx successfully, maybe the device does not
> suspend, vhost will sync last avail idx to vring used idx as a
> work around, not a failure.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  hw/virtio/vhost-vdpa.c | 10 ++++++++++
>  hw/virtio/vhost.c      |  2 +-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 3c575a9a6e..10b445f64e 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -26,6 +26,7 @@
>  #include "cpu.h"
>  #include "trace.h"
>  #include "qapi/error.h"
> +#include "sysemu/runstate.h"
>
>  /*
>   * Return one past the end of the end of section. Be careful with uint64=
_t
> @@ -1391,6 +1392,15 @@ static int vhost_vdpa_get_vring_base(struct vhost_=
dev *dev,
>      struct vhost_vdpa *v =3D dev->opaque;
>      int ret;
>
> +    if (runstate_check(RUN_STATE_SHUTDOWN)) {
> +        /*
> +         * Some devices do not support this call properly,
> +         * and we don't need to retrieve the indexes
> +         * if it is shutting down
> +         */
> +        return 0;
> +    }
> +
>      if (v->shadow_vqs_enabled) {
>          ring->num =3D virtio_queue_get_last_avail_idx(dev->vdev, ring->i=
ndex);
>          return 0;
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 82394331bf..7dd90cff3a 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1262,7 +1262,7 @@ void vhost_virtqueue_stop(struct vhost_dev *dev,
>
>      r =3D dev->vhost_ops->vhost_get_vring_base(dev, &state);
>      if (r < 0) {
> -        VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r=
);
> +        VHOST_OPS_DEBUG(r, "sync last avail idx to the guest used idx fo=
r vhost VQ %u", idx);
>          /* Connection to the backend is broken, so let's sync internal
>           * last avail idx to the device used idx.
>           */
> --
> 2.39.3
>


