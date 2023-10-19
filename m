Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F24A47CF387
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 11:07:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtOzO-0005Fr-OC; Thu, 19 Oct 2023 05:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtOz3-0005Dm-58
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtOz1-0000XH-CT
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697706375;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=pbSYvyuyEPZugfJGSMk6Dma+H1+O9xQqUavGitpyqN8=;
 b=TCOsS51l/LU8ONkIRnKBwQiyAPNi2mkJoyvbWfRS8jy6hP3niBV9/g3UN+m5U4cCxMB870
 USAEQ++4wfeB/HG65OZdWPiaPPG+nX+VK8jTenLulp91iy0QryGPJREwx5SCsbRUwjpwI7
 4Qi+fGtfd5521gT9RFf+AcTFsS1VUBA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-cCUaKzdfN1ee-QkYcCnnig-1; Thu, 19 Oct 2023 05:06:09 -0400
X-MC-Unique: cCUaKzdfN1ee-QkYcCnnig-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-406710d9a4aso55043025e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 02:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697706368; x=1698311168;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pbSYvyuyEPZugfJGSMk6Dma+H1+O9xQqUavGitpyqN8=;
 b=xHNc2AYA9CXnNiE7icDFXWbWpRGSYPBO8xcOU9dOuo692cJBIGmuUIsZ9z9pk7R6dd
 PDHYcjhHPr83X2ns7saejR0jYcqIgOcO1gvHN5B6uSH9d+iA/74sPWXG5tW+R7y8fc8z
 hBv1mHdTdUVKz7yE7JTjJv4AAk20cd/rGOOzy+QV5OQYTmQHlgd+STXIymYkavR7XF/d
 1YkojvO/E0UAnG9YFF7sZC26ZIAf8VVoRWObWBwV3FHki4HMZCJE2mSJKnAm3h5Vmzqc
 3Tb1mtVhO/8wSDT4Qn+Ja/NACwjVnPKSPo+65Xt6/06+XfvCu1onX59/8wqBjHiBe6u1
 0xbA==
X-Gm-Message-State: AOJu0YztbyHERjEAJ/5Hons/jm5wZiGsLex8otIb0Z6RXqECMCv2AWg5
 3d7IUS8dn4/VmcK84eONutEFzPdV+RAWSKRSkhlfq1xiBHRvI/osvqIKF+t7cIaOlzk6U0WOKj8
 bD9tyNbqOnW7mmwM=
X-Received: by 2002:a5d:5444:0:b0:32d:a405:b6b7 with SMTP id
 w4-20020a5d5444000000b0032da405b6b7mr1112746wrv.32.1697706367910; 
 Thu, 19 Oct 2023 02:06:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAVDsNOj7/PxlZNnBY1mXjcC+mRfUx6ybYc9EMq6PEZtGSoKhEDA2v2R1agGXEM7xfRHrY1Q==
X-Received: by 2002:a5d:5444:0:b0:32d:a405:b6b7 with SMTP id
 w4-20020a5d5444000000b0032da405b6b7mr1112728wrv.32.1697706367464; 
 Thu, 19 Oct 2023 02:06:07 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 k1-20020a5d66c1000000b0032dbf99bf4fsm3974083wrw.89.2023.10.19.02.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 02:06:06 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 1/6] migration/multifd: Remove channels_ready
 semaphore
In-Reply-To: <20231012140651.13122-2-farosas@suse.de> (Fabiano Rosas's message
 of "Thu, 12 Oct 2023 11:06:46 -0300")
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-2-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 11:06:06 +0200
Message-ID: <87sf676kxt.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> The channels_ready semaphore is a global variable not linked to any
> single multifd channel. Waiting on it only means that "some" channel
> has become ready to send data. Since we need to address the channels
> by index (multifd_send_state->params[i]), that information adds
> nothing of value.

NAK.

I disagree here O:-)

the reason why that channel exist is for multifd_send_pages()

And simplifying the function what it does is:

sem_wait(channels_ready);

for_each_channel()
   look if it is empty()

But with the semaphore, we guarantee that when we go to the loop, there
is a channel ready, so we know we donat busy wait searching for a
channel that is free.

Notice that I fully agree that the sem is not needed for locking.
Locking is done with the mutex.  It is just used to make sure that we
don't busy loop on that loop.

And we use a sem, because it is the easiest way to know how many
channels are ready (even when we only care if there is one when we
arrive to that code).

We lost count of that counter, and we fixed that here:

commit d2026ee117147893f8d80f060cede6d872ecbd7f
Author: Juan Quintela <quintela@redhat.com>
Date:   Wed Apr 26 12:20:36 2023 +0200

    multifd: Fix the number of channels ready

    We don't wait in the sem when we are doing a sync_main.  Make it

And we were addressing the problem that some users where finding that we
were busy waiting on that loop.

> The channel being addressed is not necessarily the
> one that just released the semaphore.

We only care that there is at least one free.  We are going to search
the next one.

Does this explanation makes sense?

Later, Juan.

> The only usage of this semaphore that makes sense is to wait for it in
> a loop that iterates for the number of channels. That could mean: all
> channels have been setup and are operational OR all channels have
> finished their work and are idle.
>
> Currently all code that waits on channels_ready is redundant. There is
> always a subsequent lock or semaphore that does the actual data
> protection/synchronization.
>
> - at multifd_send_pages: Waiting on channels_ready doesn't mean the
>   'next_channel' is ready, it could be any other channel. So there are
>   already cases where this code runs as if no semaphore was there.

>   Waiting outside of the loop is also incorrect because if the current
>   channel already has a pending_job, then it will loop into the next
>   one without waiting the semaphore and the count will be greater than
>   zero at the end of the execution.
>
>   Checking that "any" channel is ready as a proxy for all channels
>   being ready would work, but it's not what the code is doing and not
>   really needed because the channel lock and 'sem' would be enough.
>
> - at multifd_send_sync: This usage is correct, but it is made
>   redundant by the wait on sem_sync. What this piece of code is doing
>   is making sure all channels have sent the SYNC packet and became
>   idle afterwards.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/multifd.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 0f6b203877..e26f5f246d 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -362,8 +362,6 @@ struct {
>      MultiFDPages_t *pages;
>      /* global number of generated multifd packets */
>      uint64_t packet_num;
> -    /* send channels ready */
> -    QemuSemaphore channels_ready;
>      /*
>       * Have we already run terminate threads.  There is a race when it
>       * happens that we got one error while we are exiting.
> @@ -403,7 +401,6 @@ static int multifd_send_pages(QEMUFile *f)
>          return -1;
>      }
>  
> -    qemu_sem_wait(&multifd_send_state->channels_ready);
>      /*
>       * next_channel can remain from a previous migration that was
>       * using more channels, so ensure it doesn't overflow if the
> @@ -554,7 +551,6 @@ void multifd_save_cleanup(void)
>              error_free(local_err);
>          }
>      }
> -    qemu_sem_destroy(&multifd_send_state->channels_ready);
>      g_free(multifd_send_state->params);
>      multifd_send_state->params = NULL;
>      multifd_pages_clear(multifd_send_state->pages);
> @@ -630,7 +626,6 @@ int multifd_send_sync_main(QEMUFile *f)
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
> -        qemu_sem_wait(&multifd_send_state->channels_ready);
>          trace_multifd_send_sync_main_wait(p->id);
>          qemu_sem_wait(&p->sem_sync);
>  
> @@ -664,7 +659,6 @@ static void *multifd_send_thread(void *opaque)
>      p->num_packets = 1;
>  
>      while (true) {
> -        qemu_sem_post(&multifd_send_state->channels_ready);
>          qemu_sem_wait(&p->sem);
>  
>          if (qatomic_read(&multifd_send_state->exiting)) {
> @@ -759,7 +753,6 @@ out:
>       */
>      if (ret != 0) {
>          qemu_sem_post(&p->sem_sync);
> -        qemu_sem_post(&multifd_send_state->channels_ready);
>      }
>  
>      qemu_mutex_lock(&p->mutex);
> @@ -796,7 +789,6 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
>           * is not created, and then tell who pay attention to me.
>           */
>          p->quit = true;
> -        qemu_sem_post(&multifd_send_state->channels_ready);
>          qemu_sem_post(&p->sem_sync);
>      }
>  }
> @@ -874,7 +866,6 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
>  {
>       migrate_set_error(migrate_get_current(), err);
>       /* Error happen, we need to tell who pay attention to me */
> -     qemu_sem_post(&multifd_send_state->channels_ready);
>       qemu_sem_post(&p->sem_sync);
>       /*
>        * Although multifd_send_thread is not created, but main migration
> @@ -919,7 +910,6 @@ int multifd_save_setup(Error **errp)
>      multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
>      multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
>      multifd_send_state->pages = multifd_pages_init(page_count);
> -    qemu_sem_init(&multifd_send_state->channels_ready, 0);
>      qatomic_set(&multifd_send_state->exiting, 0);
>      multifd_send_state->ops = multifd_ops[migrate_multifd_compression()];


