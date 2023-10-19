Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D5C7CFEE1
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 17:58:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtVOI-0003tA-RJ; Thu, 19 Oct 2023 11:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtVOG-0003sr-4i
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:56:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtVOD-0001S0-Un
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:56:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C5D321A6A;
 Thu, 19 Oct 2023 15:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697731006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xniYC3JDQdqZBFdwD6pT/keDTNMUgmGhZyD3dqIAT6U=;
 b=LbbXlVf3ZvoNIkPDDUBQSL01MgmNX1kfd0hWDY2dbm2ECCfW/yL70wriCyy8oGmqVP9mZY
 e35P2XUs2hsrTnPJoqDc/OQrJPaQD6FJbtJFb0OpAOa2l0r+2goTv4cFoEOmcRn7v8XTQp
 OgigGN2dJ07JoRa/4Su2W59alOODWxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697731006;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xniYC3JDQdqZBFdwD6pT/keDTNMUgmGhZyD3dqIAT6U=;
 b=WR0lCmsI51N/Tk4WKushqEBR7Xf8UOIHqA2Avn6rsmzKrgIjPYIW7+/hMWids/O/+ALP1A
 5eex2PyEHJJzAoDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 200B9139C2;
 Thu, 19 Oct 2023 15:56:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Rbj4Nr1RMWWIMwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 19 Oct 2023 15:56:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 1/6] migration/multifd: Remove channels_ready
 semaphore
In-Reply-To: <87wmvi3akc.fsf@secure.mitica>
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-2-farosas@suse.de> <87sf676kxt.fsf@secure.mitica>
 <87r0lqy83p.fsf@suse.de> <87wmvi3akc.fsf@secure.mitica>
Date: Thu, 19 Oct 2023 12:56:43 -0300
Message-ID: <87lebyy5ac.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -7.10
X-Spamd-Result: default: False [-7.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
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

Juan Quintela <quintela@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> wrote:
>> Juan Quintela <quintela@redhat.com> writes:
>>
>>> Fabiano Rosas <farosas@suse.de> wrote:
>>>> The channels_ready semaphore is a global variable not linked to any
>>>> single multifd channel. Waiting on it only means that "some" channel
>>>> has become ready to send data. Since we need to address the channels
>>>> by index (multifd_send_state->params[i]), that information adds
>>>> nothing of value.
>>>
>>> NAK.
>>>
>>> I disagree here O:-)
>>>
>>> the reason why that channel exist is for multifd_send_pages()
>>>
>>> And simplifying the function what it does is:
>>>
>>> sem_wait(channels_ready);
>>>
>>> for_each_channel()
>>>    look if it is empty()
>>>
>>> But with the semaphore, we guarantee that when we go to the loop, there
>>> is a channel ready, so we know we donat busy wait searching for a
>>> channel that is free.
>>>
>>
>> Ok, so that clarifies the channels_ready usage.
>>
>> Now, thinking out loud... can't we simply (famous last words) remove the
>> "if (!p->pending_job)" line and let multifd_send_pages() prepare another
>> payload for the channel? That way multifd_send_pages() could already
>> return and the channel would see one more pending_job and proceed to
>> send it.
>
> No.
>
> See the while loop in multifd_send_thread()
>
>     while (true) {
>         qemu_mutex_lock(&p->mutex);
>
>         if (p->pending_job) {
>
>             ......
>             Do things with parts of the struct that are shared with the
>             migration thread
>             ....
>             qemu_mutex_unlock(&p->mutex);
>
>             // Drop the lock
>             // Do mothing things on the channel, pending_job means that
>             // it is working
>             // mutex dropped means that migration_thread can use the
>             // shared variables, but not the channel
>
>             // now here we decrease pending_job, so main thread can
>             // change things as it wants
>             // But we need to take the lock first.
>             qemu_mutex_lock(&p->mutex);
>             p->pending_job--;
>             qemu_mutex_unlock(&p->mutex);
>             ......
>         }
>     }
>
> This is a common pattern for concurrency.  To not have your mutex locked
> too long, you put a variable (that can only be tested/changed with the
> lock) to explain that the "channel" is busy, the struct that lock
> protects is not (see how we make sure that the channel don't use any
> variable of the struct without the locking).

Sure, but what purpose is to mark the channel as busy? The migration
thread cannot access the p->packet anyway. From multifd_send_pages()
perspective, as soon as the channel releases the lock to start with the
IO, the packet has been sent. It could start preparing the next pages
struct while the channel is doing IO. No?

We don't touch p after the IO aside from p->pending_jobs-- and we
already distribute the load uniformly by incrementing next_channel.

I'm not saying this would be more performant, just wondering if it would
be possible.

>
>
>> Or, since there's no resending anyway, we could dec pending_jobs earlier
>> before unlocking the channel. It seems the channel could be made ready
>> for another job as soon as the packet is built and the lock is released.
>
> pending_jobs can be transformed in a bool.  We just need to make sure
> that we didn't screw it in _sync().
>
>> That way we could remove the semaphore and let the mutex do the job of
>> waiting for the channel to become ready.
>
> As said, we don't want that.  Because channels can go a different speeds
> due to factors outside of our control.
>
> If the semaphore bothers you, you can change it to to a condition
> variable, but you just move the complexity from one side to the other
> (Initial implementation had a condition variable, but Paolo said that
> the semaphore is more efficient, so he won)

Oh, it doesn't bother me. I'm just trying to unequivocally understand
it's effects. And if it logically follows that it's not necessary, only
then remove it.


