Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CB37C41F6
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 23:01:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqJqg-0007mp-Be; Tue, 10 Oct 2023 17:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqJqc-0007mQ-Qu
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 17:00:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqJqY-0002Ud-7O
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 17:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696971652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jHUvXhBs6zyiN+rGmJ0FcRHaQRKw5Mn3+eUxbaUvfyg=;
 b=jLtYROCH0hJ9yP3tTM01RD1BtvRRX/9+iorsKmdC1onkPINDVoHrb7OdOM5ld+vmoVScb5
 h7ev9cNdE5dx0JDugnJwszDBLShISsmZMjM8Q9EpfFqfLx7OCqlg+kXbSqUZ2U2i5ZwEFh
 hxGKacCHPkTdVG9qZ7ycFnrcueS3W7Q=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-7QNt6T44OQ6QNhvc2yrk6w-1; Tue, 10 Oct 2023 17:00:51 -0400
X-MC-Unique: 7QNt6T44OQ6QNhvc2yrk6w-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-4817b0031e8so465478e0c.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 14:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696971651; x=1697576451;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHUvXhBs6zyiN+rGmJ0FcRHaQRKw5Mn3+eUxbaUvfyg=;
 b=vcNge8aAeHRNZHgKG7RqoEDj+qVUB4XBzLftYeQ3W/M3iVnm7mB5JPh4kusREf3fPQ
 z0Fedul2bHzI1SGt9l766s4vqH6yH/EWFQGyzFkSfLjteeWeO4pcAo7rbinhLtqpKAL8
 WJ00NQ6+Iv7QwBPyjjLOGcDUt5kXAP8yxkiKHw7/H0Ym2737SufWvDvejfJBhIWmlTZM
 1+heQhIP97Cw9WMOLKcJS3Hw/w823oSKlTpN5Jker5oQyz/mSg1lPI+2DB25l2pbfy1B
 xhv8VASRVBTX7uDf0nvWhg49oGJGJPF8moYTDj/lqx2M1CPbnAEbuMvgnh+VvF+E5TQN
 kOug==
X-Gm-Message-State: AOJu0YzyeYeqqorkSuhZwRsqzA7nAkJzKfrkuwdEAa+Uhnwc12MfUqwl
 X0i1uhJqHFrK+BWvpol0cojC8Bv4irBdhUqFI5i2i0LaYL6ZAu0APyq5lD34t9m1+xpe6Vb54qI
 1VynrMf1MEDA3xZU=
X-Received: by 2002:a05:6122:2216:b0:499:7af7:207d with SMTP id
 bb22-20020a056122221600b004997af7207dmr10759704vkb.1.1696971650651; 
 Tue, 10 Oct 2023 14:00:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrDdDxMd2dMCAlpMN8Um7C7e3iXH3Y8hXydR/4WR7zuY8gwzk+MmloLT9w+qx8l4YvW5q+SA==
X-Received: by 2002:a05:6122:2216:b0:499:7af7:207d with SMTP id
 bb22-20020a056122221600b004997af7207dmr10759684vkb.1.1696971650336; 
 Tue, 10 Oct 2023 14:00:50 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 h4-20020ac85044000000b004180fb5c6adsm4776880qtm.25.2023.10.10.14.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 14:00:44 -0700 (PDT)
Date: Tue, 10 Oct 2023 17:00:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH 1/3] migration/multifd: Move channels_ready semaphore
Message-ID: <ZSW7dfSgV2dc6n0D@x1n>
References: <20230922145319.27380-1-farosas@suse.de>
 <20230922145319.27380-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230922145319.27380-2-farosas@suse.de>
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

On Fri, Sep 22, 2023 at 11:53:17AM -0300, Fabiano Rosas wrote:
> Commit d2026ee117 ("multifd: Fix the number of channels ready") moved
> the "post" of channels_ready to the start of the multifd_send_thread()
> loop and added a missing "wait" at multifd_send_sync_main(). While it
> does work, the placement of the wait goes against what the rest of the
> code does.
> 
> The sequence at multifd_send_thread() is:
> 
>     qemu_sem_post(&multifd_send_state->channels_ready);
>     qemu_sem_wait(&p->sem);
>     <work>
>     if (flags & MULTIFD_FLAG_SYNC) {
>         qemu_sem_post(&p->sem_sync);
>     }
> 
> Which means that the sending thread makes itself available
> (channels_ready) and waits for more work (sem). So the sequence in the
> migration thread should be to check if any channel is available
> (channels_ready), give it some work and set it off (sem):
> 
>     qemu_sem_wait(&multifd_send_state->channels_ready);

Here it means we have at least 1 free send thread, then...

>     <enqueue work>
>     qemu_sem_post(&p->sem);

... here we enqueue some work to the current thread (pointed by "i"), no
matter it's free or not, as "i" may not always point to the free thread.

>     if (flags & MULTIFD_FLAG_SYNC) {
>         qemu_sem_wait(&p->sem_sync);
>     }

So I must confess I never fully digest how these sem/mutex/.. worked in
multifd, since the 1st day it's introduced.. so please take below comment
with a grain of salt..

It seems to me that the current design allows >1 pending_job for a thread.
Here the current code didn't do "wait(channels_ready)" because it doesn't
need to - it simply always queue an MULTIFD_FLAG_SYNC pending job over the
thread, and wait for it to run.

From that POV I think I can understand why "wait(channels_ready)" is not
needed here.  But then I'm confused because we don't have a real QUEUE to
put those requests; we simply apply this:

multifd_send_sync_main():
        p->flags |= MULTIFD_FLAG_SYNC;

Even if this send thread can be busy handling a batch of pages and
accessing p->flags.  I think it can actually race with the send thread
reading the flag at the exact same time:

multifd_send_thread():
            multifd_send_fill_packet(p);
            flags = p->flags;  <-------------- here

And whether it sees MULTIFD_FLAG_SYNC is unpredictable.  If it sees it,
it'll post(sem_sync) in this round.  If it doesn't see it, it'll
post(sem_sync) in the next round.  In whatever way, we'll generate an empty
multifd packet to the wire I think, even though I don't know whether that's
needed at all...

I'm not sure whether we should fix it in a more complete form, by not
sending that empty multifd packet at all? Because that only contains the
header without any real page inside, IIUC, so it seems to be a waste of
resource.  Here what we want is only to kick sem_sync?

> 
> The reason there's no deadlock today is that the migration thread
> enqueues the SYNC packet right before the wait on channels_ready and
> we end up taking advantage of the out-of-order post to sem:
> 
>         ...
>         qemu_sem_post(&p->sem);
>     }
>     for (i = 0; i < migrate_multifd_channels(); i++) {
>         MultiFDSendParams *p = &multifd_send_state->params[i];
> 
>         qemu_sem_wait(&multifd_send_state->channels_ready);
>         trace_multifd_send_sync_main_wait(p->id);
>         qemu_sem_wait(&p->sem_sync);
> 	...
> 
> Move the channels_ready wait before the sem post to keep the sequence
> consistent. Also fix the error path to post to channels_ready and
> sem_sync in the correct order.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/multifd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index a7c7a947e3..d626740f2f 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -618,6 +618,7 @@ int multifd_send_sync_main(QEMUFile *f)
>  
>          trace_multifd_send_sync_main_signal(p->id);
>  
> +        qemu_sem_wait(&multifd_send_state->channels_ready);
>          qemu_mutex_lock(&p->mutex);
>  
>          if (p->quit) {
> @@ -635,7 +636,6 @@ int multifd_send_sync_main(QEMUFile *f)
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
> -        qemu_sem_wait(&multifd_send_state->channels_ready);
>          trace_multifd_send_sync_main_wait(p->id);
>          qemu_sem_wait(&p->sem_sync);
>  
> @@ -763,8 +763,8 @@ out:
>       * who pay attention to me.
>       */
>      if (ret != 0) {
> -        qemu_sem_post(&p->sem_sync);
>          qemu_sem_post(&multifd_send_state->channels_ready);
> +        qemu_sem_post(&p->sem_sync);

I'm not sure why such movement will have a difference; afaiu on the
semaphore semantics, post() to two sems don't matter on order?

>      }
>  
>      qemu_mutex_lock(&p->mutex);
> -- 
> 2.35.3
> 

-- 
Peter Xu


