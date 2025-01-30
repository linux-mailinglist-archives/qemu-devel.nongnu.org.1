Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A7DA22B76
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Jan 2025 11:14:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdRUi-0002Ef-Qk; Thu, 30 Jan 2025 05:09:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRUg-0002EU-5w
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:09:54 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRUe-00073x-MQ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:09:53 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRUZ-00000006TxG-04Ei; Thu, 30 Jan 2025 11:09:47 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 07/33] io: tls: Allow terminating the TLS session
 gracefully with EOF
Date: Thu, 30 Jan 2025 11:08:28 +0100
Message-ID: <fdd9a0a6053ac6aed32e08cc284991a3630bbfec.1738171076.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738171076.git.maciej.szmigiero@oracle.com>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.037, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Currently, hitting EOF on receive without sender terminating the TLS
session properly causes the TLS channel to return an error (unless
the channel was already shut down for read).

Add an optional setting whether we instead just return EOF in that
case.

This possibility will be soon used by the migration multifd code.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/io/channel-tls.h | 11 +++++++++++
 io/channel-tls.c         |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
index 26c67f17e2d3..8552c0d0266e 100644
--- a/include/io/channel-tls.h
+++ b/include/io/channel-tls.h
@@ -49,6 +49,7 @@ struct QIOChannelTLS {
     QCryptoTLSSession *session;
     QIOChannelShutdown shutdown;
     guint hs_ioc_tag;
+    bool premature_eof_okay;
 };
 
 /**
@@ -143,4 +144,14 @@ void qio_channel_tls_handshake(QIOChannelTLS *ioc,
 QCryptoTLSSession *
 qio_channel_tls_get_session(QIOChannelTLS *ioc);
 
+/**
+ * qio_channel_tls_set_premature_eof_okay:
+ * @ioc: the TLS channel object
+ *
+ * Sets whether receiving an EOF without terminating the TLS session properly
+ * by used the other side is considered okay or an error (the
+ * default behaviour).
+ */
+void qio_channel_tls_set_premature_eof_okay(QIOChannelTLS *ioc, bool enabled);
+
 #endif /* QIO_CHANNEL_TLS_H */
diff --git a/io/channel-tls.c b/io/channel-tls.c
index aab630e5ae32..1079d6d10de1 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -147,6 +147,11 @@ qio_channel_tls_new_client(QIOChannel *master,
     return NULL;
 }
 
+void qio_channel_tls_set_premature_eof_okay(QIOChannelTLS *ioc, bool enabled)
+{
+    ioc->premature_eof_okay = enabled;
+}
+
 struct QIOChannelTLSData {
     QIOTask *task;
     GMainContext *context;
@@ -279,6 +284,7 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
             tioc->session,
             iov[i].iov_base,
             iov[i].iov_len,
+            tioc->premature_eof_okay ||
             qatomic_load_acquire(&tioc->shutdown) & QIO_CHANNEL_SHUTDOWN_READ,
             errp);
         if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {

