Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A4280D515
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 19:15:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCkoK-0001OI-Mm; Mon, 11 Dec 2023 13:15:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCknx-0001MW-FV
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:14:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCknv-0004UY-Sn
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:14:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702318495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l7Hur+7vxOMfXZB9QP4ksNeQL1NZjIkS+oFsMrXa8yc=;
 b=BbDHgykN6Qh87E6+icHas+d4Zjs1LmAuGgbEKjkpIpNE76UZ4o5A851vXd6GbKRDrsWHS/
 lh4uNW6Wf8QPGwfQ9ZOVAGaAjvprF4DNm2XK7L5g4If9MW/roiXc+MPHtC2qm5WBV1+GNB
 yx0TEtfbrMtugu8nIfHN8vqfGQidGEE=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-Rmg95KE5N2u4aSsjNHY2xQ-1; Mon, 11 Dec 2023 13:14:53 -0500
X-MC-Unique: Rmg95KE5N2u4aSsjNHY2xQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-daee86e2d70so5323136276.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 10:14:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702318493; x=1702923293;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l7Hur+7vxOMfXZB9QP4ksNeQL1NZjIkS+oFsMrXa8yc=;
 b=FxIL9XRMy7NWVhLIB1/AUME6xiC4jxEJfKSJYBhP+aElrwA8VDyX6z8J8NM7SKw0cb
 RiPEWLYkVtWlhPg/+jQ2GArWRkorSVZDmmLTxufpNNG4UcZOnzQtAOhgqJTbxs/1B/ze
 S7OLbcFtcgVqHPk2fpVD16F35T70JcdCYlP3n/iiTedcRbQanbjhcpYs/i4Na6iF9QCw
 TGSBIW0TdZQGkwP09VjUBdiBD/5V+bwFO+WnNnG3kfyNRIpDmiYQXvijR8GOuvnopFit
 dZNpnbd+TbctFmMDOusLZZlM31iIvh0NV9RLdt6lY13BlGNcFE3xHjQVH/Slw/w4bP6H
 WNFA==
X-Gm-Message-State: AOJu0Yw+eAf6oBWtwgR+sXzpwXtWbDAKHfvbxBbrLs62YkuIUR8vgKmI
 XPoWrk+qqDczEulq4x65YmRq7ubZTZwXm7nJyuCVgt8asQ8iEgD+5klsyvftvCmrd9l3TDGd7L5
 jLfMp9taHealUEMjqmG1Be7zab13dkd0=
X-Received: by 2002:a25:abc4:0:b0:db7:dacf:3fac with SMTP id
 v62-20020a25abc4000000b00db7dacf3facmr2586371ybi.89.1702318493144; 
 Mon, 11 Dec 2023 10:14:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMiE1PFMePry99kS4BEZnxiDcPCo1g57R0uFWf016mkWYDv8J4ib89jXcUhm2JCFY2J1HMON8pSh/CYoAFou4=
X-Received: by 2002:a25:abc4:0:b0:db7:dacf:3fac with SMTP id
 v62-20020a25abc4000000b00db7dacf3facmr2586362ybi.89.1702318492873; Mon, 11
 Dec 2023 10:14:52 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-37-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-37-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Dec 2023 19:14:16 +0100
Message-ID: <CAJaqyWfCmykmS9h1fE52oKC7j1DSPk52O=njVKZ4oyAzMosi6Q@mail.gmail.com>
Subject: Re: [PATCH 36/40] vdpa: add vhost_vdpa_get_vring_base trace for svq
 mode
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Dec 7, 2023 at 7:51=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> For better debuggability and observability.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  hw/virtio/trace-events | 2 +-
>  hw/virtio/vhost-vdpa.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 196f32f..a8d3321 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -58,7 +58,7 @@ vhost_vdpa_set_log_base(void *dev, uint64_t base, unsig=
ned long long size, int r
>  vhost_vdpa_set_vring_addr(void *dev, unsigned int index, unsigned int fl=
ags, uint64_t desc_user_addr, uint64_t used_user_addr, uint64_t avail_user_=
addr, uint64_t log_guest_addr) "dev: %p index: %u flags: 0x%x desc_user_add=
r: 0x%"PRIx64" used_user_addr: 0x%"PRIx64" avail_user_addr: 0x%"PRIx64" log=
_guest_addr: 0x%"PRIx64
>  vhost_vdpa_set_vring_num(void *dev, unsigned int index, unsigned int num=
) "dev: %p index: %u num: %u"
>  vhost_vdpa_set_vring_base(void *dev, unsigned int index, unsigned int nu=
m) "dev: %p index: %u num: %u"
> -vhost_vdpa_get_vring_base(void *dev, unsigned int index, unsigned int nu=
m) "dev: %p index: %u num: %u"
> +vhost_vdpa_get_vring_base(void *dev, unsigned int index, unsigned int nu=
m, bool svq) "dev: %p index: %u num: %u svq: %d"
>  vhost_vdpa_set_vring_kick(void *dev, unsigned int index, int fd) "dev: %=
p index: %u fd: %d"
>  vhost_vdpa_set_vring_call(void *dev, unsigned int index, int fd) "dev: %=
p index: %u fd: %d"
>  vhost_vdpa_get_features(void *dev, uint64_t features) "dev: %p features:=
 0x%"PRIx64
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 8ba390d..d66936f 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1607,6 +1607,7 @@ static int vhost_vdpa_get_vring_base(struct vhost_d=
ev *dev,
>
>      if (v->shadow_vqs_enabled) {
>          ring->num =3D virtio_queue_get_last_avail_idx(dev->vdev, ring->i=
ndex);
> +        trace_vhost_vdpa_get_vring_base(dev, ring->index, ring->num, tru=
e);
>          return 0;
>      }
>
> @@ -1619,7 +1620,7 @@ static int vhost_vdpa_get_vring_base(struct vhost_d=
ev *dev,
>      }
>
>      ret =3D vhost_vdpa_call(dev, VHOST_GET_VRING_BASE, ring);
> -    trace_vhost_vdpa_get_vring_base(dev, ring->index, ring->num);
> +    trace_vhost_vdpa_get_vring_base(dev, ring->index, ring->num, false);
>      return ret;
>  }
>
> --
> 1.8.3.1
>


