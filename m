Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D754676E618
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 13:00:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRW35-0006kq-Hm; Thu, 03 Aug 2023 06:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1qRW32-0006XZ-W9
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 06:59:17 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1qRW30-0002OH-5W
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 06:59:16 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 2CCBAC0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1691060350; bh=6M9XNZqC6+PwpcxI1EL+AQwcwoslHx9KXxpKEm8R1IE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=W24BtGcCL535opZvmamOPvtUxxNQwnFyOx4noWwMtRdfCtP6pPssKhx0TlSb/De95
 J3kRNMOguVW1kk+mMxHQECL+PdVL3Yg/yxu3WIoqeXHO1LAjn4iy+gsoOPsPVbB4xa
 B1I8584lBEo+/4Lp1R+SBM2p8AZM9OnSwVZRrpOEMvY5ok+oN+054bEsQyQuAP4v+Z
 idiPNHC7trqmqLaaqRq+Drmi/cBE2dfX4jPsS++R40SAhvsXU2yyRCrwO2WwQhqECI
 7SR1/FjwCcjLjm/I4ZEStUnzmY67NnCZcfcdPFm6GOnvIATzuvQUn7sGyoUb9ZVTgJ
 F0LTY4UUrTpvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1691060350; bh=6M9XNZqC6+PwpcxI1EL+AQwcwoslHx9KXxpKEm8R1IE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=RuICXRyB/rNFgRbjxV2FvtFlSurGLl0Lh5fxdz4vY0zEliGZWTsGaxuhfzZH20Vgp
 6yO19p77fTunbgwUX7yVxB4MwlXgCz5iH0m+XADUdgyuwgJvAwrC6GWHe9NAV8zjet
 3DuwQDUD32jQFZyIzkHRuZZUylZ8wZ/5aIDTMfkp6kuVB5OgmKFsHm0DXETfSD4EFb
 KTLFP5xPi79eAstFL41X9F2npda6E7E06kd9YoRWCvEKfmVEmu6zbOYiLlTD8xHixY
 iiD/QlKQn+/7wHzvpDVDPqZiGJezSvLxCA7o7ngtv/FyYFb+MUZFCQw4lU1AwtOXTC
 h82T8PfQ+TZDA==
From: Mikhail Tyutin <m.tyutin@yadro.com>
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <pbonzini@redhat.com>,
 <alex.bennee@linaro.org>, Mikhail Tyutin <m.tyutin@yadro.com>, Dmitriy
 Solovev <d.solovev@yadro.com>
Subject: [PATCH v2] Fix SEGFAULT on getting physical address of MMIO region.
Date: Thu, 3 Aug 2023 13:58:30 +0300
Message-ID: <20230803105830.8722-1-m.tyutin@yadro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
Received-SPF: pass client-ip=89.207.88.248; envelope-from=m.tyutin@yadro.com;
 helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Apply save_iotlb_data() to io_readx() as well as to io_writex().

Signed-off-by: Dmitriy Solovev <d.solovev@yadro.com>
Signed-off-by: Mikhail Tyutin <m.tyutin@yadro.com>
---
 accel/tcg/cputlb.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ba44501a7c..addce3be38 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1363,6 +1363,21 @@ static inline void cpu_transaction_failed(CPUState *cpu, hwaddr physaddr,
     }
 }
 
+/*
+ * Save a potentially trashed CPUTLBEntryFull for later lookup by plugin.
+ * This is read by tlb_plugin_lookup if the fulltlb entry doesn't match
+ * because of the side effect of io_writex changing memory layout.
+ */
+static void save_iotlb_data(CPUState *cs, MemoryRegionSection *section,
+                            hwaddr mr_offset)
+{
+#ifdef CONFIG_PLUGIN
+    SavedIOTLB *saved = &cs->saved_iotlb;
+    saved->section = section;
+    saved->mr_offset = mr_offset;
+#endif
+}
+
 static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
                          int mmu_idx, vaddr addr, uintptr_t retaddr,
                          MMUAccessType access_type, MemOp op)
@@ -1382,6 +1397,12 @@ static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
         cpu_io_recompile(cpu, retaddr);
     }
 
+    /*
+     * The memory_region_dispatch may trigger a flush/resize
+     * so for plugins we save the iotlb_data just in case.
+     */
+    save_iotlb_data(cpu, section, mr_offset);
+
     {
         QEMU_IOTHREAD_LOCK_GUARD();
         r = memory_region_dispatch_read(mr, mr_offset, &val, op, full->attrs);
@@ -1398,21 +1419,6 @@ static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
     return val;
 }
 
-/*
- * Save a potentially trashed CPUTLBEntryFull for later lookup by plugin.
- * This is read by tlb_plugin_lookup if the fulltlb entry doesn't match
- * because of the side effect of io_writex changing memory layout.
- */
-static void save_iotlb_data(CPUState *cs, MemoryRegionSection *section,
-                            hwaddr mr_offset)
-{
-#ifdef CONFIG_PLUGIN
-    SavedIOTLB *saved = &cs->saved_iotlb;
-    saved->section = section;
-    saved->mr_offset = mr_offset;
-#endif
-}
-
 static void io_writex(CPUArchState *env, CPUTLBEntryFull *full,
                       int mmu_idx, uint64_t val, vaddr addr,
                       uintptr_t retaddr, MemOp op)
-- 
2.34.1


