Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E437E389B
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:15:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J5p-0005EI-Up; Tue, 07 Nov 2023 05:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5j-0005AP-Bt
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5h-0002yV-1h
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699352026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cd9W/8zkY194vb6pZir4961+V5rZF/NXCls+/nqUWMo=;
 b=cBMAMtA3bljYuX2MZ8maSaOZ0ycxX2UmT5Ac0AxVZ5DY9rgmKHn66UWf/Iw8d9Bw3FWcJT
 voexBVg6JTo1xzZnCj4r/UoA04BmJOYpBe4o+4F/sdpLGxBK0soix2rRJmrZ8iGmbrmiXm
 fZFFSLYsps2aJgDKGo1aJNvtxfeNVwE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-dexJiD50Nvei_FP2Fu77Sw-1; Tue, 07 Nov 2023 05:13:45 -0500
X-MC-Unique: dexJiD50Nvei_FP2Fu77Sw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32d9751ca2cso2622217f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699352023; x=1699956823;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cd9W/8zkY194vb6pZir4961+V5rZF/NXCls+/nqUWMo=;
 b=HIYsuU/OLrpTcdu9xXzX6Hj7/FHhahJ9+ox8ScGfWDtt6+ncNZVIHwJOAccjfNjgBP
 BlKEOnuDYZCvurxx9yFIC+QLQyOheO6zxt9M0yvUvFGnEArhAlL9in1D3+JrXsd0s/zE
 CBxMXI0kvCWP2MGK/GHOH3unttvBeOqJMFBcFS6PCDdBxkrWRJ66GUdp85kMzNBBFlGL
 9HlczaDPX0Jz8jwdKvYtmHLkkFkXgqNGmaN3psPylxpCSCV2noVQVkmHiQbOHQs/tJPY
 N8lvPTuPXLNoVa9e6+OMqmQqR/mAYL5HdjqAnGkh0kz13lvVm4HYnpAMsjipO1wZZJkX
 JebQ==
X-Gm-Message-State: AOJu0YxUtcOY0QhRRlB8GX1tTlajg0ws2q86ZuIeTjjYwIbQ9r7MdM+J
 SIrMO5Rs+O6+dAsFYy45/UJ9ek4nCyfZQvKPv+/S5NsoYFAG0H/khU2xGCoj3qRblPZ9NVIqF1u
 WEfgh3SehYndoREEECd0PhonGc6PBghItdopOflpGQ/w8KOaHt4UGrkR4A78UsNWOdI2t
X-Received: by 2002:a05:6000:1445:b0:32f:7a07:be07 with SMTP id
 v5-20020a056000144500b0032f7a07be07mr27217786wrx.17.1699352023384; 
 Tue, 07 Nov 2023 02:13:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvYRQXPkfrGmP6XpXvkbD5RMN4S1jPqzhcJ0vc1h2OW2Tdp2Qp32+UrapviElDShzLBkjYvA==
X-Received: by 2002:a05:6000:1445:b0:32f:7a07:be07 with SMTP id
 v5-20020a056000144500b0032f7a07be07mr27217769wrx.17.1699352023009; 
 Tue, 07 Nov 2023 02:13:43 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 m5-20020a5d4a05000000b0032db4e660d9sm1947410wrq.56.2023.11.07.02.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:13:42 -0800 (PST)
Date: Tue, 7 Nov 2023 05:13:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 57/63] hw/cxl: Add support for device sanitation
Message-ID: <25a52959f99d6860a186175bda898e3bdb605f91.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Davidlohr Bueso <dave@stgolabs.net>

Make use of the background operations through the sanitize command, per CXL
3.0 specs. Traditionally run times can be rather long, depending on the
size of the media.

Estimate times based on:
	 https://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20231023160806.13206-14-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  17 +++++
 hw/cxl/cxl-mailbox-utils.c  | 140 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  10 +++
 3 files changed, 167 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 2a813cdddd..70aca9024c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -343,6 +343,23 @@ REG64(CXL_MEM_DEV_STS, 0)
     FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
     FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
 
+static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
+{
+    uint64_t dev_status_reg;
+
+    dev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val);
+    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = dev_status_reg;
+}
+#define cxl_dev_disable_media(cxlds)                    \
+        do { __toggle_media((cxlds), 0x3); } while (0)
+#define cxl_dev_enable_media(cxlds)                     \
+        do { __toggle_media((cxlds), 0x1); } while (0)
+
+static inline bool sanitize_running(CXLCCI *cci)
+{
+    return !!cci->bg.runtime && cci->bg.opcode == 0x4400;
+}
+
 typedef struct CXLError {
     QTAILQ_ENTRY(CXLError) node;
     int type; /* Error code as per FE definition */
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f3fd97deb5..2463f239af 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -18,6 +18,7 @@
 #include "qemu/log.h"
 #include "qemu/units.h"
 #include "qemu/uuid.h"
+#include "sysemu/hostmem.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 
@@ -68,6 +69,9 @@ enum {
         #define GET_PARTITION_INFO     0x0
         #define GET_LSA       0x2
         #define SET_LSA       0x3
+    SANITIZE    = 0x44,
+        #define OVERWRITE     0x0
+        #define SECURE_ERASE  0x1
     MEDIA_AND_POISON = 0x43,
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
@@ -749,6 +753,108 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* Perform the actual device zeroing */
+static void __do_sanitization(CXLType3Dev *ct3d)
+{
+    MemoryRegion *mr;
+
+    if (ct3d->hostvmem) {
+        mr = host_memory_backend_get_memory(ct3d->hostvmem);
+        if (mr) {
+            void *hostmem = memory_region_get_ram_ptr(mr);
+            memset(hostmem, 0, memory_region_size(mr));
+        }
+    }
+
+    if (ct3d->hostpmem) {
+        mr = host_memory_backend_get_memory(ct3d->hostpmem);
+        if (mr) {
+            void *hostmem = memory_region_get_ram_ptr(mr);
+            memset(hostmem, 0, memory_region_size(mr));
+        }
+    }
+    if (ct3d->lsa) {
+        mr = host_memory_backend_get_memory(ct3d->lsa);
+        if (mr) {
+            void *lsa = memory_region_get_ram_ptr(mr);
+            memset(lsa, 0, memory_region_size(mr));
+        }
+    }
+}
+
+/*
+ * CXL 3.0 spec section 8.2.9.8.5.1 - Sanitize.
+ *
+ * Once the Sanitize command has started successfully, the device shall be
+ * placed in the media disabled state. If the command fails or is interrupted
+ * by a reset or power failure, it shall remain in the media disabled state
+ * until a successful Sanitize command has been completed. During this state:
+ *
+ * 1. Memory writes to the device will have no effect, and all memory reads
+ * will return random values (no user data returned, even for locations that
+ * the failed Sanitize operation didn’t sanitize yet).
+ *
+ * 2. Mailbox commands shall still be processed in the disabled state, except
+ * that commands that access Sanitized areas shall fail with the Media Disabled
+ * error code.
+ */
+static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    uint64_t total_mem; /* in Mb */
+    int secs;
+
+    total_mem = (ct3d->cxl_dstate.vmem_size + ct3d->cxl_dstate.pmem_size) >> 20;
+    if (total_mem <= 512) {
+        secs = 4;
+    } else if (total_mem <= 1024) {
+        secs = 8;
+    } else if (total_mem <= 2 * 1024) {
+        secs = 15;
+    } else if (total_mem <= 4 * 1024) {
+        secs = 30;
+    } else if (total_mem <= 8 * 1024) {
+        secs = 60;
+    } else if (total_mem <= 16 * 1024) {
+        secs = 2 * 60;
+    } else if (total_mem <= 32 * 1024) {
+        secs = 4 * 60;
+    } else if (total_mem <= 64 * 1024) {
+        secs = 8 * 60;
+    } else if (total_mem <= 128 * 1024) {
+        secs = 15 * 60;
+    } else if (total_mem <= 256 * 1024) {
+        secs = 30 * 60;
+    } else if (total_mem <= 512 * 1024) {
+        secs = 60 * 60;
+    } else if (total_mem <= 1024 * 1024) {
+        secs = 120 * 60;
+    } else {
+        secs = 240 * 60; /* max 4 hrs */
+    }
+
+    /* EBUSY other bg cmds as of now */
+    cci->bg.runtime = secs * 1000UL;
+    *len_out = 0;
+
+    cxl_dev_disable_media(&ct3d->cxl_dstate);
+
+    if (secs > 2) {
+        /* sanitize when done */
+        return CXL_MBOX_BG_STARTED;
+    } else {
+        __do_sanitization(ct3d);
+        cxl_dev_enable_media(&ct3d->cxl_dstate);
+
+        return CXL_MBOX_SUCCESS;
+    }
+}
+
 /*
  * This is very inefficient, but good enough for now!
  * Also the payload will always fit, so no need to handle the MORE flag and
@@ -993,6 +1099,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
     [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
         ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
+    [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
+        IMMEDIATE_DATA_CHANGE | SECURITY_STATE_CHANGE | BACKGROUND_OPERATION },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
         cmd_media_get_poison_list, 16, 0 },
     [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
@@ -1050,6 +1158,21 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
         return CXL_MBOX_BUSY;
     }
 
+    /* forbid any selected commands while overwriting */
+    if (sanitize_running(cci)) {
+        if (h == cmd_events_get_records ||
+            h == cmd_ccls_get_partition_info ||
+            h == cmd_ccls_set_lsa ||
+            h == cmd_ccls_get_lsa ||
+            h == cmd_logs_get_log ||
+            h == cmd_media_get_poison_list ||
+            h == cmd_media_inject_poison ||
+            h == cmd_media_clear_poison ||
+            h == cmd_sanitize_overwrite) {
+            return CXL_MBOX_MEDIA_DISABLED;
+        }
+    }
+
     ret = (*h)(cxl_cmd, pl_in, len_in, pl_out, len_out, cci);
     if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
         ret == CXL_MBOX_BG_STARTED) {
@@ -1088,6 +1211,23 @@ static void bg_timercb(void *opaque)
 
         cci->bg.complete_pct = 100;
         cci->bg.ret_code = ret;
+        if (ret == CXL_MBOX_SUCCESS) {
+            switch (cci->bg.opcode) {
+            case 0x4400: /* sanitize */
+            {
+                CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+
+                __do_sanitization(ct3d);
+                cxl_dev_enable_media(&ct3d->cxl_dstate);
+            }
+            break;
+            case 0x4304: /* TODO: scan media */
+                break;
+            default:
+                __builtin_unreachable();
+                break;
+            }
+        }
 
         qemu_log("Background command %04xh finished: %s\n",
                  cci->bg.opcode,
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0529745786..cc8220592f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -23,6 +23,7 @@
 #include "qemu/pmem.h"
 #include "qemu/range.h"
 #include "qemu/rcu.h"
+#include "qemu/guest-random.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/numa.h"
 #include "hw/cxl/cxl.h"
@@ -897,6 +898,11 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
         return MEMTX_ERROR;
     }
 
+    if (sanitize_running(&CXL_TYPE3(d)->cci)) {
+        qemu_guest_getrandom_nofail(data, size);
+        return MEMTX_OK;
+    }
+
     return address_space_read(as, dpa_offset, attrs, data, size);
 }
 
@@ -913,6 +919,10 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
         return MEMTX_ERROR;
     }
 
+    if (sanitize_running(&CXL_TYPE3(d)->cci)) {
+        return MEMTX_OK;
+    }
+
     return address_space_write(as, dpa_offset, attrs, &data, size);
 }
 
-- 
MST


