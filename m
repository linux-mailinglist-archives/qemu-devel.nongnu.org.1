Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B548377083C
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 20:55:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRzwN-0002KL-48; Fri, 04 Aug 2023 14:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRzwH-0002Jr-S2; Fri, 04 Aug 2023 14:54:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRzwG-00089L-6o; Fri, 04 Aug 2023 14:54:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1904D1840D;
 Fri,  4 Aug 2023 21:54:19 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6560D1B884;
 Fri,  4 Aug 2023 21:53:58 +0300 (MSK)
Received: (nullmailer pid 1874221 invoked by uid 1000);
 Fri, 04 Aug 2023 18:53:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 jiangyegen <jiangyegen@huawei.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.5 23/36] io: remove io watch if TLS channel is closed
 during handshake
Date: Fri,  4 Aug 2023 21:53:36 +0300
Message-Id: <20230804185350.1874133-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.5-20230804215319@cover.tls.msk.ru>
References: <qemu-stable-7.2.5-20230804215319@cover.tls.msk.ru>
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

From: Daniel P. Berrangé <berrange@redhat.com>

The TLS handshake make take some time to complete, during which time an
I/O watch might be registered with the main loop. If the owner of the
I/O channel invokes qio_channel_close() while the handshake is waiting
to continue the I/O watch must be removed. Failing to remove it will
later trigger the completion callback which the owner is not expecting
to receive. In the case of the VNC server, this results in a SEGV as
vnc_disconnect_start() tries to shutdown a client connection that is
already gone / NULL.

CVE-2023-3354
Reported-by: jiangyegen <jiangyegen@huawei.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit 10be627d2b5ec2d6b3dce045144aa739eef678b4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
index 5672479e9e..26c67f17e2 100644
--- a/include/io/channel-tls.h
+++ b/include/io/channel-tls.h
@@ -48,6 +48,7 @@ struct QIOChannelTLS {
     QIOChannel *master;
     QCryptoTLSSession *session;
     QIOChannelShutdown shutdown;
+    guint hs_ioc_tag;
 };
 
 /**
diff --git a/io/channel-tls.c b/io/channel-tls.c
index 4ce08ccc28..a91efb57f3 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -198,12 +198,13 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
         }
 
         trace_qio_channel_tls_handshake_pending(ioc, status);
-        qio_channel_add_watch_full(ioc->master,
-                                   condition,
-                                   qio_channel_tls_handshake_io,
-                                   data,
-                                   NULL,
-                                   context);
+        ioc->hs_ioc_tag =
+            qio_channel_add_watch_full(ioc->master,
+                                       condition,
+                                       qio_channel_tls_handshake_io,
+                                       data,
+                                       NULL,
+                                       context);
     }
 }
 
@@ -218,6 +219,7 @@ static gboolean qio_channel_tls_handshake_io(QIOChannel *ioc,
     QIOChannelTLS *tioc = QIO_CHANNEL_TLS(
         qio_task_get_source(task));
 
+    tioc->hs_ioc_tag = 0;
     g_free(data);
     qio_channel_tls_handshake_task(tioc, task, context);
 
@@ -377,6 +379,10 @@ static int qio_channel_tls_close(QIOChannel *ioc,
 {
     QIOChannelTLS *tioc = QIO_CHANNEL_TLS(ioc);
 
+    if (tioc->hs_ioc_tag) {
+        g_clear_handle_id(&tioc->hs_ioc_tag, g_source_remove);
+    }
+
     return qio_channel_close(tioc->master, errp);
 }
 
-- 
2.39.2


