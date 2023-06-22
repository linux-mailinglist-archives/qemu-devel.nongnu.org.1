Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E34C373955F
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 04:16:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC9qE-0006cw-Qk; Wed, 21 Jun 2023 22:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9q5-0006Mz-Qb
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9q4-00051h-A6
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687400063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/rFBgHJ4D0rnee2hOZE5ZKRJbpKxVo1csNBW02wMzHA=;
 b=ajBaAiFJdPjmX6Rmnjtu0JRvnoT7q8jVl9gnn4dUHcWL0tXwqOmmgyQFHux+lYY9qYklqi
 AtZsnknZuOPBMuZ3/Y/d5nX5lTo1Fy0FXvy5gqaWOX1K59Z6ANEUvY7kRgWn/3UFaHz+up
 5iC5DTaXkRfcpNsP7Hw40g5oBukE2ik=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-hupQGlqFM1mR8yx26P5xCA-1; Wed, 21 Jun 2023 22:14:20 -0400
X-MC-Unique: hupQGlqFM1mR8yx26P5xCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BE4C185A7A7;
 Thu, 22 Jun 2023 02:14:19 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.193.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8011F112132C;
 Thu, 22 Jun 2023 02:14:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 12/30] migration-test: Make machine_opts regular with other
 options
Date: Thu, 22 Jun 2023 04:13:02 +0200
Message-Id: <20230622021320.66124-13-quintela@redhat.com>
In-Reply-To: <20230622021320.66124-1-quintela@redhat.com>
References: <20230622021320.66124-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230608224943.3877-5-quintela@redhat.com>
---
 tests/qtest/migration-test.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index c5e0c69c6b..79157d600b 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -637,7 +637,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         start_address = S390_TEST_MEM_START;
         end_address = S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") == 0) {
-        machine_opts = "vsmt=8";
+        machine_opts = "-machine vsmt=8";
         memory_size = "256M";
         start_address = PPC_TEST_MEM_START;
         end_address = PPC_TEST_MEM_END;
@@ -649,7 +649,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         arch_target = g_strdup("-nodefaults");
     } else if (strcmp(arch, "aarch64") == 0) {
         init_bootfile(bootpath, aarch64_kernel, sizeof(aarch64_kernel));
-        machine_opts = "virt,gic-version=max";
+        machine_opts = "-machine virt,gic-version=max";
         memory_size = "150M";
         arch_source = g_strdup_printf("-cpu max "
                                       "-kernel %s",
@@ -689,14 +689,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         shmem_opts = g_strdup("");
     }
 
-    cmd_source = g_strdup_printf("-accel kvm%s -accel tcg%s%s "
+    cmd_source = g_strdup_printf("-accel kvm%s -accel tcg %s "
                                  "-name source,debug-threads=on "
                                  "-m %s "
                                  "-serial file:%s/src_serial "
                                  "%s %s %s %s",
                                  args->use_dirty_ring ?
                                  ",dirty-ring-size=4096" : "",
-                                 machine_opts ? " -machine " : "",
                                  machine_opts ? machine_opts : "",
                                  memory_size, tmpfs,
                                  arch_source, shmem_opts,
@@ -709,7 +708,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                      &got_src_stop);
     }
 
-    cmd_target = g_strdup_printf("-accel kvm%s -accel tcg%s%s "
+    cmd_target = g_strdup_printf("-accel kvm%s -accel tcg %s "
                                  "-name target,debug-threads=on "
                                  "-m %s "
                                  "-serial file:%s/dest_serial "
@@ -717,7 +716,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  "%s %s %s %s",
                                  args->use_dirty_ring ?
                                  ",dirty-ring-size=4096" : "",
-                                 machine_opts ? " -machine " : "",
                                  machine_opts ? machine_opts : "",
                                  memory_size, tmpfs, uri,
                                  arch_target, shmem_opts,
-- 
2.40.1


