Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDA17EBE53
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 09:02:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Ap9-0002p2-Ei; Wed, 15 Nov 2023 03:00:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhujun2@cmss.chinamobile.com>)
 id 1r3Ap6-0002ot-Gw
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 03:00:32 -0500
Received: from cmccmta6.chinamobile.com ([111.22.67.139]
 helo=cmccmta3.chinamobile.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhujun2@cmss.chinamobile.com>) id 1r3Aoz-0004SC-4m
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 03:00:32 -0500
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee965547a90399-42399;
 Wed, 15 Nov 2023 16:00:16 +0800 (CST)
X-RM-TRANSID: 2ee965547a90399-42399
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from ubuntu.localdomain (unknown[10.54.5.255])
 by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee565547a8f6d5-6e0b4;
 Wed, 15 Nov 2023 16:00:16 +0800 (CST)
X-RM-TRANSID: 2ee565547a8f6d5-6e0b4
From: zhujun2 <zhujun2@cmss.chinamobile.com>
To: thuth@redhat.com
Cc: lvivier@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 zhujun2@cmss.chinamobile.com
Subject: [PATCH] tests/qtest: remove unused variables
Date: Wed, 15 Nov 2023 00:00:14 -0800
Message-Id: <20231115080014.12273-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=111.22.67.139;
 envelope-from=zhujun2@cmss.chinamobile.com; helo=cmccmta3.chinamobile.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

These variables are never referenced in the code, just remove them

Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
---
 tests/qtest/test-filter-mirror.c     | 2 +-
 tests/qtest/test-filter-redirector.c | 4 ++--
 tests/qtest/virtio-net-test.c        | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/test-filter-mirror.c b/tests/qtest/test-filter-mirror.c
index adeada3eb8..7aa81daa93 100644
--- a/tests/qtest/test-filter-mirror.c
+++ b/tests/qtest/test-filter-mirror.c
@@ -60,7 +60,7 @@ static void test_mirror(void)
 
     g_assert_cmpint(len, ==, sizeof(send_buf));
     recv_buf = g_malloc(len);
-    ret = recv(recv_sock[0], recv_buf, len, 0);
+    recv(recv_sock[0], recv_buf, len, 0);
     g_assert_cmpstr(recv_buf, ==, send_buf);
 
     g_free(recv_buf);
diff --git a/tests/qtest/test-filter-redirector.c b/tests/qtest/test-filter-redirector.c
index e72e3b7873..e4dfeff2e0 100644
--- a/tests/qtest/test-filter-redirector.c
+++ b/tests/qtest/test-filter-redirector.c
@@ -117,7 +117,7 @@ static void test_redirector_tx(void)
 
     g_assert_cmpint(len, ==, sizeof(send_buf));
     recv_buf = g_malloc(len);
-    ret = recv(recv_sock, recv_buf, len, 0);
+    recv(recv_sock, recv_buf, len, 0);
     g_assert_cmpstr(recv_buf, ==, send_buf);
 
     g_free(recv_buf);
@@ -184,7 +184,7 @@ static void test_redirector_rx(void)
 
     g_assert_cmpint(len, ==, sizeof(send_buf));
     recv_buf = g_malloc(len);
-    ret = recv(backend_sock[0], recv_buf, len, 0);
+    recv(backend_sock[0], recv_buf, len, 0);
     g_assert_cmpstr(recv_buf, ==, send_buf);
 
     close(send_sock);
diff --git a/tests/qtest/virtio-net-test.c b/tests/qtest/virtio-net-test.c
index fab5dd8b05..26df5bbabe 100644
--- a/tests/qtest/virtio-net-test.c
+++ b/tests/qtest/virtio-net-test.c
@@ -90,7 +90,7 @@ static void tx_test(QVirtioDevice *dev,
     g_assert_cmpint(ret, ==, sizeof(len));
     len = ntohl(len);
 
-    ret = recv(socket, buffer, len, 0);
+    recv(socket, buffer, len, 0);
     g_assert_cmpstr(buffer, ==, "TEST");
 }
 
-- 
2.17.1




