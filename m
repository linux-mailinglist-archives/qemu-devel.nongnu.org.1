Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E67AB7CB98B
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 06:11:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsbOp-0007N6-1Q; Tue, 17 Oct 2023 00:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbOm-0007Mr-MT
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:09:40 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbOk-00042w-L1
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:09:40 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c9e06f058bso35016135ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 21:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697515777; x=1698120577;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E/yHGDStlq6WH86k6FxlNhbYZA+ENm0yo2nN01ItAME=;
 b=GFpdT03Por3iBdXtPyYlKud8Z65a/fqx8ySJZ0FKXpoRqDbakYwMGbmx6id0XW6t+t
 86BASoAKDV05xRCzC/kYW0Dl07U5mD5j7d+QXGaA18/ccfHN+l0rJv6kJgPcGmrGpknO
 XXRiswp3ow3FvQelVJa8PPoNxEN/IYiLjCYS35LO/xHluBp+Oc0SCbhSi3//R9cLybfN
 /X4URRBKtHpwBTDZGkyIskla+YsIiVXANuPaBuPzyiPZU0RRFPdK1R9AXccI4X9HFo65
 KCGwN9pfU9Q1LFry0AHG9gvHPO6zlzyzJU3O2PBA+lIxoQMVYmFYyP3GEpOVN9TbWaxw
 eCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697515777; x=1698120577;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E/yHGDStlq6WH86k6FxlNhbYZA+ENm0yo2nN01ItAME=;
 b=MqVyfpLO1yDv1lfEm8MfZygso65hMiuEzqK3jum6I/fScgPznDnhb1/XQyVwQdbh7k
 qRhiRT2SHK6jfnrzsP1DlqK1MeWUkLVZVtTP/Bs4U+J+Z+j5g3EkB/mk7a2j/C34EyX5
 3QjuOMks/hyJ6MN+Kwp5zbc099utWpF382W09zxPMma+WSq9UIzPQKegxKGXrPdnmGmK
 qCV6Clap2MrsOv7Z0gvI7lM926QdilRitqQBWkRseBwpxIsd6UGc7ee/tc4pTPdOLxWb
 kE9WhvCPZWhBzFTreuhIXUI1k1SZgLBSS/qGFydyE7toRJPLtrRXEzJ/6TWRw4mUT67C
 xoew==
X-Gm-Message-State: AOJu0YxOx3+K02jBt4FKsCHUS8Fw+vgqd76RxtOO94Gec4DDK9SAgZAs
 fPN6hkFUeREc3M/rRbkLsae8CUg5gq1cFcmnNAIzPg==
X-Google-Smtp-Source: AGHT+IGVf+cPVQ0AiwMz3P8711XbZj3eT/AHJwadYINn21UGUTVnDnQHzDnTMlC4LFxg0DZ9i5Ym6Q==
X-Received: by 2002:a17:902:e741:b0:1c9:e77d:62d3 with SMTP id
 p1-20020a170902e74100b001c9e77d62d3mr1336660plf.10.1697515777124; 
 Mon, 16 Oct 2023 21:09:37 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 u9-20020a170902e80900b001c9d2360b2asm394999plg.22.2023.10.16.21.09.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 21:09:36 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 00/21] virtio-net RSS/hash report fixes and improvements
Date: Tue, 17 Oct 2023 13:09:06 +0900
Message-ID: <20231017040932.62997-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This series contains fixes and improvements for virtio-net RSS and hash
reporting feature.

V4 -> V5:
  Added patch "virtio-net: Do not write hashes to peer buffer".

V3 -> V4:
  Extract patches "tap: Remove tap_receive()" and  "net: Remove flag
  propagation" from "net: Remove receive_raw()".
  Added patch "virtio-net: Always set populate_hash".
  Added patch "virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT".
  Added patch "ebpf: Use standard section name".
  Added patch "ebpf: Simplify error handling".
  Added patch "ebpf: Return 0 when configuration fails".
  Added patch "ebpf: Refactor tun_rss_steering_prog()".
  Added patch "ebpf: Add a separate target for skeleton".

V2 -> V3:
  Added patch "tap: Remove tap_probe_vnet_hdr_len()".
  Added patch "tap: Remove qemu_using_vnet_hdr()".
  Added patch "net: Move virtio-net header length assertion".
  Added patch "net: Remove receive_raw()".
  Added patch "tap: Shrink zeroed virtio-net header".
  Dropped patch "tap: Fix virtio-net header buffer size".

V1 -> V2:
  Added patch "ebpf: Fix RSS error handling".

Akihiko Odaki (21):
  tap: Remove tap_probe_vnet_hdr_len()
  tap: Remove qemu_using_vnet_hdr()
  net: Move virtio-net header length assertion
  net: Remove receive_raw()
  tap: Remove tap_receive()
  net: Remove flag propagation
  tap: Shrink zeroed virtio-net header
  virtio-net: Copy header only when necessary
  virtio-net: Disable RSS on reset
  virtio-net: Unify the logic to update NIC state for RSS
  virtio-net: Return an error when vhost cannot enable RSS
  virtio-net: Always set populate_hash
  virtio-net: Do not clear VIRTIO_NET_F_RSS
  virtio-net: Do not write hashes to peer buffer
  virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT
  ebpf: Fix RSS error handling
  ebpf: Use standard section name
  ebpf: Simplify error handling
  ebpf: Return 0 when configuration fails
  ebpf: Refactor tun_rss_steering_prog()
  ebpf: Add a separate target for skeleton

 ebpf/ebpf_rss.h          |    2 +-
 ebpf/rss.bpf.skeleton.h  | 1557 +++++++++++++++++++-------------------
 include/net/filter.h     |    3 -
 include/net/net.h        |    7 -
 include/net/queue.h      |    7 -
 include/sysemu/replay.h  |    2 +-
 net/tap_int.h            |    1 -
 ebpf/ebpf_rss-stub.c     |    4 +-
 ebpf/ebpf_rss.c          |   80 +-
 hw/net/e1000e.c          |    1 -
 hw/net/igb.c             |    1 -
 hw/net/net_tx_pkt.c      |    4 +-
 hw/net/virtio-net.c      |  319 ++++----
 hw/net/vmxnet3.c         |    2 -
 net/dump.c               |    8 +-
 net/filter-buffer.c      |    4 +-
 net/filter-mirror.c      |    6 +-
 net/filter-replay.c      |    3 +-
 net/filter-rewriter.c    |    5 +-
 net/filter.c             |    8 +-
 net/net.c                |   83 +-
 net/netmap.c             |    5 -
 net/queue.c              |   30 +-
 net/tap-bsd.c            |    5 -
 net/tap-linux.c          |   20 -
 net/tap-solaris.c        |    5 -
 net/tap-stub.c           |    5 -
 net/tap.c                |   74 +-
 replay/replay-net.c      |    8 +-
 tools/ebpf/rss.bpf.c     |   46 +-
 tools/ebpf/Makefile.ebpf |   15 +-
 31 files changed, 1044 insertions(+), 1276 deletions(-)

-- 
2.42.0


