Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 679DB748EB3
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 22:17:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH8sE-0002ht-1h; Wed, 05 Jul 2023 16:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qH8s9-0002gF-NG; Wed, 05 Jul 2023 16:13:09 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qH8s7-00063o-Nw; Wed, 05 Jul 2023 16:13:09 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 99B55746335;
 Wed,  5 Jul 2023 22:12:45 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 99B7574632B; Wed,  5 Jul 2023 22:12:44 +0200 (CEST)
Message-Id: <cover.1688586835.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 00/14] PPC440 devices misc clean up
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <"danielhb413@gmail.com>, philmd"@linaro.org>
Date: Wed,  5 Jul 2023 22:12:44 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

These are some small misc clean ups to PPC440 related device models
which is all I have ready for now.

v2:
- Added R-b tags from Philippe
- Addressed review comments
- Added new patch to rename parent field of PPC460EXPCIEState to parent_obj

Patches needing review: 6 7 10-13

BALATON Zoltan (14):
  ppc440: Change ppc460ex_pcie_init() parameter type
  ppc440: Add cpu link property to PCIe controller model
  ppc440: Add a macro to shorten PCIe controller DCR registration
  ppc440: Rename parent field of PPC460EXPCIEState to match code style
  ppc440: Rename local variable in dcr_read_pcie()
  ppc440: Stop using system io region for PCIe buses
  ppc/sam460ex: Remove address_space_mem local variable
  ppc440: Add busnum property to PCIe controller model
  ppc440: Remove ppc460ex_pcie_init legacy init function
  ppc4xx_pci: Rename QOM type name define
  ppc4xx_pci: Add define for ppc4xx-host-bridge type name
  ppc440_pcix: Rename QOM type define abd move it to common header
  ppc440_pcix: Don't use iomem for regs
  ppc440_pcix: Stop using system io region for PCI bus

 hw/ppc/ppc440.h         |   1 -
 hw/ppc/ppc440_bamboo.c  |   3 +-
 hw/ppc/ppc440_pcix.c    |  28 +++---
 hw/ppc/ppc440_uc.c      | 192 +++++++++++++++++-----------------------
 hw/ppc/ppc4xx_pci.c     |  10 +--
 hw/ppc/sam460ex.c       |  33 ++++---
 include/hw/ppc/ppc4xx.h |   5 +-
 7 files changed, 129 insertions(+), 143 deletions(-)

-- 
2.30.9


