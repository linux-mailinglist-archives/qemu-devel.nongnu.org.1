Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 282FD760AD1
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 08:48:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOBpp-0005qe-M9; Tue, 25 Jul 2023 02:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qOBpn-0005dN-Kr
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 02:47:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qOBpl-00079y-IH
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 02:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690267669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JyF7laIUov0JMaKOS0HhfaJaB3bS6zclJzkS9xnnzfU=;
 b=J2VGI8LnUZNXPUZncNYI8+Wq1WVz/Yo1V/KBD+09WBS/pdIguDaiBAH+9agzK1sun7QMJx
 XNm/8DUpH/5s/QIMdzV1KXwLcPnqVm30jjjbM2RRIsS2o3Y+DktJJW45sCXdQx1sKnBBlf
 HFMA1+1ONOCHeQJS69NPrPvLLg77bJc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-s9qWab6TNgWi8QydZfWvLA-1; Tue, 25 Jul 2023 02:47:47 -0400
X-MC-Unique: s9qWab6TNgWi8QydZfWvLA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b961c3af8fso45072331fa.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 23:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690267666; x=1690872466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JyF7laIUov0JMaKOS0HhfaJaB3bS6zclJzkS9xnnzfU=;
 b=YirDTCRTs7sjsVo69kYv41UX7/2Tpx7QmM6/RN1biKqG+gqWPrjxlVYHinXWzvcRst
 9PsHg2co0gTHxhC/M/FtJtqdZcKcf7F3TGGEmAB2gxfCs3wyam7yYfZn7kGlt4OAX/fP
 qs+Ggfw2i+/g9J9MJB07tEGz2vmula0oWZl9VGYJ4oobso1rO31hvevDcUDh4XU/EUL2
 nnDrs8F0RYWB8L/2yZl6khCGXUagqDcyjSORbhE41YyTijz8HZdRerXrAAIPnen+r/PL
 /CbwdTRAk5VqpfaUl30A93eQR/dBHLs24XTYgk9h5uSyKSl9Z1UOl0BAwkLgSH1wTvGO
 0AMg==
X-Gm-Message-State: ABy/qLaWdi4OifF0hh2Y2PvAqCKkDa4J036dRxV8+Y7x8Nn/V68xraD3
 h+DmsAlpp/VgyT+H2q8wi2EzIZcngy0uPfun7T2Q2OPHmQyY5VKKTyZAz16dHqU9I5l8Q0rc8xt
 WTTz3zcKRzAQW9amGkL6aNGHk5r+0pGA=
X-Received: by 2002:a2e:9c02:0:b0:2b5:95a8:4126 with SMTP id
 s2-20020a2e9c02000000b002b595a84126mr6889678lji.52.1690267665840; 
 Mon, 24 Jul 2023 23:47:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFXeJ02ZdeKrMxZccUOwkA5t7fK/oFBRAQuQR/PKk9JCoaNqiCU5f8wpV7wZJWHe27HecWX95Wl4hVLuSHx1Fg=
X-Received: by 2002:a2e:9c02:0:b0:2b5:95a8:4126 with SMTP id
 s2-20020a2e9c02000000b002b595a84126mr6889668lji.52.1690267665585; Mon, 24 Jul
 2023 23:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690100802.git.yin31149@gmail.com>
 <ca03403319c6405ea7c400836a572255bbc9ceba.1690100802.git.yin31149@gmail.com>
In-Reply-To: <ca03403319c6405ea7c400836a572255bbc9ceba.1690100802.git.yin31149@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jul 2023 14:47:34 +0800
Message-ID: <CACGkMEuCVWT-MyAVfTZhr9XdvVsq92SNO2sZHSy4hO4goOH=pg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] virtio-net: Expose MAX_VLAN
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: mst@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Sun, Jul 23, 2023 at 5:27=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> vhost-vdpa shadowed CVQ needs to know the maximum number of
> vlans supported by the virtio-net device, so QEMU can restore
> the VLAN state in a migration.
>
> Co-developed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  hw/net/virtio-net.c            | 2 --
>  include/hw/virtio/virtio-net.h | 6 ++++++
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index d20d5a63cd..a32672039d 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -49,8 +49,6 @@
>
>  #define VIRTIO_NET_VM_VERSION    11
>
> -#define MAX_VLAN    (1 << 12)   /* Per 802.1Q definition */
> -
>  /* previously fixed value */
>  #define VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE 256
>  #define VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE 256
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
> index 5f5dcb4572..93f3bb5d97 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -38,6 +38,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIONet, VIRTIO_NET)
>  /* Maximum VIRTIO_NET_CTRL_MAC_TABLE_SET unicast + multicast entries. */
>  #define MAC_TABLE_ENTRIES    64
>
> +/*
> + * The maximum number of VLANs in the VLAN filter table
> + * added by VIRTIO_NET_CTRL_VLAN_ADD
> + */
> +#define MAX_VLAN    (1 << 12)   /* Per 802.1Q definition */
> +
>  typedef struct virtio_net_conf
>  {
>      uint32_t txtimer;
> --
> 2.25.1
>


