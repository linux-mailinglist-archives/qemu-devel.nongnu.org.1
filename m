Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C37FC96A825
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Sep 2024 22:18:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slZxj-0005hX-6J; Tue, 03 Sep 2024 16:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1slZxg-0005Zb-NN
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:17:12 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1slZxe-0004Rq-LT
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:17:12 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2059112f0a7so19031685ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 13:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1725394629; x=1725999429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bysn74la5UTGE5Jt6PtSVZw3zmGk2zfxbhznp1ax4MA=;
 b=IEUKQUT8GDltJNDBE5IDA5bzxdwX7N5zV6GvbjZTLJ38fcm3l7w4i7WL8ZkQJDhv6x
 6MQDJDVdubIVFurwtuJqSUxyCO5omxdYwUDsjTo0uTZM2FduHHP+GqZxlDbKRFDXnmxw
 1ZI1rzZLXgCX/0IeyEsSY0L2UOiWB0PXtUGeHiiEzdqwXI6xAUKHU1TZEY0mPX0KU8rD
 lwh/sEaiOABK+FN+SLF/LgtCmM9Do1mkP2YQYjmNwpIRZ988GxPtKnVc7WEtrUX9I05A
 4sZPnXA05AkYU0NyY33/L8aLj+mY8bOWRT6MqFMlEPOjGZ0Gss9HOH2pEcELwHSmnQju
 u/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725394629; x=1725999429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bysn74la5UTGE5Jt6PtSVZw3zmGk2zfxbhznp1ax4MA=;
 b=CpbvhLN8WjdP9pVLFMzgB3MnOn8HdVBV1jg0fuQdXKTsBKhabI54YzC4VlAl5WSZeF
 uTbkJmCfF8Sz+S7JLnaUChyjDt4ZLtunPyHS2p5txXQw9WkYtIEd5xT07a2ydtXL1Tr7
 P0t8wkqc/hGL6NM61FS/CF58Ag7bcl+85O+4j5Ln1z27Fd+fPmCXZBo3VC652Z1SKEFa
 cSpdGeR46OU3ajbDYkEcvBD3nrXMKXSOyDw5UhkUaySLlA6YBvDbQbpPpF9DJAs0yZ78
 7lxkdPuGGJhDo9u+Ssc8Si6iI1bD9ODBjwnxQ567NHa0IxVIgrTG+kQaOUX211uu01Mf
 y7QA==
X-Gm-Message-State: AOJu0Yz0oVJ+O0MyF+KxSFlb6i3oM/hOIE9YrUcYW9ZTpRyZ4Wgp848Q
 XN/cLkIL+ZidwfDQKBd4FU5+xhjpHnfofbpRv5w5I+pTgyEr4Q/RNJ1xECf3kL78JhXfi7MQ9Jj
 H
X-Google-Smtp-Source: AGHT+IEMEHCvmT4PPoGRWwK86WNERKKgdOWAABE0krhp8s+UJIYm7czYZpJ0+niIAQ0m8oxnOQyPtg==
X-Received: by 2002:a17:902:e848:b0:206:9ab3:2ec1 with SMTP id
 d9443c01a7336-2069ab336f0mr42404485ad.22.1725394628844; 
 Tue, 03 Sep 2024 13:17:08 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.170.227.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206aea531b3sm2189745ad.216.2024.09.03.13.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 13:17:08 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v7 08/12] hw/riscv/riscv-iommu: add Address Translation Cache
 (IOATC)
Date: Tue,  3 Sep 2024 17:16:27 -0300
Message-ID: <20240903201633.93182-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240903201633.93182-1-dbarboza@ventanamicro.com>
References: <20240903201633.93182-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

The RISC-V IOMMU spec predicts that the IOMMU can use translation caches
to hold entries from the DDT. This includes implementation for all cache
commands that are marked as 'not implemented'.

There are some artifacts included in the cache that predicts s-stage and
g-stage elements, although we don't support it yet. We'll introduce them
next.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 205 ++++++++++++++++++++++++++++++++++++++++-
 hw/riscv/riscv-iommu.h |   3 +
 2 files changed, 204 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 061a5efe19..fe81072b1c 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -65,6 +65,16 @@ struct RISCVIOMMUContext {
     uint64_t msiptp;            /* MSI redirection page table pointer */
 };
 
+/* Address translation cache entry */
+struct RISCVIOMMUEntry {
+    uint64_t iova:44;           /* IOVA Page Number */
+    uint64_t pscid:20;          /* Process Soft-Context identifier */
+    uint64_t phys:44;           /* Physical Page Number */
+    uint64_t gscid:16;          /* Guest Soft-Context identifier */
+    uint64_t perm:2;            /* IOMMU_RW flags */
+    uint64_t __rfu:2;
+};
+
 /* IOMMU index for transactions without process_id specified. */
 #define RISCV_IOMMU_NOPROCID 0
 
@@ -1156,13 +1166,130 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
     return &as->iova_as;
 }
 
+/* Translation Object cache support */
+static gboolean __iot_equal(gconstpointer v1, gconstpointer v2)
+{
+    RISCVIOMMUEntry *t1 = (RISCVIOMMUEntry *) v1;
+    RISCVIOMMUEntry *t2 = (RISCVIOMMUEntry *) v2;
+    return t1->gscid == t2->gscid && t1->pscid == t2->pscid &&
+           t1->iova == t2->iova;
+}
+
+static guint __iot_hash(gconstpointer v)
+{
+    RISCVIOMMUEntry *t = (RISCVIOMMUEntry *) v;
+    return (guint)t->iova;
+}
+
+/* GV: 1 PSCV: 1 AV: 1 */
+static void __iot_inval_pscid_iova(gpointer key, gpointer value, gpointer data)
+{
+    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
+    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
+    if (iot->gscid == arg->gscid &&
+        iot->pscid == arg->pscid &&
+        iot->iova == arg->iova) {
+        iot->perm = IOMMU_NONE;
+    }
+}
+
+/* GV: 1 PSCV: 1 AV: 0 */
+static void __iot_inval_pscid(gpointer key, gpointer value, gpointer data)
+{
+    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
+    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
+    if (iot->gscid == arg->gscid &&
+        iot->pscid == arg->pscid) {
+        iot->perm = IOMMU_NONE;
+    }
+}
+
+/* GV: 1 GVMA: 1 */
+static void __iot_inval_gscid_gpa(gpointer key, gpointer value, gpointer data)
+{
+    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
+    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
+    if (iot->gscid == arg->gscid) {
+        /* simplified cache, no GPA matching */
+        iot->perm = IOMMU_NONE;
+    }
+}
+
+/* GV: 1 GVMA: 0 */
+static void __iot_inval_gscid(gpointer key, gpointer value, gpointer data)
+{
+    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
+    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
+    if (iot->gscid == arg->gscid) {
+        iot->perm = IOMMU_NONE;
+    }
+}
+
+/* GV: 0 */
+static void __iot_inval_all(gpointer key, gpointer value, gpointer data)
+{
+    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
+    iot->perm = IOMMU_NONE;
+}
+
+/* caller should keep ref-count for iot_cache object */
+static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx,
+    GHashTable *iot_cache, hwaddr iova)
+{
+    RISCVIOMMUEntry key = {
+        .gscid = get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID),
+        .pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID),
+        .iova  = PPN_DOWN(iova),
+    };
+    return g_hash_table_lookup(iot_cache, &key);
+}
+
+/* caller should keep ref-count for iot_cache object */
+static void riscv_iommu_iot_update(RISCVIOMMUState *s,
+    GHashTable *iot_cache, RISCVIOMMUEntry *iot)
+{
+    if (!s->iot_limit) {
+        return;
+    }
+
+    qemu_mutex_lock(&s->iot_lock);
+    if (g_hash_table_size(s->iot_cache) >= s->iot_limit) {
+        iot_cache = g_hash_table_new_full(__iot_hash, __iot_equal,
+                                          g_free, NULL);
+        g_hash_table_unref(qatomic_xchg(&s->iot_cache, iot_cache));
+    }
+    g_hash_table_add(iot_cache, iot);
+    qemu_mutex_unlock(&s->iot_lock);
+}
+
+static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
+    uint32_t gscid, uint32_t pscid, hwaddr iova)
+{
+    GHashTable *iot_cache;
+    RISCVIOMMUEntry key = {
+        .gscid = gscid,
+        .pscid = pscid,
+        .iova  = PPN_DOWN(iova),
+    };
+
+    iot_cache = g_hash_table_ref(s->iot_cache);
+    qemu_mutex_lock(&s->iot_lock);
+    g_hash_table_foreach(iot_cache, func, &key);
+    qemu_mutex_unlock(&s->iot_lock);
+    g_hash_table_unref(iot_cache);
+}
+
 static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
-    IOMMUTLBEntry *iotlb)
+    IOMMUTLBEntry *iotlb, bool enable_cache)
 {
+    RISCVIOMMUEntry *iot;
+    IOMMUAccessFlags perm;
     bool enable_pid;
     bool enable_pri;
+    GHashTable *iot_cache;
     int fault;
 
+    iot_cache = g_hash_table_ref(s->iot_cache);
     /*
      * TC[32] is reserved for custom extensions, used here to temporarily
      * enable automatic page-request generation for ATS queries.
@@ -1170,9 +1297,45 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     enable_pri = (iotlb->perm == IOMMU_NONE) && (ctx->tc & BIT_ULL(32));
     enable_pid = (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
 
+    qemu_mutex_lock(&s->iot_lock);
+    iot = riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova);
+    qemu_mutex_unlock(&s->iot_lock);
+    perm = iot ? iot->perm : IOMMU_NONE;
+    if (perm != IOMMU_NONE) {
+        iotlb->translated_addr = PPN_PHYS(iot->phys);
+        iotlb->addr_mask = ~TARGET_PAGE_MASK;
+        iotlb->perm = perm;
+        fault = 0;
+        goto done;
+    }
+
     /* Translate using device directory / page table information. */
     fault = riscv_iommu_spa_fetch(s, ctx, iotlb);
 
+    if (!fault && iotlb->target_as == &s->trap_as) {
+        /* Do not cache trapped MSI translations */
+        goto done;
+    }
+
+    /*
+     * We made an implementation choice to not cache identity-mapped
+     * translations, as allowed by the specification, to avoid
+     * translation cache evictions for other devices sharing the
+     * IOMMU hardware model.
+     */
+    if (!fault && iotlb->translated_addr != iotlb->iova && enable_cache) {
+        iot = g_new0(RISCVIOMMUEntry, 1);
+        iot->iova = PPN_DOWN(iotlb->iova);
+        iot->phys = PPN_DOWN(iotlb->translated_addr);
+        iot->gscid = get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID);
+        iot->pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID);
+        iot->perm = iotlb->perm;
+        riscv_iommu_iot_update(s, iot_cache, iot);
+    }
+
+done:
+    g_hash_table_unref(iot_cache);
+
     if (enable_pri && fault) {
         struct riscv_iommu_pq_record pr = {0};
         if (enable_pid) {
@@ -1312,13 +1475,40 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
             if (cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV) {
                 /* illegal command arguments IOTINVAL.GVMA & PSCV == 1 */
                 goto cmd_ill;
+            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
+                /* invalidate all cache mappings */
+                func = __iot_inval_all;
+            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
+                /* invalidate cache matching GSCID */
+                func = __iot_inval_gscid;
+            } else {
+                /* invalidate cache matching GSCID and ADDR (GPA) */
+                func = __iot_inval_gscid_gpa;
             }
-            /* translation cache not implemented yet */
+            riscv_iommu_iot_inval(s, func,
+                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID), 0,
+                cmd.dword1 & TARGET_PAGE_MASK);
             break;
 
         case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA,
                              RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
-            /* translation cache not implemented yet */
+            if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
+                /* invalidate all cache mappings, simplified model */
+                func = __iot_inval_all;
+            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV)) {
+                /* invalidate cache matching GSCID, simplified model */
+                func = __iot_inval_gscid;
+            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
+                /* invalidate cache matching GSCID and PSCID */
+                func = __iot_inval_pscid;
+            } else {
+                /* invalidate cache matching GSCID and PSCID and ADDR (IOVA) */
+                func = __iot_inval_pscid_iova;
+            }
+            riscv_iommu_iot_inval(s, func,
+                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID),
+                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_PSCID),
+                cmd.dword1 & TARGET_PAGE_MASK);
             break;
 
         case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT,
@@ -1857,6 +2047,10 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
                                          g_free, NULL);
     qemu_mutex_init(&s->ctx_lock);
 
+    s->iot_cache = g_hash_table_new_full(__iot_hash, __iot_equal,
+                                         g_free, NULL);
+    qemu_mutex_init(&s->iot_lock);
+
     s->iommus.le_next = NULL;
     s->iommus.le_prev = NULL;
     QLIST_INIT(&s->spaces);
@@ -1869,6 +2063,7 @@ static void riscv_iommu_unrealize(DeviceState *dev)
     RISCVIOMMUState *s = RISCV_IOMMU(dev);
 
     qemu_mutex_destroy(&s->core_lock);
+    g_hash_table_unref(s->iot_cache);
     g_hash_table_unref(s->ctx_cache);
 }
 
@@ -1876,6 +2071,8 @@ static Property riscv_iommu_properties[] = {
     DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
         RISCV_IOMMU_SPEC_DOT_VER),
     DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
+    DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
+        LIMIT_CACHE_IOT),
     DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
     DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
     DEFINE_PROP_BOOL("s-stage", RISCVIOMMUState, enable_s_stage, TRUE),
@@ -1930,7 +2127,7 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
         /* Translation disabled or invalid. */
         iotlb.addr_mask = 0;
         iotlb.perm = IOMMU_NONE;
-    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb)) {
+    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb, true)) {
         /* Translation disabled or fault reported. */
         iotlb.addr_mask = 0;
         iotlb.perm = IOMMU_NONE;
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 95b4ce8d50..ddf5d50cf9 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -72,6 +72,9 @@ struct RISCVIOMMUState {
 
     GHashTable *ctx_cache;          /* Device translation Context Cache */
     QemuMutex ctx_lock;      /* Device translation Cache update lock */
+    GHashTable *iot_cache;          /* IO Translated Address Cache */
+    QemuMutex iot_lock;      /* IO TLB Cache update lock */
+    unsigned iot_limit;             /* IO Translation Cache size limit */
 
     /* MMIO Hardware Interface */
     MemoryRegion regs_mr;
-- 
2.45.2


