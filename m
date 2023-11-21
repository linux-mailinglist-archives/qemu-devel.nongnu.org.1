Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2367F25B1
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 07:18:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5K44-00045C-5E; Tue, 21 Nov 2023 01:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhujun2@cmss.chinamobile.com>)
 id 1r5K3x-00044n-JA
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 01:16:47 -0500
Received: from cmccmta4.chinamobile.com ([111.22.67.137]
 helo=cmccmta2.chinamobile.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhujun2@cmss.chinamobile.com>) id 1r5K3t-0006RJ-Jm
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 01:16:44 -0500
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee8655c4b3dc17-69c17;
 Tue, 21 Nov 2023 14:16:32 +0800 (CST)
X-RM-TRANSID: 2ee8655c4b3dc17-69c17
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from ubuntu.localdomain (unknown[10.54.5.255])
 by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee3655c4b3f20d-c8b30;
 Tue, 21 Nov 2023 14:16:32 +0800 (CST)
X-RM-TRANSID: 2ee3655c4b3f20d-c8b30
From: zhujun2 <zhujun2@cmss.chinamobile.com>
To: chen.zhang@intel.com
Cc: lvivier@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 thuth@redhat.com, zhujun2@cmss.chinamobile.com
Subject: [PATCH] tests/qtest: check the return value
Date: Mon, 20 Nov 2023 22:16:30 -0800
Message-Id: <20231121061630.3350-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CYYPR11MB8432C52A61F5A47F4025BDEB9BB0A@CYYPR11MB8432.namprd11.prod.outlook.com>
References: <CYYPR11MB8432C52A61F5A47F4025BDEB9BB0A@CYYPR11MB8432.namprd11.prod.outlook.com>
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

These variables "ret" are never referenced in the code, that
add check logic for the "ret"

Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
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
index fab5dd8b05..b470d8c6e2 100644
--- a/tests/qtest/virtio-net-test.c
+++ b/tests/qtest/virtio-net-test.c
@@ -92,6 +92,7 @@ static void tx_test(QVirtioDevice *dev,
 
     ret = recv(socket, buffer, len, 0);
     g_assert_cmpstr(buffer, ==, "TEST");
+    g_assert_cmpint(ret, ==, len);
 }
 
 static void rx_stop_cont_test(QVirtioDevice *dev,
-- 
2.17.1




