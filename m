Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 450127E8353
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 21:04:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1XiS-00021c-08; Fri, 10 Nov 2023 15:02:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r1XiP-0001zI-GV
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 15:02:53 -0500
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r1XiN-0004db-U4
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 15:02:53 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E3E4D219B2;
 Fri, 10 Nov 2023 20:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699646568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1XDw7h+MPjEb3Fw95R1zEtbmr3eWUmHUulSWsjufGZg=;
 b=MnZV9KopVQQ8ipOudvugtx6AXDetVFvHUliIaAczRz9fMuXcSy6xFLWsVEqDXm2j0lxKfn
 7eL+SgeelUSbxiliguUovU0IePsfL6BahSi3oHTxJQzliohJeiWMQaBLh74zowVvEgdU4e
 WivfZDdYEyfsj4FxTUe9cYXP8aBobGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699646568;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1XDw7h+MPjEb3Fw95R1zEtbmr3eWUmHUulSWsjufGZg=;
 b=cjarW7DpZ5pbL1kPd1h/uNQvcxpvuZJynoNkdW35SQ1nk/hsDCKVQXhbbmujbfGYndsAVm
 qgfYgfvfN95kSFDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D801138FC;
 Fri, 10 Nov 2023 20:02:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wKlGDmeMTmWiaQAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 10 Nov 2023 20:02:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 2/4] migration/multifd: Join the TLS thread
Date: Fri, 10 Nov 2023 17:02:39 -0300
Message-Id: <20231110200241.20679-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231110200241.20679-1-farosas@suse.de>
References: <20231110200241.20679-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We're currently leaking the resources of the TLS thread by not joining
it and also overwriting the p->thread pointer altogether.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 10 +++++++++-
 migration/multifd.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 409460684f..d632dbc095 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -525,6 +525,10 @@ void multifd_save_cleanup(void)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
+        if (p->tls_thread) {
+            qemu_thread_join(p->tls_thread);
+        }
+
         if (p->running) {
             qemu_thread_join(&p->thread);
         }
@@ -552,6 +556,8 @@ void multifd_save_cleanup(void)
         p->iov = NULL;
         g_free(p->normal);
         p->normal = NULL;
+        g_free(p->tls_thread);
+        p->tls_thread = NULL;
         multifd_send_state->ops->send_cleanup(p, &local_err);
         if (local_err) {
             migrate_set_error(migrate_get_current(), local_err);
@@ -826,7 +832,9 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
     trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
     qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
     p->c = QIO_CHANNEL(tioc);
-    qemu_thread_create(&p->thread, "multifd-tls-handshake-worker",
+
+    p->tls_thread = g_new0(QemuThread, 1);
+    qemu_thread_create(p->tls_thread, "multifd-tls-handshake-worker",
                        multifd_tls_handshake_thread, p,
                        QEMU_THREAD_JOINABLE);
     return true;
diff --git a/migration/multifd.h b/migration/multifd.h
index a835643b48..4ff78e9863 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -75,6 +75,7 @@ typedef struct {
     char *name;
     /* channel thread id */
     QemuThread thread;
+    QemuThread *tls_thread;
     /* communication channel */
     QIOChannel *c;
     /* is the yank function registered */
-- 
2.35.3


