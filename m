Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E6F7CFDAA
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 17:19:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtUnK-00070n-Eu; Thu, 19 Oct 2023 11:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtUnG-0006yf-6W
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:18:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtUnD-0000tw-VW
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697728714;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ap//yrapDFh/u0DH4Umec6lH3Sw8N6RrRYSvaohM7lU=;
 b=BTYMFQMIxpRRnxOsJmhhOXx6j+3GiYmQpcz6wzCLj7h5avC/02yysJU7ncdm3lXbT5VZG9
 bzXWFBi8kEbnmckgnxfgvwBnQF9M5zRgQYm9mXP3vi4q7mTU0ypJHHhBxjjPEqJ9CIhY5m
 VGTocH/Gi9VLwxPvRHux0EGkIB7dFrE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-QRPmwRREP0OAA-Vs99XNHA-1; Thu, 19 Oct 2023 11:18:32 -0400
X-MC-Unique: QRPmwRREP0OAA-Vs99XNHA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-507c996104fso2027753e87.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 08:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697728710; x=1698333510;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ap//yrapDFh/u0DH4Umec6lH3Sw8N6RrRYSvaohM7lU=;
 b=uCPcN00Ah5OirMfgkozME7oajKWEzzgIQOUMKk97e8CH8puJ0RmjPjShJk1i6lnOSa
 tkugOuSeP4ugfMhG5wnuRusqgSleuildb+qQnI4PFzJSkCXKSTu/HzlE9kc7QjOdL15b
 ukHaQZr/hfGlVbCTH3Mc2L3mU9MOB5TVMYDUAjZvOyVM1hoaa5XI+8E/XAhg4jj2yhiS
 AR5biXK0gOdyKe2jtw4WNvIk/3hq8z4ahah6Sv8SWNatyqFaJIWuUYouzCkfPdEY+TTd
 pBKu5Ugn7v/c3Y5vePWHWpoZSKFQQjRSMTAvgR/CIePpD72QPwRYHrinzi2oG8vMphKf
 +45A==
X-Gm-Message-State: AOJu0YzYv8MKh3BlxqCYVFN5rttqo7ekv/mZAcR7BOpLVhYXbj2XCX6Q
 A4awQr77sNfFi7wYOTYgLfj4DdlmcesnjE78RJQhKQsiZIwY93XgBTPjUStB3TgQ2h5eANBJz66
 mJ6pw/Zp3C8qjjZXE/eoE8vXVSw==
X-Received: by 2002:a05:6512:220c:b0:507:a04c:1bcf with SMTP id
 h12-20020a056512220c00b00507a04c1bcfmr2064676lfu.58.1697728710597; 
 Thu, 19 Oct 2023 08:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKQLb3mthsnFo0+DNTb0l3ISJId4LNCHhvmk1qKQ5Ts6tN1uEUYEkoQvy8WrZyN7RZGtTxgg==
X-Received: by 2002:a05:6512:220c:b0:507:a04c:1bcf with SMTP id
 h12-20020a056512220c00b00507a04c1bcfmr2064656lfu.58.1697728710168; 
 Thu, 19 Oct 2023 08:18:30 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 j4-20020adfe504000000b0032da7454ebesm4687534wrm.79.2023.10.19.08.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:18:28 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 1/6] migration/multifd: Remove channels_ready
 semaphore
In-Reply-To: <87r0lqy83p.fsf@suse.de> (Fabiano Rosas's message of "Thu, 19 Oct
 2023 11:55:54 -0300")
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-2-farosas@suse.de>
 <87sf676kxt.fsf@secure.mitica> <87r0lqy83p.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 17:18:27 +0200
Message-ID: <87wmvi3akc.fsf@secure.mitica>
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
> Juan Quintela <quintela@redhat.com> writes:
>
>> Fabiano Rosas <farosas@suse.de> wrote:
>>> The channels_ready semaphore is a global variable not linked to any
>>> single multifd channel. Waiting on it only means that "some" channel
>>> has become ready to send data. Since we need to address the channels
>>> by index (multifd_send_state->params[i]), that information adds
>>> nothing of value.
>>
>> NAK.
>>
>> I disagree here O:-)
>>
>> the reason why that channel exist is for multifd_send_pages()
>>
>> And simplifying the function what it does is:
>>
>> sem_wait(channels_ready);
>>
>> for_each_channel()
>>    look if it is empty()
>>
>> But with the semaphore, we guarantee that when we go to the loop, there
>> is a channel ready, so we know we donat busy wait searching for a
>> channel that is free.
>>
>
> Ok, so that clarifies the channels_ready usage.
>
> Now, thinking out loud... can't we simply (famous last words) remove the
> "if (!p->pending_job)" line and let multifd_send_pages() prepare another
> payload for the channel? That way multifd_send_pages() could already
> return and the channel would see one more pending_job and proceed to
> send it.

No.

See the while loop in multifd_send_thread()

    while (true) {
        qemu_mutex_lock(&p->mutex);

        if (p->pending_job) {

            ......
            Do things with parts of the struct that are shared with the
            migration thread
            ....
            qemu_mutex_unlock(&p->mutex);

            // Drop the lock
            // Do mothing things on the channel, pending_job means that
            // it is working
            // mutex dropped means that migration_thread can use the
            // shared variables, but not the channel

            // now here we decrease pending_job, so main thread can
            // change things as it wants
            // But we need to take the lock first.
            qemu_mutex_lock(&p->mutex);
            p->pending_job--;
            qemu_mutex_unlock(&p->mutex);
            ......
        }
    }

This is a common pattern for concurrency.  To not have your mutex locked
too long, you put a variable (that can only be tested/changed with the
lock) to explain that the "channel" is busy, the struct that lock
protects is not (see how we make sure that the channel don't use any
variable of the struct without the locking).


> Or, since there's no resending anyway, we could dec pending_jobs earlier
> before unlocking the channel. It seems the channel could be made ready
> for another job as soon as the packet is built and the lock is released.

pending_jobs can be transformed in a bool.  We just need to make sure
that we didn't screw it in _sync().

> That way we could remove the semaphore and let the mutex do the job of
> waiting for the channel to become ready.

As said, we don't want that.  Because channels can go a different speeds
due to factors outside of our control.

If the semaphore bothers you, you can change it to to a condition
variable, but you just move the complexity from one side to the other
(Initial implementation had a condition variable, but Paolo said that
the semaphore is more efficient, so he won)

>> Notice that I fully agree that the sem is not needed for locking.
>> Locking is done with the mutex.  It is just used to make sure that we
>> don't busy loop on that loop.
>>
>> And we use a sem, because it is the easiest way to know how many
>> channels are ready (even when we only care if there is one when we
>> arrive to that code).
>
> Yep, that's fine, no objection here.
>
>>
>> We lost count of that counter, and we fixed that here:
>
> Kind of, because we still don't wait on it during cleanup. If we did,
> then we could have an assert at the end to make sure this doesn't
> regress again.
>
> And maybe use channels_ready.count for other types of introspection.

We could.

>> commit d2026ee117147893f8d80f060cede6d872ecbd7f
>> Author: Juan Quintela <quintela@redhat.com>
>> Date:   Wed Apr 26 12:20:36 2023 +0200
>>
>>     multifd: Fix the number of channels ready
>>
>>     We don't wait in the sem when we are doing a sync_main.  Make it
>>
>> And we were addressing the problem that some users where finding that we
>> were busy waiting on that loop.
>>
>>> The channel being addressed is not necessarily the
>>> one that just released the semaphore.
>>
>> We only care that there is at least one free.  We are going to search
>> the next one.
>>
>> Does this explanation makes sense?
>
> It does, thanks for taking the time to educate us =)
>
> I made some suggestions above, but I might be missing something still.

I think that the current code is already quite efficient.

But will have to think if that improves anything major.

Later, Juan.


