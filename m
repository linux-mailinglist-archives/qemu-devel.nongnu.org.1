Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55284880605
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Mar 2024 21:22:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmfxr-00014Z-S4; Tue, 19 Mar 2024 16:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmfxq-00014C-5y
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:21:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmfxo-0007X9-EB
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710879695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gwhuhopU6Owv4BRvoghyf3BdPZYUiV632VPHRz7qJqI=;
 b=F2vL3Gv2d6aagG4ZC9PCbDTmMEl04qZnEtve/iRR+Y2id4GRsgLvhnHBJg4XnSRs+pZxww
 /oid+WUAmjsZD7Ykc9ZcpZ7euEiwBMbFS8oFHROxWa2WZ8v3u4IWNe0vsJe2a8Tx+rN4Us
 hGWTO6cWm/sN0nkjiv+jnwn97Hb6iE8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-33fwykhrMQKwcVrwXGiguQ-1; Tue,
 19 Mar 2024 16:21:34 -0400
X-MC-Unique: 33fwykhrMQKwcVrwXGiguQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDCB91C05EB8
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 20:21:33 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4AFA10E47;
 Tue, 19 Mar 2024 20:21:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 4/8] Revert "chardev: use a child source for qio input source"
Date: Tue, 19 Mar 2024 20:21:17 +0000
Message-ID: <20240319202121.233130-5-berrange@redhat.com>
In-Reply-To: <20240319202121.233130-1-berrange@redhat.com>
References: <20240319202121.233130-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

This reverts commit a7077b8e354d90fec26c2921aa2dea85b90dff90,
and add comments to explain why child sources cannot be used.

When a GSource is added as a child of another GSource, if its
'prepare' function indicates readiness, then the parent's
'prepare' function will never be run. The io_watch_poll_prepare
absolutely *must* be run on every iteration of the main loop,
to ensure that the chardev backend doesn't feed data to the
frontend that it is unable to consume.

At the time a7077b8e354d90fec26c2921aa2dea85b90dff90 was made,
all the child GSource impls were relying on poll'ing an FD,
so their 'prepare' functions would never indicate readiness
ahead of poll() being invoked. So the buggy behaviour was
not noticed and lay dormant.

Relatively recently the QIOChannelTLS impl introduced a
level 2 child GSource, which checks with GNUTLS whether it
has cached any data that was decoded but not yet consumed:

  commit ffda5db65aef42266a5053a4be34515106c4c7ee
  Author: Antoine Damhet <antoine.damhet@shadow.tech>
  Date:   Tue Nov 15 15:23:29 2022 +0100

    io/channel-tls: fix handling of bigger read buffers

    Since the TLS backend can read more data from the underlying QIOChannel
    we introduce a minimal child GSource to notify if we still have more
    data available to be read.

    Signed-off-by: Antoine Damhet <antoine.damhet@shadow.tech>
    Signed-off-by: Charles Frey <charles.frey@shadow.tech>
    Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

With this, it is now quite common for the 'prepare' function
on a QIOChannelTLS GSource to indicate immediate readiness,
bypassing the parent GSource 'prepare' function. IOW, the
critical 'io_watch_poll_prepare' is being skipped on some
iterations of the main loop. As a result chardev frontend
asserts are now being triggered as they are fed data they
are not ready to consume.

A reproducer is as follows:

 * In terminal 1 run a GNUTLS *echo* server

   $ gnutls-serv --echo \
                 --x509cafile ca-cert.pem \
                 --x509keyfile server-key.pem \
		 --x509certfile server-cert.pem \
		 -p 9000

 * In terminal 2 run a QEMU guest

   $ qemu-system-s390x \
       -nodefaults \
       -display none \
       -object tls-creds-x509,id=tls0,dir=$PWD,endpoint=client \
       -chardev socket,id=con0,host=localhost,port=9000,tls-creds=tls0 \
       -device sclpconsole,chardev=con0 \
       -hda Fedora-Cloud-Base-39-1.5.s390x.qcow2

After the previous patch revert, but before this patch revert,
this scenario will crash:

  qemu-system-s390x: ../hw/char/sclpconsole.c:73: chr_read: Assertion
  `size <= SIZE_BUFFER_VT220 - scon->iov_data_len' failed.

This assert indicates that 'tcp_chr_read' was called without
'tcp_chr_read_poll' having first been checked for ability to
receive more data

QEMU's use of a 'prepare' function to create/delete another
GSource is rather a hack and not normally the kind of thing that
is expected to be done by a GSource. There is no mechanism to
force GLib to always run the 'prepare' function of a parent
GSource. The best option is to simply not use the child source
concept, and go back to the functional approach previously
relied on.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char-io.c | 56 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/chardev/char-io.c b/chardev/char-io.c
index 4451128cba..dab77b112e 100644
--- a/chardev/char-io.c
+++ b/chardev/char-io.c
@@ -33,6 +33,7 @@ typedef struct IOWatchPoll {
     IOCanReadHandler *fd_can_read;
     GSourceFunc fd_read;
     void *opaque;
+    GMainContext *context;
 } IOWatchPoll;
 
 static IOWatchPoll *io_watch_poll_from_source(GSource *source)
@@ -50,28 +51,59 @@ static gboolean io_watch_poll_prepare(GSource *source,
         return FALSE;
     }
 
+    /*
+     * We do not register the QIOChannel watch as a child GSource.
+     * The 'prepare' function on the parent GSource will be
+     * skipped if a child GSource's 'prepare' function indicates
+     * readiness. We need this prepare function be guaranteed
+     * to run on *every* iteration of the main loop, because
+     * it is critical to ensure we remove the QIOChannel watch
+     * if 'fd_can_read' indicates the frontend cannot receive
+     * more data.
+     */
     if (now_active) {
         iwp->src = qio_channel_create_watch(
             iwp->ioc, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL);
         g_source_set_callback(iwp->src, iwp->fd_read, iwp->opaque, NULL);
-        g_source_add_child_source(source, iwp->src);
-        g_source_unref(iwp->src);
+        g_source_attach(iwp->src, iwp->context);
     } else {
-        g_source_remove_child_source(source, iwp->src);
+        g_source_destroy(iwp->src);
+        g_source_unref(iwp->src);
         iwp->src = NULL;
     }
     return FALSE;
 }
 
+static gboolean io_watch_poll_check(GSource *source)
+{
+    return FALSE;
+}
+
 static gboolean io_watch_poll_dispatch(GSource *source, GSourceFunc callback,
                                        gpointer user_data)
 {
-    return G_SOURCE_CONTINUE;
+    abort();
+}
+
+static void io_watch_poll_finalize(GSource *source)
+{
+    /*
+     * Due to a glib bug, removing the last reference to a source
+     * inside a finalize callback causes recursive locking (and a
+     * deadlock).  This is not a problem inside other callbacks,
+     * including dispatch callbacks, so we call io_remove_watch_poll
+     * to remove this source.  At this point, iwp->src must
+     * be NULL, or we would leak it.
+     */
+    IOWatchPoll *iwp = io_watch_poll_from_source(source);
+    assert(iwp->src == NULL);
 }
 
 static GSourceFuncs io_watch_poll_funcs = {
     .prepare = io_watch_poll_prepare,
+    .check = io_watch_poll_check,
     .dispatch = io_watch_poll_dispatch,
+    .finalize = io_watch_poll_finalize,
 };
 
 GSource *io_add_watch_poll(Chardev *chr,
@@ -91,6 +123,7 @@ GSource *io_add_watch_poll(Chardev *chr,
     iwp->ioc = ioc;
     iwp->fd_read = (GSourceFunc) fd_read;
     iwp->src = NULL;
+    iwp->context = context;
 
     name = g_strdup_printf("chardev-iowatch-%s", chr->label);
     g_source_set_name((GSource *)iwp, name);
@@ -101,10 +134,23 @@ GSource *io_add_watch_poll(Chardev *chr,
     return (GSource *)iwp;
 }
 
+static void io_remove_watch_poll(GSource *source)
+{
+    IOWatchPoll *iwp;
+
+    iwp = io_watch_poll_from_source(source);
+    if (iwp->src) {
+        g_source_destroy(iwp->src);
+        g_source_unref(iwp->src);
+        iwp->src = NULL;
+    }
+    g_source_destroy(&iwp->parent);
+}
+
 void remove_fd_in_watch(Chardev *chr)
 {
     if (chr->gsource) {
-        g_source_destroy(chr->gsource);
+        io_remove_watch_poll(chr->gsource);
         chr->gsource = NULL;
     }
 }
-- 
2.43.0


