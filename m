Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CDA73DF36
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:30:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlKE-0000wp-TM; Mon, 26 Jun 2023 08:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKC-0000vi-Ng
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKA-0002YZ-V1
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kI03NjQB8ru4Nw/R5Bq2TCinmmajORtmgzFeybe/w5g=;
 b=ZFTnwNs9X4C3Btz+wmOBZTjRHaF2OTUJ14YSQFYJ+km6RzKqXeHwlaqD85CsFKUCbmUnG4
 t7k6Mb4lrfoJSXyXzwi8Ltwjv7RTxVptvzZEx1tP55Qfqr24+ebp0KisSvqNbDdBkoCaFs
 JnC97aot0Jlizq2yhNtIZB0nEjP1Vqo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-pMTTG9KvMTey99pEsl7rbQ-1; Mon, 26 Jun 2023 08:28:03 -0400
X-MC-Unique: pMTTG9KvMTey99pEsl7rbQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso1218376f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782481; x=1690374481;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kI03NjQB8ru4Nw/R5Bq2TCinmmajORtmgzFeybe/w5g=;
 b=e2Tz5wVl89xxJNI2t3nzIwt7fLRDnn3iqACwROqEEGVWEK/mhxE9ATpyZHbT53Z2v1
 cDFaDpbfvSbN28pHFeDTwPah3vZ0O4rgnutI2boiROtu77M7R1sLWOUDZ+PEfkcNTY6b
 vny4maCvo5ogYFccI1aAQblM9XvQy1ckHDJeQQH7K21J0upFnTxdBEFsq8OQHJyvjZTX
 5M8x7zEZ1qRNVCadojuqfMTnV3aTIOGiQjBy6WaUQFD2rChELCTcIUhexFltnjnROTVH
 Q6QXuR2mqmpDQUv8CuVD7aub7YuC33J1vfEx7EZPqqNZ3MJoR6MhorBLgo9iXnN5xSbh
 idiA==
X-Gm-Message-State: AC+VfDz9lNGvRJLsfpGNJU1eH9PXNiIbbQr8rbOHTKqiLgVJWaCfTRag
 l7AVx6An3sJWop3nEU++M1xMGXnd93yK6fpmfMi0TLn0Ggr1GfcO7mrl1hg3E6dzzq1ycsZZoYc
 ERXwau1JNNresd7baR4bHxXDa5ZnhEitOgxOAw1b6D2QffMKQZvXf6IwTKD5b4lXme1QU
X-Received: by 2002:adf:e387:0:b0:313:f395:f5a3 with SMTP id
 e7-20020adfe387000000b00313f395f5a3mr1203027wrm.38.1687782481587; 
 Mon, 26 Jun 2023 05:28:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5alL0yEsATExBsdDlntYFvgXtaKiqmPh13aYdw/59Y86OAQaOZY4BHv5pMZHaf7LNTkQlLvw==
X-Received: by 2002:adf:e387:0:b0:313:f395:f5a3 with SMTP id
 e7-20020adfe387000000b00313f395f5a3mr1203014wrm.38.1687782481245; 
 Mon, 26 Jun 2023 05:28:01 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 b3-20020adfe303000000b0030fd03e3d25sm7288876wrj.75.2023.06.26.05.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:28:00 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:27:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PULL 04/53] hw/cxl: Add clear poison mailbox command support.
Message-ID: <6bda41a69bdcee8ff7dcf75df2f9647ce55908ab.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Current implementation is very simple so many of the corner
cases do not exist (e.g. fragmenting larger poison list entries)

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230526170010.574-5-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  1 +
 hw/cxl/cxl-mailbox-utils.c  | 82 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          | 37 +++++++++++++++++
 3 files changed, 120 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 32c234ea91..73328a52cf 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -298,6 +298,7 @@ struct CXLType3Class {
                         uint64_t offset);
     void (*set_lsa)(CXLType3Dev *ct3d, const void *buf, uint64_t size,
                     uint64_t offset);
+    bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data);
 };
 
 MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6c476ad7f4..e3401b6be8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -65,6 +65,7 @@ enum {
     MEDIA_AND_POISON = 0x43,
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
+        #define CLEAR_POISON           0x2
 };
 
 /* 8.2.8.4.5.1 Command Return Codes */
@@ -512,6 +513,85 @@ static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
+                                         CXLDeviceState *cxl_dstate,
+                                         uint16_t *len_unused)
+{
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLPoisonList *poison_list = &ct3d->poison_list;
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
+    struct clear_poison_pl {
+        uint64_t dpa;
+        uint8_t data[64];
+    };
+    CXLPoison *ent;
+    uint64_t dpa;
+
+    struct clear_poison_pl *in = (void *)cmd->payload;
+
+    dpa = ldq_le_p(&in->dpa);
+    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
+        return CXL_MBOX_INVALID_PA;
+    }
+
+    /* Clearing a region with no poison is not an error so always do so */
+    if (cvc->set_cacheline) {
+        if (!cvc->set_cacheline(ct3d, dpa, in->data)) {
+            return CXL_MBOX_INTERNAL_ERROR;
+        }
+    }
+
+    QLIST_FOREACH(ent, poison_list, node) {
+        /*
+         * Test for contained in entry. Simpler than general case
+         * as clearing 64 bytes and entries 64 byte aligned
+         */
+        if ((dpa >= ent->start) && (dpa < ent->start + ent->length)) {
+            break;
+        }
+    }
+    if (!ent) {
+        return CXL_MBOX_SUCCESS;
+    }
+
+    QLIST_REMOVE(ent, node);
+    ct3d->poison_list_cnt--;
+
+    if (dpa > ent->start) {
+        CXLPoison *frag;
+        /* Cannot overflow as replacing existing entry */
+
+        frag = g_new0(CXLPoison, 1);
+
+        frag->start = ent->start;
+        frag->length = dpa - ent->start;
+        frag->type = ent->type;
+
+        QLIST_INSERT_HEAD(poison_list, frag, node);
+        ct3d->poison_list_cnt++;
+    }
+
+    if (dpa + CXL_CACHE_LINE_SIZE < ent->start + ent->length) {
+        CXLPoison *frag;
+
+        if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
+            cxl_set_poison_list_overflowed(ct3d);
+        } else {
+            frag = g_new0(CXLPoison, 1);
+
+            frag->start = dpa + CXL_CACHE_LINE_SIZE;
+            frag->length = ent->start + ent->length - frag->start;
+            frag->type = ent->type;
+            QLIST_INSERT_HEAD(poison_list, frag, node);
+            ct3d->poison_list_cnt++;
+        }
+    }
+    /* Any fragments have been added, free original entry */
+    g_free(ent);
+
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -543,6 +623,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_get_poison_list, 16, 0 },
     [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
         cmd_media_inject_poison, 8, 0 },
+    [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
+        cmd_media_clear_poison, 72, 0 },
 };
 
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ab600735eb..d751803188 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -947,6 +947,42 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
      */
 }
 
+static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
+{
+    MemoryRegion *vmr = NULL, *pmr = NULL;
+    AddressSpace *as;
+
+    if (ct3d->hostvmem) {
+        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+    }
+    if (ct3d->hostpmem) {
+        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+    }
+
+    if (!vmr && !pmr) {
+        return false;
+    }
+
+    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.mem_size) {
+        return false;
+    }
+
+    if (vmr) {
+        if (dpa_offset < memory_region_size(vmr)) {
+            as = &ct3d->hostvmem_as;
+        } else {
+            as = &ct3d->hostpmem_as;
+            dpa_offset -= memory_region_size(vmr);
+        }
+    } else {
+        as = &ct3d->hostpmem_as;
+    }
+
+    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
+                        CXL_CACHE_LINE_SIZE);
+    return true;
+}
+
 void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d)
 {
         ct3d->poison_list_overflowed = true;
@@ -1168,6 +1204,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     cvc->get_lsa_size = get_lsa_size;
     cvc->get_lsa = get_lsa;
     cvc->set_lsa = set_lsa;
+    cvc->set_cacheline = set_cacheline;
 }
 
 static const TypeInfo ct3d_info = {
-- 
MST


