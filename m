Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 879EA7CFD65
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:56:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtURO-0007d6-TV; Thu, 19 Oct 2023 10:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtURM-0007ar-PY
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:56:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtURL-0007jb-4Y
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:56:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3B7E821A82;
 Thu, 19 Oct 2023 14:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697727357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fA1zUFpdbgAc2Ybp6mtwIU2hgHF4szidVAavxIT8IBs=;
 b=wJ3c1LCwhGrVKptaRATEZhq608IN4heAoP//rsoOEQEh2SO96PB57oJ0TzVMErf2C1kR2d
 foC3YEIgXJTIes7zdVfBLD4nuacyBL2gP+nudYo/TMLZ8IUb/nl3vbNGQFXiqX/aRK25jl
 wLsRx73OoaTxtQ5+UMK7cB6qgDFh/Vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697727357;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fA1zUFpdbgAc2Ybp6mtwIU2hgHF4szidVAavxIT8IBs=;
 b=pO1Kny4nwDc63MCbc3a6VGOi9/VQuPTt0e9TajPlbc0geVGuz+xeoP15Q2EHAeJTC9W0TK
 +b8rp8LC9QlWtoAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C21A91357F;
 Thu, 19 Oct 2023 14:55:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2WHcI3xDMWXPEQAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 19 Oct 2023 14:55:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 1/6] migration/multifd: Remove channels_ready
 semaphore
In-Reply-To: <87sf676kxt.fsf@secure.mitica>
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-2-farosas@suse.de> <87sf676kxt.fsf@secure.mitica>
Date: Thu, 19 Oct 2023 11:55:54 -0300
Message-ID: <87r0lqy83p.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -4.10
X-Spamd-Result: default: False [-4.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.00)[30.07%];
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
>> The channels_ready semaphore is a global variable not linked to any
>> single multifd channel. Waiting on it only means that "some" channel
>> has become ready to send data. Since we need to address the channels
>> by index (multifd_send_state->params[i]), that information adds
>> nothing of value.
>
> NAK.
>
> I disagree here O:-)
>
> the reason why that channel exist is for multifd_send_pages()
>
> And simplifying the function what it does is:
>
> sem_wait(channels_ready);
>
> for_each_channel()
>    look if it is empty()
>
> But with the semaphore, we guarantee that when we go to the loop, there
> is a channel ready, so we know we donat busy wait searching for a
> channel that is free.
>

Ok, so that clarifies the channels_ready usage.

Now, thinking out loud... can't we simply (famous last words) remove the
"if (!p->pending_job)" line and let multifd_send_pages() prepare another
payload for the channel? That way multifd_send_pages() could already
return and the channel would see one more pending_job and proceed to
send it.

Or, since there's no resending anyway, we could dec pending_jobs earlier
before unlocking the channel. It seems the channel could be made ready
for another job as soon as the packet is built and the lock is released.

That way we could remove the semaphore and let the mutex do the job of
waiting for the channel to become ready.

> Notice that I fully agree that the sem is not needed for locking.
> Locking is done with the mutex.  It is just used to make sure that we
> don't busy loop on that loop.
>
> And we use a sem, because it is the easiest way to know how many
> channels are ready (even when we only care if there is one when we
> arrive to that code).

Yep, that's fine, no objection here.

>
> We lost count of that counter, and we fixed that here:

Kind of, because we still don't wait on it during cleanup. If we did,
then we could have an assert at the end to make sure this doesn't
regress again.

And maybe use channels_ready.count for other types of introspection.

> commit d2026ee117147893f8d80f060cede6d872ecbd7f
> Author: Juan Quintela <quintela@redhat.com>
> Date:   Wed Apr 26 12:20:36 2023 +0200
>
>     multifd: Fix the number of channels ready
>
>     We don't wait in the sem when we are doing a sync_main.  Make it
>
> And we were addressing the problem that some users where finding that we
> were busy waiting on that loop.
>
>> The channel being addressed is not necessarily the
>> one that just released the semaphore.
>
> We only care that there is at least one free.  We are going to search
> the next one.
>
> Does this explanation makes sense?

It does, thanks for taking the time to educate us =)

I made some suggestions above, but I might be missing something still.


