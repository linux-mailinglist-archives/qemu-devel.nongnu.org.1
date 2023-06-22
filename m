Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FDD73A6AD
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:57:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCNbp-0007uo-GX; Thu, 22 Jun 2023 12:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNbV-00071r-4i
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:56:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNbS-0008SR-KH
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687452973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=feGe41Lqr8pFN4/LkM2/RlPwQoWrtkla/6guXH2f0IA=;
 b=GQOdjlM2ftcO5GKgs6Bukodjaz0b9C6BO0NqNMAaOTSMhyTbqMP1KlvoZuHzI9QsxLBor+
 QhJOAvOtm91ej9DpU1O6xOQgo6yZDl8DFH/o9AQusiSzDK5DkMFXXx5dR72j9cz05w7jdB
 8Sfq+wjq8AD79aPbhiwmuFEdvGerwxo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-CztxM3pdMPeL5_uFpzt2jw-1; Thu, 22 Jun 2023 12:56:10 -0400
X-MC-Unique: CztxM3pdMPeL5_uFpzt2jw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE354385557B;
 Thu, 22 Jun 2023 16:56:03 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A53EC478C6;
 Thu, 22 Jun 2023 16:56:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 13/30] migration-test: Create arch_opts
Date: Thu, 22 Jun 2023 18:55:10 +0200
Message-Id: <20230622165527.2417-14-quintela@redhat.com>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index 79157d600b..4d8542f5c7 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -600,6 +600,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
 {
     g_autofree gchar *arch_source = NULL;
     g_autofree gchar *arch_target = NULL;
+    /* options for source and target */
+    g_autofree gchar *arch_opts = NULL;
     g_autofree gchar *cmd_source = NULL;
     g_autofree gchar *cmd_target = NULL;
     const gchar *ignore_stderr;
@@ -625,15 +627,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
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
@@ -641,20 +641,16 @@ static int test_migrate_start(QTestState **from, QTestState **to,
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
 
@@ -693,12 +689,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
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
@@ -713,12 +711,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
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


