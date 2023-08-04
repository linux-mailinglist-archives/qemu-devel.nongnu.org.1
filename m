Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5970C7708CD
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 21:18:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS0IE-0000Gm-9L; Fri, 04 Aug 2023 15:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0IB-0000GD-I2; Fri, 04 Aug 2023 15:16:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0I9-0006sc-Nd; Fri, 04 Aug 2023 15:16:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C312318453;
 Fri,  4 Aug 2023 22:17:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4F1A91B896;
 Fri,  4 Aug 2023 22:16:49 +0300 (MSK)
Received: (nullmailer pid 1875690 invoked by uid 1000);
 Fri, 04 Aug 2023 19:16:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 25/63] qemu-nbd: regression with arguments passing into
 nbd_client_thread()
Date: Fri,  4 Aug 2023 22:16:16 +0300
Message-Id: <20230804191647.1875608-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Denis V. Lunev" <den@openvz.org>

Unfortunately
    commit 03b67621445d601c9cdc7dfe25812e9f19b81488
    (8.0:  feb0814b3b48e75b336ad72eb303f9d579c94083)
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-ID: <20230727105828.324314-1-den@openvz.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit e5b815b0defcc3617f473ba70c3e675ef0ee69c2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: add reference to feb0814b3b48e75b336ad72eb303f9d579c94083 for 8.0 branch)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index e64f45f767..1039809e9c 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -584,6 +584,9 @@ int main(int argc, char **argv)
     const char *pid_file_name = NULL;
     const char *selinux_label = NULL;
     BlockExportOptions *export_opts;
+#if HAVE_NBD_DEVICE
+    struct NbdClientOpts opts;
+#endif
 
 #ifdef CONFIG_POSIX
     os_setup_early_signal_handling();
@@ -1120,7 +1123,7 @@ int main(int argc, char **argv)
     if (device) {
 #if HAVE_NBD_DEVICE
         int ret;
-        struct NbdClientOpts opts = {
+        opts = (struct NbdClientOpts) {
             .device = device,
             .fork_process = fork_process,
         };
-- 
2.39.2


