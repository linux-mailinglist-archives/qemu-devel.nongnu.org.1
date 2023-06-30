Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 983E474343A
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 07:29:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF6bM-0008Dm-DR; Fri, 30 Jun 2023 01:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6b3-0008B8-Sm
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:23:07 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6b1-0003gM-Fm
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:23:05 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QskH45cKGz4wp5;
 Fri, 30 Jun 2023 15:22:56 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QskH16qkvz4wZy;
 Fri, 30 Jun 2023 15:22:53 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, YangHang Liu <yanghliu@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/16] tests: Add migration switchover ack capability test
Date: Fri, 30 Jun 2023 07:22:23 +0200
Message-ID: <20230630052235.1934154-5-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630052235.1934154-1-clg@redhat.com>
References: <20230630052235.1934154-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=mf8A=CS=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

Add migration switchover ack capability test. The test runs without
devices that support this capability, but is still useful to make sure
it didn't break anything.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: YangHang Liu <yanghliu@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/migration-test.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b0c355bbd9ca..b9cc194100b5 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1693,6 +1693,33 @@ static void test_precopy_tcp_plain(void)
     test_precopy_common(&args);
 }
 
+static void *test_migrate_switchover_ack_start(QTestState *from, QTestState *to)
+{
+
+    migrate_set_capability(from, "return-path", true);
+    migrate_set_capability(to, "return-path", true);
+
+    migrate_set_capability(from, "switchover-ack", true);
+    migrate_set_capability(to, "switchover-ack", true);
+
+    return NULL;
+}
+
+static void test_precopy_tcp_switchover_ack(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "tcp:127.0.0.1:0",
+        .start_hook = test_migrate_switchover_ack_start,
+        /*
+         * Source VM must be running in order to consider the switchover ACK
+         * when deciding to do switchover or not.
+         */
+        .live = true,
+    };
+
+    test_precopy_common(&args);
+}
+
 #ifdef CONFIG_GNUTLS
 static void test_precopy_tcp_tls_psk_match(void)
 {
@@ -2737,6 +2764,10 @@ int main(int argc, char **argv)
 #endif /* CONFIG_GNUTLS */
 
     qtest_add_func("/migration/precopy/tcp/plain", test_precopy_tcp_plain);
+
+    qtest_add_func("/migration/precopy/tcp/plain/switchover-ack",
+                   test_precopy_tcp_switchover_ack);
+
 #ifdef CONFIG_GNUTLS
     qtest_add_func("/migration/precopy/tcp/tls/psk/match",
                    test_precopy_tcp_tls_psk_match);
-- 
2.41.0


