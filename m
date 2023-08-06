Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E19B77136F
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 05:39:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSUaL-0003lD-K7; Sat, 05 Aug 2023 23:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUaI-0003jw-6L
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:38 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUaG-0007bV-IW
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:37 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-268128a0105so2263148a91.3
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 20:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691293055; x=1691897855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfYi3zP2whYYhdilrdAtUwTS+wOZ/T9TUKhhh0JmADM=;
 b=HdyPok+35A++RKX3yC0PF7hseKukkof6kahARC9kKVXK6WUkzluMycTr6fDE6K576c
 RyDl2kfcDH1jczDplg9no9tNPr3DQd+VtOZ0lTq9cY26+0XScCm9Up/jqInUx5NuFhAR
 7J7fmuh6TenmTm0ovFOXlg+GedT9ykcf5XYnPmglTX/92k8eWcvQyR1nAcOvUYEzUoE0
 9mTI2q+jZ2IxA0GYEVOvI5NzM+mPPvFqGIlfF7IBG4DRAKrTTvKd2bukUGq+dFKFPCVj
 X25jz99cXiGyvhH49eS+F7qdYXHRrP9J7W8NPAYNr1fpvOmojayb51YsgyFhPMLmPf0N
 SoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691293055; x=1691897855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfYi3zP2whYYhdilrdAtUwTS+wOZ/T9TUKhhh0JmADM=;
 b=WYV1ywJ/jRoZWX4eCP7aNPtS2lYxREECz7TZLxmjlNF2qWKVqjjyaXmI/42YDXHAy4
 UsPkvxHfCx5pAWVK0+wDsKByOFvky+X60jzX4zytAQTejTJrsdKY3zr1JHMEhNRN4Hsi
 d488dYLSirPkX1cfJU7Axhh5cfDFadnIgdFOiAoESMi+LRQ7pFOWkOZRTUdLVCszkWhM
 EdnSr3NM1/XIA4G+mnOSzGYAK0dF7pTtqZihW+ZAsSY48NdgEiANC/Sn0D9kPQqCNp5C
 /ajlzYsrFa5+wxIXgWvzAyGZhqdmaT1JwpzUmz/Q5VccWQ7UeyQfL4ELu+wYjvSLq/Zo
 bPYQ==
X-Gm-Message-State: AOJu0YzEe5l3MCBe/EeS/P/AWW7Xjv7gU2dLmR6JFKxrN/+59HC1GlNR
 c/VwlkcFqWQME3yHjmC83tgojt9pbxQDH5TE+ng=
X-Google-Smtp-Source: AGHT+IH182JTUkKRcUvMXSljjWXCUWyGprfHlN1TemklAIg9o1gErngHU56+SVYttp9MIPZeSqRj2g==
X-Received: by 2002:a17:90a:eb07:b0:267:a859:dfef with SMTP id
 j7-20020a17090aeb0700b00267a859dfefmr5281440pjz.27.1691293055326; 
 Sat, 05 Aug 2023 20:37:35 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090a740500b00262e604724dsm6306451pjg.50.2023.08.05.20.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 20:37:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Dmitriy Solovev <d.solovev@yadro.com>
Subject: [PULL 23/24] accel/tcg: Call save_iotlb_data from io_readx as well.
Date: Sat,  5 Aug 2023 20:37:14 -0700
Message-Id: <20230806033715.244648-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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


