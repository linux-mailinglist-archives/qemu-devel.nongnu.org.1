Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CBA7C42D9
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 23:43:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqKVW-0004bY-8J; Tue, 10 Oct 2023 17:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqKVU-0004bH-9B
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 17:43:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqKVS-00034l-BN
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 17:43:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 671C8215EF;
 Tue, 10 Oct 2023 21:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696974188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4z+BgIm1tw0SJUe0upb3QuvEyEiyuVV95wls2SZJtaw=;
 b=jJpZosu72BJuYM488WZY3/vZcgshtDDcQbZiLyye5AkiqWAlH3JaHAd7EWkg7FvkFodVo5
 Plg+AcOIfns/hV64elX9xm/xx3pNLr8kt+KskEBQ+Yjx2xzqL6IHJB8TQuCmqDbdRDzKdo
 lXYE2oBoXBftjM4iWRMOYNLpM+ahWOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696974188;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4z+BgIm1tw0SJUe0upb3QuvEyEiyuVV95wls2SZJtaw=;
 b=hFrbkFT93/JL9GSCPFjZtlUrhu3+XmwS0HBYjSWW/OG++6al9+8P6PEf2ftY4sjhWdVi2B
 oVQdV0V6efeJHkBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E98101348E;
 Tue, 10 Oct 2023 21:43:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /36dLGvFJWVaHgAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 10 Oct 2023 21:43:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Leonardo
 Bras <leobras@redhat.com>, Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH 1/3] migration/multifd: Move channels_ready semaphore
In-Reply-To: <ZSW7dfSgV2dc6n0D@x1n>
References: <20230922145319.27380-1-farosas@suse.de>
 <20230922145319.27380-2-farosas@suse.de> <ZSW7dfSgV2dc6n0D@x1n>
Date: Tue, 10 Oct 2023 18:43:05 -0300
Message-ID: <87edi25f2u.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Fri, Sep 22, 2023 at 11:53:17AM -0300, Fabiano Rosas wrote:
>> Commit d2026ee117 ("multifd: Fix the number of channels ready") moved
>> the "post" of channels_ready to the start of the multifd_send_thread()
>> loop and added a missing "wait" at multifd_send_sync_main(). While it
>> does work, the placement of the wait goes against what the rest of the
>> code does.
>> 
>> The sequence at multifd_send_thread() is:
>> 
>>     qemu_sem_post(&multifd_send_state->channels_ready);
>>     qemu_sem_wait(&p->sem);
>>     <work>
>>     if (flags & MULTIFD_FLAG_SYNC) {
>>         qemu_sem_post(&p->sem_sync);
>>     }
>> 
>> Which means that the sending thread makes itself available
>> (channels_ready) and waits for more work (sem). So the sequence in the
>> migration thread should be to check if any channel is available
>> (channels_ready), give it some work and set it off (sem):
>> 
>>     qemu_sem_wait(&multifd_send_state->channels_ready);
>
> Here it means we have at least 1 free send thread, then...
>
>>     <enqueue work>
>>     qemu_sem_post(&p->sem);
>
> ... here we enqueue some work to the current thread (pointed by "i"), no
> matter it's free or not, as "i" may not always point to the free thread.
>

Yes. Which means channels_ready is currently useless. Since I posted
this I realized that and have been working on a series to remove it
completely.

... I'm not opposed to "fixing" whatever needs to be fixed here as well, but
I think removing it makes sense. I'll try to focus on that and post a v2
here.

>>     if (flags & MULTIFD_FLAG_SYNC) {
>>         qemu_sem_wait(&p->sem_sync);
>>     }
>
> So I must confess I never fully digest how these sem/mutex/.. worked in
> multifd, since the 1st day it's introduced.. so please take below comment
> with a grain of salt..

We definitely need to clarify some things in the multifd
design. Specially if we're going to use it as the main migration
infrastructure moving forward.

I think what we lack is a design direction. I'm not really interested in
how things work currently, but in how they *should* work based on the
design.

I'm confused about:

1) why channels_ready exists? Were we trying to do some lockstep
movement of: populate MultiFDPages -> release the sender thread -> move
to next channel -> wait for it to become ready -> repeat. If so, that
semaphore should be per-channel I think.

(my future proposal will be to remove the channels_ready semaphore)

2) why do we need sem_sync? The SYNC flag makes sense, but why the
source needs to sync with itself when syncing with dst?

(my proposal in this series is to rename sem_sync to sem_done and use it
to track sending completion)

3) why do we need to take the params lock? Shouldn't the semaphores
already ensure that only one of the main thread and the sender thread
will touch the params? The comment in multifd_send_pages says that we
don't take locks for the pages structure, but that seems pointeless to
me since we still lock the params structure.

> It seems to me that the current design allows >1 pending_job for a thread.
> Here the current code didn't do "wait(channels_ready)" because it doesn't
> need to - it simply always queue an MULTIFD_FLAG_SYNC pending job over the
> thread, and wait for it to run.
>
> From that POV I think I can understand why "wait(channels_ready)" is not
> needed here.  But then I'm confused because we don't have a real QUEUE to
> put those requests; we simply apply this:
>
> multifd_send_sync_main():
>         p->flags |= MULTIFD_FLAG_SYNC;
>
> Even if this send thread can be busy handling a batch of pages and
> accessing p->flags.  I think it can actually race with the send thread
> reading the flag at the exact same time:
>
> multifd_send_thread():
>             multifd_send_fill_packet(p);
>             flags = p->flags;  <-------------- here

It doesn't race in reading due to the p->mutex lock. But it looks like
it could miss a newly set flag when it unlocks to start sending
(qio_channel_write*).

> And whether it sees MULTIFD_FLAG_SYNC is unpredictable.  If it sees it,
> it'll post(sem_sync) in this round.  If it doesn't see it, it'll
> post(sem_sync) in the next round.  In whatever way, we'll generate an empty
> multifd packet to the wire I think, even though I don't know whether that's
> needed at all...
>
> I'm not sure whether we should fix it in a more complete form, by not
> sending that empty multifd packet at all? Because that only contains the
> header without any real page inside, IIUC, so it seems to be a waste of
> resource.  Here what we want is only to kick sem_sync?
>
>> 
>> The reason there's no deadlock today is that the migration thread
>> enqueues the SYNC packet right before the wait on channels_ready and
>> we end up taking advantage of the out-of-order post to sem:
>> 
>>         ...
>>         qemu_sem_post(&p->sem);
>>     }
>>     for (i = 0; i < migrate_multifd_channels(); i++) {
>>         MultiFDSendParams *p = &multifd_send_state->params[i];
>> 
>>         qemu_sem_wait(&multifd_send_state->channels_ready);
>>         trace_multifd_send_sync_main_wait(p->id);
>>         qemu_sem_wait(&p->sem_sync);
>> 	...
>> 
>> Move the channels_ready wait before the sem post to keep the sequence
>> consistent. Also fix the error path to post to channels_ready and
>> sem_sync in the correct order.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/multifd.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index a7c7a947e3..d626740f2f 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -618,6 +618,7 @@ int multifd_send_sync_main(QEMUFile *f)
>>  
>>          trace_multifd_send_sync_main_signal(p->id);
>>  
>> +        qemu_sem_wait(&multifd_send_state->channels_ready);
>>          qemu_mutex_lock(&p->mutex);
>>  
>>          if (p->quit) {
>> @@ -635,7 +636,6 @@ int multifd_send_sync_main(QEMUFile *f)
>>      for (i = 0; i < migrate_multifd_channels(); i++) {
>>          MultiFDSendParams *p = &multifd_send_state->params[i];
>>  
>> -        qemu_sem_wait(&multifd_send_state->channels_ready);
>>          trace_multifd_send_sync_main_wait(p->id);
>>          qemu_sem_wait(&p->sem_sync);
>>  
>> @@ -763,8 +763,8 @@ out:
>>       * who pay attention to me.
>>       */
>>      if (ret != 0) {
>> -        qemu_sem_post(&p->sem_sync);
>>          qemu_sem_post(&multifd_send_state->channels_ready);
>> +        qemu_sem_post(&p->sem_sync);
>
> I'm not sure why such movement will have a difference; afaiu on the
> semaphore semantics, post() to two sems don't matter on order?

You're right, there's no difference here. I have been working on
centralizing these "cleanup posts" and ended up convincing myself that
this was needed.

