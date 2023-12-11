Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5362A80D517
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 19:16:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCkof-0001g0-PA; Mon, 11 Dec 2023 13:15:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCkoP-0001Yq-ME
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:15:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCkoM-0004gW-85
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702318510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1NLD7lU0dyIgUP74FXnH2ioESmmKsYjqjyhxkMai38=;
 b=Grzn3rV2P9+49TwI9erj32QxOFpGzr1hAph3EQ6mzbRYYRzgoE7EoJCO07AclFuMWkhuCG
 DQafMdiBA9pZ7EysO+JZ1uJZH/m9dj3mH0GMPP8XqHyJs87Hw6iXKU+Xrj2RFuR0wISaU2
 5KcqnBXR1fTZLv4D9osSQFZSU/KEfzo=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-I_MvshnvOSqtiyG7riRLaw-1; Mon, 11 Dec 2023 13:15:08 -0500
X-MC-Unique: I_MvshnvOSqtiyG7riRLaw-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-db542ec49d9so4793387276.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 10:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702318508; x=1702923308;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b1NLD7lU0dyIgUP74FXnH2ioESmmKsYjqjyhxkMai38=;
 b=N2zaYz4Yfq/bFnQeamiEEzjYCKLE/dLZQqp2IpEi48WxhU0qy5J0M2Qg1wpHdcvpWP
 JJNFUFNKOkMCE6RfBkG/bYfGh83+DaDGtTSGowBNwwxMQ8wr7LXHvBULgovL0krTlMYZ
 diy4Inf9Av4IOKbhVAbXAWFSFLJ3MDSqScmGC5g9BEg3JCaASQ97P6PEI6/GpBSuuAoK
 AWArRdWn3N1AtGksG3RkwrxJSoNFK0EoA9SnMcqi3iMngvHdO4NNjrDIqD9Di02HNPlS
 mwCZRGykJWW1Rpu1S4ZLZmHSCosW8TZPR9GEtu+Y1tne1VBOPMgs9zJbPvijri4TGIc3
 09oQ==
X-Gm-Message-State: AOJu0YzqfG0C+SASFdG5vl2ImlnTsPEFsjL2eHJVwlRVBYvPIQc4b9yf
 g2CDZQol9zfeYM/MqUwNyRXwOZ9MrBu9Sz1ThZmYbjQXWGCR+R4Hu66YPzpQUBSphAt1SzkijvC
 OTBKytRJ+e9TZDZs83t+TU6fRJYLcgeYh9y4l+GCZYQ==
X-Received: by 2002:a5b:82:0:b0:db7:dad0:76ce with SMTP id
 b2-20020a5b0082000000b00db7dad076cemr2599038ybp.106.1702318507180; 
 Mon, 11 Dec 2023 10:15:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkQlXPd7hgQR1LWaVyQhtIGo/LhnjxaEc4c+Tcw4qlYd8uulx/WHmGpZY6gBDD2QJDQif3jBExyLF03y5actQ=
X-Received: by 2002:a5b:82:0:b0:db7:dad0:76ce with SMTP id
 b2-20020a5b0082000000b00db7dad076cemr2599023ybp.106.1702318506909; 
 Mon, 11 Dec 2023 10:15:06 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-38-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-38-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Dec 2023 19:14:30 +0100
Message-ID: <CAJaqyWf2DfTRyResx7KmkRduu_KJNG_R4z3z3CBySoEx5Qmrpg@mail.gmail.com>
Subject: Re: [PATCH 37/40] vdpa: add vhost_vdpa_set_dev_vring_base trace for
 svq mode
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

On Thu, Dec 7, 2023 at 7:51=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> For better debuggability and observability.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  hw/virtio/trace-events | 2 +-
>  hw/virtio/vhost-vdpa.c | 5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index a8d3321..5085607 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -57,7 +57,7 @@ vhost_vdpa_dev_start(void *dev, bool started) "dev: %p =
started: %d"
>  vhost_vdpa_set_log_base(void *dev, uint64_t base, unsigned long long siz=
e, int refcnt, int fd, void *log) "dev: %p base: 0x%"PRIx64" size: %llu ref=
cnt: %d fd: %d log: %p"
>  vhost_vdpa_set_vring_addr(void *dev, unsigned int index, unsigned int fl=
ags, uint64_t desc_user_addr, uint64_t used_user_addr, uint64_t avail_user_=
addr, uint64_t log_guest_addr) "dev: %p index: %u flags: 0x%x desc_user_add=
r: 0x%"PRIx64" used_user_addr: 0x%"PRIx64" avail_user_addr: 0x%"PRIx64" log=
_guest_addr: 0x%"PRIx64
>  vhost_vdpa_set_vring_num(void *dev, unsigned int index, unsigned int num=
) "dev: %p index: %u num: %u"
> -vhost_vdpa_set_vring_base(void *dev, unsigned int index, unsigned int nu=
m) "dev: %p index: %u num: %u"
> +vhost_vdpa_set_dev_vring_base(void *dev, unsigned int index, unsigned in=
t num, bool svq) "dev: %p index: %u num: %u svq: %d"
>  vhost_vdpa_get_vring_base(void *dev, unsigned int index, unsigned int nu=
m, bool svq) "dev: %p index: %u num: %u svq: %d"
>  vhost_vdpa_set_vring_kick(void *dev, unsigned int index, int fd) "dev: %=
p index: %u fd: %d"
>  vhost_vdpa_set_vring_call(void *dev, unsigned int index, int fd) "dev: %=
p index: %u fd: %d"
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index d66936f..ff4f218 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1043,7 +1043,10 @@ static int vhost_vdpa_get_config(struct vhost_dev =
*dev, uint8_t *config,
>  static int vhost_vdpa_set_dev_vring_base(struct vhost_dev *dev,
>                                           struct vhost_vring_state *ring)
>  {
> -    trace_vhost_vdpa_set_vring_base(dev, ring->index, ring->num);
> +    struct vhost_vdpa *v =3D dev->opaque;
> +
> +    trace_vhost_vdpa_set_dev_vring_base(dev, ring->index, ring->num,
> +                                        v->shadow_vqs_enabled);
>      return vhost_vdpa_call(dev, VHOST_SET_VRING_BASE, ring);
>  }
>
> --
> 1.8.3.1
>


