Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFAE7262AF
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:21:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6u0m-0002qW-5B; Wed, 07 Jun 2023 10:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0k-0002pr-37
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:42 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0i-0003Q0-9B
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1686147580;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bCzmK+QTz8cxoFGS+grvZ3JIIawRIpTTMiK7TiZbJyk=;
 b=cYot39Ud0thKPwU6DPVHInsWws2tj4nD/czvSWhkk+pFtExvDywfjnKF
 S63bxnH0tXudBdDAhQcA6j1V4c0cZq3qSNtpvEdzT7TCV5F7L/Y7OPafo
 iIOCUEEdVXRiQTUPXYrTevMkhMSHxDi4mRlyIWXNslQWgo0MIzYxzdCAR s=;
Authentication-Results: esa6.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 111246586
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:ulpoZK9icerqMy2NaLh3DrUD9X6TJUtcMsCJ2f8bNWPcYEJGY0x3z
 GtMXD3SaKyKNmugKY11bYW/oEkCu5GEyoQ3HgNv/io8E34SpcT7XtnIdU2Y0wF+jCHgZBk+s
 5hBMImowOQcFCK0SsKFa+C5xZVE/fjUAOG6UKicYXoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqojUNUTNNwRcawr40Ird7ks31BjOkGlA5AdmO6gU5AW2e0Q9V/rzG4ngdxMUfaEMdgKKb
 76r5K20+Grf4yAsBruN+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+v9T2M4nQVVWk120c+VZk
 72hg3ASpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDklq0
 f87LjVSMym5ntm/x6mHaPU82fYaeZyD0IM34hmMzBncBPciB5vCX7/L9ZlT2zJYasJmRKiEI
 ZBDMHw2MUqGOkcUUrsUIMtWcOOAj3/jczpeuRSNqLA++WT7xw1tyrn9dtHSf7RmQO0Mxx/C+
 jybrzqR7hcyFM2u4j2h+VmQv+r+sSj8RqgbN+OZz6s/6LGU7jNKU0BHPbehmtGgh0ujHt5SN
 UEQ0iwpq6c06QqsVNaVYvGjiCfa5FhGAYMWSrBkrljXkcI4/jp1GEAgaj1ibtl56fYMXAcj0
 US1vc+5Wg5W5ej9pW2myp+Yqja7OC4wJGAEZDMZQQZt3+QPsL3fnTqUEI89TffdYsndXGipn
 mvU9HRWa6A715Zj6kmtwbzQb9tATLDtRxV92AjYV3nNAuhRNN/8PNzABbQ2AJ99wGelorup5
 iBsdyu2trpm4XSxeMulHo0w8EmBvartDdElqQcH82Md3zqs4WW/Wotb/StzIkxkWu5dJ2+3O
 BCN418KtcMKVJdPUUORS9jpYyjN5fK5fekJq9iONoYeCnSPXFHvEN5Sib64gDm2zRlEfVAXM
 paHa8e8ZUv2+ow+pAdas9w1iOdxrghnnDO7eHwO50j/uVZoTCLPGOht3ZrnRrxR0Z5oVy2Lq
 4sOaZHXkUw3vS+XSnC/zLP/5GsidRATba0aYeQNHgJfCmKKwF0cNsI=
IronPort-HdrOrdr: A9a23:iYAqVKvSgHiJUt60msk60L857skDeNV00zEX/kB9WHVpm62j+/
 xG+c5x6faaslkssR0b9+xoWpPhfZqsz/9ICOAqVN/JMTUO01HYT72Kg7GSpgHIKmnT8fNcyL
 clU4UWMqyVMbGit7eZ3DWF
X-Talos-CUID: =?us-ascii?q?9a23=3A6eOYn2o3A/HD6Wc4xhMai4TmUeQBcV7bySiNGnW?=
 =?us-ascii?q?hMm9uU4G3VQ/Pypoxxg=3D=3D?=
X-Talos-MUID: 9a23:G4leCwujiwhcGS8qss2npCBTH8BM6I+SMUU8vZ4BpeONFnJRAmLI
X-IronPort-AV: E=Sophos;i="6.00,224,1681185600"; d="scan'208";a="111246586"
To: <qemu-devel@nongnu.org>
CC: Anthony PERARD <anthony.perard@citrix.com>
Subject: [PULL 00/12] xen queue
Date: Wed, 7 Jun 2023 15:18:27 +0100
Message-ID: <20230607141839.48422-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.155.175;
 envelope-from=prvs=51561cf95=anthony.perard@citrix.com;
 helo=esa6.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Anthony PERARD <anthony.perard@citrix.com>

The following changes since commit f5e6786de4815751b0a3d2235c760361f228ea48:

  Merge tag 'pull-target-arm-20230606' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-06-06 12:11:34 -0700)

are available in the Git repository at:

  https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20230607

for you to fetch changes up to 9000666052f99ed4217e75b73636acae61e6fc2c:

  xen-block: fix segv on unrealize (2023-06-07 15:07:10 +0100)

----------------------------------------------------------------
Xen queue

- fix for xen-block segv
- Resolve TYPE_PIIX3_XEN_DEVICE
- Xen emulation build/Coverity fixes

----------------------------------------------------------------
Anthony PERARD (1):
      xen-block: fix segv on unrealize

Bernhard Beschow (7):
      include/hw/xen/xen: Rename xen_piix3_set_irq() to xen_intx_set_irq()
      hw/pci/pci.c: Don't leak PCIBus::irq_count[] in pci_bus_irqs()
      hw/isa/piix3: Reuse piix3_realize() in piix3_xen_realize()
      hw/isa/piix3: Wire up Xen PCI IRQ handling outside of PIIX3
      hw/isa/piix3: Avoid Xen-specific variant of piix3_write_config()
      hw/isa/piix3: Resolve redundant k->config_write assignments
      hw/isa/piix3: Resolve redundant TYPE_PIIX3_XEN_DEVICE

David Woodhouse (4):
      hw/xen: Simplify emulated Xen platform init
      hw/xen: Fix memory leak in libxenstore_open() for Xen
      xen: Drop support for Xen versions below 4.7.1
      hw/xen: Fix broken check for invalid state in xs_be_open()

 hw/i386/kvm/xen_evtchn.c      |  40 ++++++++--------
 hw/i386/kvm/xen_evtchn.h      |   3 +-
 hw/i386/kvm/xen_xenstore.c    |   2 +-
 hw/i386/pc.c                  |  13 ++---
 hw/i386/pc_piix.c             |  36 ++++++++++++--
 hw/i386/xen/xen-hvm.c         |   2 +-
 hw/isa/piix3.c                |  60 +----------------------
 hw/pci/pci.c                  |   2 +
 hw/xen/xen-bus.c              |   6 ++-
 hw/xen/xen-operations.c       |  59 +----------------------
 include/hw/southbridge/piix.h |   1 -
 include/hw/xen/xen.h          |   2 +-
 include/hw/xen/xen_native.h   | 107 +-----------------------------------------
 meson.build                   |   5 +-
 scripts/xen-detect.c          |  60 -----------------------
 stubs/xen-hw-stub.c           |   2 +-
 16 files changed, 73 insertions(+), 327 deletions(-)

