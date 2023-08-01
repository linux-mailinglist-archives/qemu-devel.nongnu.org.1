Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C50F376BB97
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 19:48:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQtSX-00016v-Tm; Tue, 01 Aug 2023 13:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQtSV-00016O-9P
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 13:46:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQtST-00075t-Pw
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 13:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690912016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BL0ARjJ+eQs4h4J0geGkfpYZpOtvMOsNh41wGouGR3w=;
 b=UT9Yd83R4ZqMx1ZdxBkEtReiYWXKLNHj9bmi7CbcHkvGI+xlYej829Gx/Sc9HFLH9sx+M+
 Q2F8bTxeBhZtlc1hRi4wy3rmM/fGce54ZhWbYePhFwcwdTaYfm0XPT15QsH2YA075nKFVM
 0nFHAX9EdV1nCOGduGDhmBFszALvsjs=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-687-eAJN1MDpM4-3O8KI8DfhZg-1; Tue, 01 Aug 2023 13:46:53 -0400
X-MC-Unique: eAJN1MDpM4-3O8KI8DfhZg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DE3E3C0C496;
 Tue,  1 Aug 2023 17:46:53 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61952401E63;
 Tue,  1 Aug 2023 17:46:52 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, jiangyegen <jiangyegen@huawei.com>
Subject: [PULL 1/1] io: remove io watch if TLS channel is closed during
 handshake
Date: Tue,  1 Aug 2023 18:46:50 +0100
Message-ID: <20230801174650.177924-2-berrange@redhat.com>
In-Reply-To: <20230801174650.177924-1-berrange@redhat.com>
References: <20230801174650.177924-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
---
 include/io/channel-tls.h |  1 +
 io/channel-tls.c         | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

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
index 9805dd0a3f..847d5297c3 100644
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
 
@@ -378,6 +380,10 @@ static int qio_channel_tls_close(QIOChannel *ioc,
 {
     QIOChannelTLS *tioc = QIO_CHANNEL_TLS(ioc);
 
+    if (tioc->hs_ioc_tag) {
+        g_clear_handle_id(&tioc->hs_ioc_tag, g_source_remove);
+    }
+
     return qio_channel_close(tioc->master, errp);
 }
 
-- 
2.41.0


