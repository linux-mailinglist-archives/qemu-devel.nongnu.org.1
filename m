Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 065857C956B
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 18:38:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrhdn-00076k-WB; Sat, 14 Oct 2023 12:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qrhdm-00076c-H6
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 12:37:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qrhdk-0007GQ-SX
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 12:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697301442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xkby15Q3uM60GRoU7GjpLXsvty99PVv6YC7sLCN43XE=;
 b=YGCNJL79J7+qP+nCfepbyYw0aSEPH6RwYQP+E6p6vptb5v85hwJCQLwyttM8RvJUkhX2sh
 EkBqFjAadIyjsUdK7SHVBjspfDAFLK2U2amI84Kbr8XmRi0hxx1hK3SO7AL6JcQmtOtTtm
 gFfsTg/E4aOOirRkfU3IDedv1h7FXKo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-K9A-CZQkMFSHB4O-mm9pSQ-1; Sat, 14 Oct 2023 12:37:10 -0400
X-MC-Unique: K9A-CZQkMFSHB4O-mm9pSQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso1919205f8f.3
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 09:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697301430; x=1697906230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xkby15Q3uM60GRoU7GjpLXsvty99PVv6YC7sLCN43XE=;
 b=NAneWZcsNLdGGfhXaoqD4DSVSKTT6nv8ZmAAZcdKe++M3VwcxSlKqePLxgXUo4KA24
 saPLrXFgFy91fVPIgjq6RFcjphvvvSe/nBaGaoJ35hhVxvMo+HT3ejsoswuELZw2zVbE
 hPDDznATUoVh6UGvo6uTzhOk+Mbo8na6OeXg4ujBlynK2/avwwa2LyoKwuJBFOqYjKgA
 Szcm1rLT/8+AlbH/Uuz96LuCLev62i08yKiquODxCbukd8KEcxZsa9zbs35aymN8zdr1
 d1Cau9FC57eistmurirkpjRiGzhafIej3FBjqJ8s5iZmYhhyHnDyNFdT35/M4GOJQc+0
 ZJBg==
X-Gm-Message-State: AOJu0YyVirQbz75EzcdC7LQx+xeYyr/S8m/fCpZvzLSBVBO4ui8SLQyp
 XMZR61TgXhuL4wnn+mK/+vLWwc3HwQcaMDsVNqCxh9k4ZT12f7i6PPLfvoAlXegMd3BOb32vF//
 aj0J5RDfnCHXlVvQ=
X-Received: by 2002:a5d:4c86:0:b0:31a:ed75:75d9 with SMTP id
 z6-20020a5d4c86000000b0031aed7575d9mr26500014wrs.16.1697301429808; 
 Sat, 14 Oct 2023 09:37:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoOnMMtkD7A6xG4jTkaA2ewSHL2RkZKY5oTLUnu36RejWrY671Nc/GJKNx4i9nwFkk4CBfcg==
X-Received: by 2002:a5d:4c86:0:b0:31a:ed75:75d9 with SMTP id
 z6-20020a5d4c86000000b0031aed7575d9mr26500006wrs.16.1697301429427; 
 Sat, 14 Oct 2023 09:37:09 -0700 (PDT)
Received: from redhat.com ([109.253.193.138]) by smtp.gmail.com with ESMTPSA id
 k17-20020adff291000000b003143867d2ebsm23339658wro.63.2023.10.14.09.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 09:37:08 -0700 (PDT)
Date: Sat, 14 Oct 2023 12:37:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vincent Jardin <vincent.jardin@ekinops.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com
Subject: Re: [RFC] virtio: enforce link up
Message-ID: <20231014123635-mutt-send-email-mst@kernel.org>
References: <20231014162234.153808-1-vincent.jardin@ekinops.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014162234.153808-1-vincent.jardin@ekinops.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Oct 14, 2023 at 06:22:34PM +0200, Vincent Jardin wrote:
> Using interface's settings, let's enforce an always on link up.
> 
> Signed-off-by: Vincent Jardin <vincent.jardin@ekinops.com>

What is going on here? Just don't set it down.

> ---
>  hw/net/virtio-net.c            | 8 ++++++++
>  include/hw/virtio/virtio-net.h | 2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 29e33ea5ed..e731b4fdea 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -78,6 +78,9 @@
>     tso/gso/gro 'off'. */
>  #define VIRTIO_NET_RSC_DEFAULT_INTERVAL 300000
>  
> +/* force always link up */
> +#define VIRTIO_NET_LINK_UP false
> +
>  #define VIRTIO_NET_RSS_SUPPORTED_HASHES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
>                                           VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
>                                           VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
> @@ -447,6 +450,9 @@ static void virtio_net_set_link_status(NetClientState *nc)
>      else
>          n->status |= VIRTIO_NET_S_LINK_UP;
>  
> +    if (n->net_conf.link_up)
> +        n->status |= VIRTIO_NET_S_LINK_UP;
> +
>      if (n->status != old_status)
>          virtio_notify_config(vdev);
>  
> @@ -3947,6 +3953,8 @@ static Property virtio_net_properties[] = {
>                        VIRTIO_NET_F_GUEST_USO6, true),
>      DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
>                        VIRTIO_NET_F_HOST_USO, true),
> +    DEFINE_PROP_BOOL("link_up", VirtIONet, net_conf.link_up,
> +                       VIRTIO_NET_LINK_UP),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> index 55977f01f0..385bebab34 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -56,6 +56,7 @@ typedef struct virtio_net_conf
>      char *duplex_str;
>      uint8_t duplex;
>      char *primary_id_str;
> +    bool link_up; /* if set enforce link up, never down */
>  } virtio_net_conf;
>  
>  /* Coalesced packets type & status */
> @@ -180,6 +181,7 @@ struct VirtIONet {
>      size_t guest_hdr_len;
>      uint64_t host_features;
>      uint32_t rsc_timeout;
> +    uint32_t link_up; /* if set enforce link up, never down */
>      uint8_t rsc4_enabled;
>      uint8_t rsc6_enabled;
>      uint8_t has_ufo;
> -- 
> 2.34.1


