Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DBA7CFD76
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 17:00:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtUVS-0005YO-Ng; Thu, 19 Oct 2023 11:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtUVQ-0005W1-Pl
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtUVN-0000AH-Ao
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697727608;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=U26FJ2WAPF3TCjOt0sE90VW9s4jxBxo+wfHWRJ9AMYg=;
 b=ARuTVLoemaTSvq9sBWPiaU8ZuEINEPh/oTcI8XHvxR5FnOfbp/MgayaB/o63C8FoTQl0Fi
 zf4LtIwoX4hmjznjdvY0/PKl5uQ0NCQEPYYRScXvCGvjUfzL4yPDkcQoQdSTtF7byh0B+k
 Sex+MYMOnzbYOWh/hzac0g+17yWZPiE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-09nOyZ2hMQOgfbWAQ9X2Jw-1; Thu, 19 Oct 2023 11:00:07 -0400
X-MC-Unique: 09nOyZ2hMQOgfbWAQ9X2Jw-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-5a8ead739c3so3900237b3.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 08:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727606; x=1698332406;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U26FJ2WAPF3TCjOt0sE90VW9s4jxBxo+wfHWRJ9AMYg=;
 b=iGaB5bgr9cJaP8vicH0iqZYVHjZ75iLq7o7S23hpW/TLfdeEJacqX+R0+qp1Tc8EWW
 yI4GQ9hQ1ZnMxLBapczsqc+7ElMtOOwtZGBEMgR7x/y9bJde1PwZLhSEeBc2Ryqi9MM9
 Cnab5bzRuGAinQpvXwCLMOfCxbxR/x2BTXmqcKPxy2bSyDmyq3qiLqTggyFyXM6PtEZW
 qEuQyqA7tp9MBqGyMrWvxQGloK/hDK2m9PmPqPM89e0wOWwBeV3vKMA0rHJhzNRA38F6
 6Vl/NbspCAez3qFYeKVvEkvY/WaLabNPVqUhpa7a80U2COU8LjNzjCuzZdsmgH6hV3vv
 76cQ==
X-Gm-Message-State: AOJu0Ywl/kQ6OSySGKEvklo1kikyzoh9fYyErzHle4XSlRO9ZLSaBMAo
 gePNKMGJfCCk5D46Zjs9gfhb/olVGcx+DhtmxUFxlf4HjF4GRZJ/46JC7xk1SZRXSJLHWcGq4jl
 UhZ9+T6ZXALxnSkQ=
X-Received: by 2002:a0d:d741:0:b0:5a8:d92b:fbf3 with SMTP id
 z62-20020a0dd741000000b005a8d92bfbf3mr2756520ywd.38.1697727606335; 
 Thu, 19 Oct 2023 08:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH9HUtnepq/CHM47hbMs5bI2TPWtaPYdpL4ftjpIc6+ziZWltQ2+cafLF64R34q2kz2cKvtA==
X-Received: by 2002:a0d:d741:0:b0:5a8:d92b:fbf3 with SMTP id
 z62-20020a0dd741000000b005a8d92bfbf3mr2756487ywd.38.1697727605882; 
 Thu, 19 Oct 2023 08:00:05 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 qp13-20020a05620a388d00b0076eee688a95sm811023qkn.0.2023.10.19.08.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:00:05 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  qemu-devel@nongnu.org,  Leonardo Bras
 <leobras@redhat.com>,  Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 1/6] migration/multifd: Remove channels_ready
 semaphore
In-Reply-To: <ZTE+lmbvtYNDU80q@x1n> (Peter Xu's message of "Thu, 19 Oct 2023
 10:35:02 -0400")
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-2-farosas@suse.de>
 <87sf676kxt.fsf@secure.mitica> <ZTE+lmbvtYNDU80q@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 17:00:02 +0200
Message-ID: <871qdq4pzh.fsf@secure.mitica>
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

Peter Xu <peterx@redhat.com> wrote:
> Fabiano,
>
> Sorry to look at this series late; I messed up my inbox after I reworked my
> arrangement methodology of emails. ;)
>
> On Thu, Oct 19, 2023 at 11:06:06AM +0200, Juan Quintela wrote:
>> Fabiano Rosas <farosas@suse.de> wrote:
>> > The channels_ready semaphore is a global variable not linked to any
>> > single multifd channel. Waiting on it only means that "some" channel
>> > has become ready to send data. Since we need to address the channels
>> > by index (multifd_send_state->params[i]), that information adds
>> > nothing of value.
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
>> Notice that I fully agree that the sem is not needed for locking.
>> Locking is done with the mutex.  It is just used to make sure that we
>> don't busy loop on that loop.
>> 
>> And we use a sem, because it is the easiest way to know how many
>> channels are ready (even when we only care if there is one when we
>> arrive to that code).
>> 
>> We lost count of that counter, and we fixed that here:
>> 
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
>
> Juan,
>
> I can understand why send_pages needs that sem, but not when sync main.
> IOW, why multifd_send_sync_main() needs:
>
>         qemu_sem_wait(&multifd_send_state->channels_ready);
>
> If it has:
>
>         qemu_sem_wait(&p->sem_sync);
>
> How does a busy loop happen?

What does multifd_send_thread() for a SYNC packet.

static void *multifd_send_thread(void *opaque)
{
    while (true) {
        qemu_sem_post(&multifd_send_state->channels_ready);
        qemu_sem_wait(&p->sem);

        qemu_mutex_lock(&p->mutex);

        if (p->pending_job) {
            ....
            qemu_mutex_unlock(&p->mutex);

            if (flags & MULTIFD_FLAG_SYNC) {
                qemu_sem_post(&p->sem_sync);
            }
    }
}

I have simplified it a lot, but yot the idea.

See the 1st post of channel_ready().
We do it for every packet sent.  Even for the SYNC ones.

Now what multifd_send_page() does?

static int multifd_send_pages(QEMUFile *f)
{
    qemu_sem_wait(&multifd_send_state->channels_ready);
    ....
}

See, we are decreasing the numbers of channels_ready because we know we
are using one.

As we are sending packets for multifd_send_sync_main(), we need to do a
hack in multifd_send_thread() and say that sync packets don't
account. Or we need to decrease that semaphore in multifd_send_sync_main()

int multifd_send_sync_main(QEMUFile *f)
{
    ....
    for (i = 0; i < migrate_multifd_channels(); i++) {
        qemu_sem_wait(&multifd_send_state->channels_ready);
        ...
    }
}

And that is what we do here.
We didn't had this last line (not needed for making sure the channels
are ready here).

But needed to make sure that we are maintaining channels_ready exact.

Later, Juan.


