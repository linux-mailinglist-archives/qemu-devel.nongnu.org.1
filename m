Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 343597A2DCB
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:38:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM16-00064m-BX; Fri, 15 Sep 2023 23:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM13-00063F-3w
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:41 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM11-00084S-DK
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:40 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68fb2e9ebbfso2332785b3a.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835038; x=1695439838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yHjWbAi9btcVTSvND+C/MROFnqLtNDPhov9ERvl3KYw=;
 b=hJrlHofxsOhm0WKr4ETNj/7OXBMBTNDTWs2txFnoY5ZoJRAMZx9JaWqYEGdNiw99KQ
 geUn0LvQO5ZK9HPKgyBcenND0kd/+6ukHlHnSVvBtNcce4GV/kR6eet+muiveIJLciqg
 yrkv/6GipLRCeYh8Ki6NJTLFlE1B2s6jpC2QmyAUOCczZZ24zHJz9taqTLSD0RMX0TmM
 I92I4of4wY40qTGeT//1ksEHmmLt4nCYjK9Oa+pvmPXJBCml28ySOn8bURI0Pc+mNBrz
 knlvJfJqDEjZIzZNDHrQea3X1hs//CGFwQECdLgrS/8ilGfAp7rt2pKCILZVkCjYrEgA
 bDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835038; x=1695439838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yHjWbAi9btcVTSvND+C/MROFnqLtNDPhov9ERvl3KYw=;
 b=DfGXwTBIerNoi4NgCfFskZUr55nNTsyVMxmHJCKVyNPrI3N4k1QxdxTFqhTtL1gRVI
 oQl5F0LCn1zmBFevmB4gOcclXqU6WyhOoITri1r49ddWGdOfv4zL07Wc70qf1sZjyjdP
 YDm6YB33vVyvmATBoDYuRobn5D2I08OX0Likb4+Yk+zvRdctje0Fp6chnaX/bQwebleh
 QiXUCh9UQ+PgYanaJjA3Ek/DnB7wKjILjEIQxX1iTHuBnj0WJrOF4xPoBr2aMdnOEmyS
 2l2QMPLeLHLLV3+mgvJsmhORuMcZKOpnXadXD2T3yeXgxEu26yXYiNlmI9R5djbrHoP3
 d77A==
X-Gm-Message-State: AOJu0Ywst2DtfjlDk3+naYaoCtMAao4r9+eiwx2N9tKRnUHzmOcBILvI
 TTwDObGjgpwBxjBbjCQyzvaEOMJcy2geyEvDjbM=
X-Google-Smtp-Source: AGHT+IHpnoqPFr+NFC9S2ix9a9tP8/MkYxjKwRZ0oP2tEe50QuZN08hSlGdFDukCT4dIvL5XtaX4pw==
X-Received: by 2002:a05:6a00:2d83:b0:68a:586a:f62 with SMTP id
 fb3-20020a056a002d8300b0068a586a0f62mr3679630pfb.4.1694835038048; 
 Fri, 15 Sep 2023 20:30:38 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 27/39] plugin: Simplify struct qemu_plugin_hwaddr
Date: Fri, 15 Sep 2023 20:29:59 -0700
Message-Id: <20230916033011.479144-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Rather than saving MemoryRegionSection and offset,
save phys_addr and MemoryRegion.  This matches up
much closer with the plugin api.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin-memory.h | 11 ++---------
 accel/tcg/cputlb.c           | 16 +++++++++-------
 plugins/api.c                | 27 ++++++---------------------
 3 files changed, 17 insertions(+), 37 deletions(-)

diff --git a/include/qemu/plugin-memory.h b/include/qemu/plugin-memory.h
index 43165f2452..71c1123308 100644
--- a/include/qemu/plugin-memory.h
+++ b/include/qemu/plugin-memory.h
@@ -15,15 +15,8 @@
 struct qemu_plugin_hwaddr {
     bool is_io;
     bool is_store;
-    union {
-        struct {
-            MemoryRegionSection *section;
-            hwaddr    offset;
-        } io;
-        struct {
-            void *hostaddr;
-        } ram;
-    } v;
+    hwaddr phys_addr;
+    MemoryRegion *mr;
 };
 
 /**
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index a46be6a120..fd1b07c5a3 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1724,23 +1724,25 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     MMUAccessType access_type = is_store ? MMU_DATA_STORE : MMU_DATA_LOAD;
     uint64_t tlb_addr = tlb_read_idx(tlbe, access_type);
+    CPUTLBEntryFull *full;
 
     if (unlikely(!tlb_hit(tlb_addr, addr))) {
         return false;
     }
 
+    full = &env_tlb(env)->d[mmu_idx].fulltlb[index];
+    data->phys_addr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
+
     /* We must have an iotlb entry for MMIO */
     if (tlb_addr & TLB_MMIO) {
-        CPUTLBEntryFull *full = &env_tlb(env)->d[mmu_idx].fulltlb[index];
-        hwaddr xlat = full->xlat_section;
-
+        MemoryRegionSection *section =
+            iotlb_to_section(cpu, full->xlat_section & ~TARGET_PAGE_MASK,
+                             full->attrs);
         data->is_io = true;
-        data->v.io.offset = (xlat & TARGET_PAGE_MASK) + addr;
-        data->v.io.section =
-            iotlb_to_section(cpu, xlat & ~TARGET_PAGE_MASK, full->attrs);
+        data->mr = section->mr;
     } else {
         data->is_io = false;
-        data->v.ram.hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
+        data->mr = NULL;
     }
     return true;
 }
diff --git a/plugins/api.c b/plugins/api.c
index 2078b16edb..5521b0ad36 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -316,22 +316,7 @@ uint64_t qemu_plugin_hwaddr_phys_addr(const struct qemu_plugin_hwaddr *haddr)
 {
 #ifdef CONFIG_SOFTMMU
     if (haddr) {
-        if (!haddr->is_io) {
-            RAMBlock *block;
-            ram_addr_t offset;
-            void *hostaddr = haddr->v.ram.hostaddr;
-
-            block = qemu_ram_block_from_host(hostaddr, false, &offset);
-            if (!block) {
-                error_report("Bad host ram pointer %p", haddr->v.ram.hostaddr);
-                abort();
-            }
-
-            return block->offset + offset + block->mr->addr;
-        } else {
-            MemoryRegionSection *mrs = haddr->v.io.section;
-            return mrs->offset_within_address_space + haddr->v.io.offset;
-        }
+        return haddr->phys_addr;
     }
 #endif
     return 0;
@@ -341,13 +326,13 @@ const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h)
 {
 #ifdef CONFIG_SOFTMMU
     if (h && h->is_io) {
-        MemoryRegionSection *mrs = h->v.io.section;
-        if (!mrs->mr->name) {
-            unsigned long maddr = 0xffffffff & (uintptr_t) mrs->mr;
-            g_autofree char *temp = g_strdup_printf("anon%08lx", maddr);
+        MemoryRegion *mr = h->mr;
+        if (!mr->name) {
+            unsigned maddr = (uintptr_t)mr;
+            g_autofree char *temp = g_strdup_printf("anon%08x", maddr);
             return g_intern_string(temp);
         } else {
-            return g_intern_string(mrs->mr->name);
+            return g_intern_string(mr->name);
         }
     } else {
         return g_intern_static_string("RAM");
-- 
2.34.1


