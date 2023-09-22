Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ED07AB428
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 16:54:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjhXK-0005DS-Mx; Fri, 22 Sep 2023 10:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjhXD-00052B-2b
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:53:36 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjhXA-00012f-1d
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:53:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E4AD1FF12;
 Fri, 22 Sep 2023 14:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695394409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FAEWKulcsDPmjEVXA94aLX9eUiosZLqzoPLzDJitoXg=;
 b=JiPqsXl4Wa8/nBIWhrHIaxPzLDkpPTd8su3bLOmduYdYcuGzhF17oLvisu/cohw0/GrgfG
 PnujeZJHZ3uzVjP4072dgjSamINcbtskf1JsYnT2krQB326KiGacB0VoCcSjK80pCBy194
 Y1SMQvXezm0tBhFjlDnI0K8btddVZfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695394409;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FAEWKulcsDPmjEVXA94aLX9eUiosZLqzoPLzDJitoXg=;
 b=KEGYR5b164s5oy1IXmq5ApwLHsJiLuKTZp8HhlYJm0Z4xggbnv+eSUhTAHPCDuDn4W3md8
 SL/f/1E387MjrUBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91E8613478;
 Fri, 22 Sep 2023 14:53:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +KscF2eqDWUpDAAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 22 Sep 2023 14:53:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [RFC PATCH 3/3] migration/multifd: Extract sem_done waiting into a
 function
Date: Fri, 22 Sep 2023 11:53:19 -0300
Message-Id: <20230922145319.27380-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230922145319.27380-1-farosas@suse.de>
References: <20230922145319.27380-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

This helps document the intent of the loop via the function name and
we can reuse this in the future.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 38 +++++---------------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 3d4a631915..159225530d 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -585,24 +585,14 @@ static int multifd_zero_copy_flush(QIOChannel *c)
     return ret;
 }
 
-int multifd_send_sync_main(QEMUFile *f)
+static int multifd_send_wait(void)
 {
-    int i;
     bool flush_zero_copy;
-
-    if (!migrate_multifd()) {
-        return 0;
-
-    if (multifd_send_state->pages->num) {
-        if (multifd_send_pages(f) < 0) {
-            error_report("%s: multifd_send_pages fail", __func__);
-            return -1;
-        }
-    }
+    int i;
 
     /* wait for all channels to be idle */
     for (i = 0; i < migrate_multifd_channels(); i++) {
-        trace_multifd_send_sync_main_wait(p->id);
+        trace_multifd_send_wait(migrate_multifd_channels() - i);
         qemu_sem_wait(&multifd_send_state->channels_ready);
     }
 
@@ -677,28 +667,10 @@ int multifd_send_sync_main(QEMUFile *f)
         qemu_sem_post(&p->sem);
     }
 
-    for (i = 0; i < migrate_multifd_channels(); i++) {
-        trace_multifd_send_wait(migrate_multifd_channels() - i);
-        qemu_sem_wait(&multifd_send_state->channels_ready);
-    }
-
-    for (i = 0; i < migrate_multifd_channels(); i++) {
-        MultiFDSendParams *p = &multifd_send_state->params[i];
-
-        qemu_mutex_lock(&p->mutex);
-        assert(!p->pending_job);
-        qemu_mutex_unlock(&p->mutex);
-
-        qemu_sem_post(&p->sem);
-        qemu_sem_wait(&p->sem_done);
-
-        if (flush_zero_copy && p->c && (multifd_zero_copy_flush(p->c) < 0)) {
-            return -1;
-        }
-    }
+    ret = multifd_send_wait();
     trace_multifd_send_sync_main(multifd_send_state->packet_num);
 
-    return 0;
+    return ret;
 }
 
 static void *multifd_send_thread(void *opaque)
-- 
2.35.3


