Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1A2792CB6
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 19:47:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qda8f-00041Y-6n; Tue, 05 Sep 2023 13:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qda8S-0003yL-Ky
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 13:46:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qda8Q-0006MZ-8j
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 13:46:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 96A0F1FF64;
 Tue,  5 Sep 2023 17:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693935999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=L/WAEDSFNLpsb5m9BlWlLp+qgIbutuYimcNiIgtUEIE=;
 b=Y2/IjpQFdT1QoVpWIX6FFaIhbZUYVstRSt2aFDQYLemcrJEsJ4i9+/xg7ipSwEzG9ZXcYG
 qM+5bjyj3zpvE0UhJ1YhBTGrPebp2iYxqiz+D5eUodO0wdXSndKEBLtTgROecQOwMW82/I
 q2Cca4xKGp2iBUep5chUv7/CUK9qEsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693935999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=L/WAEDSFNLpsb5m9BlWlLp+qgIbutuYimcNiIgtUEIE=;
 b=sqDwnR5T8QSHM4r8jzf9TieJaRBpk6EaUBuTByIO5ppNMHQJGUrYgmB6ANhAzCFpqLC/sA
 XIk8FhWyYH2+y4Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49EDC13499;
 Tue,  5 Sep 2023 17:46:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +dhEBX5p92SFQgAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 05 Sep 2023 17:46:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] iothread: Set the GSource "name" field
Date: Tue,  5 Sep 2023 14:46:35 -0300
Message-Id: <20230905174635.10112-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Having a name in the source helps with debugging core dumps when one
might not have access to TLS data to cross-reference AioContexts with
their addresses.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
v2:
used g_autofree where appropriate
---
 iothread.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/iothread.c b/iothread.c
index b41c305bd9..78ac1153ac 100644
--- a/iothread.c
+++ b/iothread.c
@@ -138,12 +138,14 @@ static void iothread_instance_finalize(Object *obj)
     qemu_sem_destroy(&iothread->init_done_sem);
 }
 
-static void iothread_init_gcontext(IOThread *iothread)
+static void iothread_init_gcontext(IOThread *iothread, char *thread_name)
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
2.35.3


