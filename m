Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 718937EE68A
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 19:14:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3gs8-0002wM-8k; Thu, 16 Nov 2023 13:13:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r3gs5-0002w9-Mj
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:13:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r3gs3-0006Qy-FE
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:13:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 16A0420507;
 Thu, 16 Nov 2023 18:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700158420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M+jTf1q9UhE2sCSPf8pmFO1G0IpTWW2yMPvxPnoRpxI=;
 b=dpSXSQCx0PzPdVJjQm7BdDjaP08FPLv6Vtoqq7XQ1dAHMSvTAK4ngW9J9Qjqlbp5HgjPKb
 65tUVHg7OMb6U321ech800gZR1wn6g545Adxm7CWaqLfr4qdXAmUTwOm52vN/d8GbNMgJP
 0KWA08RI/gwe7MnWKVC4Myj+J1ERuCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700158420;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M+jTf1q9UhE2sCSPf8pmFO1G0IpTWW2yMPvxPnoRpxI=;
 b=0Aa5wcXw68FasT6VEHv2h43AkgSG7SjK+NcyD2LWyG/zYqcefDTFXqf6hfa7uXafC2EbL5
 0F4Y8439S7RiB3BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4385139C4;
 Thu, 16 Nov 2023 18:13:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wkzlG9NbVmVJMAAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 16 Nov 2023 18:13:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: quintela@redhat.com, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH 2/2] migration/multifd: Move semaphore release into
 main thread
In-Reply-To: <875y21rbke.fsf@secure.mitica>
References: <20231109165856.15224-1-farosas@suse.de>
 <20231109165856.15224-3-farosas@suse.de> <ZU0rY662a5C1mvyf@x1n>
 <875y21rbke.fsf@secure.mitica>
Date: Thu, 16 Nov 2023 15:13:37 -0300
Message-ID: <87jzqhefce.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 CLAM_VIRUS_FAIL(0.00)[failed to scan and retransmits exceed];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.991];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Juan Quintela <quintela@redhat.com> writes:

> Peter Xu <peterx@redhat.com> wrote:
>> On Thu, Nov 09, 2023 at 01:58:56PM -0300, Fabiano Rosas wrote:
>>> We cannot operate on the multifd semaphores outside of the multifd
>>> channel thread
>>> because multifd_save_cleanup() can run in parallel and
>>> attempt to destroy the mutexes, which causes an assert.
>>> 
>>> Looking at the places where we use the semaphores aside from the
>>> migration thread, there's only the TLS handshake thread and the
>>> initial multifd_channel_connect() in the main thread. These are places
>>> where creating the multifd channel cannot fail, so releasing the
>>> semaphores at these places only serves the purpose of avoiding a
>>> deadlock when an error happens before the channel(s) have started, but
>>> after the migration thread has already called
>>> multifd_send_sync_main().
>>> 
>>> Instead of attempting to release the semaphores at those places, move
>>> the release into multifd_save_cleanup(). This puts the semaphore usage
>>> in the same thread that does the cleanup, eliminating the race.
>>> 
>>> Move the call to multifd_save_cleanup() before joining for the
>>> migration thread so we release the semaphores before.
>>> 
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>>  migration/migration.c |  4 +++-
>>>  migration/multifd.c   | 29 +++++++++++------------------
>>>  2 files changed, 14 insertions(+), 19 deletions(-)
>>> 
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index cca32c553c..52be20561b 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -1300,6 +1300,9 @@ static void migrate_fd_cleanup(MigrationState *s)
>>>          QEMUFile *tmp;
>>>  
>>>          trace_migrate_fd_cleanup();
>>> +
>>> +        multifd_save_cleanup();
>>> +
>>>          qemu_mutex_unlock_iothread();
>>>          if (s->migration_thread_running) {
>>>              qemu_thread_join(&s->thread);
>>> @@ -1307,7 +1310,6 @@ static void migrate_fd_cleanup(MigrationState *s)
>>>          }
>>>          qemu_mutex_lock_iothread();
>>>  
>>> -        multifd_save_cleanup();
>>>          qemu_mutex_lock(&s->qemu_file_lock);
>>>          tmp = s->to_dst_file;
>>>          s->to_dst_file = NULL;
>>> diff --git a/migration/multifd.c b/migration/multifd.c
>>> index ec58c58082..9ca482cfbe 100644
>>> --- a/migration/multifd.c
>>> +++ b/migration/multifd.c
>>> @@ -527,6 +527,9 @@ void multifd_save_cleanup(void)
>>>  
>>>          if (p->running) {
>>>              qemu_thread_join(&p->thread);
>>> +        } else {
>>> +            qemu_sem_post(&p->sem_sync);
>>> +            qemu_sem_post(&multifd_send_state->channels_ready);
>>
>> I think relying on p->running to join the thread is already problematic.
>
> Why?

The channel holds resources that need to be freed by
multifd_save_cleanup(). We cannot reliably do so while the channel
itself is the one responsible for telling the main thread whether it is
done with those resources. 

p->running works fine for knowing "has the thread been created", so we
can use it to avoid joining if it was never created. But it is bad for
knowing "is the thread still running" because as soon as the channel
sets p->running=false, multifd_save_cleanup() could attempt to destroy
the p->mutex and the semaphores.

The bug reported in the other series was about this already:

[PATCH] migrate/multifd: fix coredump when the multifd thread cleanup
https://lore.kernel.org/r/20230621081826.3203053-1-zhangjianguo18@huawei.com

>> Now all threads are created with JOINABLE, so we must join them to release
>> the thread resources.  Clearing "running" at the end of the thread is
>> already wrong to me, because it means if the thread quits before the main
>> thread reaching here, we will not join the thread, and the thread resource
>> will be leaked.
>
> The bug is that the thread quits from other place.
> It is not different that forgetting to do a mutex_unlock().  It is an
> error that needs fixing.  
>
>> Here IMHO we should set p->running=true right before thread created,
>
> (that is basically what is done)
>
> Meaning of ->running is that multifd thread has started running.  it a
> false is that it is not running normally anymore.

The issue is that multifd_save_cleanup looks at p->running = false and
continues with the cleanup that destroys the mutex while the TLS thread
might be using it.

>
> thread function:
>
>> and never clear it.
>
> static void *multifd_send_thread(void *opaque)
> {
>     // No error can happens here
>
>     while (true) {
>     // No return command here, just breaks
>     }
>
> out:
>     // This can fail
>
>     qemu_mutex_lock(&p->mutex);
>     p->running = false;
>     qemu_mutex_unlock(&p->mutex);
>
>     /* this can't fail */
>
>     return NULL;
> }
>
>
> What running here means is that we don't need to "stop" this thread
> anymore.  That happens as soon as we get out of the loop.
>
>>  We may even want to rename it to p->thread_created?
>
> We can rename it, but I am not sure if it buys it too much.  Notice that
> we also mean that we have created the channel.
>
>>
>>>          }
>>>      }
>>>      for (i = 0; i < migrate_multifd_channels(); i++) {
>>> @@ -751,8 +754,6 @@ out:
>>>          assert(local_err);
>>>          trace_multifd_send_error(p->id);
>>>          multifd_send_terminate_threads(local_err);
>>> -        qemu_sem_post(&p->sem_sync);
>>> -        qemu_sem_post(&multifd_send_state->channels_ready);
>>>          error_free(local_err);
>>>      }
>>>  
>>> @@ -780,20 +781,15 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
>>>  
>>>      if (!qio_task_propagate_error(task, &err)) {
>>>          trace_multifd_tls_outgoing_handshake_complete(ioc);
>>> -        if (multifd_channel_connect(p, ioc, &err)) {
>>> -            return;
>>> -        }
>>> +        multifd_channel_connect(p, ioc, NULL);
>>
>> Ignoring Error** is not good..
>>
>> I think you meant to say "it should never fail", then we should put
>> &error_abort.  Another cleaner way to do this is split the current
>> multifd_channel_connect() into tls and non-tls helpers, then we can call
>> the non-tls helpers here (which may not need an Error**).
>
> This code is really weird because it is (very) asynchronous.
> And TLS is even worse, because we need to do the equilent of two
> listen().
> Sniff.
>
>>> +    } else {
>>> +        /*
>>> +         * The multifd client could already be waiting to queue data,
>>> +         * so let it know that we didn't even start.
>>> +         */
>>> +        p->quit = true;
>>> +        trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
>>>      }
>>> -
>>> -    trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
>>> -
>>> -    /*
>>> -     * Error happen, mark multifd_send_thread status as 'quit' although it
>>> -     * is not created, and then tell who pay attention to me.
>>> -     */
>>> -    p->quit = true;
>>> -    qemu_sem_post(&multifd_send_state->channels_ready);
>>> -    qemu_sem_post(&p->sem_sync);
>>>  }
>>>  
>>>  static void *multifd_tls_handshake_thread(void *opaque)
>>> @@ -862,9 +858,6 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
>>>                                               QIOChannel *ioc, Error *err)
>>>  {
>>>       migrate_set_error(migrate_get_current(), err);
>>> -     /* Error happen, we need to tell who pay attention to me */
>>> -     qemu_sem_post(&multifd_send_state->channels_ready);
>>> -     qemu_sem_post(&p->sem_sync);
>>>       /*
>>>        * Although multifd_send_thread is not created, but main migration
>>>        * thread need to judge whether it is running, so we need to mark
>>> -- 
>>
>> I may still need some more time to digest your whole solution, currently
>> not very clear to me.  It may or may not be the patch's problem, though.
>>
>> But let me also share how I see this..  I think we should rework the
>> multifd thread model on channel establishment.
>>
>> Firstly, as I mentioned above, we must always join() the threads if it's
>> JOINABLE or the resource is leaked, afaict.  That's the first thing to fix.
>
> The problem that running is trying to fix is this:
> * we get an additional error while we are exiting due to any reason.
>
> So we end calling multifd_fd_cleanup() several times, and things get
> really weird.
>
> So what we really need is to be sure that:
> - we join each thread once and only once
>
> 	https://linux.die.net/man/3/pthread_join
>
> 	Joining with a thread that has previously been joined results in undefined behavior.
>

I don't see how we would call multifd_save_cleanup() more than once. The
qemu_mutex_destroy() calls in the loop below would already assert if
called twice.

>> Then let's see when TLS is there and what we do: we'll create "two" threads
>> just for that, what's even worse:
>>
>>   - We'll create tls handshake thread in multifd_tls_channel_connect()
>>     first, setting &p->thread.
>>
>>   - Within the same thread, we do multifd_tls_outgoing_handshake() when
>>     handshake done -> multifd_channel_connect() -> we yet create the real
>>     multifd_send_thread(), setting &p->thread too.
>>
>> So AFAICT, the tls handshake thread is already leaked, got p->thread
>> overwritten by the new thread created by itself..
>>
>> I think we should fix this then.  I haven't figured the best way to do,
>> two things I can come up with now:
>>
>>   1) At least make the tls handshake thread detached.
>>
>>   2) Make the handshake done in multifd send thread directly; I don't yet
>>      see why we must create two threads..
>
> The way we listen() in sockets anynchronously. QIO channels are a
> mystery to me, and this was really weird.
>
> Using glib_main_loop() has lots of advantages.  Understanding how to
> listen asynchronously is not one of them.
>
>> Then assuming we have a clear model with all these threads issue fixed (no
>> matter whether we'd shrink 2N threads into N threads), then what we need to
>> do, IMHO, is making sure to join() all of them before destroying anything
>> (say, per-channel MultiFDSendParams).  Then when we destroy everything
>> safely, either mutex/sem/etc..  Because no one will race us anymore.
>
>> Would it make sense?
>
> I can't see why we need to join the threads created for tls.  That ones
> could be not joinable and just call it a day.

From the perspective of this series, we just need to be sure
multifd_tls_outgoing_handshake() never runs in parallel with
multifd_save_cleanup(). Joining the thread would be one way to do that.

