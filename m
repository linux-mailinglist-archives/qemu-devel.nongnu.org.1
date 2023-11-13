Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 735D77EA1EA
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:34:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ao6-0001Y8-6L; Mon, 13 Nov 2023 12:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2ao0-0001Vc-3L
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:33:01 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2ann-0000vq-T4
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:59 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc9b626a96so33523155ad.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699896766; x=1700501566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kKwJoYSEfi9kpha72LByVIQJbXETSVDWcN/f8oG001I=;
 b=DDwEdzTANa0QabMDvB+BiPlkHqJTcTfae5m73K19KxN8/X7R9I8HWMG+qmoxD/jNUP
 6sVQk8pg5/NUHWZTI8QeImFWnjAIte/6nT0WjspfGCt0lnGVozlrLOP/ISPYXTeuoDQf
 fY21YMlGcqqwp11RiIzuCav+4VstjaZMXF0nxDV0SOjPCW/nBBdLnvpQ4pEZDUy3zMWx
 Whc2OipAupZUdPHh0jgpzXcsjuea11BsPGZaY2h9SrNxet0FXl1elxWia+QQtjvMxPTE
 qNtlU0mC8y9BUMf2wAOkOy36Sgibs/lGTg/JHXYLxZu35xT191LvGQvA5tF+oqe3iHea
 y8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699896766; x=1700501566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kKwJoYSEfi9kpha72LByVIQJbXETSVDWcN/f8oG001I=;
 b=d/DM420Tw8l69r8xSrLCZS8qnkZdzlUsp6TYSxZiBk9I0iSgiMBrTvR9AUGLzQWdj7
 m4angU/XFV+MUJpYAht7mP9pg/nRTuvcwVUP3tfr2p622oybOtX/CM+92EIhGQTHFHwG
 EmEGnaS/cTM3jdWYi3hPelwqMvab9P9jQHRtNthkiaVjwVOcBjq01KAFyCjRY1b+NJs6
 e9jv77wedJkx2rjimc5+6g0eWGSRSXjvJCzkLWXV0/3Tmn7UciZS2vuIM3x7Zh9ABqez
 oUJmVZ24FbPLXuOGNA0+cmmVzJpzMKSZqa+9RH0upGltrToJElkF8vRfJWRAeWwR5Gwj
 qdVg==
X-Gm-Message-State: AOJu0YzPtK9Rx1a7cCgQ/O4kkjfrj3xxMwJFxddd9VvffdZBkmZJ6YjL
 LlnjGUONrgWUNrFlIGEqusnMo+UltucXjX0yl9s=
X-Google-Smtp-Source: AGHT+IHnPhlYlr0ptRG7WFG9lKZ0nZoKNaD2ZGUtjO1OdTIRl7l0aPQ+INRafgbw4k637EaX5SYmaA==
X-Received: by 2002:a17:903:41c8:b0:1cc:5833:cf5e with SMTP id
 u8-20020a17090341c800b001cc5833cf5emr281108ple.27.1699896765906; 
 Mon, 13 Nov 2023 09:32:45 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 e6-20020a170902d38600b001c731b62403sm4271910pld.218.2023.11.13.09.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:32:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 09/12] hw/pci-host/astro: Fix boot for C3700 machine
Date: Mon, 13 Nov 2023 09:32:34 -0800
Message-Id: <20231113173237.48233-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113173237.48233-1-richard.henderson@linaro.org>
References: <20231113173237.48233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


