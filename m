Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C9A7A5F92
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:31:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiY0O-00035w-Pu; Tue, 19 Sep 2023 06:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiY08-00033J-59
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiY03-0001si-4k
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695119433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hc1ldNwm9nx2Mjv6ubA2UVpq3V+HAMD7CrTALFMXrkM=;
 b=gEEB+FL+6PIGkAzKftxq+t3BYDWdMlUyXGue6NrhX/aO88QZWQumaEH+zXCWTWIHk3yulb
 3vXDs50EcK8nGPFXFpdznQQ3GUkf8CZzuFnkLZl5JfVphkOd+8TZJXgmSHEYbCVAF/U74V
 0mKYCpSqpkTmN5tfCE5lzwpIsr0wzj8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-sWBv_YpgOFKvMnr9LmXGcA-1; Tue, 19 Sep 2023 06:30:32 -0400
X-MC-Unique: sWBv_YpgOFKvMnr9LmXGcA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6B0829AB40E
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 10:30:31 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2299E40C6EBF;
 Tue, 19 Sep 2023 10:30:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [GIT PULL 01/12] nvdimm: Reject writing label data to ROM instead of
 crashing QEMU
Date: Tue, 19 Sep 2023 12:30:18 +0200
Message-ID: <20230919103029.235736-2-david@redhat.com>
In-Reply-To: <20230919103029.235736-1-david@redhat.com>
References: <20230919103029.235736-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Currently, when using a true R/O NVDIMM (ROM memory backend) with a label
area, the VM can easily crash QEMU by trying to write to the label area,
because the ROM memory is mmap'ed without PROT_WRITE.

    [root@vm-0 ~]# ndctl disable-region region0
    disabled 1 region
    [root@vm-0 ~]# ndctl zero-labels nmem0
    -> QEMU segfaults

Let's remember whether we have a ROM memory backend and properly
reject the write request:

    [root@vm-0 ~]# ndctl disable-region region0
    disabled 1 region
    [root@vm-0 ~]# ndctl zero-labels nmem0
    zeroed 0 nmem

In comparison, on a system with a R/W NVDIMM:

    [root@vm-0 ~]# ndctl disable-region region0
    disabled 1 region
    [root@vm-0 ~]# ndctl zero-labels nmem0
    zeroed 1 nmem

For ACPI, just return "unsupported", like if no label exists. For spapr,
return "H_P2", similar to when no label area exists.

Could we rely on the "unarmed" property? Maybe, but it looks cleaner to
only disallow what certainly cannot work.

After all "unarmed=on" primarily means: cannot accept persistent writes. In
theory, there might be setups where devices with "unarmed=on" set could
be used to host non-persistent data (temporary files, system RAM, ...); for
example, in Linux, admins can overwrite the "readonly" setting and still
write to the device -- which will work as long as we're not using ROM.
Allowing writing label data in such configurations can make sense.

Message-ID: <20230906120503.359863-2-david@redhat.com>
Fixes: dbd730e85987 ("nvdimm: check -object memory-backend-file, readonly=on option")
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/acpi/nvdimm.c        | 11 ++++++++---
 hw/mem/nvdimm.c         | 10 +++++++---
 hw/ppc/spapr_nvdimm.c   |  3 ++-
 include/hw/mem/nvdimm.h |  6 ++++++
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index a3b25a92f3..3cbd41629d 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -670,7 +670,8 @@ static void nvdimm_dsm_label_size(NVDIMMDevice *nvdimm, hwaddr dsm_mem_addr)
 }
 
 static uint32_t nvdimm_rw_label_data_check(NVDIMMDevice *nvdimm,
-                                           uint32_t offset, uint32_t length)
+                                           uint32_t offset, uint32_t length,
+                                           bool is_write)
 {
     uint32_t ret = NVDIMM_DSM_RET_STATUS_INVALID;
 
@@ -690,6 +691,10 @@ static uint32_t nvdimm_rw_label_data_check(NVDIMMDevice *nvdimm,
         return ret;
     }
 
+    if (is_write && nvdimm->readonly) {
+        return NVDIMM_DSM_RET_STATUS_UNSUPPORT;
+    }
+
     return NVDIMM_DSM_RET_STATUS_SUCCESS;
 }
 
@@ -713,7 +718,7 @@ static void nvdimm_dsm_get_label_data(NVDIMMDevice *nvdimm, NvdimmDsmIn *in,
                                  get_label_data->length);
 
     status = nvdimm_rw_label_data_check(nvdimm, get_label_data->offset,
-                                        get_label_data->length);
+                                        get_label_data->length, false);
     if (status != NVDIMM_DSM_RET_STATUS_SUCCESS) {
         nvdimm_dsm_no_payload(status, dsm_mem_addr);
         return;
@@ -752,7 +757,7 @@ static void nvdimm_dsm_set_label_data(NVDIMMDevice *nvdimm, NvdimmDsmIn *in,
                                   set_label_data->length);
 
     status = nvdimm_rw_label_data_check(nvdimm, set_label_data->offset,
-                                        set_label_data->length);
+                                        set_label_data->length, true);
     if (status != NVDIMM_DSM_RET_STATUS_SUCCESS) {
         nvdimm_dsm_no_payload(status, dsm_mem_addr);
         return;
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 31080c22c9..1631a7d13f 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -154,6 +154,9 @@ static void nvdimm_prepare_memory_region(NVDIMMDevice *nvdimm, Error **errp)
                    object_get_canonical_path_component(OBJECT(hostmem)));
         return;
     }
+    if (memory_region_is_rom(mr)) {
+        nvdimm->readonly = true;
+    }
 
     nvdimm->nvdimm_mr = g_new(MemoryRegion, 1);
     memory_region_init_alias(nvdimm->nvdimm_mr, OBJECT(dimm),
@@ -207,15 +210,16 @@ static void nvdimm_unrealize(PCDIMMDevice *dimm)
  * label read/write functions.
  */
 static void nvdimm_validate_rw_label_data(NVDIMMDevice *nvdimm, uint64_t size,
-                                        uint64_t offset)
+                                        uint64_t offset, bool is_write)
 {
     assert((nvdimm->label_size >= size + offset) && (offset + size > offset));
+    assert(!is_write || !nvdimm->readonly);
 }
 
 static void nvdimm_read_label_data(NVDIMMDevice *nvdimm, void *buf,
                                    uint64_t size, uint64_t offset)
 {
-    nvdimm_validate_rw_label_data(nvdimm, size, offset);
+    nvdimm_validate_rw_label_data(nvdimm, size, offset, false);
 
     memcpy(buf, nvdimm->label_data + offset, size);
 }
@@ -229,7 +233,7 @@ static void nvdimm_write_label_data(NVDIMMDevice *nvdimm, const void *buf,
                                             "pmem", NULL);
     uint64_t backend_offset;
 
-    nvdimm_validate_rw_label_data(nvdimm, size, offset);
+    nvdimm_validate_rw_label_data(nvdimm, size, offset, true);
 
     if (!is_pmem) {
         memcpy(nvdimm->label_data + offset, buf, size);
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index a8688243a6..60d6d0acc0 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -320,7 +320,8 @@ static target_ulong h_scm_write_metadata(PowerPCCPU *cpu,
 
     nvdimm = NVDIMM(drc->dev);
     if ((offset + len < offset) ||
-        (nvdimm->label_size < len + offset)) {
+        (nvdimm->label_size < len + offset) ||
+        nvdimm->readonly) {
         return H_P2;
     }
 
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index acf887c83d..d3b763453a 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -77,6 +77,12 @@ struct NVDIMMDevice {
      */
     bool unarmed;
 
+    /*
+     * Whether our DIMM is backed by ROM, and even label data cannot be
+     * written. If set, implies that "unarmed" is also set.
+     */
+    bool readonly;
+
     /*
      * The PPC64 - spapr requires each nvdimm device have a uuid.
      */
-- 
2.41.0


