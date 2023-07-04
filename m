Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A22746A6F
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:18:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGaHj-0000Qu-OS; Tue, 04 Jul 2023 03:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGaHZ-0000PD-VQ
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGaHY-0006hQ-7H
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688455023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ucULyzajFx/Or06D5biHO/o9m7YQg/WZ+w5FZAhPc9Q=;
 b=fO7oS01JUgbrX7Rm25c2Jw3EL0nbZ/6PBKWVkPGPSc7yH6RzVtJHIzE8rIh/hnBUIkPB3+
 kVkDyiog0wsqnCrt6fo9oBi13WRW2m5maDeBqDQ6k1iHDKm3tzBdtRlCODDlG8VGd/rNyM
 W+JzUsVtXZw4JAlxAS+EhYk9RJE5M1U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-UC0zqqVGNnmo9wyohL9vvg-1; Tue, 04 Jul 2023 03:17:00 -0400
X-MC-Unique: UC0zqqVGNnmo9wyohL9vvg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93AE9104458D
 for <qemu-devel@nongnu.org>; Tue,  4 Jul 2023 07:17:00 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 562B62014E17;
 Tue,  4 Jul 2023 07:16:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/3] tests/qtest/readconfig-test: Allow testing for arbitrary
 memory sizes
Date: Tue,  4 Jul 2023 09:16:53 +0200
Message-Id: <20230704071655.75381-2-thuth@redhat.com>
In-Reply-To: <20230704071655.75381-1-thuth@redhat.com>
References: <20230704071655.75381-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

Make test_x86_memdev_resp() more flexible by allowing arbitrary
memory sizes as parameter here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/readconfig-test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/readconfig-test.c b/tests/qtest/readconfig-test.c
index ac7242451b..74526f3af2 100644
--- a/tests/qtest/readconfig-test.c
+++ b/tests/qtest/readconfig-test.c
@@ -48,7 +48,7 @@ static QTestState *qtest_init_with_config(const char *cfgdata)
     return qts;
 }
 
-static void test_x86_memdev_resp(QObject *res)
+static void test_x86_memdev_resp(QObject *res, const char *mem_id, int size)
 {
     Visitor *v;
     g_autoptr(MemdevList) memdevs = NULL;
@@ -63,8 +63,8 @@ static void test_x86_memdev_resp(QObject *res)
     g_assert(!memdevs->next);
 
     memdev = memdevs->value;
-    g_assert_cmpstr(memdev->id, ==, "ram");
-    g_assert_cmpint(memdev->size, ==, 200 * MiB);
+    g_assert_cmpstr(memdev->id, ==, mem_id);
+    g_assert_cmpint(memdev->size, ==, size * MiB);
 
     visit_free(v);
 }
@@ -80,7 +80,7 @@ static void test_x86_memdev(void)
     qts = qtest_init_with_config(cfgdata);
     /* Test valid command */
     resp = qtest_qmp(qts, "{ 'execute': 'query-memdev' }");
-    test_x86_memdev_resp(qdict_get(resp, "return"));
+    test_x86_memdev_resp(qdict_get(resp, "return"), "ram", 200);
     qobject_unref(resp);
 
     qtest_quit(qts);
-- 
2.39.3


