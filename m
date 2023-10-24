Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 429EA7D5182
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 15:22:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvHKY-0001mC-Ff; Tue, 24 Oct 2023 09:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvHI2-0005zF-IM
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvHHy-0002Hu-9v
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698153461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9e5RYP7kkCgfv8VdNgjAc4n9NlOa/o8OZpIjS60zpqs=;
 b=RB4px0r+QVNlGKVJaykPISOhIRr+6XBBPNCgTRbfnn80uwmTovC3Tz+pliF9LxV+iqY0Vo
 mCwFbmyfqZlfkqj5GnS3g3cZaeodKvHT2nkJYspbAfDSFkWsz02SXyWmECf5SY4mFKrXks
 DLADrpJwI8kSeYNXEMJvfRb+azJsea0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-bfYjJ8jIMZONxkzmN1pU4w-1; Tue,
 24 Oct 2023 09:17:37 -0400
X-MC-Unique: bfYjJ8jIMZONxkzmN1pU4w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAAD6381C161;
 Tue, 24 Oct 2023 13:17:35 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72B781C060AE;
 Tue, 24 Oct 2023 13:17:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Corey Minyard <minyard@acm.org>, Li Zhijian <lizhijian@fujitsu.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 libvir-list@redhat.com, Stefan Weil <sw@weilnetz.de>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Eric Farman <farman@linux.ibm.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org
Subject: [PULL 39/39] migration: Deprecate old compression method
Date: Tue, 24 Oct 2023 15:13:05 +0200
Message-ID: <20231024131305.87468-40-quintela@redhat.com>
In-Reply-To: <20231024131305.87468-1-quintela@redhat.com>
References: <20231024131305.87468-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231018115513.2163-6-quintela@redhat.com>
---
 docs/about/deprecated.rst |  8 +++++
 qapi/migration.json       | 63 ++++++++++++++++++++++++++-------------
 migration/options.c       | 13 ++++++++
 3 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 7ae872162d..e7f17827d3 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -488,3 +488,11 @@ devices or none.
 Please see "QMP invocation for live storage migration with
 ``blockdev-mirror`` + NBD" in docs/interop/live-block-operations.rst
 for a detailed explanation.
+
+old compression method (since 8.2)
+''''''''''''''''''''''''''''''''''
+
+Compression method fails too much.  Too many races.  We are going to
+remove it if nobody fixes it.  For starters, migration-test
+compression tests are disabled becase they fail randomly.  If you need
+compression, use multifd compression methods.
diff --git a/qapi/migration.json b/qapi/migration.json
index e3b00a215b..e6610af428 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -272,6 +272,10 @@
 # Features:
 #
 # @deprecated: Member @disk is deprecated because block migration is.
+#     Member @compression is deprecated because it is unreliable and
+#     untested.  It is recommended to use multifd migration, which
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
+#     unreliable and untested.  It is recommended to use multifd
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
 # @deprecated: Member @block-incremental is deprecated.  Use
-#     blockdev-mirror with NBD instead.
+#     blockdev-mirror with NBD instead.  Members @compress-level,
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
@@ -1023,7 +1036,9 @@
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
-#     blockdev-mirror with NBD instead.
+#     blockdev-mirror with NBD instead.  Members @compress-level,
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
@@ -1241,7 +1260,9 @@
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
-#     blockdev-mirror with NBD instead.
+#     blockdev-mirror with NBD instead.  Members @compress-level,
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
index ae8ab47e32..9a39826ca5 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -483,6 +483,11 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
                     " use blockdev-mirror with NBD instead");
     }
 
+    if (new_caps[MIGRATION_CAPABILITY_COMPRESS]) {
+        warn_report("old compression method is deprecated;"
+                    " use multifd compression methods instead");
+    }
+
 #ifndef CONFIG_REPLICATION
     if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
         error_setg(errp, "QEMU compiled without replication module"
@@ -1335,18 +1340,26 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     /* TODO use QAPI_CLONE() instead of duplicating it inline */
 
     if (params->has_compress_level) {
+        warn_report("old compression is deprecated;"
+                    " use multifd compression methods instead");
         s->parameters.compress_level = params->compress_level;
     }
 
     if (params->has_compress_threads) {
+        warn_report("old compression is deprecated;"
+                    " use multifd compression methods instead");
         s->parameters.compress_threads = params->compress_threads;
     }
 
     if (params->has_compress_wait_thread) {
+        warn_report("old compression is deprecated;"
+                    " use multifd compression methods instead");
         s->parameters.compress_wait_thread = params->compress_wait_thread;
     }
 
     if (params->has_decompress_threads) {
+        warn_report("old compression is deprecated;"
+                    " use multifd compression methods instead");
         s->parameters.decompress_threads = params->decompress_threads;
     }
 
-- 
2.41.0


