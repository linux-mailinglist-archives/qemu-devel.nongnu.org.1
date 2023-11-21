Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AEA7F26F2
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:08:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Lnx-0002BP-17; Tue, 21 Nov 2023 03:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhujun2@cmss.chinamobile.com>)
 id 1r5Lnr-0002AD-NU
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:08:16 -0500
Received: from cmccmta4.chinamobile.com ([111.22.67.137]
 helo=cmccmta2.chinamobile.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhujun2@cmss.chinamobile.com>) id 1r5Lno-0008F2-0v
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:08:15 -0500
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee8655c65613ad-6b3ad;
 Tue, 21 Nov 2023 16:08:04 +0800 (CST)
X-RM-TRANSID: 2ee8655c65613ad-6b3ad
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from ubuntu.localdomain (unknown[10.54.5.255])
 by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee4655c6563e40-434d8;
 Tue, 21 Nov 2023 16:08:04 +0800 (CST)
X-RM-TRANSID: 2ee4655c6563e40-434d8
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: thuth@redhat.com
Cc: chen.zhang@intel.com, lvivier@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, zhujun2@cmss.chinamobile.com
Subject: [PATCH] tests/qtest: check the return value
Date: Tue, 21 Nov 2023 00:08:02 -0800
Message-Id: <20231121080802.4500-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <08e7104d-5a6c-4a4a-a737-200f04fffd57@redhat.com>
References: <08e7104d-5a6c-4a4a-a737-200f04fffd57@redhat.com>
Received-SPF: pass client-ip=111.22.67.137;
 envelope-from=zhujun2@cmss.chinamobile.com; helo=cmccmta2.chinamobile.com
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

These variables "ret" are never referenced in the code, thus
add check logic for the "ret"

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tests/qtest/test-filter-mirror.c     | 1 +
 tests/qtest/test-filter-redirector.c | 2 ++
 tests/qtest/virtio-net-test.c        | 1 +
 3 files changed, 4 insertions(+)

diff --git a/tests/qtest/test-filter-mirror.c b/tests/qtest/test-filter-mirror.c
index adeada3eb8..f3865f7519 100644
--- a/tests/qtest/test-filter-mirror.c
+++ b/tests/qtest/test-filter-mirror.c
@@ -61,6 +61,7 @@ static void test_mirror(void)
     g_assert_cmpint(len, ==, sizeof(send_buf));
     recv_buf = g_malloc(len);
     ret = recv(recv_sock[0], recv_buf, len, 0);
+    g_assert_cmpint(ret, ==, len);
     g_assert_cmpstr(recv_buf, ==, send_buf);
 
     g_free(recv_buf);
diff --git a/tests/qtest/test-filter-redirector.c b/tests/qtest/test-filter-redirector.c
index e72e3b7873..a77d5fd8ec 100644
--- a/tests/qtest/test-filter-redirector.c
+++ b/tests/qtest/test-filter-redirector.c
@@ -118,6 +118,7 @@ static void test_redirector_tx(void)
     g_assert_cmpint(len, ==, sizeof(send_buf));
     recv_buf = g_malloc(len);
     ret = recv(recv_sock, recv_buf, len, 0);
+    g_assert_cmpint(ret, ==, len);
     g_assert_cmpstr(recv_buf, ==, send_buf);
 
     g_free(recv_buf);
@@ -185,6 +186,7 @@ static void test_redirector_rx(void)
     g_assert_cmpint(len, ==, sizeof(send_buf));
     recv_buf = g_malloc(len);
     ret = recv(backend_sock[0], recv_buf, len, 0);
+    g_assert_cmpint(ret, ==, len);
     g_assert_cmpstr(recv_buf, ==, send_buf);
 
     close(send_sock);
diff --git a/tests/qtest/virtio-net-test.c b/tests/qtest/virtio-net-test.c
index fab5dd8b05..2df75c9780 100644
--- a/tests/qtest/virtio-net-test.c
+++ b/tests/qtest/virtio-net-test.c
@@ -91,6 +91,7 @@ static void tx_test(QVirtioDevice *dev,
     len = ntohl(len);
 
     ret = recv(socket, buffer, len, 0);
+    g_assert_cmpint(ret, ==, len);
     g_assert_cmpstr(buffer, ==, "TEST");
 }
 
-- 
2.17.1




