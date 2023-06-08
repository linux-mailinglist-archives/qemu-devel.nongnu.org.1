Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A835728B78
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:58:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OS6-0003Pb-6r; Thu, 08 Jun 2023 18:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OS3-0003OV-2O
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:49:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OS0-0004ef-Kb
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dss+c/xQKMwCZkS1Ig75K0xJ/Ka/v/C8UE28PysQz4k=;
 b=PqZG/FFYSv0DJyj+tmXqPmi/9CUpz//hrM1sw4mp9aDYXyyzWsDLRzljFolD5KLSnzd6rj
 L/n9NA3wDkA/5WE+qCTFIlxgu0AUBelHik4RMFhmAf5QLcWxJXT1T8fbDs//QUBxKiLc7Z
 3vf/5RCFrew6E6a/hNh02C2cJlchwyk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-pP5iDa0yMPO0lZ22s0KuNA-1; Thu, 08 Jun 2023 18:49:49 -0400
X-MC-Unique: pP5iDa0yMPO0lZ22s0KuNA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9173D85A5AA;
 Thu,  8 Jun 2023 22:49:49 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10228492B00;
 Thu,  8 Jun 2023 22:49:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 02/42] migration-test: Make ignore_stderr regular with other
 options
Date: Fri,  9 Jun 2023 00:49:03 +0200
Message-Id: <20230608224943.3877-3-quintela@redhat.com>
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index c5e0c69c6b..73b2f01427 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -602,7 +602,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     g_autofree gchar *arch_target = NULL;
     g_autofree gchar *cmd_source = NULL;
     g_autofree gchar *cmd_target = NULL;
-    const gchar *ignore_stderr;
+    const gchar *ignore_stderr = NULL;
     g_autofree char *bootpath = NULL;
     g_autofree char *shmem_opts = NULL;
     g_autofree char *shmem_path = NULL;
@@ -672,10 +672,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
          * IO redirection does not work, so don't bother adding IO redirection
          * to the command line.
          */
-        ignore_stderr = "";
 #endif
-    } else {
-        ignore_stderr = "";
     }
 
     if (args->use_shmem) {
@@ -701,7 +698,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  memory_size, tmpfs,
                                  arch_source, shmem_opts,
                                  args->opts_source ? args->opts_source : "",
-                                 ignore_stderr);
+                                 ignore_stderr ? ignore_stderr : "");
+
     if (!args->only_target) {
         *from = qtest_init(cmd_source);
         qtest_qmp_set_event_callback(*from,
@@ -722,7 +720,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  memory_size, tmpfs, uri,
                                  arch_target, shmem_opts,
                                  args->opts_target ? args->opts_target : "",
-                                 ignore_stderr);
+                                 ignore_stderr ? ignore_stderr : "");
     *to = qtest_init(cmd_target);
     qtest_qmp_set_event_callback(*to,
                                  migrate_watch_for_resume,
-- 
2.40.1


