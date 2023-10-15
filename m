Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F60A7C9947
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:04:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1i3-0001D7-Rt; Sun, 15 Oct 2023 10:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1i0-0001Cg-Kr
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:08 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1hy-0007gm-JV
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:08 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c9daca2b85so26366655ad.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697378584; x=1697983384;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WI+8LWb0hylILtwAyA7V12t2W4GWf6KGOgE959Aw9nQ=;
 b=eqzqZhtUNqoiBMKxnNc4beY2bWcUz5nk/s2w8DoTuIKa3nDVtcZgnoHG0bDQxSAWWx
 SOcWtE7N9d4rf7wWa/65dtSgfsLnmk3ByWnCjS0rDuDEQQmh64q7mcvn5c10saVD6JlF
 aZ/dYbqWvPzCE/7wTwymiGstUFMTuiZJEqhsUFK24gkAJnkUldFg27MQgVKgm/IhfveL
 5DiQnwmg6tn1oMB1FvjRskEFufVi45hOqIciWQfcJvWGAh11kz5alZRW0sCgndd7OB+Q
 dw8VS/WkfvDDJJn+6etILJePn4C/xaJeiNc7nDR/fpomA86QLToEYEAjVT720prLCxgH
 J4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697378584; x=1697983384;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WI+8LWb0hylILtwAyA7V12t2W4GWf6KGOgE959Aw9nQ=;
 b=qPH3XjoZwUWgriPjreOgqbwHze6es4aUHGJ4peKAbbe3hbM5vLXFxt3zl22OXiaS/Z
 9i4cbsDjVWQpEZmQIR2ZJHHac4p6/L1tfJJ2fG3YvhaUOz5ATX5fpmddhb6+UFIB0iG2
 0NVFo6k8j4s4XG6Ytn6ZJgdr7Zu+FGsGPidH3HysHsxxPoU6x+Zyke7BExCo/Uv68P70
 /yyCDEyUbG203o8IyOAt2PLGobyvCVpdFVrPg1rD4vs/IM3sCkFBcbvkdosKDkz688ip
 mNVZ7NhUDZsUPlFcTxJUyIfyNcNVY8FQUWCxHki8TE8rwPtYUKOoEAL1hEeNiVrwfthj
 aEfQ==
X-Gm-Message-State: AOJu0YxYXZNM+Ws2iiTuDqC2XehucFK86f+QoS7VxzBPqZ3onR2BFfZr
 OXNd98VLx0G0H5lJl51jtB3QyBkzQfrqNb/yJgfxug==
X-Google-Smtp-Source: AGHT+IHkmA/5nrxQcQngqBG1MONWeNXDpv8yqTlElNV+yUaZ5b+PEKMnHwsdEbZyC0v0iyjcyZihPw==
X-Received: by 2002:a17:902:ecd1:b0:1bc:1e17:6d70 with SMTP id
 a17-20020a170902ecd100b001bc1e176d70mr8948890plh.24.1697378584052; 
 Sun, 15 Oct 2023 07:03:04 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 iy6-20020a170903130600b001c877f27d1fsm6850932plb.11.2023.10.15.07.03.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:03:03 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 00/20] virtio-net RSS/hash report fixes and improvements
Date: Sun, 15 Oct 2023 23:02:32 +0900
Message-ID: <20231015140259.259434-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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

Akihiko Odaki (20):
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
 hw/net/virtio-net.c      |  283 ++++---
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
 31 files changed, 1027 insertions(+), 1257 deletions(-)

-- 
2.42.0


