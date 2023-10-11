Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A494C7C4F2E
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:37:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVQD-0007An-VT; Wed, 11 Oct 2023 05:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQB-00079g-O1
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQ9-0004rH-RX
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4KhAJY/z1r6I222TvkX5auQlGYb3oiZk6HbR8znGbR8=;
 b=ai9/q19D+zfdGxMr8l9QW9r9bfzncbxRQZRvyYlvJ8tSV6Q+kkCrTXI236gkXOJ7wviQCQ
 Daw0Awy/P5aDFjgkWZ1jfp+sx9x3VA2pMLkfTCMMYJBW/AU6WxoV4uGMZyxdAv8UvGI/xE
 HsSDNudRL7RVSRFjGetAut1rqMi+l0A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-h5xcd1iwONiD7Re80f35ZQ-1; Wed, 11 Oct 2023 05:22:10 -0400
X-MC-Unique: h5xcd1iwONiD7Re80f35ZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91C832825E9F;
 Wed, 11 Oct 2023 09:22:10 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B18861C060AE;
 Wed, 11 Oct 2023 09:22:08 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 02/65] tests/qtest: migration: Expose migrate_set_capability
Date: Wed, 11 Oct 2023 11:21:00 +0200
Message-ID: <20231011092203.1266-3-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

From: Fabiano Rosas <farosas@suse.de>

The following patch will make use of this function from within
migrate-helpers.c, so move it there.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230712190742.22294-2-farosas@suse.de>
---
 tests/qtest/migration-helpers.h |  3 +++
 tests/qtest/migration-helpers.c | 11 +++++++++++
 tests/qtest/migration-test.c    | 11 -----------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 009e250e90..484d7c960f 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -23,6 +23,9 @@ bool migrate_watch_for_resume(QTestState *who, const char *name,
 G_GNUC_PRINTF(3, 4)
 void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...);
 
+void migrate_set_capability(QTestState *who, const char *capability,
+                            bool value);
+
 QDict *migrate_query(QTestState *who);
 QDict *migrate_query_not_failed(QTestState *who);
 
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index be00c52d00..2df198c99e 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -70,6 +70,17 @@ void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
                              "{ 'execute': 'migrate', 'arguments': %p}", args);
 }
 
+void migrate_set_capability(QTestState *who, const char *capability,
+                            bool value)
+{
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'migrate-set-capabilities',"
+                             "'arguments': { "
+                             "'capabilities': [ { "
+                             "'capability': %s, 'state': %i } ] } }",
+                             capability, value);
+}
+
 /*
  * Note: caller is responsible to free the returned object via
  * qobject_unref() after use
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 46f1c275a2..48778565a3 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -605,17 +605,6 @@ static void migrate_cancel(QTestState *who)
     qtest_qmp_assert_success(who, "{ 'execute': 'migrate_cancel' }");
 }
 
-static void migrate_set_capability(QTestState *who, const char *capability,
-                                   bool value)
-{
-    qtest_qmp_assert_success(who,
-                             "{ 'execute': 'migrate-set-capabilities',"
-                             "'arguments': { "
-                             "'capabilities': [ { "
-                             "'capability': %s, 'state': %i } ] } }",
-                             capability, value);
-}
-
 static void migrate_postcopy_start(QTestState *from, QTestState *to)
 {
     qtest_qmp_assert_success(from, "{ 'execute': 'migrate-start-postcopy' }");
-- 
2.41.0


