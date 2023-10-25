Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 501FA7D5ED2
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 01:51:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvR9d-00066T-Qq; Tue, 24 Oct 2023 19:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qvR9a-000665-UY; Tue, 24 Oct 2023 19:49:42 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qvR9Y-0004q9-KG; Tue, 24 Oct 2023 19:49:42 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 2FBE275606C;
 Wed, 25 Oct 2023 01:49:36 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id ECB0A756066; Wed, 25 Oct 2023 01:49:35 +0200 (CEST)
Message-Id: <cover.1698190128.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 0/3] Add emulation of AmigaOne XE board
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Date: Wed, 25 Oct 2023 01:49:35 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Changes in v6:
- Dropped patch 1, now it's
Based-on: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
([PATCH v2 0/3] ide: implement simple legacy/native mode switching for PCI IDE controllers)
- Added Tested-by from Rene

Changes in v5:
- Fixed avocado test

Changes in v4:
- Found typo in comment in patch 1 so ended up rewording it again
trying to make it more concise. Also take the idea of using
range_covers_byte from Mark's patch
- Added RFC patch for avocado test (untested, I don't have Avocado)

Changes in v3:
- Update values, comment and commit message in patch 1 again

Changes in v2:
- Update comment and commit message in patch 1 (Mark)
- Fix irq mapping in patch 2 (Volker)

Regards,
BALATON Zoltan

BALATON Zoltan (3):
  hw/pci-host: Add emulation of Mai Logic Articia S
  hw/ppc: Add emulation of AmigaOne XE board
  tests/avocado: Add test for amigaone board

 MAINTAINERS                             |   8 +
 configs/devices/ppc-softmmu/default.mak |   1 +
 hw/pci-host/Kconfig                     |   5 +
 hw/pci-host/articia.c                   | 293 ++++++++++++++++++++++++
 hw/pci-host/meson.build                 |   2 +
 hw/ppc/Kconfig                          |   7 +
 hw/ppc/amigaone.c                       | 164 +++++++++++++
 hw/ppc/meson.build                      |   2 +
 include/hw/pci-host/articia.h           |  17 ++
 tests/avocado/ppc_amiga.py              |  38 +++
 10 files changed, 537 insertions(+)
 create mode 100644 hw/pci-host/articia.c
 create mode 100644 hw/ppc/amigaone.c
 create mode 100644 include/hw/pci-host/articia.h
 create mode 100644 tests/avocado/ppc_amiga.py

-- 
2.30.9


