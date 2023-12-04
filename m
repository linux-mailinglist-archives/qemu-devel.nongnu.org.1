Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6A280368E
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 15:27:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA9tL-0000lv-Uw; Mon, 04 Dec 2023 09:25:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rA9tJ-0000jm-53
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:25:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rA9tH-0003Io-LA
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701699943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cy605Y5LwgV71RhxcU+z3P/0T8ClOlKg7YNk918cCg8=;
 b=G7j+Ypm0HLD70B55vFlpscT4ejqJ4rR1LhT8xwodPoA3LCpJ4zqjUiI6vqoUG5IGgBvHcz
 0iXg+BUnXy9xCs3qw918A91wV6hc0LE37O4cx35w/mUxQ0Xw7dlmYfgV+1DywguJlsU2t4
 5Mc3Ntd8GwScMAQb9YDW94lG6RNpSL4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163--zf7n8WpMpaav0opOrwWCA-1; Mon, 04 Dec 2023 09:25:39 -0500
X-MC-Unique: -zf7n8WpMpaav0opOrwWCA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 661DD805145;
 Mon,  4 Dec 2023 14:25:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A26A2166B26;
 Mon,  4 Dec 2023 14:25:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PULL 3/3] tests/qtest: check the return value
Date: Mon,  4 Dec 2023 15:25:32 +0100
Message-ID: <20231204142532.581730-4-thuth@redhat.com>
In-Reply-To: <20231204142532.581730-1-thuth@redhat.com>
References: <20231204142532.581730-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

From: Zhu Jun <zhujun2@cmss.chinamobile.com>

These variables "ret" are never referenced in the code, thus
add check logic for the "ret"

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20231121080802.4500-1-zhujun2@cmss.chinamobile.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
2.42.0


