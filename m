Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE122763B77
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:44:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOe5n-0000mR-QA; Wed, 26 Jul 2023 08:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qOe5i-0000lz-0u
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qOe5f-0006o0-D5
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690376286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mUQUPPgbtfqDCxoUUTQ7pFjQCO3AJnGfyNLI3mLb2c8=;
 b=cghgpR0K0LDh/V8OvkCVzwm/gb+bFuITd94EECaAXk/9Xh/0JkJ3E8oSPnesh8USQYypHb
 bVE0n9xXzF17TISr5g4rZJh0AbbMMUqcPqZbCMEqVi0EoRrEgC0sEYf6MTlm7qp2B+cAL5
 acooiQxirp2JeuFT9cl1RCdAVMbfPSk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-bgu3GCAkMkmDWE5yRLzxkw-1; Wed, 26 Jul 2023 08:58:04 -0400
X-MC-Unique: bgu3GCAkMkmDWE5yRLzxkw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF550805AF6;
 Wed, 26 Jul 2023 12:58:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 585CD414A80D;
 Wed, 26 Jul 2023 12:58:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0466921E5A13; Wed, 26 Jul 2023 14:58:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL v2 5/5] qapi: Reformat recent doc comments to conform to
 current conventions
Date: Wed, 26 Jul 2023 14:58:00 +0200
Message-ID: <20230726125800.163430-6-armbru@redhat.com>
In-Reply-To: <20230726125800.163430-1-armbru@redhat.com>
References: <20230726125800.163430-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Since commit a937b6aa739 (qapi: Reformat doc comments to conform to
current conventions), a number of comments not conforming to the
current formatting conventions were added.  No problem, just sweep
the entire documentation once more.

To check the generated documentation does not change, I compared the
generated HTML before and after this commit with "wdiff -3".  Finds no
differences.  Comparing with diff is not useful, as the reflown
paragraphs are visible there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20230720071610.1096458-7-armbru@redhat.com>
---
 qapi/block-core.json     | 78 +++++++++++++++++++---------------------
 qapi/block.json          |  4 +--
 qapi/cxl.json            |  4 +--
 qapi/machine-target.json |  2 +-
 qapi/migration.json      | 10 +++---
 qapi/net.json            |  1 -
 qapi/qom.json            |  9 ++---
 qapi/trace.json          |  2 ++
 qapi/ui.json             |  2 +-
 9 files changed, 55 insertions(+), 57 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index dcfd54d15c..2b1d493d6e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -136,7 +136,7 @@
 #
 # @filename: Name of the extent file
 #
-# @format: Extent type (e.g.  FLAT or SPARSE)
+# @format: Extent type (e.g. FLAT or SPARSE)
 #
 # @virtual-size: Number of bytes covered by this extent
 #
@@ -853,9 +853,8 @@
 # @min_wr_latency_ns: Minimum latency of write operations in the
 #     defined interval, in nanoseconds.
 #
-# @min_zone_append_latency_ns: Minimum latency of zone append operations
-#                              in the defined interval, in nanoseconds
-#                              (since 8.1)
+# @min_zone_append_latency_ns: Minimum latency of zone append
+#     operations in the defined interval, in nanoseconds (since 8.1)
 #
 # @min_flush_latency_ns: Minimum latency of flush operations in the
 #     defined interval, in nanoseconds.
@@ -866,9 +865,8 @@
 # @max_wr_latency_ns: Maximum latency of write operations in the
 #     defined interval, in nanoseconds.
 #
-# @max_zone_append_latency_ns: Maximum latency of zone append operations
-#                              in the defined interval, in nanoseconds
-#                              (since 8.1)
+# @max_zone_append_latency_ns: Maximum latency of zone append
+#     operations in the defined interval, in nanoseconds (since 8.1)
 #
 # @max_flush_latency_ns: Maximum latency of flush operations in the
 #     defined interval, in nanoseconds.
@@ -879,9 +877,8 @@
 # @avg_wr_latency_ns: Average latency of write operations in the
 #     defined interval, in nanoseconds.
 #
-# @avg_zone_append_latency_ns: Average latency of zone append operations
-#                              in the defined interval, in nanoseconds
-#                              (since 8.1)
+# @avg_zone_append_latency_ns: Average latency of zone append
+#     operations in the defined interval, in nanoseconds (since 8.1)
 #
 # @avg_flush_latency_ns: Average latency of flush operations in the
 #     defined interval, in nanoseconds.
@@ -893,8 +890,7 @@
 #     the defined interval.
 #
 # @avg_zone_append_queue_depth: Average number of pending zone append
-#                               operations in the defined interval
-#                               (since 8.1).
+#     operations in the defined interval (since 8.1).
 #
 # Since: 2.5
 ##
@@ -919,8 +915,8 @@
 #
 # @wr_bytes: The number of bytes written by the device.
 #
-# @zone_append_bytes: The number of bytes appended by the zoned devices
-#                     (since 8.1)
+# @zone_append_bytes: The number of bytes appended by the zoned
+#     devices (since 8.1)
 #
 # @unmap_bytes: The number of bytes unmapped by the device (Since 4.2)
 #
@@ -930,8 +926,8 @@
 # @wr_operations: The number of write operations performed by the
 #     device.
 #
-# @zone_append_operations: The number of zone append operations performed
-#                          by the zoned devices (since 8.1)
+# @zone_append_operations: The number of zone append operations
+#     performed by the zoned devices (since 8.1)
 #
 # @flush_operations: The number of cache flush operations performed by
 #     the device (since 0.15)
@@ -946,7 +942,7 @@
 #     0.15).
 #
 # @zone_append_total_time_ns: Total time spent on zone append writes
-#                             in nanoseconds (since 8.1)
+#     in nanoseconds (since 8.1)
 #
 # @flush_total_time_ns: Total time spent on cache flushes in
 #     nanoseconds (since 0.15).
@@ -965,8 +961,8 @@
 # @wr_merged: Number of write requests that have been merged into
 #     another request (Since 2.3).
 #
-# @zone_append_merged: Number of zone append requests that have been merged
-#                      into another request (since 8.1)
+# @zone_append_merged: Number of zone append requests that have been
+#     merged into another request (since 8.1)
 #
 # @unmap_merged: Number of unmap requests that have been merged into
 #     another request (Since 4.2)
@@ -981,9 +977,8 @@
 # @failed_wr_operations: The number of failed write operations
 #     performed by the device (Since 2.5)
 #
-# @failed_zone_append_operations: The number of failed zone append write
-#                                 operations performed by the zoned devices
-#                                 (since 8.1)
+# @failed_zone_append_operations: The number of failed zone append
+#     write operations performed by the zoned devices (since 8.1)
 #
 # @failed_flush_operations: The number of failed flush operations
 #     performed by the device (Since 2.5)
@@ -997,8 +992,8 @@
 # @invalid_wr_operations: The number of invalid write operations
 #     performed by the device (Since 2.5)
 #
-# @invalid_zone_append_operations: The number of invalid zone append operations
-#                                  performed by the zoned device (since 8.1)
+# @invalid_zone_append_operations: The number of invalid zone append
+#     operations performed by the zoned device (since 8.1)
 #
 # @invalid_flush_operations: The number of invalid flush operations
 #     performed by the device (Since 2.5)
@@ -1019,7 +1014,8 @@
 #
 # @wr_latency_histogram: @BlockLatencyHistogramInfo.  (Since 4.0)
 #
-# @zone_append_latency_histogram: @BlockLatencyHistogramInfo.  (since 8.1)
+# @zone_append_latency_histogram: @BlockLatencyHistogramInfo.
+#     (since 8.1)
 #
 # @flush_latency_histogram: @BlockLatencyHistogramInfo.  (Since 4.0)
 #
@@ -1126,7 +1122,7 @@
 #
 # @parent: This describes the file block device if it has one.
 #     Contains recursively the statistics of the underlying protocol
-#     (e.g. the host file for a qcow2 image). If there is no
+#     (e.g. the host file for a qcow2 image).  If there is no
 #     underlying protocol, this field is omitted
 #
 # @backing: This describes the backing block device if it has one.
@@ -1486,7 +1482,7 @@
 # @format: the format of the overlay image, default is 'qcow2'.
 #
 # @mode: whether and how QEMU should create a new image, default is
-#        'absolute-paths'.
+#     'absolute-paths'.
 ##
 { 'struct': 'BlockdevSnapshotSync',
   'data': { '*device': 'str', '*node-name': 'str',
@@ -1550,7 +1546,7 @@
 #
 # @bitmap: The name of a dirty bitmap to use.  Must be present if sync
 #     is "bitmap" or "incremental". Can be present if sync is "full"
-#     or "top". Must not be present otherwise.
+#     or "top".  Must not be present otherwise.
 #     (Since 2.4 (drive-backup), 3.1 (blockdev-backup))
 #
 # @bitmap-mode: Specifies the type of data the bitmap should contain
@@ -3477,16 +3473,16 @@
 # @pass-discard-other: whether discard requests for the data source
 #     should be issued on other occasions where a cluster gets freed
 #
-# @discard-no-unref: when enabled, discards from the guest will not cause
-#     cluster allocations to be relinquished. This prevents qcow2 fragmentation
-#     that would be caused by such discards. Besides potential
-#     performance degradation, such fragmentation can lead to increased
-#     allocation of clusters past the end of the image file,
-#     resulting in image files whose file length can grow much larger
-#     than their guest disk size would suggest.
-#     If image file length is of concern (e.g. when storing qcow2
-#     images directly on block devices), you should consider enabling
-#     this option. (since 8.1)
+# @discard-no-unref: when enabled, discards from the guest will not
+#     cause cluster allocations to be relinquished.  This prevents
+#     qcow2 fragmentation that would be caused by such discards.
+#     Besides potential performance degradation, such fragmentation
+#     can lead to increased allocation of clusters past the end of the
+#     image file, resulting in image files whose file length can grow
+#     much larger than their guest disk size would suggest.  If image
+#     file length is of concern (e.g. when storing qcow2 images
+#     directly on block devices), you should consider enabling this
+#     option.  (since 8.1)
 #
 # @overlap-check: which overlap checks to perform for writes to the
 #     image, defaults to 'cached' (since 2.2)
@@ -5240,9 +5236,9 @@
 #
 # @subformat: vhdx subformat (default: dynamic)
 #
-# @block-state-zero: Force use of payload blocks of type
-#     'ZERO'. Non-standard, but default.  Do not set to 'off' when
-#     using 'qemu-img convert' with subformat=dynamic.
+# @block-state-zero: Force use of payload blocks of type 'ZERO'.
+#     Non-standard, but default.  Do not set to 'off' when using
+#     'qemu-img convert' with subformat=dynamic.
 #
 # Since: 2.12
 ##
diff --git a/qapi/block.json b/qapi/block.json
index 535892fddc..998008cfa8 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -534,8 +534,8 @@
 # @boundaries-write: list of interval boundary values for write
 #     latency histogram.
 #
-# @boundaries-zap: list of interval boundary values for zone append write
-#                  latency histogram.
+# @boundaries-zap: list of interval boundary values for zone append
+#     write latency histogram.
 #
 # @boundaries-flush: list of interval boundary values for flush
 #     latency histogram.
diff --git a/qapi/cxl.json b/qapi/cxl.json
index d5b5293eb5..8cc4c72fa9 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -172,8 +172,8 @@
 #
 # @temperature: Device temperature in degrees Celsius.
 #
-# @dirty-shutdown-count: Number of times the device has been unable
-#     to determine whether data loss may have occurred.
+# @dirty-shutdown-count: Number of times the device has been unable to
+#     determine whether data loss may have occurred.
 #
 # @corrected-volatile-error-count: Total number of correctable errors
 #     in volatile memory.
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 3362f8dc3f..f0a6b72414 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -61,7 +61,7 @@
 # @CpuModelCompareResult:
 #
 # An enumeration of CPU model comparison results.  The result is
-# usually calculated using e.g.  CPU features or CPU generations.
+# usually calculated using e.g. CPU features or CPU generations.
 #
 # @incompatible: If model A is incompatible to model B, model A is not
 #     guaranteed to run where model B runs and the other way around.
diff --git a/qapi/migration.json b/qapi/migration.json
index 2a6565a0f8..476b90bd50 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -465,8 +465,8 @@
 #     block devices (and thus take locks) immediately at the end of
 #     migration.  (since 3.0)
 #
-# @x-ignore-shared: If enabled, QEMU will not migrate shared memory that is
-#     accessible on the destination machine. (since 4.0)
+# @x-ignore-shared: If enabled, QEMU will not migrate shared memory
+#     that is accessible on the destination machine.  (since 4.0)
 #
 # @validate-uuid: Send the UUID of the source to allow the destination
 #     to ensure it is the same.  (since 4.2)
@@ -490,9 +490,9 @@
 # @switchover-ack: If enabled, migration will not stop the source VM
 #     and complete the migration until an ACK is received from the
 #     destination that it's OK to do so.  Exactly when this ACK is
-#     sent depends on the migrated devices that use this feature.
-#     For example, a device can use it to make sure some of its data
-#     is sent and loaded in the destination before doing switchover.
+#     sent depends on the migrated devices that use this feature.  For
+#     example, a device can use it to make sure some of its data is
+#     sent and loaded in the destination before doing switchover.
 #     This can reduce downtime if devices that support this capability
 #     are present.  'return-path' capability must be enabled to use
 #     it.  (since 8.1)
diff --git a/qapi/net.json b/qapi/net.json
index db67501308..313c8a606e 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -663,7 +663,6 @@
 # @type: Specify the driver used for interpreting remaining arguments.
 #
 # Since: 1.2
-#
 ##
 { 'union': 'Netdev',
   'base': { 'id': 'str', 'type': 'NetClientDriver' },
diff --git a/qapi/qom.json b/qapi/qom.json
index 7f92ea43e8..fa3e88c8e6 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -647,9 +647,10 @@
 #     selects a default alignment (currently the page size).
 #     (default: 0)
 #
-# @offset: the offset into the target file that the region starts at. You
-#     can use this option to back multiple regions with a single file. Must
-#     be a multiple of the page size. (default: 0) (since 8.1)
+# @offset: the offset into the target file that the region starts at.
+#     You can use this option to back multiple regions with a single
+#     file. Must be a multiple of the page size.
+#     (default: 0) (since 8.1)
 #
 # @discard-data: if true, the file contents can be destroyed when QEMU
 #     exits, to avoid unnecessarily flushing data to the backing file.
@@ -662,7 +663,7 @@
 #
 # @pmem: specifies whether the backing file specified by @mem-path is
 #     in host persistent memory that can be accessed using the SNIA
-#     NVM programming model (e.g.  Intel NVDIMM).
+#     NVM programming model (e.g. Intel NVDIMM).
 #
 # @readonly: if true, the backing file is opened read-only; if false,
 #     it is opened read-write.  (default: false)
diff --git a/qapi/trace.json b/qapi/trace.json
index 0819d93016..2077d7e117 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -38,6 +38,7 @@
 # @vcpu: Whether this is a per-vCPU event (since 2.7).
 #
 # Features:
+#
 # @deprecated: Member @vcpu is deprecated, and always ignored.
 #
 # Since: 2.2
@@ -56,6 +57,7 @@
 # @vcpu: The vCPU to query (since 2.7).
 #
 # Features:
+#
 # @deprecated: Member @vcpu is deprecated, and always ignored.
 #
 # Returns: a list of @TraceEventInfo for the matching events
diff --git a/qapi/ui.json b/qapi/ui.json
index bb06fb6039..006616aa77 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1309,7 +1309,7 @@
 #     defaults to "off". (Since 3.1)
 #
 # @show-tabs: Display the tab bar for switching between the various
-#     graphical interfaces (e.g.  VGA and virtual console character
+#     graphical interfaces (e.g. VGA and virtual console character
 #     devices) by default.  (Since 7.1)
 #
 # @show-menubar: Display the main window menubar.  Defaults to "on".
-- 
2.41.0


