Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCD1824642
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:31:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQbT-0007N6-IF; Thu, 04 Jan 2024 11:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLQbR-0007M5-Ai
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:29:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLQbP-0002Ho-Rd
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704385791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIYpZpVNKMTyPeKeXTYR/dwq+d96I6kuKlWLUEPyetU=;
 b=Dcmw4g/uv3AXwP7XpbpPp0sB0xd8PSioVTm9Imy+5oH+YphdP5CGYzf0Hn4Z9NbAwMlQt8
 20psbNtHR7jNM7PurbLVNeeuuGkSz/XPctpxDI/+Foh/UVKj6kpwbUGxEglyBvxnBuYOto
 cTHZr5y35nwhb2nSv+K6JgVptCK1tfE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-Y6s8DCi2OHSylhehjNBLGA-1; Thu, 04 Jan 2024 11:29:48 -0500
X-MC-Unique: Y6s8DCi2OHSylhehjNBLGA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57261882082;
 Thu,  4 Jan 2024 16:29:48 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BE981C060B2;
 Thu,  4 Jan 2024 16:29:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/6] Revert "netdev: set timeout depending on loadavg"
Date: Thu,  4 Jan 2024 16:29:37 +0000
Message-ID: <20240104162942.211458-2-berrange@redhat.com>
In-Reply-To: <20240104162942.211458-1-berrange@redhat.com>
References: <20240104162942.211458-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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

This reverts commit cadfc7293977ecadc2d6c48d7cffc553ed2f85f1.

The test was not timing out because of slow execution. It was
timing out due to a race condition leading to the client QEMU
attempting (and fatally failing) to connect before the server
QEMU was listening.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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


