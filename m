Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F485926BC6
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jul 2024 00:47:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8kL-0008CF-BN; Wed, 03 Jul 2024 18:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8kE-0007eT-8p
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:46:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8k8-0001Sq-6x
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=luTRPHAeeb1OyXMCpOc0nu4ARMny/qSptOQ/dYaP6qI=;
 b=TF7xiXfDOg9eDjl+8c5ay8ZwMA78r7jtg8gvfdaOD3NHGthkHdvLzopO+uWXqn3BT28/0t
 wLB5VRHBa7sBNGPSeqa9p7mHRRHYcJbGcus02HBmaLtxOR02PfDrbl1/nMJY1ar6o8/4un
 66uSqW9C1QNViVZcNBTN9Q93KnXsv7I=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-fY9txIauOeehXHGWGeZE9A-1; Wed, 03 Jul 2024 18:46:23 -0400
X-MC-Unique: fY9txIauOeehXHGWGeZE9A-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-584ef6c00c0so1684542a12.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046782; x=1720651582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=luTRPHAeeb1OyXMCpOc0nu4ARMny/qSptOQ/dYaP6qI=;
 b=bQV/Ls/paxAam+IfjI7aPg9ax2zExrE95ArV0x83FTNv25Mz7gPd/huLmhh5wipT25
 IlnZopaOQEfD5hwo5bszG9IiIcrKzp0U1dElDg9hzzbQX1cNgZfTlh34VDjFmX/PAHL5
 x+4BsDO4lZbAQLpMP0aza9JajIpxDwmhdugX377ce+rLjoTuYqkC2/SvuKrYgQoXbzdJ
 WuT+AL41rvdlCiyqW8vGE7PRfeSN1f0627Fhib87G25Kd58gaRLKa0wOZXl0sr9JJWjg
 6mDcABMC/aK2MVl7xMvE4fkT3sVPUTLWMf7pyRMB0NMcNUMt5WTkV47wxJHhrs8pxqew
 wCIQ==
X-Gm-Message-State: AOJu0YwPBIufYFklyfHf5mrFDFh8nK/0AF5/7+IKxO2Zx80Z/131HARM
 ixXPQPr+Rk5/mSdofVwnSkW0/+KcxBBfuUca5rDfBnVUJH0LE2a6MfjatIPTscrZwYN2+qZfJTB
 YiqMj5doPQwdQQ/5ajKZbxBswibPIFAMctTFm3LqtOrsCr12n9Jeum9viqagQcPENqW+e3JgFYN
 Rj1XgjKdb6q9jsLtqWpP46mP8G2FIlkg==
X-Received: by 2002:a17:906:f253:b0:a77:a1f1:cfa0 with SMTP id
 a640c23a62f3a-a77a24bf96bmr190754866b.36.1720046781908; 
 Wed, 03 Jul 2024 15:46:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg2wT/M13CEH2K+OZvTHPj3LYd3kxJxOq9Cohn/BEelMSHnHDXIUN7MQ5zDXw4mbfbB/WWog==
X-Received: by 2002:a17:906:f253:b0:a77:a1f1:cfa0 with SMTP id
 a640c23a62f3a-a77a24bf96bmr190751966b.36.1720046780436; 
 Wed, 03 Jul 2024 15:46:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab08fb70sm543323566b.180.2024.07.03.15.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:46:19 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:46:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Svetly Todorov <svetly.todorov@memverge.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL v3 26/85] hw/cxl/events: Add qmp interfaces to add/release
 dynamic capacity extents
Message-ID: <d0b9b28a5b9f1e3d22b508f4f05d903a4b443e38.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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

To simulate FM functionalities for initiating Dynamic Capacity Add
(Opcode 5604h) and Dynamic Capacity Release (Opcode 5605h) as in CXL spec
r3.1 7.6.7.6.5 and 7.6.7.6.6, we implemented two QMP interfaces to issue
add/release dynamic capacity extents requests.

With the change, we allow to release an extent only when its DPA range
is contained by a single accepted extent in the device. That is to say,
extent superset release is not supported yet.

1. Add dynamic capacity extents:

For example, the command to add two continuous extents (each 128MiB long)
to region 0 (starting at DPA offset 0) looks like below:

{ "execute": "qmp_capabilities" }

{ "execute": "cxl-add-dynamic-capacity",
  "arguments": {
      "path": "/machine/peripheral/cxl-dcd0",
      "host-id": 0,
      "selection-policy": "prescriptive",
      "region": 0,
      "extents": [
      {
          "offset": 0,
          "len": 134217728
      },
      {
          "offset": 134217728,
          "len": 134217728
      }
      ]
  }
}

2. Release dynamic capacity extents:

For example, the command to release an extent of size 128MiB from region 0
(DPA offset 128MiB) looks like below:

{ "execute": "cxl-release-dynamic-capacity",
  "arguments": {
      "path": "/machine/peripheral/cxl-dcd0",
      "host-id": 0,
      "removal-policy":"prescriptive",
      "region": 0,
      "extents": [
      {
          "offset": 134217728,
          "len": 134217728
      }
      ]
  }
}

Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20240523174651.1089554-12-nifan.cxl@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/cxl.json               | 143 +++++++++++++++++
 include/hw/cxl/cxl_device.h |  22 +++
 include/hw/cxl/cxl_events.h |  18 +++
 hw/cxl/cxl-mailbox-utils.c  |  62 ++++++--
 hw/mem/cxl_type3.c          | 306 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3_stubs.c    |  25 +++
 6 files changed, 563 insertions(+), 13 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 4281726dec..57d9f82014 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -361,3 +361,146 @@
 ##
 {'command': 'cxl-inject-correctable-error',
  'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
+
+##
+# @CXLDynamicCapacityExtent:
+#
+# A single dynamic capacity extent
+#
+# @offset: The offset (in bytes) to the start of the region
+#     where the extent belongs to.
+#
+# @len: The length of the extent in bytes.
+#
+# Since: 9.1
+##
+{ 'struct': 'CXLDynamicCapacityExtent',
+  'data': {
+      'offset':'uint64',
+      'len': 'uint64'
+  }
+}
+
+##
+# @CXLExtSelPolicy:
+#
+# The policy to use for selecting which extents comprise the added
+# capacity, as defined in cxl spec r3.1 Table 7-70.
+#
+# @free: 0h = Free
+#
+# @contiguous: 1h = Continuous
+#
+# @prescriptive: 2h = Prescriptive
+#
+# @enable-shared-access: 3h = Enable Shared Access
+#
+# Since: 9.1
+##
+{ 'enum': 'CXLExtSelPolicy',
+  'data': ['free',
+           'contiguous',
+           'prescriptive',
+           'enable-shared-access']
+}
+
+##
+# @cxl-add-dynamic-capacity:
+#
+# Command to initiate to add dynamic capacity extents to a host.  It
+# simulates operations defined in cxl spec r3.1 7.6.7.6.5.
+#
+# @path: CXL DCD canonical QOM path.
+#
+# @host-id: The "Host ID" field as defined in cxl spec r3.1
+#     Table 7-70.
+#
+# @selection-policy: The "Selection Policy" bits as defined in
+#     cxl spec r3.1 Table 7-70.  It specifies the policy to use for
+#     selecting which extents comprise the added capacity.
+#
+# @region: The "Region Number" field as defined in cxl spec r3.1
+#     Table 7-70.  The dynamic capacity region where the capacity
+#     is being added.  Valid range is from 0-7.
+#
+# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-70.
+#
+# @extents: The "Extent List" field as defined in cxl spec r3.1
+#     Table 7-70.
+#
+# Since : 9.1
+##
+{ 'command': 'cxl-add-dynamic-capacity',
+  'data': { 'path': 'str',
+            'host-id': 'uint16',
+            'selection-policy': 'CXLExtSelPolicy',
+            'region': 'uint8',
+            '*tag': 'str',
+            'extents': [ 'CXLDynamicCapacityExtent' ]
+           }
+}
+
+##
+# @CXLExtRemovalPolicy:
+#
+# The policy to use for selecting which extents comprise the released
+# capacity, defined in the "Flags" field in cxl spec r3.1 Table 7-71.
+#
+# @tag-based: value = 0h.  Extents are selected by the device based
+#     on tag, with no requirement for contiguous extents.
+#
+# @prescriptive: value = 1h.  Extent list of capacity to release is
+#     included in the request payload.
+#
+# Since: 9.1
+##
+{ 'enum': 'CXLExtRemovalPolicy',
+  'data': ['tag-based',
+           'prescriptive']
+}
+
+##
+# @cxl-release-dynamic-capacity:
+#
+# Command to initiate to release dynamic capacity extents from a
+# host.  It simulates operations defined in cxl spec r3.1 7.6.7.6.6.
+#
+# @path: CXL DCD canonical QOM path.
+#
+# @host-id: The "Host ID" field as defined in cxl spec r3.1
+#     Table 7-71.
+#
+# @removal-policy: Bit[3:0] of the "Flags" field as defined in cxl
+#     spec r3.1 Table 7-71.
+#
+# @forced-removal: Bit[4] of the "Flags" field in cxl spec r3.1
+#     Table 7-71.  When set, device does not wait for a Release
+#     Dynamic Capacity command from the host.  Host immediately
+#     loses access to released capacity.
+#
+# @sanitize-on-release: Bit[5] of the "Flags" field in cxl spec r3.1
+#     Table 7-71.  When set, device should sanitize all released
+#     capacity as a result of this request.
+#
+# @region: The "Region Number" field as defined in cxl spec r3.1
+#     Table 7-71.  The dynamic capacity region where the capacity
+#     is being added.  Valid range is from 0-7.
+#
+# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-71.
+#
+# @extents: The "Extent List" field as defined in cxl spec r3.1
+#     Table 7-71.
+#
+# Since : 9.1
+##
+{ 'command': 'cxl-release-dynamic-capacity',
+  'data': { 'path': 'str',
+            'host-id': 'uint16',
+            'removal-policy': 'CXLExtRemovalPolicy',
+            '*forced-removal': 'bool',
+            '*sanitize-on-release': 'bool',
+            'region': 'uint8',
+            '*tag': 'str',
+            'extents': [ 'CXLDynamicCapacityExtent' ]
+           }
+}
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index df3511e91b..c69ff6b5de 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -443,6 +443,12 @@ typedef struct CXLDCExtent {
 } CXLDCExtent;
 typedef QTAILQ_HEAD(, CXLDCExtent) CXLDCExtentList;
 
+typedef struct CXLDCExtentGroup {
+    CXLDCExtentList list;
+    QTAILQ_ENTRY(CXLDCExtentGroup) node;
+} CXLDCExtentGroup;
+typedef QTAILQ_HEAD(, CXLDCExtentGroup) CXLDCExtentGroupList;
+
 typedef struct CXLDCRegion {
     uint64_t base;       /* aligned to 256*MiB */
     uint64_t decode_len; /* aligned to 256*MiB */
@@ -494,6 +500,7 @@ struct CXLType3Dev {
          */
         uint64_t total_capacity; /* 256M aligned */
         CXLDCExtentList extents;
+        CXLDCExtentGroupList extents_pending;
         uint32_t total_extent_count;
         uint32_t ext_list_gen_seq;
 
@@ -555,4 +562,19 @@ CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
 
 void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
                                         CXLDCExtent *extent);
+void cxl_insert_extent_to_extent_list(CXLDCExtentList *list, uint64_t dpa,
+                                      uint64_t len, uint8_t *tag,
+                                      uint16_t shared_seq);
+bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
+                       unsigned long size);
+bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
+                                    uint64_t dpa, uint64_t len);
+CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
+                                                    uint64_t dpa,
+                                                    uint64_t len,
+                                                    uint8_t *tag,
+                                                    uint16_t shared_seq);
+void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
+                                       CXLDCExtentGroup *group);
+void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
 #endif
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 5170b8dbf8..38cadaa0f3 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -166,4 +166,22 @@ typedef struct CXLEventMemoryModule {
     uint8_t reserved[0x3d];
 } QEMU_PACKED CXLEventMemoryModule;
 
+/*
+ * CXL r3.1 section Table 8-50: Dynamic Capacity Event Record
+ * All fields little endian.
+ */
+typedef struct CXLEventDynamicCapacity {
+    CXLEventRecordHdr hdr;
+    uint8_t type;
+    uint8_t validity_flags;
+    uint16_t host_id;
+    uint8_t updated_region_id;
+    uint8_t flags;
+    uint8_t reserved2[2];
+    uint8_t dynamic_capacity_extent[0x28]; /* defined in cxl_device.h */
+    uint8_t reserved[0x18];
+    uint32_t extents_avail;
+    uint32_t tags_avail;
+} QEMU_PACKED CXLEventDynamicCapacity;
+
 #endif /* CXL_EVENTS_H */
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index e322407fb3..64387f34ce 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1405,7 +1405,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
  * Check whether any bit between addr[nr, nr+size) is set,
  * return true if any bit is set, otherwise return false
  */
-static bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
+bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
                               unsigned long size)
 {
     unsigned long res = find_next_bit(addr, size + nr, nr);
@@ -1444,7 +1444,7 @@ CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len)
     return NULL;
 }
 
-static void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
+void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
                                              uint64_t dpa,
                                              uint64_t len,
                                              uint8_t *tag,
@@ -1470,6 +1470,44 @@ void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
     g_free(extent);
 }
 
+/*
+ * Add a new extent to the extent "group" if group exists;
+ * otherwise, create a new group
+ * Return value: the extent group where the extent is inserted.
+ */
+CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
+                                                    uint64_t dpa,
+                                                    uint64_t len,
+                                                    uint8_t *tag,
+                                                    uint16_t shared_seq)
+{
+    if (!group) {
+        group = g_new0(CXLDCExtentGroup, 1);
+        QTAILQ_INIT(&group->list);
+    }
+    cxl_insert_extent_to_extent_list(&group->list, dpa, len,
+                                     tag, shared_seq);
+    return group;
+}
+
+void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
+                                       CXLDCExtentGroup *group)
+{
+    QTAILQ_INSERT_TAIL(list, group, node);
+}
+
+void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
+{
+    CXLDCExtent *ent, *ent_next;
+    CXLDCExtentGroup *group = QTAILQ_FIRST(list);
+
+    QTAILQ_REMOVE(list, group, node);
+    QTAILQ_FOREACH_SAFE(ent, &group->list, node, ent_next) {
+        cxl_remove_extent_from_extent_list(&group->list, ent);
+    }
+    g_free(group);
+}
+
 /*
  * CXL r3.1 Table 8-168: Add Dynamic Capacity Response Input Payload
  * CXL r3.1 Table 8-170: Release Dynamic Capacity Input Payload
@@ -1541,6 +1579,7 @@ static CXLRetCode cxl_dcd_add_dyn_cap_rsp_dry_run(CXLType3Dev *ct3d,
 {
     uint32_t i;
     CXLDCExtent *ent;
+    CXLDCExtentGroup *ext_group;
     uint64_t dpa, len;
     Range range1, range2;
 
@@ -1551,9 +1590,13 @@ static CXLRetCode cxl_dcd_add_dyn_cap_rsp_dry_run(CXLType3Dev *ct3d,
         range_init_nofail(&range1, dpa, len);
 
         /*
-         * TODO: once the pending extent list is added, check against
-         * the list will be added here.
+         * The host-accepted DPA range must be contained by the first extent
+         * group in the pending list
          */
+        ext_group = QTAILQ_FIRST(&ct3d->dc.extents_pending);
+        if (!cxl_extents_contains_dpa_range(&ext_group->list, dpa, len)) {
+            return CXL_MBOX_INVALID_PA;
+        }
 
         /* to-be-added range should not overlap with range already accepted */
         QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
@@ -1586,10 +1629,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     CXLRetCode ret;
 
     if (in->num_entries_updated == 0) {
-        /*
-         * TODO: once the pending list is introduced, extents in the beginning
-         * will get wiped out.
-         */
+        cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
         return CXL_MBOX_SUCCESS;
     }
 
@@ -1615,11 +1655,9 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
 
         cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
         ct3d->dc.total_extent_count += 1;
-        /*
-         * TODO: we will add a pending extent list based on event log record
-         * and process the list accordingly here.
-         */
     }
+    /* Remove the first extent group in the pending list */
+    cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
 
     return CXL_MBOX_SUCCESS;
 }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index db5191b3b7..f53bcca6d3 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -674,6 +674,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
         ct3d->dc.total_capacity += region->len;
     }
     QTAILQ_INIT(&ct3d->dc.extents);
+    QTAILQ_INIT(&ct3d->dc.extents_pending);
 
     return true;
 }
@@ -681,10 +682,19 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
 static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
 {
     CXLDCExtent *ent, *ent_next;
+    CXLDCExtentGroup *group, *group_next;
 
     QTAILQ_FOREACH_SAFE(ent, &ct3d->dc.extents, node, ent_next) {
         cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
     }
+
+    QTAILQ_FOREACH_SAFE(group, &ct3d->dc.extents_pending, node, group_next) {
+        QTAILQ_REMOVE(&ct3d->dc.extents_pending, group, node);
+        QTAILQ_FOREACH_SAFE(ent, &group->list, node, ent_next) {
+            cxl_remove_extent_from_extent_list(&group->list, ent);
+        }
+        g_free(group);
+    }
 }
 
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
@@ -1449,7 +1459,6 @@ static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
         return CXL_EVENT_TYPE_FAIL;
     case CXL_EVENT_LOG_FATAL:
         return CXL_EVENT_TYPE_FATAL;
-/* DCD not yet supported */
     default:
         return -EINVAL;
     }
@@ -1700,6 +1709,301 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
     }
 }
 
+/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
+static const QemuUUID dynamic_capacity_uuid = {
+    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
+                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
+};
+
+typedef enum CXLDCEventType {
+    DC_EVENT_ADD_CAPACITY = 0x0,
+    DC_EVENT_RELEASE_CAPACITY = 0x1,
+    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
+    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
+    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
+    DC_EVENT_CAPACITY_RELEASED = 0x5,
+} CXLDCEventType;
+
+/*
+ * Check whether the range [dpa, dpa + len - 1] has overlaps with extents in
+ * the list.
+ * Return value: return true if has overlaps; otherwise, return false
+ */
+static bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
+                                           uint64_t dpa, uint64_t len)
+{
+    CXLDCExtent *ent;
+    Range range1, range2;
+
+    if (!list) {
+        return false;
+    }
+
+    range_init_nofail(&range1, dpa, len);
+    QTAILQ_FOREACH(ent, list, node) {
+        range_init_nofail(&range2, ent->start_dpa, ent->len);
+        if (range_overlaps_range(&range1, &range2)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+/*
+ * Check whether the range [dpa, dpa + len - 1] is contained by extents in
+ * the list.
+ * Will check multiple extents containment once superset release is added.
+ * Return value: return true if range is contained; otherwise, return false
+ */
+bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
+                                    uint64_t dpa, uint64_t len)
+{
+    CXLDCExtent *ent;
+    Range range1, range2;
+
+    if (!list) {
+        return false;
+    }
+
+    range_init_nofail(&range1, dpa, len);
+    QTAILQ_FOREACH(ent, list, node) {
+        range_init_nofail(&range2, ent->start_dpa, ent->len);
+        if (range_contains_range(&range2, &range1)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
+                                                 uint64_t dpa, uint64_t len)
+{
+    CXLDCExtentGroup *group;
+
+    if (!list) {
+        return false;
+    }
+
+    QTAILQ_FOREACH(group, list, node) {
+        if (cxl_extents_overlaps_dpa_range(&group->list, dpa, len)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+/*
+ * The main function to process dynamic capacity event with extent list.
+ * Currently DC extents add/release requests are processed.
+ */
+static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
+        uint16_t hid, CXLDCEventType type, uint8_t rid,
+        CXLDynamicCapacityExtentList *records, Error **errp)
+{
+    Object *obj;
+    CXLEventDynamicCapacity dCap = {};
+    CXLEventRecordHdr *hdr = &dCap.hdr;
+    CXLType3Dev *dcd;
+    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
+    uint32_t num_extents = 0;
+    CXLDynamicCapacityExtentList *list;
+    CXLDCExtentGroup *group = NULL;
+    g_autofree CXLDCExtentRaw *extents = NULL;
+    uint8_t enc_log = CXL_EVENT_TYPE_DYNAMIC_CAP;
+    uint64_t dpa, offset, len, block_size;
+    g_autofree unsigned long *blk_bitmap = NULL;
+    int i;
+
+    obj = object_resolve_path_type(path, TYPE_CXL_TYPE3, NULL);
+    if (!obj) {
+        error_setg(errp, "Unable to resolve CXL type 3 device");
+        return;
+    }
+
+    dcd = CXL_TYPE3(obj);
+    if (!dcd->dc.num_regions) {
+        error_setg(errp, "No dynamic capacity support from the device");
+        return;
+    }
+
+
+    if (rid >= dcd->dc.num_regions) {
+        error_setg(errp, "region id is too large");
+        return;
+    }
+    block_size = dcd->dc.regions[rid].block_size;
+    blk_bitmap = bitmap_new(dcd->dc.regions[rid].len / block_size);
+
+    /* Sanity check and count the extents */
+    list = records;
+    while (list) {
+        offset = list->value->offset;
+        len = list->value->len;
+        dpa = offset + dcd->dc.regions[rid].base;
+
+        if (len == 0) {
+            error_setg(errp, "extent with 0 length is not allowed");
+            return;
+        }
+
+        if (offset % block_size || len % block_size) {
+            error_setg(errp, "dpa or len is not aligned to region block size");
+            return;
+        }
+
+        if (offset + len > dcd->dc.regions[rid].len) {
+            error_setg(errp, "extent range is beyond the region end");
+            return;
+        }
+
+        /* No duplicate or overlapped extents are allowed */
+        if (test_any_bits_set(blk_bitmap, offset / block_size,
+                              len / block_size)) {
+            error_setg(errp, "duplicate or overlapped extents are detected");
+            return;
+        }
+        bitmap_set(blk_bitmap, offset / block_size, len / block_size);
+
+        if (type == DC_EVENT_RELEASE_CAPACITY) {
+            if (cxl_extent_groups_overlaps_dpa_range(&dcd->dc.extents_pending,
+                                                     dpa, len)) {
+                error_setg(errp,
+                           "cannot release extent with pending DPA range");
+                return;
+            }
+            if (!cxl_extents_contains_dpa_range(&dcd->dc.extents, dpa, len)) {
+                error_setg(errp,
+                           "cannot release extent with non-existing DPA range");
+                return;
+            }
+        } else if (type == DC_EVENT_ADD_CAPACITY) {
+            if (cxl_extents_overlaps_dpa_range(&dcd->dc.extents, dpa, len)) {
+                error_setg(errp,
+                           "cannot add DPA already accessible to the same LD");
+                return;
+            }
+            if (cxl_extent_groups_overlaps_dpa_range(&dcd->dc.extents_pending,
+                                                     dpa, len)) {
+                error_setg(errp,
+                           "cannot add DPA again while still pending");
+                return;
+            }
+        }
+        list = list->next;
+        num_extents++;
+    }
+
+    /* Create extent list for event being passed to host */
+    i = 0;
+    list = records;
+    extents = g_new0(CXLDCExtentRaw, num_extents);
+    while (list) {
+        offset = list->value->offset;
+        len = list->value->len;
+        dpa = dcd->dc.regions[rid].base + offset;
+
+        extents[i].start_dpa = dpa;
+        extents[i].len = len;
+        memset(extents[i].tag, 0, 0x10);
+        extents[i].shared_seq = 0;
+        if (type == DC_EVENT_ADD_CAPACITY) {
+            group = cxl_insert_extent_to_extent_group(group,
+                                                      extents[i].start_dpa,
+                                                      extents[i].len,
+                                                      extents[i].tag,
+                                                      extents[i].shared_seq);
+        }
+
+        list = list->next;
+        i++;
+    }
+    if (group) {
+        cxl_extent_group_list_insert_tail(&dcd->dc.extents_pending, group);
+    }
+
+    /*
+     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
+     *
+     * All Dynamic Capacity event records shall set the Event Record Severity
+     * field in the Common Event Record Format to Informational Event. All
+     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
+     * Event Log.
+     */
+    cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
+                            cxl_device_get_timestamp(&dcd->cxl_dstate));
+
+    dCap.type = type;
+    /* FIXME: for now, validity flag is cleared */
+    dCap.validity_flags = 0;
+    stw_le_p(&dCap.host_id, hid);
+    /* only valid for DC_REGION_CONFIG_UPDATED event */
+    dCap.updated_region_id = 0;
+    dCap.flags = 0;
+    for (i = 0; i < num_extents; i++) {
+        memcpy(&dCap.dynamic_capacity_extent, &extents[i],
+               sizeof(CXLDCExtentRaw));
+
+        if (i < num_extents - 1) {
+            /* Set "More" flag */
+            dCap.flags |= BIT(0);
+        }
+
+        if (cxl_event_insert(&dcd->cxl_dstate, enc_log,
+                             (CXLEventRecordRaw *)&dCap)) {
+            cxl_event_irq_assert(dcd);
+        }
+    }
+}
+
+void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
+                                  CXLExtSelPolicy sel_policy, uint8_t region,
+                                  const char *tag,
+                                  CXLDynamicCapacityExtentList  *extents,
+                                  Error **errp)
+{
+    switch (sel_policy) {
+    case CXL_EXT_SEL_POLICY_PRESCRIPTIVE:
+        qmp_cxl_process_dynamic_capacity_prescriptive(path, host_id,
+                                                      DC_EVENT_ADD_CAPACITY,
+                                                      region, extents, errp);
+        return;
+    default:
+        error_setg(errp, "Selection policy not supported");
+        return;
+    }
+}
+
+void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
+                                      CXLExtRemovalPolicy removal_policy,
+                                      bool has_forced_removal,
+                                      bool forced_removal,
+                                      bool has_sanitize_on_release,
+                                      bool sanitize_on_release,
+                                      uint8_t region,
+                                      const char *tag,
+                                      CXLDynamicCapacityExtentList  *extents,
+                                      Error **errp)
+{
+    CXLDCEventType type = DC_EVENT_RELEASE_CAPACITY;
+
+    if (has_forced_removal && forced_removal) {
+        /* TODO: enable forced removal in the future */
+        type = DC_EVENT_FORCED_RELEASE_CAPACITY;
+        error_setg(errp, "Forced removal not supported yet");
+        return;
+    }
+
+    switch (removal_policy) {
+    case CXL_EXT_REMOVAL_POLICY_PRESCRIPTIVE:
+        qmp_cxl_process_dynamic_capacity_prescriptive(path, host_id, type,
+                                                      region, extents, errp);
+        return;
+    default:
+        error_setg(errp, "Removal policy not supported");
+        return;
+    }
+}
+
 static void ct3_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 3e1851e32b..45419bbefe 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -67,3 +67,28 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
 {
     error_setg(errp, "CXL Type 3 support is not compiled in");
 }
+
+void qmp_cxl_add_dynamic_capacity(const char *path,
+                                  uint16_t host_id,
+                                  CXLExtSelPolicy sel_policy,
+                                  uint8_t region,
+                                  const char *tag,
+                                  CXLDynamicCapacityExtentList *extents,
+                                  Error **errp)
+{
+    error_setg(errp, "CXL Type 3 support is not compiled in");
+}
+
+void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
+                                      CXLExtRemovalPolicy removal_policy,
+                                      bool has_forced_removal,
+                                      bool forced_removal,
+                                      bool has_sanitize_on_release,
+                                      bool sanitize_on_release,
+                                      uint8_t region,
+                                      const char *tag,
+                                      CXLDynamicCapacityExtentList *extents,
+                                      Error **errp)
+{
+    error_setg(errp, "CXL Type 3 support is not compiled in");
+}
-- 
MST


