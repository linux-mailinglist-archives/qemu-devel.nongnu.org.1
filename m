Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFD87A2397
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:29:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBgW-0004yX-PV; Fri, 15 Sep 2023 12:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qhBgU-0004xw-Ds
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qhBgS-000273-5w
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694795322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v6h15rrcom6/d92eWuq/6p0LuhpM7rVpNcHNe4RxLJE=;
 b=dQ8UYLklNvj5ifkQdk74vFOcNErCo3YqSqE9UVkOjcXhVJfGyGzJoQd9s9gdX2sJfkJ8Oy
 xHaJfu9Y49jt3SEgZ70S13tx58w546kVbfBwau+0JIvwiVqLjzdIwg2J+UM0ayjK3vzKaA
 PRMS3UiMIdYlVGjfq26hD9zoHd50TN8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-EG_BoIOiNPeZetLiEZR_UQ-1; Fri, 15 Sep 2023 12:28:39 -0400
X-MC-Unique: EG_BoIOiNPeZetLiEZR_UQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76f191e26f5so60138685a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694795318; x=1695400118;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6h15rrcom6/d92eWuq/6p0LuhpM7rVpNcHNe4RxLJE=;
 b=fxtEgbNVImBoqRGWcLptXWAAMjizOm91wA3jt6K3AmgBPMW4nGXgZ3v6Gi+T1zs3ir
 dw4h+ik/CMEnV+4qOX/f950GZGM0hRdrnY2D1hMFUEafcD/IZ0r8CaYBAJEJj+JEclza
 HRgIBCtl0w2p5qslp4Evg77C0GhalaOLgVm0xA6ArZTIgoWbD/F6uc+tgQrkStEHzrgb
 7w1EVkIGddzbYVVAvINPpJmF0V4lT+Opk2Wd5XiDcsUMGtEBkO7xmPwzVk8lmHA71SO0
 I5+yYVvHlmTeKrvddB0u2qWSn2L0zC3q65aBw6JpDWzI35tUxDXMQzxAG5bi6HB7lq/u
 7xog==
X-Gm-Message-State: AOJu0Yx4U++UfbeYw+akGlDyfwUGiXte8bZsrVfz2tTOgk0LJbZpzeyY
 ZYxUF9waXu/wcAHLmY42HvpF88lOfPdfidwNAmqku0scjd871NsiaG37XZacG8zeI20Mt/XjKDF
 Xcm+yCJfQp/x2bFQ=
X-Received: by 2002:a05:6214:20ef:b0:621:65de:f60c with SMTP id
 15-20020a05621420ef00b0062165def60cmr2495004qvk.3.1694795318396; 
 Fri, 15 Sep 2023 09:28:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0C9ioJLJGaRUvkTZ7fRJ2WGC9gCLK8dflvx2EtG0s92F464eQaNzdCvU5AbBUOm5iPfUoCg==
X-Received: by 2002:a05:6214:20ef:b0:621:65de:f60c with SMTP id
 15-20020a05621420ef00b0062165def60cmr2494987qvk.3.1694795318116; 
 Fri, 15 Sep 2023 09:28:38 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 o8-20020a0ccb08000000b00626362f1bf1sm1361382qvk.63.2023.09.15.09.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:28:37 -0700 (PDT)
Date: Fri, 15 Sep 2023 12:28:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org
Subject: Re: QEMU migration-test CI intermittent failure
Message-ID: <ZQSGNDn2gg5if8ie@x1n>
References: <87r0n1kggo.fsf@suse.de> <ZQMfIO3oiqTsawtU@x1n>
 <87edj0kcz7.fsf@suse.de> <ZQMoUzRH1BZKs39g@x1n>
 <87bke4kasr.fsf@suse.de> <ZQM3SV4eqSltoQSe@x1n>
 <87led8e9vv.fsf@suse.de> <87r0n0nz6u.fsf@suse.de>
 <ZQOW4BS1ZcDTN7tK@x1n> <87o7i4nqrc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o7i4nqrc.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Sep 14, 2023 at 10:56:23PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Sep 14, 2023 at 07:54:17PM -0300, Fabiano Rosas wrote:
> >> Fabiano Rosas <farosas@suse.de> writes:
> >> 
> >> > Peter Xu <peterx@redhat.com> writes:
> >> >
> >> >> On Thu, Sep 14, 2023 at 12:57:08PM -0300, Fabiano Rosas wrote:
> >> >>> I managed to reproduce it. It's not the return path error. In hindsight
> >> >>> that's obvious because that error happens in the 'recovery' test and this
> >> >>> one in the 'plain' one. Sorry about the noise.
> >> >>
> >> >> No worry.  It's good to finally identify that.
> >> >>
> >> >>> 
> >> >>> This one reproduced with just 4 iterations of preempt/plain. I'll
> >> >>> investigate.
> >> >
> >> > It seems that we're getting a tcp disconnect (ECONNRESET) on when doing
> >> > that shutdown() on postcopy_qemufile_src. The one from commit 6621883f93
> >> > ("migration: Fix potential race on postcopy_qemufile_src").
> >> >
> >> > I'm trying to determine why that happens when other times it just
> >> > returns 0 as expected.
> >> >
> >> > Could this mean that we're kicking the dest too soon while it is still
> >> > receiving valid data?
> >> 
> >> Looking a bit more into this, what's happening is that
> >> postcopy_ram_incoming_cleanup() is shutting the postcopy_qemufile_dst
> >> while ram_load_postcopy() is still running.
> >> 
> >> The postcopy_ram_listen_thread() function waits for the
> >> main_thread_load_event, but that only works when not using preempt. With
> >> the preempt thread, the event is set right away and we proceed to do the
> >> cleanup without waiting.
> >> 
> >> So the assumption of commit 6621883f93 that the incoming side knows when
> >> it has finished migrating is wrong IMO. Without the EOS we're relying on
> >> the chance that the shutdown() happens after the last recvmsg has
> >> returned and not during it.
> >> 
> >> Peter, what do you think?
> >
> > That's a good point.
> >
> > One thing to verify that (sorry, I still cannot reproduce it myself, which
> > is so weirdly... it seems loads won't really help reproducing this) is to
> > let the main thread wait for all requested pages to arrive:
> >
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 29aea9456d..df055c51ea 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -597,6 +597,12 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
> >      trace_postcopy_ram_incoming_cleanup_entry();
> >  
> >      if (mis->preempt_thread_status == PREEMPT_THREAD_CREATED) {
> > +        /*
> > +         * NOTE!  it's possible that the preempt thread is still handling
> > +         * the last pages to arrive which were requested by faults.  Making
> > +         * sure nothing is left behind.
> > +         */
> > +        while (qatomic_read(&mis->page_requested_count));
> >          /* Notify the fast load thread to quit */
> >          mis->preempt_thread_status = PREEMPT_THREAD_QUIT;
> >          if (mis->postcopy_qemufile_dst) {
> >
> > If that can work solidly, we can figure out a better way than a dead loop
> > here.
> 
> Yep, 2000+ iterations so far and no error.

Definitely good news.. thanks.

> 
> Should we add something that makes ram_load_postcopy return once it's
> finished? Then this code could just set PREEMPT_THREAD_QUIT and join the
> preempt thread.

Yeah it'll be nice to have that. We used to have an EOS message at the end
for the preempt channel, but that used to cause another race (which IIRC I
could easily reproduce at that time) and we removed it after
6621883f9398bc3 for 7.2+.

Now instead of fiddling with the protocol again, we do have a way to detect
that, but it may need some trick on counting on page_requested_count and
also provide a signal mechanism.

I've drafted one solution here and attached here as a complete patch, feel
free to try.  If you have anything better, that'll be even nicer; just let
me know your thoughts.

---8<---
From 384aff2264650872e15916dcfeaec593e5e9b781 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 15 Sep 2023 12:11:34 -0400
Subject: [PATCH] migration: Fix race that dest preempt thread close too early

We hit intermit CI issue on failing at migration-test over the unit test
preempt/plain:

qemu-system-x86_64: Unable to read from socket: Connection reset by peer
Memory content inconsistency at 5b43000 first_byte = bd last_byte = bc current = 4f hit_edge = 1
**
ERROR:../tests/qtest/migration-test.c:300:check_guests_ram: assertion failed: (bad == 0)
(test program exited with status code -6)

Fabiano debugged into it and found that the preempt thread can quit even
without receiving all the pages, which can cause guest not receiving all
the pages and corrupt the guest memory.

To make sure preempt thread finished receiving all the pages, we can rely
on the page_requested_count being zero because preempt channel will only
receive requested page faults. Note, not all the faulted pages are required
to be sent via the preempt channel/thread; imagine the case when a
requested page is just queued into the background main channel for
migration, the src qemu will just still send it via the background channel.

Here instead of spinning over reading the count, we add a condvar so the
main thread can wait on it if that unusual case happened, without burning
the cpu for no good reason, even if the duration is short; so even if we
spin in this rare case is probably fine.  It's just better to not do so.

The condvar is only used when that special case is triggered.  Some memory
ordering trick is needed to guarantee it from happening (against the
preempt thread status field), so the main thread will always get a kick
when that triggers correctly.

Closes: https://gitlab.com/qemu-project/qemu/-/issues/1886
Debugged-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h    | 13 ++++++++++++-
 migration/migration.c    |  1 +
 migration/postcopy-ram.c | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/migration/migration.h b/migration/migration.h
index c390500604..cdaa10d515 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -196,7 +196,10 @@ struct MigrationIncomingState {
 
     /* A tree of pages that we requested to the source VM */
     GTree *page_requested;
-    /* For debugging purpose only, but would be nice to keep */
+    /*
+     * For postcopy only, count the number of requested page faults that
+     * still haven't been resolved.
+     */
     int page_requested_count;
     /*
      * The mutex helps to maintain the requested pages that we sent to the
@@ -210,6 +213,14 @@ struct MigrationIncomingState {
      * contains valid information.
      */
     QemuMutex page_request_mutex;
+    /*
+     * If postcopy preempt is enabled, there is a chance that the main
+     * thread finished loading its data before the preempt channel has
+     * finished loading the urgent pages.  If that happens, the two threads
+     * will use this condvar to synchronize, so the main thread will always
+     * wait until all pages received.
+     */
+    QemuCond page_request_cond;
 
     /*
      * Number of devices that have yet to approve switchover. When this reaches
diff --git a/migration/migration.c b/migration/migration.c
index d61e572742..e86b3f7368 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -153,6 +153,7 @@ void migration_object_init(void)
     qemu_sem_init(&current_incoming->postcopy_qemufile_dst_done, 0);
 
     qemu_mutex_init(&current_incoming->page_request_mutex);
+    qemu_cond_init(&current_incoming->page_request_cond);
     current_incoming->page_requested = g_tree_new(page_request_addr_cmp);
 
     migration_object_check(current_migration, &error_fatal);
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 29aea9456d..dbf02cd3ed 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -599,6 +599,30 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
     if (mis->preempt_thread_status == PREEMPT_THREAD_CREATED) {
         /* Notify the fast load thread to quit */
         mis->preempt_thread_status = PREEMPT_THREAD_QUIT;
+        /*
+         * Update preempt_thread_status before reading count.  Note: mutex
+         * lock only provide ACQUIRE semantic, and it doesn't stops this
+         * write to be reordered after reading the count.
+         */
+        smp_mb();
+        /*
+         * It's possible that the preempt thread is still handling the last
+         * pages to arrive which were requested by guest page faults.
+         * Making sure nothing is left behind by waiting on the condvar if
+         * that unlikely case happened.
+         */
+        WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex) {
+            if (qatomic_read(&mis->page_requested_count)) {
+                /*
+                 * It is guaranteed to receive a signal later, because the
+                 * count>0 now, so it's destined to be decreased to zero
+                 * very soon by the preempt thread.
+                 */
+                qemu_cond_wait(&mis->page_request_cond,
+                               &mis->page_request_mutex);
+            }
+        }
+        /* Notify the fast load thread to quit */
         if (mis->postcopy_qemufile_dst) {
             qemu_file_shutdown(mis->postcopy_qemufile_dst);
         }
@@ -1279,6 +1303,17 @@ static int qemu_ufd_copy_ioctl(MigrationIncomingState *mis, void *host_addr,
             g_tree_remove(mis->page_requested, host_addr);
             mis->page_requested_count--;
             trace_postcopy_page_req_del(host_addr, mis->page_requested_count);
+            /* Order the update of count and read of preempt status */
+            smp_mb();
+            if (qatomic_read(&mis->preempt_thread_status) ==
+                PREEMPT_THREAD_QUIT) {
+                /*
+                 * This probably means the main thread is waiting for us.
+                 * Notify that we've finished receiving the last requested
+                 * page.
+                 */
+                qemu_cond_signal(&mis->page_request_cond);
+            }
         }
         qemu_mutex_unlock(&mis->page_request_mutex);
         mark_postcopy_blocktime_end((uintptr_t)host_addr);
-- 
2.41.0


