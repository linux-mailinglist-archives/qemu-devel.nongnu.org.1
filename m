Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 596427CC20C
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 13:53:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsidA-00049f-91; Tue, 17 Oct 2023 07:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsid8-00047X-GG
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:52:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsid6-0004wl-EK
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697543575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aX+5UiIV+aWRjaABwcjfRHulEZzTZPdKv8T1n0VEzAc=;
 b=ILOnU3tvYYY8MPitmDt6YcSIAJjIgcAudE4MINnYLXT/bAiuwimDaj+3tNRxBXV9YrtEtD
 RyUHBfRwIuMu7CWzyBcXA0RYUJfF+mJejDhUdT32XL/YXQe5Aa6K803+qfgiXVXROXYiJy
 K3YyCwpinDhnCi15se3x7/+jZ72T+iY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-4-7K__kKPi2CbAHhrnk2vw-1; Tue, 17 Oct 2023 07:52:53 -0400
X-MC-Unique: 4-7K__kKPi2CbAHhrnk2vw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F29F13826D57;
 Tue, 17 Oct 2023 11:52:52 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 187CE492BFA;
 Tue, 17 Oct 2023 11:52:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 5/7] migration: Deprecate old compression method
Date: Tue, 17 Oct 2023 13:52:36 +0200
Message-ID: <20231017115238.18309-6-quintela@redhat.com>
In-Reply-To: <20231017115238.18309-1-quintela@redhat.com>
References: <20231017115238.18309-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
---
 docs/about/deprecated.rst |  8 ++++
 qapi/migration.json       | 79 +++++++++++++++++++++++++--------------
 migration/options.c       | 13 +++++++
 3 files changed, 72 insertions(+), 28 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 5eaf096040..f46baf9ee9 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -489,3 +489,11 @@ Please see "QMP invocation for live storage migration with
 ``blockdev-mirror`` + NBD" in docs/interop/live-block-operations.rst
 for a detailed explanation.
 
+old compression method (since 8.2)
+''''''''''''''''''''''''''''''''''
+
+Compression method fails too much.  Too many races.  We are going to
+remove it if nobody fixes it.  For starters, migration-test
+compression tests are disabled becase they fail randomly.  If you need
+compression, use multifd compression methods.
+
diff --git a/qapi/migration.json b/qapi/migration.json
index c7633b22c0..834506a02b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -272,6 +272,10 @@
 # Features:
 #
 # @deprecated: Member @disk is deprecated because block migration is.
+#     Member @compression is deprecated because it is unreliable and
+#     untested. It is recommended to use multifd migration, which
+#     offers an alternative compression implementation that is
+#     reliable and tested.
 #
 # Since: 0.14
 ##
@@ -289,7 +293,7 @@
            '*blocked-reasons': ['str'],
            '*postcopy-blocktime': 'uint32',
            '*postcopy-vcpu-blocktime': ['uint32'],
-           '*compression': 'CompressionStats',
+           '*compression': { 'type': 'CompressionStats', 'features': [ 'deprecated' ] },
            '*socket-address': ['SocketAddress'],
            '*dirty-limit-throttle-time-per-round': 'uint64',
            '*dirty-limit-ring-full-time': 'uint64'} }
@@ -530,7 +534,10 @@
 # Features:
 #
 # @deprecated: Member @block is deprecated.  Use blockdev-mirror with
-#     NBD instead.
+#     NBD instead.  Member @compression is deprecated because it is
+#     unreliable and untested. It is recommended to use multifd
+#     migration, which offers an alternative compression
+#     implementation that is reliable and tested.
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
 #
@@ -538,7 +545,8 @@
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
-           'compress', 'events', 'postcopy-ram',
+           { 'name': 'compress', 'features': [ 'deprecated' ] },
+           'events', 'postcopy-ram',
            { 'name': 'x-colo', 'features': [ 'unstable' ] },
            'release-ram',
            { 'name': 'block', 'features': [ 'deprecated' ] },
@@ -844,7 +852,9 @@
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated. Use
-#     blockdev-mirror with NBD instead.
+#     blockdev-mirror with NBD instead. Members @compress-level,
+#     @compress-threads, @decompress-threads and @compress-wait-thread
+#     are deprecated because @compression is deprecated.
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
 #     are experimental.
@@ -854,8 +864,11 @@
 { 'enum': 'MigrationParameter',
   'data': ['announce-initial', 'announce-max',
            'announce-rounds', 'announce-step',
-           'compress-level', 'compress-threads', 'decompress-threads',
-           'compress-wait-thread', 'throttle-trigger-threshold',
+           { 'name': 'compress-level', 'features': [ 'deprecated' ] },
+           { 'name': 'compress-threads', 'features': [ 'deprecated' ] },
+           { 'name': 'decompress-threads', 'features': [ 'deprecated' ] },
+           { 'name': 'compress-wait-thread', 'features': [ 'deprecated' ] },
+           'throttle-trigger-threshold',
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'cpu-throttle-tailslow',
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
@@ -885,16 +898,16 @@
 # @announce-step: Increase in delay (in milliseconds) between
 #     subsequent packets in the announcement (Since 4.0)
 #
-# @compress-level: compression level
+# @compress-level: compression level.
 #
-# @compress-threads: compression thread count
+# @compress-threads: compression thread count.
 #
 # @compress-wait-thread: Controls behavior when all compression
 #     threads are currently busy.  If true (default), wait for a free
 #     compression thread to become available; otherwise, send the page
-#     uncompressed.  (Since 3.1)
+#     uncompressed. (Since 3.1)
 #
-# @decompress-threads: decompression thread count
+# @decompress-threads: decompression thread count.
 #
 # @throttle-trigger-threshold: The ratio of bytes_dirty_period and
 #     bytes_xfer_period to trigger throttling.  It is expressed as
@@ -1023,7 +1036,9 @@
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated. Use
-#     blockdev-mirror with NBD instead.
+#     blockdev-mirror with NBD instead. Members @compress-level,
+#     @compress-threads, @decompress-threads and @compress-wait-thread
+#     are deprecated because @compression is deprecated.
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
 #     are experimental.
@@ -1038,10 +1053,14 @@
             '*announce-max': 'size',
             '*announce-rounds': 'size',
             '*announce-step': 'size',
-            '*compress-level': 'uint8',
-            '*compress-threads': 'uint8',
-            '*compress-wait-thread': 'bool',
-            '*decompress-threads': 'uint8',
+            '*compress-level': { 'type': 'uint8',
+                                 'features': [ 'deprecated' ] },
+            '*compress-threads':  { 'type': 'uint8',
+                                    'features': [ 'deprecated' ] },
+            '*compress-wait-thread':  { 'type': 'bool',
+                                        'features': [ 'deprecated' ] },
+            '*decompress-threads':  { 'type': 'uint8',
+                                      'features': [ 'deprecated' ] },
             '*throttle-trigger-threshold': 'uint8',
             '*cpu-throttle-initial': 'uint8',
             '*cpu-throttle-increment': 'uint8',
@@ -1078,7 +1097,7 @@
 # Example:
 #
 # -> { "execute": "migrate-set-parameters" ,
-#      "arguments": { "compress-level": 1 } }
+#      "arguments": { "multifd-channels": 5 } }
 # <- { "return": {} }
 ##
 { 'command': 'migrate-set-parameters', 'boxed': true,
@@ -1101,16 +1120,16 @@
 # @announce-step: Increase in delay (in milliseconds) between
 #     subsequent packets in the announcement (Since 4.0)
 #
-# @compress-level: compression level
+# @compress-level: compression level.
 #
-# @compress-threads: compression thread count
+# @compress-threads: compression thread count.
 #
 # @compress-wait-thread: Controls behavior when all compression
 #     threads are currently busy.  If true (default), wait for a free
 #     compression thread to become available; otherwise, send the page
-#     uncompressed.  (Since 3.1)
+#     uncompressed. (Since 3.1)
 #
-# @decompress-threads: decompression thread count
+# @decompress-threads: decompression thread count.
 #
 # @throttle-trigger-threshold: The ratio of bytes_dirty_period and
 #     bytes_xfer_period to trigger throttling.  It is expressed as
@@ -1241,7 +1260,9 @@
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated. Use
-#     blockdev-mirror with NBD instead.
+#     blockdev-mirror with NBD instead. Members @compress-level,
+#     @compress-threads, @decompress-threads and @compress-wait-thread
+#     are deprecated because @compression is deprecated.
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
 #     are experimental.
@@ -1253,10 +1274,14 @@
             '*announce-max': 'size',
             '*announce-rounds': 'size',
             '*announce-step': 'size',
-            '*compress-level': 'uint8',
-            '*compress-threads': 'uint8',
-            '*compress-wait-thread': 'bool',
-            '*decompress-threads': 'uint8',
+            '*compress-level': { 'type': 'uint8',
+                                 'features': [ 'deprecated' ] },
+            '*compress-threads': { 'type': 'uint8',
+                                   'features': [ 'deprecated' ] },
+            '*compress-wait-thread': { 'type': 'bool',
+                                       'features': [ 'deprecated' ] },
+            '*decompress-threads': { 'type': 'uint8',
+                                     'features': [ 'deprecated' ] },
             '*throttle-trigger-threshold': 'uint8',
             '*cpu-throttle-initial': 'uint8',
             '*cpu-throttle-increment': 'uint8',
@@ -1296,10 +1321,8 @@
 #
 # -> { "execute": "query-migrate-parameters" }
 # <- { "return": {
-#          "decompress-threads": 2,
+#          "multifd-channels": 2,
 #          "cpu-throttle-increment": 10,
-#          "compress-threads": 8,
-#          "compress-level": 1,
 #          "cpu-throttle-initial": 20,
 #          "max-bandwidth": 33554432,
 #          "downtime-limit": 300
diff --git a/migration/options.c b/migration/options.c
index 0d0a3f8edb..7cb99a82a5 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -483,6 +483,11 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
                     "Use blockdev-mirror with NBD instead.");
     }
 
+    if (new_caps[MIGRATION_CAPABILITY_COMPRESS]) {
+        warn_report("Old compression method is deprecated. "
+                    "Use multifd compression methods instead.");
+    }
+
 #ifndef CONFIG_REPLICATION
     if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
         error_setg(errp, "QEMU compiled without replication module"
@@ -1321,18 +1326,26 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     /* TODO use QAPI_CLONE() instead of duplicating it inline */
 
     if (params->has_compress_level) {
+        warn_report("Old compression is deprecated. "
+                    "Use multifd compression methods instead.");
         s->parameters.compress_level = params->compress_level;
     }
 
     if (params->has_compress_threads) {
+        warn_report("Old compression is deprecated. "
+                    "Use multifd compression methods instead.");
         s->parameters.compress_threads = params->compress_threads;
     }
 
     if (params->has_compress_wait_thread) {
+        warn_report("Old compression is deprecated. "
+                    "Use multifd compression methods instead.");
         s->parameters.compress_wait_thread = params->compress_wait_thread;
     }
 
     if (params->has_decompress_threads) {
+        warn_report("Old compression is deprecated. "
+                    "Use multifd compression methods instead.");
         s->parameters.decompress_threads = params->decompress_threads;
     }
 
-- 
2.41.0


