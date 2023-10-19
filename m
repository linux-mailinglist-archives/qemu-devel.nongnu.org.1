Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E42267CFE95
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 17:46:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtVEI-00073n-O3; Thu, 19 Oct 2023 11:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtVEH-00070A-4Z
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:46:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtVEF-0007VW-5Y
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697730389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XAHZmjx0D1vdZGmqHoTiUz7Cddu/Se2XB60IwRQqxB8=;
 b=GdYo9SXn42xf9K7A40H+Rmbm67Y3c2GLioU25CVmvZJvzRZAOJd31BPgah0d3VtK2xyH57
 Xlc/cn+UpErBjPj9HLkS4TJx7Dl5SGg2kfnxmeBKJz1Jzef/AcZ5hvPTijnfNAIvveBN0+
 gEqYkeD43E5Lfy5ITwSyw/b/leEgaCo=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-BLdtpDhtNE6jAs6-hh7egw-1; Thu, 19 Oct 2023 11:46:28 -0400
X-MC-Unique: BLdtpDhtNE6jAs6-hh7egw-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3ae35e37ff8so2013006b6e.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 08:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697730387; x=1698335187;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAHZmjx0D1vdZGmqHoTiUz7Cddu/Se2XB60IwRQqxB8=;
 b=LHq7UDft/nkNsBuC3UiR02qBLnsao7mFv3Cstcn50+NojJ99LHz0lj8ddQdI8IYlgF
 HaXBjaGvt+jAYTfjpluWmT0Ew4pK3WRySATdYeIxd3uY5QllGRKFIIeWGmjr/uwknM2p
 6r3F0p5DWGMpGtKxEvGzNtviCWmSt2c9JiLY6zzE20cdS92pfhYuTqJiai8LW9rjr8z8
 PLPH1YP7iIxFlh8C7T15bdbTnL8IYYY+9FtxJgifQd1/CYL8lXuWMXQx/d875HQ5DvFW
 QxtPswQpGG2qgZjW7GxfJal9Ih77FwP6SKTa6Kk6wZI1MpbyqWmS6fuZV/lbDG4AjEnb
 rwag==
X-Gm-Message-State: AOJu0YwgjNGnITCosl9R/G6apfiyRIwNTrQrfmdfgFezxaAzFSuUibKo
 s0/Jn+FNtKO0MfCGVIdARJSgkMaltLSce+tE6euRYykH/4Kvstb6t5LwpwdSAy764yJSGQ+SuEQ
 lFihn+pVPvhxTl/4=
X-Received: by 2002:a05:6808:1b21:b0:3b2:e224:73d0 with SMTP id
 bx33-20020a0568081b2100b003b2e22473d0mr2425319oib.5.1697730387450; 
 Thu, 19 Oct 2023 08:46:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6k516bary9/RrhEi9mS98scF9oq4EdSLu6OOSZWYHg+K9gyKq75GLsy//AaZWVwNG4ug25A==
X-Received: by 2002:a05:6808:1b21:b0:3b2:e224:73d0 with SMTP id
 bx33-20020a0568081b2100b003b2e22473d0mr2425296oib.5.1697730387079; 
 Thu, 19 Oct 2023 08:46:27 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 ne14-20020a056214424e00b0065b0771f2edsm865089qvb.136.2023.10.19.08.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:46:26 -0700 (PDT)
Date: Thu, 19 Oct 2023 11:46:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 1/6] migration/multifd: Remove channels_ready
 semaphore
Message-ID: <ZTFPUUdJ5Y8/szaA@x1n>
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-2-farosas@suse.de>
 <87sf676kxt.fsf@secure.mitica> <ZTE+lmbvtYNDU80q@x1n>
 <871qdq4pzh.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871qdq4pzh.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Oct 19, 2023 at 05:00:02PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > Fabiano,
> >
> > Sorry to look at this series late; I messed up my inbox after I reworked my
> > arrangement methodology of emails. ;)
> >
> > On Thu, Oct 19, 2023 at 11:06:06AM +0200, Juan Quintela wrote:
> >> Fabiano Rosas <farosas@suse.de> wrote:
> >> > The channels_ready semaphore is a global variable not linked to any
> >> > single multifd channel. Waiting on it only means that "some" channel
> >> > has become ready to send data. Since we need to address the channels
> >> > by index (multifd_send_state->params[i]), that information adds
> >> > nothing of value.
> >> 
> >> NAK.
> >> 
> >> I disagree here O:-)
> >> 
> >> the reason why that channel exist is for multifd_send_pages()
> >> 
> >> And simplifying the function what it does is:
> >> 
> >> sem_wait(channels_ready);
> >> 
> >> for_each_channel()
> >>    look if it is empty()
> >> 
> >> But with the semaphore, we guarantee that when we go to the loop, there
> >> is a channel ready, so we know we donat busy wait searching for a
> >> channel that is free.
> >> 
> >> Notice that I fully agree that the sem is not needed for locking.
> >> Locking is done with the mutex.  It is just used to make sure that we
> >> don't busy loop on that loop.
> >> 
> >> And we use a sem, because it is the easiest way to know how many
> >> channels are ready (even when we only care if there is one when we
> >> arrive to that code).
> >> 
> >> We lost count of that counter, and we fixed that here:
> >> 
> >> commit d2026ee117147893f8d80f060cede6d872ecbd7f
> >> Author: Juan Quintela <quintela@redhat.com>
> >> Date:   Wed Apr 26 12:20:36 2023 +0200
> >> 
> >>     multifd: Fix the number of channels ready
> >> 
> >>     We don't wait in the sem when we are doing a sync_main.  Make it
> >> 
> >> And we were addressing the problem that some users where finding that we
> >> were busy waiting on that loop.
> >
> > Juan,
> >
> > I can understand why send_pages needs that sem, but not when sync main.
> > IOW, why multifd_send_sync_main() needs:
> >
> >         qemu_sem_wait(&multifd_send_state->channels_ready);
> >
> > If it has:
> >
> >         qemu_sem_wait(&p->sem_sync);
> >
> > How does a busy loop happen?
> 
> What does multifd_send_thread() for a SYNC packet.
> 
> static void *multifd_send_thread(void *opaque)
> {
>     while (true) {
>         qemu_sem_post(&multifd_send_state->channels_ready);
>         qemu_sem_wait(&p->sem);
> 
>         qemu_mutex_lock(&p->mutex);
> 
>         if (p->pending_job) {
>             ....
>             qemu_mutex_unlock(&p->mutex);
> 
>             if (flags & MULTIFD_FLAG_SYNC) {
>                 qemu_sem_post(&p->sem_sync);
>             }
>     }
> }
> 
> I have simplified it a lot, but yot the idea.
> 
> See the 1st post of channel_ready().
> We do it for every packet sent.  Even for the SYNC ones.
> 
> Now what multifd_send_page() does?
> 
> static int multifd_send_pages(QEMUFile *f)
> {
>     qemu_sem_wait(&multifd_send_state->channels_ready);
>     ....
> }
> 
> See, we are decreasing the numbers of channels_ready because we know we
> are using one.
> 
> As we are sending packets for multifd_send_sync_main(), we need to do a
> hack in multifd_send_thread() and say that sync packets don't
> account. Or we need to decrease that semaphore in multifd_send_sync_main()
> 
> int multifd_send_sync_main(QEMUFile *f)
> {
>     ....
>     for (i = 0; i < migrate_multifd_channels(); i++) {
>         qemu_sem_wait(&multifd_send_state->channels_ready);
>         ...
>     }
> }
> 
> And that is what we do here.
> We didn't had this last line (not needed for making sure the channels
> are ready here).
> 
> But needed to make sure that we are maintaining channels_ready exact.

I didn't expect it to be exact, I think that's the major part of confusion.
For example, I see this comment:

static void *multifd_send_thread(void *opaque)
       ...
        } else {
            qemu_mutex_unlock(&p->mutex);
            /* sometimes there are spurious wakeups */
        }

So do we have spurious wakeup anywhere for either p->sem or channels_ready?
They are related, because if we got spurious p->sem wakeups, then we'll
boost channels_ready one more time too there.

I think two ways to go here:

  - If we want to make them all exact: we'd figure out where are spurious
    wake ups and we fix all of them.  Or,

  - IMHO we can also make them not exact.  It means they can allow
    spurious, and code can actually also work like that.  One example is
    e.g. what happens if we get spurious wakeup in multifd_send_pages() for
    channels_ready?  We simply do some cpu loops as long as we double check
    with each channel again, we can even do better that if looping over N
    channels and see all busy, "goto retry" and wait on the sem again.

What do you think?

Thanks,

-- 
Peter Xu


