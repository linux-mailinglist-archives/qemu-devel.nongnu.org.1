Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC0270D513
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:33:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MW0-00081i-L8; Tue, 23 May 2023 03:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MVo-000801-HG
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:32:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MVm-00046e-JH
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hRRFYvh/YpVZnPsMTDXRsMb6R6m+51iKGKKOa05KlPo=;
 b=TaDoTjySX+zpm99vnWVpBgGPIMpzGNy31CgSZQlvlvsHml1G7bR0j/C8YFDqRJsqjEPAjE
 cWlQHCE8Z9KVbQnfGwY8n/Ju7G86bvU7x7XGIQ2mt7oSeKKb5eHV6mo+GezEFSuxRWIfJt
 yJbl5upbQ+5Di2tMHtMvUk3mf3vGdZU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-wKRiJiRGOl2yxtldgUmUZQ-1; Tue, 23 May 2023 03:32:44 -0400
X-MC-Unique: wKRiJiRGOl2yxtldgUmUZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53C36101A585;
 Tue, 23 May 2023 07:32:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D7B32166B25;
 Tue, 23 May 2023 07:32:41 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PULL 00/50] Net patches
Date: Tue, 23 May 2023 15:31:48 +0800
Message-Id: <20230523073238.54236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 886c0453cbf10eebd42a9ccf89c3e46eb389c357:

  Merge tag 'pull-qapi-2023-05-17-v2' of https://repo.or.cz/qemu/armbru into staging (2023-05-22 15:54:21 -0700)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 792676c165159c11412346870fd58fd243ab2166:

  rtl8139: fix large_send_mss divide-by-zero (2023-05-23 15:20:15 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
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

Stefan Hajnoczi (1):
      rtl8139: fix large_send_mss divide-by-zero

timothee.cocault@gmail.com (1):
      e1000e: Fix tx/rx counters

 MAINTAINERS                                        |   3 +-
 docs/system/devices/igb.rst                        |  14 +-
 hw/net/Kconfig                                     |   2 +-
 hw/net/e1000.c                                     |  46 +-
 hw/net/e1000e_core.c                               | 297 ++++-----
 hw/net/e1000e_core.h                               |   2 -
 hw/net/e1000x_common.c                             |  82 ++-
 hw/net/e1000x_common.h                             |   9 +-
 hw/net/e1000x_regs.h                               |  24 +-
 hw/net/igb.c                                       |  10 +-
 hw/net/igb_common.h                                |  24 +-
 hw/net/igb_core.c                                  | 722 +++++++++++----------
 hw/net/igb_regs.h                                  |  67 +-
 hw/net/igbvf.c                                     |   7 -
 hw/net/net_rx_pkt.c                                | 107 +--
 hw/net/net_rx_pkt.h                                |  38 +-
 hw/net/net_tx_pkt.c                                | 101 +--
 hw/net/net_tx_pkt.h                                |  46 +-
 hw/net/rtl8139.c                                   |   3 +
 hw/net/trace-events                                |  19 +-
 hw/net/virtio-net.c                                |   7 +-
 hw/net/vmxnet3.c                                   |  22 +-
 include/net/eth.h                                  |  29 +-
 include/qemu/crc32c.h                              |   1 +
 net/eth.c                                          | 100 +--
 scripts/ci/org.centos/stream/8/x86_64/test-avocado |   3 +-
 tests/avocado/netdev-ethtool.py                    |  17 +-
 tests/qtest/libqos/igb.c                           |   1 +
 util/crc32c.c                                      |   8 +
 29 files changed, 979 insertions(+), 832 deletions(-)



