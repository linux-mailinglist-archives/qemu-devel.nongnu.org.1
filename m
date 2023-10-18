Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A97A7CDB87
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 14:26:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt5cX-0008Er-3m; Wed, 18 Oct 2023 08:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt5cR-0008AK-Pu
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 08:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt5cN-00085S-CH
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 08:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697631941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=32s9h+b/Hzy7n4Tvmv/XScHvCd7ZlRO1fcMtbXrwAIg=;
 b=dnD+8rdCsLSzt/WlVtBaSyfw1b8seuTq1ETk+lbowM0fG29ED32HljSwr87WoEGPLSIIIC
 XzNVfvhtX6+Px8YedIMe0IgARqhrptivlGBc2um3sVpoD7GTqu1Q8XBk4NTYHYtY6aWk6h
 hwoOHAJG9l+7sTQ4wipREtiAjQhTkXU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-CgZAcF4IOfiwDPKeUQRSEQ-1; Wed, 18 Oct 2023 08:25:30 -0400
X-MC-Unique: CgZAcF4IOfiwDPKeUQRSEQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9bd91ce3033so459358566b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 05:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697631928; x=1698236728;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=32s9h+b/Hzy7n4Tvmv/XScHvCd7ZlRO1fcMtbXrwAIg=;
 b=YmehyutvCcm/U/ssuK18CwNvQhLhLc3qYrlj5qfxXPk/kKUiCVoJ24yir9ppgUinAl
 8j7C2N1E8i6BZzMNk0aGZOP+eyx2lKj5sPy2Mz5HlDiNlx09pokp7AncMxuIqpCNx0Nb
 CAICanW3OeQqkOi/lFqb0na7Jx5xVAEig14j/0aQL+veXa7nIXy5CxghEtSw01UeS59I
 IVZgZ0Q4PmWexF4ll4u2fj+ae+qCCh3HQpKlsZXygh8cwFpz9BaHWan7rSC6hqQqJJTg
 2SA0ArK9GBl+LTiUGgQin9mXvmToDy6sb9yEeeiH7CG5zEPdmkFO29kIQYeh25a+7Q63
 Yc2A==
X-Gm-Message-State: AOJu0YxpupQ0nuGYKOxvJ10KGyFqojSPvA6fUuaFes8/cUfXHbdlFf9M
 F6tbUnLhSqFvLgNZ6B5xVJmmi0aU1PYwjJisGSj3p8v1I9wxbewAVNV+cofqtna3HA/Sxx2WQOB
 hdtCrNA9GjT7vgGU77zJCxLAejQ==
X-Received: by 2002:a17:906:7955:b0:9bd:a73a:7a0a with SMTP id
 l21-20020a170906795500b009bda73a7a0amr3933862ejo.58.1697631928635; 
 Wed, 18 Oct 2023 05:25:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9hZe+lPTOoVrPN2EyCsjFJFxMN+v+TOidtFdV5J8N1Maj6bqGw6Zx8bF4JcDfxfJfFA2h6Q==
X-Received: by 2002:a17:906:7955:b0:9bd:a73a:7a0a with SMTP id
 l21-20020a170906795500b009bda73a7a0amr3933853ejo.58.1697631928270; 
 Wed, 18 Oct 2023 05:25:28 -0700 (PDT)
Received: from redhat.com ([193.142.201.38]) by smtp.gmail.com with ESMTPSA id
 s16-20020a1709062ed000b009b2d46425absm1589755eji.85.2023.10.18.05.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 05:25:27 -0700 (PDT)
Date: Wed, 18 Oct 2023 08:25:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4 00/20] virtio-net RSS/hash report fixes and improvements
Message-ID: <20231018082511-mutt-send-email-mst@kernel.org>
References: <20231015140259.259434-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015140259.259434-1-akihiko.odaki@daynix.com>
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

On Sun, Oct 15, 2023 at 11:02:32PM +0900, Akihiko Odaki wrote:
> This series contains fixes and improvements for virtio-net RSS and hash
> reporting feature.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Jason's turf.


> V3 -> V4:
>   Extract patches "tap: Remove tap_receive()" and  "net: Remove flag
>   propagation" from "net: Remove receive_raw()".
>   Added patch "virtio-net: Always set populate_hash".
>   Added patch "virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT".
>   Added patch "ebpf: Use standard section name".
>   Added patch "ebpf: Simplify error handling".
>   Added patch "ebpf: Return 0 when configuration fails".
>   Added patch "ebpf: Refactor tun_rss_steering_prog()".
>   Added patch "ebpf: Add a separate target for skeleton".
> 
> V2 -> V3:
>   Added patch "tap: Remove tap_probe_vnet_hdr_len()".
>   Added patch "tap: Remove qemu_using_vnet_hdr()".
>   Added patch "net: Move virtio-net header length assertion".
>   Added patch "net: Remove receive_raw()".
>   Added patch "tap: Shrink zeroed virtio-net header".
>   Dropped patch "tap: Fix virtio-net header buffer size".
> 
> V1 -> V2:
>   Added patch "ebpf: Fix RSS error handling".
> 
> Akihiko Odaki (20):
>   tap: Remove tap_probe_vnet_hdr_len()
>   tap: Remove qemu_using_vnet_hdr()
>   net: Move virtio-net header length assertion
>   net: Remove receive_raw()
>   tap: Remove tap_receive()
>   net: Remove flag propagation
>   tap: Shrink zeroed virtio-net header
>   virtio-net: Copy header only when necessary
>   virtio-net: Disable RSS on reset
>   virtio-net: Unify the logic to update NIC state for RSS
>   virtio-net: Return an error when vhost cannot enable RSS
>   virtio-net: Always set populate_hash
>   virtio-net: Do not clear VIRTIO_NET_F_RSS
>   virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT
>   ebpf: Fix RSS error handling
>   ebpf: Use standard section name
>   ebpf: Simplify error handling
>   ebpf: Return 0 when configuration fails
>   ebpf: Refactor tun_rss_steering_prog()
>   ebpf: Add a separate target for skeleton
> 
>  ebpf/ebpf_rss.h          |    2 +-
>  ebpf/rss.bpf.skeleton.h  | 1557 +++++++++++++++++++-------------------
>  include/net/filter.h     |    3 -
>  include/net/net.h        |    7 -
>  include/net/queue.h      |    7 -
>  include/sysemu/replay.h  |    2 +-
>  net/tap_int.h            |    1 -
>  ebpf/ebpf_rss-stub.c     |    4 +-
>  ebpf/ebpf_rss.c          |   80 +-
>  hw/net/e1000e.c          |    1 -
>  hw/net/igb.c             |    1 -
>  hw/net/net_tx_pkt.c      |    4 +-
>  hw/net/virtio-net.c      |  283 ++++---
>  hw/net/vmxnet3.c         |    2 -
>  net/dump.c               |    8 +-
>  net/filter-buffer.c      |    4 +-
>  net/filter-mirror.c      |    6 +-
>  net/filter-replay.c      |    3 +-
>  net/filter-rewriter.c    |    5 +-
>  net/filter.c             |    8 +-
>  net/net.c                |   83 +-
>  net/netmap.c             |    5 -
>  net/queue.c              |   30 +-
>  net/tap-bsd.c            |    5 -
>  net/tap-linux.c          |   20 -
>  net/tap-solaris.c        |    5 -
>  net/tap-stub.c           |    5 -
>  net/tap.c                |   74 +-
>  replay/replay-net.c      |    8 +-
>  tools/ebpf/rss.bpf.c     |   46 +-
>  tools/ebpf/Makefile.ebpf |   15 +-
>  31 files changed, 1027 insertions(+), 1257 deletions(-)
> 
> -- 
> 2.42.0


