Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2749823197
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 17:53:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL4T0-00059q-LI; Wed, 03 Jan 2024 11:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>) id 1rL4Sw-00059H-7K
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 11:51:38 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>) id 1rL4St-0001vl-J6
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 11:51:37 -0500
Received: from buffy.. (buffy [192.168.147.6])
 by zoidberg.rfc1149.net (Postfix) with ESMTP id 6BC0680024;
 Wed,  3 Jan 2024 17:51:32 +0100 (CET)
Authentication-Results: zoidberg.rfc1149.net;
 dmarc=fail (p=none dis=none) header.from=rfc1149.net
Authentication-Results: zoidberg.rfc1149.net;
 spf=fail smtp.mailfrom=rfc1149.net
From: Samuel Tardieu <sam@rfc1149.net>
To: qemu-devel@nongnu.org
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Samuel Tardieu <sam@rfc1149.net>
Subject: [PATCH] tests/unit/test-qga: do not qualify executable paths
Date: Wed,  3 Jan 2024 17:51:31 +0100
Message-ID: <20240103165131.2166988-1-sam@rfc1149.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
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

guest-exec invocation does not need the full path of the executable to
execute. Using only the command names ensures correct execution of the
test on systems not adhering to the FHS.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 tests/unit/test-qga.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
index 671e83cb86..8cddf5dc37 100644
--- a/tests/unit/test-qga.c
+++ b/tests/unit/test-qga.c
@@ -822,7 +822,7 @@ static void test_qga_guest_exec(gconstpointer fix)
 
     /* exec 'echo foo bar' */
     ret = qmp_fd(fixture->fd, "{'execute': 'guest-exec', 'arguments': {"
-                 " 'path': '/bin/echo', 'arg': [ '-n', '\" test_str \"' ],"
+                 " 'path': 'echo', 'arg': [ '-n', '\" test_str \"' ],"
                  " 'capture-output': true } }");
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);
@@ -883,7 +883,7 @@ static void test_qga_guest_exec_separated(gconstpointer fix)
 
     /* exec 'echo foo bar' */
     ret = qmp_fd(fixture->fd, "{'execute': 'guest-exec', 'arguments': {"
-                 " 'path': '/bin/bash',"
+                 " 'path': 'bash',"
                  " 'arg': [ '-c', 'for i in $(seq 4); do if (( $i %% 2 )); then echo stdout; else echo stderr 1>&2; fi; done;' ],"
                  " 'capture-output': 'separated' } }");
     g_assert_nonnull(ret);
@@ -924,7 +924,7 @@ static void test_qga_guest_exec_merged(gconstpointer fix)
 
     /* exec 'echo foo bar' */
     ret = qmp_fd(fixture->fd, "{'execute': 'guest-exec', 'arguments': {"
-                 " 'path': '/bin/bash',"
+                 " 'path': 'bash',"
                  " 'arg': [ '-c', 'for i in $(seq 4); do if (( $i %% 2 )); then echo stdout; else echo stderr 1>&2; fi; done;' ],"
                  " 'capture-output': 'merged' } }");
     g_assert_nonnull(ret);
-- 
2.42.0


