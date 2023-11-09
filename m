Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8F87E6C0E
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:06:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15eC-0008Qi-LZ; Thu, 09 Nov 2023 09:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15bm-0002V6-6L; Thu, 09 Nov 2023 09:02:10 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15bj-0006QJ-Tv; Thu, 09 Nov 2023 09:02:09 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4899231BD2;
 Thu,  9 Nov 2023 16:59:56 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 516DB3450B;
 Thu,  9 Nov 2023 16:59:48 +0300 (MSK)
Received: (nullmailer pid 1462862 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 28/62] chardev/char-pty: Avoid losing bytes when the
 other side just (re-)connected
Date: Thu,  9 Nov 2023 16:58:56 +0300
Message-Id: <20231109135933.1462615-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
References: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Thomas Huth <thuth@redhat.com>

When starting a guest via libvirt with "virsh start --console ...",
the first second of the console output is missing. This is especially
annoying on s390x that only has a text console by default and no graphical
output - if the bios fails to boot here, the information about what went
wrong is completely lost.

One part of the problem (there is also some things to be done on the
libvirt side) is that QEMU only checks with a 1 second timer whether
the other side of the pty is already connected, so the first second of
the console output is always lost.

This likely used to work better in the past, since the code once checked
for a re-connection during write, but this has been removed in commit
f8278c7d74 ("char-pty: remove the check for connection on write") to avoid
some locking.

To ease the situation here at least a little bit, let's check with g_poll()
whether we could send out the data anyway, even if the connection has not
been marked as "connected" yet. The file descriptor is marked as non-blocking
anyway since commit fac6688a18 ("Do not hang on full PTY"), so this should
not cause any trouble if the other side is not ready for receiving yet.

With this patch applied, I can now successfully see the bios output of
a s390x guest when running it with "virsh start --console" (with a patched
version of virsh that fixes the remaining issues there, too).

Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230816210743.1319018-1-thuth@redhat.com>
(cherry picked from commit 4f7689f0817a717d18cc8aca298990760f27a89b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: use TFR() instead of RETRY_ON_EINTR() before v7.2.0-538-g8b6aa69365)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 53f25c6bbd..e6d0b05211 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -108,11 +108,27 @@ static void pty_chr_update_read_handler(Chardev *chr)
 static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
     PtyChardev *s = PTY_CHARDEV(chr);
+    GPollFD pfd;
+    int rc;
 
-    if (!s->connected) {
-        return len;
+    if (s->connected) {
+        return io_channel_send(s->ioc, buf, len);
+    }
+
+    /*
+     * The other side might already be re-connected, but the timer might
+     * not have fired yet. So let's check here whether we can write again:
+     */
+    pfd.fd = QIO_CHANNEL_FILE(s->ioc)->fd;
+    pfd.events = G_IO_OUT;
+    pfd.revents = 0;
+    TFR(rc = g_poll(&pfd, 1, 0));
+    g_assert(rc >= 0);
+    if (!(pfd.revents & G_IO_HUP) && (pfd.revents & G_IO_OUT)) {
+        io_channel_send(s->ioc, buf, len);
     }
-    return io_channel_send(s->ioc, buf, len);
+
+    return len;
 }
 
 static GSource *pty_chr_add_watch(Chardev *chr, GIOCondition cond)
-- 
2.39.2


