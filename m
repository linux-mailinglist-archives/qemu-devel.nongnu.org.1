Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E140EB96D9D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Sep 2025 18:38:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v161Y-00066K-Mf; Tue, 23 Sep 2025 12:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v161W-00065D-Ic
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 12:37:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v161T-0007bQ-Gh
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 12:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758645465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+ywBNmpuSKsYD4JIXq1tBOOTOsTd7MaPXqk8fbBL9s=;
 b=JMMAj2hW763Znd02eMRTKIrwD++TfvcGKCFlyU05swGIRecY6jJbRA7MR+RJ6NXCP3fBsu
 SRw90WeLxkPBiHXHGPZ/UXnuWmcdndvStkeDpjAZNsCFcbO6s4OJwaJweWhfq9+UdPfCUj
 WaFeK2yj+R87PXP1H//BtFwfvoI1yus=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-69obEIOUOKigr1z_WGSTkQ-1; Tue,
 23 Sep 2025 12:37:44 -0400
X-MC-Unique: 69obEIOUOKigr1z_WGSTkQ-1
X-Mimecast-MFC-AGG-ID: 69obEIOUOKigr1z_WGSTkQ_1758645463
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25B86195608B; Tue, 23 Sep 2025 16:37:43 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 261523000198; Tue, 23 Sep 2025 16:37:40 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 1/2] block: Expose block limits for images in QMP
Date: Tue, 23 Sep 2025 18:37:34 +0200
Message-ID: <20250923163735.378254-2-kwolf@redhat.com>
In-Reply-To: <20250923163735.378254-1-kwolf@redhat.com>
References: <20250923163735.378254-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This information can be useful both for debugging and for management
tools trying to configure guest devices with the optimal limits
(possibly across multiple hosts). There is no reason not to make it
available, so just add it to BlockNodeInfo.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json             | 59 ++++++++++++++++++++++++++++++++
 block/qapi.c                     | 34 ++++++++++++++++--
 tests/qemu-iotests/184           |  3 +-
 tests/qemu-iotests/184.out       |  8 -----
 tests/qemu-iotests/common.filter |  3 +-
 5 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index dc6eb4ae23..eda041ac1c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -275,6 +275,62 @@
       'file': 'ImageInfoSpecificFileWrapper'
   } }
 
+##
+# @BlockLimitsInfo:
+#
+# @request-alignment: Alignment requirement, in bytes, for offset/length of I/O
+#     requests.
+#
+# @max-discard: Maximum number of bytes that can be discarded at once. If not
+#     present, there is no specific maximum.
+#
+# @discard-alignment: Optimal alignment for discard requests in bytes. A power
+#     of 2 is best, but not mandatory. If not present, discards don't have a
+#     alignment requirement different from @request-alignment.
+#
+# @max-write-zeroes: Maximum number of bytes that can be zeroed out at once. If
+#     not present, there is no specific maximum.
+#
+# @write-zeroes-alignment: Optimal alignment for write_zeroes requests in
+#     bytes. A power of 2 is best, but not mandatory. If not present,
+#     write_zeroes doesn't have a alignment requirement different from
+#     @request-alignment.
+#
+# @opt-transfer: Optimal transfer length in bytes. If not present, there is no
+#     preferred size.
+#
+# @max-transfer: Maximal transfer length in bytes. If not present, there is no
+#     specific maximum.
+#
+# @max-hw-transfer: Maximal hardware transfer length in bytes.  Applies
+#     whenever transfers to the device bypass the kernel I/O scheduler, for
+#     example with SG_IO. If not present, there is no specific maximum.
+#
+# @max-iov: Maximum number of scatter/gather elements
+#
+# @max-hw-iov: Maximal number of scatter/gather elements allowed by the hardware.
+#     Applies whenever transfers to the device bypass the kernel I/O scheduler,
+#     for example with SG_IO. If not present, the hardware limits is unknown
+#     and @max-iov is always used.
+#
+# @min-mem-alignment: memory alignment in bytes so that no bounce buffer is needed
+#
+# @opt-mem-alignment: memory alignment in bytes that is used for bounce buffers
+##
+{ 'struct': 'BlockLimitsInfo',
+  'data': { 'request-alignment': 'uint32',
+            '*max-discard': 'uint64',
+            '*discard-alignment': 'uint32',
+            '*max-write-zeroes': 'uint64',
+            '*write-zeroes-alignment': 'uint32',
+            '*opt-transfer': 'uint32',
+            '*max-transfer': 'uint32',
+            '*max-hw-transfer': 'uint32',
+            'max-iov': 'int',
+            '*max-hw-iov': 'int',
+            'min-mem-alignment': 'size',
+            'opt-mem-alignment': 'size' } }
+
 ##
 # @BlockNodeInfo:
 #
@@ -304,6 +360,8 @@
 #
 # @snapshots: list of VM snapshots
 #
+# @limits: block limits that are used for I/O on the node (Since 10.2)
+#
 # @format-specific: structure supplying additional format-specific
 #     information (since 1.7)
 #
@@ -315,6 +373,7 @@
            '*cluster-size': 'int', '*encrypted': 'bool', '*compressed': 'bool',
            '*backing-filename': 'str', '*full-backing-filename': 'str',
            '*backing-filename-format': 'str', '*snapshots': ['SnapshotInfo'],
+           '*limits': 'BlockLimitsInfo',
            '*format-specific': 'ImageInfoSpecific' } }
 
 ##
diff --git a/block/qapi.c b/block/qapi.c
index 12fbf8d1b7..54521d0a68 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -235,7 +235,8 @@ int bdrv_query_snapshot_info_list(BlockDriverState *bs,
  * in @info, setting @errp on error.
  */
 static void GRAPH_RDLOCK
-bdrv_do_query_node_info(BlockDriverState *bs, BlockNodeInfo *info, Error **errp)
+bdrv_do_query_node_info(BlockDriverState *bs, BlockNodeInfo *info, bool limits,
+                        Error **errp)
 {
     int64_t size;
     const char *backing_filename;
@@ -269,6 +270,33 @@ bdrv_do_query_node_info(BlockDriverState *bs, BlockNodeInfo *info, Error **errp)
         info->dirty_flag = bdi.is_dirty;
         info->has_dirty_flag = true;
     }
+
+    if (limits) {
+        info->limits = g_new(BlockLimitsInfo, 1);
+        *info->limits = (BlockLimitsInfo) {
+            .request_alignment          = bs->bl.request_alignment,
+            .has_max_discard            = bs->bl.max_pdiscard != 0,
+            .max_discard                = bs->bl.max_pdiscard,
+            .has_discard_alignment      = bs->bl.pdiscard_alignment != 0,
+            .discard_alignment          = bs->bl.pdiscard_alignment,
+            .has_max_write_zeroes       = bs->bl.max_pwrite_zeroes != 0,
+            .max_write_zeroes           = bs->bl.max_pwrite_zeroes,
+            .has_write_zeroes_alignment = bs->bl.pwrite_zeroes_alignment != 0,
+            .write_zeroes_alignment     = bs->bl.pwrite_zeroes_alignment,
+            .has_opt_transfer           = bs->bl.opt_transfer != 0,
+            .opt_transfer               = bs->bl.opt_transfer,
+            .has_max_transfer           = bs->bl.max_transfer != 0,
+            .max_transfer               = bs->bl.max_transfer,
+            .has_max_hw_transfer        = bs->bl.max_hw_transfer != 0,
+            .max_hw_transfer            = bs->bl.max_hw_transfer,
+            .max_iov                    = bs->bl.max_iov,
+            .has_max_hw_iov             = bs->bl.max_hw_iov != 0,
+            .max_hw_iov                 = bs->bl.max_hw_iov,
+            .min_mem_alignment          = bs->bl.min_mem_alignment,
+            .opt_mem_alignment          = bs->bl.opt_mem_alignment,
+        };
+    }
+
     info->format_specific = bdrv_get_specific_info(bs, &err);
     if (err) {
         error_propagate(errp, err);
@@ -343,7 +371,7 @@ void bdrv_query_image_info(BlockDriverState *bs,
     ImageInfo *info;
 
     info = g_new0(ImageInfo, 1);
-    bdrv_do_query_node_info(bs, qapi_ImageInfo_base(info), errp);
+    bdrv_do_query_node_info(bs, qapi_ImageInfo_base(info), true, errp);
     if (*errp) {
         goto fail;
     }
@@ -397,7 +425,7 @@ void bdrv_query_block_graph_info(BlockDriverState *bs,
     BdrvChild *c;
 
     info = g_new0(BlockGraphInfo, 1);
-    bdrv_do_query_node_info(bs, qapi_BlockGraphInfo_base(info), errp);
+    bdrv_do_query_node_info(bs, qapi_BlockGraphInfo_base(info), false, errp);
     if (*errp) {
         goto fail;
     }
diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index e4cbcd8634..6d44bad59f 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -46,7 +46,8 @@ do_run_qemu()
 run_qemu()
 {
     do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp\
-                          | _filter_qemu_io | _filter_generated_node_ids
+                          | _filter_qemu_io | _filter_generated_node_ids \
+                          | _filter_img_info
 }
 
 test_throttle=$($QEMU_IMG --help|grep throttle)
diff --git a/tests/qemu-iotests/184.out b/tests/qemu-iotests/184.out
index ef99bb2e9a..52692b6b3b 100644
--- a/tests/qemu-iotests/184.out
+++ b/tests/qemu-iotests/184.out
@@ -41,12 +41,6 @@ Testing:
             },
             "iops_wr": 0,
             "ro": false,
-            "children": [
-                {
-                    "node-name": "disk0",
-                    "child": "file"
-                }
-            ],
             "node-name": "throttle0",
             "backing_file_depth": 1,
             "drv": "throttle",
@@ -75,8 +69,6 @@ Testing:
             },
             "iops_wr": 0,
             "ro": false,
-            "children": [
-            ],
             "node-name": "disk0",
             "backing_file_depth": 0,
             "drv": "null-co",
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 511a55b1e8..26e6b45b04 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -229,6 +229,7 @@ _filter_img_info()
     discard=0
     regex_json_spec_start='^ *"format-specific": \{'
     regex_json_child_start='^ *"children": \['
+    regex_json_limit_start='^ *"limits": \{'
     gsed -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
         -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
         -e "s#$TEST_DIR#TEST_DIR#g" \
@@ -261,7 +262,7 @@ _filter_img_info()
                 discard=1
             elif [[ $line =~ "Child node '/" ]]; then
                 discard=1
-            elif [[ $line =~ $regex_json_spec_start ]]; then
+            elif [[ $line =~ $regex_json_spec_start || $line =~ $regex_json_limit_start ]]; then
                 discard=2
                 regex_json_end="^${line%%[^ ]*}\\},? *$"
             elif [[ $line =~ $regex_json_child_start ]]; then
-- 
2.51.0


