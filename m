Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C40007D01F5
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:41:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXxg-0004CD-7n; Thu, 19 Oct 2023 14:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtXxe-0004Bw-CH
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtXxc-00018L-OH
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697740892;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Iu6BmbSKr95QfOuqDyfQadoyKGmgBWkVpNduy3nGOCg=;
 b=X57JnjyyJxY8TtVVURUOll0SOAGXBJIYYgNzoiq4HdbAD4y2tZ+BMHJw666l3JximW0bBS
 lpH2YOrfdBj5y8F3vjjYrEGHC6zTXOFeRt28e/n7td7P84vX2f7yf3KU+7RbuAUKMYqWm3
 QOXHBrlz680m7YTOeBLGVdd6v3iA1Rw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-AwG384wSNM2KDpJj2tVfDA-1; Thu, 19 Oct 2023 14:41:30 -0400
X-MC-Unique: AwG384wSNM2KDpJj2tVfDA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507d0e4eedaso1098307e87.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697740889; x=1698345689;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iu6BmbSKr95QfOuqDyfQadoyKGmgBWkVpNduy3nGOCg=;
 b=wfHwlfGZ89kULDA3IkXB49EBUajgtXFNYlehcoctp/7O5qOx+CBfvgO/RaEzLnetg6
 6587E059Tzc8u3ATfIXoxvy8XXIMf2fcvpjGYFW+O+QZ+uAsBXmzs8zO24pLYjDQPEnb
 mwvUJe14iwX0SNZHzAxuC+SW1Z7oRVKgMcDlMnQvKaVyVXpQyOFSIMBFqzSNru11urg4
 ZjJmPD9mjM+/t6e/528auaugs5h16CgF4e0F7R/AQVBmNnJEXtVoGYWnfwCeDt2vjSyb
 MPMgTs00K94e4RyV+WZdbb3DheKl1vALQDDT6LCoVySSBPL7Xguxqggvp39TE9TsH8gS
 uR3w==
X-Gm-Message-State: AOJu0YwroTob2YRVcVEfhFWYOzl689BgbNxV5vzt/Uld7M4ctG6Wmn/P
 /nsmkm43rLpXgAQa5u52fGo+o5H2QUVRcsRoKraEdmMWgYCeK0ya2s3TGWmDhbtvNvBbFFeDBAr
 OhG2qeai5G2r4UbU=
X-Received: by 2002:a05:6512:2244:b0:4ff:7f7f:22e7 with SMTP id
 i4-20020a056512224400b004ff7f7f22e7mr2472373lfu.17.1697740888883; 
 Thu, 19 Oct 2023 11:41:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuec+RlVnNOhGHo5zJBsxhOVM2pSUPusw4sk0Mu4udm3jL/9ObO1783IKwbo/Ywv5LOdjPvw==
X-Received: by 2002:a05:6512:2244:b0:4ff:7f7f:22e7 with SMTP id
 i4-20020a056512224400b004ff7f7f22e7mr2472361lfu.17.1697740888449; 
 Thu, 19 Oct 2023 11:41:28 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m21-20020a194355000000b00501b9fc977csm662lfj.37.2023.10.19.11.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:41:27 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 1/6] migration/multifd: Remove channels_ready
 semaphore
In-Reply-To: <87lebyy5ac.fsf@suse.de> (Fabiano Rosas's message of "Thu, 19 Oct
 2023 12:56:43 -0300")
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-2-farosas@suse.de>
 <87sf676kxt.fsf@secure.mitica> <87r0lqy83p.fsf@suse.de>
 <87wmvi3akc.fsf@secure.mitica> <87lebyy5ac.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 20:41:26 +0200
Message-ID: <87a5se3161.fsf@secure.mitica>
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
>>> Juan Quintela <quintela@redhat.com> writes:
>>>
>>
>> This is a common pattern for concurrency.  To not have your mutex locked
>> too long, you put a variable (that can only be tested/changed with the
>> lock) to explain that the "channel" is busy, the struct that lock
>> protects is not (see how we make sure that the channel don't use any
>> variable of the struct without the locking).
>
> Sure, but what purpose is to mark the channel as busy? The migration
> thread cannot access the p->packet anyway. From multifd_send_pages()
> perspective, as soon as the channel releases the lock to start with the
> IO, the packet has been sent. It could start preparing the next pages
> struct while the channel is doing IO. No?

ok, we remove the pending.
Then we are sending that packet.

But see what happens on multifd_send_pages()

channels_ready is 0.
this is channel 1
next_channel == 1
channel 0 gets ready, so it increases channels_ready.

static int multifd_send_pages(QEMUFile *f)
{

    qemu_sem_wait(&multifd_send_state->channels_ready);
    // we pass this

    next_channel %= migrate_multifd_channels();
    for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
        p = &multifd_send_state->params[i];

        // remember that i == 0

        qemu_mutex_lock(&p->mutex);
        if (p->quit) {
            error_report("%s: channel %d has already quit!", __func__, i);
            qemu_mutex_unlock(&p->mutex);
            return -1;
        }
        if (!p->pending_job) {
            p->pending_job++;
            next_channel = (i + 1) % migrate_multifd_channels();
            break;
        }
        qemu_mutex_unlock(&p->mutex);

// We choose 1, to send the packet through it.
// channel 1 is busy.
// channel 0 is idle but receives no work.
    }
...
}

So the variable is there to differentiate what channels are busy/idle to
send the work to the idle channels.

> We don't touch p after the IO aside from p->pending_jobs-- and we
> already distribute the load uniformly by incrementing next_channel.

I know.  After multifd_send_threads() releases the mutex it will only
touch ->pending_job (taking the mutex 1st).

> I'm not saying this would be more performant, just wondering if it would
> be possible.

Yeap, but as said before quite suboptimal.

>> As said, we don't want that.  Because channels can go a different speeds
>> due to factors outside of our control.
>>
>> If the semaphore bothers you, you can change it to to a condition
>> variable, but you just move the complexity from one side to the other
>> (Initial implementation had a condition variable, but Paolo said that
>> the semaphore is more efficient, so he won)
>
> Oh, it doesn't bother me. I'm just trying to unequivocally understand
> it's effects. And if it logically follows that it's not necessary, only
> then remove it.

Both channels_ready and pending_job makes the scheme more performant.
Without them it will not fail, just work way slower.

In the example that just showed you, if we started always from channel 0
to search for a idle channel, we would even do worse (that would be an
actual error):

start with channels_ready == 0;
channels_ready is 0.
channel 1 gets ready, so it increases channels_ready.

static int multifd_send_pages(QEMUFile *f)
{
    qemu_sem_wait(&multifd_send_state->channels_ready);
    // we pass this

    for (i = 0;; i = (i + 1) % migrate_multifd_channels()) {
        p = &multifd_send_state->params[i];

        // remember that i == 0

        qemu_mutex_lock(&p->mutex);
        if (p->quit) {
            error_report("%s: channel %d has already quit!", __func__, i);
            qemu_mutex_unlock(&p->mutex);
            return -1;
        }
        if (!p->pending_job) {
            p->pending_job++;
            next_channel = (i + 1) % migrate_multifd_channels();
            break;
        }
        // As there is no test to see if this is idle, we put the page here
        qemu_mutex_unlock(&p->mutex);

        // We put here the page info
    }
...
}

channel 2 guest ready, so it increses channels_ready

static int multifd_send_pages(QEMUFile *f)
{
    qemu_sem_wait(&multifd_send_state->channels_ready);
    // we pass this

    for (i = 0;; i = (i + 1) % migrate_multifd_channels()) {
        p = &multifd_send_state->params[i];

        // remember that i == 0

        qemu_mutex_lock(&p->mutex);
        if (p->quit) {
            error_report("%s: channel %d has already quit!", __func__, i);
            qemu_mutex_unlock(&p->mutex);
            return -1;
        }
        if (!p->pending_job) {
            p->pending_job++;
            next_channel = (i + 1) % migrate_multifd_channels();
            break;
        }
        // As there is no test to see if this is idle, we put the page here
        qemu_mutex_unlock(&p->mutex);

        // We put here the page info
        // channel 0 is still transmitting the 1st page
        // And overwrote the previous page info
   }
...
}

In this particular case, using next_channel in round robin would have
saved the case.  When you put info for a channel to consume
asynhronously, you need to mark somehow that the channel has finished to
use the data before ordering it to put do more job.

We can changing pending_job to a bool if you preffer.  I think that we
have nailed all the off_by_one errors by now (famous last words).

Later, Juan.


