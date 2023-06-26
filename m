Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD3C73DF31
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:29:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlKc-0001km-0E; Mon, 26 Jun 2023 08:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKZ-0001iS-9M
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKX-0002lh-Au
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CvHv0xRrL+n4gHBfU6fz1bd4t5h8JYvFuitEDaGVga0=;
 b=Yq/BB65R5DXAY0JqHqfHHV+R5kRX5XRMN811zfgW6EYPSu8Mk8UMVdk952/pB9rAUwbuoZ
 NlsGiiLSCA2FeTemNErijAAwvCCOyAvIIoBAwxV9oRqGse4IulI1imvk3leR6jopM63nB9
 7vsgJ7fMt+mpR7Kj38abNC4oJPEHa3M=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-3Ly1rWS_OlSZ-iHBWYTRnQ-1; Mon, 26 Jun 2023 08:28:27 -0400
X-MC-Unique: 3Ly1rWS_OlSZ-iHBWYTRnQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b620465d0eso11924351fa.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782505; x=1690374505;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvHv0xRrL+n4gHBfU6fz1bd4t5h8JYvFuitEDaGVga0=;
 b=mIWSZewfIAQWRYSAi002RkH0eqg/6IAt2n6YYZTyIplDBhmzzhKzevIEVuQyMP+CFC
 OuHG278rMc+NGkMg9D6d2Lt1bhBkW309ccdSkw/cHMK3gviHEEW2Gouqpg4xSyWuFNbQ
 Hoc3Zo1kolcoko8EpZ0+uddlnreUKKQVKfd/rxl9mRJw0YspDcKN5IH/jMkJV1dC8xJA
 WFgN9UBpIwAgsoJS4aseewpuzkoFuahJJ322lyWrSGWllmFa2MKAjJ/XAfJWntv9Nx3x
 Zbq7TLFX8Ih/ZORfAKEKVem2sCyaOxQNhr5R0PBwSRtVPpFu3oViZhf4vl95/140LO13
 HvpQ==
X-Gm-Message-State: AC+VfDy3BOIssCnZt2foYC63s26LJ4NqepuJJustyWn6VFOb3Ah2pjAM
 7AhHeL0/axCXkjIdqeTv2JphTnXQP8l+lKNQn2hVrBcvTGHPLP/iQil9ZilPpBFhKEFo61oXQFv
 cXjMJCRpIv1xM0jp99u7A0CsKQD51kvZg5i3C634ej6t2RtikVSZnj6SmxSaVYyz627Xy
X-Received: by 2002:ac2:5de6:0:b0:4f7:6976:2070 with SMTP id
 z6-20020ac25de6000000b004f769762070mr16090142lfq.40.1687782505598; 
 Mon, 26 Jun 2023 05:28:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4TidHk/DVMiErVZn5VKGYv8G149EwkYEMljrTvIrfqRETKCjYRYLJRxI45YgbMV34JPiiUyw==
X-Received: by 2002:ac2:5de6:0:b0:4f7:6976:2070 with SMTP id
 z6-20020ac25de6000000b004f769762070mr16090117lfq.40.1687782504927; 
 Mon, 26 Jun 2023 05:28:24 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 t12-20020a7bc3cc000000b003f604793989sm10297184wmj.18.2023.06.26.05.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:28:24 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:28:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 Ira Weiny <ira.weiny@intel.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 11/53] hw/cxl/events: Add injection of Memory Module Events
Message-ID: <bafe03083255da3a053144b77a5fbc7dbf9494f3.1687782442.git.mst@redhat.com>
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

These events include a copy of the device health information at the
time of the event. Actually using the emulated device health would
require a lot of controls to manipulate that state.  Given the aim
of this injection code is to just test the flows when events occur,
inject the contents of the device health state as well.

Future work may add more sophisticate device health emulation
including direct generation of these records when events occur
(such as a temperature threshold being crossed).  That does not
reduce the usefulness of this more basic generation of the events.

Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230530133603.16934-8-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/cxl.json               | 53 +++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_events.h | 19 ++++++++++++
 hw/mem/cxl_type3.c          | 62 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    | 12 +++++++
 4 files changed, 146 insertions(+)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 2ad310387c..d5b5293eb5 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -140,6 +140,59 @@
             '*column': 'uint16', '*correction-mask': [ 'uint64' ]
            }}
 
+##
+# @cxl-inject-memory-module-event:
+#
+# Inject an event record for a Memory Module Event (CXL r3.0
+# 8.2.9.2.1.3).  This event includes a copy of the Device Health
+# info at the time of the event.
+#
+# @path: CXL type 3 device canonical QOM path
+#
+# @log: Event Log to add the event to
+#
+# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
+#     Record Format, Event Record Flags for subfield definitions.
+#
+# @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
+#     Event Record for bit definitions for bit definiions.
+#
+# @health-status: Overall health summary bitmap.  See CXL r3.0 Table
+#     8-100 Get Health Info Output Payload, Health Status for bit
+#     definitions.
+#
+# @media-status: Overall media health summary.  See CXL r3.0 Table
+#     8-100 Get Health Info Output Payload, Media Status for bit
+#     definitions.
+#
+# @additional-status: See CXL r3.0 Table 8-100 Get Health Info Output
+#     Payload, Additional Status for subfield definitions.
+#
+# @life-used: Percentage (0-100) of factory expected life span.
+#
+# @temperature: Device temperature in degrees Celsius.
+#
+# @dirty-shutdown-count: Number of times the device has been unable
+#     to determine whether data loss may have occurred.
+#
+# @corrected-volatile-error-count: Total number of correctable errors
+#     in volatile memory.
+#
+# @corrected-persistent-error-count: Total number of correctable
+#     errors in persistent memory
+#
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-memory-module-event',
+  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
+            'type': 'uint8', 'health-status': 'uint8',
+            'media-status': 'uint8', 'additional-status': 'uint8',
+            'life-used': 'uint8', 'temperature' : 'int16',
+            'dirty-shutdown-count': 'uint32',
+            'corrected-volatile-error-count': 'uint32',
+            'corrected-persistent-error-count': 'uint32'
+            }}
+
 ##
 # @cxl-inject-poison:
 #
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index a39e30d973..089ba2091f 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -146,4 +146,23 @@ typedef struct CXLEventDram {
     uint8_t reserved[0x17];
 } QEMU_PACKED CXLEventDram;
 
+/*
+ * Memory Module Event Record
+ * CXL Rev 3.0 Section 8.2.9.2.1.3: Table 8-45
+ * All fields little endian.
+ */
+typedef struct CXLEventMemoryModule {
+    CXLEventRecordHdr hdr;
+    uint8_t type;
+    uint8_t health_status;
+    uint8_t media_status;
+    uint8_t additional_status;
+    uint8_t life_used;
+    int16_t temperature;
+    uint32_t dirty_shutdown_count;
+    uint32_t corrected_volatile_error_count;
+    uint32_t corrected_persistent_error_count;
+    uint8_t reserved[0x3d];
+} QEMU_PACKED CXLEventMemoryModule;
+
 #endif /* CXL_EVENTS_H */
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3c07b1b7a3..4e314748d3 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1201,6 +1201,11 @@ static const QemuUUID dram_uuid = {
                  0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
 };
 
+static const QemuUUID memory_module_uuid = {
+    .data = UUID(0xfe927475, 0xdd59, 0x4339, 0xa5, 0x86,
+                 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
+};
+
 #define CXL_GMER_VALID_CHANNEL                          BIT(0)
 #define CXL_GMER_VALID_RANK                             BIT(1)
 #define CXL_GMER_VALID_DEVICE                           BIT(2)
@@ -1408,6 +1413,63 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
     return;
 }
 
+void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
+                                        uint8_t flags, uint8_t type,
+                                        uint8_t health_status,
+                                        uint8_t media_status,
+                                        uint8_t additional_status,
+                                        uint8_t life_used,
+                                        int16_t temperature,
+                                        uint32_t dirty_shutdown_count,
+                                        uint32_t corrected_volatile_error_count,
+                                        uint32_t corrected_persistent_error_count,
+                                        Error **errp)
+{
+    Object *obj = object_resolve_path(path, NULL);
+    CXLEventMemoryModule module;
+    CXLEventRecordHdr *hdr = &module.hdr;
+    CXLDeviceState *cxlds;
+    CXLType3Dev *ct3d;
+    uint8_t enc_log;
+    int rc;
+
+    if (!obj) {
+        error_setg(errp, "Unable to resolve path");
+        return;
+    }
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        error_setg(errp, "Path does not point to a CXL type 3 device");
+        return;
+    }
+    ct3d = CXL_TYPE3(obj);
+    cxlds = &ct3d->cxl_dstate;
+
+    rc = ct3d_qmp_cxl_event_log_enc(log);
+    if (rc < 0) {
+        error_setg(errp, "Unhandled error log type");
+        return;
+    }
+    enc_log = rc;
+
+    memset(&module, 0, sizeof(module));
+    cxl_assign_event_header(hdr, &memory_module_uuid, flags, sizeof(module),
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+
+    module.type = type;
+    module.health_status = health_status;
+    module.media_status = media_status;
+    module.additional_status = additional_status;
+    module.life_used = life_used;
+    stw_le_p(&module.temperature, temperature);
+    stl_le_p(&module.dirty_shutdown_count, dirty_shutdown_count);
+    stl_le_p(&module.corrected_volatile_error_count, corrected_volatile_error_count);
+    stl_le_p(&module.corrected_persistent_error_count, corrected_persistent_error_count);
+
+    if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&module)) {
+        cxl_event_irq_assert(ct3d);
+    }
+}
+
 static void ct3_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index e904c5d089..f3e4a9fa72 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -26,6 +26,18 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
                                bool has_correction_mask, uint64List *correction_mask,
                                Error **errp) {}
 
+void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
+                                        uint8_t flags, uint8_t type,
+                                        uint8_t health_status,
+                                        uint8_t media_status,
+                                        uint8_t additional_status,
+                                        uint8_t life_used,
+                                        int16_t temperature,
+                                        uint32_t dirty_shutdown_count,
+                                        uint32_t corrected_volatile_error_count,
+                                        uint32_t corrected_persistent_error_count,
+                                        Error **errp) {}
+
 void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
                            Error **errp)
 {
-- 
MST


