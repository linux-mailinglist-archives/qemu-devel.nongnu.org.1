Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 056FA765236
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 13:26:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOyhe-0000D9-F7; Thu, 27 Jul 2023 06:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qOyha-00009D-BC; Thu, 27 Jul 2023 06:58:38 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qOyhW-0006Ig-FN; Thu, 27 Jul 2023 06:58:37 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qOyfZ-004d1t-19;
 Thu, 27 Jul 2023 12:58:28 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 1/1] qemu-nbd: regression with arguments passing into
 nbd_client_thread()
Date: Thu, 27 Jul 2023 12:58:28 +0200
Message-Id: <20230727105828.324314-1-den@openvz.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
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

Unfortunately
    commit 03b67621445d601c9cdc7dfe25812e9f19b81488
    Author: Denis V. Lunev <den@openvz.org>
    Date:   Mon Jul 17 16:55:40 2023 +0200
    qemu-nbd: pass structure into nbd_client_thread instead of plain char*
has introduced a regression. struct NbdClientOpts resides on stack inside
'if' block. This specifically means that this stack space could be reused
once the execution will leave that block of the code.

This means that parameters passed into nbd_client_thread could be
overwritten at any moment.

The patch moves the data to the namespace of main() function effectively
preserving it for the whole process lifetime.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: <qemu-stable@nongnu.org>
---
Changes from v1:
- fixed compilation without HAVE_NBD_DEVICE (i.e. for Win/BSD)

 qemu-nbd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 5b2757920c..aaccaa3318 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -589,6 +589,9 @@ int main(int argc, char **argv)
     const char *pid_file_name = NULL;
     const char *selinux_label = NULL;
     BlockExportOptions *export_opts;
+#if HAVE_NBD_DEVICE
+    struct NbdClientOpts opts;
+#endif
 
 #ifdef CONFIG_POSIX
     os_setup_early_signal_handling();
@@ -1145,7 +1148,7 @@ int main(int argc, char **argv)
     if (device) {
 #if HAVE_NBD_DEVICE
         int ret;
-        struct NbdClientOpts opts = {
+        opts = (struct NbdClientOpts) {
             .device = device,
             .fork_process = fork_process,
             .verbose = verbose,
-- 
2.34.1


