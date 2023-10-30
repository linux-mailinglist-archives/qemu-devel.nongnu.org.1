Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AA87DB2A7
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 06:15:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxKbW-0001zs-0C; Mon, 30 Oct 2023 01:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKbT-0001ze-QI
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:14:19 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKbI-0001ht-JC
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:14:13 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso24445925ad.2
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 22:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698642847; x=1699247647;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JtQ45ikALGGMBInfjAVoEgO8CPaLp7MZq2NUvJWFcoU=;
 b=efJXr9+0n3R7/6/Y5cdOoWpOmo+sdz87nfr53xK+Fz1Y3T3y1pFVVJ5UcWMObAlgDY
 pvgQknPun1Zc2ZJupm06uRCPRmOiP+gXT84h9eAguDNVDeNRAb98oLrimEui+/74HcJk
 elzKdMwpruHUmDT1g3eQASEsMuD5+aQ3K0Nt2Vi+jiF23poeT4W1zhlYhAwaFLJnH00O
 qyjqS3dqjbwFOcX8NzkMAnXwVw+9HZZim9H8R9nmLBmk75icyt1/TozKw0sINjvYCMwQ
 dZrc60QvWnSk08PVgBcgv8mq1fu2t5EFkdVrdcf09i7wm9/pMFpMmRYmVq4e9dB3U8pu
 hOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698642847; x=1699247647;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JtQ45ikALGGMBInfjAVoEgO8CPaLp7MZq2NUvJWFcoU=;
 b=Pr+z5LQlgL09ATR9DA7GsetNQOBwu88NmJAd/CFZGUuLbnGiW4RYdZ3RnXIPJvAiRb
 QNt8JHfrIoEzqFfoQ+91/gm+xolKl3jBGq6wwayBn2McH6xjDlpLdadSw0IsYwMOmWhR
 OLM7hdkjgkHhf0Wq3dPzoRjz5OEkhrtsFpdRx9jIXLCKmSK+MSgrFWibesbB8jxTTpnw
 aW2Ot9l07rqNFdE/AvEe9yMrpkbOXD9FLuQoE8gOeoq601b4azLL5Ne5/Mo2Wqlw8Ic9
 zOzz3R0AcDfi2TGZJ37vv+eCKGiuC/5QfNrRsf42Bao+yCLBYgAcG3Dl2rMToo2L24eS
 HlWw==
X-Gm-Message-State: AOJu0YwsKq8fSVf/6R6+PXs/Zjn0mek0jrREDDeWGhf0B5WuJEqmBHwv
 d9KJZ4xVJw/OxK/RLgurX3Tonb2FIQyhrTQizyZoZQ==
X-Google-Smtp-Source: AGHT+IF8EFj2Xe0Wq6Up0MFyLOu06bJWt1nkbRlS2E0uIRiDmcLtEh3qaCRmasGDqZFXLLZVuv2Dmw==
X-Received: by 2002:a17:902:d490:b0:1cc:5920:1d1c with SMTP id
 c16-20020a170902d49000b001cc59201d1cmr60228plg.48.1698642846723; 
 Sun, 29 Oct 2023 22:14:06 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 iy9-20020a170903130900b001c9b8f76a89sm5372469plb.82.2023.10.29.22.14.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 22:14:06 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 00/21] virtio-net RSS/hash report fixes and improvements
Date: Mon, 30 Oct 2023 14:12:21 +0900
Message-ID: <20231030051356.33123-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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

Based-on: <20230524064704.47711-1-akihiko.odaki@daynix.com>
("[PATCH 0/2] net: Update MemReentrancyGuard for NIC")

This series contains fixes and improvements for virtio-net RSS and hash
reporting feature.

V5 -> V6:
  Corrected the message for patch "virtio-net: Return an error when vhost
  cannot enable RSS".
  Removed changes to introduce asserts from "virtio-net: Return an error
  when vhost cannot enable RSS".
  Reorganized patches "virtio-net: Return an error when vhost cannot enable
  RSS" and "virtio-net: Do not clear VIRTIO_NET_F_RSS". This version now
  contains patches "virtio-net: Return an error when vhost cannot enable
  RSS" and "virtio-net: Enable software RSS".
  Rebased.

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
  virtio-net: Enable software RSS
  virtio-net: Always set populate_hash
  virtio-net: Do not write hashes to peer buffer
  virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT
  ebpf: Fix RSS error handling
  ebpf: Use standard section name
  ebpf: Simplify error handling
  ebpf: Return 0 when configuration fails
  ebpf: Refactor tun_rss_steering_prog()
  ebpf: Add a separate target for skeleton

 ebpf/rss.bpf.skeleton.h  | 1557 +++++++++++++++++++-------------------
 include/net/filter.h     |    3 -
 include/net/net.h        |    7 -
 include/net/queue.h      |    7 -
 include/sysemu/replay.h  |    2 +-
 net/tap_int.h            |    1 -
 ebpf/ebpf_rss.c          |   12 +-
 hw/net/e1000e.c          |    1 -
 hw/net/igb.c             |    1 -
 hw/net/net_tx_pkt.c      |    4 +-
 hw/net/virtio-net.c      |  310 ++++----
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
 29 files changed, 1016 insertions(+), 1221 deletions(-)

-- 
2.42.0


