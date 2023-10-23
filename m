Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F7C7D4111
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 22:40:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv1gL-0004Lq-0g; Mon, 23 Oct 2023 16:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1fu-0003nq-TB
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:37:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1fr-0001u4-AX
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:37:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2ACEE21B28;
 Mon, 23 Oct 2023 20:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698093438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B8nEthtwB2qEKS5Hv45AtaqNIBTuRIA7SDrRGv3fpRE=;
 b=d7geVfelSn1pQUZ6lzI6MQAQS/HXhbdK7mo3tRk0vq/LEXOn1bwMkBUrWslSoDsAacxveY
 +BqZkKttKjZwTFDecxYBNrn2HlMNSoChn96np6UwLbFR1ZbSRziEZI2E8jv8zBdYLvxGgp
 4TZZpH8HIdsZmMAXnP7DQOnFec39/pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698093438;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B8nEthtwB2qEKS5Hv45AtaqNIBTuRIA7SDrRGv3fpRE=;
 b=VqmQUIMcBxYxaTnK+zQQczkmNuhpi7jDy0goqZ3PwJeM2+JnPsfNDzggCJ9/nZE9iZXeWG
 mJYNznKROzwh09CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 355A4132FD;
 Mon, 23 Oct 2023 20:37:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yI8vAHzZNmV1JQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 20:37:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v2 25/29] migration/multifd: Support outgoing fixed-ram stream
 format
Date: Mon, 23 Oct 2023 17:36:04 -0300
Message-Id: <20231023203608.26370-26-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023203608.26370-1-farosas@suse.de>
References: <20231023203608.26370-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
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

The new fixed-ram stream format uses a file transport and puts ram
pages in the migration file at their respective offsets and can be
done in parallel by using the pwritev system call which takes iovecs
and an offset.

Add support to enabling the new format along with multifd to make use
of the threading and page handling already in place.

This requires multifd to stop sending headers and leaving the stream
format to the fixed-ram code. When it comes time to write the data, we
need to call a version of qio_channel_write that can take an offset.

Usage on HMP is:

(qemu) stop
(qemu) migrate_set_capability multifd on
(qemu) migrate_set_capability fixed-ram on
(qemu) migrate_set_parameter max-bandwidth 0
(qemu) migrate_set_parameter multifd-channels 8
(qemu) migrate file:migfile

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/qemu/bitops.h | 13 ++++++++++
 migration/multifd.c   | 55 +++++++++++++++++++++++++++++++++++++++++--
 migration/options.c   |  6 -----
 migration/ram.c       |  2 +-
 4 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index cb3526d1f4..2c0a2fe751 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -67,6 +67,19 @@ static inline void clear_bit(long nr, unsigned long *addr)
     *p &= ~mask;
 }
 
+/**
+ * clear_bit_atomic - Clears a bit in memory atomically
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ */
+static inline void clear_bit_atomic(long nr, unsigned long *addr)
+{
+    unsigned long mask = BIT_MASK(nr);
+    unsigned long *p = addr + BIT_WORD(nr);
+
+    return qatomic_and(p, ~mask);
+}
+
 /**
  * change_bit - Toggle a bit in memory
  * @nr: Bit to change
diff --git a/migration/multifd.c b/migration/multifd.c
index 20e8635740..3f95a41ee9 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -260,6 +260,19 @@ static void multifd_pages_clear(MultiFDPages_t *pages)
     g_free(pages);
 }
 
+static void multifd_set_file_bitmap(MultiFDSendParams *p)
+{
+    MultiFDPages_t *pages = p->pages;
+
+    if (!pages->block) {
+        return;
+    }
+
+    for (int i = 0; i < p->normal_num; i++) {
+        ramblock_set_shadow_bmap_atomic(pages->block, pages->offset[i]);
+    }
+}
+
 static void multifd_send_fill_packet(MultiFDSendParams *p)
 {
     MultiFDPacket_t *packet = p->packet;
@@ -606,6 +619,29 @@ int multifd_send_sync_main(QEMUFile *f)
         }
     }
 
+    if (!migrate_multifd_packets()) {
+        /*
+         * There's no sync packet to send. Just make sure the sending
+         * above has finished.
+         */
+        for (i = 0; i < migrate_multifd_channels(); i++) {
+            qemu_sem_wait(&multifd_send_state->channels_ready);
+        }
+
+        /* sanity check and release the channels */
+        for (i = 0; i < migrate_multifd_channels(); i++) {
+            MultiFDSendParams *p = &multifd_send_state->params[i];
+
+            qemu_mutex_lock(&p->mutex);
+            assert(!p->pending_job || p->quit);
+            qemu_mutex_unlock(&p->mutex);
+
+            qemu_sem_post(&p->sem);
+        }
+
+        return 0;
+    }
+
     /*
      * When using zero-copy, it's necessary to flush the pages before any of
      * the pages can be sent again, so we'll make sure the new version of the
@@ -689,6 +725,8 @@ static void *multifd_send_thread(void *opaque)
 
         if (p->pending_job) {
             uint32_t flags;
+            uint64_t write_base;
+
             p->normal_num = 0;
 
             if (!use_packets || use_zero_copy_send) {
@@ -713,6 +751,16 @@ static void *multifd_send_thread(void *opaque)
             if (use_packets) {
                 multifd_send_fill_packet(p);
                 p->num_packets++;
+                write_base = 0;
+            } else {
+                multifd_set_file_bitmap(p);
+
+                /*
+                 * If we subtract the host page now, we don't need to
+                 * pass it into qio_channel_write_full_all() below.
+                 */
+                write_base = p->pages->block->pages_offset -
+                    (uint64_t)p->pages->block->host;
             }
 
             flags = p->flags;
@@ -738,8 +786,9 @@ static void *multifd_send_thread(void *opaque)
                 p->iov[0].iov_base = p->packet;
             }
 
-            ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
-                                              0, p->write_flags, &local_err);
+            ret = qio_channel_write_full_all(p->c, p->iov, p->iovs_num,
+                                             write_base, NULL, 0,
+                                             p->write_flags, &local_err);
             if (ret != 0) {
                 break;
             }
@@ -969,6 +1018,8 @@ int multifd_save_setup(Error **errp)
 
         if (migrate_zero_copy_send()) {
             p->write_flags = QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
+        } else if (!use_packets) {
+            p->write_flags |= QIO_CHANNEL_WRITE_FLAG_WITH_OFFSET;
         } else {
             p->write_flags = 0;
         }
diff --git a/migration/options.c b/migration/options.c
index 469d5d4c50..2193d69e71 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -648,12 +648,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     }
 
     if (new_caps[MIGRATION_CAPABILITY_FIXED_RAM]) {
-        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
-            error_setg(errp,
-                       "Fixed-ram migration is incompatible with multifd");
-            return false;
-        }
-
         if (new_caps[MIGRATION_CAPABILITY_XBZRLE]) {
             error_setg(errp,
                        "Fixed-ram migration is incompatible with xbzrle");
diff --git a/migration/ram.c b/migration/ram.c
index 3497ed186a..5c67e30e55 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1161,7 +1161,7 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
 
     if (migrate_fixed_ram()) {
         /* zero pages are not transferred with fixed-ram */
-        clear_bit(offset >> TARGET_PAGE_BITS, pss->block->shadow_bmap);
+        clear_bit_atomic(offset >> TARGET_PAGE_BITS, pss->block->shadow_bmap);
         return 1;
     }
 
-- 
2.35.3


