Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C0D709AA5
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:57:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Rp-0001ez-7c; Fri, 19 May 2023 10:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Re-0001Jo-Hy
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01RR-0003bA-4U
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4U/14sfZhlFfC8BaIVkdltDJxltfSQtXgLnD2+kk0Jc=;
 b=WX1Zn7bgGRrmIZn3nMqQnF/JpYEh+O2wsbmwOmMFm+Bqxfi1jyjsmGX+EmC8dkH0kw+Ish
 NuHjxxtdgkulK2+sS7JWiUb9JJ8Z23J1XIN7c5e3VW/W+qrFbP2w61+MK/AaUswv00mYyo
 tODpBWMhMyFfkFfMBA9KwBkk557B+R8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-MxyCz0WKN1eUFh93qx-l7w-1; Fri, 19 May 2023 10:50:47 -0400
X-MC-Unique: MxyCz0WKN1eUFh93qx-l7w-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f26157450aso2219742e87.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507845; x=1687099845;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4U/14sfZhlFfC8BaIVkdltDJxltfSQtXgLnD2+kk0Jc=;
 b=L7fXmsETCM8appkc2nYh/yWaUoZYWlG5syhVXYAbyTGJxy+7PWSxsdoEf4WVm3Z94T
 lTdbqgXJ0ZBT+crHmV3+DT/9cmXLWijGDJYZGXElBl+CZtFKLXNL8sfSKX6jNLAVfS+E
 JrV2J3b/PDVeq2Wt083XYYK+NvxOIwzJESOI8BOLyy4UcDpQl2ONAp2gnTbCbxiwtBue
 fF2TBV/9X6qRdVYAM3+UUMcJUeqPF1Y2ij6mYlm8b2pv6gSbY1YaSgkaRyGCbiSVDqcM
 k+10LPQmQepzQJB0qXWkBWzxxdIf/GO0XYLjPjjX3y7ljHbMm1BuVYoBis+Zje9sizLu
 0Pjg==
X-Gm-Message-State: AC+VfDzwPctHM8SW5gKOvxC4U/3BZukfMvoUlg2/Z0m7Nur1y3qf38YV
 EY011SHfKFD1jFjZrVf3mq1E0f8shztBQ8Brz7nwAFmu9k5rGn9RgwlrpM+zxLTKS3mC5dmAU7j
 Bg9X2sy5KjG6C2ngPDCmeD6bbyD+7fIV+1X4/d3VJ4nNNBP+OKy3iQlLutJe3NmQSFovh
X-Received: by 2002:ac2:5298:0:b0:4f3:b1dc:b46b with SMTP id
 q24-20020ac25298000000b004f3b1dcb46bmr427034lfm.1.1684507844719; 
 Fri, 19 May 2023 07:50:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4aF194ASQYfgYz3pBdbvbdO2j6zPHcwBCWYfEJ3cho4nQtZ3kWa3qXWLLTDn01Sc3ls9WSoQ==
X-Received: by 2002:ac2:5298:0:b0:4f3:b1dc:b46b with SMTP id
 q24-20020ac25298000000b004f3b1dcb46bmr427011lfm.1.1684507844022; 
 Fri, 19 May 2023 07:50:44 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 u3-20020ac25183000000b004f13ca69dc8sm631164lfi.72.2023.05.19.07.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:50:43 -0700 (PDT)
Date: Fri, 19 May 2023 10:50:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gregory.price@memverge.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 libvir-list@redhat.com, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 12/40] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile and
 Persistent)
Message-ID: <adacc814f541af9281c922e750d8ba4b90c1a73e.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Gregory Price <gregory.price@memverge.com>

This commit enables each CXL Type-3 device to contain one volatile
memory region and one persistent region.

Two new properties have been added to cxl-type3 device initialization:
    [volatile-memdev] and [persistent-memdev]

The existing [memdev] property has been deprecated and will default the
memory region to a persistent memory region (although a user may assign
the region to a ram or file backed region). It cannot be used in
combination with the new [persistent-memdev] property.

Partitioning volatile memory from persistent memory is not yet supported.

Volatile memory is mapped at DPA(0x0), while Persistent memory is mapped
at DPA(vmem->size), per CXL Spec 8.2.9.8.2.0 - Get Partition Info.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Message-Id: <20230421160827.2227-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h    |  11 +-
 hw/cxl/cxl-mailbox-utils.c     |  32 ++--
 hw/mem/cxl_type3.c             | 306 ++++++++++++++++++++++++---------
 tests/qtest/bios-tables-test.c |   8 +-
 tests/qtest/cxl-test.c         |  76 ++++++--
 docs/about/deprecated.rst      |   8 +
 docs/system/devices/cxl.rst    |  49 ++++--
 7 files changed, 371 insertions(+), 119 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index d589f78202..edb9791bab 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -119,8 +119,10 @@ typedef struct cxl_device_state {
         uint64_t host_set;
     } timestamp;
 
-    /* memory region for persistent memory, HDM */
+    /* memory region size, HDM */
+    uint64_t mem_size;
     uint64_t pmem_size;
+    uint64_t vmem_size;
 } CXLDeviceState;
 
 /* Initialize the register block for a device */
@@ -245,12 +247,15 @@ struct CXLType3Dev {
     PCIDevice parent_obj;
 
     /* Properties */
-    HostMemoryBackend *hostmem;
+    HostMemoryBackend *hostmem; /* deprecated */
+    HostMemoryBackend *hostvmem;
+    HostMemoryBackend *hostpmem;
     HostMemoryBackend *lsa;
     uint64_t sn;
 
     /* State */
-    AddressSpace hostmem_as;
+    AddressSpace hostvmem_as;
+    AddressSpace hostpmem_as;
     CXLComponentState cxl_cstate;
     CXLDeviceState cxl_dstate;
 
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 206e04a4b8..ed663cc04a 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -141,7 +141,8 @@ static ret_code cmd_firmware_update_get_info(struct cxl_cmd *cmd,
     } QEMU_PACKED *fw_info;
     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
 
-    if (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) {
+    if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
+        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -288,21 +289,21 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
 
     CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
-    uint64_t size = cxl_dstate->pmem_size;
 
-    if (!QEMU_IS_ALIGNED(size, CXL_CAPACITY_MULTIPLIER)) {
+    if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
     id = (void *)cmd->payload;
     memset(id, 0, sizeof(*id));
 
-    /* PMEM only */
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
 
-    id->total_capacity = size / CXL_CAPACITY_MULTIPLIER;
-    id->persistent_capacity = size / CXL_CAPACITY_MULTIPLIER;
-    id->lsa_size = cvc->get_lsa_size(ct3d);
+    stq_le_p(&id->total_capacity, cxl_dstate->mem_size / CXL_CAPACITY_MULTIPLIER);
+    stq_le_p(&id->persistent_capacity, cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
+    stq_le_p(&id->volatile_capacity, cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
+    stl_le_p(&id->lsa_size, cvc->get_lsa_size(ct3d));
 
     *len = sizeof(*id);
     return CXL_MBOX_SUCCESS;
@@ -319,17 +320,20 @@ static ret_code cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
         uint64_t next_pmem;
     } QEMU_PACKED *part_info = (void *)cmd->payload;
     QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
-    uint64_t size = cxl_dstate->pmem_size;
 
-    if (!QEMU_IS_ALIGNED(size, CXL_CAPACITY_MULTIPLIER)) {
+    if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
-    /* PMEM only */
-    part_info->active_vmem = 0;
-    part_info->next_vmem = 0;
-    part_info->active_pmem = size / CXL_CAPACITY_MULTIPLIER;
-    part_info->next_pmem = 0;
+    stq_le_p(&part_info->active_vmem, cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
+    /*
+     * When both next_vmem and next_pmem are 0, there is no pending change to
+     * partitioning.
+     */
+    stq_le_p(&part_info->next_vmem, 0);
+    stq_le_p(&part_info->active_pmem, cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
+    stq_le_p(&part_info->next_pmem, 0);
 
     *len = sizeof(*part_info);
     return CXL_MBOX_SUCCESS;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 2db756851c..2adacbd01b 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -31,7 +31,8 @@ enum {
 };
 
 static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
-                                         int dsmad_handle, MemoryRegion *mr)
+                                         int dsmad_handle, MemoryRegion *mr,
+                                         bool is_pmem, uint64_t dpa_base)
 {
     g_autofree CDATDsmas *dsmas = NULL;
     g_autofree CDATDslbis *dslbis0 = NULL;
@@ -50,8 +51,8 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
             .length = sizeof(*dsmas),
         },
         .DSMADhandle = dsmad_handle,
-        .flags = CDAT_DSMAS_FLAG_NV,
-        .DPA_base = 0,
+        .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
+        .DPA_base = dpa_base,
         .DPA_length = memory_region_size(mr),
     };
 
@@ -130,8 +131,11 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
             .length = sizeof(*dsemts),
         },
         .DSMAS_handle = dsmad_handle,
-        /* Reserved - the non volatile from DSMAS matters */
-        .EFI_memory_type_attr = 2,
+        /*
+         * NV: Reserved - the non volatile from DSMAS matters
+         * V: EFI_MEMORY_SP
+         */
+        .EFI_memory_type_attr = is_pmem ? 2 : 1,
         .DPA_offset = 0,
         .DPA_length = memory_region_size(mr),
     };
@@ -150,33 +154,68 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
 static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
 {
     g_autofree CDATSubHeader **table = NULL;
-    MemoryRegion *nonvolatile_mr;
     CXLType3Dev *ct3d = priv;
+    MemoryRegion *volatile_mr = NULL, *nonvolatile_mr = NULL;
     int dsmad_handle = 0;
-    int rc;
+    int cur_ent = 0;
+    int len = 0;
+    int rc, i;
 
-    if (!ct3d->hostmem) {
+    if (!ct3d->hostpmem && !ct3d->hostvmem) {
         return 0;
     }
 
-    nonvolatile_mr = host_memory_backend_get_memory(ct3d->hostmem);
-    if (!nonvolatile_mr) {
-        return -EINVAL;
+    if (ct3d->hostvmem) {
+        volatile_mr = host_memory_backend_get_memory(ct3d->hostvmem);
+        if (!volatile_mr) {
+            return -EINVAL;
+        }
+        len += CT3_CDAT_NUM_ENTRIES;
     }
 
-    table = g_malloc0(CT3_CDAT_NUM_ENTRIES * sizeof(*table));
+    if (ct3d->hostpmem) {
+        nonvolatile_mr = host_memory_backend_get_memory(ct3d->hostpmem);
+        if (!nonvolatile_mr) {
+            return -EINVAL;
+        }
+        len += CT3_CDAT_NUM_ENTRIES;
+    }
+
+    table = g_malloc0(len * sizeof(*table));
     if (!table) {
         return -ENOMEM;
     }
 
-    rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, nonvolatile_mr);
-    if (rc < 0) {
-        return rc;
+    /* Now fill them in */
+    if (volatile_mr) {
+        rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
+                                           false, 0);
+        if (rc < 0) {
+            return rc;
+        }
+        cur_ent = CT3_CDAT_NUM_ENTRIES;
     }
 
+    if (nonvolatile_mr) {
+        rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
+                                           nonvolatile_mr, true,
+                                           (volatile_mr ?
+                                            memory_region_size(volatile_mr) : 0));
+        if (rc < 0) {
+            goto error_cleanup;
+        }
+        cur_ent += CT3_CDAT_NUM_ENTRIES;
+    }
+    assert(len == cur_ent);
+
     *cdat_table = g_steal_pointer(&table);
 
-    return CT3_CDAT_NUM_ENTRIES;
+    return len;
+error_cleanup:
+    for (i = 0; i < cur_ent; i++) {
+        g_free(table[i]);
+    }
+    return rc;
 }
 
 static void ct3_free_cdat_table(CDATSubHeader **cdat_table, int num, void *priv)
@@ -264,16 +303,42 @@ static void build_dvsecs(CXLType3Dev *ct3d)
 {
     CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
     uint8_t *dvsec;
+    uint32_t range1_size_hi, range1_size_lo,
+             range1_base_hi = 0, range1_base_lo = 0,
+             range2_size_hi = 0, range2_size_lo = 0,
+             range2_base_hi = 0, range2_base_lo = 0;
+
+    /*
+     * Volatile memory is mapped as (0x0)
+     * Persistent memory is mapped at (volatile->size)
+     */
+    if (ct3d->hostvmem) {
+        range1_size_hi = ct3d->hostvmem->size >> 32;
+        range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
+                         (ct3d->hostvmem->size & 0xF0000000);
+        if (ct3d->hostpmem) {
+            range2_size_hi = ct3d->hostpmem->size >> 32;
+            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
+                             (ct3d->hostpmem->size & 0xF0000000);
+        }
+    } else {
+        range1_size_hi = ct3d->hostpmem->size >> 32;
+        range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
+                         (ct3d->hostpmem->size & 0xF0000000);
+    }
 
     dvsec = (uint8_t *)&(CXLDVSECDevice){
         .cap = 0x1e,
         .ctrl = 0x2,
         .status2 = 0x2,
-        .range1_size_hi = ct3d->hostmem->size >> 32,
-        .range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
-        (ct3d->hostmem->size & 0xF0000000),
-        .range1_base_hi = 0,
-        .range1_base_lo = 0,
+        .range1_size_hi = range1_size_hi,
+        .range1_size_lo = range1_size_lo,
+        .range1_base_hi = range1_base_hi,
+        .range1_base_lo = range1_base_lo,
+        .range2_size_hi = range2_size_hi,
+        .range2_size_lo = range2_size_lo,
+        .range2_base_hi = range2_base_hi,
+        .range2_base_lo = range2_base_lo,
     };
     cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
                                PCIE_CXL_DEVICE_DVSEC_LENGTH,
@@ -514,36 +579,69 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
-    MemoryRegion *mr;
-    char *name;
 
-    if (!ct3d->hostmem) {
-        error_setg(errp, "memdev property must be set");
+    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem) {
+        error_setg(errp, "at least one memdev property must be set");
+        return false;
+    } else if (ct3d->hostmem && ct3d->hostpmem) {
+        error_setg(errp, "[memdev] cannot be used with new "
+                         "[persistent-memdev] property");
+        return false;
+    } else if (ct3d->hostmem) {
+        /* Use of hostmem property implies pmem */
+        ct3d->hostpmem = ct3d->hostmem;
+        ct3d->hostmem = NULL;
+    }
+
+    if (ct3d->hostpmem && !ct3d->lsa) {
+        error_setg(errp, "lsa property must be set for persistent devices");
         return false;
     }
 
-    mr = host_memory_backend_get_memory(ct3d->hostmem);
-    if (!mr) {
-        error_setg(errp, "memdev property must be set");
-        return false;
+    if (ct3d->hostvmem) {
+        MemoryRegion *vmr;
+        char *v_name;
+
+        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+        if (!vmr) {
+            error_setg(errp, "volatile memdev must have backing device");
+            return false;
+        }
+        memory_region_set_nonvolatile(vmr, false);
+        memory_region_set_enabled(vmr, true);
+        host_memory_backend_set_mapped(ct3d->hostvmem, true);
+        if (ds->id) {
+            v_name = g_strdup_printf("cxl-type3-dpa-vmem-space:%s", ds->id);
+        } else {
+            v_name = g_strdup("cxl-type3-dpa-vmem-space");
+        }
+        address_space_init(&ct3d->hostvmem_as, vmr, v_name);
+        ct3d->cxl_dstate.vmem_size = memory_region_size(vmr);
+        ct3d->cxl_dstate.mem_size += memory_region_size(vmr);
+        g_free(v_name);
     }
-    memory_region_set_nonvolatile(mr, true);
-    memory_region_set_enabled(mr, true);
-    host_memory_backend_set_mapped(ct3d->hostmem, true);
 
-    if (ds->id) {
-        name = g_strdup_printf("cxl-type3-dpa-space:%s", ds->id);
-    } else {
-        name = g_strdup("cxl-type3-dpa-space");
-    }
-    address_space_init(&ct3d->hostmem_as, mr, name);
-    g_free(name);
+    if (ct3d->hostpmem) {
+        MemoryRegion *pmr;
+        char *p_name;
 
-    ct3d->cxl_dstate.pmem_size = ct3d->hostmem->size;
-
-    if (!ct3d->lsa) {
-        error_setg(errp, "lsa property must be set");
-        return false;
+        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+        if (!pmr) {
+            error_setg(errp, "persistent memdev must have backing device");
+            return false;
+        }
+        memory_region_set_nonvolatile(pmr, true);
+        memory_region_set_enabled(pmr, true);
+        host_memory_backend_set_mapped(ct3d->hostpmem, true);
+        if (ds->id) {
+            p_name = g_strdup_printf("cxl-type3-dpa-pmem-space:%s", ds->id);
+        } else {
+            p_name = g_strdup("cxl-type3-dpa-pmem-space");
+        }
+        address_space_init(&ct3d->hostpmem_as, pmr, p_name);
+        ct3d->cxl_dstate.pmem_size = memory_region_size(pmr);
+        ct3d->cxl_dstate.mem_size += memory_region_size(pmr);
+        g_free(p_name);
     }
 
     return true;
@@ -633,7 +731,12 @@ err_release_cdat:
 err_free_special_ops:
     g_free(regs->special_ops);
 err_address_space_free:
-    address_space_destroy(&ct3d->hostmem_as);
+    if (ct3d->hostpmem) {
+        address_space_destroy(&ct3d->hostpmem_as);
+    }
+    if (ct3d->hostvmem) {
+        address_space_destroy(&ct3d->hostvmem_as);
+    }
     return;
 }
 
@@ -646,7 +749,12 @@ static void ct3_exit(PCIDevice *pci_dev)
     pcie_aer_exit(pci_dev);
     cxl_doe_cdat_release(cxl_cstate);
     g_free(regs->special_ops);
-    address_space_destroy(&ct3d->hostmem_as);
+    if (ct3d->hostpmem) {
+        address_space_destroy(&ct3d->hostpmem_as);
+    }
+    if (ct3d->hostvmem) {
+        address_space_destroy(&ct3d->hostvmem_as);
+    }
 }
 
 /* TODO: Support multiple HDM decoders and DPA skip */
@@ -681,51 +789,77 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
     return true;
 }
 
+static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
+                                       hwaddr host_addr,
+                                       unsigned int size,
+                                       AddressSpace **as,
+                                       uint64_t *dpa_offset)
+{
+    MemoryRegion *vmr = NULL, *pmr = NULL;
+
+    if (ct3d->hostvmem) {
+        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+    }
+    if (ct3d->hostpmem) {
+        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+    }
+
+    if (!vmr && !pmr) {
+        return -ENODEV;
+    }
+
+    if (!cxl_type3_dpa(ct3d, host_addr, dpa_offset)) {
+        return -EINVAL;
+    }
+
+    if (*dpa_offset > ct3d->cxl_dstate.mem_size) {
+        return -EINVAL;
+    }
+
+    if (vmr) {
+        if (*dpa_offset < memory_region_size(vmr)) {
+            *as = &ct3d->hostvmem_as;
+        } else {
+            *as = &ct3d->hostpmem_as;
+            *dpa_offset -= memory_region_size(vmr);
+        }
+    } else {
+        *as = &ct3d->hostpmem_as;
+    }
+
+    return 0;
+}
+
 MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
                            unsigned size, MemTxAttrs attrs)
 {
-    CXLType3Dev *ct3d = CXL_TYPE3(d);
-    uint64_t dpa_offset;
-    MemoryRegion *mr;
+    uint64_t dpa_offset = 0;
+    AddressSpace *as = NULL;
+    int res;
 
-    /* TODO support volatile region */
-    mr = host_memory_backend_get_memory(ct3d->hostmem);
-    if (!mr) {
+    res = cxl_type3_hpa_to_as_and_dpa(CXL_TYPE3(d), host_addr, size,
+                                      &as, &dpa_offset);
+    if (res) {
         return MEMTX_ERROR;
     }
 
-    if (!cxl_type3_dpa(ct3d, host_addr, &dpa_offset)) {
-        return MEMTX_ERROR;
-    }
-
-    if (dpa_offset > memory_region_size(mr)) {
-        return MEMTX_ERROR;
-    }
-
-    return address_space_read(&ct3d->hostmem_as, dpa_offset, attrs, data, size);
+    return address_space_read(as, dpa_offset, attrs, data, size);
 }
 
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
                             unsigned size, MemTxAttrs attrs)
 {
-    CXLType3Dev *ct3d = CXL_TYPE3(d);
-    uint64_t dpa_offset;
-    MemoryRegion *mr;
+    uint64_t dpa_offset = 0;
+    AddressSpace *as = NULL;
+    int res;
 
-    mr = host_memory_backend_get_memory(ct3d->hostmem);
-    if (!mr) {
-        return MEMTX_OK;
+    res = cxl_type3_hpa_to_as_and_dpa(CXL_TYPE3(d), host_addr, size,
+                                      &as, &dpa_offset);
+    if (res) {
+        return MEMTX_ERROR;
     }
 
-    if (!cxl_type3_dpa(ct3d, host_addr, &dpa_offset)) {
-        return MEMTX_OK;
-    }
-
-    if (dpa_offset > memory_region_size(mr)) {
-        return MEMTX_OK;
-    }
-    return address_space_write(&ct3d->hostmem_as, dpa_offset, attrs,
-                               &data, size);
+    return address_space_write(as, dpa_offset, attrs, &data, size);
 }
 
 static void ct3d_reset(DeviceState *dev)
@@ -740,7 +874,11 @@ static void ct3d_reset(DeviceState *dev)
 
 static Property ct3_props[] = {
     DEFINE_PROP_LINK("memdev", CXLType3Dev, hostmem, TYPE_MEMORY_BACKEND,
-                     HostMemoryBackend *),
+                     HostMemoryBackend *), /* for backward compatibility */
+    DEFINE_PROP_LINK("persistent-memdev", CXLType3Dev, hostpmem,
+                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
+    DEFINE_PROP_LINK("volatile-memdev", CXLType3Dev, hostvmem,
+                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
     DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *),
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
@@ -752,6 +890,10 @@ static uint64_t get_lsa_size(CXLType3Dev *ct3d)
 {
     MemoryRegion *mr;
 
+    if (!ct3d->lsa) {
+        return 0;
+    }
+
     mr = host_memory_backend_get_memory(ct3d->lsa);
     return memory_region_size(mr);
 }
@@ -769,6 +911,10 @@ static uint64_t get_lsa(CXLType3Dev *ct3d, void *buf, uint64_t size,
     MemoryRegion *mr;
     void *lsa;
 
+    if (!ct3d->lsa) {
+        return 0;
+    }
+
     mr = host_memory_backend_get_memory(ct3d->lsa);
     validate_lsa_access(mr, size, offset);
 
@@ -784,6 +930,10 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
     MemoryRegion *mr;
     void *lsa;
 
+    if (!ct3d->lsa) {
+        return;
+    }
+
     mr = host_memory_backend_get_memory(ct3d->lsa);
     validate_lsa_access(mr, size, offset);
 
@@ -955,7 +1105,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     pc->config_read = ct3d_config_read;
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->desc = "CXL PMEM Device (Type 3)";
+    dc->desc = "CXL Memory Device (Type 3)";
     dc->reset = ct3d_reset;
     device_class_set_props(dc, ct3_props);
 
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 7fd88b0e9c..159e4edb8f 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1867,13 +1867,13 @@ static void test_acpi_q35_cxl(void)
                              " -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1"
                              " -device pxb-cxl,bus_nr=222,bus=pcie.0,id=cxl.2"
                              " -device cxl-rp,port=0,bus=cxl.1,id=rp1,chassis=0,slot=2"
-                             " -device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1"
+                             " -device cxl-type3,bus=rp1,persistent-memdev=cxl-mem1,lsa=lsa1"
                              " -device cxl-rp,port=1,bus=cxl.1,id=rp2,chassis=0,slot=3"
-                             " -device cxl-type3,bus=rp2,memdev=cxl-mem2,lsa=lsa2"
+                             " -device cxl-type3,bus=rp2,persistent-memdev=cxl-mem2,lsa=lsa2"
                              " -device cxl-rp,port=0,bus=cxl.2,id=rp3,chassis=0,slot=5"
-                             " -device cxl-type3,bus=rp3,memdev=cxl-mem3,lsa=lsa3"
+                             " -device cxl-type3,bus=rp3,persistent-memdev=cxl-mem3,lsa=lsa3"
                              " -device cxl-rp,port=1,bus=cxl.2,id=rp4,chassis=0,slot=6"
-                             " -device cxl-type3,bus=rp4,memdev=cxl-mem4,lsa=lsa4"
+                             " -device cxl-type3,bus=rp4,persistent-memdev=cxl-mem4,lsa=lsa4"
                              " -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k,"
                              "cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.targets.1=cxl.2,cxl-fmw.1.size=4G,cxl-fmw.1.interleave-granularity=8k",
                              tmp_path, tmp_path, tmp_path, tmp_path,
diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
index eda2bbbbe6..edcad4a0ce 100644
--- a/tests/qtest/cxl-test.c
+++ b/tests/qtest/cxl-test.c
@@ -34,32 +34,46 @@
     "-device cxl-rp,id=rp2,bus=cxl.1,chassis=0,slot=2 " \
     "-device cxl-rp,id=rp3,bus=cxl.1,chassis=0,slot=3 "
 
-#define QEMU_T3D \
+#define QEMU_T3D_DEPRECATED \
     "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
     "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
     "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 "
 
+#define QEMU_T3D_PMEM \
+    "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
+    "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
+    "-device cxl-type3,bus=rp0,persistent-memdev=cxl-mem0,lsa=lsa0,id=pmem0 "
+
+#define QEMU_T3D_VMEM \
+    "-object memory-backend-ram,id=cxl-mem0,size=256M " \
+    "-device cxl-type3,bus=rp0,volatile-memdev=cxl-mem0,id=mem0 "
+
+#define QEMU_T3D_VMEM_LSA \
+    "-object memory-backend-ram,id=cxl-mem0,size=256M " \
+    "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
+    "-device cxl-type3,bus=rp0,volatile-memdev=cxl-mem0,lsa=lsa0,id=mem0 "
+
 #define QEMU_2T3D \
     "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
     "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
-    "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
+    "-device cxl-type3,bus=rp0,persistent-memdev=cxl-mem0,lsa=lsa0,id=pmem0 " \
     "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M " \
     "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M " \
-    "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 "
+    "-device cxl-type3,bus=rp1,persistent-memdev=cxl-mem1,lsa=lsa1,id=pmem1 "
 
 #define QEMU_4T3D \
     "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
     "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
-    "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
+    "-device cxl-type3,bus=rp0,persistent-memdev=cxl-mem0,lsa=lsa0,id=pmem0 " \
     "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M " \
     "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M " \
-    "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 " \
+    "-device cxl-type3,bus=rp1,persistent-memdev=cxl-mem1,lsa=lsa1,id=pmem1 " \
     "-object memory-backend-file,id=cxl-mem2,mem-path=%s,size=256M " \
     "-object memory-backend-file,id=lsa2,mem-path=%s,size=256M " \
-    "-device cxl-type3,bus=rp2,memdev=cxl-mem2,lsa=lsa2,id=cxl-pmem2 " \
+    "-device cxl-type3,bus=rp2,persistent-memdev=cxl-mem2,lsa=lsa2,id=pmem2 " \
     "-object memory-backend-file,id=cxl-mem3,mem-path=%s,size=256M " \
     "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M " \
-    "-device cxl-type3,bus=rp3,memdev=cxl-mem3,lsa=lsa3,id=cxl-pmem3 "
+    "-device cxl-type3,bus=rp3,persistent-memdev=cxl-mem3,lsa=lsa3,id=pmem3 "
 
 static void cxl_basic_hb(void)
 {
@@ -98,14 +112,53 @@ static void cxl_2root_port(void)
 }
 
 #ifdef CONFIG_POSIX
-static void cxl_t3d(void)
+static void cxl_t3d_deprecated(void)
 {
     g_autoptr(GString) cmdline = g_string_new(NULL);
     g_autofree const char *tmpfs = NULL;
 
     tmpfs = g_dir_make_tmp("cxl-test-XXXXXX", NULL);
 
-    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D, tmpfs, tmpfs);
+    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D_DEPRECATED,
+                    tmpfs, tmpfs);
+
+    qtest_start(cmdline->str);
+    qtest_end();
+}
+
+static void cxl_t3d_persistent(void)
+{
+    g_autoptr(GString) cmdline = g_string_new(NULL);
+    g_autofree const char *tmpfs = NULL;
+
+    tmpfs = g_dir_make_tmp("cxl-test-XXXXXX", NULL);
+
+    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D_PMEM,
+                    tmpfs, tmpfs);
+
+    qtest_start(cmdline->str);
+    qtest_end();
+}
+
+static void cxl_t3d_volatile(void)
+{
+    g_autoptr(GString) cmdline = g_string_new(NULL);
+
+    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D_VMEM);
+
+    qtest_start(cmdline->str);
+    qtest_end();
+}
+
+static void cxl_t3d_volatile_lsa(void)
+{
+    g_autoptr(GString) cmdline = g_string_new(NULL);
+    g_autofree const char *tmpfs = NULL;
+
+    tmpfs = g_dir_make_tmp("cxl-test-XXXXXX", NULL);
+
+    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D_VMEM_LSA,
+                    tmpfs);
 
     qtest_start(cmdline->str);
     qtest_end();
@@ -155,7 +208,10 @@ int main(int argc, char **argv)
     qtest_add_func("/pci/cxl/rp", cxl_root_port);
     qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
 #ifdef CONFIG_POSIX
-    qtest_add_func("/pci/cxl/type3_device", cxl_t3d);
+    qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
+    qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
+    qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
+    qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatile_lsa);
     qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
     qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4", cxl_2pxb_4rp_4t3d);
 #endif
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 7bb4d2f4f6..e934e0a13a 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -328,6 +328,14 @@ from Intel that was not properly allocated. Since version 5.2, the controller
 has used a properly allocated identifier. Deprecate the ``use-intel-id``
 machine compatibility parameter.
 
+``-device cxl-type3,memdev=xxxx`` (since 8.0)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``cxl-type3`` device initially only used a single memory backend.  With
+the addition of volatile memory support, it is now necessary to distinguish
+between persistent and volatile memory backends.  As such, memdev is deprecated
+in favor of persistent-memdev.
+
 
 Block device options
 ''''''''''''''''''''
diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 8f2885aba1..f12011e230 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -300,7 +300,7 @@ Example topology involving a switch::
 
 Example command lines
 ---------------------
-A very simple setup with just one directly attached CXL Type 3 device::
+A very simple setup with just one directly attached CXL Type 3 Persistent Memory device::
 
   qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
   ...
@@ -308,7 +308,28 @@ A very simple setup with just one directly attached CXL Type 3 device::
   -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M \
   -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
   -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
-  -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
+  -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
+
+A very simple setup with just one directly attached CXL Type 3 Volatile Memory device::
+
+  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
+  ...
+  -object memory-backend-ram,id=vmem0,share=on,size=256M \
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
+  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
+  -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
+
+The same volatile setup may optionally include an LSA region::
+
+  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
+  ...
+  -object memory-backend-ram,id=vmem0,share=on,size=256M \
+  -object memory-backend-file,id=cxl-lsa0,share=on,mem-path=/tmp/lsa.raw,size=256M \
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
+  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
+  -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,lsa=cxl-lsa0,id=cxl-vmem0 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
 
 A setup suitable for 4 way interleave. Only one fixed window provided, to enable 2 way
@@ -328,13 +349,13 @@ the CXL Type3 device directly attached (no switches).::
   -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
   -device pxb-cxl,bus_nr=222,bus=pcie.0,id=cxl.2 \
   -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
-  -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
+  -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
   -device cxl-rp,port=1,bus=cxl.1,id=root_port14,chassis=0,slot=3 \
-  -device cxl-type3,bus=root_port14,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1 \
+  -device cxl-type3,bus=root_port14,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1 \
   -device cxl-rp,port=0,bus=cxl.2,id=root_port15,chassis=0,slot=5 \
-  -device cxl-type3,bus=root_port15,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2 \
+  -device cxl-type3,bus=root_port15,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2 \
   -device cxl-rp,port=1,bus=cxl.2,id=root_port16,chassis=0,slot=6 \
-  -device cxl-type3,bus=root_port16,memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3 \
+  -device cxl-type3,bus=root_port16,persistent-memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.targets.1=cxl.2,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k
 
 An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
@@ -354,15 +375,23 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
   -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
   -device cxl-upstream,bus=root_port0,id=us0 \
   -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
-  -device cxl-type3,bus=swport0,memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0 \
+  -device cxl-type3,bus=swport0,persistent-memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0 \
   -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
-  -device cxl-type3,bus=swport1,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1 \
+  -device cxl-type3,bus=swport1,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1 \
   -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
-  -device cxl-type3,bus=swport2,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2 \
+  -device cxl-type3,bus=swport2,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2 \
   -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
-  -device cxl-type3,bus=swport3,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3 \
+  -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
 
+Deprecations
+------------
+
+The Type 3 device [memdev] attribute has been deprecated in favor of the
+[persistent-memdev] attributes. [memdev] will default to a persistent memory
+device for backward compatibility and is incapable of being used in combination
+with [persistent-memdev].
+
 Kernel Configuration Options
 ----------------------------
 
-- 
MST


