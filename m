Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DF974E476
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 04:51:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ3SR-0001Xv-Ov; Mon, 10 Jul 2023 22:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qJ3SQ-0001Xn-4v
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 22:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qJ3SO-0003VE-3k
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 22:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689043827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AE07ROfoov+7q7oP20Qw3Tuzkql0dVyhxSuWbfdWjc4=;
 b=AfidkLobOIt+Pv4XMTfr1DPehR0NYkJOoIa4kWepNjNgZqAie2RLxHYhjMYAYPBDdmKelZ
 rt7iMy2qkfTOp3ECMUWYbrj6drO+6oLqJjPpaxAfVQPSVWRQ3H6pCSM6xm1Y5CgfoWENwt
 Olu8bjM2i5h3tx7I2wodSqH2TFCtcJk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-ZTIWDPRJOKCk_aO7sp8slg-1; Mon, 10 Jul 2023 22:50:25 -0400
X-MC-Unique: ZTIWDPRJOKCk_aO7sp8slg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b6fbee0642so30873871fa.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 19:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689043824; x=1691635824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AE07ROfoov+7q7oP20Qw3Tuzkql0dVyhxSuWbfdWjc4=;
 b=XuwFdm4x+9sfAIwQ88nniB2NBfiCtrcuPlYIrkBCzuqLOc1i0XP7vb4/8aoOSDnrMU
 sj3simoqePxGO0vLBJCvBXNwpn/NMr5CiaSsFwueVPcQigbdqalUmJ5Hd867oNukkT87
 FMHHj00iDx+LdQNIiv6dvMIHEJ9FROZK2rY7NtrgJC0xeYU5fepas3BIoJrfvth9ajt+
 583v0X72CgZZJEmBgMbjdpnRSJLC4cDaYNd4Q/QKPKbcwocYEo0YvomcjEMsBRziO/xZ
 lbsyLGyd+YzUoZzTr/nA6wT+mlUrKP4V+u+HaCOJ05kTXSYbabjIBedb5t9a1AdtOn4Q
 UKSg==
X-Gm-Message-State: ABy/qLaYfakgVjEkfu7grfA+y2yRfnZiSAkCJDAbaRqlA15/HP/GJXcg
 +bpDeskIGQZk8nZd9Fqzq1jPnl22A9FaXX5sBAEwBxijZNH65RJaasSycQuUcda25xfwJb+bTsB
 3EASAZZW9LBaj730Te7LfefUVNsa8c+I=
X-Received: by 2002:a05:651c:10ab:b0:2b6:9e1d:cd0f with SMTP id
 k11-20020a05651c10ab00b002b69e1dcd0fmr7103501ljn.12.1689043824433; 
 Mon, 10 Jul 2023 19:50:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE0oCyW9o5pc8siQ8HF7vB87zEFFeK0bzRdIX42ufeQpiaPqnDJElDx/wpZ/Hur4xTNQXlCW68t+s1DQXaNFkc=
X-Received: by 2002:a05:651c:10ab:b0:2b6:9e1d:cd0f with SMTP id
 k11-20020a05651c10ab00b002b69e1dcd0fmr7103494ljn.12.1689043824162; Mon, 10
 Jul 2023 19:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230710165333.17506-1-lingshan.zhu@intel.com>
In-Reply-To: <20230710165333.17506-1-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Jul 2023 10:50:13 +0800
Message-ID: <CACGkMEsNE995Z-TE8wiPc3TwLd3N4Rd+hGMGNfR-d1tFdwOM-Q@mail.gmail.com>
Subject: Re: [PATCH V2] vhost_vdpa: no need to fetch vring base when poweroff
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: mst@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Mon, Jul 10, 2023 at 4:53=E2=80=AFPM Zhu Lingshan <lingshan.zhu@intel.co=
m> wrote:
>
> In the poweroff routine, no need to fetch last available index.
>

This is because there's no concept of shutdown in the vhost layer, it
only knows start and stop.

> This commit also provides a better debug message in the vhost
> caller vhost_virtqueue_stop,

A separate patch is better.

> because if vhost does not fetch
> the last avail idx successfully, maybe the device does not
> suspend, vhost will sync last avail idx to vring used idx as a
> work around, not a failure.

This only happens if we return a negative value?

>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
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

Checking runstate in the vhost code seems like a layer violation.

What happens without this patch?

Thanks

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


