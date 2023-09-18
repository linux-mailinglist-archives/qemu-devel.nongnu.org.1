Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1DB7A4B01
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:17:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiF2m-0003j4-Qq; Mon, 18 Sep 2023 10:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiF2k-0003i3-Ld
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:16:06 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiF2h-00060K-PM
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:16:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 779951FF2C;
 Mon, 18 Sep 2023 14:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695046560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XMHl5dtm/rG80C50ZL2fH+KQFPi/bCpqLul3PPki6bw=;
 b=j/jOY1kctS1Qs7VnMV8CQoDljqwi7Ovu1uLIw160vi7zqExRdsVW+lTlCFXnp61cKjA+qR
 +yGeRBIlQtHxMo66vt65RjZZhuJZkVqzRlBK+9uocmpZLLnYL1+4r8FPUdLW08FpShY018
 SRPRetMNkCieTLpv5QIDfVxKtDaRg9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695046560;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XMHl5dtm/rG80C50ZL2fH+KQFPi/bCpqLul3PPki6bw=;
 b=cloz6Mwd5DEBrUJnmyc8sF1qx83LujXrUR6S/sQkigbtQR1LldHC+qIQSKi3RKLPhqkQzc
 N4BzFmCNpF0ob5DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06EF813480;
 Mon, 18 Sep 2023 14:15:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SrxqMZ9bCGVAMQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 18 Sep 2023 14:15:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: QEMU migration-test CI intermittent failure
In-Reply-To: <ZQSMekgtg5kIPl2H@x1n>
References: <ZQMfIO3oiqTsawtU@x1n> <87edj0kcz7.fsf@suse.de>
 <ZQMoUzRH1BZKs39g@x1n> <87bke4kasr.fsf@suse.de> <ZQM3SV4eqSltoQSe@x1n>
 <87led8e9vv.fsf@suse.de> <87r0n0nz6u.fsf@suse.de> <ZQOW4BS1ZcDTN7tK@x1n>
 <87o7i4nqrc.fsf@suse.de> <ZQSGNDn2gg5if8ie@x1n> <ZQSMekgtg5kIPl2H@x1n>
Date: Mon, 18 Sep 2023 11:15:57 -0300
Message-ID: <878r931s9u.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Sep 15, 2023 at 12:28:36PM -0400, Peter Xu wrote:
>> On Thu, Sep 14, 2023 at 10:56:23PM -0300, Fabiano Rosas wrote:
>> > Peter Xu <peterx@redhat.com> writes:
>> > 
>> > > On Thu, Sep 14, 2023 at 07:54:17PM -0300, Fabiano Rosas wrote:
>> > >> Fabiano Rosas <farosas@suse.de> writes:
>> > >> 
>> > >> > Peter Xu <peterx@redhat.com> writes:
>> > >> >
>> > >> >> On Thu, Sep 14, 2023 at 12:57:08PM -0300, Fabiano Rosas wrote:
>> > >> >>> I managed to reproduce it. It's not the return path error. In hindsight
>> > >> >>> that's obvious because that error happens in the 'recovery' test and this
>> > >> >>> one in the 'plain' one. Sorry about the noise.
>> > >> >>
>> > >> >> No worry.  It's good to finally identify that.
>> > >> >>
>> > >> >>> 
>> > >> >>> This one reproduced with just 4 iterations of preempt/plain. I'll
>> > >> >>> investigate.
>> > >> >
>> > >> > It seems that we're getting a tcp disconnect (ECONNRESET) on when doing
>> > >> > that shutdown() on postcopy_qemufile_src. The one from commit 6621883f93
>> > >> > ("migration: Fix potential race on postcopy_qemufile_src").
>> > >> >
>> > >> > I'm trying to determine why that happens when other times it just
>> > >> > returns 0 as expected.
>> > >> >
>> > >> > Could this mean that we're kicking the dest too soon while it is still
>> > >> > receiving valid data?
>> > >> 
>> > >> Looking a bit more into this, what's happening is that
>> > >> postcopy_ram_incoming_cleanup() is shutting the postcopy_qemufile_dst
>> > >> while ram_load_postcopy() is still running.
>> > >> 
>> > >> The postcopy_ram_listen_thread() function waits for the
>> > >> main_thread_load_event, but that only works when not using preempt. With
>> > >> the preempt thread, the event is set right away and we proceed to do the
>> > >> cleanup without waiting.
>> > >> 
>> > >> So the assumption of commit 6621883f93 that the incoming side knows when
>> > >> it has finished migrating is wrong IMO. Without the EOS we're relying on
>> > >> the chance that the shutdown() happens after the last recvmsg has
>> > >> returned and not during it.
>> > >> 
>> > >> Peter, what do you think?
>> > >
>> > > That's a good point.
>> > >
>> > > One thing to verify that (sorry, I still cannot reproduce it myself, which
>> > > is so weirdly... it seems loads won't really help reproducing this) is to
>> > > let the main thread wait for all requested pages to arrive:
>> > >
>> > > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> > > index 29aea9456d..df055c51ea 100644
>> > > --- a/migration/postcopy-ram.c
>> > > +++ b/migration/postcopy-ram.c
>> > > @@ -597,6 +597,12 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
>> > >      trace_postcopy_ram_incoming_cleanup_entry();
>> > >  
>> > >      if (mis->preempt_thread_status == PREEMPT_THREAD_CREATED) {
>> > > +        /*
>> > > +         * NOTE!  it's possible that the preempt thread is still handling
>> > > +         * the last pages to arrive which were requested by faults.  Making
>> > > +         * sure nothing is left behind.
>> > > +         */
>> > > +        while (qatomic_read(&mis->page_requested_count));
>> > >          /* Notify the fast load thread to quit */
>> > >          mis->preempt_thread_status = PREEMPT_THREAD_QUIT;
>> > >          if (mis->postcopy_qemufile_dst) {
>> > >
>> > > If that can work solidly, we can figure out a better way than a dead loop
>> > > here.
>> > 
>> > Yep, 2000+ iterations so far and no error.
>> 
>> Definitely good news.. thanks.
>> 
>> > 
>> > Should we add something that makes ram_load_postcopy return once it's
>> > finished? Then this code could just set PREEMPT_THREAD_QUIT and join the
>> > preempt thread.
>> 
>> Yeah it'll be nice to have that. We used to have an EOS message at the end
>> for the preempt channel, but that used to cause another race (which IIRC I
>> could easily reproduce at that time) and we removed it after
>> 6621883f9398bc3 for 7.2+.
>> 
>> Now instead of fiddling with the protocol again, we do have a way to detect
>> that, but it may need some trick on counting on page_requested_count and
>> also provide a signal mechanism.
>> 
>> I've drafted one solution here and attached here as a complete patch, feel
>> free to try.  If you have anything better, that'll be even nicer; just let
>> me know your thoughts.
>> 
>> ---8<---
>> From 384aff2264650872e15916dcfeaec593e5e9b781 Mon Sep 17 00:00:00 2001
>> From: Peter Xu <peterx@redhat.com>
>> Date: Fri, 15 Sep 2023 12:11:34 -0400
>> Subject: [PATCH] migration: Fix race that dest preempt thread close too early
>> 
>> We hit intermit CI issue on failing at migration-test over the unit test
>> preempt/plain:
>> 
>> qemu-system-x86_64: Unable to read from socket: Connection reset by peer
>> Memory content inconsistency at 5b43000 first_byte = bd last_byte = bc current = 4f hit_edge = 1
>> **
>> ERROR:../tests/qtest/migration-test.c:300:check_guests_ram: assertion failed: (bad == 0)
>> (test program exited with status code -6)
>> 
>> Fabiano debugged into it and found that the preempt thread can quit even
>> without receiving all the pages, which can cause guest not receiving all
>> the pages and corrupt the guest memory.
>> 
>> To make sure preempt thread finished receiving all the pages, we can rely
>> on the page_requested_count being zero because preempt channel will only
>> receive requested page faults. Note, not all the faulted pages are required
>> to be sent via the preempt channel/thread; imagine the case when a
>> requested page is just queued into the background main channel for
>> migration, the src qemu will just still send it via the background channel.
>> 
>> Here instead of spinning over reading the count, we add a condvar so the
>> main thread can wait on it if that unusual case happened, without burning
>> the cpu for no good reason, even if the duration is short; so even if we
>> spin in this rare case is probably fine.  It's just better to not do so.
>> 
>> The condvar is only used when that special case is triggered.  Some memory
>> ordering trick is needed to guarantee it from happening (against the
>> preempt thread status field), so the main thread will always get a kick
>> when that triggers correctly.
>> 
>> Closes: https://gitlab.com/qemu-project/qemu/-/issues/1886
>> Debugged-by: Fabiano Rosas <farosas@suse.de>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>  migration/migration.h    | 13 ++++++++++++-
>>  migration/migration.c    |  1 +
>>  migration/postcopy-ram.c | 35 +++++++++++++++++++++++++++++++++++
>>  3 files changed, 48 insertions(+), 1 deletion(-)
>> 
>> diff --git a/migration/migration.h b/migration/migration.h
>> index c390500604..cdaa10d515 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -196,7 +196,10 @@ struct MigrationIncomingState {
>>  
>>      /* A tree of pages that we requested to the source VM */
>>      GTree *page_requested;
>> -    /* For debugging purpose only, but would be nice to keep */
>> +    /*
>> +     * For postcopy only, count the number of requested page faults that
>> +     * still haven't been resolved.
>> +     */
>>      int page_requested_count;
>>      /*
>>       * The mutex helps to maintain the requested pages that we sent to the
>> @@ -210,6 +213,14 @@ struct MigrationIncomingState {
>>       * contains valid information.
>>       */
>>      QemuMutex page_request_mutex;
>> +    /*
>> +     * If postcopy preempt is enabled, there is a chance that the main
>> +     * thread finished loading its data before the preempt channel has
>> +     * finished loading the urgent pages.  If that happens, the two threads
>> +     * will use this condvar to synchronize, so the main thread will always
>> +     * wait until all pages received.
>> +     */
>> +    QemuCond page_request_cond;
>>  
>>      /*
>>       * Number of devices that have yet to approve switchover. When this reaches
>> diff --git a/migration/migration.c b/migration/migration.c
>> index d61e572742..e86b3f7368 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -153,6 +153,7 @@ void migration_object_init(void)
>>      qemu_sem_init(&current_incoming->postcopy_qemufile_dst_done, 0);
>>  
>>      qemu_mutex_init(&current_incoming->page_request_mutex);
>> +    qemu_cond_init(&current_incoming->page_request_cond);
>>      current_incoming->page_requested = g_tree_new(page_request_addr_cmp);
>>  
>>      migration_object_check(current_migration, &error_fatal);
>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> index 29aea9456d..dbf02cd3ed 100644
>> --- a/migration/postcopy-ram.c
>> +++ b/migration/postcopy-ram.c
>> @@ -599,6 +599,30 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
>>      if (mis->preempt_thread_status == PREEMPT_THREAD_CREATED) {
>>          /* Notify the fast load thread to quit */
>>          mis->preempt_thread_status = PREEMPT_THREAD_QUIT;
>> +        /*
>> +         * Update preempt_thread_status before reading count.  Note: mutex
>> +         * lock only provide ACQUIRE semantic, and it doesn't stops this
>> +         * write to be reordered after reading the count.
>> +         */
>> +        smp_mb();
>> +        /*
>> +         * It's possible that the preempt thread is still handling the last
>> +         * pages to arrive which were requested by guest page faults.
>> +         * Making sure nothing is left behind by waiting on the condvar if
>> +         * that unlikely case happened.
>> +         */
>> +        WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex) {
>> +            if (qatomic_read(&mis->page_requested_count)) {
>> +                /*
>> +                 * It is guaranteed to receive a signal later, because the
>> +                 * count>0 now, so it's destined to be decreased to zero
>> +                 * very soon by the preempt thread.
>> +                 */
>> +                qemu_cond_wait(&mis->page_request_cond,
>> +                               &mis->page_request_mutex);
>> +            }
>> +        }
>> +        /* Notify the fast load thread to quit */
>>          if (mis->postcopy_qemufile_dst) {
>>              qemu_file_shutdown(mis->postcopy_qemufile_dst);
>>          }
>> @@ -1279,6 +1303,17 @@ static int qemu_ufd_copy_ioctl(MigrationIncomingState *mis, void *host_addr,
>>              g_tree_remove(mis->page_requested, host_addr);
>>              mis->page_requested_count--;
>>              trace_postcopy_page_req_del(host_addr, mis->page_requested_count);
>> +            /* Order the update of count and read of preempt status */
>> +            smp_mb();
>> +            if (qatomic_read(&mis->preempt_thread_status) ==
>> +                PREEMPT_THREAD_QUIT) {
>> +                /*
>> +                 * This probably means the main thread is waiting for us.
>> +                 * Notify that we've finished receiving the last requested
>> +                 * page.
>> +                 */
>> +                qemu_cond_signal(&mis->page_request_cond);
>> +            }
>>          }
>>          qemu_mutex_unlock(&mis->page_request_mutex);
>>          mark_postcopy_blocktime_end((uintptr_t)host_addr);
>> -- 
>> 2.41.0
>
> I just made some changes on top of this patch..
>
> One major thing is to double check we only kick main thread only if it's
> the last page, as I think there can be >1 pages on the fly..
>
> Since at it, I cleaned up a bit on accessing either the preempt status
> field or the counter, to make it always consistent (always not use atomic
> ops for status as it's defined as volatile anyway; meanwhile always use
> qatomic for the counter).
>
> ---8<---
> From bfdd1f872fbeafe26ebad280a6d9e5a88de621de Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Fri, 15 Sep 2023 12:45:01 -0400
> Subject: [PATCH] fixup! migration: Fix race that dest preempt thread close too
>  early
>
> Three more small changes:
>
>   - Always use qatomic_* for page_requested_count accesses
>   - only kick main thread when we're sure it's the last page
>   - drop qatomic_read() on reading preempt status, to make it match use
>     cases elsewhere, not needed when defined as volatile already
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c    | 2 +-
>  migration/postcopy-ram.c | 7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index e86b3f7368..3ee1e6b0d6 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -368,7 +368,7 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis,
>               * things like g_tree_lookup() will return TRUE (1) when found.
>               */
>              g_tree_insert(mis->page_requested, aligned, (gpointer)1);
> -            mis->page_requested_count++;
> +            qatomic_inc(&mis->page_requested_count);
>              trace_postcopy_page_req_add(aligned, mis->page_requested_count);
>          }
>      }
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index dbf02cd3ed..5408e028c6 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1301,12 +1301,13 @@ static int qemu_ufd_copy_ioctl(MigrationIncomingState *mis, void *host_addr,
>           */
>          if (g_tree_lookup(mis->page_requested, host_addr)) {
>              g_tree_remove(mis->page_requested, host_addr);
> -            mis->page_requested_count--;
> +            int left_pages = qatomic_dec_fetch(&mis->page_requested_count);
> +
>              trace_postcopy_page_req_del(host_addr, mis->page_requested_count);
>              /* Order the update of count and read of preempt status */
>              smp_mb();
> -            if (qatomic_read(&mis->preempt_thread_status) ==
> -                PREEMPT_THREAD_QUIT) {
> +            if (mis->preempt_thread_status == PREEMPT_THREAD_QUIT &&
> +                left_pages == 0) {
>                  /*
>                   * This probably means the main thread is waiting for us.
>                   * Notify that we've finished receiving the last requested
> -- 
> 2.41.0

This fixes the issue. It looks ok to me. Do you want me to send a separate patch with it?

