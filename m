Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8769682E829
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 04:22:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPa0B-0005k9-SR; Mon, 15 Jan 2024 22:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPZzy-0005gp-1K
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPZzv-0002xe-3F
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705375218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uPgp0tmgiDc/OMvGTjwfLVUX42d/xPWCsacOI2JAgcQ=;
 b=PCUeM29ub6s64g8piVcn35CQWY3xOBSTaTmQzTtM2pqKgZc1lrDTIOIynr5kGL8dJNy9YP
 MyoAtE/p86n3dkruxh74DKmOOgLuCFhiO0TZBKu5Og5VWeW4BsOylcHSh5Z0+jfWkLUFXH
 EtXwYg9l1cOJXF2xwBnlYcSWr/QD3FM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-XWED1zs0MfmvLDoh3bip2g-1; Mon, 15 Jan 2024 22:20:14 -0500
X-MC-Unique: XWED1zs0MfmvLDoh3bip2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FCEC800076;
 Tue, 16 Jan 2024 03:20:14 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A8D93C25;
 Tue, 16 Jan 2024 03:20:11 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 07/20] tests/qtest/migration: Add a wrapper to print test names
Date: Tue, 16 Jan 2024 11:19:34 +0800
Message-ID: <20240116031947.69017-8-peterx@redhat.com>
In-Reply-To: <20240116031947.69017-1-peterx@redhat.com>
References: <20240116031947.69017-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

Our usage of gtest results in us losing the very basic functionality
of "knowing which test failed". The issue is that gtest only prints
test names ("paths" in gtest parlance) once the test has finished, but
we use asserts in the tests and crash gtest itself before it can print
anything. We also use a final abort when the result of g_test_run is
not 0.

Depending on how the test failed/broke we can see the function that
trigged the abort, which may be representative of the test, but it
could also just be some generic function.

We have been relying on the primitive method of looking at the name of
the previous successful test and then looking at the code to figure
out which test should have come next.

Add a wrapper to the test registration that does the job of printing
the test name before running.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240104142144.9680-7-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-helpers.h |  1 +
 tests/qtest/migration-helpers.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index b478549096..3bf7ded1b9 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -52,4 +52,5 @@ char *find_common_machine_version(const char *mtype, const char *var1,
                                   const char *var2);
 char *resolve_machine_version(const char *alias, const char *var1,
                               const char *var2);
+void migration_test_add(const char *path, void (*fn)(void));
 #endif /* MIGRATION_HELPERS_H */
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 19384e3fa6..e451dbdbed 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -291,3 +291,35 @@ char *resolve_machine_version(const char *alias, const char *var1,
 
     return find_common_machine_version(machine_name, var1, var2);
 }
+
+typedef struct {
+    char *name;
+    void (*func)(void);
+} MigrationTest;
+
+static void migration_test_destroy(gpointer data)
+{
+    MigrationTest *test = (MigrationTest *)data;
+
+    g_free(test->name);
+    g_free(test);
+}
+
+static void migration_test_wrapper(const void *data)
+{
+    MigrationTest *test = (MigrationTest *)data;
+
+    g_test_message("Running /%s%s", qtest_get_arch(), test->name);
+    test->func();
+}
+
+void migration_test_add(const char *path, void (*fn)(void))
+{
+    MigrationTest *test = g_new0(MigrationTest, 1);
+
+    test->func = fn;
+    test->name = g_strdup(path);
+
+    qtest_add_data_func_full(path, test, migration_test_wrapper,
+                             migration_test_destroy);
+}
-- 
2.43.0


