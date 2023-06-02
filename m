Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A0671FFB5
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 12:50:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q52Lb-0007A7-OU; Fri, 02 Jun 2023 06:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q52LT-00078s-7j
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 06:49:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q52LR-0002Jt-IQ
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 06:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685702960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z9eSrmEHKsaRI512KUEARN3Urhez6AXLf6fD0DkMfVM=;
 b=etsvYG6OfVLdLTqIRGMubhB7bUHnxfoeh4VXMwyhGeozxvWIuC8Nsx03b9HPKOJnyrelxG
 dCZbRAFzSpEzDjNdKTabJUvvpb+T2C7sfOWq7wcFVXgKo3COYO5sxwf6twWxn0Tm87kQ2P
 2WLN4Sl/lZWwBXVvqV/WZG0V1mgZ1Ek=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-WT0RTer1MiCtiGsLlh03gQ-1; Fri, 02 Jun 2023 06:49:19 -0400
X-MC-Unique: WT0RTer1MiCtiGsLlh03gQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17728811E7F
 for <qemu-devel@nongnu.org>; Fri,  2 Jun 2023 10:49:19 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2AC640CFD00;
 Fri,  2 Jun 2023 10:49:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 04/10] tests/qtest: get rid of some 'qtest_qmp' usage in
 migration test
Date: Fri,  2 Jun 2023 12:49:04 +0200
Message-Id: <20230602104910.35157-5-quintela@redhat.com>
In-Reply-To: <20230602104910.35157-1-quintela@redhat.com>
References: <20230602104910.35157-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Some of the usage is just a verbose way of re-inventing the
qtest_qmp_assert_success(_ref) methods.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230601161347.1803440-5-berrange@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-helpers.c |  8 ++---
 tests/qtest/migration-test.c    | 52 ++++++++++++---------------------
 2 files changed, 21 insertions(+), 39 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index bddf3f8d4d..e26fdcb132 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -93,7 +93,7 @@ QDict *wait_command(QTestState *who, const char *command, ...)
 void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
 {
     va_list ap;
-    QDict *args, *rsp;
+    QDict *args;
 
     va_start(ap, fmt);
     args = qdict_from_vjsonf_nofail(fmt, ap);
@@ -102,10 +102,8 @@ void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
     g_assert(!qdict_haskey(args, "uri"));
     qdict_put_str(args, "uri", uri);
 
-    rsp = qtest_qmp(who, "{ 'execute': 'migrate', 'arguments': %p}", args);
-
-    g_assert(qdict_haskey(rsp, "return"));
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'migrate', 'arguments': %p}", args);
 }
 
 /*
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 9ce27f89ec..822516286d 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -359,14 +359,10 @@ static void migrate_check_parameter_int(QTestState *who, const char *parameter,
 static void migrate_set_parameter_int(QTestState *who, const char *parameter,
                                       long long value)
 {
-    QDict *rsp;
-
-    rsp = qtest_qmp(who,
-                    "{ 'execute': 'migrate-set-parameters',"
-                    "'arguments': { %s: %lld } }",
-                    parameter, value);
-    g_assert(qdict_haskey(rsp, "return"));
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'migrate-set-parameters',"
+                             "'arguments': { %s: %lld } }",
+                             parameter, value);
     migrate_check_parameter_int(who, parameter, value);
 }
 
@@ -392,14 +388,10 @@ static void migrate_check_parameter_str(QTestState *who, const char *parameter,
 static void migrate_set_parameter_str(QTestState *who, const char *parameter,
                                       const char *value)
 {
-    QDict *rsp;
-
-    rsp = qtest_qmp(who,
-                    "{ 'execute': 'migrate-set-parameters',"
-                    "'arguments': { %s: %s } }",
-                    parameter, value);
-    g_assert(qdict_haskey(rsp, "return"));
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'migrate-set-parameters',"
+                             "'arguments': { %s: %s } }",
+                             parameter, value);
     migrate_check_parameter_str(who, parameter, value);
 }
 
@@ -427,14 +419,10 @@ static void migrate_check_parameter_bool(QTestState *who, const char *parameter,
 static void migrate_set_parameter_bool(QTestState *who, const char *parameter,
                                       int value)
 {
-    QDict *rsp;
-
-    rsp = qtest_qmp(who,
-                    "{ 'execute': 'migrate-set-parameters',"
-                    "'arguments': { %s: %i } }",
-                    parameter, value);
-    g_assert(qdict_haskey(rsp, "return"));
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'migrate-set-parameters',"
+                             "'arguments': { %s: %i } }",
+                             parameter, value);
     migrate_check_parameter_bool(who, parameter, value);
 }
 
@@ -494,16 +482,12 @@ static void migrate_cancel(QTestState *who)
 static void migrate_set_capability(QTestState *who, const char *capability,
                                    bool value)
 {
-    QDict *rsp;
-
-    rsp = qtest_qmp(who,
-                    "{ 'execute': 'migrate-set-capabilities',"
-                    "'arguments': { "
-                    "'capabilities': [ { "
-                    "'capability': %s, 'state': %i } ] } }",
-                    capability, value);
-    g_assert(qdict_haskey(rsp, "return"));
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'migrate-set-capabilities',"
+                             "'arguments': { "
+                             "'capabilities': [ { "
+                             "'capability': %s, 'state': %i } ] } }",
+                             capability, value);
 }
 
 static void migrate_postcopy_start(QTestState *from, QTestState *to)
-- 
2.40.1


