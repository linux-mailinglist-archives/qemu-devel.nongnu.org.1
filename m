Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3812F748EB8
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 22:18:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH8sM-0002p1-3n; Wed, 05 Jul 2023 16:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qH8sB-0002gk-DE; Wed, 05 Jul 2023 16:13:12 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qH8s8-00064I-0A; Wed, 05 Jul 2023 16:13:10 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id ED10D748A60;
 Wed,  5 Jul 2023 22:12:48 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D3ACC748A5D; Wed,  5 Jul 2023 22:12:48 +0200 (CEST)
Message-Id: <6995f28215d2a489a661b7d91a1783048829d467.1688586835.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1688586835.git.balaton@eik.bme.hu>
References: <cover.1688586835.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 04/14] ppc440: Rename parent field of PPC460EXPCIEState to
 match code style
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <"danielhb413@gmail.com>, philmd"@linaro.org>
Date: Wed,  5 Jul 2023 22:12:48 +0200 (CEST)
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

QOM prefers to call the parent field parent_obj, change
PPC460EXPCIEState ro match that convention.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/ppc440_uc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index b36dc409d7..22c74839ae 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -774,7 +774,7 @@ void ppc4xx_dma_init(CPUPPCState *env, int dcr_base)
 OBJECT_DECLARE_SIMPLE_TYPE(PPC460EXPCIEState, PPC460EX_PCIE_HOST)
 
 struct PPC460EXPCIEState {
-    PCIExpressHost host;
+    PCIExpressHost parent_obj;
 
     MemoryRegion iomem;
     qemu_irq irq[4];
-- 
2.30.9


