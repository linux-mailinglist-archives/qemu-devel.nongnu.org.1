Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0110A8CD94F
	for <lists+qemu-devel@lfdr.de>; Thu, 23 May 2024 19:43:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sACRc-00019p-W8; Thu, 23 May 2024 13:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sACQx-0000jY-Ig
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:41:02 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sACQo-0001bN-8Y
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:40:48 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ee12baa01cso22246105ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 10:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716486042; x=1717090842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ya8boQxG/QpEUzX5SWUsbg2wmczWk4GGkx84Sgujws=;
 b=U9r7oO7/nNFlw9dr+dJ49nYbbukfIRXjAtVaB8SKbRo7hcQzoxk7jen5CFr/lBzK0Y
 7AiYVuUPe3hxcp+ds7vMwP3ylcbqAG8Ilqtj58c4o4FJiGXLNcbfXXdNbKtMHsjsmgII
 gA97C+PVwLzOXxRrfWU7hNyPLzyo+YE4qx+YlV2fThinF2xPdpzkN4rv45nvW9922lrY
 yhgA7spM9r1mJtxgpErtOBn834Ulgkw52z+TEXfhSCWyetrO1ZWtvOJwqXkjIU/lx6+Q
 G665dt8ImOujmWmTVD1c2bzMaoyc/coOTsBgeolw13Ih3ZyS6YtBtLknek5Y3ByaedV/
 tNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716486042; x=1717090842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ya8boQxG/QpEUzX5SWUsbg2wmczWk4GGkx84Sgujws=;
 b=RsuKXjkb+8Ud5M9a1Yon9AMNHJ18S5VbhH6uWHsiRF0WVCKVLxfQCsaSZj0UMYVdWL
 EDXQTLzG4dFyRwkF1eCwY+HAVYwS9vKhpG5wlAHD4LgPxQNja+CaSzx2/WtZo3LBoTAh
 T0UoPCOClV2E86R5QDp3X165Lby7+kSKC9wO3jjPZCPFN4pPfsg9GFpFDDu7FNaebYXy
 ZDoo2i6ESHArrgpBja2r3aQvLZDlsY2LB9cEXog+1fVrg1ToOcZmn7f3ZrVtVHesg1Ul
 MpCLrwbustF6F3+CQAe6vgbkiiCSu7Iu7HAYEj+IM1TfHeve8jd9iLQJyb40D/RWnY8b
 Al0Q==
X-Gm-Message-State: AOJu0Yzi7qHlx9GQg8TP1zIWhLuW4sOKnqfsujsDazUgiXkXTzajDJ49
 wIOcQABoNU32jM1SYF1zEoA0hSHjBESAxOuUKneop3K1CXyw+T+MbUOFzkX77fkcNY9Ksz1tGQq
 m
X-Google-Smtp-Source: AGHT+IGuXOnesGtcwg8pr7Nf2eST7ggpGNC9O8HlXj0KvxASTeI+gidanOtXr6sd+jtWU3h1K6/eZg==
X-Received: by 2002:a17:902:cec3:b0:1eb:3daf:ebaf with SMTP id
 d9443c01a7336-1f4497e08femr127485ad.57.1716486042066; 
 Thu, 23 May 2024 10:40:42 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.42.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f2fb4ca0ebsm81246535ad.119.2024.05.23.10.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 10:40:41 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 tjeznach@rivosinc.com, ajones@ventanamicro.com, frank.chang@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 09/13] hw/riscv/riscv-iommu: add s-stage and g-stage support
Date: Thu, 23 May 2024 14:39:50 -0300
Message-ID: <20240523173955.1940072-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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

Add support for s-stage (sv32, sv39, sv48, sv57 caps) and g-stage
(sv32x4, sv39x4, sv48x4, sv57x4 caps). Most of the work is done in the
riscv_iommu_spa_fetch() function that now has to consider how many
translation stages we need to walk the page table.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/riscv-iommu-bits.h |  11 ++
 hw/riscv/riscv-iommu.c      | 331 +++++++++++++++++++++++++++++++++++-
 hw/riscv/riscv-iommu.h      |   2 +
 3 files changed, 336 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index f29b916acb..a4def7b8ec 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -71,6 +71,14 @@ struct riscv_iommu_pq_record {
 /* 5.3 IOMMU Capabilities (64bits) */
 #define RISCV_IOMMU_REG_CAP             0x0000
 #define RISCV_IOMMU_CAP_VERSION         GENMASK_ULL(7, 0)
+#define RISCV_IOMMU_CAP_SV32            BIT_ULL(8)
+#define RISCV_IOMMU_CAP_SV39            BIT_ULL(9)
+#define RISCV_IOMMU_CAP_SV48            BIT_ULL(10)
+#define RISCV_IOMMU_CAP_SV57            BIT_ULL(11)
+#define RISCV_IOMMU_CAP_SV32X4          BIT_ULL(16)
+#define RISCV_IOMMU_CAP_SV39X4          BIT_ULL(17)
+#define RISCV_IOMMU_CAP_SV48X4          BIT_ULL(18)
+#define RISCV_IOMMU_CAP_SV57X4          BIT_ULL(19)
 #define RISCV_IOMMU_CAP_MSI_FLAT        BIT_ULL(22)
 #define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
 #define RISCV_IOMMU_CAP_T2GPA           BIT_ULL(26)
@@ -83,6 +91,7 @@ struct riscv_iommu_pq_record {
 /* 5.4 Features control register (32bits) */
 #define RISCV_IOMMU_REG_FCTL            0x0008
 #define RISCV_IOMMU_FCTL_WSI            BIT(1)
+#define RISCV_IOMMU_FCTL_GXL            BIT(2)
 
 /* 5.5 Device-directory-table pointer (64bits) */
 #define RISCV_IOMMU_REG_DDTP            0x0010
@@ -205,6 +214,8 @@ struct riscv_iommu_dc {
 #define RISCV_IOMMU_DC_TC_DTF           BIT_ULL(4)
 #define RISCV_IOMMU_DC_TC_PDTV          BIT_ULL(5)
 #define RISCV_IOMMU_DC_TC_PRPR          BIT_ULL(6)
+#define RISCV_IOMMU_DC_TC_GADE          BIT_ULL(7)
+#define RISCV_IOMMU_DC_TC_SADE          BIT_ULL(8)
 #define RISCV_IOMMU_DC_TC_DPE           BIT_ULL(9)
 #define RISCV_IOMMU_DC_TC_SBE           BIT_ULL(10)
 #define RISCV_IOMMU_DC_TC_SXL           BIT_ULL(11)
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index abf6ae7726..11c418b548 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -58,6 +58,8 @@ struct RISCVIOMMUContext {
     uint64_t __rfu:20;          /* reserved */
     uint64_t tc;                /* Translation Control */
     uint64_t ta;                /* Translation Attributes */
+    uint64_t satp;              /* S-Stage address translation and protection */
+    uint64_t gatp;              /* G-Stage address translation and protection */
     uint64_t msi_addr_mask;     /* MSI filtering - address mask */
     uint64_t msi_addr_pattern;  /* MSI filtering - address pattern */
     uint64_t msiptp;            /* MSI redirection page table pointer */
@@ -201,12 +203,45 @@ static bool riscv_iommu_msi_check(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     return true;
 }
 
-/* RISCV IOMMU Address Translation Lookup - Page Table Walk */
+/*
+ * RISCV IOMMU Address Translation Lookup - Page Table Walk
+ *
+ * Note: Code is based on get_physical_address() from target/riscv/cpu_helper.c
+ * Both implementation can be merged into single helper function in future.
+ * Keeping them separate for now, as error reporting and flow specifics are
+ * sufficiently different for separate implementation.
+ *
+ * @s        : IOMMU Device State
+ * @ctx      : Translation context for device id and process address space id.
+ * @iotlb    : translation data: physical address and access mode.
+ * @return   : success or fault cause code.
+ */
 static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     IOMMUTLBEntry *iotlb)
 {
+    dma_addr_t addr, base;
+    uint64_t satp, gatp, pte;
+    bool en_s, en_g;
+    struct {
+        unsigned char step;
+        unsigned char levels;
+        unsigned char ptidxbits;
+        unsigned char ptesize;
+    } sc[2];
+    /* Translation stage phase */
+    enum {
+        S_STAGE = 0,
+        G_STAGE = 1,
+    } pass;
+
+    satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
+    gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
+
+    en_s = satp != RISCV_IOMMU_DC_FSC_MODE_BARE;
+    en_g = gatp != RISCV_IOMMU_DC_IOHGATP_MODE_BARE;
+
     /* Early check for MSI address match when IOVA == GPA */
-    if (iotlb->perm & IOMMU_WO &&
+    if ((iotlb->perm & IOMMU_WO) &&
         riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
         iotlb->target_as = &s->trap_as;
         iotlb->translated_addr = iotlb->iova;
@@ -215,11 +250,196 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     }
 
     /* Exit early for pass-through mode. */
-    iotlb->translated_addr = iotlb->iova;
-    iotlb->addr_mask = ~TARGET_PAGE_MASK;
-    /* Allow R/W in pass-through mode */
-    iotlb->perm = IOMMU_RW;
-    return 0;
+    if (!(en_s || en_g)) {
+        iotlb->translated_addr = iotlb->iova;
+        iotlb->addr_mask = ~TARGET_PAGE_MASK;
+        /* Allow R/W in pass-through mode */
+        iotlb->perm = IOMMU_RW;
+        return 0;
+    }
+
+    /* S/G translation parameters. */
+    for (pass = 0; pass < 2; pass++) {
+        uint32_t sv_mode;
+
+        sc[pass].step = 0;
+        if (pass ? (s->fctl & RISCV_IOMMU_FCTL_GXL) :
+            (ctx->tc & RISCV_IOMMU_DC_TC_SXL)) {
+            /* 32bit mode for GXL/SXL == 1 */
+            switch (pass ? gatp : satp) {
+            case RISCV_IOMMU_DC_IOHGATP_MODE_BARE:
+                sc[pass].levels    = 0;
+                sc[pass].ptidxbits = 0;
+                sc[pass].ptesize   = 0;
+                break;
+            case RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4:
+                sv_mode = pass ? RISCV_IOMMU_CAP_SV32X4 : RISCV_IOMMU_CAP_SV32;
+                if (!(s->cap & sv_mode)) {
+                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
+                }
+                sc[pass].levels    = 2;
+                sc[pass].ptidxbits = 10;
+                sc[pass].ptesize   = 4;
+                break;
+            default:
+                return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
+            }
+        } else {
+            /* 64bit mode for GXL/SXL == 0 */
+            switch (pass ? gatp : satp) {
+            case RISCV_IOMMU_DC_IOHGATP_MODE_BARE:
+                sc[pass].levels    = 0;
+                sc[pass].ptidxbits = 0;
+                sc[pass].ptesize   = 0;
+                break;
+            case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
+                sv_mode = pass ? RISCV_IOMMU_CAP_SV39X4 : RISCV_IOMMU_CAP_SV39;
+                if (!(s->cap & sv_mode)) {
+                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
+                }
+                sc[pass].levels    = 3;
+                sc[pass].ptidxbits = 9;
+                sc[pass].ptesize   = 8;
+                break;
+            case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
+                sv_mode = pass ? RISCV_IOMMU_CAP_SV48X4 : RISCV_IOMMU_CAP_SV48;
+                if (!(s->cap & sv_mode)) {
+                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
+                }
+                sc[pass].levels    = 4;
+                sc[pass].ptidxbits = 9;
+                sc[pass].ptesize   = 8;
+                break;
+            case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
+                sv_mode = pass ? RISCV_IOMMU_CAP_SV57X4 : RISCV_IOMMU_CAP_SV57;
+                if (!(s->cap & sv_mode)) {
+                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
+                }
+                sc[pass].levels    = 5;
+                sc[pass].ptidxbits = 9;
+                sc[pass].ptesize   = 8;
+                break;
+            default:
+                return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
+            }
+        }
+    };
+
+    /* S/G stages translation tables root pointers */
+    gatp = PPN_PHYS(get_field(ctx->gatp, RISCV_IOMMU_ATP_PPN_FIELD));
+    satp = PPN_PHYS(get_field(ctx->satp, RISCV_IOMMU_ATP_PPN_FIELD));
+    addr = (en_s && en_g) ? satp : iotlb->iova;
+    base = en_g ? gatp : satp;
+    pass = en_g ? G_STAGE : S_STAGE;
+
+    do {
+        const unsigned widened = (pass && !sc[pass].step) ? 2 : 0;
+        const unsigned va_bits = widened + sc[pass].ptidxbits;
+        const unsigned va_skip = TARGET_PAGE_BITS + sc[pass].ptidxbits *
+                                 (sc[pass].levels - 1 - sc[pass].step);
+        const unsigned idx = (addr >> va_skip) & ((1 << va_bits) - 1);
+        const dma_addr_t pte_addr = base + idx * sc[pass].ptesize;
+        const bool ade =
+            ctx->tc & (pass ? RISCV_IOMMU_DC_TC_GADE : RISCV_IOMMU_DC_TC_SADE);
+
+        /* Address range check before first level lookup */
+        if (!sc[pass].step) {
+            const uint64_t va_mask = (1ULL << (va_skip + va_bits)) - 1;
+            if ((addr & va_mask) != addr) {
+                return RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED;
+            }
+        }
+
+        /* Read page table entry */
+        if (dma_memory_read(s->target_as, pte_addr, &pte,
+                sc[pass].ptesize, MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
+            return (iotlb->perm & IOMMU_WO) ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT
+                                            : RISCV_IOMMU_FQ_CAUSE_RD_FAULT;
+        }
+
+        if (sc[pass].ptesize == 4) {
+            pte = (uint64_t) le32_to_cpu(*((uint32_t *)&pte));
+        } else {
+            pte = le64_to_cpu(pte);
+        }
+
+        sc[pass].step++;
+        hwaddr ppn = pte >> PTE_PPN_SHIFT;
+
+        if (!(pte & PTE_V)) {
+            break;                /* Invalid PTE */
+        } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
+            base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
+        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
+            break;                /* Reserved leaf PTE flags: PTE_W */
+        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == (PTE_W | PTE_X)) {
+            break;                /* Reserved leaf PTE flags: PTE_W + PTE_X */
+        } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) {
+            break;                /* Misaligned PPN */
+        } else if ((iotlb->perm & IOMMU_RO) && !(pte & PTE_R)) {
+            break;                /* Read access check failed */
+        } else if ((iotlb->perm & IOMMU_WO) && !(pte & PTE_W)) {
+            break;                /* Write access check failed */
+        } else if ((iotlb->perm & IOMMU_RO) && !ade && !(pte & PTE_A)) {
+            break;                /* Access bit not set */
+        } else if ((iotlb->perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
+            break;                /* Dirty bit not set */
+        } else {
+            /* Leaf PTE, translation completed. */
+            sc[pass].step = sc[pass].levels;
+            base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
+            /* Update address mask based on smallest translation granularity */
+            iotlb->addr_mask &= (1ULL << va_skip) - 1;
+            /* Continue with S-Stage translation? */
+            if (pass && sc[0].step != sc[0].levels) {
+                pass = S_STAGE;
+                addr = iotlb->iova;
+                continue;
+            }
+            /* Translation phase completed (GPA or SPA) */
+            iotlb->translated_addr = base;
+            iotlb->perm = (pte & PTE_W) ? ((pte & PTE_R) ? IOMMU_RW : IOMMU_WO)
+                                                         : IOMMU_RO;
+
+            /* Check MSI GPA address match */
+            if (pass == S_STAGE && (iotlb->perm & IOMMU_WO) &&
+                riscv_iommu_msi_check(s, ctx, base)) {
+                /* Trap MSI writes and return GPA address. */
+                iotlb->target_as = &s->trap_as;
+                iotlb->addr_mask = ~TARGET_PAGE_MASK;
+                return 0;
+            }
+
+            /* Continue with G-Stage translation? */
+            if (!pass && en_g) {
+                pass = G_STAGE;
+                addr = base;
+                base = gatp;
+                sc[pass].step = 0;
+                continue;
+            }
+
+            return 0;
+        }
+
+        if (sc[pass].step == sc[pass].levels) {
+            break; /* Can't find leaf PTE */
+        }
+
+        /* Continue with G-Stage translation? */
+        if (!pass && en_g) {
+            pass = G_STAGE;
+            addr = base;
+            base = gatp;
+            sc[pass].step = 0;
+        }
+    } while (1);
+
+    return (iotlb->perm & IOMMU_WO) ?
+                (pass ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
+                        RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S) :
+                (pass ? RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS :
+                        RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S);
 }
 
 static void riscv_iommu_report_fault(RISCVIOMMUState *s,
@@ -420,7 +640,7 @@ err:
 static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
                                             RISCVIOMMUContext *ctx)
 {
-    uint32_t msi_mode;
+    uint32_t fsc_mode, msi_mode;
 
     if (!(ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI) &&
         ctx->tc & RISCV_IOMMU_DC_TC_PRPR) {
@@ -441,6 +661,58 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
         }
     }
 
+    fsc_mode = get_field(ctx->satp, RISCV_IOMMU_DC_FSC_MODE);
+
+    if (ctx->tc & RISCV_IOMMU_DC_TC_PDTV) {
+        switch (fsc_mode) {
+        case RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8:
+            if (!(s->cap & RISCV_IOMMU_CAP_PD8)) {
+                return false;
+            }
+            break;
+        case RISCV_IOMMU_DC_FSC_PDTP_MODE_PD17:
+            if (!(s->cap & RISCV_IOMMU_CAP_PD17)) {
+                return false;
+            }
+            break;
+        case RISCV_IOMMU_DC_FSC_PDTP_MODE_PD20:
+            if (!(s->cap & RISCV_IOMMU_CAP_PD20)) {
+                return false;
+            }
+            break;
+        }
+    } else {
+        /* DC.tc.PDTV is 0 */
+        if (ctx->tc & RISCV_IOMMU_DC_TC_DPE) {
+            return false;
+        }
+
+        if (ctx->tc & RISCV_IOMMU_DC_TC_SXL) {
+            if (fsc_mode == RISCV_IOMMU_CAP_SV32 &&
+                !(s->cap & RISCV_IOMMU_CAP_SV32)) {
+                return false;
+            }
+        } else {
+            switch (fsc_mode) {
+            case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
+                if (!(s->cap & RISCV_IOMMU_CAP_SV39)) {
+                    return false;
+                }
+                break;
+            case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48:
+                if (!(s->cap & RISCV_IOMMU_CAP_SV48)) {
+                    return false;
+                }
+            break;
+            case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57:
+                if (!(s->cap & RISCV_IOMMU_CAP_SV57)) {
+                    return false;
+                }
+                break;
+            }
+        }
+    }
+
     /*
      * CAP_END is always zero (only one endianess). FCTL_BE is
      * always zero (little-endian accesses). Thus TC_SBE must
@@ -478,6 +750,10 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
 
     case RISCV_IOMMU_DDTP_MODE_BARE:
         /* mock up pass-through translation context */
+        ctx->gatp = set_field(0, RISCV_IOMMU_ATP_MODE_FIELD,
+            RISCV_IOMMU_DC_IOHGATP_MODE_BARE);
+        ctx->satp = set_field(0, RISCV_IOMMU_ATP_MODE_FIELD,
+            RISCV_IOMMU_DC_FSC_MODE_BARE);
         ctx->tc = RISCV_IOMMU_DC_TC_V;
         ctx->ta = 0;
         ctx->msiptp = 0;
@@ -551,6 +827,8 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
 
     /* Set translation context. */
     ctx->tc = le64_to_cpu(dc.tc);
+    ctx->gatp = le64_to_cpu(dc.iohgatp);
+    ctx->satp = le64_to_cpu(dc.fsc);
     ctx->ta = le64_to_cpu(dc.ta);
     ctx->msiptp = le64_to_cpu(dc.msiptp);
     ctx->msi_addr_mask = le64_to_cpu(dc.msi_addr_mask);
@@ -564,14 +842,38 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
         return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
     }
 
+    /* FSC field checks */
+    mode = get_field(ctx->satp, RISCV_IOMMU_DC_FSC_MODE);
+    addr = PPN_PHYS(get_field(ctx->satp, RISCV_IOMMU_DC_FSC_PPN));
+
+    if (mode == RISCV_IOMMU_DC_FSC_MODE_BARE) {
+        /* No S-Stage translation, done. */
+        return 0;
+    }
+
     if (!(ctx->tc & RISCV_IOMMU_DC_TC_PDTV)) {
         if (ctx->pasid != RISCV_IOMMU_NOPASID) {
             /* PASID is disabled */
             return RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED;
         }
+        if (mode > RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57) {
+            /* Invalid translation mode */
+            return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
+        }
         return 0;
     }
 
+    if (ctx->pasid == RISCV_IOMMU_NOPASID) {
+        if (!(ctx->tc & RISCV_IOMMU_DC_TC_DPE)) {
+            /* No default PASID enabled, set BARE mode */
+            ctx->satp = 0ULL;
+            return 0;
+        } else {
+            /* Use default PASID #0 */
+            ctx->pasid = 0;
+        }
+    }
+
     /* FSC.TC.PDTV enabled */
     if (mode > RISCV_IOMMU_DC_FSC_PDTP_MODE_PD20) {
         /* Invalid PDTP.MODE */
@@ -605,6 +907,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
 
     /* Use FSC and TA from process directory entry. */
     ctx->ta = le64_to_cpu(dc.ta);
+    ctx->satp = le64_to_cpu(dc.fsc);
 
     return 0;
 }
@@ -832,6 +1135,7 @@ static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx,
     GHashTable *iot_cache, hwaddr iova)
 {
     RISCVIOMMUEntry key = {
+        .gscid = get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID),
         .pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID),
         .iova  = PPN_DOWN(iova),
     };
@@ -909,6 +1213,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         iot = g_new0(RISCVIOMMUEntry, 1);
         iot->iova = PPN_DOWN(iotlb->iova);
         iot->phys = PPN_DOWN(iotlb->translated_addr);
+        iot->gscid = get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID);
         iot->pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID);
         iot->perm = iotlb->perm;
         riscv_iommu_iot_update(s, iot_cache, iot);
@@ -1513,6 +1818,14 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
     if (s->enable_msi) {
         s->cap |= RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRIF;
     }
+    if (s->enable_s_stage) {
+        s->cap |= RISCV_IOMMU_CAP_SV32 | RISCV_IOMMU_CAP_SV39 |
+                  RISCV_IOMMU_CAP_SV48 | RISCV_IOMMU_CAP_SV57;
+    }
+    if (s->enable_g_stage) {
+        s->cap |= RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 |
+                  RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
+    }
     /* Report QEMU target physical address space limits */
     s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
                        TARGET_PHYS_ADDR_SPACE_BITS);
@@ -1613,6 +1926,8 @@ static Property riscv_iommu_properties[] = {
         LIMIT_CACHE_IOT),
     DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
     DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
+    DEFINE_PROP_BOOL("s-stage", RISCVIOMMUState, enable_s_stage, TRUE),
+    DEFINE_PROP_BOOL("g-stage", RISCVIOMMUState, enable_g_stage, TRUE),
     DEFINE_PROP_LINK("downstream-mr", RISCVIOMMUState, target_mr,
         TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 3afee9f3e8..c24e3e4c16 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -38,6 +38,8 @@ struct RISCVIOMMUState {
 
     bool enable_off;      /* Enable out-of-reset OFF mode (DMA disabled) */
     bool enable_msi;      /* Enable MSI remapping */
+    bool enable_s_stage;  /* Enable S/VS-Stage translation */
+    bool enable_g_stage;  /* Enable G-Stage translation */
 
     /* IOMMU Internal State */
     uint64_t ddtp;        /* Validated Device Directory Tree Root Pointer */
-- 
2.44.0


