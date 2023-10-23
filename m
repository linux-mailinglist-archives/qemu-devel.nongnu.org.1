Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3847D3B86
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:53:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxEv-0007IO-Hr; Mon, 23 Oct 2023 11:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1quxEq-0007Cu-VC
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:53:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1quxEm-0006QN-Uc
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698076383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y4jaSUuPsemVA982bEN2EmukpqfSwlaJR5TSMRrhFNc=;
 b=UC3+sSvFBO7gaLfIyAgrB6MPuhN1ZlR2PKUMePL36U/28EQlKj3hGdqgwNIIZTQJLwH48u
 XRqhuUbFlcKYoLPNEBLvk9ycFtrRSS/Uyd40H3bvOXYneQGTIwkHyCpTVTtC5AsQC3wEXZ
 c+mNAOMFgcuGE8/6jTkytQZ5d1YTCIw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-p-aBXfxKOoiyM9DGLcFZGw-1; Mon, 23 Oct 2023 11:52:55 -0400
X-MC-Unique: p-aBXfxKOoiyM9DGLcFZGw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41e1ecf3350so3059811cf.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 08:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698076375; x=1698681175;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4jaSUuPsemVA982bEN2EmukpqfSwlaJR5TSMRrhFNc=;
 b=HAtUxbEsPRrDciRV/+QA2xZXRqBAZ4MT95S7ovj5CUVAS9CeBhkdQtY4WbAEJbrJHO
 FY0UDS62J4vSo72XrgMI9E0i/LfBIpeeAgp0XYt6q96R9BI33Bv2jfOd3BuDyl/NtveD
 wT+w6V08vPeEAPKM8DYTffM2DQCSQpzM8oWkOlWlUa78HksSqUdCKsBVXIpWsslpbCfH
 Z3mfdquy2BnfFyHU7AYJ+GrPtz2PPP0nvxgDvFPmrLGQrLsbQqoYTXu+H5onMHkj9yM9
 QAHadT+6kZAh/ug5RKBbU9FTB0SuIFmOg06eMI+192Qp8N9XBY4XXbPXIflB3906illP
 zJYQ==
X-Gm-Message-State: AOJu0YxpmKUfHpEtzFJX66FMkG+1asFUaKM/hG9bkNKrzQOX2zUrTj/Y
 ouebO7/gEfGJaY9djjBclNdG1/QLFVLrgQajNkR+V9fWuuxinJJMevmd14um1Qj39G31FAJ3btl
 XZ52o8mtyG8H/nZ0FRCf5dKI=
X-Received: by 2002:a05:622a:198a:b0:417:944a:bcd0 with SMTP id
 u10-20020a05622a198a00b00417944abcd0mr11296129qtc.3.1698076375007; 
 Mon, 23 Oct 2023 08:52:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAs52vYMaHypOpbciqlUGKjlnH8fs2BGYwQ8DdMDPb2eBSPHX5S55AD8XhGNcbbtg2WWfYkw==
X-Received: by 2002:a05:622a:198a:b0:417:944a:bcd0 with SMTP id
 u10-20020a05622a198a00b00417944abcd0mr11296116qtc.3.1698076374710; 
 Mon, 23 Oct 2023 08:52:54 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 v14-20020ac8748e000000b0041815bcea29sm2798337qtq.19.2023.10.23.08.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 08:52:54 -0700 (PDT)
Date: Mon, 23 Oct 2023 11:52:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH RFC 6/7] migration: Split multifd pending_job into two
 booleans
Message-ID: <ZTaW1I/HOrt9mk7Z@x1n>
References: <20231022201211.452861-1-peterx@redhat.com>
 <20231022201211.452861-7-peterx@redhat.com>
 <87bkcpz7x6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bkcpz7x6.fsf@suse.de>
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

On Mon, Oct 23, 2023 at 12:15:49PM -0300, Fabiano Rosas wrote:
> > @@ -764,12 +761,27 @@ static void *multifd_send_thread(void *opaque)
> >              qemu_mutex_lock(&p->mutex);
> >  
> >              /* Send successful, mark the task completed */
> > -            p->pending_job--;
> > +            p->pending_job = false;
> > +
> > +        } else if (p->pending_sync) {
> 
> Is your intention here to stop sending the SYNC along with the pages?
> This would have to loop once more to send the sync.

My intention is to be clear on how we do SYNC, e.g., avoid main thread
touching p->flags at all.

AFAIK we'll need to loop twice either before or after this patch to send
SYNC; the old code boosts pending_job for sync too, and kick one more time
upon p->sem to guarantee that 2nd loop.

The major difference after this patch is, it'll be clear we send the pages
first in the 1st packet, then another SYNC packet as the 2nd.  Also I hope
the pending_sync is more readable too..

One thing I should have mentioned but I didn't: we must handle pending_job
before pending_sync here, so that when we do SYNC we make sure all pages
will be sent.  IOW, below:

  if (p->pending_sync) {
     ...
  } else if (p->pending_job) {
     ...
  }

should be buggy, because when pending_sync requested with job==true, we can
send SYNC before that batch of pages.

I'll add a comment block for it:

        /*
         * NOTE: we must handle pending_job before pending_sync, so as to
         * make sure SYNC packet will always cover all queued pages here.
         */
        if (p->pending_job) {

One thing I just notice is I forgot to write commit message for this
patch.. my apologies.  Let me attach a new version here with commit message
written, and with the comment squashed in, attached.

Thanks,

===8<===

From c7636dffe0f58e42e5aa0028cd0a6208cc75dd46 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Sun, 22 Oct 2023 15:20:29 -0400
Subject: [PATCH] migration: Split multifd pending_job into two booleans

We used to have MultiFDSendParams.pending_job covering both sending data
and sending SYNC message.  The send SYNC message part is tricky, because it
directly modifies p->flags, boost pending_job even if there is a request.
It makes it the only chance where pending_job can be larger than 1.

To make it clear, split the pending_job integer into two booleans:

  - pending_job:  keep its own name, a boolean to show we have data to send
  - pending_sync: a new boolean shows QEMU requests a SYNC message to send

With that, we can remove the only place that main thread will touch
p->flags, instead it simply sets pending_sync==true.  Multifd send thread
also does not need to peek p->flags before hand, it can unconditionally
kick p->sem_sync as long as it's a pending_sync request.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h | 16 ++++++++++------
 migration/multifd.c | 37 +++++++++++++++++++++++++++----------
 2 files changed, 37 insertions(+), 16 deletions(-)

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
index 3f4fb6ad40..5d3571faa8 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -434,7 +434,7 @@ static int multifd_send_pages(QEMUFile *f)
         p = &multifd_send_state->params[i];
         qemu_mutex_lock(&p->mutex);
         if (!p->pending_job) {
-            p->pending_job++;
+            p->pending_job = true;
             next_channel = (i + 1) % migrate_multifd_channels();
             break;
         }
@@ -624,8 +624,7 @@ int multifd_send_sync_main(QEMUFile *f)
 
         qemu_mutex_lock(&p->mutex);
         p->packet_num = multifd_send_state->packet_num++;
-        p->flags |= MULTIFD_FLAG_SYNC;
-        p->pending_job++;
+        p->pending_sync = true;
         qemu_mutex_unlock(&p->mutex);
         qemu_sem_post(&p->sem);
     }
@@ -755,9 +754,11 @@ static void *multifd_send_thread(void *opaque)
         }
 
         qemu_mutex_lock(&p->mutex);
+        /*
+         * NOTE: we must handle pending_job before pending_sync, so as to
+         * make sure SYNC packet will always cover all queued pages here.
+         */
         if (p->pending_job) {
-            bool need_sync = p->flags & MULTIFD_FLAG_SYNC;
-
             if (!multifd_send_prepare(p, &local_err)) {
                 assert(local_err);
                 qemu_mutex_unlock(&p->mutex);
@@ -773,12 +774,27 @@ static void *multifd_send_thread(void *opaque)
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
@@ -941,7 +957,8 @@ int multifd_save_setup(Error **errp)
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

-- 
Peter Xu


