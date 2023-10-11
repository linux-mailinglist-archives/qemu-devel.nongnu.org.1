Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EC07C5EA9
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 22:48:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqg7J-000881-Rf; Wed, 11 Oct 2023 16:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqg7B-00086O-1K
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqg78-0005UC-S0
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697057249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PmvrTrs31LP9oHYi2GtaBaJaMxrza1M1BiLmQkVOUmA=;
 b=envZWiXjFxCe1oZH6L6aC1pU+MfaMeO2mgOwkSa/khrBkWIaeezqZgI+mE+yBX0sEx7kG2
 1U2YrnBh2HpfT0CQoyKu4AgfpJDiSrRIyD40c97uAj0gO/p4Sy8XAGuxp8goQbQTEwbHH/
 qGv40yhQXnB4kiPLSzx4ay2PQ9eBa/Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-1LckWdVBMMyfS_DZziRwZw-1; Wed, 11 Oct 2023 16:47:25 -0400
X-MC-Unique: 1LckWdVBMMyfS_DZziRwZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E0D9857F82;
 Wed, 11 Oct 2023 20:47:25 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51B6A40C6CA0;
 Wed, 11 Oct 2023 20:47:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, libvir-list@redhat.com,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 4/4] migration: Deprecate old compression method
Date: Wed, 11 Oct 2023 22:47:11 +0200
Message-ID: <20231011204711.9744-5-quintela@redhat.com>
In-Reply-To: <20231011204711.9744-1-quintela@redhat.com>
References: <20231011204711.9744-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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
Acked-by: Peter Xu <peterx@redhat.com>
---
 docs/about/deprecated.rst |   8 +++
 qapi/migration.json       | 102 ++++++++++++++++++++++++--------------
 migration/options.c       |  13 +++++
 3 files changed, 86 insertions(+), 37 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index e46f3df376..b92621996f 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -441,3 +441,11 @@ Please see "QMP invocation for live storage migration with
 ``driver-mirror`` + NBD" in docs/interop/live-block-operations.rst for
 a detailed explanation.
 
+old compression method (since 8.2)
+''''''''''''''''''''''''''''''''''
+
+Compression method fails too much.  Too many races.  We are going to
+remove it if nobody fixes it.  For starters, migration-test
+compression tests are disabled becase they fail randomly.  If you need
+compression, use multifd compression methods.
+
diff --git a/qapi/migration.json b/qapi/migration.json
index bf6e1ac5b5..549306fa76 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -243,7 +243,9 @@
 #
 # @compression: migration compression statistics, only returned if
 #     compression feature is on and status is 'active' or 'completed'
-#     (Since 3.1)
+#     This feature is unreliable and not tested. It is recommended to
+#     use multifd migration instead, which offers an alternative
+#     reliable and tested compression implementation.  (Since 3.1)
 #
 # @socket-address: Only used for tcp, to know what the real port is
 #     (Since 4.0)
@@ -271,8 +273,11 @@
 #
 # Features:
 #
-# @deprecated: @disk migration is deprecated.  Use driver-mirror
-#     with NBD instead.
+# @deprecated: @disk migration is deprecated.  Use driver-mirror with
+#     NBD instead.  @compression is unreliable and untested. It is
+#     recommended to use multifd migration, which offers an
+#     alternative compression implementation that is reliable and
+#     tested.
 #
 # Since: 0.14
 ##
@@ -290,7 +295,7 @@
            '*blocked-reasons': ['str'],
            '*postcopy-blocktime': 'uint32',
            '*postcopy-vcpu-blocktime': ['uint32'],
-           '*compression': 'CompressionStats',
+           '*compression': { 'type': 'CompressionStats', 'features': ['deprecated'] },
            '*socket-address': ['SocketAddress'],
            '*dirty-limit-throttle-time-per-round': 'uint64',
            '*dirty-limit-ring-full-time': 'uint64'} }
@@ -445,7 +450,8 @@
 #     compress and xbzrle are both on, compress only takes effect in
 #     the ram bulk stage, after that, it will be disabled and only
 #     xbzrle takes effect, this can help to minimize migration
-#     traffic.  The feature is disabled by default.  (since 2.4 )
+#     traffic.  The feature is disabled by default.  Obsolete.  Use
+#     multifd compression methods if needed. (since 2.4 )
 #
 # @events: generate events for each migration state change (since 2.4
 #     )
@@ -531,8 +537,9 @@
 #
 # Features:
 #
-# @deprecated: @block migration is deprecated.  Use driver-mirror
-#     with NBD instead.
+# @deprecated: @block migration is deprecated.  Use driver-mirror with
+#     NBD instead. @compress is obsolete, use multifd compression
+#     methods instead.
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
 #
@@ -540,7 +547,8 @@
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
-           'compress', 'events', 'postcopy-ram',
+           { 'name': 'compress', 'features': [ 'deprecated' ] },
+           'events', 'postcopy-ram',
            { 'name': 'x-colo', 'features': [ 'unstable' ] },
            'release-ram',
            { 'name': 'block', 'features': [ 'deprecated' ] },
@@ -701,22 +709,24 @@
 #     migration, the compression level is an integer between 0 and 9,
 #     where 0 means no compression, 1 means the best compression
 #     speed, and 9 means best compression ratio which will consume
-#     more CPU.
+#     more CPU. Obsolete, see multifd compression if needed.
 #
 # @compress-threads: Set compression thread count to be used in live
 #     migration, the compression thread count is an integer between 1
-#     and 255.
+#     and 255. Obsolete, see multifd compression if needed.
 #
 # @compress-wait-thread: Controls behavior when all compression
 #     threads are currently busy.  If true (default), wait for a free
 #     compression thread to become available; otherwise, send the page
-#     uncompressed.  (Since 3.1)
+#     uncompressed. Obsolete, see multifd compression if
+#     needed. (Since 3.1)
 #
 # @decompress-threads: Set decompression thread count to be used in
 #     live migration, the decompression thread count is an integer
 #     between 1 and 255. Usually, decompression is at least 4 times as
 #     fast as compression, so set the decompress-threads to the number
-#     about 1/4 of compress-threads is adequate.
+#     about 1/4 of compress-threads is adequate. Obsolete, see multifd
+#     compression if needed.
 #
 # @throttle-trigger-threshold: The ratio of bytes_dirty_period and
 #     bytes_xfer_period to trigger throttling.  It is expressed as
@@ -836,7 +846,9 @@
 # Features:
 #
 # @deprecated: Member @block-incremental is obsolete. Use
-#     driver-mirror with NBD instead.
+#     driver-mirror with NBD instead. Compression is obsolete, so
+#     members @compress-level, @compress-threads, @decompress-threads
+#     and @compress-wait-thread should not be used.
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
 #     are experimental.
@@ -846,8 +858,11 @@
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
@@ -877,16 +892,17 @@
 # @announce-step: Increase in delay (in milliseconds) between
 #     subsequent packets in the announcement (Since 4.0)
 #
-# @compress-level: compression level
+# @compress-level: compression level. Obsolete and deprecated.
 #
-# @compress-threads: compression thread count
+# @compress-threads: compression thread count. Obsolete and deprecated.
 #
 # @compress-wait-thread: Controls behavior when all compression
 #     threads are currently busy.  If true (default), wait for a free
 #     compression thread to become available; otherwise, send the page
-#     uncompressed.  (Since 3.1)
+#     uncompressed.  Obsolete and deprecated. (Since 3.1)
 #
-# @decompress-threads: decompression thread count
+# @decompress-threads: decompression thread count. Obsolete and
+#     deprecated.
 #
 # @throttle-trigger-threshold: The ratio of bytes_dirty_period and
 #     bytes_xfer_period to trigger throttling.  It is expressed as
@@ -1005,7 +1021,9 @@
 # Features:
 #
 # @deprecated: Member @block-incremental is obsolete. Use
-#     driver-mirror with NBD instead.
+#     driver-mirror with NBD instead. Compression is obsolete, so
+#     members @compress-level, @compress-threads, @decompress-threads
+#     and @compress-wait-thread should not be used.
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
 #     are experimental.
@@ -1020,10 +1038,14 @@
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
@@ -1059,7 +1081,7 @@
 # Example:
 #
 # -> { "execute": "migrate-set-parameters" ,
-#      "arguments": { "compress-level": 1 } }
+#      "arguments": { "multifd-channels": 5 } }
 # <- { "return": {} }
 ##
 { 'command': 'migrate-set-parameters', 'boxed': true,
@@ -1082,16 +1104,18 @@
 # @announce-step: Increase in delay (in milliseconds) between
 #     subsequent packets in the announcement (Since 4.0)
 #
-# @compress-level: compression level
+# @compress-level: compression level. Obsolete and deprecated.
 #
-# @compress-threads: compression thread count
+# @compress-threads: compression thread count. Obsolete and
+#     deprecated.
 #
 # @compress-wait-thread: Controls behavior when all compression
 #     threads are currently busy.  If true (default), wait for a free
 #     compression thread to become available; otherwise, send the page
-#     uncompressed.  (Since 3.1)
+#     uncompressed. Obsolete and deprecated. (Since 3.1)
 #
-# @decompress-threads: decompression thread count
+# @decompress-threads: decompression thread count. Obsolete and
+#     deprecated.
 #
 # @throttle-trigger-threshold: The ratio of bytes_dirty_period and
 #     bytes_xfer_period to trigger throttling.  It is expressed as
@@ -1212,7 +1236,9 @@
 # Features:
 #
 # @deprecated: Member @block-incremental is obsolete. Use
-#     driver-mirror with NBD instead.
+#     driver-mirror with NBD instead. Compression is obsolete, so
+#     members @compress-level, @compress-threads, @decompress-threads
+#     and @compress-wait-thread should not be used.
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
 #     are experimental.
@@ -1224,10 +1250,14 @@
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
@@ -1266,10 +1296,8 @@
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
index 48cbbd682a..8667d42488 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -474,6 +474,11 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
                     "Use driver-mirror with NBD instead.");
     }
 
+    if (new_caps[MIGRATION_CAPABILITY_COMPRESS]) {
+        warn_report("Old compression method is deprecated. "
+                    "Use multifd compression methods instead.");
+    }
+
 #ifndef CONFIG_REPLICATION
     if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
         error_setg(errp, "QEMU compiled without replication module"
@@ -1290,18 +1295,26 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
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


