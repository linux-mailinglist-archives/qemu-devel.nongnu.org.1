Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B572B7A7E9F
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:19:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwAf-0001hI-Uy; Wed, 20 Sep 2023 08:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qiwAQ-0001Fl-67; Wed, 20 Sep 2023 08:18:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qiwAO-0005sH-6d; Wed, 20 Sep 2023 08:18:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 56A0823A20;
 Wed, 20 Sep 2023 15:19:02 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id ADE9929707;
 Wed, 20 Sep 2023 15:18:42 +0300 (MSK)
Received: (nullmailer pid 106036 invoked by uid 1000);
 Wed, 20 Sep 2023 12:18:41 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Stefan Berger <stefanb@linux.ibm.com>
Subject: [Stable-8.0.5 70/70] tpm: fix crash when FD >= 1024 and unnecessary
 errors due to EINTR
Date: Wed, 20 Sep 2023 15:18:39 +0300
Message-Id: <20230920121841.106001-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230920151433@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230920151433@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Replace select() with poll() to fix a crash when QEMU has a large number
of FDs. Also use RETRY_ON_EINTR to avoid unnecessary errors due to EINTR.

Cc: qemu-stable@nongnu.org
Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2020133
Fixes: 56a3c24ffc ("tpm: Probe for connected TPM 1.2 or TPM 2")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
(cherry picked from commit 8e32ddff69b6b4547cc00592ad816484e160817a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index a6e6d3e72f..1856589c3b 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -112,12 +112,8 @@ static int tpm_util_request(int fd,
                             void *response,
                             size_t responselen)
 {
-    fd_set readfds;
+    GPollFD fds[1] = { {.fd = fd, .events = G_IO_IN } };
     int n;
-    struct timeval tv = {
-        .tv_sec = 1,
-        .tv_usec = 0,
-    };
 
     n = write(fd, request, requestlen);
     if (n < 0) {
@@ -127,11 +123,8 @@ static int tpm_util_request(int fd,
         return -EFAULT;
     }
 
-    FD_ZERO(&readfds);
-    FD_SET(fd, &readfds);
-
     /* wait for a second */
-    n = select(fd + 1, &readfds, NULL, NULL, &tv);
+    n = RETRY_ON_EINTR(g_poll(fds, 1, 1000));
     if (n != 1) {
         return -errno;
     }
-- 
2.39.2


