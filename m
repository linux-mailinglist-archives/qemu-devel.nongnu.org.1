Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B438728B75
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:57:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OSO-0003W5-AX; Thu, 08 Jun 2023 18:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSM-0003VZ-8X
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSH-0004wv-QJ
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M1ae4vt5kMNTkdWttV/KRR6LDnpq9N03HaDMSbk6Sdo=;
 b=RNBl47qD3EwpFx0u4ENV5YOS6PqvgWaO5uxJlqyEJzlGw8gk4gK78Syi2JmPj0JklZNt2K
 bj9ktC8QsvOjXBulCM2gyaqblGjfBMrPa/LuywXNDMK3g45MCBpbUGQW3lIVYLxvr+kdTa
 GuMCvdL8rwa0Lho9x5E3U027lZYYFV4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-2zC4w6hHO_C-1HHEGzp0kA-1; Thu, 08 Jun 2023 18:50:07 -0400
X-MC-Unique: 2zC4w6hHO_C-1HHEGzp0kA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CB6A185A78E;
 Thu,  8 Jun 2023 22:50:07 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C5F1482060;
 Thu,  8 Jun 2023 22:50:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 11/42] migration-test: Update test_ignore_shared to use args
Date: Fri,  9 Jun 2023 00:49:12 +0200
Message-Id: <20230608224943.3877-12-quintela@redhat.com>
In-Reply-To: <20230608224943.3877-1-quintela@redhat.com>
References: <20230608224943.3877-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

It missed this treatment:

commit 11f1a4ce14803f15d59cff42a4cfb7ac50d36bd0
Author: Juan Quintela <quintela@redhat.com>
Date:   Mon Nov 29 18:57:51 2021 +0100

    migration-test: Check for shared memory like for everything else

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 743aa873e6..7178c8e679 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1597,8 +1597,11 @@ static void test_ignore_shared(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
+    MigrateStart args = {
+        .use_shmem = true
+    };
 
-    if (test_migrate_start(&from, &to, uri, false, true, NULL, NULL)) {
+    if (test_migrate_start(&from, &to, uri, &args)) {
         return;
     }
 
-- 
2.40.1


