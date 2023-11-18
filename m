Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D4F7EFEA9
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 10:20:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4HTk-0002St-OM; Sat, 18 Nov 2023 04:19:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4HTi-0002R4-FT
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:19:02 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4HTg-00054v-Go
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:19:02 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6ce291b5df9so1778340a34.2
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 01:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700299138; x=1700903938;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bzPbn/UXtEGcJrWyb4phGcKNnE54oqJAK5ni2viz46M=;
 b=jD6EOOj6WJCzcS1foWbqWQK/B3nDhvtI/hTkMVWQbxusL4qTmHwe+QPuQZop82UNhl
 HR2gBuMrHf6Ye1YQZbmockeutv55b3fO/h22B090goEdsAMFxpCvqYwQYHcC3P9pEQet
 DLLV3UQecFBnDZZXD7iozT+w9ZwUnYJM5jUjPbhq24gsn8Tonzi6NpU8ygCHFgYGVOVB
 QwZbwnNdfllzBfpR8BrTTiTErwPiRZWIB5VQeIPwu0NcRzaj5pzORPdoG20TXTospCzz
 x5jBYO21YktNq9TUGGsBSCZcr8UJQZWHEofqfttcw+Vr0MZ71CoHlMf5RVXe9ZBOSdN+
 6hmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700299138; x=1700903938;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bzPbn/UXtEGcJrWyb4phGcKNnE54oqJAK5ni2viz46M=;
 b=kiuZxpyUmh0SDfNa+u5PUJsJEPrGOHmFBdSSZfN1SQgEGKErjwPZnfdBQjWHod9+JM
 /Uwvk+WIKl2UAy50LAB+oG1Bk//x/PAbIcv2UQE4wSJmTKU2cx/AZXAPRcNrOisObmhr
 dWzj1XGmUqu0t3rWzl21A6Kt2n85g3tJ9KER6nigHBsI2tjkYkOVilplnW+ulccPYoJk
 b6nn/3ZfYOwvj1Qgrga1JIg52shaxSqFc3Vj09sp5hAb3IPYxxEs1vAoyTSoATIbkCAd
 2Z6ChzFJ+q71FiToalf1TzvGf0FOEXv9RfQFDwz9zASy9ngye330DnL728ZbDIRsvYlh
 xS1g==
X-Gm-Message-State: AOJu0YzHLlkPbSRhg72Y5UOe05KlFNnpvjtl8AQLcxmHi4ub8ny3wdGB
 6T+g9N4Ycwsf6CWacCUMRrta1s+i391W79SYXwg=
X-Google-Smtp-Source: AGHT+IEffugknbHh1B/SU8SRq8jn96B9fZ4Vx8T1UBqYSaICWkHfMzyx0B+DhMlBO4Mxqugl/5cy2w==
X-Received: by 2002:a9d:4b0a:0:b0:6c6:4843:2ac5 with SMTP id
 q10-20020a9d4b0a000000b006c648432ac5mr1959432otf.21.1700299138303; 
 Sat, 18 Nov 2023 01:18:58 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 x20-20020a63fe54000000b005bdd8dcfe19sm2668576pgj.10.2023.11.18.01.18.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 01:18:57 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Zhang, Chen" <chen.zhang@intel.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v7 00/19] virtio-net RSS/hash report fixes and improvements
Date: Sat, 18 Nov 2023 18:18:14 +0900
Message-ID: <20231118091837.5758-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32c.google.com
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


