Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AE27AB42B
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 16:54:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjhXH-00056y-PZ; Fri, 22 Sep 2023 10:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjhXB-000515-8l
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:53:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjhX4-00011x-Nf
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:53:30 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2DC3C21C26;
 Fri, 22 Sep 2023 14:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695394405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WANW53u5/qrAJoF+HXqNYldAbn1LpGeokYUSz327Qlk=;
 b=OFOQficTxTc+ug5TFXhEryW5QFrDza62+HB54hdSM2qlPxCGTiAU5ukrQ5IAtl/qw4/XxD
 8lZrStZbFt1OrYL4ue1VUPphKVT7tt+bzKLXCSWgG1iUhVa9xLiy8Vs2EEUrdHnWbz3dja
 2QMY6GG/5u8zy0UbXWCnc5kbFO+IDyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695394405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WANW53u5/qrAJoF+HXqNYldAbn1LpGeokYUSz327Qlk=;
 b=aFX0ohS3id4DNEeN3uLOOEWYtbAJoDz1qrOZ9Nk6HRWlJVF3A81HkJD/L31hualmmgPG7T
 sF7naZB0t+AAqYDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A467A13478;
 Fri, 22 Sep 2023 14:53:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EFX9GmOqDWUpDAAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 22 Sep 2023 14:53:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [RFC PATCH 1/3] migration/multifd: Move channels_ready semaphore
Date: Fri, 22 Sep 2023 11:53:17 -0300
Message-Id: <20230922145319.27380-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230922145319.27380-1-farosas@suse.de>
References: <20230922145319.27380-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

Commit d2026ee117 ("multifd: Fix the number of channels ready") moved
the "post" of channels_ready to the start of the multifd_send_thread()
loop and added a missing "wait" at multifd_send_sync_main(). While it
does work, the placement of the wait goes against what the rest of the
code does.

The sequence at multifd_send_thread() is:

    qemu_sem_post(&multifd_send_state->channels_ready);
    qemu_sem_wait(&p->sem);
    <work>
    if (flags & MULTIFD_FLAG_SYNC) {
        qemu_sem_post(&p->sem_sync);
    }

Which means that the sending thread makes itself available
(channels_ready) and waits for more work (sem). So the sequence in the
migration thread should be to check if any channel is available
(channels_ready), give it some work and set it off (sem):

    qemu_sem_wait(&multifd_send_state->channels_ready);
    <enqueue work>
    qemu_sem_post(&p->sem);
    if (flags & MULTIFD_FLAG_SYNC) {
        qemu_sem_wait(&p->sem_sync);
    }

The reason there's no deadlock today is that the migration thread
enqueues the SYNC packet right before the wait on channels_ready and
we end up taking advantage of the out-of-order post to sem:

        ...
        qemu_sem_post(&p->sem);
    }
    for (i = 0; i < migrate_multifd_channels(); i++) {
        MultiFDSendParams *p = &multifd_send_state->params[i];

        qemu_sem_wait(&multifd_send_state->channels_ready);
        trace_multifd_send_sync_main_wait(p->id);
        qemu_sem_wait(&p->sem_sync);
	...

Move the channels_ready wait before the sem post to keep the sequence
consistent. Also fix the error path to post to channels_ready and
sem_sync in the correct order.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index a7c7a947e3..d626740f2f 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -618,6 +618,7 @@ int multifd_send_sync_main(QEMUFile *f)
 
         trace_multifd_send_sync_main_signal(p->id);
 
+        qemu_sem_wait(&multifd_send_state->channels_ready);
         qemu_mutex_lock(&p->mutex);
 
         if (p->quit) {
@@ -635,7 +636,6 @@ int multifd_send_sync_main(QEMUFile *f)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
-        qemu_sem_wait(&multifd_send_state->channels_ready);
         trace_multifd_send_sync_main_wait(p->id);
         qemu_sem_wait(&p->sem_sync);
 
@@ -763,8 +763,8 @@ out:
      * who pay attention to me.
      */
     if (ret != 0) {
-        qemu_sem_post(&p->sem_sync);
         qemu_sem_post(&multifd_send_state->channels_ready);
+        qemu_sem_post(&p->sem_sync);
     }
 
     qemu_mutex_lock(&p->mutex);
-- 
2.35.3


