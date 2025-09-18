Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC794B37D28
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Aug 2025 10:11:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urBEV-00015Z-G7; Wed, 27 Aug 2025 04:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1urBE6-0000cC-9E
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:09:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1urBE0-0004CP-K8
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:09:49 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxO9I8va5og7ADAA--.7207S3;
 Wed, 27 Aug 2025 16:09:32 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxXME4va5oWKVrAA--.18662S13;
 Wed, 27 Aug 2025 16:09:32 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 11/12] target/loongarch: Update matched ptw bit A/D with
 PTW supported
Date: Wed, 27 Aug 2025 16:09:26 +0800
Message-Id: <20250827080927.1644016-12-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250827080927.1644016-1-maobibo@loongson.cn>
References: <20250827080927.1644016-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxXME4va5oWKVrAA--.18662S13
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

With hardware PTE supported, bit A will be set if there is read access
or instruction fetch, and bit D will be set with write access.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu-mmu.h    | 26 ++++++++++
 target/loongarch/cpu_helper.c | 93 ++++++++++++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 4c227d4ef3..85d01e1bbe 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -61,6 +61,32 @@ static inline bool pte_write(CPULoongArchState *env, uint64_t entry)
     return !!writable;
 }
 
+/*
+ * The folloing functions should be called with PTW enable checked
+ * With hardware PTW enabled
+ *   Bit D will be set by hardware with write access
+ *   Bit A will be set by hardware with read/intruction fetch access
+ */
+static inline uint64_t pte_mkaccess(uint64_t entry)
+{
+    return FIELD_DP64(entry, TLBENTRY, V, 1);
+}
+
+static inline uint64_t pte_mkdirty(uint64_t entry)
+{
+    return FIELD_DP64(entry, TLBENTRY, D, 1);
+}
+
+static inline bool pte_access(uint64_t entry)
+{
+    return !!FIELD_EX64(entry, TLBENTRY, V);
+}
+
+static inline bool pte_dirty(uint64_t entry)
+{
+    return !!FIELD_EX64(entry, TLBENTRY, D);
+}
+
 bool check_ps(CPULoongArchState *ent, uint8_t ps);
 TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
                            MMUAccessType access_type, int mmu_idx);
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 9b035d9683..192f4ae49b 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -106,15 +106,52 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
     return TLBRET_MATCH;
 }
 
+static MemTxResult loongarch_cmpxchg_phys(CPUState *cs, hwaddr phys,
+                                          uint64_t old, uint64_t new)
+{
+    hwaddr addr1, l = 8;
+    MemoryRegion *mr;
+    uint8_t *ram_ptr;
+    uint64_t old1;
+    MemTxResult ret;
+
+    rcu_read_lock();
+    mr = address_space_translate(cs->as, phys, &addr1, &l,
+                                 false, MEMTXATTRS_UNSPECIFIED);
+    if (!memory_region_is_ram(mr)) {
+        /*
+         * Misconfigured PTE in ROM (AD bits are not preset) or
+         * PTE is in IO space and can't be updated atomically.
+         */
+         rcu_read_unlock();
+         return MEMTX_ACCESS_ERROR;
+    }
+
+    ram_ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
+    old1 = qatomic_cmpxchg((uint64_t *)ram_ptr, cpu_to_le64(old),
+                           cpu_to_le64(new));
+    old1 = le64_to_cpu(old1);
+    if (old1 == old) {
+        ret = MEMTX_OK;
+    } else {
+        ret = MEMTX_DECODE_ERROR;
+    }
+    rcu_read_unlock();
+
+    return ret;
+}
+
 TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
                      int access_type, int mmu_idx, int debug)
 {
     CPUState *cs = env_cpu(env);
     target_ulong index = 0, phys = 0;
     uint64_t dir_base, dir_width;
-    uint64_t base;
+    uint64_t base, pte;
     int level;
     vaddr address;
+    TLBRet ret;
+    MemTxResult ret1;
 
     address = context->addr;
     if ((address >> 63) & 0x1) {
@@ -148,7 +185,9 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
         }
     }
 
+restart:
     /* pte */
+    pte = base;
     if (level > 0) {
         /* Huge Page. base is pte */
         base = FIELD_DP64(base, TLBENTRY, LEVEL, 0);
@@ -170,7 +209,57 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
 
     context->ps = dir_base;
     context->pte = base;
-    return loongarch_check_pte(env, context, access_type, mmu_idx);
+    ret = loongarch_check_pte(env, context, access_type, mmu_idx);
+    if (debug) {
+        return ret;
+    }
+
+    /*
+     * Update bit A/D with hardware PTW supported
+     *
+     * Need atomic compchxg operation with pte update, other vCPUs may
+     * update pte at the same time.
+     */
+    if (ret == TLBRET_MATCH && cpu_has_ptw(env)) {
+        if (access_type == MMU_DATA_STORE && pte_dirty(base)) {
+            return ret;
+        }
+
+        if (access_type != MMU_DATA_STORE && pte_access(base)) {
+            return ret;
+        }
+
+        base = pte_mkaccess(pte);
+        if (access_type == MMU_DATA_STORE) {
+            base = pte_mkdirty(base);
+        }
+        ret1 = loongarch_cmpxchg_phys(cs, phys, pte, base);
+        /* PTE updated by other CPU, reload PTE entry */
+        if (ret1 == MEMTX_DECODE_ERROR) {
+            base = ldq_phys(cs->as, phys);
+            goto restart;
+        }
+
+        base = context->pte_buddy[index];
+        base = pte_mkaccess(base);
+        if (access_type == MMU_DATA_STORE) {
+            base = pte_mkdirty(base);
+        }
+        context->pte_buddy[index] = base;
+
+        /* Bit A/D need be updated with both Even/Odd page with huge pte */
+        if (level > 0) {
+            index = 1 - index;
+            base = context->pte_buddy[index];
+            base = pte_mkaccess(base);
+            if (access_type == MMU_DATA_STORE) {
+                base = pte_mkdirty(base);
+            }
+            context->pte_buddy[index] = base;
+        }
+    }
+
+    return ret;
 }
 
 static TLBRet loongarch_map_address(CPULoongArchState *env,
-- 
2.39.3


