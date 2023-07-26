Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E98E763614
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 14:17:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOdRi-000725-CZ; Wed, 26 Jul 2023 08:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qOdQZ-0006P8-QG
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qOdQX-0004AQ-GH
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690373736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KNC9nSJyggxk1F8QEqwfNe0/LHOiMWhVaqtIL8XGii0=;
 b=dTMgWPiztq8/6dZoQeHa9JcuiodoDcCDhW1A1NJ8h5WUjJjaoSSOSjwTkyBIFFLzfGa5z+
 fa2iUG9EprQScP8g/0UccjkTrAP/gqXY3TOVAkc+WRD5LhK/8sGpjn1EzGE8n2MEFKNpRP
 QIrltvnZyNAY2WoWeszkff1DqLm6c2o=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-MkezuU0QO5m_4F8zXS0FDQ-1; Wed, 26 Jul 2023 08:15:35 -0400
X-MC-Unique: MkezuU0QO5m_4F8zXS0FDQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 483F82815E28
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 12:15:35 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7699840C2063;
 Wed, 26 Jul 2023 12:15:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 13/25] migration-test: Create arch_opts
Date: Wed, 26 Jul 2023 14:14:47 +0200
Message-Id: <20230726121459.1837-14-quintela@redhat.com>
In-Reply-To: <20230726121459.1837-1-quintela@redhat.com>
References: <20230726121459.1837-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This will contain the options needed for both source and target.

Reviewed-by: Peter Xu <peterx@redhat.com>
Message-ID: <20230608224943.3877-6-quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index f51a25e299..c723f083da 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -702,6 +702,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
 {
     g_autofree gchar *arch_source = NULL;
     g_autofree gchar *arch_target = NULL;
+    /* options for source and target */
+    g_autofree gchar *arch_opts = NULL;
     g_autofree gchar *cmd_source = NULL;
     g_autofree gchar *cmd_target = NULL;
     const gchar *ignore_stderr;
@@ -727,15 +729,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         assert(sizeof(x86_bootsect) == 512);
         init_bootfile(bootpath, x86_bootsect, sizeof(x86_bootsect));
         memory_size = "150M";
-        arch_source = g_strdup_printf("-drive file=%s,format=raw", bootpath);
-        arch_target = g_strdup(arch_source);
+        arch_opts = g_strdup_printf("-drive file=%s,format=raw", bootpath);
         start_address = X86_TEST_MEM_START;
         end_address = X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
         init_bootfile(bootpath, s390x_elf, sizeof(s390x_elf));
         memory_size = "128M";
-        arch_source = g_strdup_printf("-bios %s", bootpath);
-        arch_target = g_strdup(arch_source);
+        arch_opts = g_strdup_printf("-bios %s", bootpath);
         start_address = S390_TEST_MEM_START;
         end_address = S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") == 0) {
@@ -743,20 +743,16 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         memory_size = "256M";
         start_address = PPC_TEST_MEM_START;
         end_address = PPC_TEST_MEM_END;
-        arch_source = g_strdup_printf("-nodefaults "
-                                      "-prom-env 'use-nvramrc?=true' -prom-env "
+        arch_source = g_strdup_printf("-prom-env 'use-nvramrc?=true' -prom-env "
                                       "'nvramrc=hex .\" _\" begin %x %x "
                                       "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
                                       "until'", end_address, start_address);
-        arch_target = g_strdup("-nodefaults");
+        arch_opts = g_strdup("-nodefaults");
     } else if (strcmp(arch, "aarch64") == 0) {
         init_bootfile(bootpath, aarch64_kernel, sizeof(aarch64_kernel));
         machine_opts = "-machine virt,gic-version=max";
         memory_size = "150M";
-        arch_source = g_strdup_printf("-cpu max "
-                                      "-kernel %s",
-                                      bootpath);
-        arch_target = g_strdup(arch_source);
+        arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
 
@@ -795,12 +791,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  "-name source,debug-threads=on "
                                  "-m %s "
                                  "-serial file:%s/src_serial "
-                                 "%s %s %s %s",
+                                 "%s %s %s %s %s",
                                  args->use_dirty_ring ?
                                  ",dirty-ring-size=4096" : "",
                                  machine_opts ? machine_opts : "",
                                  memory_size, tmpfs,
-                                 arch_source, shmem_opts,
+                                 arch_opts ? arch_opts : "",
+                                 arch_source ? arch_source : "",
+                                 shmem_opts,
                                  args->opts_source ? args->opts_source : "",
                                  ignore_stderr);
     if (!args->only_target) {
@@ -815,12 +813,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  "-m %s "
                                  "-serial file:%s/dest_serial "
                                  "-incoming %s "
-                                 "%s %s %s %s",
+                                 "%s %s %s %s %s",
                                  args->use_dirty_ring ?
                                  ",dirty-ring-size=4096" : "",
                                  machine_opts ? machine_opts : "",
                                  memory_size, tmpfs, uri,
-                                 arch_target, shmem_opts,
+                                 arch_opts ? arch_opts : "",
+                                 arch_target ? arch_target : "",
+                                 shmem_opts,
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
     *to = qtest_init(cmd_target);
-- 
2.40.1


