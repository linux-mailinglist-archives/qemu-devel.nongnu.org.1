Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 846B77B6926
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:37:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnedr-00077e-Ee; Tue, 03 Oct 2023 08:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnedp-00071M-RP
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnedo-0000Nr-3J
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696336603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y2TJjxqw7SzSnZaLUNRM+rREKOqfND12mU9YO35wFaQ=;
 b=hkwJQ+WiJNek3/XsCdu5K8ejDOKZURnAQIHz/105difO+VO5wxaeJph/3NQs+Mvrhz2C+e
 JvYl1ZLOCKU9E8tMkos5aeGZNsWoW1Mtu285NC2DZ3XYdCtpfhMBGv3ohq3Ux9u5XOpTzU
 kZ6sYUuMDsfnCuSRh6xmsZ8F5JvlwOM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-AM2LiOOGMkybMWABaQxx-Q-1; Tue, 03 Oct 2023 08:36:42 -0400
X-MC-Unique: AM2LiOOGMkybMWABaQxx-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA939185A79C
 for <qemu-devel@nongnu.org>; Tue,  3 Oct 2023 12:36:41 +0000 (UTC)
Received: from localhost (unknown [10.39.208.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A98051E3;
 Tue,  3 Oct 2023 12:36:40 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 13/13] chardev/char-pty: Avoid losing bytes when the other side
 just (re-)connected
Date: Tue,  3 Oct 2023 16:35:42 +0400
Message-ID: <20231003123543.1360795-14-marcandre.lureau@redhat.com>
In-Reply-To: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
References: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 chardev/char-pty.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 4e5deac18a..cc2f7617fe 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -106,11 +106,27 @@ static void pty_chr_update_read_handler(Chardev *chr)
 static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
     PtyChardev *s = PTY_CHARDEV(chr);
+    GPollFD pfd;
+    int rc;
 
-    if (!s->connected) {
-        return len;
+    if (s->connected) {
+        return io_channel_send(s->ioc, buf, len);
     }
-    return io_channel_send(s->ioc, buf, len);
+
+    /*
+     * The other side might already be re-connected, but the timer might
+     * not have fired yet. So let's check here whether we can write again:
+     */
+    pfd.fd = QIO_CHANNEL_FILE(s->ioc)->fd;
+    pfd.events = G_IO_OUT;
+    pfd.revents = 0;
+    rc = RETRY_ON_EINTR(g_poll(&pfd, 1, 0));
+    g_assert(rc >= 0);
+    if (!(pfd.revents & G_IO_HUP) && (pfd.revents & G_IO_OUT)) {
+        io_channel_send(s->ioc, buf, len);
+    }
+
+    return len;
 }
 
 static GSource *pty_chr_add_watch(Chardev *chr, GIOCondition cond)
-- 
2.41.0


