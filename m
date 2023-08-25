Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4F2788CE3
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 18:00:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZZDl-0001T5-0P; Fri, 25 Aug 2023 11:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qZZDi-0001Ru-Qp
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 11:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qZZDd-0004hx-GT
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 11:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692979167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A/xw5TzRgtqL5gvcD+iF/MI8zm+z0eH+HQ+WE4j4vY0=;
 b=jWPrTWShY6GlSFqak0WCtZss6SI/CeEcp0SjLY9lD4r4U9nZpu0fiLv2KN/Kl6/cZAEdIZ
 U2HvAdtUMJNKFjagqAwplXIhh9EZU/DX1gS58tDVkjL+E7Ae+uwEsrvIm/O4uTo9aoxss6
 h2a3bBC6Ni1j+ZrHaHHsksxZAeTCBFw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-F0c-GMIfMc24ml17CDjZ4w-1; Fri, 25 Aug 2023 11:59:25 -0400
X-MC-Unique: F0c-GMIfMc24ml17CDjZ4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5D4C85D187;
 Fri, 25 Aug 2023 15:59:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A41861121319;
 Fri, 25 Aug 2023 15:59:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9C28321E692A; Fri, 25 Aug 2023 17:59:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, dave@treblig.org, thuth@redhat.com,
 qemu-block@nongnu.org, berrange@redhat.com, dgilbert@redhat.com,
 qemu-trivial@nongnu.org
Subject: [PATCH 1/2] docs tests: Fix use of migrate_set_parameter
Date: Fri, 25 Aug 2023 17:59:22 +0200
Message-ID: <20230825155923.1983141-2-armbru@redhat.com>
In-Reply-To: <20230825155923.1983141-1-armbru@redhat.com>
References: <20230825155923.1983141-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

docs/multi-thread-compression.txt uses parameter names with
underscores instead of dashes.  Wrong since day one.

docs/rdma.txt, tests/qemu-iotests/181, and tests/qtest/test-hmp.c are
wrong the same way since commit cbde7be900d2 (v6.0.0).  Hard to see,
as test-hmp doesn't check whether the commands work, and iotest 181
appears to be unaffected.

Fixes: 263170e679df (docs: Add a doc about multiple thread compression)
Fixes: cbde7be900d2 (migrate: remove QMP/HMP commands for speed, downtime and cache size)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/multi-thread-compression.txt | 12 ++++++------
 docs/rdma.txt                     |  2 +-
 tests/qtest/test-hmp.c            |  6 +++---
 tests/qemu-iotests/181            |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

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
 
diff --git a/tests/qtest/test-hmp.c b/tests/qtest/test-hmp.c
index 6704be239b..c0d2d70689 100644
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
-- 
2.41.0


