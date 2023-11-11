Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3417E878D
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 02:33:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1crV-0002YO-0s; Fri, 10 Nov 2023 20:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1crP-0002Jp-5K
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:32:31 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1crN-0001cT-7O
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:32:30 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso2116411b3a.1
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 17:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699666346; x=1700271146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kKwJoYSEfi9kpha72LByVIQJbXETSVDWcN/f8oG001I=;
 b=Us1pO4tFr1Q4pTHZUzh1UrFuzo/P7bUyALdub2NoZYsoV89sxps6N4/sYKCMfRb5L9
 d4y/YwMqvHmHe3YTUe5WbkAeeb9oPMn0IEhTYoOP6eawTWvIGuBAoNueTKhI18PXrtPf
 vs8anMLIf8UFtnJf8j1wVtJoqc06F0myeWTxSMt4UkJW2OFrv3OnznuHAvE/gPh/QcsR
 SumHpVhBp3NAXGUgnXriHbQd87p2S/I2FTBKoeDuHMtikYM0jFJHyPHqBeV/9LXf4Yuf
 0XyiuLBCbpAqmA3UTLU8oAdtUjtvhRy4LMcfL2J17I40uuD3BJxVs6vk3rSMPa0v59PR
 WBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699666346; x=1700271146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kKwJoYSEfi9kpha72LByVIQJbXETSVDWcN/f8oG001I=;
 b=kcdUczvYoqAuzTSGNgD148WwxW2utU7DPZbZAfCEUVrmDNz/TjTysCJGe2neHVYvqs
 SpkgKhj5htaqN5+8bhoziJ4gBzP2jg8CKV6PLB6KraktGOJeZXmSmbhu3xzdQ09IuhFl
 c9IqT70gNa0UGnAkZctvkUgPoODcR+8Cam4ANY384LdIxkATPuPF4F0OQKEqm0iVB08v
 TlWtvp2ck2wQcfTYB7dj+MHQPlhQOzmbpLq6gbtXtW2XCPxWfNT2gDkT3XW9EMc3ZRUd
 CdRa902polyG9G3kQWwji8JGkprxA+CxudqIenyKdPz1vVeg8WkJKB48099TsLos2hqG
 3GWg==
X-Gm-Message-State: AOJu0YwX9NlF2meXB08wHSLMs4yfrPstr2WXYMfa44bxCoZfeZZaNLJU
 VVj+pKTm65Rdby6FxDyXBGIkn9J+IcZ3aLCP3IE=
X-Google-Smtp-Source: AGHT+IGKIkiK34DpHWm8QwJZuDqiIiaPRdU4nabf1PVRYQqAHJt95vDI+LYlfDdDYdblZGEWX1hc3A==
X-Received: by 2002:aa7:84c7:0:b0:6c3:4bf2:7486 with SMTP id
 x7-20020aa784c7000000b006c34bf27486mr961801pfn.7.1699666346592; 
 Fri, 10 Nov 2023 17:32:26 -0800 (PST)
Received: from stoup.hsd1.or.comcast.net
 ([2601:1c0:5e02:2a20:a99c:45a6:14e9:ea6])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a62f20b000000b006c1221bc58bsm333502pfh.115.2023.11.10.17.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 17:32:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 11/11] hw/pci-host/astro: Fix boot for C3700 machine
Date: Fri, 10 Nov 2023 17:32:12 -0800
Message-Id: <20231111013212.229673-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111013212.229673-1-richard.henderson@linaro.org>
References: <20231111013212.229673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Apply the "32-bit PCI addressing on 40-bit Runway" as the default
iommu transformation.  This allows PCI devices to dma PDC memory.

Signed-off-by: Helge Deller <deller@gmx.de>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/pci-host/astro.c     | 73 ++++++++++++++++++-----------------------
 hw/pci-host/meson.build |  2 +-
 2 files changed, 33 insertions(+), 42 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index bd226581af..7d68ccee7e 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -32,6 +32,7 @@
 #include "hw/pci-host/astro.h"
 #include "hw/hppa/hppa_hardware.h"
 #include "migration/vmstate.h"
+#include "target/hppa/cpu.h"
 #include "trace.h"
 #include "qom/object.h"
 
@@ -268,22 +269,6 @@ static const MemoryRegionOps elroy_config_addr_ops = {
 };
 
 
-/*
- * A subroutine of astro_translate_iommu that builds an IOMMUTLBEntry using the
- * given translated address and mask.
- */
-static bool make_iommu_tlbe(hwaddr addr, hwaddr taddr, hwaddr mask,
-                            IOMMUTLBEntry *ret)
-{
-    hwaddr tce_mask = ~((1ull << 12) - 1);
-    ret->target_as = &address_space_memory;
-    ret->iova = addr & tce_mask;
-    ret->translated_addr = taddr & tce_mask;
-    ret->addr_mask = ~tce_mask;
-    ret->perm = IOMMU_RW;
-    return true;
-}
-
 /* Handle PCI-to-system address translation.  */
 static IOMMUTLBEntry astro_translate_iommu(IOMMUMemoryRegion *iommu,
                                              hwaddr addr,
@@ -291,53 +276,59 @@ static IOMMUTLBEntry astro_translate_iommu(IOMMUMemoryRegion *iommu,
                                              int iommu_idx)
 {
     AstroState *s = container_of(iommu, AstroState, iommu);
-    IOMMUTLBEntry ret = {
-        .target_as = &address_space_memory,
-        .iova = addr,
-        .translated_addr = 0,
-        .addr_mask = ~(hwaddr)0,
-        .perm = IOMMU_NONE,
-    };
-    hwaddr pdir_ptr, index, a, ibase;
+    hwaddr pdir_ptr, index, ibase;
     hwaddr addr_mask = 0xfff; /* 4k translation */
     uint64_t entry;
 
 #define IOVP_SHIFT              12   /* equals PAGE_SHIFT */
 #define PDIR_INDEX(iovp)        ((iovp) >> IOVP_SHIFT)
-#define IOVP_MASK               PAGE_MASK
 #define SBA_PDIR_VALID_BIT      0x8000000000000000ULL
 
+    addr &= ~addr_mask;
+
+    /*
+     * Default translation: "32-bit PCI Addressing on 40-bit Runway".
+     * For addresses in the 32-bit memory address range ... and then
+     * language which not-coincidentally matches the PSW.W=0 mapping.
+     */
+    if (addr <= UINT32_MAX) {
+        entry = hppa_abs_to_phys_pa2_w0(addr);
+    } else {
+        entry = addr;
+    }
+
     /* "range enable" flag cleared? */
     if ((s->tlb_ibase & 1) == 0) {
-        make_iommu_tlbe(addr, addr, addr_mask, &ret);
-        return ret;
+        goto skip;
     }
 
-    a = addr;
     ibase = s->tlb_ibase & ~1ULL;
-    if ((a & s->tlb_imask) != ibase) {
+    if ((addr & s->tlb_imask) != ibase) {
         /* do not translate this one! */
-        make_iommu_tlbe(addr, addr, addr_mask, &ret);
-        return ret;
+        goto skip;
     }
-    index = PDIR_INDEX(a);
+
+    index = PDIR_INDEX(addr);
     pdir_ptr = s->tlb_pdir_base + index * sizeof(entry);
     entry = ldq_le_phys(&address_space_memory, pdir_ptr);
+
     if (!(entry & SBA_PDIR_VALID_BIT)) { /* I/O PDIR entry valid ? */
-        g_assert_not_reached();
-        goto failure;
+        /* failure */
+        return (IOMMUTLBEntry) { .perm = IOMMU_NONE };
     }
+
     entry &= ~SBA_PDIR_VALID_BIT;
     entry >>= IOVP_SHIFT;
     entry <<= 12;
-    entry |= addr & 0xfff;
-    make_iommu_tlbe(addr, entry, addr_mask, &ret);
-    goto success;
 
- failure:
-    ret = (IOMMUTLBEntry) { .perm = IOMMU_NONE };
- success:
-    return ret;
+ skip:
+    return (IOMMUTLBEntry) {
+        .target_as = &address_space_memory,
+        .iova = addr,
+        .translated_addr = entry,
+        .addr_mask = addr_mask,
+        .perm = IOMMU_RW,
+    };
 }
 
 static AddressSpace *elroy_pcihost_set_iommu(PCIBus *bus, void *opaque,
diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
index de7bfb5a62..36d5ab756f 100644
--- a/hw/pci-host/meson.build
+++ b/hw/pci-host/meson.build
@@ -29,7 +29,7 @@ pci_ss.add(when: 'CONFIG_MV64361', if_true: files('mv64361.c'))
 pci_ss.add(when: 'CONFIG_VERSATILE_PCI', if_true: files('versatile.c'))
 
 # HPPA devices
-pci_ss.add(when: 'CONFIG_ASTRO', if_true: files('astro.c'))
+specific_ss.add(when: 'CONFIG_ASTRO', if_true: files('astro.c'))
 pci_ss.add(when: 'CONFIG_DINO', if_true: files('dino.c'))
 
 system_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
-- 
2.34.1


