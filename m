Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C07AF7D411B
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 22:40:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv1g3-00046m-4x; Mon, 23 Oct 2023 16:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1fq-0003jl-SG
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:37:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1fk-0001tM-Jn
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:37:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C2B741FE35;
 Mon, 23 Oct 2023 20:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698093428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rGDXXkd9mpTgbPLkflQJtoKien+TPU2p5r3bG/wfUw4=;
 b=GU+qB/vmoWKYvn5lnjxBrDq5lWme+Dfl3iavBlbOSgfzyfx4W5J2kbuXFyg1gbgSdNJq39
 NHpKprGUVMkjM8G4vvadK3vYjbW2XhizyQRXas66wY7qbXhmlaAoAy1oyUz/wm7D0XK4tu
 TFLWQLaCt43NNJLLpDzs3ol3H9gGrDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698093428;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rGDXXkd9mpTgbPLkflQJtoKien+TPU2p5r3bG/wfUw4=;
 b=csYAX9ZwppK2sQza+S4VQQp9z/GGuct/YPbhbKsMWnbZ9uVyxA8O6sdKIo9qZykUsmP3A7
 /4YquCwuklx8k8AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0642132FD;
 Mon, 23 Oct 2023 20:37:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GGBHInLZNmV1JQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 20:37:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v2 21/29] migration/multifd: Add pages to the receiving side
Date: Mon, 23 Oct 2023 17:36:00 -0300
Message-Id: <20231023203608.26370-22-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023203608.26370-1-farosas@suse.de>
References: <20231023203608.26370-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
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

Currently multifd does not need to have knowledge of pages on the
receiving side because all the information needed is within the
packets that come in the stream.

We're about to add support to fixed-ram migration, which cannot use
packets because it expects the ramblock section in the migration file
to contain only the guest pages data.

Add a pointer to MultiFDPages in the multifd_recv_state and use the
pages similarly to what we already do on the sending side. The pages
are used to transfer data between the ram migration code in the main
migration thread and the multifd receiving threads.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 107 ++++++++++++++++++++++++++++++++++++++++++++
 migration/multifd.h |  13 +++++-
 2 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index ad51210f13..20e8635740 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -992,6 +992,8 @@ int multifd_save_setup(Error **errp)
 
 struct {
     MultiFDRecvParams *params;
+    /* array of pages to receive */
+    MultiFDPages_t *pages;
     /* number of created threads */
     int count;
     /* syncs main thread and channels */
@@ -1002,6 +1004,75 @@ struct {
     MultiFDMethods *ops;
 } *multifd_recv_state;
 
+static int multifd_recv_pages(QEMUFile *f)
+{
+    int i;
+    static int next_recv_channel;
+    MultiFDRecvParams *p = NULL;
+    MultiFDPages_t *pages = multifd_recv_state->pages;
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
+
+    multifd_recv_state->pages = p->pages;
+    p->pages = pages;
+    qemu_mutex_unlock(&p->mutex);
+    qemu_sem_post(&p->sem);
+
+    return 1;
+}
+
+int multifd_recv_queue_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset)
+{
+    MultiFDPages_t *pages = multifd_recv_state->pages;
+    bool changed = false;
+
+    if (!pages->block) {
+        pages->block = block;
+    }
+
+    if (pages->block == block) {
+        pages->offset[pages->num] = offset;
+        pages->num++;
+
+        if (pages->num < pages->allocated) {
+            return 1;
+        }
+    } else {
+        changed = true;
+    }
+
+    if (multifd_recv_pages(f) < 0) {
+        return -1;
+    }
+
+    if (changed) {
+        return multifd_recv_queue_page(f, block, offset);
+    }
+
+    return 1;
+}
+
 static void multifd_recv_terminate_threads(Error *err)
 {
     int i;
@@ -1023,6 +1094,7 @@ static void multifd_recv_terminate_threads(Error *err)
 
         qemu_mutex_lock(&p->mutex);
         p->quit = true;
+        qemu_sem_post(&p->sem);
         /*
          * We could arrive here for two reasons:
          *  - normal quit, i.e. everything went fine, just finished
@@ -1072,8 +1144,11 @@ void multifd_load_cleanup(void)
         p->c = NULL;
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem_sync);
+        qemu_sem_destroy(&p->sem);
         g_free(p->name);
         p->name = NULL;
+        multifd_pages_clear(p->pages);
+        p->pages = NULL;
         p->packet_len = 0;
         g_free(p->packet);
         p->packet = NULL;
@@ -1086,6 +1161,8 @@ void multifd_load_cleanup(void)
     qemu_sem_destroy(&multifd_recv_state->sem_sync);
     g_free(multifd_recv_state->params);
     multifd_recv_state->params = NULL;
+    multifd_pages_clear(multifd_recv_state->pages);
+    multifd_recv_state->pages = NULL;
     g_free(multifd_recv_state);
     multifd_recv_state = NULL;
 }
@@ -1148,6 +1225,25 @@ static void *multifd_recv_thread(void *opaque)
                 break;
             }
             p->num_packets++;
+        } else {
+            /*
+             * No packets, so we need to wait for the vmstate code to
+             * queue pages.
+             */
+            qemu_sem_wait(&p->sem);
+            qemu_mutex_lock(&p->mutex);
+            if (!p->pending_job) {
+                qemu_mutex_unlock(&p->mutex);
+                break;
+            }
+
+            for (int i = 0; i < p->pages->num; i++) {
+                p->normal[p->normal_num] = p->pages->offset[i];
+                p->normal_num++;
+            }
+
+            p->pages->num = 0;
+            p->host = p->pages->block->host;
         }
 
         flags = p->flags;
@@ -1170,6 +1266,13 @@ static void *multifd_recv_thread(void *opaque)
             qemu_sem_post(&multifd_recv_state->sem_sync);
             qemu_sem_wait(&p->sem_sync);
         }
+
+        if (!use_packets) {
+            qemu_mutex_lock(&p->mutex);
+            p->pending_job--;
+            p->pages->block = NULL;
+            qemu_mutex_unlock(&p->mutex);
+        }
     }
 
     if (local_err) {
@@ -1204,6 +1307,7 @@ int multifd_load_setup(Error **errp)
     thread_count = migrate_multifd_channels();
     multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
+    multifd_recv_state->pages = multifd_pages_init(page_count);
     qatomic_set(&multifd_recv_state->count, 0);
     qemu_sem_init(&multifd_recv_state->sem_sync, 0);
     multifd_recv_state->ops = multifd_ops[migrate_multifd_compression()];
@@ -1213,8 +1317,11 @@ int multifd_load_setup(Error **errp)
 
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem_sync, 0);
+        qemu_sem_init(&p->sem, 0);
         p->quit = false;
+        p->pending_job = 0;
         p->id = i;
+        p->pages = multifd_pages_init(page_count);
 
         if (use_packets) {
             p->packet_len = sizeof(MultiFDPacket_t)
diff --git a/migration/multifd.h b/migration/multifd.h
index a112ec7ac6..b571b1e4a2 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -24,6 +24,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
 void multifd_recv_sync_main(void);
 int multifd_send_sync_main(QEMUFile *f);
 int multifd_queue_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset);
+int multifd_recv_queue_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset);
 
 /* Multifd Compression flags */
 #define MULTIFD_FLAG_SYNC (1 << 0)
@@ -153,9 +154,13 @@ typedef struct {
     uint32_t page_size;
     /* number of pages in a full packet */
     uint32_t page_count;
+    /* multifd flags for receiving ram */
+    int read_flags;
 
     /* syncs main thread and channels */
     QemuSemaphore sem_sync;
+    /* sem where to wait for more work */
+    QemuSemaphore sem;
 
     /* this mutex protects the following parameters */
     QemuMutex mutex;
@@ -167,6 +172,13 @@ typedef struct {
     uint32_t flags;
     /* global number of generated multifd packets */
     uint64_t packet_num;
+    int pending_job;
+    /* array of pages to sent.
+     * The owner of 'pages' depends of 'pending_job' value:
+     * pending_job == 0 -> migration_thread can use it.
+     * pending_job != 0 -> multifd_channel can use it.
+     */
+    MultiFDPages_t *pages;
 
     /* thread local variables. No locking required */
 
@@ -210,4 +222,3 @@ typedef struct {
 void multifd_register_ops(int method, MultiFDMethods *ops);
 
 #endif
-
-- 
2.35.3


