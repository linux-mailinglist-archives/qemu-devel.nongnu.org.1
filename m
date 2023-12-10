Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9DD80B8FE
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 06:31:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCCON-0001yP-VP; Sun, 10 Dec 2023 00:30:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCOC-0001wL-Fa
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:06 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCOA-0002vd-1i
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:04 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6d9e9f3a3abso1548761a34.3
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 21:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702186201; x=1702791001;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sum8t79+OpX8YpgN9ieH5VICo3lYg0njJNCKzPbJPZg=;
 b=kLt1V1jiU50EcVDE5yO5/nCMoIFLQYsysLtzp1W3RcXHH9w8WT6f1+9LkF75HpwA2D
 EqgH9eQI4UbNTDFKw9UhkIbhwJV2V+cspG4+17yysclFPYDSw0MGk617n96aflUCWeGS
 oj1AL+tZkpKP8yu2W5c7FLa+hRM+fXF+YThrGen8cOoDsX7MRM2cgzrUliTLlw+NeE24
 ZDpc+6rUcFFThQ7z0RzCYmB4YCzEq3kBVq3rQQKs1ABVWZj7mpTUtXaIYHeUTwhl4qUw
 41zs2tKzwadxYni+k45myGeLMRWB4NYCu0bE2QDWPlSnaE2R19lAf+V1thVODlcJyEyb
 0UJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702186201; x=1702791001;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sum8t79+OpX8YpgN9ieH5VICo3lYg0njJNCKzPbJPZg=;
 b=uxKhOcFd1Zqe0OcoGmnBvOwVmLPgRqIbpzD64LKSP65LFYbFcccyPt+IINQHk2dN47
 Dw3iLH8JCHt6Wv1qLmJfsalTshPlZWrmnz654EQMNV2g9CGPeMyA7awFAlW3yxHDKyAD
 rcZ1mfqNaE7x4YInm70u00Km3Hi8Z8zyJuKweqlaeWVkrpBdMRPGJ+ehR3QmCuEkS3T5
 G79aZnRBJgiget6XbaoJNjeR+hc/X/XNhzvup+MoU9cvY8WuRRQL4TtnukQksT10GCL/
 gZMhnfoxWMsxlyuHOm76ka8KvyZISXnl9B2JwVYU9PgVLiSHf46gH8szE61Ty+EXn76v
 E41Q==
X-Gm-Message-State: AOJu0YykfcwP5USx6G3JO9DR83bMOtO+A+KU4/8Hcoz8zjzzdEfGhiWS
 ZIDJc1dOH6Lr8ViDF4thotUlvw==
X-Google-Smtp-Source: AGHT+IHGRebwr46aeQi5a5EO8sdNNI3UPJELBML1lLD3PMmmFYK5OW2bXdVIQP0c0IvSeDCg2vIrpw==
X-Received: by 2002:a05:6808:219c:b0:3b8:b1bd:b36a with SMTP id
 be28-20020a056808219c00b003b8b1bdb36amr3367076oib.49.1702186200770; 
 Sat, 09 Dec 2023 21:30:00 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 i9-20020a17090332c900b001d07b659f91sm4216245plr.6.2023.12.09.21.29.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 21:30:00 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v8 00/19] virtio-net RSS/hash report fixes and improvements
Date: Sun, 10 Dec 2023 14:29:38 +0900
Message-Id: <20231210-rss-v8-0-9553ee714d38@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMJMdWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyLHQUlJIzE
 vPSU3UzU4B8JSMDI2NDI0MD3aLiYt1U82RLi1RzIyMjU2MloMqCotS0zAqwKdGxtbUA2KzG+lU
 AAAA=
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 "Zhang, Chen" <chen.zhang@intel.com>, Michael Tokarev <mjt@tls.msk.ru>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x334.google.com
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

This series contains fixes and improvements for virtio-net RSS and hash
reporting feature.

V7 -> V8:
  Reset author email addresses.
  Rebased.

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
  Reorganized patches "virtio-net: Return an error when vhost cannot
  enable RSS" and "virtio-net: Do not clear VIRTIO_NET_F_RSS". This
  version now contains patches "virtio-net: Return an error when vhost
  cannot enable RSS" and "virtio-net: Enable software RSS".
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
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

 ebpf/rss.bpf.skeleton.h  | 1557 +++++++++++++++++++++++-----------------------
 include/net/net.h        |    8 -
 net/tap_int.h            |    1 -
 ebpf/ebpf_rss.c          |   12 +-
 hw/net/e1000e.c          |    1 -
 hw/net/igb.c             |    1 -
 hw/net/net_tx_pkt.c      |    4 +-
 hw/net/virtio-net.c      |  308 +++++----
 hw/net/vmxnet3.c         |    2 -
 net/dump.c               |    4 +-
 net/net.c                |   47 +-
 net/netmap.c             |    5 -
 net/tap-bsd.c            |    5 -
 net/tap-linux.c          |   20 -
 net/tap-solaris.c        |    5 -
 net/tap-stub.c           |    5 -
 net/tap.c                |   77 +--
 tools/ebpf/rss.bpf.c     |   46 +-
 tools/ebpf/Makefile.ebpf |   15 +-
 19 files changed, 986 insertions(+), 1137 deletions(-)
---
base-commit: 9c74490bff6c8886a922008d0c9ce6cae70dd17e
change-id: 20231210-rss-e7c98e722253

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


