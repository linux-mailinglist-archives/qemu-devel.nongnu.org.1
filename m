Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B044F7465A1
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 00:05:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGRdH-0003VI-On; Mon, 03 Jul 2023 18:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGRdF-0003Uy-Gu; Mon, 03 Jul 2023 18:02:53 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGRdD-00049K-I4; Mon, 03 Jul 2023 18:02:53 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A09AA748A4D;
 Tue,  4 Jul 2023 00:02:32 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 729D4746369; Tue,  4 Jul 2023 00:02:32 +0200 (CEST)
Message-Id: <cover.1688421085.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 00/13] PPC440 devices misc clean up
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue,  4 Jul 2023 00:02:32 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

BALATON Zoltan (13):
  ppc440: Change ppc460ex_pcie_init() parameter type
  ppc440: Add cpu link property to PCIe controller model
  ppc440: Add a macro to shorten PCIe controller DCR registration
  ppc440: Rename local variable in dcr_read_pcie()
  ppc440: Stop using system io region for PCIe buses
  sam460ex: Remove address_space_mem local variable
  ppc440: Add busnum property to PCIe controller model
  ppc440: Remove ppc460ex_pcie_init legacy init function
  ppc4xx_pci: Rename QOM type name define
  ppc4xx_pci: Add define for ppc4xx-host-bridge type name
  ppc440_pcix: Rename QOM type define abd move it to common header
  ppc440_pcix: Don't use iomem for regs
  ppc440_pcix: Stop using system io region for PCI bus

 hw/ppc/ppc440.h         |   1 -
 hw/ppc/ppc440_bamboo.c  |   3 +-
 hw/ppc/ppc440_pcix.c    |  27 +++---
 hw/ppc/ppc440_uc.c      | 190 +++++++++++++++++-----------------------
 hw/ppc/ppc4xx_pci.c     |  10 +--
 hw/ppc/sam460ex.c       |  33 ++++---
 include/hw/ppc/ppc4xx.h |   5 +-
 7 files changed, 127 insertions(+), 142 deletions(-)

-- 
2.30.9


