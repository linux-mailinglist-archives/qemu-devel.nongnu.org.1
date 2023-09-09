Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 132A1799891
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:18:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexhm-0000Ot-GQ; Sat, 09 Sep 2023 09:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexhW-0000FZ-NJ; Sat, 09 Sep 2023 09:08:39 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexhT-0003z2-G0; Sat, 09 Sep 2023 09:08:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3C5D2205F0;
 Sat,  9 Sep 2023 16:06:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EFCA226E43;
 Sat,  9 Sep 2023 16:05:19 +0300 (MSK)
Received: (nullmailer pid 354366 invoked by uid 1000);
 Sat, 09 Sep 2023 13:05:12 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 35/37] docs tests: Fix use of migrate_set_parameter
Date: Sat,  9 Sep 2023 16:05:05 +0300
Message-Id: <20230909130511.354171-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

From: Markus Armbruster <armbru@redhat.com>

docs/multi-thread-compression.txt uses parameter names with
underscores instead of dashes.  Wrong since day one.

docs/rdma.txt, tests/qemu-iotests/181, and tests/qtest/test-hmp.c are
wrong the same way since commit cbde7be900d2 (v6.0.0).  Hard to see,
as test-hmp doesn't check whether the commands work, and iotest 181
appears to be unaffected.

Fixes: 263170e679df (docs: Add a doc about multiple thread compression)
Fixes: cbde7be900d2 (migrate: remove QMP/HMP commands for speed, downtime and cache size)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit b21a6e31a182a5ae7436a444f840d49aac07c94f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/docs/multi-thread-compression.txt b/docs/multi-thread-compression.txt
index bb88c6bdf1..95b1556f67 100644
--- a/docs/multi-thread-compression.txt
+++ b/docs/multi-thread-compression.txt
@@ -117,13 +117,13 @@ to support the multiple thread compression migration:
     {qemu} migrate_set_capability compress on
 
 3. Set the compression thread count on source:
-    {qemu} migrate_set_parameter compress_threads 12
+    {qemu} migrate_set_parameter compress-threads 12
 
 4. Set the compression level on the source:
-    {qemu} migrate_set_parameter compress_level 1
+    {qemu} migrate_set_parameter compress-level 1
 
 5. Set the decompression thread count on destination:
-    {qemu} migrate_set_parameter decompress_threads 3
+    {qemu} migrate_set_parameter decompress-threads 3
 
 6. Start outgoing migration:
     {qemu} migrate -d tcp:destination.host:4444
@@ -133,9 +133,9 @@ to support the multiple thread compression migration:
 
 The following are the default settings:
     compress: off
-    compress_threads: 8
-    decompress_threads: 2
-    compress_level: 1 (which means best speed)
+    compress-threads: 8
+    decompress-threads: 2
+    compress-level: 1 (which means best speed)
 
 So, only the first two steps are required to use the multiple
 thread compression in migration. You can do more if the default
diff --git a/docs/rdma.txt b/docs/rdma.txt
index 2b4cdea1d8..bd8dd799a9 100644
--- a/docs/rdma.txt
+++ b/docs/rdma.txt
@@ -89,7 +89,7 @@ RUNNING:
 First, set the migration speed to match your hardware's capabilities:
 
 QEMU Monitor Command:
-$ migrate_set_parameter max_bandwidth 40g # or whatever is the MAX of your RDMA device
+$ migrate_set_parameter max-bandwidth 40g # or whatever is the MAX of your RDMA device
 
 Next, on the destination machine, add the following to the QEMU command line:
 
diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index cb96d09ae5..dc90a10757 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -109,7 +109,7 @@ if [ ${QEMU_STATUS[$dest]} -lt 0 ]; then
     _notrun 'Postcopy is not supported'
 fi
 
-_send_qemu_cmd $src 'migrate_set_parameter max_bandwidth 4k' "(qemu)"
+_send_qemu_cmd $src 'migrate_set_parameter max-bandwidth 4k' "(qemu)"
 _send_qemu_cmd $src 'migrate_set_capability postcopy-ram on' "(qemu)"
 _send_qemu_cmd $src "migrate -d unix:${MIG_SOCKET}" "(qemu)"
 _send_qemu_cmd $src 'migrate_start_postcopy' "(qemu)"
diff --git a/tests/qtest/test-hmp.c b/tests/qtest/test-hmp.c
index f8b22abe4c..c38d0b9db9 100644
--- a/tests/qtest/test-hmp.c
+++ b/tests/qtest/test-hmp.c
@@ -45,9 +45,9 @@ static const char *hmp_cmds[] = {
     "log all",
     "log none",
     "memsave 0 4096 \"/dev/null\"",
-    "migrate_set_parameter xbzrle_cache_size 1",
-    "migrate_set_parameter downtime_limit 1",
-    "migrate_set_parameter max_bandwidth 1",
+    "migrate_set_parameter xbzrle-cache-size 1",
+    "migrate_set_parameter downtime-limit 1",
+    "migrate_set_parameter max-bandwidth 1",
     "netdev_add user,id=net1",
     "set_link net1 off",
     "set_link net1 on",
-- 
2.39.2


