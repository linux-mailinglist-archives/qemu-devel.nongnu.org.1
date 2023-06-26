Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F3A73EB0A
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:13:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrSF-0006xG-3i; Mon, 26 Jun 2023 15:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrSB-0006q0-9y; Mon, 26 Jun 2023 15:00:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrS9-0007Xy-EN; Mon, 26 Jun 2023 15:00:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 10BD8EFB7;
 Mon, 26 Jun 2023 21:59:12 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 20ED7F7F3;
 Mon, 26 Jun 2023 21:59:10 +0300 (MSK)
Received: (nullmailer pid 1575342 invoked by uid 1000);
 Mon, 26 Jun 2023 18:59:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Mark Somerville <mark@qpok.net>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.4 22/43] qga: Fix suspend on Linux guests without systemd
Date: Mon, 26 Jun 2023 21:58:40 +0300
Message-Id: <20230626185902.1575177-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
References: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Mark Somerville <mark@qpok.net>

Allow the Linux guest agent to attempt each of the suspend methods
(systemctl, pm-* and writing to /sys) in turn.

Prior to this guests without systemd failed to suspend due to
`guest_suspend` returning early regardless of the return value of
`systemd_supports_mode`.

Signed-off-by: Mark Somerville <mark@qpok.net>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
(cherry picked from commit 86dcb6ab9b603450eb6d896cdc95286de2c7d561)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 32493d6383..182eba4a38 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1925,10 +1925,10 @@ static void guest_suspend(SuspendMode mode, Error **errp)
     if (systemd_supports_mode(mode, &local_err)) {
         mode_supported = true;
         systemd_suspend(mode, &local_err);
-    }
 
-    if (!local_err) {
-        return;
+        if (!local_err) {
+            return;
+        }
     }
 
     error_free(local_err);
@@ -1937,10 +1937,10 @@ static void guest_suspend(SuspendMode mode, Error **errp)
     if (pmutils_supports_mode(mode, &local_err)) {
         mode_supported = true;
         pmutils_suspend(mode, &local_err);
-    }
 
-    if (!local_err) {
-        return;
+        if (!local_err) {
+            return;
+        }
     }
 
     error_free(local_err);
-- 
2.39.2


