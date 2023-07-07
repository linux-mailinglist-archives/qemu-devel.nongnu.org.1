Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C74674AF5E
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:04:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjFC-0001hU-IF; Fri, 07 Jul 2023 07:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qHjFA-0001hJ-UG
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 07:03:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qHjF9-0004ra-FB
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 07:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688727798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uVqFGHdDaLtc0dp2O74sWPgLJAlkhr9+nlLGJKQ66vw=;
 b=d3GKUbV1KqbFmmIbxWyNlG1fN9B8UYm9s1gYABXC0teTqcAnma8ng1RkTqKI0ltWHWiiGu
 PwmLhIsXusvCqXfD+nM2dQaOnrKqGgMo4CFko1ztpvrMSFpoJcIUltexJsRwRdfzfr1Kqm
 Sa9oirb6qxtXRTQ//tra6qcLontGyAk=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-oli71obBMRaKvVDmKxMZMQ-1; Fri, 07 Jul 2023 07:03:17 -0400
X-MC-Unique: oli71obBMRaKvVDmKxMZMQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-c5cea5773e8so2017978276.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 04:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688727797; x=1691319797;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVqFGHdDaLtc0dp2O74sWPgLJAlkhr9+nlLGJKQ66vw=;
 b=gcRBTyZCXV3xM2G7TDVaUQVdnGqBjj0QVFMBR/0ZkDhO/zV5ImyHd9OCERMKD/RnPP
 PAYJuD1HRger/Vm9IwVV5ACInWkzc763yNK/YVIlAcqt7LD/ANhsxd+SsChE3md73cdI
 Mhb8Cplubd2ob1KPweF+vSt5wuUXDDThKG56e4AyN2WgV2uDNLhiTJmaKKxk7TwynvYU
 +PEYKSTUYOxGxohAderlymrWRoL/wpMOJ4nf2GwmZ0dvwZkxeF4r5IC8FNQEhhL+E9Am
 edpxzuAgT7rRp05cmzaCQxXxMqN+HvoqcKg6rM3LvHBXhQ85AFH0159tpkdwM6rW9YZd
 8i6g==
X-Gm-Message-State: ABy/qLY2b76IcGr9bIpdxaG8TJMeCArLIjHWaS4RntHkdrAYO9UmEwgP
 MuPudc4jD1InNKESDRQmcNz6YtVfoTMkb6mLnRY5BXrAOo8K+cQI/oIV4zEhqMstH5asFvv+vIT
 oGnnr7m1kGreF8hPCgzObR4LUAbAIATM=
X-Received: by 2002:a25:1856:0:b0:c63:a7fe:6dda with SMTP id
 83-20020a251856000000b00c63a7fe6ddamr5386652yby.23.1688727796934; 
 Fri, 07 Jul 2023 04:03:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHjsjj7WCXY+PsyLxZB9bDvlTz6Fc8kngQjb0/RPHXcGH68wEILuvRAh/M+85BHEq1GafAJjjJfqXWZkoPODI0=
X-Received: by 2002:a25:1856:0:b0:c63:a7fe:6dda with SMTP id
 83-20020a251856000000b00c63a7fe6ddamr5386641yby.23.1688727796683; Fri, 07 Jul
 2023 04:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230707181826.10946-1-lingshan.zhu@intel.com>
In-Reply-To: <20230707181826.10946-1-lingshan.zhu@intel.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 7 Jul 2023 13:02:40 +0200
Message-ID: <CAJaqyWdp6FvVT3wms39-paqQndLPQwQjqb4Ocua0ja=N3bxvpw@mail.gmail.com>
Subject: Re: [PATCH] vhost_vdpa: no need to fetch vring base when poweroff
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, 
 Michael Tsirkin <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Fri, Jul 7, 2023 at 12:18=E2=80=AFPM Zhu Lingshan <lingshan.zhu@intel.co=
m> wrote:
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

CCing MST.

> ---
>  hw/virtio/vhost-vdpa.c | 4 ++++
>  hw/virtio/vhost.c      | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 3c575a9a6e..f62952e1c7 100644
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
> @@ -1391,6 +1392,9 @@ static int vhost_vdpa_get_vring_base(struct vhost_d=
ev *dev,
>      struct vhost_vdpa *v =3D dev->opaque;
>      int ret;
>
> +    if (runstate_check(RUN_STATE_SHUTDOWN))
> +        return 0;
> +

QEMU coding style mandates braces around the "if" body (CODING_STYLE.rst fi=
le).

Apart from that I think we should add a comment here. Something in the line=
 of:

Some devices do not support the call properly, and we don't need to
retrieve the indexes if we're not migrating. Skip it in this case.

>      if (v->shadow_vqs_enabled) {
>          ring->num =3D virtio_queue_get_last_avail_idx(dev->vdev, ring->i=
ndex);
>          return 0;
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 82394331bf..84712743e0 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1262,7 +1262,7 @@ void vhost_virtqueue_stop(struct vhost_dev *dev,
>
>      r =3D dev->vhost_ops->vhost_get_vring_base(dev, &state);
>      if (r < 0) {
> -        VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r=
);
> +        VHOST_OPS_DEBUG(r, "sync last avail idx to the used idx for vhos=
t VQ %u", idx);

Guest's used idx? Also, maybe it is worth splitting this in a separated pat=
ch.

Apart from the nitpicking, I think the general line of the patch is
the way to go :).

Thanks!

>          /* Connection to the backend is broken, so let's sync internal
>           * last avail idx to the device used idx.
>           */
> --
> 2.39.3
>


