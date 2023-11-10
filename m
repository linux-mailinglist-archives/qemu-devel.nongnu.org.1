Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 791347E7C39
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 13:39:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1QGl-0008OT-GX; Fri, 10 Nov 2023 07:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r1QGj-0008O9-NC
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 07:05:49 -0500
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r1QGh-0006cg-Av
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 07:05:49 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DEC7E219C8;
 Fri, 10 Nov 2023 12:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699617943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gzd6qkznI0x8Cssy0qMXqVWYBjaJ4DrRnnZNdEXT2lo=;
 b=cjn0HcVjbE9Ek5r7divCdL2/Oux/jcX76N6xZ2xzg6BxpAS53lou+siVMF2fZFqYDBtFPc
 D3Oyyi2ii0CpX9Xk8qA/QvL5ejkDnfoUhC47DNC1FabFjEtMRw6XMJmfZ/pAaRYFcssHcZ
 wJ8x1oOZ94naviaHCsKMrvuteclRcWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699617943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gzd6qkznI0x8Cssy0qMXqVWYBjaJ4DrRnnZNdEXT2lo=;
 b=NaF58m+BjE7zh9wNZKQYW73afRdIatp0EUezS48mrF1HD5EG2bzwpNTqV/+ewIud+qcVxV
 JY5h5yWD1ShL5VCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70F5F138FC;
 Fri, 10 Nov 2023 12:05:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bekJD5ccTmUMEwAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 10 Nov 2023 12:05:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Leonardo
 Bras <leobras@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [RFC PATCH 2/2] migration/multifd: Move semaphore release into
 main thread
In-Reply-To: <ZU0rY662a5C1mvyf@x1n>
References: <20231109165856.15224-1-farosas@suse.de>
 <20231109165856.15224-3-farosas@suse.de> <ZU0rY662a5C1mvyf@x1n>
Date: Fri, 10 Nov 2023 09:05:41 -0300
Message-ID: <87pm0hzucq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Thu, Nov 09, 2023 at 01:58:56PM -0300, Fabiano Rosas wrote:
>> We cannot operate on the multifd semaphores outside of the multifd
>> channel thread
>> because multifd_save_cleanup() can run in parallel and
>> attempt to destroy the mutexes, which causes an assert.
>> 
>> Looking at the places where we use the semaphores aside from the
>> migration thread, there's only the TLS handshake thread and the
>> initial multifd_channel_connect() in the main thread. These are places
>> where creating the multifd channel cannot fail, so releasing the
>> semaphores at these places only serves the purpose of avoiding a
>> deadlock when an error happens before the channel(s) have started, but
>> after the migration thread has already called
>> multifd_send_sync_main().
>> 
>> Instead of attempting to release the semaphores at those places, move
>> the release into multifd_save_cleanup(). This puts the semaphore usage
>> in the same thread that does the cleanup, eliminating the race.
>> 
>> Move the call to multifd_save_cleanup() before joining for the
>> migration thread so we release the semaphores before.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/migration.c |  4 +++-
>>  migration/multifd.c   | 29 +++++++++++------------------
>>  2 files changed, 14 insertions(+), 19 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index cca32c553c..52be20561b 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1300,6 +1300,9 @@ static void migrate_fd_cleanup(MigrationState *s)
>>          QEMUFile *tmp;
>>  
>>          trace_migrate_fd_cleanup();
>> +
>> +        multifd_save_cleanup();
>> +
>>          qemu_mutex_unlock_iothread();
>>          if (s->migration_thread_running) {
>>              qemu_thread_join(&s->thread);
>> @@ -1307,7 +1310,6 @@ static void migrate_fd_cleanup(MigrationState *s)
>>          }
>>          qemu_mutex_lock_iothread();
>>  
>> -        multifd_save_cleanup();
>>          qemu_mutex_lock(&s->qemu_file_lock);
>>          tmp = s->to_dst_file;
>>          s->to_dst_file = NULL;
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index ec58c58082..9ca482cfbe 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -527,6 +527,9 @@ void multifd_save_cleanup(void)
>>  
>>          if (p->running) {
>>              qemu_thread_join(&p->thread);
>> +        } else {
>> +            qemu_sem_post(&p->sem_sync);
>> +            qemu_sem_post(&multifd_send_state->channels_ready);
>
> I think relying on p->running to join the thread is already problematic.
>

Absolutely. I've already complained about this in another thread.

> Now all threads are created with JOINABLE, so we must join them to release
> the thread resources.  Clearing "running" at the end of the thread is
> already wrong to me, because it means if the thread quits before the main
> thread reaching here, we will not join the thread, and the thread resource
> will be leaked.
>
> Here IMHO we should set p->running=true right before thread created, and
> never clear it.  We may even want to rename it to p->thread_created?
>

Ok, let me do that. I already have some patches touching
multifd_new_send_channel_async() due to fixed-ram.

>>          }
>>      }
>>      for (i = 0; i < migrate_multifd_channels(); i++) {
>> @@ -751,8 +754,6 @@ out:
>>          assert(local_err);
>>          trace_multifd_send_error(p->id);
>>          multifd_send_terminate_threads(local_err);
>> -        qemu_sem_post(&p->sem_sync);
>> -        qemu_sem_post(&multifd_send_state->channels_ready);
>>          error_free(local_err);
>>      }
>>  
>> @@ -780,20 +781,15 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
>>  
>>      if (!qio_task_propagate_error(task, &err)) {
>>          trace_multifd_tls_outgoing_handshake_complete(ioc);
>> -        if (multifd_channel_connect(p, ioc, &err)) {
>> -            return;
>> -        }
>> +        multifd_channel_connect(p, ioc, NULL);
>
> Ignoring Error** is not good..
>
> I think you meant to say "it should never fail", then we should put
> &error_abort.  Another cleaner way to do this is split the current
> multifd_channel_connect() into tls and non-tls helpers, then we can call
> the non-tls helpers here (which may not need an Error**).

I attempted the split and it looked awkward, so I let go. But I agree
about the Error.

>> +    } else {
>> +        /*
>> +         * The multifd client could already be waiting to queue data,
>> +         * so let it know that we didn't even start.
>> +         */
>> +        p->quit = true;
>> +        trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
>>      }
>> -
>> -    trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
>> -
>> -    /*
>> -     * Error happen, mark multifd_send_thread status as 'quit' although it
>> -     * is not created, and then tell who pay attention to me.
>> -     */
>> -    p->quit = true;
>> -    qemu_sem_post(&multifd_send_state->channels_ready);
>> -    qemu_sem_post(&p->sem_sync);
>>  }
>>  
>>  static void *multifd_tls_handshake_thread(void *opaque)
>> @@ -862,9 +858,6 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
>>                                               QIOChannel *ioc, Error *err)
>>  {
>>       migrate_set_error(migrate_get_current(), err);
>> -     /* Error happen, we need to tell who pay attention to me */
>> -     qemu_sem_post(&multifd_send_state->channels_ready);
>> -     qemu_sem_post(&p->sem_sync);
>>       /*
>>        * Although multifd_send_thread is not created, but main migration
>>        * thread need to judge whether it is running, so we need to mark
>> -- 
>
> I may still need some more time to digest your whole solution, currently
> not very clear to me.  It may or may not be the patch's problem,
> though.

The core assumption of this patch is that we currently only need to
release the semaphores because the multifd_send_sync_main() is allowed
to execute even before the multifd channels have started. If creation
failed to even start, for instance because of a TLS handshake failure,
the migration thread will hang waiting for channels_ready (or sem_sync).

Then there are two premises:

 - when an error happens, multifd_save_cleanup() is always called;
 
 - a hanging migration thread (at multifd_send_sync_main) will not stop
   the main thread from reaching multifd_save_cleanup.

If this holds, then it's safe to release the semaphores right before
destroying them at multifd_save_cleanup.

> But let me also share how I see this..  I think we should rework the
> multifd thread model on channel establishment.
>
> Firstly, as I mentioned above, we must always join() the threads if it's
> JOINABLE or the resource is leaked, afaict.  That's the first thing to fix.

I think we historically stumbled upon the fact that qemu_thread_join()
is not the same as pthread_join(). The former takes a pointer and is not
safe to call with a NULL QemuThread. That seems to be the reason for the
p->running check before it.

> Then let's see when TLS is there and what we do: we'll create "two" threads
> just for that, what's even worse:
>
>   - We'll create tls handshake thread in multifd_tls_channel_connect()
>     first, setting &p->thread.
>
>   - Within the same thread, we do multifd_tls_outgoing_handshake() when
>     handshake done -> multifd_channel_connect() -> we yet create the real
>     multifd_send_thread(), setting &p->thread too.

Hmm good point, we're calling qio_task_complete() from within the
thread, that's misleading. I believe using qio_task_run_in_thread()
would put the completion callback in the main thread, right? That would
look a bit better I think because we could then join the handshake
thread before multifd_channel_connect().

> So AFAICT, the tls handshake thread is already leaked, got p->thread
> overwritten by the new thread created by itself..
>
> I think we should fix this then.  I haven't figured the best way to do,
> two things I can come up with now:
>
>   1) At least make the tls handshake thread detached.
>
>   2) Make the handshake done in multifd send thread directly; I don't yet
>      see why we must create two threads..

I'm (a little bit) against this. It's nice to know that a multifdsend_#
thread will only be doing IO and no other task. I have the same concern
about putting zero page detection in the multifd thread.

> Then assuming we have a clear model with all these threads issue fixed (no
> matter whether we'd shrink 2N threads into N threads), then what we need to
> do, IMHO, is making sure to join() all of them before destroying anything
> (say, per-channel MultiFDSendParams).  Then when we destroy everything
> safely, either mutex/sem/etc..  Because no one will race us anymore.

This doesn't address the race. There's a data dependency between the
multifd channels and the migration thread around the channels_ready
semaphore. So we cannot join the migration thread because it could be
stuck waiting for the semaphore, which means we cannot join+cleanup the
channel thread because the semaphore is still being used. That's why I'm
moving the semaphores post to the point where we join the
thread. Reading your email, now I think that should be:

qemu_sem_post(&p->sem_sync);
qemu_sem_post(&multifd_send_state->channels_ready);
qemu_thread_join(&p->thread);

Fundamentally, the issue is that we do create the multifd threads before
the migration thread, but they might not be ready before the migration
thread needs to use them.

