Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0819AAE86E
	for <lists+qemu-devel@lfdr.de>; Wed,  7 May 2025 20:07:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCj8e-0008FR-1x; Wed, 07 May 2025 14:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uCj8B-00089O-NK; Wed, 07 May 2025 14:04:31 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uCj89-0008Ay-Th; Wed, 07 May 2025 14:04:31 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 36AD911FEFB;
 Wed, 07 May 2025 21:04:00 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 09157206700;
 Wed,  7 May 2025 21:04:13 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 06/21] hw/acpi/ich9: Remove ICH9_DEBUG macro
Date: Wed,  7 May 2025 21:03:57 +0300
Message-Id: <20250507180412.182797-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250507180412.182797-1-mjt@tls.msk.ru>
References: <20250507180412.182797-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Remove the ICH9_DEBUG macro, which is only used to dump the value of the
pm_io_base parameter, passed to ich9_pm_iospace_update(). It provides
little to no value and is not worth converting to a trace event.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/acpi/ich9.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index c7a735bf64..9c0b7437b7 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -41,15 +41,6 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 
-//#define DEBUG
-
-#ifdef DEBUG
-#define ICH9_DEBUG(fmt, ...) \
-do { printf("%s "fmt, __func__, ## __VA_ARGS__); } while (0)
-#else
-#define ICH9_DEBUG(fmt, ...)    do { } while (0)
-#endif
-
 static void ich9_pm_update_sci_fn(ACPIREGS *regs)
 {
     ICH9LPCPMRegs *pm = container_of(regs, ICH9LPCPMRegs, acpi_regs);
@@ -135,8 +126,6 @@ static const MemoryRegionOps ich9_smi_ops = {
 
 void ich9_pm_iospace_update(ICH9LPCPMRegs *pm, uint32_t pm_io_base)
 {
-    ICH9_DEBUG("to 0x%x\n", pm_io_base);
-
     assert((pm_io_base & ICH9_PMIO_MASK) == 0);
 
     pm->pm_io_base = pm_io_base;
-- 
2.39.5


