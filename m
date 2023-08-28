Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C88D78B7AE
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:57:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qahP7-0000pX-5R; Mon, 28 Aug 2023 14:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahP5-0000pN-UW
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:55:59 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahP3-0002Rj-KD
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:55:59 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-56a55c0f8b1so1702578a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693248956; x=1693853756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7fAz4IDlZXVLjSd/SH1PWPNAHXfaCucW3CyJSYpT2lM=;
 b=E4xlrPgE61OLpG+Lg2pYYPFU10HAxkOaVX5Qhs+/nyHFH20ZK74yUdx6Jv+GLDg9NI
 2coQT4DL2VRySF6Og5j2of+lFXce+Y1DwP9299VXmTdfmVkGkdTb8dLiaAm+g286db3K
 H/etax29NYtIkQFLcxNEqISPLMFcyHdwWo24x7q7mn5Zsm93D+xX04pQ+ZBAAAARwWb3
 LmhTLFJ8PnlTdIxTw4mx0SHxOfE9U3AYhdzkL11hROr6IfirNK/rUVZWwiiJ9hkVj8hO
 b7u004dRc2Pw1K3y/H14NFDsSrZHGpBd6mADd9A3DEHhFJvef0z46hhDJoqtksUxQb7o
 LfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693248956; x=1693853756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7fAz4IDlZXVLjSd/SH1PWPNAHXfaCucW3CyJSYpT2lM=;
 b=QfAO/P1M1ctzgJJLLBrPYsqASkZnmyDhBOEVhe2DBol/tJdjJM+KaMSg/K8HQ21E3X
 xKl4VXWAFujh239CiXnou1K4vaHOueWYmOV2I6D/FPR2Ts1+j2W9crMkIpwjyot1RLBu
 Bi3jz3LAnRUdDqSFbnVwQcpGFTuBWPCEauJSfFcEBqQEYqqUolUYkfkqHfVQGuvCjYbm
 mIZQ7Om0i0LSDw+9hOegL6aSArCoLvRHevEKIb85iKaZE6LxwmC2FgOw/UEtkkLX4tHb
 ji07glYO1XVY5LDqL2dZmc6oqjraVUNoDktShpkYbvFmtmO/WWlzIpv0tXokOrGXXRuM
 n1Rg==
X-Gm-Message-State: AOJu0YxlKU4x68pOh8Xz10weYsvGBGZG/q7YXYMiIrodc/VTGYoIl7q0
 CtOfbxc2AP34X6fz+2ZjhuRFcZljS8Q+U/mT+wg=
X-Google-Smtp-Source: AGHT+IFCCgJ7k9yXS2Cyije0XaKUwDCwTOzbJ1U3n/3wWPJXpyQvtJqsb4xQ/3yv7hPkKv2HL/gJ0g==
X-Received: by 2002:a17:90a:db08:b0:26b:3f10:820f with SMTP id
 g8-20020a17090adb0800b0026b3f10820fmr19825065pjv.36.1693248956126; 
 Mon, 28 Aug 2023 11:55:56 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 4-20020a17090a190400b002680dfd368dsm7932835pjg.51.2023.08.28.11.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 11:55:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 04/10] plugin: Simplify struct qemu_plugin_hwaddr
Date: Mon, 28 Aug 2023 11:55:44 -0700
Message-Id: <20230828185550.573653-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828185550.573653-1-richard.henderson@linaro.org>
References: <20230828185550.573653-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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
index fd6c956214..b1dc213675 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1721,23 +1721,25 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
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


