Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D79763612
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 14:17:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOdRT-0006qo-Hq; Wed, 26 Jul 2023 08:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qOdQc-0006RA-SI
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qOdQa-0004Aj-PU
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690373739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P/n8gDGifsWxAYVoM2b9VPggXZSyNeMKEDHZl2X1mHU=;
 b=GBTvhkgva22ULYnhxoqU5rJEQNbIC00njfWKcoyniQp3r6ya/LM0x+G70Wu62q8wNRioBb
 eJkx6n+of01ebEvqG1a+9s2ZbZdXJE1IjjAOD4MlkgdDp+Qwo44acP+ZsWWSb/3X4KGARR
 9L0AIglJtBAhpRImq/5UgkK/ShSxCuo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-hQWyPz7WOIiXEbvtIP9H9g-1; Wed, 26 Jul 2023 08:15:38 -0400
X-MC-Unique: hQWyPz7WOIiXEbvtIP9H9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F438805AF7
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 12:15:37 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F46740C2063;
 Wed, 26 Jul 2023 12:15:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 14/25] migration-test: machine_opts is really arch specific
Date: Wed, 26 Jul 2023 14:14:48 +0200
Message-Id: <20230726121459.1837-15-quintela@redhat.com>
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

And it needs to be in both source and target, so put it on arch_opts.

Reviewed-by: Peter Xu <peterx@redhat.com>
Message-ID: <20230608224943.3877-7-quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index c723f083da..fd145e38d9 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -711,7 +711,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     g_autofree char *shmem_opts = NULL;
     g_autofree char *shmem_path = NULL;
     const char *arch = qtest_get_arch();
-    const char *machine_opts = NULL;
     const char *memory_size;
 
     if (args->use_shmem) {
@@ -739,7 +738,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         start_address = S390_TEST_MEM_START;
         end_address = S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") == 0) {
-        machine_opts = "-machine vsmt=8";
         memory_size = "256M";
         start_address = PPC_TEST_MEM_START;
         end_address = PPC_TEST_MEM_END;
@@ -747,12 +745,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                       "'nvramrc=hex .\" _\" begin %x %x "
                                       "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
                                       "until'", end_address, start_address);
-        arch_opts = g_strdup("-nodefaults");
+        arch_opts = g_strdup("-nodefaults -machine vsmt=8");
     } else if (strcmp(arch, "aarch64") == 0) {
         init_bootfile(bootpath, aarch64_kernel, sizeof(aarch64_kernel));
-        machine_opts = "-machine virt,gic-version=max";
         memory_size = "150M";
-        arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
+        arch_opts = g_strdup_printf("-machine virt,gic-version=max -cpu max "
+                                    "-kernel %s", bootpath);
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
 
@@ -787,14 +785,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         shmem_opts = g_strdup("");
     }
 
-    cmd_source = g_strdup_printf("-accel kvm%s -accel tcg %s "
+    cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-name source,debug-threads=on "
                                  "-m %s "
                                  "-serial file:%s/src_serial "
                                  "%s %s %s %s %s",
                                  args->use_dirty_ring ?
                                  ",dirty-ring-size=4096" : "",
-                                 machine_opts ? machine_opts : "",
                                  memory_size, tmpfs,
                                  arch_opts ? arch_opts : "",
                                  arch_source ? arch_source : "",
@@ -808,7 +805,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                      &got_src_stop);
     }
 
-    cmd_target = g_strdup_printf("-accel kvm%s -accel tcg %s "
+    cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-name target,debug-threads=on "
                                  "-m %s "
                                  "-serial file:%s/dest_serial "
@@ -816,7 +813,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  "%s %s %s %s %s",
                                  args->use_dirty_ring ?
                                  ",dirty-ring-size=4096" : "",
-                                 machine_opts ? machine_opts : "",
                                  memory_size, tmpfs, uri,
                                  arch_opts ? arch_opts : "",
                                  arch_target ? arch_target : "",
-- 
2.40.1


