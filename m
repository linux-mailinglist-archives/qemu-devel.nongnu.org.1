Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBAC7C83AD
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 12:49:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrFjk-0008HC-KZ; Fri, 13 Oct 2023 06:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrFjW-0007gJ-Ni
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrFjL-0007QJ-TC
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697194157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCbhUHDcxEf8gr5lJ7gXlSpglAA5dMdp4r/vsmsx514=;
 b=IkmXs4qSWgaakNEpJZBtgLE0uA1noUx0Npaig3QT4gJdxfJYByi1itDP2J6dAa36b40nmc
 mmzp/woNvD17epKnEXyPV8B2cBBdbWXGo9MzJvyS909vecwHdWLJGmBt/MVYsndW0iFwfb
 ZOoqh0VwKtIrE55CHHVIjID5M7ZqdpQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-DN6A0GxiMg6tNZdIJagoNg-1; Fri, 13 Oct 2023 06:48:01 -0400
X-MC-Unique: DN6A0GxiMg6tNZdIJagoNg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77E8829AB40E;
 Fri, 13 Oct 2023 10:48:00 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41ED3215660D;
 Fri, 13 Oct 2023 10:47:57 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH v4 06/10] migration: Deprecate old compression method
Date: Fri, 13 Oct 2023 12:47:32 +0200
Message-ID: <20231013104736.31722-7-quintela@redhat.com>
In-Reply-To: <20231013104736.31722-1-quintela@redhat.com>
References: <20231013104736.31722-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index 6490925cdc..a6da0df8e1 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -476,3 +476,11 @@ Please see "QMP invocation for live storage migration with
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
index 5e545d10c0..e599062f7d 100644
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
@@ -834,7 +842,9 @@
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
@@ -844,8 +854,11 @@
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
@@ -875,16 +888,16 @@
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
@@ -1003,7 +1016,9 @@
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
@@ -1018,10 +1033,14 @@
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
@@ -1057,7 +1076,7 @@
 # Example:
 #
 # -> { "execute": "migrate-set-parameters" ,
-#      "arguments": { "compress-level": 1 } }
+#      "arguments": { "multifd-channels": 5 } }
 # <- { "return": {} }
 ##
 { 'command': 'migrate-set-parameters', 'boxed': true,
@@ -1080,16 +1099,16 @@
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
@@ -1210,7 +1229,9 @@
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
@@ -1222,10 +1243,14 @@
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
@@ -1264,10 +1289,8 @@
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
index bb6005052f..e46d847de2 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -474,6 +474,11 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
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


