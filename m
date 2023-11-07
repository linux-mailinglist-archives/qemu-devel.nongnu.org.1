Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B14BB7E47EA
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:11:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QXQ-0005LB-I0; Tue, 07 Nov 2023 13:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1r0QXO-0005Cb-66
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:10:54 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1r0QWx-0002k1-MU
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:10:53 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc3216b2a1so48538895ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699380621; x=1699985421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fidJGI9tSfEUK7LuKCCNr/HhdNthEOLs0OgUT171rXg=;
 b=TsnQ8RjAzqCgqUp3l7dAXTXZXdj0CuZ0LbxEyU6SDTmNoMkHyvZwM2a2ieRBq4bpH+
 JjJWFVGYcSd2o7lSxO9+dyV6ku892dmqBTrAtQcESHJ5tAMVEC/7K14l+oEmZ5MmTURQ
 8x4Zj7gAR8gmCOfI/gSCFygQ50sOGoVNznrj68/tre8gGpOLP3ldzX2YGkgCZ0OpuvFC
 ZrzjgCmqGV29qh9iCbwRSmXS6IRkz/tRHUG+/9XRzAldIZxxMyMjQQtcwn5kBd1tsUvR
 nhxOEHnBi4ML6bwa8iN7myVaEAW0Ix+Ym/R8WMND2aGy4nDFVcyRZ2y7lcv7eboyu1Nh
 wp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380621; x=1699985421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fidJGI9tSfEUK7LuKCCNr/HhdNthEOLs0OgUT171rXg=;
 b=GxgHBwJq05vwXac34g5ORkcKwjSxl+wn6XpJeGseFfeSuXemf+yfvWQFYjPsm69t4v
 tIRM0sQaTaK9VUdnDgq22luqSSaDipxRvn/eP5QXo/MApaKdk72NyV5B/FOK8rY9egp5
 YM9gFdFZpNPVepDMuQxDcUDZdpsvYG7vy9bZUZAZTUN4ifmQSkHJBUKfSSDO3i9cFFCy
 SGAkQ+ElrkvzhMLH+YaWAL/EilIPZqGOdFXxiuHRGbzJBxaR9v4fYIZ50hYuUeHTeeHX
 1JCu5wAWwrpiED1IJg6fUqT1Zsv60/6l8D37bbAqXLTfJQk7x0N61MvsOnAdSvs/r5QS
 WkPw==
X-Gm-Message-State: AOJu0YxtPqbCa/BxfaUvmIbzxowkiOESspmSeZG88da4dcS7g5YR/wf3
 lVBA50sD8nzztVj5aMwURUTI7XxUfiM=
X-Google-Smtp-Source: AGHT+IH2sOSQhzqP6upCTCtWBH3TOQDDXqGUL3eGXNC+4Wz3oTZeRcj6fBK6yv5oVwcRAzQmxyDd9g==
X-Received: by 2002:a17:903:11c3:b0:1cc:5549:aabd with SMTP id
 q3-20020a17090311c300b001cc5549aabdmr27205343plh.8.1699380621077; 
 Tue, 07 Nov 2023 10:10:21 -0800 (PST)
Received: from DT.local (c-71-202-158-162.hsd1.ca.comcast.net.
 [71.202.158.162]) by smtp.gmail.com with ESMTPSA id
 az10-20020a170902a58a00b001cc615e6850sm131924plb.90.2023.11.07.10.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:10:20 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com, dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan@outlook.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v3 5/9] hw/mem/cxl_type3: Add host backend and address space
 handling for DC regions
Date: Tue,  7 Nov 2023 10:07:09 -0800
Message-ID: <20231107180907.553451-6-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107180907.553451-1-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x62f.google.com
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

Add (file/memory backed) host backend, all the dynamic capacity regions
will share a single, large enough host backend. Set up address space for
DC regions to support read/write operations to dynamic capacity for DCD.

With the change, following supports are added:
1. Add a new property to type3 device "nonvolatile-dc-memdev" to point to host
   memory backend for dynamic capacity. Currently, all dc regions share one
   one host backend.
2. Add namespace for dynamic capacity for read/write support;
3. Create cdat entries for each dynamic capacity region;
4. Fix dvsec range registers to include DC regions.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  16 ++-
 hw/mem/cxl_type3.c          | 198 +++++++++++++++++++++++++++++-------
 include/hw/cxl/cxl_device.h |   4 +
 3 files changed, 179 insertions(+), 39 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 707fd9fe7f..1f512b3e6b 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -596,7 +596,8 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                size_t *len_out,
                                                CXLCCI *cci)
 {
-    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
     struct {
         uint8_t slots_supported;
         uint8_t slot_info;
@@ -610,7 +611,8 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
 
     if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
-        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {
+        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
+        (ct3d->dc.total_capacity < CXL_CAPACITY_MULTIPLIER)) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -764,7 +766,8 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
 
     if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
-        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
+        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -805,9 +808,11 @@ static CXLRetCode cmd_ccls_get_partition_info(const struct cxl_cmd *cmd,
         uint64_t next_pmem;
     } QEMU_PACKED *part_info = (void *)payload_out;
     QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
 
     if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
-        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
+        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -1149,7 +1154,8 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     struct clear_poison_pl *in = (void *)payload_in;
 
     dpa = ldq_le_p(&in->dpa);
-    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size) {
+    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size +
+            ct3d->dc.total_capacity) {
         return CXL_MBOX_INVALID_PA;
     }
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 2d67d2015c..152a51306d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -31,6 +31,7 @@
 #include "hw/pci/spdm.h"
 
 #define DWORD_BYTE 4
+#define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 
 /* Default CDAT entries for a memory region */
 enum {
@@ -44,8 +45,9 @@ enum {
 };
 
 static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
-                                         int dsmad_handle, MemoryRegion *mr,
-                                         bool is_pmem, uint64_t dpa_base)
+                                         int dsmad_handle, uint64_t size,
+                                         bool is_pmem, bool is_dynamic,
+                                         uint64_t dpa_base)
 {
     g_autofree CDATDsmas *dsmas = NULL;
     g_autofree CDATDslbis *dslbis0 = NULL;
@@ -64,9 +66,10 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
             .length = sizeof(*dsmas),
         },
         .DSMADhandle = dsmad_handle,
-        .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
+        .flags = (is_pmem ? CDAT_DSMAS_FLAG_NV : 0) |
+            (is_dynamic ? CDAT_DSMAS_FLAG_DYNAMIC_CAP : 0),
         .DPA_base = dpa_base,
-        .DPA_length = memory_region_size(mr),
+        .DPA_length = size,
     };
 
     /* For now, no memory side cache, plausiblish numbers */
@@ -150,7 +153,7 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
          */
         .EFI_memory_type_attr = is_pmem ? 2 : 1,
         .DPA_offset = 0,
-        .DPA_length = memory_region_size(mr),
+        .DPA_length = size,
     };
 
     /* Header always at start of structure */
@@ -169,21 +172,28 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     g_autofree CDATSubHeader **table = NULL;
     CXLType3Dev *ct3d = priv;
     MemoryRegion *volatile_mr = NULL, *nonvolatile_mr = NULL;
+    MemoryRegion *dc_mr = NULL;
     int dsmad_handle = 0;
     int cur_ent = 0;
     int len = 0;
     int rc, i;
+    uint64_t vmr_size = 0, pmr_size = 0;
 
-    if (!ct3d->hostpmem && !ct3d->hostvmem) {
+    if (!ct3d->hostpmem && !ct3d->hostvmem && !ct3d->dc.num_regions) {
         return 0;
     }
 
+    if (ct3d->hostpmem && ct3d->hostvmem && ct3d->dc.host_dc) {
+        warn_report("The device has static ram and pmem and dynamic capacity");
+    }
+
     if (ct3d->hostvmem) {
         volatile_mr = host_memory_backend_get_memory(ct3d->hostvmem);
         if (!volatile_mr) {
             return -EINVAL;
         }
         len += CT3_CDAT_NUM_ENTRIES;
+        vmr_size = memory_region_size(volatile_mr);
     }
 
     if (ct3d->hostpmem) {
@@ -192,6 +202,19 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
             return -EINVAL;
         }
         len += CT3_CDAT_NUM_ENTRIES;
+        pmr_size = memory_region_size(nonvolatile_mr);
+    }
+
+    if (ct3d->dc.num_regions) {
+        if (ct3d->dc.host_dc) {
+            dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+            if (!dc_mr) {
+                return -EINVAL;
+            }
+            len += CT3_CDAT_NUM_ENTRIES * ct3d->dc.num_regions;
+        } else {
+            return -EINVAL;
+        }
     }
 
     table = g_malloc0(len * sizeof(*table));
@@ -201,8 +224,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
 
     /* Now fill them in */
     if (volatile_mr) {
-        rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
-                                           false, 0);
+        rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, vmr_size,
+                                           false, false, 0);
         if (rc < 0) {
             return rc;
         }
@@ -210,14 +233,38 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     }
 
     if (nonvolatile_mr) {
-        uint64_t base = volatile_mr ? memory_region_size(volatile_mr) : 0;
         rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
-                                           nonvolatile_mr, true, base);
+                                           pmr_size, true, false, vmr_size);
         if (rc < 0) {
             goto error_cleanup;
         }
         cur_ent += CT3_CDAT_NUM_ENTRIES;
     }
+
+    if (dc_mr) {
+        uint64_t region_base = vmr_size + pmr_size;
+
+        /*
+         * Currently we create cdat entries for each region, should we only
+         * create dsmas table instead??
+         * We assume all dc regions are non-volatile for now.
+         *
+         */
+        for (i = 0; i < ct3d->dc.num_regions; i++) {
+            rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]),
+                                               dsmad_handle++,
+                                               ct3d->dc.regions[i].len,
+                                               true, true, region_base);
+            if (rc < 0) {
+                goto error_cleanup;
+            }
+            ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
+
+            cur_ent += CT3_CDAT_NUM_ENTRIES;
+            region_base += ct3d->dc.regions[i].len;
+        }
+    }
+
     assert(len == cur_ent);
 
     *cdat_table = g_steal_pointer(&table);
@@ -445,11 +492,24 @@ static void build_dvsecs(CXLType3Dev *ct3d)
             range2_size_hi = ct3d->hostpmem->size >> 32;
             range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
                              (ct3d->hostpmem->size & 0xF0000000);
+        } else if (ct3d->dc.host_dc) {
+            range2_size_hi = ct3d->dc.host_dc->size >> 32;
+            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
+                             (ct3d->dc.host_dc->size & 0xF0000000);
         }
-    } else {
+    } else if (ct3d->hostpmem) {
         range1_size_hi = ct3d->hostpmem->size >> 32;
         range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
                          (ct3d->hostpmem->size & 0xF0000000);
+        if (ct3d->dc.host_dc) {
+            range2_size_hi = ct3d->dc.host_dc->size >> 32;
+            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
+                             (ct3d->dc.host_dc->size & 0xF0000000);
+        }
+    } else {
+        range1_size_hi = ct3d->dc.host_dc->size >> 32;
+        range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
+            (ct3d->dc.host_dc->size & 0xF0000000);
     }
 
     dvsec = (uint8_t *)&(CXLDVSECDevice){
@@ -721,6 +781,9 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
     }
 }
 
+/*
+ * TODO: region parameters are hard coded, may need to change in the future.
+ */
 static int cxl_create_dc_regions(CXLType3Dev *ct3d)
 {
     int i;
@@ -736,6 +799,7 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d)
     if (ct3d->hostpmem) {
         region_base += ct3d->hostpmem->size;
     }
+
     for (i = 0; i < ct3d->dc.num_regions; i++) {
         region = &ct3d->dc.regions[i];
         region->base = region_base;
@@ -755,7 +819,8 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
 
-    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem) {
+    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
+            && !ct3d->dc.num_regions) {
         error_setg(errp, "at least one memdev property must be set");
         return false;
     } else if (ct3d->hostmem && ct3d->hostpmem) {
@@ -823,6 +888,50 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         return false;
     }
 
+    ct3d->dc.total_capacity = 0;
+    if (ct3d->dc.host_dc) {
+        MemoryRegion *dc_mr;
+        char *dc_name;
+        uint64_t total_region_size = 0;
+        int i;
+
+        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        if (!dc_mr) {
+            error_setg(errp, "dynamic capacity must have backing device");
+            return false;
+        }
+        /* FIXME: set dc as nonvolatile for now */
+        memory_region_set_nonvolatile(dc_mr, true);
+        memory_region_set_enabled(dc_mr, true);
+        host_memory_backend_set_mapped(ct3d->dc.host_dc, true);
+        if (ds->id) {
+            dc_name = g_strdup_printf("cxl-dcd-dpa-dc-space:%s", ds->id);
+        } else {
+            dc_name = g_strdup("cxl-dcd-dpa-dc-space");
+        }
+        address_space_init(&ct3d->dc.host_dc_as, dc_mr, dc_name);
+        g_free(dc_name);
+
+        for (i = 0; i < ct3d->dc.num_regions; i++) {
+            total_region_size += ct3d->dc.regions[i].len;
+        }
+        /* Make sure the host backend is large enough to cover all dc range */
+        if (total_region_size > memory_region_size(dc_mr)) {
+            error_setg(errp,
+                "too small host backend size, increase to %lu MiB or more",
+                total_region_size / MiB);
+            return false;
+        }
+
+        if (dc_mr->size % CXL_CAPACITY_MULTIPLIER != 0) {
+            error_setg(errp, "DC region size is unaligned to %lx",
+                    CXL_CAPACITY_MULTIPLIER);
+            return false;
+        }
+
+        ct3d->dc.total_capacity = total_region_size;
+    }
+
     return true;
 }
 
@@ -933,6 +1042,9 @@ err_release_cdat:
 err_free_special_ops:
     g_free(regs->special_ops);
 err_address_space_free:
+    if (ct3d->dc.host_dc) {
+        address_space_destroy(&ct3d->dc.host_dc_as);
+    }
     if (ct3d->hostpmem) {
         address_space_destroy(&ct3d->hostpmem_as);
     }
@@ -952,6 +1064,9 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     spdm_sock_fini(ct3d->doe_spdm.socket);
     g_free(regs->special_ops);
+    if (ct3d->dc.host_dc) {
+        address_space_destroy(&ct3d->dc.host_dc_as);
+    }
     if (ct3d->hostpmem) {
         address_space_destroy(&ct3d->hostpmem_as);
     }
@@ -1025,16 +1140,24 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
                                        AddressSpace **as,
                                        uint64_t *dpa_offset)
 {
-    MemoryRegion *vmr = NULL, *pmr = NULL;
+    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
+    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
 
     if (ct3d->hostvmem) {
         vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+        vmr_size = memory_region_size(vmr);
     }
     if (ct3d->hostpmem) {
         pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+        pmr_size = memory_region_size(pmr);
+    }
+    if (ct3d->dc.host_dc) {
+        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        /* Do we want dc_size to be dc_mr->size or not?? */
+        dc_size = ct3d->dc.total_capacity;
     }
 
-    if (!vmr && !pmr) {
+    if (!vmr && !pmr && !dc_mr) {
         return -ENODEV;
     }
 
@@ -1042,19 +1165,18 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
         return -EINVAL;
     }
 
-    if (*dpa_offset > ct3d->cxl_dstate.static_mem_size) {
+    if (*dpa_offset >= vmr_size + pmr_size + dc_size) {
         return -EINVAL;
     }
 
-    if (vmr) {
-        if (*dpa_offset < memory_region_size(vmr)) {
-            *as = &ct3d->hostvmem_as;
-        } else {
-            *as = &ct3d->hostpmem_as;
-            *dpa_offset -= memory_region_size(vmr);
-        }
-    } else {
+    if (*dpa_offset < vmr_size) {
+        *as = &ct3d->hostvmem_as;
+    } else if (*dpa_offset < vmr_size + pmr_size) {
         *as = &ct3d->hostpmem_as;
+        *dpa_offset -= vmr_size;
+    } else {
+        *as = &ct3d->dc.host_dc_as;
+        *dpa_offset -= (vmr_size + pmr_size);
     }
 
     return 0;
@@ -1143,6 +1265,8 @@ static Property ct3_props[] = {
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
     DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
+    DEFINE_PROP_LINK("nonvolatile-dc-memdev", CXLType3Dev, dc.host_dc,
+                    TYPE_MEMORY_BACKEND, HostMemoryBackend *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1209,33 +1333,39 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
 
 static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
 {
-    MemoryRegion *vmr = NULL, *pmr = NULL;
+    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
     AddressSpace *as;
+    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
 
     if (ct3d->hostvmem) {
         vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+        vmr_size = memory_region_size(vmr);
     }
     if (ct3d->hostpmem) {
         pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+        pmr_size = memory_region_size(pmr);
     }
+    if (ct3d->dc.host_dc) {
+        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        dc_size = ct3d->dc.total_capacity;
+     }
 
-    if (!vmr && !pmr) {
+    if (!vmr && !pmr && !dc_mr) {
         return false;
     }
 
-    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.static_mem_size) {
+    if (dpa_offset + CXL_CACHE_LINE_SIZE > vmr_size + pmr_size + dc_size) {
         return false;
     }
 
-    if (vmr) {
-        if (dpa_offset < memory_region_size(vmr)) {
-            as = &ct3d->hostvmem_as;
-        } else {
-            as = &ct3d->hostpmem_as;
-            dpa_offset -= memory_region_size(vmr);
-        }
-    } else {
+    if (dpa_offset < vmr_size) {
+        as = &ct3d->hostvmem_as;
+    } else if (dpa_offset < vmr_size + pmr_size) {
         as = &ct3d->hostpmem_as;
+        dpa_offset -= vmr_size;
+    } else {
+        as = &ct3d->dc.host_dc_as;
+        dpa_offset -= (vmr_size + pmr_size);
     }
 
     address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index de6469eef7..3dc6928bc5 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -467,6 +467,10 @@ struct CXLType3Dev {
     uint64_t poison_list_overflow_ts;
 
     struct dynamic_capacity {
+        HostMemoryBackend *host_dc;
+        AddressSpace host_dc_as;
+        uint64_t total_capacity; /* 256M aligned */
+
         uint8_t num_regions; /* 0-8 regions */
         CXLDCDRegion regions[DCD_MAX_REGION_NUM];
     } dc;
-- 
2.42.0


