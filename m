Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0A09F54ED
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Dec 2024 18:50:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbh9-0005pY-4t; Tue, 17 Dec 2024 12:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNbgw-0005mR-Az
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:49:07 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNbgu-0007bm-DJ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:49:06 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 319CD1F395;
 Tue, 17 Dec 2024 17:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734457743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eH+tSkTA1Njs87LBw4qz5ZAbpCXXNhTECYXkhVMymUU=;
 b=B9vHQ3a7RHxvYUAoOKGuuKQ6W5qBo71OUwTqV0u7BG8rTkKdFeYBHb9WbF/Jh2c2eszdPU
 Z8gYnlyTkGdDYZi/4D0s+iT/jVQfqIavWWXfOQr8ueYIXKKo4fT3G1m7m+I7UeTWongzlH
 5uG/DhSkbgE1riisP7sNgUGF4ub067c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734457743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eH+tSkTA1Njs87LBw4qz5ZAbpCXXNhTECYXkhVMymUU=;
 b=SJdKXIQFm79zASgp5jBBQubhwvA13f5x9UOhv00E3WEMps7UvFSkByqQeR35f06tmiOgN5
 IoxD4mXFNZ6wGHAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=B9vHQ3a7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SJdKXIQF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734457743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eH+tSkTA1Njs87LBw4qz5ZAbpCXXNhTECYXkhVMymUU=;
 b=B9vHQ3a7RHxvYUAoOKGuuKQ6W5qBo71OUwTqV0u7BG8rTkKdFeYBHb9WbF/Jh2c2eszdPU
 Z8gYnlyTkGdDYZi/4D0s+iT/jVQfqIavWWXfOQr8ueYIXKKo4fT3G1m7m+I7UeTWongzlH
 5uG/DhSkbgE1riisP7sNgUGF4ub067c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734457743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eH+tSkTA1Njs87LBw4qz5ZAbpCXXNhTECYXkhVMymUU=;
 b=SJdKXIQFm79zASgp5jBBQubhwvA13f5x9UOhv00E3WEMps7UvFSkByqQeR35f06tmiOgN5
 IoxD4mXFNZ6wGHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CB2313A3C;
 Tue, 17 Dec 2024 17:49:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ABTNAI65YWd1TwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Dec 2024 17:49:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 03/17] migration/multifd: Allow to sync with sender threads only
Date: Tue, 17 Dec 2024 14:48:41 -0300
Message-Id: <20241217174855.24971-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241217174855.24971-1-farosas@suse.de>
References: <20241217174855.24971-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 319CD1F395
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Peter Xu <peterx@redhat.com>

Teach multifd_send_sync_main() to sync with threads only.

We already have such requests, which is when mapped-ram is enabled with
multifd.  In that case, no SYNC messages will be pushed to the stream when
multifd syncs the sender threads because there's no destination threads
waiting for that.  The whole point of the sync is to make sure all threads
finished their jobs.

So fundamentally we have a request to do the sync in different ways:

  - Either to sync the threads only,
  - Or to sync the threads but also with the destination side.

Mapped-ram did it already because of the use_packet check in the sync
handler of the sender thread.  It works.

However it may stop working when e.g. VFIO may start to reuse multifd
channels to push device states.  In that case VFIO has similar request on
"thread-only sync" however we can't check a flag because such sync request
can still come from RAM which needs the on-wire notifications.

Paving way for that by allowing the multifd_send_sync_main() to specify
what kind of sync the caller needs.  We can use it for mapped-ram already.

No functional change intended.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20241206224755.1108686-3-peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-nocomp.c |  7 ++++++-
 migration/multifd.c        | 17 +++++++++++------
 migration/multifd.h        | 23 ++++++++++++++++++++---
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 55191152f9..219f9e58ef 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -345,6 +345,8 @@ retry:
 
 int multifd_ram_flush_and_sync(void)
 {
+    MultiFDSyncReq req;
+
     if (!migrate_multifd()) {
         return 0;
     }
@@ -356,7 +358,10 @@ int multifd_ram_flush_and_sync(void)
         }
     }
 
-    return multifd_send_sync_main();
+    /* File migrations only need to sync with threads */
+    req = migrate_mapped_ram() ? MULTIFD_SYNC_LOCAL : MULTIFD_SYNC_ALL;
+
+    return multifd_send_sync_main(req);
 }
 
 bool multifd_send_prepare_common(MultiFDSendParams *p)
diff --git a/migration/multifd.c b/migration/multifd.c
index 498e71fd10..7ecc3964ee 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -523,11 +523,13 @@ static int multifd_zero_copy_flush(QIOChannel *c)
     return ret;
 }
 
-int multifd_send_sync_main(void)
+int multifd_send_sync_main(MultiFDSyncReq req)
 {
     int i;
     bool flush_zero_copy;
 
+    assert(req != MULTIFD_SYNC_NONE);
+
     flush_zero_copy = migrate_zero_copy_send();
 
     for (i = 0; i < migrate_multifd_channels(); i++) {
@@ -543,8 +545,8 @@ int multifd_send_sync_main(void)
          * We should be the only user so far, so not possible to be set by
          * others concurrently.
          */
-        assert(qatomic_read(&p->pending_sync) == false);
-        qatomic_set(&p->pending_sync, true);
+        assert(qatomic_read(&p->pending_sync) == MULTIFD_SYNC_NONE);
+        qatomic_set(&p->pending_sync, req);
         qemu_sem_post(&p->sem);
     }
     for (i = 0; i < migrate_multifd_channels(); i++) {
@@ -635,14 +637,17 @@ static void *multifd_send_thread(void *opaque)
              */
             qatomic_store_release(&p->pending_job, false);
         } else {
+            MultiFDSyncReq req = qatomic_read(&p->pending_sync);
+
             /*
              * If not a normal job, must be a sync request.  Note that
              * pending_sync is a standalone flag (unlike pending_job), so
              * it doesn't require explicit memory barriers.
              */
-            assert(qatomic_read(&p->pending_sync));
+            assert(req != MULTIFD_SYNC_NONE);
 
-            if (use_packets) {
+            /* Only push the SYNC message if it involves a remote sync */
+            if (req == MULTIFD_SYNC_ALL) {
                 p->flags = MULTIFD_FLAG_SYNC;
                 multifd_send_fill_packet(p);
                 ret = qio_channel_write_all(p->c, (void *)p->packet,
@@ -654,7 +659,7 @@ static void *multifd_send_thread(void *opaque)
                 stat64_add(&mig_stats.multifd_bytes, p->packet_len);
             }
 
-            qatomic_set(&p->pending_sync, false);
+            qatomic_set(&p->pending_sync, MULTIFD_SYNC_NONE);
             qemu_sem_post(&p->sem_sync);
         }
     }
diff --git a/migration/multifd.h b/migration/multifd.h
index 50d58c0c9c..6493512305 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -19,6 +19,22 @@
 typedef struct MultiFDRecvData MultiFDRecvData;
 typedef struct MultiFDSendData MultiFDSendData;
 
+typedef enum {
+    /* No sync request */
+    MULTIFD_SYNC_NONE = 0,
+    /* Sync locally on the sender threads without pushing messages */
+    MULTIFD_SYNC_LOCAL,
+    /*
+     * Sync not only on the sender threads, but also push MULTIFD_FLAG_SYNC
+     * message to the wire for each iochannel (which is for a remote sync).
+     *
+     * When remote sync is used, need to be paired with a follow up
+     * RAM_SAVE_FLAG_EOS / RAM_SAVE_FLAG_MULTIFD_FLUSH message on the main
+     * channel.
+     */
+    MULTIFD_SYNC_ALL,
+} MultiFDSyncReq;
+
 bool multifd_send_setup(void);
 void multifd_send_shutdown(void);
 void multifd_send_channel_created(void);
@@ -28,7 +44,7 @@ void multifd_recv_shutdown(void);
 bool multifd_recv_all_channels_created(void);
 void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
 void multifd_recv_sync_main(void);
-int multifd_send_sync_main(void);
+int multifd_send_sync_main(MultiFDSyncReq req);
 bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
 bool multifd_recv(void);
 MultiFDRecvData *multifd_get_recv_data(void);
@@ -143,7 +159,7 @@ typedef struct {
     /* multifd flags for each packet */
     uint32_t flags;
     /*
-     * The sender thread has work to do if either of below boolean is set.
+     * The sender thread has work to do if either of below field is set.
      *
      * @pending_job:  a job is pending
      * @pending_sync: a sync request is pending
@@ -152,7 +168,8 @@ typedef struct {
      * cleared by the multifd sender threads.
      */
     bool pending_job;
-    bool pending_sync;
+    MultiFDSyncReq pending_sync;
+
     MultiFDSendData *data;
 
     /* thread local variables. No locking required */
-- 
2.35.3


