Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AF770D183
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:44:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I0F-00035D-86; Mon, 22 May 2023 22:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0D-00034k-BU
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:43:57 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0B-00041s-AF
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:43:56 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-25345ca8748so5727822a91.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809834; x=1687401834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mi0jD2YLKTaI07qPDskQj0RKQG2ZJagqsigHELyRUFM=;
 b=0rgWW4D+g0B8tVasEkc81X3+hZjmZXAh6GfBlzRNWcu76W0S6JQx9JJnvEnjBYWsa6
 9EwKnfBlEiX7FQTUtj0C/uffZlywTIXR28+7OdoY8X7UNO78eLTA/IggwtQTlmbs3Mal
 eDhnF9PtnSwmYAzXm9wtAgZjxLuTMy21vegfx0PeFvA4rvq+cUnq+P/40po4FKbRVcV+
 f7YOyt9qS23ATofBdOw5cMivaOMPmSA4Eh21B6edRVK5JD4+FeBDNmCxjazJ9s474FU8
 zjkKPcLIJsJbSm5hX+5kOjrRj0ijXeZ4SPqsAiF2ArlTHnKsIXv0KbEZ1vMLbK4p6nTF
 wxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809834; x=1687401834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mi0jD2YLKTaI07qPDskQj0RKQG2ZJagqsigHELyRUFM=;
 b=JTi7ufLBH7F5hGTGUwuO4As6GNUlvwz9z7qzQefc+I3TdkrYBsO9QL+BJzNrXcoiPz
 6LanhSz0WKUXDeAWVdaUBN50J4/kECOOFcu+fwHEiArS9GY6qSIGY0Q054Wdk1SlKvjI
 8QQPDM8esMiIfnBPQg/zlWMsYHlv75sk0VtkYPbeymCxi6IADot5bxExkXl/ZrA/7A20
 YfYNcO68yUCFuTaEOYrDcITMBLwTA62a9YkRwlMy8VxEHyQbVXrxpS4vY6fpijEP/rmW
 +rEPMhXt7nsM+vcpopJkl2ZlFcQkqHSUry9QXAzDx076NflQxNIivLIqHI6Tttiwjqcn
 M6fw==
X-Gm-Message-State: AC+VfDzZF455BKRp/ptF3oceYHmf6EXX2Zp1uNDgc1o95iSswlR5SbWf
 35cK36BxjBT5W40K/H8kfNxfmw==
X-Google-Smtp-Source: ACHHUZ5ah0HFRWptWnxG4PUkCS5OgGR11dGVn9YyRtO8fSpF7AWhZNsTPkcgxXX9zYk7Im0Tqn/eKQ==
X-Received: by 2002:a17:90a:690d:b0:255:a1d9:4486 with SMTP id
 r13-20020a17090a690d00b00255a1d94486mr1174927pjj.1.1684809833725; 
 Mon, 22 May 2023 19:43:53 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:43:53 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 00/48] igb: Fix for DPDK
Date: Tue, 23 May 2023 11:42:51 +0900
Message-Id: <20230523024339.50875-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1033.google.com
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

Based-on: <366bbcafdb6e0373f0deb105153768a8c0bded87.camel@gmail.com>
("[PATCH 0/1] e1000e: Fix tx/rx counters")

This series has fixes and feature additions to pass DPDK Test Suite with
igb. It also includes a few minor changes related to networking.

Patch [01, 10] are bug fixes.
Patch [11, 14] delete code which is unnecessary.
Patch [15, 33] are minor changes.
Patch [34, 46] implement new features.
Patch [47, 48] update documentations.

While this includes so many patches, it is not necessary to land them at
once. Only bug fix patches may be applied first, for example.

V4 -> V5:
- Fixed L2 packet type bit location.

V3 -> V4:
- Renamed "min_buf variable to "buf". (Sriram Yagnaraman)
- Added patch "igb: Clear-on-read ICR when ICR.INTA is set".
  (Sriram Yagnaraman)

V2 -> V3:
- Fixed parameter name in hw/net/net_tx_pkt. (Philippe Mathieu-Daudé)
- Added patch "igb: Clear IMS bits when committing ICR access".
- Added patch "igb: Clear EICR bits for delayed MSI-X interrupts".
- Added patch "e1000e: Rename a variable in e1000e_receive_internal()".
- Added patch "igb: Rename a variable in igb_receive_internal()".
- Added patch "e1000e: Notify only new interrupts".
- Added patch "igb: Notify only new interrupts".

V1 -> V2:
- Dropped patch "Include the second VLAN tag in the buffer". The second
  VLAN tag is not used at the point and unecessary.
- Added patch "e1000x: Rename TcpIpv6 into TcpIpv6Ex".
- Split patch "hw/net/net_tx_pkt: Decouple from PCI".
  (Philippe Mathieu-Daudé)
- Added advanced Rx descriptor packet encoding definitions.
  (Sriram Yagnaraman)
- Added some constants to eth.h to derive packet oversize thresholds.
- Added IGB_TX_FLAGS_VLAN_SHIFT usage.
- Renamed patch "igb: Fix igb_mac_reg_init alignment".
  (Philippe Mathieu-Daudé)
- Fixed size check for packets with double VLAN. (Sriram Yagnaraman)
- Fixed timing to timestamp Tx packet.

Akihiko Odaki (48):
  hw/net/net_tx_pkt: Decouple implementation from PCI
  hw/net/net_tx_pkt: Decouple interface from PCI
  e1000x: Fix BPRC and MPRC
  igb: Fix Rx packet type encoding
  igb: Do not require CTRL.VME for tx VLAN tagging
  igb: Clear IMS bits when committing ICR access
  net/net_rx_pkt: Use iovec for net_rx_pkt_set_protocols()
  e1000e: Always copy ethernet header
  igb: Always copy ethernet header
  Fix references to igb Avocado test
  tests/avocado: Remove unused imports
  tests/avocado: Remove test_igb_nomsi_kvm
  hw/net/net_tx_pkt: Remove net_rx_pkt_get_l4_info
  net/eth: Rename eth_setup_vlan_headers_ex
  e1000x: Share more Rx filtering logic
  e1000x: Take CRC into consideration for size check
  e1000x: Rename TcpIpv6 into TcpIpv6Ex
  e1000e: Always log status after building rx metadata
  igb: Always log status after building rx metadata
  igb: Remove goto
  igb: Read DCMD.VLE of the first Tx descriptor
  e1000e: Reset packet state after emptying Tx queue
  vmxnet3: Reset packet state after emptying Tx queue
  igb: Add more definitions for Tx descriptor
  igb: Share common VF constants
  igb: Fix igb_mac_reg_init coding style alignment
  igb: Clear EICR bits for delayed MSI-X interrupts
  e1000e: Rename a variable in e1000e_receive_internal()
  igb: Rename a variable in igb_receive_internal()
  net/eth: Use void pointers
  net/eth: Always add VLAN tag
  hw/net/net_rx_pkt: Enforce alignment for eth_header
  tests/qtest/libqos/igb: Set GPIE.Multiple_MSIX
  igb: Implement MSI-X single vector mode
  igb: Use UDP for RSS hash
  igb: Implement Rx SCTP CSO
  igb: Implement Tx SCTP CSO
  igb: Strip the second VLAN tag for extended VLAN
  igb: Filter with the second VLAN tag for extended VLAN
  igb: Implement igb-specific oversize check
  igb: Implement Rx PTP2 timestamp
  igb: Implement Tx timestamp
  e1000e: Notify only new interrupts
  igb: Notify only new interrupts
  igb: Clear-on-read ICR when ICR.INTA is set
  vmxnet3: Do not depend on PC
  MAINTAINERS: Add a reviewer for network packet abstractions
  docs/system/devices/igb: Note igb is tested for DPDK

 MAINTAINERS                                   |   3 +-
 docs/system/devices/igb.rst                   |  14 +-
 hw/net/e1000e_core.h                          |   2 -
 hw/net/e1000x_common.h                        |   9 +-
 hw/net/e1000x_regs.h                          |  24 +-
 hw/net/igb_common.h                           |  24 +-
 hw/net/igb_regs.h                             |  67 +-
 hw/net/net_rx_pkt.h                           |  38 +-
 hw/net/net_tx_pkt.h                           |  46 +-
 include/net/eth.h                             |  29 +-
 include/qemu/crc32c.h                         |   1 +
 hw/net/e1000.c                                |  41 +-
 hw/net/e1000e_core.c                          | 292 +++----
 hw/net/e1000x_common.c                        |  79 +-
 hw/net/igb.c                                  |  10 +-
 hw/net/igb_core.c                             | 717 ++++++++++--------
 hw/net/igbvf.c                                |   7 -
 hw/net/net_rx_pkt.c                           | 107 ++-
 hw/net/net_tx_pkt.c                           | 101 ++-
 hw/net/virtio-net.c                           |   7 +-
 hw/net/vmxnet3.c                              |  22 +-
 net/eth.c                                     | 100 +--
 tests/qtest/libqos/igb.c                      |   1 +
 util/crc32c.c                                 |   8 +
 hw/net/Kconfig                                |   2 +-
 hw/net/trace-events                           |  19 +-
 .../org.centos/stream/8/x86_64/test-avocado   |   3 +-
 tests/avocado/netdev-ethtool.py               |  17 +-
 28 files changed, 969 insertions(+), 821 deletions(-)

-- 
2.40.1


