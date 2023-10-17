Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FAF7CBD89
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:32:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfUn-0007ta-4N; Tue, 17 Oct 2023 04:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfUe-0007hf-R8
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfUd-0005Y2-5T
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697531518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pP+HBLoIF2+JKG9/BKNs8YlosAiNeVK/p76YdQ6oFrU=;
 b=P+Mf8Oar8nvODTB7FHnW6+lZLraTY8klYets2Zm/J/I/SgFOrklGpC4I/zRHkOWiiWJFr2
 ggKgz+DiH79vMn+lueAv/9rlVxjRAB1ZLthvfc9F4iTZi7pOUWfvPNgBZhP0MpaLqHL6f2
 KKWFJJ84CR1KVJW/GbbMMv1EcpOPQlw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-UTmr0-TOM2WmFxNylU6OHA-1; Tue, 17 Oct 2023 04:31:55 -0400
X-MC-Unique: UTmr0-TOM2WmFxNylU6OHA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA2382932486;
 Tue, 17 Oct 2023 08:31:54 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22E921C060AE;
 Tue, 17 Oct 2023 08:31:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/38] migration/multifd: Remove direct "socket" references
Date: Tue, 17 Oct 2023 10:30:01 +0200
Message-ID: <20231017083003.15951-37-quintela@redhat.com>
In-Reply-To: <20231017083003.15951-1-quintela@redhat.com>
References: <20231017083003.15951-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

We're about to enable support for other transports in multifd, so
remove direct references to sockets.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231012134343.23757-2-farosas@suse.de>
---
 migration/multifd.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index c45f5015f8..8e9a5ee394 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -510,6 +510,11 @@ static void multifd_send_terminate_threads(Error *err)
     }
 }
 
+static int multifd_send_channel_destroy(QIOChannel *send)
+{
+    return socket_send_channel_destroy(send);
+}
+
 void multifd_save_cleanup(void)
 {
     int i;
@@ -532,7 +537,7 @@ void multifd_save_cleanup(void)
         if (p->registered_yank) {
             migration_ioc_unregister_yank(p->c);
         }
-        socket_send_channel_destroy(p->c);
+        multifd_send_channel_destroy(p->c);
         p->c = NULL;
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
@@ -890,20 +895,25 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
 static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
 {
     MultiFDSendParams *p = opaque;
-    QIOChannel *sioc = QIO_CHANNEL(qio_task_get_source(task));
+    QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
     Error *local_err = NULL;
 
     trace_multifd_new_send_channel_async(p->id);
     if (!qio_task_propagate_error(task, &local_err)) {
-        p->c = sioc;
+        p->c = ioc;
         qio_channel_set_delay(p->c, false);
         p->running = true;
-        if (multifd_channel_connect(p, sioc, local_err)) {
+        if (multifd_channel_connect(p, ioc, local_err)) {
             return;
         }
     }
 
-    multifd_new_send_channel_cleanup(p, sioc, local_err);
+    multifd_new_send_channel_cleanup(p, ioc, local_err);
+}
+
+static void multifd_new_send_channel_create(gpointer opaque)
+{
+    socket_send_channel_create(multifd_new_send_channel_async, opaque);
 }
 
 int multifd_save_setup(Error **errp)
@@ -952,7 +962,7 @@ int multifd_save_setup(Error **errp)
             p->write_flags = 0;
         }
 
-        socket_send_channel_create(multifd_new_send_channel_async, p);
+        multifd_new_send_channel_create(p);
     }
 
     for (i = 0; i < thread_count; i++) {
-- 
2.41.0


