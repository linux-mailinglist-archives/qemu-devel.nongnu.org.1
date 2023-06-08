Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F055728B76
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:57:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OTL-0004xi-5A; Thu, 08 Jun 2023 18:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSx-0004si-La
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSw-0005JF-3u
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WQYcvVui393GERT+f111xji4B0l6I7VfZfdJQ9wA1dY=;
 b=BL06X15Vl+f9UnoFLiyjmFiCoVI23cZTzs9VgEXFU4ckrJwte20J6JoRxEezpkVeGMzp7f
 RVm5LdxytFqlYPh7nT06UNYqMmd7OHnsBVlYXhjJmmyq9ogQZkzLuKDeHl0CMgIAlx0Bm/
 uBP2utLAf+7P8bHPM5IBrv2du0ImpZM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-7ywYv6jjMQW-AIDasX-gEw-1; Thu, 08 Jun 2023 18:50:46 -0400
X-MC-Unique: 7ywYv6jjMQW-AIDasX-gEw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 244D81C04191;
 Thu,  8 Jun 2023 22:50:46 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9307E492B00;
 Thu,  8 Jun 2023 22:50:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 31/42] migration-test: Preffer to->uri to uri parameter for
 migration
Date: Fri,  9 Jun 2023 00:49:32 +0200
Message-Id: <20230608224943.3877-32-quintela@redhat.com>
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
 tests/qtest/migration-test.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 6438379dcf..0afe871cfb 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -667,12 +667,22 @@ static void migrate_postcopy_start(GuestState *from, GuestState *to)
 
 static void do_migrate(GuestState *from, GuestState *to, const gchar *uri)
 {
-    if (!uri) {
-        g_autofree char *tcp_uri =
-            migrate_get_socket_address(to->qs, "socket-address");
-        migrate_qmp(from->qs, tcp_uri, "{}");
+    if (to->uri) {
+        if (strncmp(to->uri, "tcp:", strlen("tcp:")) == 0) {
+            g_autofree char *tcp_uri =
+                migrate_get_socket_address(to->qs, "socket-address");
+            migrate_qmp(from->qs, tcp_uri, "{}");
+        } else {
+            migrate_qmp(from->qs, to->uri, "{}");
+        }
     } else {
-        migrate_qmp(from->qs, uri, "{}");
+        if (!uri) {
+            g_autofree char *tcp_uri =
+                migrate_get_socket_address(to->qs, "socket-address");
+            migrate_qmp(from->qs, tcp_uri, "{}");
+        } else {
+            migrate_qmp(from->qs, uri, "{}");
+        }
     }
 }
 
-- 
2.40.1


