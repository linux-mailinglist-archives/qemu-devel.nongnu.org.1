Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7589E728B6E
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:55:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OSU-0003XZ-Ll; Thu, 08 Jun 2023 18:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSS-0003XL-GI
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSR-00052L-1L
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YF5zaFACHYRMZKZN/az3fcgRTJqGCYVOIz68XsYtrmY=;
 b=AY36YcNeIaxsdBcJWoGvf5SVHbAOMKYgxSS3qlNqcCsdnvucuTOfQJOPkybV3nHBkgMsSV
 8HL7DPq4IQEKoOmM5ZZzXnK3+neN0KZyzK1WdgWou/vp9wcqoW3OMk+PSKnaXc+TnLDnwd
 4RmKC5HGOP8wd/ZUkDOSr1BjDrEj/J0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-CJTNoqLFPO-P_Rr7hMjGUw-1; Thu, 08 Jun 2023 18:50:15 -0400
X-MC-Unique: CJTNoqLFPO-P_Rr7hMjGUw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5A5D85A5A8;
 Thu,  8 Jun 2023 22:50:14 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 47C23515541;
 Thu,  8 Jun 2023 22:50:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 15/42] migration-test: migrate_postcopy_prepare() always
 return 0
Date: Fri,  9 Jun 2023 00:49:16 +0200
Message-Id: <20230608224943.3877-16-quintela@redhat.com>
In-Reply-To: <20230608224943.3877-1-quintela@redhat.com>
References: <20230608224943.3877-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

So make it return void.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b57811da75..e623c43957 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1146,9 +1146,9 @@ test_migrate_compress_nowait_start(QTestState *from,
     return NULL;
 }
 
-static int migrate_postcopy_prepare(QTestState **from_ptr,
-                                    QTestState **to_ptr,
-                                    MigrateCommon *args)
+static void migrate_postcopy_prepare(QTestState **from_ptr,
+                                     QTestState **to_ptr,
+                                     MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
@@ -1179,8 +1179,6 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 
     *from_ptr = from;
     *to_ptr = to;
-
-    return 0;
 }
 
 static void migrate_postcopy_complete(QTestState *from, QTestState *to,
@@ -1207,9 +1205,7 @@ static void test_postcopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
 
-    if (migrate_postcopy_prepare(&from, &to, args)) {
-        return;
-    }
+    migrate_postcopy_prepare(&from, &to, args);
     migrate_postcopy_start(from, to);
     migrate_postcopy_complete(from, to, args);
 }
@@ -1270,9 +1266,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
     /* Always hide errors for postcopy recover tests since they're expected */
     args->start.hide_stderr = true;
 
-    if (migrate_postcopy_prepare(&from, &to, args)) {
-        return;
-    }
+    migrate_postcopy_prepare(&from, &to, args);
 
     /* Turn postcopy speed down, 4K/s is slow enough on any machines */
     migrate_set_parameter_int(from, "max-postcopy-bandwidth", 4096);
-- 
2.40.1


