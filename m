Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0481773956F
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 04:17:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC9rA-0000au-1S; Wed, 21 Jun 2023 22:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9qO-000786-QX
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:14:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9qN-00056h-5n
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687400082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MmcLRgrHOXaQzZw9raGtmDm+zXG9T1TLit/qoCr/HQ4=;
 b=gqQd4vy7ThEP9ZR5cvCXlHCmz/3K4xs7Jyl/ySlufkhJLBWv9FXPZp3SrBAENk4CcZoWbp
 AZlAd+o7PkmorbtYhGtMSLWumO0HHMDbVfdBt8m3ZUkzPfUAElnHoTZBaGca+SZpNBWgYq
 g3GKvHN8WE77wp6efDq1wpisOhxfybk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-27WyVnVsP2C82q_YIvbrBA-1; Wed, 21 Jun 2023 22:14:37 -0400
X-MC-Unique: 27WyVnVsP2C82q_YIvbrBA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D85C88CC41;
 Thu, 22 Jun 2023 02:14:37 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.193.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1583D1121330;
 Thu, 22 Jun 2023 02:14:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 19/30] migration-test: simplify shmem_opts handling
Date: Thu, 22 Jun 2023 04:13:09 +0200
Message-Id: <20230622021320.66124-20-quintela@redhat.com>
In-Reply-To: <20230622021320.66124-1-quintela@redhat.com>
References: <20230622021320.66124-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Message-ID: <20230608224943.3877-4-quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index fbe9db23cf..e3e7d54216 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -704,9 +704,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
             "-object memory-backend-file,id=mem0,size=%s"
             ",mem-path=%s,share=on -numa node,memdev=mem0",
             memory_size, shmem_path);
-    } else {
-        shmem_path = NULL;
-        shmem_opts = g_strdup("");
     }
 
     if (args->use_dirty_ring) {
@@ -722,7 +719,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  memory_size, tmpfs,
                                  arch_opts ? arch_opts : "",
                                  arch_source ? arch_source : "",
-                                 shmem_opts,
+                                 shmem_opts ? shmem_opts : "",
                                  args->opts_source ? args->opts_source : "",
                                  ignore_stderr);
     if (!args->only_target) {
@@ -742,7 +739,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  memory_size, tmpfs, uri,
                                  arch_opts ? arch_opts : "",
                                  arch_target ? arch_target : "",
-                                 shmem_opts,
+                                 shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
     *to = qtest_init(cmd_target);
-- 
2.40.1


