Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 713517E71D0
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 19:58:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1ADI-0001NC-Uw; Thu, 09 Nov 2023 13:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r1AD9-0001Ko-Bl
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:57:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r1ACz-0006kj-6y
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699556205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uqpvXNaqU9hWOGfsQpvKqFrfIoxZqrSfyOeru19d2pw=;
 b=aUGx8Xq9+Irv7lG+6t1ewGLC/dv30EThj1MqMaJx/QFAwq2sZqqAYCfSORbs3Kv6snRE+/
 8+oSQamE79ABQIbfulaco1cDhw3DsDlsGZD74FvbSrJcj8AKqnAKdua+jpr0aORuJpEWor
 RchM7c7w/jacwHrpJBT+SIzyi3kV7pk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-BzcaI9jpNh6Tk7l4G3t-tw-1; Thu, 09 Nov 2023 13:56:39 -0500
X-MC-Unique: BzcaI9jpNh6Tk7l4G3t-tw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6755f01ca7dso2935936d6.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 10:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699556198; x=1700160998;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uqpvXNaqU9hWOGfsQpvKqFrfIoxZqrSfyOeru19d2pw=;
 b=WaPijl87GYfeEDbHuxqzi2IrvLWR+zqkDbundw7CnqwaJQ9+CHdFGmG3ed4Xp01WSP
 z3c9c59Kqca8h2ZC7klhkgprrfCDwZAT+ab4IeYvWlst7s4n0B/V4im3/pezuBzGb5RI
 tgfP0TnqdppRls3wz6fhl6Z3UgeyDPZP5Uu+7jwXOJV6DBbv6ki0FIMM5G5YQQJ+kreP
 Qi2WAPeToityAdhhNT5JKivM7ifmV14COdU81orzwKTh7FWU4X8fJ6oH/T3g+HjJj1NO
 TF4MCAfwlHjp4AbU3dbkzh30YGVyiADBtWcdWlrQQJJMWhgJTsjNK7Upa9UnYBYZVtFi
 HilA==
X-Gm-Message-State: AOJu0Yw//ZBmIXHubx/TU1vjZmOBJvzSipjAQv1d+KgBtN5UZvNt7Y07
 7OkgMINzgN7AyYx94+rXfGb9fEMXsN0eoBTZcBYWl2I+4mcgMyS7KEeXfWF9/0VvQpuftNRH241
 kzehKvQewhqXsGpI=
X-Received: by 2002:a0c:e5c8:0:b0:66d:6111:5c5c with SMTP id
 u8-20020a0ce5c8000000b0066d61115c5cmr5639269qvm.3.1699556197684; 
 Thu, 09 Nov 2023 10:56:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcSJPvu4TKYCCAQH5rZx8Qw6aLo7hLNY9kmNxow2Gg3DYtY5pqD1pBR+hPJj9QVRWTumYxJQ==
X-Received: by 2002:a0c:e5c8:0:b0:66d:6111:5c5c with SMTP id
 u8-20020a0ce5c8000000b0066d61115c5cmr5639257qvm.3.1699556197360; 
 Thu, 09 Nov 2023 10:56:37 -0800 (PST)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 b6-20020a0cfe66000000b0066d1348bdddsm2306941qvv.44.2023.11.09.10.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 10:56:37 -0800 (PST)
Date: Thu, 9 Nov 2023 13:56:35 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH 2/2] migration/multifd: Move semaphore release into
 main thread
Message-ID: <ZU0rY662a5C1mvyf@x1n>
References: <20231109165856.15224-1-farosas@suse.de>
 <20231109165856.15224-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109165856.15224-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Nov 09, 2023 at 01:58:56PM -0300, Fabiano Rosas wrote:
> We cannot operate on the multifd semaphores outside of the multifd
> channel thread
> because multifd_save_cleanup() can run in parallel and
> attempt to destroy the mutexes, which causes an assert.
> 
> Looking at the places where we use the semaphores aside from the
> migration thread, there's only the TLS handshake thread and the
> initial multifd_channel_connect() in the main thread. These are places
> where creating the multifd channel cannot fail, so releasing the
> semaphores at these places only serves the purpose of avoiding a
> deadlock when an error happens before the channel(s) have started, but
> after the migration thread has already called
> multifd_send_sync_main().
> 
> Instead of attempting to release the semaphores at those places, move
> the release into multifd_save_cleanup(). This puts the semaphore usage
> in the same thread that does the cleanup, eliminating the race.
> 
> Move the call to multifd_save_cleanup() before joining for the
> migration thread so we release the semaphores before.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c |  4 +++-
>  migration/multifd.c   | 29 +++++++++++------------------
>  2 files changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index cca32c553c..52be20561b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1300,6 +1300,9 @@ static void migrate_fd_cleanup(MigrationState *s)
>          QEMUFile *tmp;
>  
>          trace_migrate_fd_cleanup();
> +
> +        multifd_save_cleanup();
> +
>          qemu_mutex_unlock_iothread();
>          if (s->migration_thread_running) {
>              qemu_thread_join(&s->thread);
> @@ -1307,7 +1310,6 @@ static void migrate_fd_cleanup(MigrationState *s)
>          }
>          qemu_mutex_lock_iothread();
>  
> -        multifd_save_cleanup();
>          qemu_mutex_lock(&s->qemu_file_lock);
>          tmp = s->to_dst_file;
>          s->to_dst_file = NULL;
> diff --git a/migration/multifd.c b/migration/multifd.c
> index ec58c58082..9ca482cfbe 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -527,6 +527,9 @@ void multifd_save_cleanup(void)
>  
>          if (p->running) {
>              qemu_thread_join(&p->thread);
> +        } else {
> +            qemu_sem_post(&p->sem_sync);
> +            qemu_sem_post(&multifd_send_state->channels_ready);

I think relying on p->running to join the thread is already problematic.

Now all threads are created with JOINABLE, so we must join them to release
the thread resources.  Clearing "running" at the end of the thread is
already wrong to me, because it means if the thread quits before the main
thread reaching here, we will not join the thread, and the thread resource
will be leaked.

Here IMHO we should set p->running=true right before thread created, and
never clear it.  We may even want to rename it to p->thread_created?

>          }
>      }
>      for (i = 0; i < migrate_multifd_channels(); i++) {
> @@ -751,8 +754,6 @@ out:
>          assert(local_err);
>          trace_multifd_send_error(p->id);
>          multifd_send_terminate_threads(local_err);
> -        qemu_sem_post(&p->sem_sync);
> -        qemu_sem_post(&multifd_send_state->channels_ready);
>          error_free(local_err);
>      }
>  
> @@ -780,20 +781,15 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
>  
>      if (!qio_task_propagate_error(task, &err)) {
>          trace_multifd_tls_outgoing_handshake_complete(ioc);
> -        if (multifd_channel_connect(p, ioc, &err)) {
> -            return;
> -        }
> +        multifd_channel_connect(p, ioc, NULL);

Ignoring Error** is not good..

I think you meant to say "it should never fail", then we should put
&error_abort.  Another cleaner way to do this is split the current
multifd_channel_connect() into tls and non-tls helpers, then we can call
the non-tls helpers here (which may not need an Error**).

> +    } else {
> +        /*
> +         * The multifd client could already be waiting to queue data,
> +         * so let it know that we didn't even start.
> +         */
> +        p->quit = true;
> +        trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
>      }
> -
> -    trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
> -
> -    /*
> -     * Error happen, mark multifd_send_thread status as 'quit' although it
> -     * is not created, and then tell who pay attention to me.
> -     */
> -    p->quit = true;
> -    qemu_sem_post(&multifd_send_state->channels_ready);
> -    qemu_sem_post(&p->sem_sync);
>  }
>  
>  static void *multifd_tls_handshake_thread(void *opaque)
> @@ -862,9 +858,6 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
>                                               QIOChannel *ioc, Error *err)
>  {
>       migrate_set_error(migrate_get_current(), err);
> -     /* Error happen, we need to tell who pay attention to me */
> -     qemu_sem_post(&multifd_send_state->channels_ready);
> -     qemu_sem_post(&p->sem_sync);
>       /*
>        * Although multifd_send_thread is not created, but main migration
>        * thread need to judge whether it is running, so we need to mark
> -- 

I may still need some more time to digest your whole solution, currently
not very clear to me.  It may or may not be the patch's problem, though.

But let me also share how I see this..  I think we should rework the
multifd thread model on channel establishment.

Firstly, as I mentioned above, we must always join() the threads if it's
JOINABLE or the resource is leaked, afaict.  That's the first thing to fix.

Then let's see when TLS is there and what we do: we'll create "two" threads
just for that, what's even worse:

  - We'll create tls handshake thread in multifd_tls_channel_connect()
    first, setting &p->thread.

  - Within the same thread, we do multifd_tls_outgoing_handshake() when
    handshake done -> multifd_channel_connect() -> we yet create the real
    multifd_send_thread(), setting &p->thread too.

So AFAICT, the tls handshake thread is already leaked, got p->thread
overwritten by the new thread created by itself..

I think we should fix this then.  I haven't figured the best way to do,
two things I can come up with now:

  1) At least make the tls handshake thread detached.

  2) Make the handshake done in multifd send thread directly; I don't yet
     see why we must create two threads..

Then assuming we have a clear model with all these threads issue fixed (no
matter whether we'd shrink 2N threads into N threads), then what we need to
do, IMHO, is making sure to join() all of them before destroying anything
(say, per-channel MultiFDSendParams).  Then when we destroy everything
safely, either mutex/sem/etc..  Because no one will race us anymore.

Would it make sense?

Thanks,

-- 
Peter Xu


