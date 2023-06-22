Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F034C73A924
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 21:52:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCQKp-0004HR-OZ; Thu, 22 Jun 2023 15:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCQKS-0004Bs-1O
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCQKP-0002s1-Ha
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687463449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lwpwWf1d57sYk+PxdjYgvePkLUlujtf3K4nsHwB7k0s=;
 b=aHdljQS2S9G8/kj7KMn7RqwRNLdQQJBQrNI8R2e1xhfv2hAP2zr3sGsQncaGS5bpiQEnTj
 Xsaardpk1CZFqPHe1Gisb37hog5XJC3Ed30DDUeGdXaGs1lpUiGHEq8ucrrzsGerV1cjjf
 P3iTPk0byU1Mk60fzQiw/eGyO97cvMA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-5SNf8qriPTGfdTj7o84NXw-1; Thu, 22 Jun 2023 15:50:44 -0400
X-MC-Unique: 5SNf8qriPTGfdTj7o84NXw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E067390ED43;
 Thu, 22 Jun 2023 19:50:37 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEB61C00049;
 Thu, 22 Jun 2023 19:50:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 libvir-list@redhat.com, Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v2 5/5] migration: Deprecate old compression method
Date: Thu, 22 Jun 2023 21:50:19 +0200
Message-Id: <20230622195019.4396-6-quintela@redhat.com>
In-Reply-To: <20230622195019.4396-1-quintela@redhat.com>
References: <20230622195019.4396-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 docs/about/deprecated.rst |   8 +++
 qapi/migration.json       | 102 ++++++++++++++++++++++++--------------
 migration/options.c       |  13 +++++
 3 files changed, 86 insertions(+), 37 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 2d7c48185e..792de61c8b 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -457,3 +457,11 @@ Please see "QMP invocation for live storage migration with
 ``driver-mirror`` + NBD" in docs/interop/live-block-operations.rst for
 a detailed explanation.
 
+old compression method (since 8.1)
+''''''''''''''''''''''''''''''''''
+
+Compression method fails too much.  Too many races.  We are going to
+remove it if nobody fixes it.  For starters, migration-test
+compression tests are disabled becase they fail randomly.  If you need
+compression, use multifd compression methods.
+
diff --git a/qapi/migration.json b/qapi/migration.json
index 08dee855cb..11f759b90b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -244,7 +244,9 @@
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
@@ -272,8 +274,11 @@
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
@@ -291,7 +296,7 @@
            '*blocked-reasons': ['str'],
            '*postcopy-blocktime': 'uint32',
            '*postcopy-vcpu-blocktime': ['uint32'],
-           '*compression': 'CompressionStats',
+           '*compression': { 'type': 'CompressionStats', 'features': ['deprecated'] },
            '*socket-address': ['SocketAddress'],
            '*dirty-limit-throttle-time-per-round': 'uint64',
            '*dirty-limit-ring-full-time': 'uint64'} }
@@ -446,7 +451,8 @@
 #     compress and xbzrle are both on, compress only takes effect in
 #     the ram bulk stage, after that, it will be disabled and only
 #     xbzrle takes effect, this can help to minimize migration
-#     traffic.  The feature is disabled by default.  (since 2.4 )
+#     traffic.  The feature is disabled by default.  Obsolete.  Use
+#     multifd compression methods if needed. (since 2.4 )
 #
 # @events: generate events for each migration state change (since 2.4
 #     )
@@ -525,8 +531,9 @@
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
@@ -534,7 +541,8 @@
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
-           'compress', 'events', 'postcopy-ram',
+           { 'name': 'compress', 'features': [ 'deprecated' ] },
+           'events', 'postcopy-ram',
            { 'name': 'x-colo', 'features': [ 'unstable' ] },
            'release-ram',
            { 'name': 'block', 'features': [ 'deprecated' ] },
@@ -694,22 +702,24 @@
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
@@ -829,7 +839,9 @@
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
@@ -839,8 +851,11 @@
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
@@ -870,16 +885,17 @@
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
@@ -998,7 +1014,9 @@
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
@@ -1013,10 +1031,14 @@
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
@@ -1052,7 +1074,7 @@
 # Example:
 #
 # -> { "execute": "migrate-set-parameters" ,
-#      "arguments": { "compress-level": 1 } }
+#      "arguments": { "multifd-channels": 5 } }
 # <- { "return": {} }
 ##
 { 'command': 'migrate-set-parameters', 'boxed': true,
@@ -1075,16 +1097,18 @@
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
@@ -1205,7 +1229,9 @@
 # Features:
 #
 # @deprecated: Member @block-incremental is obsolete. Use
-#     driver-mirror with NBD instead.
+#     driver-mirror with NBD instead. Compression is obsolete, so
+#     members @compress-level, @compress-threads, @decompress-threads
+#     and @compress-wait-thread should not be used.
 #
 # @unstable: Members @x-checkpoint-delay and
 #     @x-vcpu-dirty-limit-period are experimental.
@@ -1217,10 +1243,14 @@
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
@@ -1259,10 +1289,8 @@
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
index 24c883696f..7a25339156 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -466,6 +466,11 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
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
@@ -1275,18 +1280,26 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
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
2.40.1


