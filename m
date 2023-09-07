Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F96797B76
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 20:18:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeJYd-0002hi-W9; Thu, 07 Sep 2023 14:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeJYc-0002gw-8j
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 14:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeJYa-0005rD-0K
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 14:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694110598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YYi4iz2JOtEKP9Hr6Hyd+RRbIBudK+RlXAauFdbyMUM=;
 b=APjZAjXeAntBpfUf9EG3EYzciLUPcIdRQ0AEArr3qLD68L0B1/A+JyeXBQrQMi9RUXlXDP
 WLM+7zYDR1w5cO8FCyYhnty4hwCppuTBA3CxRXS4jESSzwypYTWWlkM2QQ37simzwxCE5X
 U6GWEqykAQuFYjzXsD9dnaSSL1++84M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-1sZB3QTJMROEupvxccu7vQ-1; Thu, 07 Sep 2023 14:16:32 -0400
X-MC-Unique: 1sZB3QTJMROEupvxccu7vQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C5FB101A529;
 Thu,  7 Sep 2023 18:16:32 +0000 (UTC)
Received: from localhost (unknown [10.39.193.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92A6440C2070;
 Thu,  7 Sep 2023 18:16:31 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 1/5] iothread: Set the GSource "name" field
Date: Thu,  7 Sep 2023 14:16:24 -0400
Message-ID: <20230907181628.1594401-2-stefanha@redhat.com>
In-Reply-To: <20230907181628.1594401-1-stefanha@redhat.com>
References: <20230907181628.1594401-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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

From: Fabiano Rosas <farosas@suse.de>

Having a name in the source helps with debugging core dumps when one
might not have access to TLS data to cross-reference AioContexts with
their addresses.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230905180359.14083-1-farosas@suse.de
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 iothread.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/iothread.c b/iothread.c
index b41c305bd9..b753286414 100644
--- a/iothread.c
+++ b/iothread.c
@@ -138,12 +138,14 @@ static void iothread_instance_finalize(Object *obj)
     qemu_sem_destroy(&iothread->init_done_sem);
 }
 
-static void iothread_init_gcontext(IOThread *iothread)
+static void iothread_init_gcontext(IOThread *iothread, const char *thread_name)
 {
     GSource *source;
+    g_autofree char *name = g_strdup_printf("%s aio-context", thread_name);
 
     iothread->worker_context = g_main_context_new();
     source = aio_get_g_source(iothread_get_aio_context(iothread));
+    g_source_set_name(source, name);
     g_source_attach(source, iothread->worker_context);
     g_source_unref(source);
     iothread->main_loop = g_main_loop_new(iothread->worker_context, TRUE);
@@ -180,7 +182,7 @@ static void iothread_init(EventLoopBase *base, Error **errp)
 {
     Error *local_error = NULL;
     IOThread *iothread = IOTHREAD(base);
-    char *thread_name;
+    g_autofree char *thread_name = NULL;
 
     iothread->stopping = false;
     iothread->running = true;
@@ -189,11 +191,14 @@ static void iothread_init(EventLoopBase *base, Error **errp)
         return;
     }
 
+    thread_name = g_strdup_printf("IO %s",
+                        object_get_canonical_path_component(OBJECT(base)));
+
     /*
      * Init one GMainContext for the iothread unconditionally, even if
      * it's not used
      */
-    iothread_init_gcontext(iothread);
+    iothread_init_gcontext(iothread, thread_name);
 
     iothread_set_aio_context_params(base, &local_error);
     if (local_error) {
@@ -206,11 +211,8 @@ static void iothread_init(EventLoopBase *base, Error **errp)
     /* This assumes we are called from a thread with useful CPU affinity for us
      * to inherit.
      */
-    thread_name = g_strdup_printf("IO %s",
-                        object_get_canonical_path_component(OBJECT(base)));
     qemu_thread_create(&iothread->thread, thread_name, iothread_run,
                        iothread, QEMU_THREAD_JOINABLE);
-    g_free(thread_name);
 
     /* Wait for initialization to complete */
     while (iothread->thread_id == -1) {
-- 
2.41.0


