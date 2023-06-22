Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A3473A6C8
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:58:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCNbt-0008Jz-J2; Thu, 22 Jun 2023 12:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNbn-0007nV-O3
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNbm-0000f6-2R
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687452993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v7DDKZ7/PjEB7antlRml4N9xhWEjy/6LhCVbjHExS7o=;
 b=di6tQINHWSKMmXuzHmm7c3Qt75smGHndfmtKeKQF03A3WLxgOuFbqlEQo4WDKVBmhgQ4b4
 M5KoIfWkevz/EclaqXNBpGeThW4w14AlPbRvMTNmUlsxk4skcdXFKgUQCAuYT0HaycFUPU
 9lCj8NSnQe8VqlcjjXDpx8Q98Q1oXi0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-UFJZf_aqMlKACkjINUjV7g-1; Thu, 22 Jun 2023 12:56:31 -0400
X-MC-Unique: UFJZf_aqMlKACkjINUjV7g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E37B3385556C;
 Thu, 22 Jun 2023 16:56:28 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC5D6C00049;
 Thu, 22 Jun 2023 16:56:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Wei Wang <wei.w.wang@intel.com>
Subject: [PULL 23/30] qtest/migration-tests.c: use "-incoming defer" for
 postcopy tests
Date: Thu, 22 Jun 2023 18:55:20 +0200
Message-Id: <20230622165527.2417-24-quintela@redhat.com>
In-Reply-To: <20230622165527.2417-1-quintela@redhat.com>
References: <20230622165527.2417-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Wei Wang <wei.w.wang@intel.com>

The Postcopy preempt capability is expected to be set before incoming
starts, so change the postcopy tests to start with deferred incoming and
call migrate-incoming after the cap has been set.

Why the existing tests (without this patch) didn't fail?
There could be two reasons:
1) "backlog" specifies the number of pending connections. As long as the
   server accepts the connections faster than the clients side connecting,
   connection will succeed. For the preempt test, it uses only 2 channels,
   so very likely to not have pending connections.
2) per my tests (on kernel 6.2), the number of pending connections allowed
   is actually "backlog + 1", which is 2 in this case.
That said, the implementation of socket_start_incoming_migration_internal
expects "migrate defer" to be used, and for safety, change the test to
work with the expected usage.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230606101910.20456-3-wei.w.wang@intel.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e3e7d54216..c694685923 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1161,10 +1161,10 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
                                     QTestState **to_ptr,
                                     MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    g_autofree char *uri = NULL;
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, uri, &args->start)) {
+    if (test_migrate_start(&from, &to, "defer", &args->start)) {
         return -1;
     }
 
@@ -1183,9 +1183,13 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 
     migrate_ensure_non_converge(from);
 
+    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
+                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
+
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
+    uri = migrate_get_socket_address(to, "socket-address");
     migrate_qmp(from, uri, "{}");
 
     wait_for_migration_pass(from);
-- 
2.40.1


