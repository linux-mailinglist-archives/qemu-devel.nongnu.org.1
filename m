Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C177C9992
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:28:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs26B-0004EF-AA; Sun, 15 Oct 2023 10:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs268-0004Dr-E8
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:28:04 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs266-0003It-Lt
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:28:04 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-57bab4e9e1aso2319250eaf.3
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697380081; x=1697984881;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=trprVr2mK/QmqvtCAUEQn75020aXPz91aNTNpM2f3fQ=;
 b=HQTOLs1KBTXtb9NgVZwzcESNG+6+u3BJZ1EXRGrWRdlvsRJxaRXIa6uK28CkNYaBON
 dBiVqnPVl8nOjMtz8SRScX1DAQJhfkvRPCWsHq0pW4U7vj34O6+CGGqGppeBXpCgpOh2
 YguccNNTo0rN9VB70hWVtyWrh89QdEfo6dEnwU0EgzAldpWJjAhFnuCmC9qGKVuzNJxC
 orEitcyBAbXlH2KOzlcUTQP9YfhQmlBvLGjNt82/SepMnCe7YttV2P1m8iAuvHmeV8O9
 4/U5bAiLQ9eRZgSlAM4DB6k5orGGlbauS8+JeNWyKFZHhC2btayjR4FsdleO0cMAPgG5
 5ixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697380081; x=1697984881;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=trprVr2mK/QmqvtCAUEQn75020aXPz91aNTNpM2f3fQ=;
 b=nud8YWtLTzCMOSkl8K7asSSxwplxAZypmjZ/wstOgh3/vcM9Y7u7oEbrHF0lsWF00B
 qIwqSBFgVA1QHsZU6PYPngHORHbTezU4/XvT9SDyGGR7feTt8ieVx5giiTapXeRBgRdA
 5AtsEFdYUYS0IyncU19wVPpeZSlYYvGiE2DNsQnJJ7l2wVkqqAWPrUWbBe6lKh59hj0R
 7tSTYFzpVyM1jtb85jnJNB1KnSSMijnrBXRXNvivpPUrdtqUDU8hLCAGljTbY0zFGEOH
 yCKO5jFBq2W2ma86nkmRA3rNeQcRHgwJ12ZapecNa7qQO4GXnul9VGT4TWPnMe4DckPm
 cFFA==
X-Gm-Message-State: AOJu0Yy7m88zTQhsdLVsnpdSvGQDgzb4z60RPirnJe29CJTki+umg7LK
 M2GG2xdmh4l2vLPMfOGHaqfdm3qghajoEIFtWf9VbA==
X-Google-Smtp-Source: AGHT+IE2xJ+zYM1nGUg7vMDTgEwPJRfuM68JID+u9HwkYbkcDRx+fBbtr6/ThN7L59D/ON1jSEv8uw==
X-Received: by 2002:a05:6358:9992:b0:143:3179:1a67 with SMTP id
 j18-20020a056358999200b0014331791a67mr28388223rwb.29.1697380081073; 
 Sun, 15 Oct 2023 07:28:01 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 k12-20020a62840c000000b006b4ca26f3c9sm4003105pfd.74.2023.10.15.07.27.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:28:00 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH v2 0/3] virtio-net: Introduce eBPF hash reporting
Date: Sun, 15 Oct 2023 23:27:42 +0900
Message-ID: <20231015142755.261808-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c31;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc31.google.com
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

Based-on: <20231015140259.259434-1-akihiko.odaki@daynix.com>
("[PATCH v4 00/20] virtio-net RSS/hash report fixes and improvements")

I'm proposing to introduce a new BPF program type to report virtio-net
hashes to Linux. This series contain patches to utilize the proposed Linux
feature. The patches for Linux are available at:
https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@daynix.com/

V1 -> V2:
  Changed to use the new BPF program type

Akihiko Odaki (3):
  ebpf: Add tools/ebpf/vnet_hash.bpf.c
  virtio-net: Use vnet_hash BPF program
  docs: Describe eBPF hash reporting

 docs/devel/ebpf_rss.rst             |    5 +-
 ebpf/ebpf_rss.h                     |    2 +
 ebpf/rss.bpf.skeleton.h             |  995 -------------------------
 ebpf/socket.bpf.skeleton.h          | 1019 +++++++++++++++++++++++++
 ebpf/vnet_hash.bpf.skeleton.h       | 1075 +++++++++++++++++++++++++++
 tools/ebpf/{rss.bpf.c => rss.bpf.h} |   49 +-
 ebpf/ebpf_rss-stub.c                |    5 +
 ebpf/ebpf_rss.c                     |   64 +-
 hw/net/virtio-net.c                 |   62 +-
 tools/ebpf/socket.bpf.c             |   32 +
 tools/ebpf/vnet_hash.bpf.c          |   29 +
 tools/ebpf/Makefile.ebpf            |    6 +-
 12 files changed, 2289 insertions(+), 1054 deletions(-)
 delete mode 100644 ebpf/rss.bpf.skeleton.h
 create mode 100644 ebpf/socket.bpf.skeleton.h
 create mode 100644 ebpf/vnet_hash.bpf.skeleton.h
 rename tools/ebpf/{rss.bpf.c => rss.bpf.h} (91%)
 create mode 100644 tools/ebpf/socket.bpf.c
 create mode 100644 tools/ebpf/vnet_hash.bpf.c

-- 
2.42.0


