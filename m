Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C3E7E38AD
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:17:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J4v-0003M0-3K; Tue, 07 Nov 2023 05:13:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J4t-0003KU-4A
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:12:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J4q-0002np-OB
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j2F88JokXJXgcMSPSDXbLTq7o37ECrHFxcmlb224C7w=;
 b=cV8nMWi8sg9DrhJfjLW3utS+eSGeXUXTH2b3vXRpHTJGkVyfM6rln/WUAwgAfSnliXpjx3
 Y8znBkq2NDYal03XdZZZorU0zOLwa2pBASnYUVf+R63bm0mtbHvq4HbSOypvJWS506z7uI
 eph32e0APePpwBhZmgYOMbzXKnS0HmQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-gfwiHeVyPnq4xtigvO8uYA-1; Tue, 07 Nov 2023 05:12:54 -0500
X-MC-Unique: gfwiHeVyPnq4xtigvO8uYA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c59a4dcdd0so51375481fa.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351973; x=1699956773;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j2F88JokXJXgcMSPSDXbLTq7o37ECrHFxcmlb224C7w=;
 b=O7F/m075/ZjYhUfPsSffL0tEiPlN91fFvRvUqY2Q3bs5aP/0JHg34WlgNJGT5avrg0
 3YeqgO4oAwvAn9NDHB0kAYva8lCcuacMUlNKZG5pPNgytYoRMJz5pkv+WHK23BHNysON
 sqBIzA8rjl8wQrEYSjJmJNX8II17zR5gCZ3Kir/aHAHPwOtxMuni3hAl/UTtCJ5mlB9Y
 XCcGzoS3yrSiorxsp6Y8qZeqqDGV9WM3P6FHmSNYmZow6P9I3EUDKPJc3wOX/vfvB/an
 MtDMs3Bh0M0ZjAkqKZCCUYlbSaj2NbBR6bJflp7W89CtTzqQL8WhZiBz+8r1EXTE8xoT
 k5bg==
X-Gm-Message-State: AOJu0YxOTHGheN3mLebduU67eJisV0mQaVDStxk6q9uBQF3+juAloMve
 IP65CYF9arxhi+HfP/0lcONZQ6ZyraKxGAVmy/1y3SvBKBjz9G5zFPEloqBHNaGX1KW/p5S0thJ
 E+MfZ/rK710FLjfJBnwYJv7tGgpmfw/N22L4Q0IMGsOEwTooo8mRquO1LTXuYpqw/329r
X-Received: by 2002:a2e:be0c:0:b0:2c5:1bd9:f95c with SMTP id
 z12-20020a2ebe0c000000b002c51bd9f95cmr29933562ljq.53.1699351972574; 
 Tue, 07 Nov 2023 02:12:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGdw/guimOtq7FYbmRWBj8Temw8/R8CnSzLBKD6/Uj/ZhyDC5tWcJ1aTiVEcyCxfxNa9uRHQ==
X-Received: by 2002:a2e:be0c:0:b0:2c5:1bd9:f95c with SMTP id
 z12-20020a2ebe0c000000b002c51bd9f95cmr29933529ljq.53.1699351972068; 
 Tue, 07 Nov 2023 02:12:52 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 a1-20020a05600c348100b003fe1fe56202sm15528349wmq.33.2023.11.07.02.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:12:51 -0800 (PST)
Date: Tue, 7 Nov 2023 05:12:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 45/63] hw/cxl/mbox: Pull the payload out of struct cxl_cmd and
 make instances constant
Message-ID: <a7bb53b1eee6836d29003a8ffbd2c2c4c55a40c2.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Putting the pointer in the structure for command handling puts a single
variable element inside an otherwise constant structure. Move it out as
a directly passed variable and take the cxl_cmd structures constant.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20231023160806.13206-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  13 ++++
 hw/cxl/cxl-mailbox-utils.c  | 121 +++++++++++++++++++-----------------
 2 files changed, 78 insertions(+), 56 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 007ddaf078..556953469c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -111,6 +111,18 @@ typedef enum {
     CXL_MBOX_MAX = 0x17
 } CXLRetCode;
 
+typedef struct cxl_device_state CXLDeviceState;
+struct cxl_cmd;
+typedef CXLRetCode (*opcode_handler)(const struct cxl_cmd *cmd,
+                                     uint8_t *payload,
+                                     CXLDeviceState *cxl_dstate, uint16_t *len);
+struct cxl_cmd {
+    const char *name;
+    opcode_handler handler;
+    ssize_t in;
+    uint16_t effect; /* Reported in CEL */
+};
+
 typedef struct CXLEvent {
     CXLEventRecordRaw data;
     QSIMPLEQ_ENTRY(CXLEvent) node;
@@ -178,6 +190,7 @@ typedef struct cxl_device_state {
     uint64_t pmem_size;
     uint64_t vmem_size;
 
+    const struct cxl_cmd (*cxl_cmd_set)[256];
     CXLEventLog event_logs[CXL_EVENT_TYPE_MAX];
 } CXLDeviceState;
 
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ab082ec9de..c02de06943 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -69,18 +69,9 @@ enum {
         #define CLEAR_POISON           0x2
 };
 
-struct cxl_cmd;
-typedef CXLRetCode (*opcode_handler)(struct cxl_cmd *cmd,
-                                   CXLDeviceState *cxl_dstate, uint16_t *len);
-struct cxl_cmd {
-    const char *name;
-    opcode_handler handler;
-    ssize_t in;
-    uint16_t effect; /* Reported in CEL */
-    uint8_t *payload;
-};
 
-static CXLRetCode cmd_events_get_records(struct cxl_cmd *cmd,
+static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
+                                         uint8_t *payload,
                                          CXLDeviceState *cxlds,
                                          uint16_t *len)
 {
@@ -92,9 +83,9 @@ static CXLRetCode cmd_events_get_records(struct cxl_cmd *cmd,
         return CXL_MBOX_INVALID_INPUT;
     }
 
-    log_type = *((uint8_t *)cmd->payload);
+    log_type = payload[0];
 
-    pl = (CXLGetEventPayload *)cmd->payload;
+    pl = (CXLGetEventPayload *)payload;
     memset(pl, 0, sizeof(*pl));
 
     max_recs = (cxlds->payload_size - CXL_EVENT_PAYLOAD_HDR_SIZE) /
@@ -106,25 +97,27 @@ static CXLRetCode cmd_events_get_records(struct cxl_cmd *cmd,
     return cxl_event_get_records(cxlds, pl, log_type, max_recs, len);
 }
 
-static CXLRetCode cmd_events_clear_records(struct cxl_cmd *cmd,
+static CXLRetCode cmd_events_clear_records(const struct cxl_cmd *cmd,
+                                           uint8_t *payload,
                                            CXLDeviceState *cxlds,
                                            uint16_t *len)
 {
     CXLClearEventPayload *pl;
 
-    pl = (CXLClearEventPayload *)cmd->payload;
+    pl = (CXLClearEventPayload *)payload;
     *len = 0;
     return cxl_event_clear_records(cxlds, pl);
 }
 
-static CXLRetCode cmd_events_get_interrupt_policy(struct cxl_cmd *cmd,
+static CXLRetCode cmd_events_get_interrupt_policy(const struct cxl_cmd *cmd,
+                                                  uint8_t *payload,
                                                   CXLDeviceState *cxlds,
                                                   uint16_t *len)
 {
     CXLEventInterruptPolicy *policy;
     CXLEventLog *log;
 
-    policy = (CXLEventInterruptPolicy *)cmd->payload;
+    policy = (CXLEventInterruptPolicy *)payload;
     memset(policy, 0, sizeof(*policy));
 
     log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
@@ -157,7 +150,8 @@ static CXLRetCode cmd_events_get_interrupt_policy(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static CXLRetCode cmd_events_set_interrupt_policy(struct cxl_cmd *cmd,
+static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *cmd,
+                                                  uint8_t *payload,
                                                   CXLDeviceState *cxlds,
                                                   uint16_t *len)
 {
@@ -168,7 +162,7 @@ static CXLRetCode cmd_events_set_interrupt_policy(struct cxl_cmd *cmd,
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
-    policy = (CXLEventInterruptPolicy *)cmd->payload;
+    policy = (CXLEventInterruptPolicy *)payload;
 
     log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
     log->irq_enabled = (policy->info_settings & CXL_EVENT_INT_MODE_MASK) ==
@@ -200,7 +194,8 @@ static CXLRetCode cmd_events_set_interrupt_policy(struct cxl_cmd *cmd,
 }
 
 /* 8.2.9.2.1 */
-static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
+static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
+                                               uint8_t *payload,
                                                CXLDeviceState *cxl_dstate,
                                                uint16_t *len)
 {
@@ -221,7 +216,7 @@ static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
-    fw_info = (void *)cmd->payload;
+    fw_info = (void *)payload;
     memset(fw_info, 0, sizeof(*fw_info));
 
     fw_info->slots_supported = 2;
@@ -234,27 +229,29 @@ static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
 }
 
 /* 8.2.9.3.1 */
-static CXLRetCode cmd_timestamp_get(struct cxl_cmd *cmd,
+static CXLRetCode cmd_timestamp_get(const struct cxl_cmd *cmd,
+                                    uint8_t *payload,
                                     CXLDeviceState *cxl_dstate,
                                     uint16_t *len)
 {
     uint64_t final_time = cxl_device_get_timestamp(cxl_dstate);
 
-    stq_le_p(cmd->payload, final_time);
+    stq_le_p(payload, final_time);
     *len = 8;
 
     return CXL_MBOX_SUCCESS;
 }
 
 /* 8.2.9.3.2 */
-static CXLRetCode cmd_timestamp_set(struct cxl_cmd *cmd,
-                                  CXLDeviceState *cxl_dstate,
-                                  uint16_t *len)
+static CXLRetCode cmd_timestamp_set(const struct cxl_cmd *cmd,
+                                    uint8_t *payload,
+                                    CXLDeviceState *cxl_dstate,
+                                    uint16_t *len)
 {
     cxl_dstate->timestamp.set = true;
     cxl_dstate->timestamp.last_set = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
-    cxl_dstate->timestamp.host_set = le64_to_cpu(*(uint64_t *)cmd->payload);
+    cxl_dstate->timestamp.host_set = le64_to_cpu(*(uint64_t *)payload);
 
     *len = 0;
     return CXL_MBOX_SUCCESS;
@@ -267,7 +264,8 @@ static const QemuUUID cel_uuid = {
 };
 
 /* 8.2.9.4.1 */
-static CXLRetCode cmd_logs_get_supported(struct cxl_cmd *cmd,
+static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
+                                         uint8_t *payload,
                                          CXLDeviceState *cxl_dstate,
                                          uint16_t *len)
 {
@@ -278,7 +276,7 @@ static CXLRetCode cmd_logs_get_supported(struct cxl_cmd *cmd,
             QemuUUID uuid;
             uint32_t size;
         } log_entries[1];
-    } QEMU_PACKED *supported_logs = (void *)cmd->payload;
+    } QEMU_PACKED *supported_logs = (void *)payload;
     QEMU_BUILD_BUG_ON(sizeof(*supported_logs) != 0x1c);
 
     supported_logs->entries = 1;
@@ -290,7 +288,8 @@ static CXLRetCode cmd_logs_get_supported(struct cxl_cmd *cmd,
 }
 
 /* 8.2.9.4.2 */
-static CXLRetCode cmd_logs_get_log(struct cxl_cmd *cmd,
+static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
+                                   uint8_t *payload,
                                    CXLDeviceState *cxl_dstate,
                                    uint16_t *len)
 {
@@ -298,7 +297,9 @@ static CXLRetCode cmd_logs_get_log(struct cxl_cmd *cmd,
         QemuUUID uuid;
         uint32_t offset;
         uint32_t length;
-    } QEMU_PACKED QEMU_ALIGNED(16) *get_log = (void *)cmd->payload;
+    } QEMU_PACKED QEMU_ALIGNED(16) *get_log;
+
+    get_log = (void *)payload;
 
     /*
      * 8.2.9.4.2
@@ -324,14 +325,15 @@ static CXLRetCode cmd_logs_get_log(struct cxl_cmd *cmd,
     /* Store off everything to local variables so we can wipe out the payload */
     *len = get_log->length;
 
-    memmove(cmd->payload, cxl_dstate->cel_log + get_log->offset,
+    memmove(payload, cxl_dstate->cel_log + get_log->offset,
            get_log->length);
 
     return CXL_MBOX_SUCCESS;
 }
 
 /* 8.2.9.5.1.1 */
-static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
+static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
+                                             uint8_t *payload,
                                              CXLDeviceState *cxl_dstate,
                                              uint16_t *len)
 {
@@ -361,7 +363,7 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
-    id = (void *)cmd->payload;
+    id = (void *)payload;
     memset(id, 0, sizeof(*id));
 
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
@@ -382,7 +384,8 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static CXLRetCode cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
+static CXLRetCode cmd_ccls_get_partition_info(const struct cxl_cmd *cmd,
+                                              uint8_t *payload,
                                               CXLDeviceState *cxl_dstate,
                                               uint16_t *len)
 {
@@ -391,7 +394,7 @@ static CXLRetCode cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
         uint64_t active_pmem;
         uint64_t next_vmem;
         uint64_t next_pmem;
-    } QEMU_PACKED *part_info = (void *)cmd->payload;
+    } QEMU_PACKED *part_info = (void *)payload;
     QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
 
     if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
@@ -414,7 +417,8 @@ static CXLRetCode cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static CXLRetCode cmd_ccls_get_lsa(struct cxl_cmd *cmd,
+static CXLRetCode cmd_ccls_get_lsa(const struct cxl_cmd *cmd,
+                                   uint8_t *payload,
                                    CXLDeviceState *cxl_dstate,
                                    uint16_t *len)
 {
@@ -426,7 +430,7 @@ static CXLRetCode cmd_ccls_get_lsa(struct cxl_cmd *cmd,
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     uint32_t offset, length;
 
-    get_lsa = (void *)cmd->payload;
+    get_lsa = (void *)payload;
     offset = get_lsa->offset;
     length = get_lsa->length;
 
@@ -439,7 +443,8 @@ static CXLRetCode cmd_ccls_get_lsa(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static CXLRetCode cmd_ccls_set_lsa(struct cxl_cmd *cmd,
+static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
+                                   uint8_t *payload,
                                    CXLDeviceState *cxl_dstate,
                                    uint16_t *len)
 {
@@ -448,7 +453,7 @@ static CXLRetCode cmd_ccls_set_lsa(struct cxl_cmd *cmd,
         uint32_t rsvd;
         uint8_t data[];
     } QEMU_PACKED;
-    struct set_lsa_pl *set_lsa_payload = (void *)cmd->payload;
+    struct set_lsa_pl *set_lsa_payload = (void *)payload;
     CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     const size_t hdr_len = offsetof(struct set_lsa_pl, data);
@@ -474,7 +479,8 @@ static CXLRetCode cmd_ccls_set_lsa(struct cxl_cmd *cmd,
  * make this stateful. We may want to allow longer poison lists to aid
  * testing that kernel functionality.
  */
-static CXLRetCode cmd_media_get_poison_list(struct cxl_cmd *cmd,
+static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
+                                            uint8_t *payload,
                                             CXLDeviceState *cxl_dstate,
                                             uint16_t *len)
 {
@@ -496,8 +502,8 @@ static CXLRetCode cmd_media_get_poison_list(struct cxl_cmd *cmd,
         } QEMU_PACKED records[];
     } QEMU_PACKED;
 
-    struct get_poison_list_pl *in = (void *)cmd->payload;
-    struct get_poison_list_out_pl *out = (void *)cmd->payload;
+    struct get_poison_list_pl *in = (void *)payload;
+    struct get_poison_list_out_pl *out = (void *)payload;
     CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
     uint16_t record_count = 0, i = 0;
     uint64_t query_start, query_length;
@@ -550,7 +556,8 @@ static CXLRetCode cmd_media_get_poison_list(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
+static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
+                                          uint8_t *payload,
                                           CXLDeviceState *cxl_dstate,
                                           uint16_t *len_unused)
 {
@@ -560,7 +567,7 @@ static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
     struct inject_poison_pl {
         uint64_t dpa;
     };
-    struct inject_poison_pl *in = (void *)cmd->payload;
+    struct inject_poison_pl *in = (void *)payload;
     uint64_t dpa = ldq_le_p(&in->dpa);
     CXLPoison *p;
 
@@ -589,7 +596,8 @@ static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
+static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
+                                         uint8_t *payload,
                                          CXLDeviceState *cxl_dstate,
                                          uint16_t *len_unused)
 {
@@ -603,7 +611,7 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
     CXLPoison *ent;
     uint64_t dpa;
 
-    struct clear_poison_pl *in = (void *)cmd->payload;
+    struct clear_poison_pl *in = (void *)payload;
 
     dpa = ldq_le_p(&in->dpa);
     if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
@@ -673,7 +681,7 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
 #define IMMEDIATE_LOG_CHANGE (1 << 4)
 
-static struct cxl_cmd cxl_cmd_set[256][256] = {
+static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [EVENTS][GET_RECORDS] = { "EVENTS_GET_RECORDS",
         cmd_events_get_records, 1, 0 },
     [EVENTS][CLEAR_RECORDS] = { "EVENTS_CLEAR_RECORDS",
@@ -709,21 +717,21 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
 {
     uint16_t ret = CXL_MBOX_SUCCESS;
-    struct cxl_cmd *cxl_cmd;
-    uint64_t status_reg;
+    const struct cxl_cmd *cxl_cmd;
+    uint64_t status_reg = 0;
     opcode_handler h;
     uint64_t command_reg = cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
 
     uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
     uint8_t cmd = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND);
     uint16_t len = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
-    cxl_cmd = &cxl_cmd_set[set][cmd];
+    uint8_t *pl = cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYLOAD;
+
+    cxl_cmd = &cxl_dstate->cxl_cmd_set[set][cmd];
     h = cxl_cmd->handler;
     if (h) {
         if (len == cxl_cmd->in || cxl_cmd->in == ~0) {
-            cxl_cmd->payload = cxl_dstate->mbox_reg_state +
-                A_CXL_DEV_CMD_PAYLOAD;
-            ret = (*h)(cxl_cmd, cxl_dstate, &len);
+            ret = (*h)(cxl_cmd, pl, cxl_dstate, &len);
             assert(len <= cxl_dstate->payload_size);
         } else {
             ret = CXL_MBOX_INVALID_PAYLOAD_LENGTH;
@@ -752,10 +760,11 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
 
 void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate)
 {
+    cxl_dstate->cxl_cmd_set = cxl_cmd_set;
     for (int set = 0; set < 256; set++) {
         for (int cmd = 0; cmd < 256; cmd++) {
-            if (cxl_cmd_set[set][cmd].handler) {
-                struct cxl_cmd *c = &cxl_cmd_set[set][cmd];
+            if (cxl_dstate->cxl_cmd_set[set][cmd].handler) {
+                const struct cxl_cmd *c = &cxl_dstate->cxl_cmd_set[set][cmd];
                 struct cel_log *log =
                     &cxl_dstate->cel_log[cxl_dstate->cel_size];
 
-- 
MST


