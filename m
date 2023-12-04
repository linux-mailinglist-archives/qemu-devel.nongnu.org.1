Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BC9803A59
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:34:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rABsZ-0002GW-SC; Mon, 04 Dec 2023 11:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rABsX-0002G2-KC
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:33:05 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rABsV-0006qa-Ts
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=coHukyH1DWww3pN4g1Hrcz2ONewv1IyvwdwjevEANZQ=; b=nV+WjmjRl5L7
 CxV+4oZ6rV4w7+EtjzTJQ6/Ft7Adeh8Mhohn2GWOkq8MJjdg130e3NishIrIdJNIAuoMRvfXEgv0m
 f+CZVu7TTMNj/15MJp//1l8IldVGilGXOa59adGVo8tQV6nSbLcR3JSxKrObUf7G8Kh9LMEB2IHw5
 4PenfFSRVTPuavDFJTfIpCXtWgYkIEPIpWJkIirG+HDeCFZ60oA4PwHhjY8a0zJc3jE6Zj6GRKZ1+
 iKPYC9sNu8Rd0vtovEhz8/siDmCQYhbwR/etpK8Y9Nyfq4KbnevDjDGhKkXnGiSRNUp85d0AfuW4l
 8FWFqDR3u0ebqg3AesSmRg==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1rABqo-00Gie6-0O;
 Mon, 04 Dec 2023 17:32:49 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kkostiuk@redhat.com, michael.roth@amd.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH] Revert "test/qga: use G_TEST_DIR to locate os-release test
 file"
Date: Mon,  4 Dec 2023 18:32:57 +0200
Message-Id: <20231204163257.1011556-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Since the commit a85d09269b QGA_OS_RELEASE variable points to the path
relative to the build dir.  Then on qemu-ga startup this path can't be
found as qemu-ga cwd is somewhere else, which leads to the test failure:

  # ./tests/unit/test-qga -p /qga/guest-get-osinfo
  # random seed: R02S3a90c22d77ff1070fbd844f4959cf4a4
  # Start of qga tests
  **
  ERROR:../tests/unit/test-qga.c:906:test_qga_guest_get_osinfo: 'str' should not be NULL
  Bail out! ERROR:../tests/unit/test-qga.c:906:test_qga_guest_get_osinfo: 'str' should not be NULL

Let's obtain the absolute path again.

This reverts commit a85d09269bb1a7071d3ce0f2957e3ca9dba7c047.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/unit/test-qga.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
index 671e83cb86..47cf5e30ec 100644
--- a/tests/unit/test-qga.c
+++ b/tests/unit/test-qga.c
@@ -1034,10 +1034,12 @@ static void test_qga_guest_get_osinfo(gconstpointer data)
     g_autoptr(QDict) ret = NULL;
     char *env[2];
     QDict *val;
+    g_autofree gchar *cwd = NULL;
 
+    cwd = g_get_current_dir();
     env[0] = g_strdup_printf(
-        "QGA_OS_RELEASE=%s%c..%cdata%ctest-qga-os-release",
-        g_test_get_dir(G_TEST_DIST), G_DIR_SEPARATOR, G_DIR_SEPARATOR, G_DIR_SEPARATOR);
+        "QGA_OS_RELEASE=%s%ctests%cdata%ctest-qga-os-release",
+        cwd, G_DIR_SEPARATOR, G_DIR_SEPARATOR, G_DIR_SEPARATOR);
     env[1] = NULL;
     fixture_setup(&fixture, NULL, env);
 
-- 
2.39.3


