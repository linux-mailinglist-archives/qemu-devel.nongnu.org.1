Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD3E924906
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jul 2024 22:19:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjwZ-00019V-OW; Tue, 02 Jul 2024 16:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjvw-0007Lu-TZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjvu-0008OQ-RW
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J5j8n04Q1gRbmovO7PmlswqpHPYyPExcO8mAPNVjzhI=;
 b=gFKWnVBGJmtWPO9FIkf3rTZ1ENLoG6JEh4yQ+ZbSPCG3xTlb8LsWi+D4iE5ca3Vf682ElS
 nuASpSw2H9iYJPzoE1Acu1q0JTHZ3GxKtLdVhKvcWJxuzwRWsOTIui55npBI7M4WyiBDKi
 tbAHm38d+Bd31zujdj9CI5SS5hd9tbY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-qjCe7IpROGGAyrVYufppjg-1; Tue, 02 Jul 2024 16:16:57 -0400
X-MC-Unique: qjCe7IpROGGAyrVYufppjg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4210d151c5bso32063825e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951415; x=1720556215;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5j8n04Q1gRbmovO7PmlswqpHPYyPExcO8mAPNVjzhI=;
 b=S3kYYz76xxQN0B3p+pe9Gfji1u02dxr1IOEDThi00xIe2LpymPPYfY2LD0LjbsV67v
 T8lurUmSLDCA0aXMFCsrrhp7U70qGXuZfK5I8zK53No1VA9Ctrf7yKBtxlYiM5SfFaja
 jCBeTkv46lU6YdQ7aAUiD9XaHseYkv3IxmrR74UEkxqNIBbLCrhfu1+LCt7firszH51u
 wTugZ3hIcgJXJWAMR4jFWlY+z28405ff+Z5tg79zRQEx7bNWVGrO3Qyj1An+GjnMw5IY
 cguPxbKy96vrmlAroIEJtb401j3oxp4fm+2IjxEi+ShrL+G6uOAzjdcCiGqNdM3E4aEz
 +NNg==
X-Gm-Message-State: AOJu0Yzuarm102Ii9j1ofa7nnuxJPpczRVB90z3ldnxtSONkWlBMJsgn
 ltM9z+/8IVxkA/U/VJMinvIO1K5vnNalklekHne6Uieq4C3Bh801Qo5fDETQspi5xQYnnpXF1NY
 HAS81tZor5LfyT7VB0PIMINWM6v7ViOj1oB/8ze/bzezEQ7I5Hfh0CGo1/PUrCXkNAjMySZ7qc5
 mi6Y6uAHM4AyRbcx6EGapkmGUuCGW4+w==
X-Received: by 2002:a05:600c:3b07:b0:425:6979:9b5f with SMTP id
 5b1f17b1804b1-4257a009c28mr65501975e9.6.1719951415264; 
 Tue, 02 Jul 2024 13:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhl8e1KcRWDGUyMsqnbBpBLzCAtJzesxmlNIF/+J4r9Gb3upbRfSjqTStREKpzuvn+DrdLpA==
X-Received: by 2002:a05:600c:3b07:b0:425:6979:9b5f with SMTP id
 5b1f17b1804b1-4257a009c28mr65501855e9.6.1719951414739; 
 Tue, 02 Jul 2024 13:16:54 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678a648dd3sm2153723f8f.89.2024.07.02.13.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:16:54 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:16:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Svetly Todorov <svetly.todorov@memverge.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL v2 27/88] hw/mem/cxl_type3: Add DPA range validation for
 accesses to DC regions
Message-ID: <e4180db4e63b904183374c6e7ec07f66aa0decde.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fan Ni <fan.ni@samsung.com>

All DPA ranges in the DC regions are invalid to access until an extent
covering the range has been successfully accepted by the host. A bitmap
is added to each region to record whether a DC block in the region has
been backed by a DC extent. Each bit in the bitmap represents a DC block.
When a DC extent is accepted, all the bits representing the blocks in the
extent are set, which will be cleared when the extent is released.

Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20240523174651.1089554-13-nifan.cxl@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  7 ++++
 hw/cxl/cxl-mailbox-utils.c  |  3 ++
 hw/mem/cxl_type3.c          | 76 +++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index c69ff6b5de..0a4fcb2800 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -456,6 +456,7 @@ typedef struct CXLDCRegion {
     uint64_t block_size;
     uint32_t dsmadhandle;
     uint8_t flags;
+    unsigned long *blk_bitmap;
 } CXLDCRegion;
 
 struct CXLType3Dev {
@@ -577,4 +578,10 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
 void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
                                        CXLDCExtentGroup *group);
 void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
+void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                 uint64_t len);
+void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                   uint64_t len);
+bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                  uint64_t len);
 #endif
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 64387f34ce..c4852112fe 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1655,6 +1655,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
 
         cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
         ct3d->dc.total_extent_count += 1;
+        ct3_set_region_block_backed(ct3d, dpa, len);
     }
     /* Remove the first extent group in the pending list */
     cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
@@ -1813,10 +1814,12 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
      * list and update the extent count;
      */
     QTAILQ_FOREACH_SAFE(ent, &ct3d->dc.extents, node, ent_next) {
+        ct3_clear_region_block_backed(ct3d, ent->start_dpa, ent->len);
         cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
     }
     copy_extent_list(&ct3d->dc.extents, &updated_list);
     QTAILQ_FOREACH_SAFE(ent, &updated_list, node, ent_next) {
+        ct3_set_region_block_backed(ct3d, ent->start_dpa, ent->len);
         cxl_remove_extent_from_extent_list(&updated_list, ent);
     }
     ct3d->dc.total_extent_count = updated_list_size;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index f53bcca6d3..0d18259ec0 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -672,6 +672,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
             .flags = 0,
         };
         ct3d->dc.total_capacity += region->len;
+        region->blk_bitmap = bitmap_new(region->len / region->block_size);
     }
     QTAILQ_INIT(&ct3d->dc.extents);
     QTAILQ_INIT(&ct3d->dc.extents_pending);
@@ -683,6 +684,8 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
 {
     CXLDCExtent *ent, *ent_next;
     CXLDCExtentGroup *group, *group_next;
+    int i;
+    CXLDCRegion *region;
 
     QTAILQ_FOREACH_SAFE(ent, &ct3d->dc.extents, node, ent_next) {
         cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
@@ -695,6 +698,11 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
         }
         g_free(group);
     }
+
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        g_free(region->blk_bitmap);
+    }
 }
 
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
@@ -926,6 +934,70 @@ static void ct3_exit(PCIDevice *pci_dev)
     }
 }
 
+/*
+ * Mark the DPA range [dpa, dap + len - 1] to be backed and accessible. This
+ * happens when a DC extent is added and accepted by the host.
+ */
+void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                 uint64_t len)
+{
+    CXLDCRegion *region;
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
+ * Check whether the DPA range [dpa, dpa + len - 1] is backed with DC extents.
+ * Used when validating read/write to dc regions
+ */
+bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                  uint64_t len)
+{
+    CXLDCRegion *region;
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
+    /*
+     * if bits between [dpa, dpa + len) are all 1s, meaning the DPA range is
+     * backed with DC extents, return true; else return false.
+     */
+    return find_next_zero_bit(region->blk_bitmap, nr + nbits, nr) == nr + nbits;
+}
+
+/*
+ * Mark the DPA range [dpa, dap + len - 1] to be unbacked and inaccessible.
+ * This happens when a dc extent is released by the host.
+ */
+void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                   uint64_t len)
+{
+    CXLDCRegion *region;
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
@@ -1030,6 +1102,10 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
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
-- 
MST


