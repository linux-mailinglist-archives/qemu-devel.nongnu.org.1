Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F130990851
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Oct 2024 18:00:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swkgy-0007SL-Pk; Fri, 04 Oct 2024 11:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1swkgq-0007Oz-Lo
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 11:58:00 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1swkgn-0000rP-VR
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 11:58:00 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20b0b5cdb57so24848985ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 08:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1728057476; x=1728662276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7P/vkTeYr6HUnOpNznXnJLMsi4cdSGYBwLw5gEMJ3I=;
 b=Zg3U9w/3iEnbmbE714Gx2phMlEQdm8Y1uu3fpa/GwQOliatbSSngkXTa1UykksyEOb
 3DiRBrTOTP8vt8jnoAHe5lVmke8bIa0l38uST/VBdKmjbqgGKaHKtHHflf88wOBkqXkh
 XGJ/jSkVq2KHfmrSgwB/b4bKODfSAJOWtfnBIITWXaPxc01+yN7zAT06b4G1WoDCjGuJ
 TKVZI2eoyFkhKigN8gR+5cPAj+xyzA2wPRW/EIneKGYi38/Uwu3lyC3wE39N4TduoVQT
 NtV4doyBKIT+l+yrt2jSZs17cBC/S4s5yTOAYRnH161UnNzJgVTAnHUyH0+vqWV4yvLg
 6EeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728057476; x=1728662276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7P/vkTeYr6HUnOpNznXnJLMsi4cdSGYBwLw5gEMJ3I=;
 b=dRIM22w4tZ4R05W6LhbP/UpYUfoOH2ReEePlglzriO1IzEDx0+mCLSkK0dvWZg8IGE
 QATtjGLMQqQmzYY0qHW3DET/UufAVGFXGk2UP/tFLeQqzfTUVgC1uyw06E6M3DvrGhUK
 VZP26hGdse52HqX+T44Cm5idciF1xBkY7174wZmkZANjG61cfzBk/CnVH5HQq3GsfT1a
 MwMZEBDI367YiAI8y2Xsh9hXQkGU2cjYKnDZy1toL27iFrtI8LE77eaQNc+bn4W78Bho
 LufBwyTg8VZ522zpsxgeXAFh8ftpeO4nUzA7wSWmCjL+8WDdk4XyY1gUfIZdmlEM0vV5
 K8CA==
X-Gm-Message-State: AOJu0YwtNVBmYNELg+9+2rSkLMkeZ6qfeqSt45A+7PPkpUNtNYcaRhul
 sKk2qq3ubRhMXzbMUS8BUmfs1/rxwwgrI0UMNYrrlia6pLY9gsIUqcntyRJ9FqbllhJW772GB7w
 V
X-Google-Smtp-Source: AGHT+IHEefu48e3B3xHtY25rzbPhabWpC8rj5dscH0qq3ZLxbIBkKH8izYonZvqm9LPiGN0WBgESEQ==
X-Received: by 2002:a17:903:22c4:b0:20b:46c6:3e47 with SMTP id
 d9443c01a7336-20be19a0972mr112825055ad.29.1728057476202; 
 Fri, 04 Oct 2024 08:57:56 -0700 (PDT)
Received: from grind.. (200-206-229-93.dsl.telesp.net.br. [200.206.229.93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c139306cfsm107635ad.170.2024.10.04.08.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 08:57:55 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v9 08/12] hw/riscv/riscv-iommu: add Address Translation Cache
 (IOATC)
Date: Fri,  4 Oct 2024 12:57:15 -0300
Message-ID: <20241004155721.2154626-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004155721.2154626-1-dbarboza@ventanamicro.com>
References: <20241004155721.2154626-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/riscv/riscv-iommu.c | 204 ++++++++++++++++++++++++++++++++++++++++-
 hw/riscv/riscv-iommu.h |   3 +
 2 files changed, 203 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index f2679f3740..cef54b56ba 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -64,6 +64,15 @@ struct RISCVIOMMUContext {
     uint64_t msiptp;            /* MSI redirection page table pointer */
 };
 
+/* Address translation cache entry */
+struct RISCVIOMMUEntry {
+    uint64_t iova:44;           /* IOVA Page Number */
+    uint64_t pscid:20;          /* Process Soft-Context identifier */
+    uint64_t phys:44;           /* Physical Page Number */
+    uint64_t gscid:16;          /* Guest Soft-Context identifier */
+    uint64_t perm:2;            /* IOMMU_RW flags */
+};
+
 /* IOMMU index for transactions without process_id specified. */
 #define RISCV_IOMMU_NOPROCID 0
 
@@ -1154,13 +1163,132 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
     return &as->iova_as;
 }
 
+/* Translation Object cache support */
+static gboolean riscv_iommu_iot_equal(gconstpointer v1, gconstpointer v2)
+{
+    RISCVIOMMUEntry *t1 = (RISCVIOMMUEntry *) v1;
+    RISCVIOMMUEntry *t2 = (RISCVIOMMUEntry *) v2;
+    return t1->gscid == t2->gscid && t1->pscid == t2->pscid &&
+           t1->iova == t2->iova;
+}
+
+static guint riscv_iommu_iot_hash(gconstpointer v)
+{
+    RISCVIOMMUEntry *t = (RISCVIOMMUEntry *) v;
+    return (guint)t->iova;
+}
+
+/* GV: 1 PSCV: 1 AV: 1 */
+static void riscv_iommu_iot_inval_pscid_iova(gpointer key, gpointer value,
+                                             gpointer data)
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
+static void riscv_iommu_iot_inval_pscid(gpointer key, gpointer value,
+                                        gpointer data)
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
+static void riscv_iommu_iot_inval_gscid_gpa(gpointer key, gpointer value,
+                                            gpointer data)
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
+static void riscv_iommu_iot_inval_gscid(gpointer key, gpointer value,
+                                        gpointer data)
+{
+    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
+    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
+    if (iot->gscid == arg->gscid) {
+        iot->perm = IOMMU_NONE;
+    }
+}
+
+/* GV: 0 */
+static void riscv_iommu_iot_inval_all(gpointer key, gpointer value,
+                                      gpointer data)
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
+    if (g_hash_table_size(s->iot_cache) >= s->iot_limit) {
+        iot_cache = g_hash_table_new_full(riscv_iommu_iot_hash,
+                                          riscv_iommu_iot_equal,
+                                          g_free, NULL);
+        g_hash_table_unref(qatomic_xchg(&s->iot_cache, iot_cache));
+    }
+    g_hash_table_add(iot_cache, iot);
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
+    g_hash_table_foreach(iot_cache, func, &key);
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
@@ -1168,9 +1296,43 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     enable_pri = (iotlb->perm == IOMMU_NONE) && (ctx->tc & BIT_ULL(32));
     enable_pid = (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
 
+    iot = riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova);
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
@@ -1310,13 +1472,40 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
             if (cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV) {
                 /* illegal command arguments IOTINVAL.GVMA & PSCV == 1 */
                 goto cmd_ill;
+            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
+                /* invalidate all cache mappings */
+                func = riscv_iommu_iot_inval_all;
+            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
+                /* invalidate cache matching GSCID */
+                func = riscv_iommu_iot_inval_gscid;
+            } else {
+                /* invalidate cache matching GSCID and ADDR (GPA) */
+                func = riscv_iommu_iot_inval_gscid_gpa;
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
+                func = riscv_iommu_iot_inval_all;
+            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV)) {
+                /* invalidate cache matching GSCID, simplified model */
+                func = riscv_iommu_iot_inval_gscid;
+            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
+                /* invalidate cache matching GSCID and PSCID */
+                func = riscv_iommu_iot_inval_pscid;
+            } else {
+                /* invalidate cache matching GSCID and PSCID and ADDR (IOVA) */
+                func = riscv_iommu_iot_inval_pscid_iova;
+            }
+            riscv_iommu_iot_inval(s, func,
+                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID),
+                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_PSCID),
+                cmd.dword1 & TARGET_PAGE_MASK);
             break;
 
         case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT,
@@ -1831,6 +2020,10 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
                                          riscv_iommu_ctx_equal,
                                          g_free, NULL);
 
+    s->iot_cache = g_hash_table_new_full(riscv_iommu_iot_hash,
+                                         riscv_iommu_iot_equal,
+                                         g_free, NULL);
+
     s->iommus.le_next = NULL;
     s->iommus.le_prev = NULL;
     QLIST_INIT(&s->spaces);
@@ -1840,6 +2033,7 @@ static void riscv_iommu_unrealize(DeviceState *dev)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(dev);
 
+    g_hash_table_unref(s->iot_cache);
     g_hash_table_unref(s->ctx_cache);
 }
 
@@ -1847,6 +2041,8 @@ static Property riscv_iommu_properties[] = {
     DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
         RISCV_IOMMU_SPEC_DOT_VER),
     DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
+    DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
+        LIMIT_CACHE_IOT),
     DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
     DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
     DEFINE_PROP_BOOL("s-stage", RISCVIOMMUState, enable_s_stage, TRUE),
@@ -1901,7 +2097,7 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
         /* Translation disabled or invalid. */
         iotlb.addr_mask = 0;
         iotlb.perm = IOMMU_NONE;
-    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb)) {
+    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb, true)) {
         /* Translation disabled or fault reported. */
         iotlb.addr_mask = 0;
         iotlb.perm = IOMMU_NONE;
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index af3fcafc19..9f15f3b27f 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -69,6 +69,9 @@ struct RISCVIOMMUState {
 
     GHashTable *ctx_cache;          /* Device translation Context Cache */
 
+    GHashTable *iot_cache;          /* IO Translated Address Cache */
+    unsigned iot_limit;             /* IO Translation Cache size limit */
+
     /* MMIO Hardware Interface */
     MemoryRegion regs_mr;
     uint8_t *regs_rw;  /* register state (user write) */
-- 
2.45.2


