Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54873A553FD
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Mar 2025 19:04:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqFXm-00035y-KY; Thu, 06 Mar 2025 13:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tqFXW-000336-Gp
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:01:49 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tqFXS-000051-RO
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:01:44 -0500
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-22409077c06so21322595ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 10:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741284100; x=1741888900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pXjnzMdFRw8UN/BnZINokoDYNlgpPuyWmsHQdzmGGak=;
 b=SjOfkoqFukzYqRaGNLTfaUaVkLmujtfJKfFAthODfsfbSfMlxpD2BnYxeyE23iwYar
 XMkza3RuAzqPVwxsdEg1gYfBjrpCBhV+glNYQ5+iTSX01YGbloPVHp+o5gkY/n+e9xaD
 lBdYnPKEpDklSyUcxOzWVDWOBiKZLneJUgfteJeCftU52dkO487xZnZhw5mLGRoAlkeg
 jCs3bMCyyhRnDZOFoad0sqmPco9Jqsev1KuDrCqFYs0TykoOYmJr9gGWuVo+NJiB0vvU
 OIWQM+9E7QZk0ydhmQQFd1MJofNFp+qXPLe+YMl6tdyVNxkYtu9idZmlUQ9Ekk1uiRK8
 6t3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741284100; x=1741888900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pXjnzMdFRw8UN/BnZINokoDYNlgpPuyWmsHQdzmGGak=;
 b=LK3jil3LoegNgKAPcrv66dDz9eYIIL8jSY5F0gJYLpm6MYeI+UcfoOiiN6BzKbgsnE
 UaKy2umAHHHJy6P3yvx5mn2mngLwsmCzFQhmm4XfhkpsmmxiwkveAmWrWOwJPcuk/ihR
 qwFLmJLQ9AbAavWLBVAiSmE93WbUWufeH9BxXAzh2sBRK1t9wa4Y5J2MVkNY0mnpO6Bk
 EjfrW/KPrgK2YbiR4HohzkLG3NyWmaM7s2sReuolriKwnNpcSLNfKD0CGyVr8/y3nLuD
 j2yLNqNsLZWnhTA0wiD2hi+tV/1JOz69RhVJcdh7aJ/KnCHI0rgjRBpPvhj8Ss5A3gYt
 57kw==
X-Gm-Message-State: AOJu0YwKV3M9zR40CXgkrrlFegut6YG6jq/po5BI/tJE5I3sjury3t8l
 T00OJ0xJX/MdH74qQ1ZgKsGapmLm25vGI345G/gDpJbcz8icAxiGUbCqPMZEEw==
X-Gm-Gg: ASbGncv7Eo+yV7yC0oYG1fyMsOmWNhRmqZ2eN5dSiCVFKxr3n3bIHfkegbYDAoSMrLZ
 Un5AwTD1xZKyHGFj9ZJeevI8LHr87m41X5TmtSqweyUowTcE0Hcc6BVwpcK8gzansGrIyh1oHFv
 bBcYe2NVdaXu3SPB4RKX0pncpKx9pLRmAWGQXvZyAom2JhfRIrKLZL7/2493TuTDZ04OcYe2rYE
 DGRth7IRzRSRAXhH6IOrvgbhfMKmRnjp40wss+vFlzoibpY80dQhvKvJ/1YDVJS0KKCMI9LjVS4
 FcNwmPkm0yiPal+gh/UxDH9wDsn88ZPEVanhf2S70xOzWhjOOgQOG0tuLg==
X-Google-Smtp-Source: AGHT+IEiiamkSUvp1Igj6O+INCEjbd3lWZMCuULwpW3dQjPhQNzFdGr5iN49ibRoDe42igO9KikSYg==
X-Received: by 2002:a05:6a21:700f:b0:1f0:ea87:fab7 with SMTP id
 adf61e73a8af0-1f544aef35cmr739168637.13.1741284100301; 
 Thu, 06 Mar 2025 10:01:40 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.138])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28126db9bsm1338498a12.58.2025.03.06.10.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 10:01:39 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v3 01/10] vfio/igd: Remove GTT write quirk in IO BAR 4
Date: Fri,  7 Mar 2025 02:01:21 +0800
Message-ID: <20250306180131.32970-2-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250306180131.32970-1-tomitamoeko@gmail.com>
References: <20250306180131.32970-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x643.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The IO BAR4 of IGD devices contains a pair of 32-bit address/data
registers, MMIO_Index (0x0) and MMIO_Data (0x4), which provide access
to the MMIO BAR0 (GTTMMADR) from IO space. These registers are probably
only used by the VBIOS, and are not documented by intel. The observed
layout of MMIO_Index register is:
 31                                                   2   1      0
+-------------------------------------------------------------------+
|                        Offset                        | Rsvd | Sel |
+-------------------------------------------------------------------+
- Offset: Byte offset in specified region, 4-byte aligned.
- Sel: Region selector
       0: MMIO register region (first half of MMIO BAR0)
       1: GTT region (second half of MMIO BAR0). Pre Gen11 only.

Currently, QEMU implements a quirk that adjusts the guest Data Stolen
Memory (DSM) region address to be (addr - host BDSM + guest BDSM) when
programming GTT entries via IO BAR4, assuming guest still programs GTT
with host DSM address, which is not the case. Guest's BDSM register is
emulated and initialized to 0 at startup by QEMU, then SeaBIOS programs
its value[1]. As result, the address programmed to GTT entries by VBIOS
running in guest are valid GPA, and this unnecessary adjustment brings
inconsistency.

[1] https://gitlab.com/qemu-project/seabios/-/blob/1.12-stable/src/fw/pciinit.c#L319-332

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 191 +-------------------------------------------------
 1 file changed, 1 insertion(+), 190 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index b1a237edd6..ca3a32f4f2 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -106,12 +106,6 @@ static int igd_gen(VFIOPCIDevice *vdev)
     return -1;
 }
 
-typedef struct VFIOIGDQuirk {
-    struct VFIOPCIDevice *vdev;
-    uint32_t index;
-    uint64_t bdsm;
-} VFIOIGDQuirk;
-
 #define IGD_GMCH 0x50 /* Graphics Control Register */
 #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
 #define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
@@ -300,129 +294,6 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
     return ret;
 }
 
-/*
- * IGD Gen8 and newer support up to 8MB for the GTT and use a 64bit PTE
- * entry, older IGDs use 2MB and 32bit.  Each PTE maps a 4k page.  Therefore
- * we either have 2M/4k * 4 = 2k or 8M/4k * 8 = 16k as the maximum iobar index
- * for programming the GTT.
- *
- * See linux:include/drm/i915_drm.h for shift and mask values.
- */
-static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
-{
-    uint32_t gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
-    int gen = igd_gen(vdev);
-    uint64_t ggms_size = igd_gtt_memory_size(gen, gmch);
-
-    return (ggms_size / (4 * KiB)) * (gen < 8 ? 4 : 8);
-}
-
-/*
- * The IGD ROM will make use of stolen memory (GGMS) for support of VESA modes.
- * Somehow the host stolen memory range is used for this, but how the ROM gets
- * it is a mystery, perhaps it's hardcoded into the ROM.  Thankfully though, it
- * reprograms the GTT through the IOBAR where we can trap it and transpose the
- * programming to the VM allocated buffer.  That buffer gets reserved by the VM
- * firmware via the fw_cfg entry added below.  Here we're just monitoring the
- * IOBAR address and data registers to detect a write sequence targeting the
- * GTTADR.  This code is developed by observed behavior and doesn't have a
- * direct spec reference, unfortunately.
- */
-static uint64_t vfio_igd_quirk_data_read(void *opaque,
-                                         hwaddr addr, unsigned size)
-{
-    VFIOIGDQuirk *igd = opaque;
-    VFIOPCIDevice *vdev = igd->vdev;
-
-    igd->index = ~0;
-
-    return vfio_region_read(&vdev->bars[4].region, addr + 4, size);
-}
-
-static void vfio_igd_quirk_data_write(void *opaque, hwaddr addr,
-                                      uint64_t data, unsigned size)
-{
-    VFIOIGDQuirk *igd = opaque;
-    VFIOPCIDevice *vdev = igd->vdev;
-    uint64_t val = data;
-    int gen = igd_gen(vdev);
-
-    /*
-     * Programming the GGMS starts at index 0x1 and uses every 4th index (ie.
-     * 0x1, 0x5, 0x9, 0xd,...).  For pre-Gen8 each 4-byte write is a whole PTE
-     * entry, with 0th bit enable set.  For Gen8 and up, PTEs are 64bit, so
-     * entries 0x5 & 0xd are the high dword, in our case zero.  Each PTE points
-     * to a 4k page, which we translate to a page from the VM allocated region,
-     * pointed to by the BDSM register.  If this is not set, we fail.
-     *
-     * We trap writes to the full configured GTT size, but we typically only
-     * see the vBIOS writing up to (nearly) the 1MB barrier.  In fact it often
-     * seems to miss the last entry for an even 1MB GTT.  Doing a gratuitous
-     * write of that last entry does work, but is hopefully unnecessary since
-     * we clear the previous GTT on initialization.
-     */
-    if ((igd->index % 4 == 1) && igd->index < vfio_igd_gtt_max(vdev)) {
-        if (gen < 8 || (igd->index % 8 == 1)) {
-            uint64_t base;
-
-            if (gen < 11) {
-                base = pci_get_long(vdev->pdev.config + IGD_BDSM);
-            } else {
-                base = pci_get_quad(vdev->pdev.config + IGD_BDSM_GEN11);
-            }
-            if (!base) {
-                hw_error("vfio-igd: Guest attempted to program IGD GTT before "
-                         "BIOS reserved stolen memory.  Unsupported BIOS?");
-            }
-
-            val = data - igd->bdsm + base;
-        } else {
-            val = 0; /* upper 32bits of pte, we only enable below 4G PTEs */
-        }
-
-        trace_vfio_pci_igd_bar4_write(vdev->vbasedev.name,
-                                      igd->index, data, val);
-    }
-
-    vfio_region_write(&vdev->bars[4].region, addr + 4, val, size);
-
-    igd->index = ~0;
-}
-
-static const MemoryRegionOps vfio_igd_data_quirk = {
-    .read = vfio_igd_quirk_data_read,
-    .write = vfio_igd_quirk_data_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static uint64_t vfio_igd_quirk_index_read(void *opaque,
-                                          hwaddr addr, unsigned size)
-{
-    VFIOIGDQuirk *igd = opaque;
-    VFIOPCIDevice *vdev = igd->vdev;
-
-    igd->index = ~0;
-
-    return vfio_region_read(&vdev->bars[4].region, addr, size);
-}
-
-static void vfio_igd_quirk_index_write(void *opaque, hwaddr addr,
-                                       uint64_t data, unsigned size)
-{
-    VFIOIGDQuirk *igd = opaque;
-    VFIOPCIDevice *vdev = igd->vdev;
-
-    igd->index = data;
-
-    vfio_region_write(&vdev->bars[4].region, addr, data, size);
-}
-
-static const MemoryRegionOps vfio_igd_index_quirk = {
-    .read = vfio_igd_quirk_index_read,
-    .write = vfio_igd_quirk_index_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
 #define IGD_GGC_MMIO_OFFSET     0x108040
 #define IGD_BDSM_MMIO_OFFSET    0x1080C0
 
@@ -494,14 +365,11 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     g_autofree struct vfio_region_info *opregion = NULL;
     g_autofree struct vfio_region_info *host = NULL;
     g_autofree struct vfio_region_info *lpc = NULL;
-    VFIOQuirk *quirk;
-    VFIOIGDQuirk *igd;
     PCIDevice *lpc_bridge;
-    int i, ret, gen;
+    int ret, gen;
     uint64_t ggms_size, gms_size;
     uint64_t *bdsm_size;
     uint32_t gmch;
-    uint16_t cmd_orig, cmd;
     Error *err = NULL;
 
     /*
@@ -634,32 +502,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    /* Setup our quirk to munge GTT addresses to the VM allocated buffer */
-    quirk = vfio_quirk_alloc(2);
-    igd = quirk->data = g_malloc0(sizeof(*igd));
-    igd->vdev = vdev;
-    igd->index = ~0;
-    if (gen < 11) {
-        igd->bdsm = vfio_pci_read_config(&vdev->pdev, IGD_BDSM, 4);
-    } else {
-        igd->bdsm = vfio_pci_read_config(&vdev->pdev, IGD_BDSM_GEN11, 4);
-        igd->bdsm |=
-            (uint64_t)vfio_pci_read_config(&vdev->pdev, IGD_BDSM_GEN11 + 4, 4) << 32;
-    }
-    igd->bdsm &= ~((1 * MiB) - 1); /* 1MB aligned */
-
-    memory_region_init_io(&quirk->mem[0], OBJECT(vdev), &vfio_igd_index_quirk,
-                          igd, "vfio-igd-index-quirk", 4);
-    memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
-                                        0, &quirk->mem[0], 1);
-
-    memory_region_init_io(&quirk->mem[1], OBJECT(vdev), &vfio_igd_data_quirk,
-                          igd, "vfio-igd-data-quirk", 4);
-    memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
-                                        4, &quirk->mem[1], 1);
-
-    QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
-
     /*
      * Allow user to override dsm size using x-igd-gms option, in multiples of
      * 32MiB. This option should only be used when the desired size cannot be
@@ -717,37 +559,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         pci_set_quad(vdev->emulated_config_bits + IGD_BDSM_GEN11, ~0);
     }
 
-    /*
-     * This IOBAR gives us access to GTTADR, which allows us to write to
-     * the GTT itself.  So let's go ahead and write zero to all the GTT
-     * entries to avoid spurious DMA faults.  Be sure I/O access is enabled
-     * before talking to the device.
-     */
-    if (pread(vdev->vbasedev.fd, &cmd_orig, sizeof(cmd_orig),
-              vdev->config_offset + PCI_COMMAND) != sizeof(cmd_orig)) {
-        error_report("IGD device %s - failed to read PCI command register",
-                     vdev->vbasedev.name);
-    }
-
-    cmd = cmd_orig | PCI_COMMAND_IO;
-
-    if (pwrite(vdev->vbasedev.fd, &cmd, sizeof(cmd),
-               vdev->config_offset + PCI_COMMAND) != sizeof(cmd)) {
-        error_report("IGD device %s - failed to write PCI command register",
-                     vdev->vbasedev.name);
-    }
-
-    for (i = 1; i < vfio_igd_gtt_max(vdev); i += 4) {
-        vfio_region_write(&vdev->bars[4].region, 0, i, 4);
-        vfio_region_write(&vdev->bars[4].region, 4, 0, 4);
-    }
-
-    if (pwrite(vdev->vbasedev.fd, &cmd_orig, sizeof(cmd_orig),
-               vdev->config_offset + PCI_COMMAND) != sizeof(cmd_orig)) {
-        error_report("IGD device %s - failed to restore PCI command register",
-                     vdev->vbasedev.name);
-    }
-
     trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name,
                                     (ggms_size + gms_size) / MiB);
 }
-- 
2.47.2


