Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8654D7E47FC
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:13:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QXG-0004dG-LT; Tue, 07 Nov 2023 13:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1r0QXE-0004Zj-1k
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:10:44 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1r0QWx-0002l2-AZ
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:10:43 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2801d7f46f9so5004095a91.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699380625; x=1699985425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z3VD1vraDKH7t/1eP7lxzrPhMiE3bMoC5UEpP6LTwk8=;
 b=MSmhtCTTJyegQDXpyly+w6ElBg3bLXueg7ErO734s45maLwSuwPtFYGernOYPRDMVX
 +UuG9R25qKDwJDQmaqoSUKLaeNGr6c8rEyN+tjQMY9codTt4Y5Sjsyvu4G6djbx5Ob8a
 R4aHxl3b49KqiPMxguVeTk2trEgD5xnQZJ+iHwZcQTn9eFJqlggal0OCgs0vlYQ3tOLH
 inZHdxntzhaA9Cfd2mNvl6LwBKkx8dsbH90gPoJNcjWxOguKQ6aaS+4naHBbhO8f23P3
 GZtFQPi23jhOUkQ/9vUDQMzRIrpb+o/HHlZjl/t4qAgo3L4tEQjYDDwp7+W6j6FWYxJM
 zO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380625; x=1699985425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z3VD1vraDKH7t/1eP7lxzrPhMiE3bMoC5UEpP6LTwk8=;
 b=L510b7fhl1zlDVurZaMkM5F1a27z3qty5hiza7MIB0/leNhg1W/cBbPRur9dTQpof7
 9jAEYRP9zGeykG5zDDTOIvZM/fshukDGF5+/JPalZvou7wqAqEJrN+9Uvzg2zJECHICl
 tjWC4dJ3SQ1vWTd3AyimtYoS1MtNfVDJzlhAIkkvz3F761kwUEIuA+nzhIbVFSRpUuT4
 IbYvZDDqYUvkCfS1G74n+S4EpI7ZTY31IDpxUlaoub8ru3Ta2Vimaw9hVqGoWcVi6x++
 H26PM2PDheXr3EPAeVauTjliYlAS5Tx/75ENidOOvODAmhygoQJ3v1ukSGozYRMOIY8W
 03GQ==
X-Gm-Message-State: AOJu0Ywlw+wpN8f6lF4ttgvcQkQxyHN5FlPPrZT7Hk1Nad2Bp/i4RtVO
 0SNaiBwV5irz8Ch2M0n/Wozh41yTGgE=
X-Google-Smtp-Source: AGHT+IEGtULtzP3zUAeEcHZAMhAMLm8y71Y+vs76AD4I/K8Ta3QaxjqhuJ8KDNsahiaEcfKxi25Q/A==
X-Received: by 2002:a17:90a:6f84:b0:280:9074:eb3d with SMTP id
 e4-20020a17090a6f8400b002809074eb3dmr17621113pjk.22.1699380624853; 
 Tue, 07 Nov 2023 10:10:24 -0800 (PST)
Received: from DT.local (c-71-202-158-162.hsd1.ca.comcast.net.
 [71.202.158.162]) by smtp.gmail.com with ESMTPSA id
 az10-20020a170902a58a00b001cc615e6850sm131924plb.90.2023.11.07.10.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:10:24 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com, dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan@outlook.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v3 9/9] hw/mem/cxl_type3: Add dpa range validation for
 accesses to dc regions
Date: Tue,  7 Nov 2023 10:07:13 -0800
Message-ID: <20231107180907.553451-10-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107180907.553451-1-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Fan Ni <fan.ni@samsung.com>

Not all dpa range in the dc regions is valid to access until an extent
covering the range has been added. Add a bitmap for each region to
record whether a dc block in the region has been backed by dc extent.
For the bitmap, a bit in the bitmap represents a dc block. When a dc
extent is added, all the bits of the blocks in the extent will be set,
which will be cleared when the extent is released.

Signed-off-by: Fan Ni <fan.ni@samsung.com>

--
JC changes:
- Rebase on what will be next gitlab.com/jic23/qemu CXL staging tree.
- Drop unnecessary handling of failed bitmap allocations. In common with
  most QEMU allocations they fail hard anyway.
- Use previously factored out cxl_find_region() helper
- Minor editorial stuff in comments such as spec version references
  according to the standard form I'm trying to push through the code.
Picked up Jørgen's fix:
https://lore.kernel.org/qemu-devel/d0d7ca1d-81bc-19b3-4904-d60046ded844@wdc.com/T/#u
---
 hw/cxl/cxl-mailbox-utils.c  | 31 +++++++++------
 hw/mem/cxl_type3.c          | 78 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h | 15 +++++--
 3 files changed, 109 insertions(+), 15 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 8e6a98753a..6be92fb5ba 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1401,10 +1401,9 @@ CXLDCDRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len)
 }
 
 void cxl_insert_extent_to_extent_list(CXLDCDExtentList *list,
-                                             uint64_t dpa,
-                                             uint64_t len,
-                                             uint8_t *tag,
-                                             uint16_t shared_seq)
+                                      uint64_t dpa, uint64_t len,
+                                      uint8_t *tag,
+                                      uint16_t shared_seq)
 {
     CXLDCDExtent *extent;
 
@@ -1421,6 +1420,13 @@ void cxl_insert_extent_to_extent_list(CXLDCDExtentList *list,
     QTAILQ_INSERT_TAIL(list, extent, node);
 }
 
+static void cxl_remove_extent_to_extent_list(CXLDCDExtentList *list,
+                                             CXLDCDExtent *ent)
+{
+    QTAILQ_REMOVE(list, ent, node);
+    g_free(ent);
+}
+
 /*
  * CXL r3.0 Table 8-129: Add Dynamic Capacity Response Input Payload
  * CXL r3.0 Table 8-131: Release Dynamic Capacity Input Payload
@@ -1545,14 +1551,15 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
             }
         }
         if (ent) {
-            QTAILQ_REMOVE(&ct3d->dc.extents_pending_to_add, ent, node);
-            g_free(ent);
+            cxl_remove_extent_to_extent_list(&ct3d->dc.extents_pending_to_add,
+                                             ent);
         } else {
             return CXL_MBOX_INVALID_PA;
         }
 
         cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
         ct3d->dc.total_extent_count += 1;
+        ct3_set_region_block_backed(ct3d, dpa, len);
     }
 
     /*
@@ -1601,16 +1608,22 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
                 uint64_t len1 = dpa - ent->start_dpa;
                 uint64_t len2 = ent->start_dpa + ent->len - dpa - len;
 
+                cxl_remove_extent_to_extent_list(extent_list, ent);
+                ct3d->dc.total_extent_count -= 1;
+                ct3_clear_region_block_backed(ct3d, dpa, len);
+
                 if (len1) {
                     cxl_insert_extent_to_extent_list(extent_list,
                                                      ent->start_dpa, len1,
                                                      NULL, 0);
                     ct3d->dc.total_extent_count += 1;
+                    ct3_set_region_block_backed(ct3d, dpa, len);
                 }
                 if (len2) {
                     cxl_insert_extent_to_extent_list(extent_list, dpa + len,
                                                      len2, NULL, 0);
                     ct3d->dc.total_extent_count += 1;
+                    ct3_set_region_block_backed(ct3d, dpa, len);
                 }
                 break;
                 /*Currently we reject the attempt to remove a superset*/
@@ -1621,11 +1634,7 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
             }
         }
 
-        if (ent) {
-            QTAILQ_REMOVE(extent_list, ent, node);
-            g_free(ent);
-            ct3d->dc.total_extent_count -= 1;
-        } else {
+        if (!ent) {
             /* Try to remove a non-existing extent */
             return CXL_MBOX_INVALID_PA;
         }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 43cea3d818..4ec65a751a 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -810,6 +810,7 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d)
         /* dsmad_handle is set when creating cdat table entries */
         region->flags = 0;
 
+        region->blk_bitmap = bitmap_new(region->len / region->block_size);
         region_base += region->len;
     }
     QTAILQ_INIT(&ct3d->dc.extents);
@@ -818,6 +819,17 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d)
     return 0;
 }
 
+static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
+{
+    int i;
+    struct CXLDCDRegion *region;
+
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        g_free(region->blk_bitmap);
+    }
+}
+
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
@@ -1046,6 +1058,7 @@ err_free_special_ops:
     g_free(regs->special_ops);
 err_address_space_free:
     if (ct3d->dc.host_dc) {
+        cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
     }
     if (ct3d->hostpmem) {
@@ -1068,6 +1081,7 @@ static void ct3_exit(PCIDevice *pci_dev)
     spdm_sock_fini(ct3d->doe_spdm.socket);
     g_free(regs->special_ops);
     if (ct3d->dc.host_dc) {
+        cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
     }
     if (ct3d->hostpmem) {
@@ -1078,6 +1092,66 @@ static void ct3_exit(PCIDevice *pci_dev)
     }
 }
 
+/*
+ * Mark the DPA range [dpa, dap + len) to be backed and accessible. This
+ * happens when a DC extent is added and accepted by the host.
+ */
+void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                 uint64_t len)
+{
+    CXLDCDRegion *region;
+
+    region = cxl_find_dc_region(ct3d, dpa, len);
+    if (!region) {
+        return;
+    }
+
+    bitmap_set(region->blk_bitmap, (dpa - region->base) / region->block_size,
+               len / region->block_size);
+}
+
+/*
+ * Check whether a DPA range [dpa, dpa + len) has been backed with DC extents.
+ * Used when validating read/write to dc regions
+ */
+bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                  uint64_t len)
+{
+    CXLDCDRegion *region;
+    uint64_t nbits;
+    long nr;
+
+    region = cxl_find_dc_region(ct3d, dpa, len);
+    if (!region) {
+        return false;
+    }
+
+    nr = (dpa - region->base) / region->block_size;
+    nbits = DIV_ROUND_UP(len, region->block_size);
+    return find_next_zero_bit(region->blk_bitmap, nr + nbits, nr) == nr + nbits;
+}
+
+/*
+ * Mark the DPA range [dpa, dap + len) to be unbacked and inaccessible. This
+ * happens when a dc extent is return by the host.
+ */
+void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                   uint64_t len)
+{
+    CXLDCDRegion *region;
+    uint64_t nbits;
+    long nr;
+
+    region = cxl_find_dc_region(ct3d, dpa, len);
+    if (!region) {
+        return;
+    }
+
+    nr = (dpa - region->base) / region->block_size;
+    nbits = len / region->block_size;
+    bitmap_clear(region->blk_bitmap, nr, nbits);
+}
+
 static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
 {
     int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
@@ -1178,6 +1252,10 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
         *as = &ct3d->hostpmem_as;
         *dpa_offset -= vmr_size;
     } else {
+        if (!ct3_test_region_block_backed(ct3d, *dpa_offset, size)) {
+            return -ENODEV;
+        }
+
         *as = &ct3d->dc.host_dc_as;
         *dpa_offset -= (vmr_size + pmr_size);
     }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ca4f824b11..b71b09700a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -447,6 +447,7 @@ typedef struct CXLDCDRegion {
     uint64_t block_size;
     uint32_t dsmadhandle;
     uint8_t flags;
+    unsigned long *blk_bitmap;
 } CXLDCDRegion;
 
 struct CXLType3Dev {
@@ -552,9 +553,15 @@ void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
 
 CXLDCDRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
 void cxl_insert_extent_to_extent_list(CXLDCDExtentList *list,
-                                             uint64_t dpa,
-                                             uint64_t len,
-                                             uint8_t *tag,
-                                             uint16_t shared_seq);
+                                      uint64_t dpa,
+                                      uint64_t len,
+                                      uint8_t *tag,
+                                      uint16_t shared_seq);
 bool test_any_bits_set(const unsigned long *addr, int nr, int size);
+void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                  uint64_t len);
+void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                   uint64_t len);
+bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                  uint64_t len);
 #endif
-- 
2.42.0


