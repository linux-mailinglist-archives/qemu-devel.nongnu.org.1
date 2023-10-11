Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B109B7C5845
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 17:41:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqbK4-0002Ob-Oc; Wed, 11 Oct 2023 11:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqbJW-00023R-Eo
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:40:00 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqbJT-0001uN-NP
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:39:57 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3af609b9264so4791183b6e.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697038794; x=1697643594;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c/yajKtEXNlIrTIQx5KkKAUhYiJyXNNxvkhJOkkWVbE=;
 b=qDIfzFyGfrIquqET4RP4M+caO2ZBoICDUQIvRNM8uk1ZGNeqtGqbq5XSfO41gSPBZ2
 nP0UBzef/JgcTVRjaIFcoI6dcz3VyNaCGqws93CJXEksR8R31o0qu9gWnCnu6xQD82YC
 d7KHRQ+dzP1wnOnkuR/foWmvCckc90Ai3/whpkEAn8TmabucuHI43S56lYeoPanpjysA
 ueLEEzAKRx6SiA+FrDqdHuSfEkCiURN/ayqNcoieCRhqtk+cMaj23fK5jO4oAAFTaz11
 s+Tmcb6FdLvpebxyKZjRyD44NeYTVuwJliJyTAIW570OiQr+XZaeCs2uVxGkNgEZmjLq
 NRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697038794; x=1697643594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c/yajKtEXNlIrTIQx5KkKAUhYiJyXNNxvkhJOkkWVbE=;
 b=LBtNdqmwGdOJIXxYyW/Qmav9uhvRKiUJbwuRNbt4PjZlD5vRLrbMYf5TUkZ6Ucbzlo
 2RKa/ANEtsK7cSV27eB/OBfYXBFgVGt4YKYEDquVjsgMfaTv71c49YbVYMxfUuYYhwh3
 ZHBgTl5lWCJ5Ary5a+RWTqAYg6CCEcCiaPtd26Tat7aNGO0BZQidO6wnYyfH+O//bsP9
 kbNlimqZRSsH+rgYQ4d6sCoQCCXQu0B4DFae2zBT2mXJvlCs3Jth7tKcO/pR7D7QUNYZ
 L1pd0ru6vzFZn5MngNRcho+jFd8BVUDofbrHbg1t6RSADL+IS2SEmT7XGwgo59JOUI5v
 QbjQ==
X-Gm-Message-State: AOJu0YyznU6hzY+7D6A+U1BmW3NjZFpcv4Sp7vXWD39VVx4q1Kt/H1mO
 3PsvwyEiEZaQdD0e4Gc45mw56pA9vb8bd9IqLjQy0A==
X-Google-Smtp-Source: AGHT+IEuzv4nkCGqmt2OEPaiJDe8W1XgjX8FpOOlqh0nxT3YExa73VLP00bAeQlPU9yBmf7U89olbQ==
X-Received: by 2002:a05:6358:918c:b0:14e:28f9:53fd with SMTP id
 j12-20020a056358918c00b0014e28f953fdmr20388004rwa.15.1697038793949; 
 Wed, 11 Oct 2023 08:39:53 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 m26-20020a056a00165a00b0068fb4f5f38fsm10313249pfc.30.2023.10.11.08.39.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 08:39:53 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 00/11] virtio-net RSS/hash report fixes
Date: Thu, 12 Oct 2023 00:39:31 +0900
Message-ID: <20231011153944.39572-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::231;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x231.google.com
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

V2 -> V3:
  Added patch "tap: Remove tap_probe_vnet_hdr_len()".
  Added patch "tap: Remove qemu_using_vnet_hdr()".
  Added patch "net: Move virtio-net header length assertion".
  Added patch "net: Remove receive_raw()".
  Added patch "tap: Shrink zeroed virtio-net header".
  Dropped patch "tap: Fix virtio-net header buffer size".

V1 -> V2:
  Added patch "ebpf: Fix RSS error handling".

Akihiko Odaki (11):
  tap: Remove tap_probe_vnet_hdr_len()
  tap: Remove qemu_using_vnet_hdr()
  net: Move virtio-net header length assertion
  net: Remove receive_raw()
  tap: Shrink zeroed virtio-net header
  virtio-net: Copy header only when necessary
  virtio-net: Disable RSS on reset
  virtio-net: Unify the logic to update NIC state for RSS
  virtio-net: Return an error when vhost cannot enable RSS
  virtio-net: Do not clear VIRTIO_NET_F_RSS
  ebpf: Fix RSS error handling

 ebpf/ebpf_rss.h         |   2 +-
 include/net/filter.h    |   3 -
 include/net/net.h       |   7 -
 include/net/queue.h     |   7 -
 include/sysemu/replay.h |   2 +-
 net/tap_int.h           |   1 -
 ebpf/ebpf_rss-stub.c    |   4 +-
 ebpf/ebpf_rss.c         |  68 ++++------
 hw/net/e1000e.c         |   1 -
 hw/net/igb.c            |   1 -
 hw/net/net_tx_pkt.c     |   4 +-
 hw/net/virtio-net.c     | 280 ++++++++++++++++++----------------------
 hw/net/vmxnet3.c        |   2 -
 net/dump.c              |   8 +-
 net/filter-buffer.c     |   4 +-
 net/filter-mirror.c     |   4 +-
 net/filter-replay.c     |   3 +-
 net/filter-rewriter.c   |   5 +-
 net/filter.c            |   8 +-
 net/net.c               |  83 ++++--------
 net/netmap.c            |   5 -
 net/queue.c             |  30 ++---
 net/tap-bsd.c           |   5 -
 net/tap-linux.c         |  20 ---
 net/tap-solaris.c       |   5 -
 net/tap-stub.c          |   5 -
 net/tap.c               |  74 +----------
 replay/replay-net.c     |   8 +-
 tools/ebpf/rss.bpf.c    |  20 +--
 29 files changed, 224 insertions(+), 445 deletions(-)

-- 
2.42.0


