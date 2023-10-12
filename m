Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F387C7006
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:08:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwLl-0000Mh-I1; Thu, 12 Oct 2023 10:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqwLE-0008NE-K6
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:07:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqwLA-0008Ej-Jx
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:07:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BD5B121878;
 Thu, 12 Oct 2023 14:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697119622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oz4n+qj236YL1a8qzoYEdHstGZkz+mRU8otmuN/uam0=;
 b=OQ0p2LnazH7o6j9d2wDB+av+p03ARYymqi8eMvJjhLaF10D8wwwVGGdEOV7NX2oWv4dyWz
 rmT6sbv/+SN6MXzBbLkI7VjQPVusdAFLqSONsnJ9Fo21FEJyEV4DQHjJj6AOMPPFlkTozh
 5Hmgd4ffjnRoUDz8b+gCrCn1lHTi78k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697119622;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oz4n+qj236YL1a8qzoYEdHstGZkz+mRU8otmuN/uam0=;
 b=ZxHgu9oxtfTNq11MXbcrf8nhPuYaKUzeBW0whSxBON4x5uDBg8zG9Q2jQDMUf5waDK4vwI
 5YTCPEjiEhE2EIAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 453A4139ED;
 Thu, 12 Oct 2023 14:07:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wFdmBIX9J2U5CgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 12 Oct 2023 14:07:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [RFC PATCH v2 4/6] migration/multifd: Extract sem_done waiting into a
 function
Date: Thu, 12 Oct 2023 11:06:49 -0300
Message-Id: <20231012140651.13122-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231012140651.13122-1-farosas@suse.de>
References: <20231012140651.13122-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 0.22
X-Spamd-Result: default: False [0.22 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.68)[83.12%]
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

This helps document the intent of the loop via the function name and
we can reuse this in the future.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 47 +++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 94f4ae5ff8..4ffa67339c 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -576,6 +576,35 @@ static int multifd_zero_copy_flush(QIOChannel *c)
     return ret;
 }
 
+static void multifd_send_wait(void)
+{
+    int i;
+
+    /* wait for all channels to be idle */
+    for (i = 0; i < migrate_multifd_channels(); i++) {
+        MultiFDSendParams *p = &multifd_send_state->params[i];
+
+        /*
+         * Even idle channels will wait for p->sem at the top of the
+         * loop.
+         */
+        qemu_sem_post(&p->sem);
+
+        trace_multifd_send_wait(migrate_multifd_channels() - i);
+        qemu_sem_wait(&p->sem_done);
+
+        qemu_mutex_lock(&p->mutex);
+        assert(!p->pending_job || p->quit);
+        qemu_mutex_unlock(&p->mutex);
+    }
+
+    /*
+     * All channels went idle and have no more jobs. Unless we send
+     * them more work, we're good to allow any cleanup code to run at
+     * this point.
+     */
+}
+
 int multifd_send_sync_main(QEMUFile *f)
 {
     int i;
@@ -611,23 +640,7 @@ int multifd_send_sync_main(QEMUFile *f)
         qemu_sem_post(&p->sem);
     }
 
-    /* wait for all channels to be idle */
-    for (i = 0; i < migrate_multifd_channels(); i++) {
-        MultiFDSendParams *p = &multifd_send_state->params[i];
-
-        /*
-         * Even idle channels will wait for p->sem at the top of the
-         * loop.
-         */
-        qemu_sem_post(&p->sem);
-
-        trace_multifd_send_wait(migrate_multifd_channels() - i);
-        qemu_sem_wait(&p->sem_done);
-
-        qemu_mutex_lock(&p->mutex);
-        assert(!p->pending_job || p->quit);
-        qemu_mutex_unlock(&p->mutex);
-    }
+    multifd_send_wait();
 
     /*
      * When using zero-copy, it's necessary to flush the pages before any of
-- 
2.35.3


