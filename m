Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B6F7C700B
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:08:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwM0-0000WU-2b; Thu, 12 Oct 2023 10:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqwLE-0008NL-Ux
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:07:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqwLB-0008F4-RR
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:07:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A8D331F898;
 Thu, 12 Oct 2023 14:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697119624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJwOf25AFLkGxrZXTydCy3mSdIODrn/xWE+T4mZJn4A=;
 b=a7+T/PhM/Xf2uuLiW0hiZd1lTouZD8ut6rpWQzb/iuCIZHX/srid0i6VIUqM8FN9d8UTCd
 08sRyIeGC1wIQBX5BI4u+P1M4Li1EWQeIj8LAerrnfa15ngLUIu4myd/dibgB4TJikRHG5
 W7jjF2B1OOaNFYWKe7KgyAJGIRiHL7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697119624;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJwOf25AFLkGxrZXTydCy3mSdIODrn/xWE+T4mZJn4A=;
 b=oxm+FYsF+mC+rv2FoA5M8MBRvxMWDwKVH5nwMB0riGB5Qmu6P8GZ2BLHJ8Dh63oeTlSdHd
 vZ/8lI2kxq2wWbAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 319CD139ED;
 Thu, 12 Oct 2023 14:07:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sEA9O4b9J2U5CgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 12 Oct 2023 14:07:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [RFC PATCH v2 5/6] migration/multifd: Stop setting 'quit' outside of
 channels
Date: Thu, 12 Oct 2023 11:06:50 -0300
Message-Id: <20231012140651.13122-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231012140651.13122-1-farosas@suse.de>
References: <20231012140651.13122-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
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
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[30.55%]
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

We shouldn't really be touching channel state from outside the
channels except for the transfer of pages.

Move the setting of p->quit into the channel. Keep posting the 'sem'
from multifd_send_terminate_threads() so any channel waiting on the
semaphore will unblock and see the 'exiting' flag and quit by itself.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 4ffa67339c..b7ba3fe0e6 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -497,13 +497,11 @@ static void multifd_send_terminate_threads(Error *err)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
-        qemu_mutex_lock(&p->mutex);
-        p->quit = true;
+        /* kick the channel if it was waiting for work */
         qemu_sem_post(&p->sem);
         if (p->c) {
             qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
         }
-        qemu_mutex_unlock(&p->mutex);
     }
 }
 
@@ -690,6 +688,9 @@ static void *multifd_send_thread(void *opaque)
         qemu_sem_wait(&p->sem);
 
         if (qatomic_read(&multifd_send_state->exiting)) {
+            qemu_mutex_lock(&p->mutex);
+            p->quit = true;
+            qemu_mutex_unlock(&p->mutex);
             break;
         }
         qemu_mutex_lock(&p->mutex);
@@ -765,6 +766,11 @@ static void *multifd_send_thread(void *opaque)
 out:
     if (local_err) {
         trace_multifd_send_error(p->id);
+
+        qemu_mutex_lock(&p->mutex);
+        p->quit = true;
+        qemu_mutex_unlock(&p->mutex);
+
         multifd_send_terminate_threads(local_err);
         error_free(local_err);
     }
-- 
2.35.3


