Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F78C7C7008
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:08:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwLi-0008Sc-2v; Thu, 12 Oct 2023 10:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqwLA-0008LN-VX
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:07:06 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqwL5-0008ED-8F
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:07:02 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0BE6C21870;
 Thu, 12 Oct 2023 14:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697119617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q4IScuvXsh8y/0/HKeuwuCl6yb+TmB3/Lm9GVpyLb4k=;
 b=oDV/3yxqOplJmtC0CXR7zx3d2i7Mp/AgSB1+GSYWWhEdL/Ih7zqx0U9bgEEwvnbgO3X1EW
 J2AyMV6uQpgYoeWwJgiB2SeSpY/Z417NeASDFDcDw87BG7wMelAfxkGG5PAiiXuOWP8j8V
 oYVXTH8aEl+NJ3t4x97xUiAI2cLmec0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697119617;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q4IScuvXsh8y/0/HKeuwuCl6yb+TmB3/Lm9GVpyLb4k=;
 b=uIb+a9pmfqdeKkHtByeY0hDt/Hd92f3p4Rhzmle27Xszd3W18HsInVXEXV2z1SvxusLBAF
 DVpfjx1TS3B+CTBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75155139ED;
 Thu, 12 Oct 2023 14:06:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oGDRD3/9J2U5CgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 12 Oct 2023 14:06:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [RFC PATCH v2 1/6] migration/multifd: Remove channels_ready semaphore
Date: Thu, 12 Oct 2023 11:06:46 -0300
Message-Id: <20231012140651.13122-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231012140651.13122-1-farosas@suse.de>
References: <20231012140651.13122-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

The channels_ready semaphore is a global variable not linked to any
single multifd channel. Waiting on it only means that "some" channel
has become ready to send data. Since we need to address the channels
by index (multifd_send_state->params[i]), that information adds
nothing of value. The channel being addressed is not necessarily the
one that just released the semaphore.

The only usage of this semaphore that makes sense is to wait for it in
a loop that iterates for the number of channels. That could mean: all
channels have been setup and are operational OR all channels have
finished their work and are idle.

Currently all code that waits on channels_ready is redundant. There is
always a subsequent lock or semaphore that does the actual data
protection/synchronization.

- at multifd_send_pages: Waiting on channels_ready doesn't mean the
  'next_channel' is ready, it could be any other channel. So there are
  already cases where this code runs as if no semaphore was there.

  Waiting outside of the loop is also incorrect because if the current
  channel already has a pending_job, then it will loop into the next
  one without waiting the semaphore and the count will be greater than
  zero at the end of the execution.

  Checking that "any" channel is ready as a proxy for all channels
  being ready would work, but it's not what the code is doing and not
  really needed because the channel lock and 'sem' would be enough.

- at multifd_send_sync: This usage is correct, but it is made
  redundant by the wait on sem_sync. What this piece of code is doing
  is making sure all channels have sent the SYNC packet and became
  idle afterwards.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 0f6b203877..e26f5f246d 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -362,8 +362,6 @@ struct {
     MultiFDPages_t *pages;
     /* global number of generated multifd packets */
     uint64_t packet_num;
-    /* send channels ready */
-    QemuSemaphore channels_ready;
     /*
      * Have we already run terminate threads.  There is a race when it
      * happens that we got one error while we are exiting.
@@ -403,7 +401,6 @@ static int multifd_send_pages(QEMUFile *f)
         return -1;
     }
 
-    qemu_sem_wait(&multifd_send_state->channels_ready);
     /*
      * next_channel can remain from a previous migration that was
      * using more channels, so ensure it doesn't overflow if the
@@ -554,7 +551,6 @@ void multifd_save_cleanup(void)
             error_free(local_err);
         }
     }
-    qemu_sem_destroy(&multifd_send_state->channels_ready);
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
     multifd_pages_clear(multifd_send_state->pages);
@@ -630,7 +626,6 @@ int multifd_send_sync_main(QEMUFile *f)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
-        qemu_sem_wait(&multifd_send_state->channels_ready);
         trace_multifd_send_sync_main_wait(p->id);
         qemu_sem_wait(&p->sem_sync);
 
@@ -664,7 +659,6 @@ static void *multifd_send_thread(void *opaque)
     p->num_packets = 1;
 
     while (true) {
-        qemu_sem_post(&multifd_send_state->channels_ready);
         qemu_sem_wait(&p->sem);
 
         if (qatomic_read(&multifd_send_state->exiting)) {
@@ -759,7 +753,6 @@ out:
      */
     if (ret != 0) {
         qemu_sem_post(&p->sem_sync);
-        qemu_sem_post(&multifd_send_state->channels_ready);
     }
 
     qemu_mutex_lock(&p->mutex);
@@ -796,7 +789,6 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
          * is not created, and then tell who pay attention to me.
          */
         p->quit = true;
-        qemu_sem_post(&multifd_send_state->channels_ready);
         qemu_sem_post(&p->sem_sync);
     }
 }
@@ -874,7 +866,6 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
 {
      migrate_set_error(migrate_get_current(), err);
      /* Error happen, we need to tell who pay attention to me */
-     qemu_sem_post(&multifd_send_state->channels_ready);
      qemu_sem_post(&p->sem_sync);
      /*
       * Although multifd_send_thread is not created, but main migration
@@ -919,7 +910,6 @@ int multifd_save_setup(Error **errp)
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
     multifd_send_state->pages = multifd_pages_init(page_count);
-    qemu_sem_init(&multifd_send_state->channels_ready, 0);
     qatomic_set(&multifd_send_state->exiting, 0);
     multifd_send_state->ops = multifd_ops[migrate_multifd_compression()];
 
-- 
2.35.3


