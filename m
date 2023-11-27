Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4437FAB7D
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:28:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iCR-0003LN-9q; Mon, 27 Nov 2023 15:27:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iCF-0003GJ-6b
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:12 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iCB-0002pO-9Y
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:09 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D6D71FB71;
 Mon, 27 Nov 2023 20:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701116826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G3lFVSaC2SFCUF6RJ0NZjaZayMP0TzCLKh4i0gsaGlA=;
 b=R7qTSYoeh/lyv7uwhNraRG7SvxOzrbXB66pv9BCEKovlSyaGOv/t0+4OxOjRKYzcQ5wA2p
 G/w/2a7LaT2ugEaCmspQxIEX4bHJDZGRFyRdHVIVsdTxFcwC1uDuMY2dIcYUJ3BhPaKMbM
 eSmbooXWC+oLg7HvxNGwzalUhj1rLWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701116826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G3lFVSaC2SFCUF6RJ0NZjaZayMP0TzCLKh4i0gsaGlA=;
 b=6glQq5X2VmGB/OeWkWaUp7H0oDErRJjXS77QpVkE7cV8wipyL6nNQqm5DUObD9bz1+wH5L
 OfgvDLj+XQPoJuBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CCE91379A;
 Mon, 27 Nov 2023 20:27:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EJk+MZf7ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:27:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [RFC PATCH v3 18/30] migration/multifd: Allow receiving pages without
 packets
Date: Mon, 27 Nov 2023 17:26:00 -0300
Message-Id: <20231127202612.23012-19-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127202612.23012-1-farosas@suse.de>
References: <20231127202612.23012-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently multifd does not need to have knowledge of pages on the
receiving side because all the information needed is within the
packets that come in the stream.

We're about to add support to fixed-ram migration, which cannot use
packets because it expects the ramblock section in the migration file
to contain only the guest pages data.

Add a data structure to transfer pages between the ram migration code
and the multifd receiving threads.

We don't want to reuse MultiFDPages_t for two reasons:

a) multifd threads don't really need to know about the data they're
   receiving.

b) the receiving side has to be stopped to load the pages, which means
   we can experiment with larger granularities than page size when
   transferring data.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- stopped using MultiFDPages_t and added a new structure which can
  take offset + size
---
 migration/multifd.c | 122 ++++++++++++++++++++++++++++++++++++++++++--
 migration/multifd.h |  20 ++++++++
 2 files changed, 138 insertions(+), 4 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index c1381bdc21..7dfab2367a 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -142,17 +142,36 @@ static void nocomp_recv_cleanup(MultiFDRecvParams *p)
 static int nocomp_recv_data(MultiFDRecvParams *p, Error **errp)
 {
     uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
+    ERRP_GUARD();
 
     if (flags != MULTIFD_FLAG_NOCOMP) {
         error_setg(errp, "multifd %u: flags received %x flags expected %x",
                    p->id, flags, MULTIFD_FLAG_NOCOMP);
         return -1;
     }
-    for (int i = 0; i < p->normal_num; i++) {
-        p->iov[i].iov_base = p->host + p->normal[i];
-        p->iov[i].iov_len = p->page_size;
+
+    if (!migrate_multifd_packets()) {
+        MultiFDRecvData *data = p->data;
+        size_t ret;
+
+        ret = qio_channel_pread(p->c, (char *) data->opaque,
+                                data->size, data->file_offset, errp);
+        if (ret != data->size) {
+            error_prepend(errp,
+                          "multifd recv (%u): read 0x%zx, expected 0x%zx",
+                          p->id, ret, data->size);
+            return -1;
+        }
+
+        return 0;
+    } else {
+        for (int i = 0; i < p->normal_num; i++) {
+            p->iov[i].iov_base = p->host + p->normal[i];
+            p->iov[i].iov_len = p->page_size;
+        }
+
+        return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
     }
-    return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
 }
 
 static MultiFDMethods multifd_nocomp_ops = {
@@ -989,6 +1008,7 @@ int multifd_save_setup(Error **errp)
 
 struct {
     MultiFDRecvParams *params;
+    MultiFDRecvData *data;
     /* number of created threads */
     int count;
     /* syncs main thread and channels */
@@ -999,6 +1019,49 @@ struct {
     MultiFDMethods *ops;
 } *multifd_recv_state;
 
+int multifd_recv(void)
+{
+    int i;
+    static int next_recv_channel;
+    MultiFDRecvParams *p = NULL;
+    MultiFDRecvData *data = multifd_recv_state->data;
+
+    /*
+     * next_channel can remain from a previous migration that was
+     * using more channels, so ensure it doesn't overflow if the
+     * limit is lower now.
+     */
+    next_recv_channel %= migrate_multifd_channels();
+    for (i = next_recv_channel;; i = (i + 1) % migrate_multifd_channels()) {
+        p = &multifd_recv_state->params[i];
+
+        qemu_mutex_lock(&p->mutex);
+        if (p->quit) {
+            error_report("%s: channel %d has already quit!", __func__, i);
+            qemu_mutex_unlock(&p->mutex);
+            return -1;
+        }
+        if (!p->pending_job) {
+            p->pending_job++;
+            next_recv_channel = (i + 1) % migrate_multifd_channels();
+            break;
+        }
+        qemu_mutex_unlock(&p->mutex);
+    }
+    assert(p->data->size == 0);
+    multifd_recv_state->data = p->data;
+    p->data = data;
+    qemu_mutex_unlock(&p->mutex);
+    qemu_sem_post(&p->sem);
+
+    return 1;
+}
+
+MultiFDRecvData *multifd_get_recv_data(void)
+{
+    return multifd_recv_state->data;
+}
+
 static void multifd_recv_terminate_threads(Error *err)
 {
     int i;
@@ -1020,6 +1083,7 @@ static void multifd_recv_terminate_threads(Error *err)
 
         qemu_mutex_lock(&p->mutex);
         p->quit = true;
+        qemu_sem_post(&p->sem);
         /*
          * We could arrive here for two reasons:
          *  - normal quit, i.e. everything went fine, just finished
@@ -1069,6 +1133,7 @@ void multifd_load_cleanup(void)
         p->c = NULL;
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem_sync);
+        qemu_sem_destroy(&p->sem);
         g_free(p->name);
         p->name = NULL;
         p->packet_len = 0;
@@ -1083,6 +1148,8 @@ void multifd_load_cleanup(void)
     qemu_sem_destroy(&multifd_recv_state->sem_sync);
     g_free(multifd_recv_state->params);
     multifd_recv_state->params = NULL;
+    g_free(multifd_recv_state->data);
+    multifd_recv_state->data = NULL;
     g_free(multifd_recv_state);
     multifd_recv_state = NULL;
 }
@@ -1094,6 +1161,21 @@ void multifd_recv_sync_main(void)
     if (!migrate_multifd() || !migrate_multifd_packets()) {
         return;
     }
+
+    if (!migrate_multifd_packets()) {
+        for (i = 0; i < migrate_multifd_channels(); i++) {
+            MultiFDRecvParams *p = &multifd_recv_state->params[i];
+
+            qemu_sem_post(&p->sem);
+            qemu_sem_wait(&p->sem_sync);
+
+            qemu_mutex_lock(&p->mutex);
+            assert(!p->pending_job || p->quit);
+            qemu_mutex_unlock(&p->mutex);
+        }
+        return;
+    }
+
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
@@ -1156,6 +1238,18 @@ static void *multifd_recv_thread(void *opaque)
 
             p->total_normal_pages += p->normal_num;
             has_data = !!p->normal_num;
+        } else {
+            /*
+             * No packets, so we need to wait for the vmstate code to
+             * give us work.
+             */
+            qemu_sem_wait(&p->sem);
+            qemu_mutex_lock(&p->mutex);
+            if (!p->pending_job) {
+                qemu_mutex_unlock(&p->mutex);
+                break;
+            }
+            has_data = !!p->data->size;
         }
 
         qemu_mutex_unlock(&p->mutex);
@@ -1171,6 +1265,17 @@ static void *multifd_recv_thread(void *opaque)
             qemu_sem_post(&multifd_recv_state->sem_sync);
             qemu_sem_wait(&p->sem_sync);
         }
+
+        if (!use_packets) {
+            qemu_mutex_lock(&p->mutex);
+            p->data->size = 0;
+            p->pending_job--;
+            qemu_mutex_unlock(&p->mutex);
+        }
+    }
+
+    if (!use_packets) {
+        qemu_sem_post(&p->sem_sync);
     }
 
     if (local_err) {
@@ -1205,6 +1310,10 @@ int multifd_load_setup(Error **errp)
     thread_count = migrate_multifd_channels();
     multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
+
+    multifd_recv_state->data = g_new0(MultiFDRecvData, 1);
+    multifd_recv_state->data->size = 0;
+
     qatomic_set(&multifd_recv_state->count, 0);
     qemu_sem_init(&multifd_recv_state->sem_sync, 0);
     multifd_recv_state->ops = multifd_ops[migrate_multifd_compression()];
@@ -1214,9 +1323,14 @@ int multifd_load_setup(Error **errp)
 
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem_sync, 0);
+        qemu_sem_init(&p->sem, 0);
         p->quit = false;
+        p->pending_job = 0;
         p->id = i;
 
+        p->data = g_new0(MultiFDRecvData, 1);
+        p->data->size = 0;
+
         if (use_packets) {
             p->packet_len = sizeof(MultiFDPacket_t)
                 + sizeof(uint64_t) * page_count;
diff --git a/migration/multifd.h b/migration/multifd.h
index 406d42dbae..abaf16c3f2 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -13,6 +13,8 @@
 #ifndef QEMU_MIGRATION_MULTIFD_H
 #define QEMU_MIGRATION_MULTIFD_H
 
+typedef struct MultiFDRecvData MultiFDRecvData;
+
 int multifd_save_setup(Error **errp);
 void multifd_save_cleanup(void);
 int multifd_load_setup(Error **errp);
@@ -24,6 +26,8 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
 void multifd_recv_sync_main(void);
 int multifd_send_sync_main(QEMUFile *f);
 int multifd_queue_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset);
+int multifd_recv(void);
+MultiFDRecvData *multifd_get_recv_data(void);
 
 /* Multifd Compression flags */
 #define MULTIFD_FLAG_SYNC (1 << 0)
@@ -66,6 +70,13 @@ typedef struct {
     RAMBlock *block;
 } MultiFDPages_t;
 
+struct MultiFDRecvData {
+    void *opaque;
+    size_t size;
+    /* for preadv */
+    off_t file_offset;
+};
+
 typedef struct {
     /* Fields are only written at creating/deletion time */
     /* No lock required for them, they are read only */
@@ -156,6 +167,8 @@ typedef struct {
 
     /* syncs main thread and channels */
     QemuSemaphore sem_sync;
+    /* sem where to wait for more work */
+    QemuSemaphore sem;
 
     /* this mutex protects the following parameters */
     QemuMutex mutex;
@@ -167,6 +180,13 @@ typedef struct {
     uint32_t flags;
     /* global number of generated multifd packets */
     uint64_t packet_num;
+    int pending_job;
+    /*
+     * The owner of 'data' depends of 'pending_job' value:
+     * pending_job == 0 -> migration_thread can use it.
+     * pending_job != 0 -> multifd_channel can use it.
+     */
+    MultiFDRecvData *data;
 
     /* thread local variables. No locking required */
 
-- 
2.35.3


