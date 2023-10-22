Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2E67D25C8
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 22:14:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1queoZ-0005Fk-Of; Sun, 22 Oct 2023 16:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1queoX-0005F6-6S
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 16:12:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1queoV-00061j-ES
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 16:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698005562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOiiFysHiha1Yh2C+xE/FVmKDgYGIOfNW5Tic1Olavc=;
 b=ZtcrD+599a741Gy5zco16F684BLwk30hyzILxO+jKoB+Sz0Zpd/uL9v0pfO4mzTEvDCyMt
 KsGLnzif1TVK3omd+88YnfQaEEKf2X8KJyudZ3sKdPIVX5bd6NaC8sDzWTUZ9bPwXSFPdA
 vgJV4VMmX7KLpA7JpZ/GtqcfgFuYdhY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-0j4quv0INnKAsju2hCpGoA-1; Sun, 22 Oct 2023 16:12:41 -0400
X-MC-Unique: 0j4quv0INnKAsju2hCpGoA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-778b5c628f4so36773485a.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 13:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698005560; x=1698610360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uOiiFysHiha1Yh2C+xE/FVmKDgYGIOfNW5Tic1Olavc=;
 b=lfN/lPZKXnhjrrUX66le6kqN6/Oho5vnxdYf2wTqxeawDjuk4oELwpZ7WcbKYPjQjw
 Bkb32ilFTDeQHurarnDxMcExPI6JQQWl7Rtr/3D5z91YIhU3nRdchbauqGR4Uaa5Gynx
 aN0I26u7P3EgpwW9Fkmfz9rmXRSIfJnl6yEO15cr8/3mlnwKert+gAc8+0FO4VZ2IP1k
 PhlAIrQ+jh20vw2EziEJtyTnxBDfpWl6eqFLNCWTf183p27kRrNg39b6N3DV7S+8gmnn
 HrfmUOeRCii5vcO2JSUZEKrrNqerLZBCiC1aDF4MpLpsNccgreo12zWw8rwy5/y5iW4S
 y6vQ==
X-Gm-Message-State: AOJu0YwzTJE9zC0h2gRTPa5J/3fpbaS5OL55ywM/Tyj8o92JI1VxoxVq
 aZH9bIuE1rKj3oaRJ2ZrjyXs2p68fgGR4jXu/Aqd7Pif4hRcv7uRhaNcCA6Zdb528/uNr0hFZJk
 WHI3pRMV+vAQe6N0hbY4qtn/ODGaoZhu7hmI24zSUkdfU8Zu3/v0SNiPVC/IaI7daHAr9tVX2
X-Received: by 2002:ad4:57d1:0:b0:66d:b23:a62e with SMTP id
 y17-20020ad457d1000000b0066d0b23a62emr7643793qvx.6.1698005560180; 
 Sun, 22 Oct 2023 13:12:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV6uXGBS9VAROHWbBzuzzVZk01cDs9ue6F0TFMEKUiCQdUgykBwyJ29sud8EoIn/NR6fa2Wg==
X-Received: by 2002:ad4:57d1:0:b0:66d:b23:a62e with SMTP id
 y17-20020ad457d1000000b0066d0b23a62emr7643778qvx.6.1698005559780; 
 Sun, 22 Oct 2023 13:12:39 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a0cfe0b000000b0065af657ddf7sm2330515qvr.144.2023.10.22.13.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 13:12:39 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com
Subject: [PATCH RFC 5/7] migration: Modulize multifd send threads with a few
 helpers
Date: Sun, 22 Oct 2023 16:12:09 -0400
Message-ID: <20231022201211.452861-6-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231022201211.452861-1-peterx@redhat.com>
References: <20231022201211.452861-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Abstract the multifd send packet logic into two phases:

  - multifd_send_prepare(): prepare the packet headers, with mutex
  - multifd_do_send(): do the send job finally, without mutex

When at it, always allow the send thread to use Error* for detecting
errors, dropping "int ret" altogether.

One trivial change is the send thread now kicks the sem_sync within mutex
critical section, but that shouldn't be a problem.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 160 ++++++++++++++++++++++++++------------------
 1 file changed, 96 insertions(+), 64 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 9d458914a9..8140520843 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -640,13 +640,89 @@ int multifd_send_sync_main(QEMUFile *f)
     return 0;
 }
 
+/*
+ * Returns true if succeed, false otherwise (with errp set).  Caller must
+ * be with p->mutex held.
+ */
+static bool multifd_send_prepare(MultiFDSendParams *p, Error **errp)
+{
+    bool use_zero_copy_send = migrate_zero_copy_send();
+    uint64_t packet_num = p->packet_num;
+    uint32_t flags;
+    int ret;
+
+    p->normal_num = 0;
+
+    if (use_zero_copy_send) {
+        p->iovs_num = 0;
+    } else {
+        p->iovs_num = 1;
+    }
+
+    for (int i = 0; i < p->pages->num; i++) {
+        p->normal[p->normal_num] = p->pages->offset[i];
+        p->normal_num++;
+    }
+
+    if (p->normal_num) {
+        ret = multifd_send_state->ops->send_prepare(p, errp);
+        if (ret != 0) {
+            return false;
+        }
+    }
+    multifd_send_fill_packet(p);
+    flags = p->flags;
+    p->flags = 0;
+    p->num_packets++;
+    p->total_normal_pages += p->normal_num;
+    p->pages->num = 0;
+    p->pages->block = NULL;
+
+    trace_multifd_send(p->id, packet_num, p->normal_num, flags,
+                       p->next_packet_size);
+
+    return true;
+}
+
+/* Returns true if succeed, false otherwise (with errp set) */
+static bool multifd_do_send(MultiFDSendParams *p, Error **errp)
+{
+    bool use_zero_copy_send = migrate_zero_copy_send();
+    int ret;
+
+    if (use_zero_copy_send) {
+        /* Send header first, without zerocopy */
+        ret = qio_channel_write_all(p->c, (void *)p->packet,
+                                    p->packet_len, errp);
+        if (ret != 0) {
+            return false;
+        }
+    } else {
+        /* Send header using the same writev call */
+        p->iov[0].iov_len = p->packet_len;
+        p->iov[0].iov_base = p->packet;
+    }
+
+    ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
+                                      0, p->write_flags, errp);
+    if (ret != 0) {
+        return false;
+    }
+
+    stat64_add(&mig_stats.multifd_bytes,
+               p->next_packet_size + p->packet_len);
+    stat64_add(&mig_stats.transferred,
+               p->next_packet_size + p->packet_len);
+    p->next_packet_size = 0;
+
+    return true;
+}
+
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
     MigrationThread *thread = NULL;
     Error *local_err = NULL;
-    int ret = 0;
-    bool use_zero_copy_send = migrate_zero_copy_send();
 
     thread = migration_threads_add(p->name, qemu_get_thread_id());
 
@@ -654,9 +730,10 @@ static void *multifd_send_thread(void *opaque)
     rcu_register_thread();
 
     if (multifd_send_initial_packet(p, &local_err) < 0) {
-        ret = -1;
+        assert(local_err);
         goto out;
     }
+
     /* initial packet */
     p->num_packets = 1;
 
@@ -667,83 +744,38 @@ static void *multifd_send_thread(void *opaque)
         if (qatomic_read(&multifd_send_state->exiting)) {
             break;
         }
-        qemu_mutex_lock(&p->mutex);
 
+        qemu_mutex_lock(&p->mutex);
         if (p->pending_job) {
-            uint64_t packet_num = p->packet_num;
-            uint32_t flags;
-            p->normal_num = 0;
-
-            if (use_zero_copy_send) {
-                p->iovs_num = 0;
-            } else {
-                p->iovs_num = 1;
-            }
+            bool need_sync = p->flags & MULTIFD_FLAG_SYNC;
 
-            for (int i = 0; i < p->pages->num; i++) {
-                p->normal[p->normal_num] = p->pages->offset[i];
-                p->normal_num++;
+            if (!multifd_send_prepare(p, &local_err)) {
+                assert(local_err);
+                qemu_mutex_unlock(&p->mutex);
+                goto out;
             }
 
-            if (p->normal_num) {
-                ret = multifd_send_state->ops->send_prepare(p, &local_err);
-                if (ret != 0) {
-                    qemu_mutex_unlock(&p->mutex);
-                    break;
-                }
-            }
-            multifd_send_fill_packet(p);
-            flags = p->flags;
-            p->flags = 0;
-            p->num_packets++;
-            p->total_normal_pages += p->normal_num;
-            p->pages->num = 0;
-            p->pages->block = NULL;
+            /* Send the packets without mutex */
             qemu_mutex_unlock(&p->mutex);
-
-            trace_multifd_send(p->id, packet_num, p->normal_num, flags,
-                               p->next_packet_size);
-
-            if (use_zero_copy_send) {
-                /* Send header first, without zerocopy */
-                ret = qio_channel_write_all(p->c, (void *)p->packet,
-                                            p->packet_len, &local_err);
-                if (ret != 0) {
-                    break;
-                }
-            } else {
-                /* Send header using the same writev call */
-                p->iov[0].iov_len = p->packet_len;
-                p->iov[0].iov_base = p->packet;
+            if (!multifd_do_send(p, &local_err)) {
+                assert(local_err);
+                goto out;
             }
-
-            ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
-                                              0, p->write_flags, &local_err);
-            if (ret != 0) {
-                break;
-            }
-
-            stat64_add(&mig_stats.multifd_bytes,
-                       p->next_packet_size + p->packet_len);
-            stat64_add(&mig_stats.transferred,
-                       p->next_packet_size + p->packet_len);
-            p->next_packet_size = 0;
             qemu_mutex_lock(&p->mutex);
+
+            /* Send successful, mark the task completed */
             p->pending_job--;
-            qemu_mutex_unlock(&p->mutex);
 
-            if (flags & MULTIFD_FLAG_SYNC) {
+            /* If this is a sync task, we need one more kick */
+            if (need_sync) {
                 qemu_sem_post(&p->sem_sync);
             }
-        } else {
-            qemu_mutex_unlock(&p->mutex);
-            /* sometimes there are spurious wakeups */
         }
+        qemu_mutex_unlock(&p->mutex);
     }
 
 out:
-    if (ret) {
-        assert(local_err);
+    if (local_err) {
         trace_multifd_send_error(p->id);
         multifd_send_terminate_threads(local_err);
         multifd_send_kick_main(p);
-- 
2.41.0


