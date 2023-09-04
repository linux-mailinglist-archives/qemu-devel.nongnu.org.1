Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EACC5791A00
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:49:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAsS-0006k0-Qy; Mon, 04 Sep 2023 10:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qdAsR-0006je-JW
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:48:31 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qdAsC-0004cP-Gn
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:48:31 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A8C341F38C;
 Mon,  4 Sep 2023 14:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693838894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+2qHZq5YHWZa5PL6pR5iirRHx0XHgaVsG7iMF7ATyyQ=;
 b=UoVmTX5oJkktBG1hfz5SKFFbOKldDqBM3zes8bs19YDny9pMx18O8ZY6nYR368dWf24rJ8
 yOfWROlCWprAwQgdHUcP7GtG2KROzvuUg+kufP5S2KTPy1izhjIc7l5utkD2dDmua5lVgQ
 GJSrP4OKdWVI/Ur68qAQHkFp7ST+WxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693838894;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+2qHZq5YHWZa5PL6pR5iirRHx0XHgaVsG7iMF7ATyyQ=;
 b=OI1H7nxyEF8+Q3jwDY0EEdfJjDNp0IZaEaD5IiZ8vk0rzKmKqmOuPWTesAqGbuVG3vLT7E
 nqJ6LNtGr+vyoDAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9274A13425;
 Mon,  4 Sep 2023 14:48:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iLHlFi3u9WRAOQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 04 Sep 2023 14:48:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH] iothread: Set the GSource "name" field
Date: Mon,  4 Sep 2023 11:48:11 -0300
Message-Id: <20230904144811.4218-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 iothread.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/iothread.c b/iothread.c
index b41c305bd9..8cfb9d5be6 100644
--- a/iothread.c
+++ b/iothread.c
@@ -138,15 +138,19 @@ static void iothread_instance_finalize(Object *obj)
     qemu_sem_destroy(&iothread->init_done_sem);
 }
 
-static void iothread_init_gcontext(IOThread *iothread)
+static void iothread_init_gcontext(IOThread *iothread, char *thread_name)
 {
     GSource *source;
+    gchar *name = g_strdup_printf("%s aio-context", thread_name);
 
     iothread->worker_context = g_main_context_new();
     source = aio_get_g_source(iothread_get_aio_context(iothread));
+    g_source_set_name(source, name);
     g_source_attach(source, iothread->worker_context);
     g_source_unref(source);
     iothread->main_loop = g_main_loop_new(iothread->worker_context, TRUE);
+
+    g_free(name);
 }
 
 static void iothread_set_aio_context_params(EventLoopBase *base, Error **errp)
@@ -189,11 +193,14 @@ static void iothread_init(EventLoopBase *base, Error **errp)
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
@@ -206,8 +213,6 @@ static void iothread_init(EventLoopBase *base, Error **errp)
     /* This assumes we are called from a thread with useful CPU affinity for us
      * to inherit.
      */
-    thread_name = g_strdup_printf("IO %s",
-                        object_get_canonical_path_component(OBJECT(base)));
     qemu_thread_create(&iothread->thread, thread_name, iothread_run,
                        iothread, QEMU_THREAD_JOINABLE);
     g_free(thread_name);
-- 
2.35.3


