Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 066D17E38E3
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:21:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J55-0003hG-W0; Tue, 07 Nov 2023 05:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J53-0003h0-Ut
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J51-0002sT-1G
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qCQ8Bc7r1ZWmECZIkoA9QDb2hwxsOcaeJUpPPLoe0pY=;
 b=Y65mC0u9jrhh6YtLL5Gi6m+06GZGmA+LmM+FFgBG+fvpdS7xizcHGcC9jRqoS4LoZwU2zG
 Zd4EU3jG2ReLBqpoiXhiG1FClzecc5ZcwDrggoH+fYh1Xby/H1TfXFjutO61XnLfQbLLR9
 wgNP1PymSAXGw6CSRza2UPjv0fccJKc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-m5JOuqlNPf-SiT2XQ1mjng-1; Tue, 07 Nov 2023 05:12:59 -0500
X-MC-Unique: m5JOuqlNPf-SiT2XQ1mjng-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4090181eec2so35037135e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:12:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351977; x=1699956777;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qCQ8Bc7r1ZWmECZIkoA9QDb2hwxsOcaeJUpPPLoe0pY=;
 b=ZTdepqaYTgIeHJ02l7HrxTzU4ljtO5/lNob8euRBVPbKU8wSw2fC0Ah1qf9QbKEy1j
 +3B2GBlw8z3epmRzaOwaZLQlisWQL7SHBPHfBF9Xbdtf2d20Pz0EbrjlFnJ8Q+xrOwQ6
 N+cDB7VZTZRhyXnz0KBXNUnISxXvNHNLKm9w5wkd1JwTAjHsy2sPLl6gubOKezntTks7
 t0qTYJ4t9+3eenA37oSLSmFfodmgOMf0bd8TLLtb6vSfnphB49vRagxb+de4ogMxRD0V
 QJZT3if3X+Lb6ylSYdFXfFVHFawa5cHdIDS39+D4Lzu2jlj95O62/xYuUh6wizfmcspu
 wsgw==
X-Gm-Message-State: AOJu0YzHJAwoeWW+2e6YYx0UKX/+2qY6ER3t+coOLjyjrvMZC1SsXDDY
 3PzADLFEtyf4JkuQNAA/nAqWgIQkhpP6nvyJUjTkLvpVhXLeBqBHfnYH8/XZRp86uMcq1P3xSH0
 SVui40V5KMLltvLHuNP4gl97gqp3JliCPSpIsgtSOFP2DCa1mwnbFsitMahDyM5EsdDQq
X-Received: by 2002:a05:600c:46c6:b0:406:5308:cfeb with SMTP id
 q6-20020a05600c46c600b004065308cfebmr2188037wmo.11.1699351976921; 
 Tue, 07 Nov 2023 02:12:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGof15HDQVZK8pT+o7VUeVBUI8ssewlE1lCEIj3ahjTNiBkd3tsdoojQg2vaqJ3OMcQUWYlUw==
X-Received: by 2002:a05:600c:46c6:b0:406:5308:cfeb with SMTP id
 q6-20020a05600c46c600b004065308cfebmr2188019wmo.11.1699351976564; 
 Tue, 07 Nov 2023 02:12:56 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 du15-20020a05600c634f00b00405959bbf4fsm14724926wmb.19.2023.11.07.02.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:12:56 -0800 (PST)
Date: Tue, 7 Nov 2023 05:12:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 46/63] hw/cxl/mbox: Split mailbox command payload into
 separate input and output
Message-ID: <6f59274e937576fbb2623b687aa2556e115a712f.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

New CCI types that will be supported shortly do not have a single buffer
used in both directions. As such, split it up. To avoid the complexities
of implementing all commands to handle potential aliasing, take a copy of
the input before use.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Message-Id: <20231023160806.13206-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |   7 +-
 hw/cxl/cxl-events.c         |   2 +-
 hw/cxl/cxl-mailbox-utils.c  | 230 +++++++++++++++++++++---------------
 3 files changed, 140 insertions(+), 99 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 556953469c..d7a2c4009e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -114,8 +114,9 @@ typedef enum {
 typedef struct cxl_device_state CXLDeviceState;
 struct cxl_cmd;
 typedef CXLRetCode (*opcode_handler)(const struct cxl_cmd *cmd,
-                                     uint8_t *payload,
-                                     CXLDeviceState *cxl_dstate, uint16_t *len);
+                                     uint8_t *payload_in, size_t len_in,
+                                     uint8_t *payload_out, size_t *len_out,
+                                     CXLDeviceState *cxl_dstate);
 struct cxl_cmd {
     const char *name;
     opcode_handler handler;
@@ -390,7 +391,7 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
                       CXLEventRecordRaw *event);
 CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
                                  uint8_t log_type, int max_recs,
-                                 uint16_t *len);
+                                 size_t *len);
 CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
                                    CXLClearEventPayload *pl);
 
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index e2172b94b9..bee6dfaf14 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -143,7 +143,7 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
 
 CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
                                  uint8_t log_type, int max_recs,
-                                 uint16_t *len)
+                                 size_t *len)
 {
     CXLEventLog *log;
     CXLEvent *entry;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c02de06943..e5ddce37c7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -71,9 +71,9 @@ enum {
 
 
 static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
-                                         uint8_t *payload,
-                                         CXLDeviceState *cxlds,
-                                         uint16_t *len)
+                                         uint8_t *payload_in, size_t len_in,
+                                         uint8_t *payload_out, size_t *len_out,
+                                         CXLDeviceState *cxlds)
 {
     CXLGetEventPayload *pl;
     uint8_t log_type;
@@ -83,9 +83,9 @@ static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
         return CXL_MBOX_INVALID_INPUT;
     }
 
-    log_type = payload[0];
+    log_type = payload_in[0];
 
-    pl = (CXLGetEventPayload *)payload;
+    pl = (CXLGetEventPayload *)payload_out;
     memset(pl, 0, sizeof(*pl));
 
     max_recs = (cxlds->payload_size - CXL_EVENT_PAYLOAD_HDR_SIZE) /
@@ -94,30 +94,34 @@ static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
         max_recs = 0xFFFF;
     }
 
-    return cxl_event_get_records(cxlds, pl, log_type, max_recs, len);
+    return cxl_event_get_records(cxlds, pl, log_type, max_recs, len_out);
 }
 
 static CXLRetCode cmd_events_clear_records(const struct cxl_cmd *cmd,
-                                           uint8_t *payload,
-                                           CXLDeviceState *cxlds,
-                                           uint16_t *len)
+                                           uint8_t *payload_in,
+                                           size_t len_in,
+                                           uint8_t *payload_out,
+                                           size_t *len_out,
+                                           CXLDeviceState *cxlds)
 {
     CXLClearEventPayload *pl;
 
-    pl = (CXLClearEventPayload *)payload;
-    *len = 0;
+    pl = (CXLClearEventPayload *)payload_in;
+    *len_out = 0;
     return cxl_event_clear_records(cxlds, pl);
 }
 
 static CXLRetCode cmd_events_get_interrupt_policy(const struct cxl_cmd *cmd,
-                                                  uint8_t *payload,
-                                                  CXLDeviceState *cxlds,
-                                                  uint16_t *len)
+                                                  uint8_t *payload_in,
+                                                  size_t len_in,
+                                                  uint8_t *payload_out,
+                                                  size_t *len_out,
+                                                  CXLDeviceState *cxlds)
 {
     CXLEventInterruptPolicy *policy;
     CXLEventLog *log;
 
-    policy = (CXLEventInterruptPolicy *)payload;
+    policy = (CXLEventInterruptPolicy *)payload_out;
     memset(policy, 0, sizeof(*policy));
 
     log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
@@ -146,23 +150,25 @@ static CXLRetCode cmd_events_get_interrupt_policy(const struct cxl_cmd *cmd,
         policy->dyn_cap_settings = CXL_INT_MSI_MSIX;
     }
 
-    *len = sizeof(*policy);
+    *len_out = sizeof(*policy);
     return CXL_MBOX_SUCCESS;
 }
 
 static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *cmd,
-                                                  uint8_t *payload,
-                                                  CXLDeviceState *cxlds,
-                                                  uint16_t *len)
+                                                  uint8_t *payload_in,
+                                                  size_t len_in,
+                                                  uint8_t *payload_out,
+                                                  size_t *len_out,
+                                                  CXLDeviceState *cxlds)
 {
     CXLEventInterruptPolicy *policy;
     CXLEventLog *log;
 
-    if (*len < CXL_EVENT_INT_SETTING_MIN_LEN) {
+    if (len_in < CXL_EVENT_INT_SETTING_MIN_LEN) {
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
-    policy = (CXLEventInterruptPolicy *)payload;
+    policy = (CXLEventInterruptPolicy *)payload_in;
 
     log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
     log->irq_enabled = (policy->info_settings & CXL_EVENT_INT_MODE_MASK) ==
@@ -181,7 +187,7 @@ static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *cmd,
                         CXL_INT_MSI_MSIX;
 
     /* DCD is optional */
-    if (*len < sizeof(*policy)) {
+    if (len_in < sizeof(*policy)) {
         return CXL_MBOX_SUCCESS;
     }
 
@@ -189,15 +195,17 @@ static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *cmd,
     log->irq_enabled = (policy->dyn_cap_settings & CXL_EVENT_INT_MODE_MASK) ==
                         CXL_INT_MSI_MSIX;
 
-    *len = sizeof(*policy);
+    *len_out = 0;
     return CXL_MBOX_SUCCESS;
 }
 
 /* 8.2.9.2.1 */
 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
-                                               uint8_t *payload,
-                                               CXLDeviceState *cxl_dstate,
-                                               uint16_t *len)
+                                               uint8_t *payload_in,
+                                               size_t len,
+                                               uint8_t *payload_out,
+                                               size_t *len_out,
+                                               CXLDeviceState *cxl_dstate)
 {
     struct {
         uint8_t slots_supported;
@@ -216,7 +224,7 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
-    fw_info = (void *)payload;
+    fw_info = (void *)payload_out;
     memset(fw_info, 0, sizeof(*fw_info));
 
     fw_info->slots_supported = 2;
@@ -224,36 +232,40 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
     fw_info->caps = 0;
     pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
 
-    *len = sizeof(*fw_info);
+    *len_out = sizeof(*fw_info);
     return CXL_MBOX_SUCCESS;
 }
 
 /* 8.2.9.3.1 */
 static CXLRetCode cmd_timestamp_get(const struct cxl_cmd *cmd,
-                                    uint8_t *payload,
-                                    CXLDeviceState *cxl_dstate,
-                                    uint16_t *len)
+                                    uint8_t *payload_in,
+                                    size_t len_in,
+                                    uint8_t *payload_out,
+                                    size_t *len_out,
+                                    CXLDeviceState *cxl_dstate)
 {
     uint64_t final_time = cxl_device_get_timestamp(cxl_dstate);
 
-    stq_le_p(payload, final_time);
-    *len = 8;
+    stq_le_p(payload_out, final_time);
+    *len_out = 8;
 
     return CXL_MBOX_SUCCESS;
 }
 
 /* 8.2.9.3.2 */
 static CXLRetCode cmd_timestamp_set(const struct cxl_cmd *cmd,
-                                    uint8_t *payload,
-                                    CXLDeviceState *cxl_dstate,
-                                    uint16_t *len)
+                                    uint8_t *payload_in,
+                                    size_t len_in,
+                                    uint8_t *payload_out,
+                                    size_t *len_out,
+                                    CXLDeviceState *cxl_dstate)
 {
     cxl_dstate->timestamp.set = true;
     cxl_dstate->timestamp.last_set = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
-    cxl_dstate->timestamp.host_set = le64_to_cpu(*(uint64_t *)payload);
+    cxl_dstate->timestamp.host_set = le64_to_cpu(*(uint64_t *)payload_in);
 
-    *len = 0;
+    *len_out = 0;
     return CXL_MBOX_SUCCESS;
 }
 
@@ -265,9 +277,11 @@ static const QemuUUID cel_uuid = {
 
 /* 8.2.9.4.1 */
 static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
-                                         uint8_t *payload,
-                                         CXLDeviceState *cxl_dstate,
-                                         uint16_t *len)
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLDeviceState *cxl_dstate)
 {
     struct {
         uint16_t entries;
@@ -276,22 +290,24 @@ static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
             QemuUUID uuid;
             uint32_t size;
         } log_entries[1];
-    } QEMU_PACKED *supported_logs = (void *)payload;
+    } QEMU_PACKED *supported_logs = (void *)payload_out;
     QEMU_BUILD_BUG_ON(sizeof(*supported_logs) != 0x1c);
 
     supported_logs->entries = 1;
     supported_logs->log_entries[0].uuid = cel_uuid;
     supported_logs->log_entries[0].size = 4 * cxl_dstate->cel_size;
 
-    *len = sizeof(*supported_logs);
+    *len_out = sizeof(*supported_logs);
     return CXL_MBOX_SUCCESS;
 }
 
 /* 8.2.9.4.2 */
 static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
-                                   uint8_t *payload,
-                                   CXLDeviceState *cxl_dstate,
-                                   uint16_t *len)
+                                   uint8_t *payload_in,
+                                   size_t len_in,
+                                   uint8_t *payload_out,
+                                   size_t *len_out,
+                                   CXLDeviceState *cxl_dstate)
 {
     struct {
         QemuUUID uuid;
@@ -299,7 +315,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
         uint32_t length;
     } QEMU_PACKED QEMU_ALIGNED(16) *get_log;
 
-    get_log = (void *)payload;
+    get_log = (void *)payload_in;
 
     /*
      * 8.2.9.4.2
@@ -323,19 +339,21 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
     }
 
     /* Store off everything to local variables so we can wipe out the payload */
-    *len = get_log->length;
+    *len_out = get_log->length;
 
-    memmove(payload, cxl_dstate->cel_log + get_log->offset,
-           get_log->length);
+    memmove(payload_out, cxl_dstate->cel_log + get_log->offset,
+            get_log->length);
 
     return CXL_MBOX_SUCCESS;
 }
 
 /* 8.2.9.5.1.1 */
 static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
-                                             uint8_t *payload,
-                                             CXLDeviceState *cxl_dstate,
-                                             uint16_t *len)
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLDeviceState *cxl_dstate)
 {
     struct {
         char fw_revision[0x10];
@@ -363,7 +381,7 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
-    id = (void *)payload;
+    id = (void *)payload_out;
     memset(id, 0, sizeof(*id));
 
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
@@ -380,21 +398,23 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     /* No limit - so limited by main poison record limit */
     stw_le_p(&id->inject_poison_limit, 0);
 
-    *len = sizeof(*id);
+    *len_out = sizeof(*id);
     return CXL_MBOX_SUCCESS;
 }
 
 static CXLRetCode cmd_ccls_get_partition_info(const struct cxl_cmd *cmd,
-                                              uint8_t *payload,
-                                              CXLDeviceState *cxl_dstate,
-                                              uint16_t *len)
+                                              uint8_t *payload_in,
+                                              size_t len_in,
+                                              uint8_t *payload_out,
+                                              size_t *len_out,
+                                              CXLDeviceState *cxl_dstate)
 {
     struct {
         uint64_t active_vmem;
         uint64_t active_pmem;
         uint64_t next_vmem;
         uint64_t next_pmem;
-    } QEMU_PACKED *part_info = (void *)payload;
+    } QEMU_PACKED *part_info = (void *)payload_out;
     QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
 
     if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
@@ -413,14 +433,16 @@ static CXLRetCode cmd_ccls_get_partition_info(const struct cxl_cmd *cmd,
              cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
     stq_le_p(&part_info->next_pmem, 0);
 
-    *len = sizeof(*part_info);
+    *len_out = sizeof(*part_info);
     return CXL_MBOX_SUCCESS;
 }
 
 static CXLRetCode cmd_ccls_get_lsa(const struct cxl_cmd *cmd,
-                                   uint8_t *payload,
-                                   CXLDeviceState *cxl_dstate,
-                                   uint16_t *len)
+                                   uint8_t *payload_in,
+                                   size_t len_in,
+                                   uint8_t *payload_out,
+                                   size_t *len_out,
+                                   CXLDeviceState *cxl_dstate)
 {
     struct {
         uint32_t offset;
@@ -430,46 +452,47 @@ static CXLRetCode cmd_ccls_get_lsa(const struct cxl_cmd *cmd,
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     uint32_t offset, length;
 
-    get_lsa = (void *)payload;
+    get_lsa = (void *)payload_in;
     offset = get_lsa->offset;
     length = get_lsa->length;
 
     if (offset + length > cvc->get_lsa_size(ct3d)) {
-        *len = 0;
+        *len_out = 0;
         return CXL_MBOX_INVALID_INPUT;
     }
 
-    *len = cvc->get_lsa(ct3d, get_lsa, length, offset);
+    *len_out = cvc->get_lsa(ct3d, payload_out, length, offset);
     return CXL_MBOX_SUCCESS;
 }
 
 static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
-                                   uint8_t *payload,
-                                   CXLDeviceState *cxl_dstate,
-                                   uint16_t *len)
+                                   uint8_t *payload_in,
+                                   size_t len_in,
+                                   uint8_t *payload_out,
+                                   size_t *len_out,
+                                   CXLDeviceState *cxl_dstate)
 {
     struct set_lsa_pl {
         uint32_t offset;
         uint32_t rsvd;
         uint8_t data[];
     } QEMU_PACKED;
-    struct set_lsa_pl *set_lsa_payload = (void *)payload;
+    struct set_lsa_pl *set_lsa_payload = (void *)payload_in;
     CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     const size_t hdr_len = offsetof(struct set_lsa_pl, data);
-    uint16_t plen = *len;
 
-    *len = 0;
-    if (!plen) {
+    *len_out = 0;
+    if (!len_in) {
         return CXL_MBOX_SUCCESS;
     }
 
-    if (set_lsa_payload->offset + plen > cvc->get_lsa_size(ct3d) + hdr_len) {
+    if (set_lsa_payload->offset + len_in > cvc->get_lsa_size(ct3d) + hdr_len) {
         return CXL_MBOX_INVALID_INPUT;
     }
-    plen -= hdr_len;
+    len_in -= hdr_len;
 
-    cvc->set_lsa(ct3d, set_lsa_payload->data, plen, set_lsa_payload->offset);
+    cvc->set_lsa(ct3d, set_lsa_payload->data, len_in, set_lsa_payload->offset);
     return CXL_MBOX_SUCCESS;
 }
 
@@ -480,9 +503,11 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
  * testing that kernel functionality.
  */
 static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
-                                            uint8_t *payload,
-                                            CXLDeviceState *cxl_dstate,
-                                            uint16_t *len)
+                                            uint8_t *payload_in,
+                                            size_t len_in,
+                                            uint8_t *payload_out,
+                                            size_t *len_out,
+                                            CXLDeviceState *cxl_dstate)
 {
     struct get_poison_list_pl {
         uint64_t pa;
@@ -502,8 +527,8 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
         } QEMU_PACKED records[];
     } QEMU_PACKED;
 
-    struct get_poison_list_pl *in = (void *)payload;
-    struct get_poison_list_out_pl *out = (void *)payload;
+    struct get_poison_list_pl *in = (void *)payload_in;
+    struct get_poison_list_out_pl *out = (void *)payload_out;
     CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
     uint16_t record_count = 0, i = 0;
     uint64_t query_start, query_length;
@@ -552,14 +577,16 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
         stq_le_p(&out->overflow_timestamp, ct3d->poison_list_overflow_ts);
     }
     stw_le_p(&out->count, record_count);
-    *len = out_pl_len;
+    *len_out = out_pl_len;
     return CXL_MBOX_SUCCESS;
 }
 
 static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
-                                          uint8_t *payload,
-                                          CXLDeviceState *cxl_dstate,
-                                          uint16_t *len_unused)
+                                          uint8_t *payload_in,
+                                          size_t len_in,
+                                          uint8_t *payload_out,
+                                          size_t *len_out,
+                                          CXLDeviceState *cxl_dstate)
 {
     CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
     CXLPoisonList *poison_list = &ct3d->poison_list;
@@ -567,7 +594,7 @@ static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
     struct inject_poison_pl {
         uint64_t dpa;
     };
-    struct inject_poison_pl *in = (void *)payload;
+    struct inject_poison_pl *in = (void *)payload_in;
     uint64_t dpa = ldq_le_p(&in->dpa);
     CXLPoison *p;
 
@@ -592,14 +619,17 @@ static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
      */
     QLIST_INSERT_HEAD(poison_list, p, node);
     ct3d->poison_list_cnt++;
+    *len_out = 0;
 
     return CXL_MBOX_SUCCESS;
 }
 
 static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
-                                         uint8_t *payload,
-                                         CXLDeviceState *cxl_dstate,
-                                         uint16_t *len_unused)
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLDeviceState *cxl_dstate)
 {
     CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
     CXLPoisonList *poison_list = &ct3d->poison_list;
@@ -611,7 +641,7 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     CXLPoison *ent;
     uint64_t dpa;
 
-    struct clear_poison_pl *in = (void *)payload;
+    struct clear_poison_pl *in = (void *)payload_in;
 
     dpa = ldq_le_p(&in->dpa);
     if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
@@ -672,6 +702,7 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     }
     /* Any fragments have been added, free original entry */
     g_free(ent);
+    *len_out = 0;
 
     return CXL_MBOX_SUCCESS;
 }
@@ -724,15 +755,24 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
 
     uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
     uint8_t cmd = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND);
-    uint16_t len = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
+    uint16_t len_in = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
     uint8_t *pl = cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYLOAD;
+    /*
+     * Copy taken to avoid need for individual command handlers to care
+     * about aliasing.
+     */
+    g_autofree uint8_t *pl_in_copy = NULL;
+    size_t len_out = 0;
 
+    pl_in_copy = g_memdup2(pl, len_in);
+    /* Avoid stale data - including from earlier commands */
+    memset(pl, 0, CXL_MAILBOX_MAX_PAYLOAD_SIZE);
     cxl_cmd = &cxl_dstate->cxl_cmd_set[set][cmd];
     h = cxl_cmd->handler;
     if (h) {
-        if (len == cxl_cmd->in || cxl_cmd->in == ~0) {
-            ret = (*h)(cxl_cmd, pl, cxl_dstate, &len);
-            assert(len <= cxl_dstate->payload_size);
+        if (len_in == cxl_cmd->in || cxl_cmd->in == ~0) {
+            ret = (*h)(cxl_cmd, pl_in_copy, len_in, pl, &len_out, cxl_dstate);
+            assert(len_out <= cxl_dstate->payload_size);
         } else {
             ret = CXL_MBOX_INVALID_PAYLOAD_LENGTH;
         }
@@ -748,7 +788,7 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
     /* Set the return length */
     command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET, 0);
     command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND, 0);
-    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH, len);
+    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH, len_out);
 
     cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD] = command_reg;
     cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
-- 
MST


