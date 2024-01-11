Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5977882B39D
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 18:04:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNyQi-00044P-5p; Thu, 11 Jan 2024 12:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyQU-0003pb-0o
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:01:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyQS-0003ZY-6c
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704992458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r77E7M5I85w1T8zdFWc4wKXIoTfETTc9mtCRu+/w1eI=;
 b=KuoGztuamAzge9ABfZsvs9XwUF7R33qYh/jngY+/MW31lC/p8R/BfGIruXmw0RL9ijiplx
 vB88dAVFB2EgEPS7ohX1MJI8MZrShUizdceQe7bhkwkm3Jorrx8tROszRyQU5+mj1J6gBw
 NrC3VlXpITdDT9DdAolpsjJikFe3jWE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-tCVnAmsjNOiJ4C6ILFrbDQ-1; Thu, 11 Jan 2024 12:00:55 -0500
X-MC-Unique: tCVnAmsjNOiJ4C6ILFrbDQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9CDD8352A1;
 Thu, 11 Jan 2024 17:00:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06A7F51D5;
 Thu, 11 Jan 2024 17:00:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 03/17] Revert "netdev: set timeout depending on loadavg"
Date: Thu, 11 Jan 2024 18:00:32 +0100
Message-ID: <20240111170047.909117-4-thuth@redhat.com>
In-Reply-To: <20240111170047.909117-1-thuth@redhat.com>
References: <20240111170047.909117-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

This reverts commit cadfc7293977ecadc2d6c48d7cffc553ed2f85f1.

The test was not timing out because of slow execution. It was
timing out due to a race condition leading to the client QEMU
attempting (and fatally failing) to connect before the server
QEMU was listening.

Signed-off-by: "Daniel P. Berrangé" <berrange@redhat.com>
Message-ID: <20240104162942.211458-2-berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/netdev-socket.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/tests/qtest/netdev-socket.c b/tests/qtest/netdev-socket.c
index bb99d08b5e..7ba1eff120 100644
--- a/tests/qtest/netdev-socket.c
+++ b/tests/qtest/netdev-socket.c
@@ -18,32 +18,6 @@
 
 #define CONNECTION_TIMEOUT    120
 
-static double connection_timeout(void)
-{
-    double load;
-    int ret = getloadavg(&load, 1);
-
-    /*
-     * If we can't get load data, or load is low because we just started
-     * running, assume load of 1 (we are alone in this system).
-     */
-    if (ret < 1 || load < 1.0) {
-        load = 1.0;
-    }
-    /*
-     * No one wants to wait more than 10 minutes for this test. Higher load?
-     * Too bad.
-     */
-    if (load > 10.0) {
-        fprintf(stderr, "Warning: load %f higher than 10 - test might timeout\n",
-                load);
-        load = 10.0;
-    }
-
-    /* if load is high increase timeout as we might not get a chance to run */
-    return load * CONNECTION_TIMEOUT;
-}
-
 #define EXPECT_STATE(q, e, t)                             \
 do {                                                      \
     char *resp = NULL;                                    \
@@ -57,7 +31,7 @@ do {                                                      \
         if (g_str_equal(resp, e)) {                       \
             break;                                        \
         }                                                 \
-    } while (g_test_timer_elapsed() < connection_timeout()); \
+    } while (g_test_timer_elapsed() < CONNECTION_TIMEOUT); \
     g_assert_cmpstr(resp, ==, e);                         \
     g_free(resp);                                         \
 } while (0)
-- 
2.43.0


