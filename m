Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81395770BA7
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:03:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2rN-00050m-HJ; Fri, 04 Aug 2023 18:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qv-0004mb-A6
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:57 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qs-0001vy-IB
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:55 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bbd2761f1bso22050295ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186453; x=1691791253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfYi3zP2whYYhdilrdAtUwTS+wOZ/T9TUKhhh0JmADM=;
 b=yrIm1u+shFtPbvtO7Z8qFba5AnaVPrhLqDDO8MuFiRiP1N4ytR2QTouJSYsEvGZbAU
 2kzJR7kBvcNYzzikQ7rYDE0B8NPBSLmnJ96zGNqs60MvRmAG90G/Rd/CRjXQEGGMY3UU
 ybQ+RqTFCsqZALGq2mJMLMLRrW+9z2YxsrEP+248gVamGBda7BYVPUGi6LIZ2ir9Ca8p
 7nqaoMbL2TXo95/td/IjVkJpaXAbhNTfiA/6rpPf9KOJo+cUHW/f2pYx84NSZNZHkxTM
 0NwSF8tnD+GiysZjSD1TSMmWsx8y8oT75mg6vlNseQ+BkzOigzRq/fh8LQozJwDMjnUq
 Y2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186453; x=1691791253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfYi3zP2whYYhdilrdAtUwTS+wOZ/T9TUKhhh0JmADM=;
 b=HQrRIWsyoWbFeJX2VF0wi5WpGDjI11wy5JnAh4fqTDwgdAD5gdECIuXSzfUUbHU52J
 CraNW+94pCj71Qp3NiEztTUUT47UH5sEmf5yixKJL+UqeMoYYnZUdCAN0tNjPhKmD2DN
 6OUiRW8/1SrR1FGwfaZ7XhKFPHE33ZcYY2arnw7oskxYlgCv93HPev+mEwXhhF6E17zg
 WmEas8tTf1smW/8W1NbzheBUBsBrYEN6ojG8lCzGAf0MoEej22f1OS/wrftJnE3UZ87O
 DDrFvkC2PdNITm3+cvbQl+IaBixQ9JgjKSkwQotC1xBb2pL8SvMb3bJf+xNEfTYjGm6/
 LSvQ==
X-Gm-Message-State: AOJu0YwG81DvE+QUTg5IXAdTCSx7hmJYE1xHWcpBWcFhtE5TGUGe/NCQ
 EgDS6U8g5ljBDUnrH5oLI1xACd2JZ/N3vKlue9I=
X-Google-Smtp-Source: AGHT+IGMooYLZtoFe1uhKLnWrJiGfCTE4/tLyAykw/BYiAo6bJWGYl00tEA3LdKy7Lt9edl4mjAFPQ==
X-Received: by 2002:a17:902:e804:b0:1b9:e091:8037 with SMTP id
 u4-20020a170902e80400b001b9e0918037mr3727329plg.30.1691186453371; 
 Fri, 04 Aug 2023 15:00:53 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Dmitriy Solovev <d.solovev@yadro.com>
Subject: [PATCH v9 23/24] accel/tcg: Call save_iotlb_data from io_readx as
 well.
Date: Fri,  4 Aug 2023 15:00:31 -0700
Message-Id: <20230804220032.295411-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Mikhail Tyutin <m.tyutin@yadro.com>

Apply save_iotlb_data() to io_readx() as well as to io_writex().
This fixes SEGFAULT on qemu_plugin_hwaddr_phys_addr() call plugins
for addresses inside of MMIO region.

Signed-off-by: Dmitriy Solovev <d.solovev@yadro.com>
Signed-off-by: Mikhail Tyutin <m.tyutin@yadro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230804110903.19968-1-m.tyutin@yadro.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 4b1bfaa53d..d68fa6867c 100644
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


