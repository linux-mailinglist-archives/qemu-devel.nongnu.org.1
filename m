Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 805B37EE376
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 15:58:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3dnj-0006w6-JK; Thu, 16 Nov 2023 09:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r3dng-0006pz-9c
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 09:57:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r3dnc-0007NH-3S
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 09:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700146614;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9jWPSJXUOvUVWJ+5onFsSXMr9DKWWU2/1FVEG5/vOZg=;
 b=hquxEQ+Wlniyc3cEeipPB+YqAX7mD5uOhKTniu+wR7lqoEmRfK+ncCPOTuY+NZYSDU/0x6
 X2cVcOjhNjTzYgElKMQXoWJyuoXsOtIR9PYR5GfNKJaKhYkNiKdvc0Swj3wxOWgUXX1/Ux
 AEsLL/KJBfT2VhHqRuP6QMyVPkSvxO0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-iunbSfpfOi2NmzDvj0CGBQ-1; Thu, 16 Nov 2023 09:56:52 -0500
X-MC-Unique: iunbSfpfOi2NmzDvj0CGBQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40a5290de84so5174125e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 06:56:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700146611; x=1700751411;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9jWPSJXUOvUVWJ+5onFsSXMr9DKWWU2/1FVEG5/vOZg=;
 b=uQpvowhY0jAt0HCGDBYnvPnIj8NJLBab4JaP3PY2hiTj1QuNUPgQTf0rPAsikTYeBI
 ylCLnAcR4mqHyMWNiLK6Lg97+q0pf7agA7u5ioHUOBLpBXRYZnF5GSshJLQjM0TTtaaV
 5ijhUQqsNxBZLwRKKQQbvWm67fttDKEn/LCnGK6HymSedimoPoETwTFjIIN9gVCdCxtT
 vRpSNrll7VE+aYyzw88rD/O1zHmsyZ9YSTCbuD+eL4FivYg2zGrCIthx8TEJ3XxrrOcW
 9PAIfZdkt46YpbaEPhPkQgX7lAxOoELU9COcqvPQ+LsnYlYaq/BaHJPgzLQjgoZTmTHV
 zrtA==
X-Gm-Message-State: AOJu0YyT8bsR9lgZCSWbwVlb/eUvrVDJyHJBqyC3N92KycSXzvmQX26h
 Qc1gEnF6mCRcY+AvIdGT6UZp6LdTHo70fj2IRyj3YKtV/tabuI0s5p85W4LF9bcsa2kvPt0ST56
 9aIki5flhkF6KpFoq438i/7vgcQ==
X-Received: by 2002:a05:600c:450a:b0:409:375:5a44 with SMTP id
 t10-20020a05600c450a00b0040903755a44mr13851587wmo.24.1700146611170; 
 Thu, 16 Nov 2023 06:56:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGW43Uzexvd9e9aXmmcZTNfR4pdOjOtNxIlmY79qORa2XUVcQN7XFaOUghzq0dEHqagtnhwpw==
X-Received: by 2002:a05:600c:450a:b0:409:375:5a44 with SMTP id
 t10-20020a05600c450a00b0040903755a44mr13851564wmo.24.1700146610670; 
 Thu, 16 Nov 2023 06:56:50 -0800 (PST)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 z17-20020a1c4c11000000b0040a44179a88sm3796791wmf.42.2023.11.16.06.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 06:56:50 -0800 (PST)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  qemu-devel@nongnu.org,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [RFC PATCH 2/2] migration/multifd: Move semaphore release into
 main thread
In-Reply-To: <ZU0rY662a5C1mvyf@x1n> (Peter Xu's message of "Thu, 9 Nov 2023
 13:56:35 -0500")
References: <20231109165856.15224-1-farosas@suse.de>
 <20231109165856.15224-3-farosas@suse.de> <ZU0rY662a5C1mvyf@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 16 Nov 2023 15:56:49 +0100
Message-ID: <875y21rbke.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
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

Why?

> Now all threads are created with JOINABLE, so we must join them to release
> the thread resources.  Clearing "running" at the end of the thread is
> already wrong to me, because it means if the thread quits before the main
> thread reaching here, we will not join the thread, and the thread resource
> will be leaked.

The bug is that the thread quits from other place.
It is not different that forgetting to do a mutex_unlock().  It is an
error that needs fixing.  

> Here IMHO we should set p->running=true right before thread created,

(that is basically what is done)

Meaning of ->running is that multifd thread has started running.  it a
false is that it is not running normally anymore.

thread function:

> and never clear it.

static void *multifd_send_thread(void *opaque)
{
    // No error can happens here

    while (true) {
    // No return command here, just breaks
    }

out:
    // This can fail

    qemu_mutex_lock(&p->mutex);
    p->running = false;
    qemu_mutex_unlock(&p->mutex);

    /* this can't fail */

    return NULL;
}


What running here means is that we don't need to "stop" this thread
anymore.  That happens as soon as we get out of the loop.

>  We may even want to rename it to p->thread_created?

We can rename it, but I am not sure if it buys it too much.  Notice that
we also mean that we have created the channel.

>
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

This code is really weird because it is (very) asynchronous.
And TLS is even worse, because we need to do the equilent of two
listen().
Sniff.

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
> not very clear to me.  It may or may not be the patch's problem, though.
>
> But let me also share how I see this..  I think we should rework the
> multifd thread model on channel establishment.
>
> Firstly, as I mentioned above, we must always join() the threads if it's
> JOINABLE or the resource is leaked, afaict.  That's the first thing to fix.

The problem that running is trying to fix is this:
* we get an additional error while we are exiting due to any reason.

So we end calling multifd_fd_cleanup() several times, and things get
really weird.

So what we really need is to be sure that:
- we join each thread once and only once

	https://linux.die.net/man/3/pthread_join

	Joining with a thread that has previously been joined results in undefined behavior.


> Then let's see when TLS is there and what we do: we'll create "two" threads
> just for that, what's even worse:
>
>   - We'll create tls handshake thread in multifd_tls_channel_connect()
>     first, setting &p->thread.
>
>   - Within the same thread, we do multifd_tls_outgoing_handshake() when
>     handshake done -> multifd_channel_connect() -> we yet create the real
>     multifd_send_thread(), setting &p->thread too.
>
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

The way we listen() in sockets anynchronously. QIO channels are a
mystery to me, and this was really weird.

Using glib_main_loop() has lots of advantages.  Understanding how to
listen asynchronously is not one of them.

> Then assuming we have a clear model with all these threads issue fixed (no
> matter whether we'd shrink 2N threads into N threads), then what we need to
> do, IMHO, is making sure to join() all of them before destroying anything
> (say, per-channel MultiFDSendParams).  Then when we destroy everything
> safely, either mutex/sem/etc..  Because no one will race us anymore.

> Would it make sense?

I can't see why we need to join the threads created for tls.  That ones
could be not joinable and just call it a day.

Later, Juan.


