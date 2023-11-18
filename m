Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC50E7EFEAF
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 10:26:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4Hai-00069y-Pz; Sat, 18 Nov 2023 04:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4Hag-00069q-R9
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:26:14 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4Haf-0003fJ-2N
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:26:14 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3b6d80daae8so1851345b6e.2
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 01:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700299571; x=1700904371;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bzPbn/UXtEGcJrWyb4phGcKNnE54oqJAK5ni2viz46M=;
 b=RPx72Ulq24JDGI+NmYXSEkCw6/zVBct4Wu9QAAGNU4f/3cJEpD7wRhlhfQy9KHMUUG
 wro4Yf4cpAVcUwxW2TuE2vwQxs+pwQsfyKjCvTTpunrXgeUHNXko11o+Tbgn+N18BtHU
 vqgENG7Z5zG7FmcRdrEqCx5IpN2ns6NL3wl52ZRkXjCxN0NG3YGcFzxO4oHN33oGFVPt
 Erc5/5grPUECBA2/lTA6QDgmZTv8L4xDYslWCC5OR2bppj8yPbs8w6/xqloxMPxov8t5
 5L2/JHl0EGLoxzikOjZO1TbgxmGjAYfKJMZbygSMTshjLhN3ChpwtK47vbVaY4Zux5fk
 bD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700299571; x=1700904371;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bzPbn/UXtEGcJrWyb4phGcKNnE54oqJAK5ni2viz46M=;
 b=JjGIPnI1Yq0MmBBHyZLLbrHUrf+i2Tc/jv9C1xLXJPFpSC+R4LlApQpGO50D1AIu85
 1GVSr99qHVV+u7BRXzLq67FlH86SoI0PAY/BRgmOxfFg6VDrI38PxccM5lCIsrtTfY9J
 hkWPLvxhIERJSLZmR1XeqBgSGWPK62R+F4aNMo3FhzdGgbtmfTiNqSM52HsZZbYyT/ny
 zoLk4/TxjS5jYrT81yr3cbbZ92Oi1YJ1BGl6SEvNuNd5W1ElRSia+ewpaG1Vk3gu1PHX
 pISc5lgmWw48YnTy/vsJSF/O6JHIfimZeyawjC8cZjKJd1xffb+idP84RUyMyozCRyzt
 NZ2g==
X-Gm-Message-State: AOJu0Yw1XL++5yLw5LHtui2qtcJ+ijvV22bnHZ9Gz9NdE5L/h4a1ZM1y
 IBwjcgL65aNQ2TupI3ZxfGfx/FfTIlscPrUNDpU=
X-Google-Smtp-Source: AGHT+IGfePU0NSMpss64OfL1+73vTQ7uvBU7puWKU7gFae6uVzTiQEwIS4nnh73h2NK4d+T3yAqfLA==
X-Received: by 2002:a05:6808:1642:b0:3b2:f54b:8b1f with SMTP id
 az2-20020a056808164200b003b2f54b8b1fmr2111763oib.35.1700299571633; 
 Sat, 18 Nov 2023 01:26:11 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 b7-20020a636707000000b005ab46970aaasm2627986pgc.17.2023.11.18.01.26.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 01:26:10 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Zhang, Chen" <chen.zhang@intel.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RESEND v7 00/19] virtio-net RSS/hash report fixes and
 improvements
Date: Sat, 18 Nov 2023 18:25:40 +0900
Message-ID: <20231118092601.7132-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::234;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

V6 -> V7:
  Dropped patch "virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT".
  Dropped the changes to remove packet flags.
  Re-introduced tap_receive() and changed it to call tap_receive_iov().
  Removed tap_get_vnet_hdr_len().
  Fixed tap initialization not to call tap_fd_set_vnet_hdr_len() for tap
  without virtio-net header.
  Changed to call error_report() instead of warn_report() for
  programming errors.

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

Akihiko Odaki (19):
  tap: Remove tap_probe_vnet_hdr_len()
  tap: Remove qemu_using_vnet_hdr()
  net: Move virtio-net header length assertion
  net: Remove receive_raw()
  tap: Call tap_receive_iov() from tap_receive()
  tap: Shrink zeroed virtio-net header
  virtio-net: Copy header only when necessary
  virtio-net: Disable RSS on reset
  virtio-net: Unify the logic to update NIC state for RSS
  virtio-net: Return an error when vhost cannot enable RSS
  virtio-net: Report RSS warning at device realization
  virtio-net: Always set populate_hash
  virtio-net: Do not write hashes to peer buffer
  ebpf: Fix RSS error handling
  ebpf: Use standard section name
  ebpf: Simplify error handling
  ebpf: Return 0 when configuration fails
  ebpf: Refactor tun_rss_steering_prog()
  ebpf: Add a separate target for skeleton

 ebpf/rss.bpf.skeleton.h  | 1557 +++++++++++++++++++-------------------
 include/net/net.h        |    8 -
 net/tap_int.h            |    1 -
 ebpf/ebpf_rss.c          |   12 +-
 hw/net/e1000e.c          |    1 -
 hw/net/igb.c             |    1 -
 hw/net/net_tx_pkt.c      |    4 +-
 hw/net/virtio-net.c      |  308 ++++----
 hw/net/vmxnet3.c         |    2 -
 net/dump.c               |    4 +-
 net/net.c                |   47 +-
 net/netmap.c             |    5 -
 net/tap-bsd.c            |    5 -
 net/tap-linux.c          |   20 -
 net/tap-solaris.c        |    5 -
 net/tap-stub.c           |    5 -
 net/tap.c                |   77 +-
 tools/ebpf/rss.bpf.c     |   46 +-
 tools/ebpf/Makefile.ebpf |   15 +-
 19 files changed, 986 insertions(+), 1137 deletions(-)

-- 
2.42.1


