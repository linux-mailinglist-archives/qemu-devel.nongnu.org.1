Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 496AD749A6D
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 13:18:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHMz1-0004VL-4X; Thu, 06 Jul 2023 07:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qHMyr-0004T7-Nw; Thu, 06 Jul 2023 07:17:03 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qHMyq-0007fN-6j; Thu, 06 Jul 2023 07:17:01 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 98BD7746369;
 Thu,  6 Jul 2023 13:16:41 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6C21474632B; Thu,  6 Jul 2023 13:16:41 +0200 (CEST)
Message-Id: <cover.1688641673.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [RESEND PATCH v3 0/4] PPC440 devices misc clean up
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
    philmd@linaro.org
Date: Thu,  6 Jul 2023 13:16:41 +0200 (CEST)
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

v3:
- rebased on ppc-next moving already reviewed patch to front

v2:
- Added R-b tags from Philippe
- Addressed review comments
- Added new patch to rename parent field of PPC460EXPCIEState to parent_obj

BALATON Zoltan (4):
  ppc440_pcix: Stop using system io region for PCI bus
  ppc4xx_pci: Rename QOM type name define
  ppc4xx_pci: Add define for ppc4xx-host-bridge type name
  ppc440_pcix: Rename QOM type define abd move it to common header

 hw/ppc/ppc440_bamboo.c  |  3 +--
 hw/ppc/ppc440_pcix.c    | 21 ++++++++++++---------
 hw/ppc/ppc4xx_pci.c     | 10 +++++-----
 hw/ppc/sam460ex.c       |  8 ++------
 include/hw/ppc/ppc4xx.h |  4 +++-
 5 files changed, 23 insertions(+), 23 deletions(-)

-- 
2.30.9


