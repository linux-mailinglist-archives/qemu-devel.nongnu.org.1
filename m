Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE1C7C6F8E
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 15:44:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqvzE-0000AL-E2; Thu, 12 Oct 2023 09:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqvyj-0008Pi-TA
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:43:54 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqvyi-0003Te-52
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:43:53 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D81BC21857;
 Thu, 12 Oct 2023 13:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697118228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X4reKZqkDp4jOWuqiDlkwx0OZeywEl8eez9VlBmkeoo=;
 b=q9x4g/VF5HKY2E7gsCbimyOVwW8KMHVSvop+f6IpadFw8RiulxxLhX2tcytkN/muOzCR4L
 R6pZo42sfAIylndLBiB2CxuOkqPWXEATLHUvDnwD5aHSvUvSHZ+7YczTt9wXcAu9HczEvQ
 qUuiN4vCvcHQIt9o4R0wgOECLvl8yOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697118228;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X4reKZqkDp4jOWuqiDlkwx0OZeywEl8eez9VlBmkeoo=;
 b=TaUnvxzdshWVG1XmIhMCPSFMGyJJAn0Vot0hA/CiHt22T8AP60fBwRTYsap8z2dxJZMFpq
 OQFnN5XRKDxN2NDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96172139ED;
 Thu, 12 Oct 2023 13:43:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uJY+GBP4J2UQfAAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 12 Oct 2023 13:43:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 1/3] migration/multifd: Remove direct "socket" references
Date: Thu, 12 Oct 2023 10:43:41 -0300
Message-Id: <20231012134343.23757-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231012134343.23757-1-farosas@suse.de>
References: <20231012134343.23757-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 R_MISSING_CHARSET(2.50)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[25.35%]
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

We're about to enable support for other transports in multifd, so
remove direct references to sockets.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 0f6b203877..a7c7a947e3 100644
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
@@ -889,20 +894,25 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
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
@@ -951,7 +961,7 @@ int multifd_save_setup(Error **errp)
             p->write_flags = 0;
         }
 
-        socket_send_channel_create(multifd_new_send_channel_async, p);
+        multifd_new_send_channel_create(p);
     }
 
     for (i = 0; i < thread_count; i++) {
-- 
2.35.3


