Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CC8AC4967
	for <lists+qemu-devel@lfdr.de>; Tue, 27 May 2025 09:40:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJouX-00046C-Ft; Tue, 27 May 2025 03:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJouU-00044q-Ve
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:39:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJouE-0007qB-UP
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748331562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlE8jsGF9zBv3J4gv1LhhVB+RCYdFcaNMz/9c2QXuTw=;
 b=c1lf09Mk/NxVJbewOO31/Onf7xuqmE8gGY6RLFr/RL8Jd3vXvjO5ZuZmJ3POEeIWPBrsiV
 iJaPeYu3tkygNBk/zGZsYShyopcHRFguCRKvRA+EZjNpJuWi2yyfFL+VVGBD6WklNIpZhF
 CWO3uA6NFfrIs4lJEUjbzC0NmXWmG04=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-69YUgQuvN16XsOi0MSnAKQ-1; Tue,
 27 May 2025 03:39:21 -0400
X-MC-Unique: 69YUgQuvN16XsOi0MSnAKQ-1
X-Mimecast-MFC-AGG-ID: 69YUgQuvN16XsOi0MSnAKQ_1748331560
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 039A51955DAD; Tue, 27 May 2025 07:39:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CC4819560AB; Tue, 27 May 2025 07:39:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2FE1D21E66BB; Tue, 27 May 2025 09:39:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, qemu-block@nongnu.org
Subject: [PATCH 04/13] qapi: Avoid breaking lines within (since X.Y)
Date: Tue, 27 May 2025 09:39:07 +0200
Message-ID: <20250527073916.1243024-5-armbru@redhat.com>
In-Reply-To: <20250527073916.1243024-1-armbru@redhat.com>
References: <20250527073916.1243024-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Easier on the eyes and for grep.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 56 ++++++++++++++++++++++----------------------
 qapi/introspect.json |  4 ++--
 qapi/job.json        | 12 +++++-----
 qapi/machine.json    |  4 ++--
 qapi/migration.json  | 36 ++++++++++++++--------------
 qapi/net.json        | 12 +++++-----
 qapi/run-state.json  |  4 ++--
 qapi/ui.json         |  4 ++--
 8 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0700bd3d46..cc48fc7122 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -31,8 +31,8 @@
 # @icount: Current instruction count.  Appears when execution
 #     record/replay is enabled.  Used for "time-traveling" to match
 #     the moment in the recorded execution with the snapshots.  This
-#     counter may be obtained through @query-replay command (since
-#     5.2)
+#     counter may be obtained through @query-replay command
+#     (since 5.2)
 #
 # Since: 1.3
 ##
@@ -510,11 +510,11 @@
 #
 # @bps_max: total throughput limit during bursts, in bytes (Since 1.7)
 #
-# @bps_rd_max: read throughput limit during bursts, in bytes (Since
-#     1.7)
+# @bps_rd_max: read throughput limit during bursts, in bytes
+#     (Since 1.7)
 #
-# @bps_wr_max: write throughput limit during bursts, in bytes (Since
-#     1.7)
+# @bps_wr_max: write throughput limit during bursts, in bytes
+#     (Since 1.7)
 #
 # @iops_max: total I/O operations per second during bursts, in bytes
 #     (Since 1.7)
@@ -951,11 +951,11 @@
 # @unmap_operations: The number of unmap operations performed by the
 #     device (Since 4.2)
 #
-# @rd_total_time_ns: Total time spent on reads in nanoseconds (since
-#     0.15).
+# @rd_total_time_ns: Total time spent on reads in nanoseconds
+#     (since 0.15)
 #
-# @wr_total_time_ns: Total time spent on writes in nanoseconds (since
-#     0.15).
+# @wr_total_time_ns: Total time spent on writes in nanoseconds
+#     (since 0.15)
 #
 # @zone_append_total_time_ns: Total time spent on zone append writes
 #     in nanoseconds (since 8.1)
@@ -1502,15 +1502,15 @@
 #
 # @device: the name of the device to take a snapshot of.
 #
-# @node-name: graph node name to generate the snapshot from (Since
-#     2.0)
+# @node-name: graph node name to generate the snapshot from
+#     (Since 2.0)
 #
 # @snapshot-file: the target of the new overlay image.  If the file
 #     exists, or if it is a device, the overlay will be created in the
 #     existing file/device.  Otherwise, a new file will be created.
 #
-# @snapshot-node-name: the graph node name of the new image (Since
-#     2.0)
+# @snapshot-node-name: the graph node name of the new image
+#     (Since 2.0)
 #
 # @format: the format of the overlay image, default is 'qcow2'.
 #
@@ -1785,8 +1785,8 @@
 # If top == base, that is an error.  If top has no overlays on top of
 # it, or if it is in use by a writer, the job will not be completed by
 # itself.  The user needs to complete the job with the
-# block-job-complete command after getting the ready event.  (Since
-# 2.0)
+# block-job-complete command after getting the ready event.
+# (Since 2.0)
 #
 # If the base image is smaller than top, then the base image will be
 # resized to be the same size as top.  If top is smaller than the base
@@ -2169,8 +2169,8 @@
 # @format: the format of the new destination, default is to probe if
 #     @mode is 'existing', else the format of the source
 #
-# @node-name: the new block driver state node name in the graph (Since
-#     2.1)
+# @node-name: the new block driver state node name in the graph
+#     (Since 2.1)
 #
 # @replaces: with sync=full graph node name to be replaced by the new
 #     image when a whole image copy is done.  This can be used to
@@ -2593,11 +2593,11 @@
 #
 # @bps_max: total throughput limit during bursts, in bytes (Since 1.7)
 #
-# @bps_rd_max: read throughput limit during bursts, in bytes (Since
-#     1.7)
+# @bps_rd_max: read throughput limit during bursts, in bytes
+#     (Since 1.7)
 #
-# @bps_wr_max: write throughput limit during bursts, in bytes (Since
-#     1.7)
+# @bps_wr_max: write throughput limit during bursts, in bytes
+#     (Since 1.7)
 #
 # @iops_max: total I/O operations per second during bursts, in bytes
 #     (Since 1.7)
@@ -3655,8 +3655,8 @@
 #     this feature.  (since 2.5)
 #
 # @encrypt: Image decryption options.  Mandatory for encrypted images,
-#     except when doing a metadata-only probe of the image.  (since
-#     2.10)
+#     except when doing a metadata-only probe of the image.
+#     (since 2.10)
 #
 # @data-file: reference to or definition of the external data file.
 #     This may only be specified for images that require an external
@@ -4326,8 +4326,8 @@
 # @user: Ceph id name.
 #
 # @auth-client-required: Acceptable authentication modes.  This maps
-#     to Ceph configuration option "auth_client_required".  (Since
-#     3.0)
+#     to Ceph configuration option "auth_client_required".
+#     (Since 3.0)
 #
 # @key-secret: ID of a QCryptoSecret object providing a key for cephx
 #     authentication.  This maps to Ceph configuration option "key".
@@ -4581,8 +4581,8 @@
 #     error.  During the first @reconnect-delay seconds, all requests
 #     are paused and will be rerun on a successful reconnect.  After
 #     that time, any delayed requests and all future requests before a
-#     successful reconnect will immediately fail.  Default 0 (Since
-#     4.2)
+#     successful reconnect will immediately fail.  Default 0
+#     (Since 4.2)
 #
 # @open-timeout: In seconds.  If zero, the nbd driver tries the
 #     connection only once, and fails to open if the connection fails.
diff --git a/qapi/introspect.json b/qapi/introspect.json
index 01bb242947..95724ee2d2 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -154,8 +154,8 @@
 #
 # Additional SchemaInfo members for meta-type 'enum'.
 #
-# @members: the enum type's members, in no particular order (since
-#     6.2).
+# @members: the enum type's members, in no particular order.
+#     (since 6.2)
 #
 # @values: the enumeration type's member names, in no particular
 #     order.  Redundant with @members.  Just for backward
diff --git a/qapi/job.json b/qapi/job.json
index c53c96cce8..9ddba537db 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -20,14 +20,14 @@
 #
 # @create: image creation job type, see "blockdev-create" (since 3.0)
 #
-# @amend: image options amend job type, see "x-blockdev-amend" (since
-#     5.1)
+# @amend: image options amend job type, see "x-blockdev-amend"
+#     (since 5.1)
 #
-# @snapshot-load: snapshot load job type, see "snapshot-load" (since
-#     6.0)
+# @snapshot-load: snapshot load job type, see "snapshot-load"
+#     (since 6.0)
 #
-# @snapshot-save: snapshot save job type, see "snapshot-save" (since
-#     6.0)
+# @snapshot-save: snapshot save job type, see "snapshot-save"
+#     (since 6.0)
 #
 # @snapshot-delete: snapshot delete job type, see "snapshot-delete"
 #     (since 6.0)
diff --git a/qapi/machine.json b/qapi/machine.json
index 1d60693b65..47e915a2e3 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -182,8 +182,8 @@
 # @default-cpu-type: default CPU model typename if none is requested
 #     via the -cpu argument.  (since 4.2)
 #
-# @default-ram-id: the default ID of initial RAM memory backend (since
-#     5.2)
+# @default-ram-id: the default ID of initial RAM memory backend
+#     (since 5.2)
 #
 # @acpi: machine type supports ACPI (since 8.0)
 #
diff --git a/qapi/migration.json b/qapi/migration.json
index 83afe17cec..0e5a656cc9 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -57,8 +57,8 @@
 #
 # @dirty-sync-missed-zero-copy: Number of times dirty RAM
 #     synchronization could not avoid copying dirty pages.  This is
-#     between 0 and @dirty-sync-count * @multifd-channels.  (since
-#     7.1)
+#     between 0 and @dirty-sync-count * @multifd-channels.
+#     (since 7.1)
 #
 # Since: 0.14
 ##
@@ -137,16 +137,16 @@
 #
 # @active: in the process of doing migration.
 #
-# @postcopy-active: like active, but now in postcopy mode.  (since
-#     2.5)
+# @postcopy-active: like active, but now in postcopy mode.
+#     (since 2.5)
 #
 # @postcopy-paused: during postcopy but paused.  (since 3.0)
 #
 # @postcopy-recover-setup: setup phase for a postcopy recovery
 #     process, preparing for a recovery phase to start.  (since 9.1)
 #
-# @postcopy-recover: trying to recover from a paused postcopy.  (since
-#     3.0)
+# @postcopy-recover: trying to recover from a paused postcopy.
+#     (since 3.0)
 #
 # @completed: migration is finished.
 #
@@ -422,8 +422,8 @@
 #     for precopy.  (since 2.10)
 #
 # @pause-before-switchover: Pause outgoing migration before
-#     serialising device state and before disabling block IO (since
-#     2.11)
+#     serialising device state and before disabling block IO
+#     (since 2.11)
 #
 # @multifd: Use more than one fd for migration (since 4.0)
 #
@@ -697,8 +697,8 @@
 # @alias: An alias name for migration (for example the bitmap name on
 #     the opposite site).
 #
-# @transform: Allows the modification of the migrated bitmap.  (since
-#     6.0)
+# @transform: Allows the modification of the migrated bitmap.
+#     (since 6.0)
 #
 # Since: 5.2
 ##
@@ -770,8 +770,8 @@
 #     specified by @cpu-throttle-increment and the one generated by
 #     ideal CPU percentage.  Therefore, it is compatible to
 #     traditional throttling, meanwhile the throttle increment won't
-#     be excessive at tail stage.  The default value is false.  (Since
-#     5.1)
+#     be excessive at tail stage.  The default value is false.
+#     (Since 5.1)
 #
 # @tls-creds: ID of the 'tls-creds' object that provides credentials
 #     for establishing a TLS connection over the migration data
@@ -951,8 +951,8 @@
 #     specified by @cpu-throttle-increment and the one generated by
 #     ideal CPU percentage.  Therefore, it is compatible to
 #     traditional throttling, meanwhile the throttle increment won't
-#     be excessive at tail stage.  The default value is false.  (Since
-#     5.1)
+#     be excessive at tail stage.  The default value is false.
+#     (Since 5.1)
 #
 # @tls-creds: ID of the 'tls-creds' object that provides credentials
 #     for establishing a TLS connection over the migration data
@@ -1148,8 +1148,8 @@
 #     percentage.  The default value is 50.  (Since 5.0)
 #
 # @cpu-throttle-initial: Initial percentage of time guest cpus are
-#     throttled when migration auto-converge is activated.  (Since
-#     2.7)
+#     throttled when migration auto-converge is activated.
+#     (Since 2.7)
 #
 # @cpu-throttle-increment: throttle percentage increase each time
 #     auto-converge detects that migration is not making progress.
@@ -1165,8 +1165,8 @@
 #     specified by @cpu-throttle-increment and the one generated by
 #     ideal CPU percentage.  Therefore, it is compatible to
 #     traditional throttling, meanwhile the throttle increment won't
-#     be excessive at tail stage.  The default value is false.  (Since
-#     5.1)
+#     be excessive at tail stage.  The default value is false.
+#     (Since 5.1)
 #
 # @tls-creds: ID of the 'tls-creds' object that provides credentials
 #     for establishing a TLS connection over the migration data
diff --git a/qapi/net.json b/qapi/net.json
index e670efd6b0..97ea183981 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -154,8 +154,8 @@
 #     prefix is given in the usual hexadecimal IPv6 address notation.
 #     (since 2.6)
 #
-# @ipv6-prefixlen: IPv6 network prefix length (default is 64) (since
-#     2.6)
+# @ipv6-prefixlen: IPv6 network prefix length (default is 64)
+#     (since 2.6)
 #
 # @ipv6-host: guest-visible IPv6 address of the host (since 2.6)
 #
@@ -387,8 +387,8 @@
 #
 # @hubid: hub identifier number
 #
-# @netdev: used to connect hub to a netdev instead of a device (since
-#     2.12)
+# @netdev: used to connect hub to a netdev instead of a device
+#     (since 2.12)
 #
 # Since: 1.2
 ##
@@ -510,8 +510,8 @@
 # @queues: number of queues to be created for multiqueue vhost-vdpa
 #     (default: 1)
 #
-# @x-svq: Start device with (experimental) shadow virtqueue.  (Since
-#     7.1) (default: false)
+# @x-svq: Start device with (experimental) shadow virtqueue.
+#     (Since 7.1) (default: false)
 #
 # Features:
 #
diff --git a/qapi/run-state.json b/qapi/run-state.json
index ce95cfa46b..4e44da63a0 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -365,8 +365,8 @@
 # @shutdown: Shutdown the VM and exit, according to the shutdown
 #     action
 #
-# @exit-failure: Shutdown the VM and exit with nonzero status (since
-#     7.1)
+# @exit-failure: Shutdown the VM and exit with nonzero status
+#     (since 7.1)
 #
 # Since: 6.0
 ##
diff --git a/qapi/ui.json b/qapi/ui.json
index c536d4e524..3991329668 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -175,8 +175,8 @@
 # @filename: the path of a new file to store the image
 #
 # @device: ID of the display device that should be dumped.  If this
-#     parameter is missing, the primary display will be used.  (Since
-#     2.12)
+#     parameter is missing, the primary display will be used.
+#     (Since 2.12)
 #
 # @head: head to use in case the device supports multiple heads.  If
 #     this parameter is missing, head #0 will be used.  Also note that
-- 
2.48.1


