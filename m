Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 202F57D25C6
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 22:14:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1queob-0005Ge-BX; Sun, 22 Oct 2023 16:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1queoZ-0005Fn-Hb
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 16:12:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1queoY-00062D-2t
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 16:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698005565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=phapzCWUE8d8Jlkfp2/jJ1KPEdP1a8qLD5w17cHMUKI=;
 b=C584AgxY1fXLtrjoRMYjUTm9m2VzLmNseS7rehWcKMyd5lGaigjjSWnTCmHXm72vCfmrPb
 wRe+4WkfzckXf+aU3nd2586BJvxdxsrtFgyz3sEQuD/xQ8R6J5RXtguvy0VRfoqJqgf0SO
 Oz0rb3h+owcOovwFfbdNvAreh5qpuuY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-NaL2fcVVODaVh8qH70r3Jg-1; Sun, 22 Oct 2023 16:12:41 -0400
X-MC-Unique: NaL2fcVVODaVh8qH70r3Jg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66d48cfd295so11084726d6.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 13:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698005561; x=1698610361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phapzCWUE8d8Jlkfp2/jJ1KPEdP1a8qLD5w17cHMUKI=;
 b=BJlx9DDuF1ybGKU4ocS1HNI0QPasoZuT2XF6THR1u/0aOYIeY+TwBW8hsxi6qmTugq
 SIcYT0L7MEMjsFryB43XrArZdKbjSmNcPeR02Xsic3mh9uZzEDH4IB6ke1P+Oj/6LsYS
 jlrzfiqNsalwH/V5zzpjPujCR8iEajJJrPRYrc59RnJPbYZ+T40UzF1X7/jHBejua8nt
 8HU3GngAxMoV49jA1GU+nCwU/VBE0+zB3u1ITUtzLLANfHiym/mcLyD8xQuHcRp2CGKZ
 fw1GYyPdVpgZEoKsS9B90HlsT6GNqZJOhSBk7sli7DHlNffyJNcoBp+eOWjSPwkCzANd
 svvg==
X-Gm-Message-State: AOJu0YytIJYTRirdf3JFO5g2JLdXFX/t5qbci5A9x7dieZWBmBZR9y9x
 3+WtqYxmlqw29wgB2ztMzAw6VW5dLreLt66k5eluSjB+GE9p6pcrYhB45BXhxlkpCv462YMdHAs
 bKSYPQeFUoIG7f+rjq2sB08rfp0ECCaPJazRly/EqJnz0x0P28FZOAbuH2ZuLhc79kxUwOZJ/
X-Received: by 2002:a05:6214:3d8d:b0:66d:1ff9:321f with SMTP id
 om13-20020a0562143d8d00b0066d1ff9321fmr8206092qvb.6.1698005561010; 
 Sun, 22 Oct 2023 13:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2wtZOCYLDeeiAwgm0HjXbcr2Fl+kmdggWRm/WpeLAJBORKeyRqCbNQN9SV7/x4QFdFwZBPg==
X-Received: by 2002:a05:6214:3d8d:b0:66d:1ff9:321f with SMTP id
 om13-20020a0562143d8d00b0066d1ff9321fmr8206074qvb.6.1698005560601; 
 Sun, 22 Oct 2023 13:12:40 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a0cfe0b000000b0065af657ddf7sm2330515qvr.144.2023.10.22.13.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 13:12:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com
Subject: [PATCH RFC 6/7] migration: Split multifd pending_job into two booleans
Date: Sun, 22 Oct 2023 16:12:10 -0400
Message-ID: <20231022201211.452861-7-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231022201211.452861-1-peterx@redhat.com>
References: <20231022201211.452861-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h | 16 ++++++++++------
 migration/multifd.c | 33 +++++++++++++++++++++++----------
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 2acf400085..ddee7b8d8a 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -101,12 +101,16 @@ typedef struct {
     uint32_t flags;
     /* global number of generated multifd packets */
     uint64_t packet_num;
-    /* thread has work to do */
-    int pending_job;
-    /* array of pages to sent.
-     * The owner of 'pages' depends of 'pending_job' value:
-     * pending_job == 0 -> migration_thread can use it.
-     * pending_job != 0 -> multifd_channel can use it.
+    /* thread has a request to sync all data */
+    bool pending_sync;
+    /* thread has something to send */
+    bool pending_job;
+    /*
+     * Array of pages to sent. The owner of 'pages' depends of
+     * 'pending_job' value:
+     *
+     *   - true -> multifd_channel owns it.
+     *   - false -> migration_thread owns it.
      */
     MultiFDPages_t *pages;
 
diff --git a/migration/multifd.c b/migration/multifd.c
index 8140520843..fe8d746ff9 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -425,7 +425,7 @@ static int multifd_send_pages(QEMUFile *f)
         p = &multifd_send_state->params[i];
         qemu_mutex_lock(&p->mutex);
         if (!p->pending_job) {
-            p->pending_job++;
+            p->pending_job = true;
             next_channel = (i + 1) % migrate_multifd_channels();
             break;
         }
@@ -615,8 +615,7 @@ int multifd_send_sync_main(QEMUFile *f)
 
         qemu_mutex_lock(&p->mutex);
         p->packet_num = multifd_send_state->packet_num++;
-        p->flags |= MULTIFD_FLAG_SYNC;
-        p->pending_job++;
+        p->pending_sync = true;
         qemu_mutex_unlock(&p->mutex);
         qemu_sem_post(&p->sem);
     }
@@ -747,8 +746,6 @@ static void *multifd_send_thread(void *opaque)
 
         qemu_mutex_lock(&p->mutex);
         if (p->pending_job) {
-            bool need_sync = p->flags & MULTIFD_FLAG_SYNC;
-
             if (!multifd_send_prepare(p, &local_err)) {
                 assert(local_err);
                 qemu_mutex_unlock(&p->mutex);
@@ -764,12 +761,27 @@ static void *multifd_send_thread(void *opaque)
             qemu_mutex_lock(&p->mutex);
 
             /* Send successful, mark the task completed */
-            p->pending_job--;
+            p->pending_job = false;
+
+        } else if (p->pending_sync) {
+            p->flags |= MULTIFD_FLAG_SYNC;
+
+            if (!multifd_send_prepare(p, &local_err)) {
+                assert(local_err);
+                qemu_mutex_unlock(&p->mutex);
+                goto out;
+            }
 
-            /* If this is a sync task, we need one more kick */
-            if (need_sync) {
-                qemu_sem_post(&p->sem_sync);
+            /* Send the packets without mutex */
+            qemu_mutex_unlock(&p->mutex);
+            if (!multifd_do_send(p, &local_err)) {
+                assert(local_err);
+                goto out;
             }
+            qemu_mutex_lock(&p->mutex);
+
+            qemu_sem_post(&p->sem_sync);
+            p->pending_sync = false;
         }
         qemu_mutex_unlock(&p->mutex);
     }
@@ -932,7 +944,8 @@ int multifd_save_setup(Error **errp)
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
-        p->pending_job = 0;
+        p->pending_job = false;
+        p->pending_sync = false;
         p->id = i;
         p->pages = multifd_pages_init(page_count);
         p->packet_len = sizeof(MultiFDPacket_t)
-- 
2.41.0


