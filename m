Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C657C4354
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 00:00:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqKlc-0001Q0-Tn; Tue, 10 Oct 2023 17:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqKlb-0001Pp-Mw
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 17:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqKlX-0006ox-7E
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 17:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696975186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m0XEu5dlk9u8cvLIMrgAgqxMVvR966Na0SDXVS376rM=;
 b=YHsYD5V70jXTHZ5meYEs6+2pvfXOgXr3T1ZInUT7HCHrev1pGoSCe7IV/sbm8YspWfKFu0
 rRhpD0SbRCSA+tlAIhR7VQFnS+utO6/gQj+P/n/Tsj1nU5oeizc9HGUwLvzqDVSvCx1Hc3
 hKr+hdTnGVYoCdMWUc3Ny1I07PpmHZM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-D2l0eptJNVqr5fhGhtwIPA-1; Tue, 10 Oct 2023 17:59:35 -0400
X-MC-Unique: D2l0eptJNVqr5fhGhtwIPA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4197878ffe9so20584241cf.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 14:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696975175; x=1697579975;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m0XEu5dlk9u8cvLIMrgAgqxMVvR966Na0SDXVS376rM=;
 b=ddEJdpV8M+MAz9zox1aXz8FvHRVTDLj8EvGgdGWEaORn/xoYBtDt6z6xbKTxyR4PM4
 Q4pSpY8YPbvWEsitydMuNWJo7UnPx98eGVlYw9PVscFEzqhFvy9uUaxStRVA3s+02Mug
 I62zd8BZ13okvWHfOCiMQvsQTp9c1AEnygRW9RKQNOh9ocO1jaawzxW6RFguYgqTswt0
 utep3Oue3MIuSOm9XWTD0KIc4Z8Ds1TH7NHHwttr5zZz8I6dfAINnvfM1iMWGYd6bVlR
 n1jk7EHdEsVBPPjpJ8FsZdmVkgsxpmWmLZYEnl0PlSr96J0mujczo6J8r0r0aEykSDO5
 8irA==
X-Gm-Message-State: AOJu0Yx5ZG+Iz8W03lsOrXLDl45JkdCT70L/TENtyr92KCLsKOH8b5eY
 GUMvoGQulH5DPnBLvYivfQzU3QD1IGujlJA+zy6PqEODzO2gehq9ASUgCZy7ThLDBM4ABmQdX73
 a8WIc7D9jkl0bt9w=
X-Received: by 2002:a05:6214:4012:b0:668:e10e:3ca8 with SMTP id
 kd18-20020a056214401200b00668e10e3ca8mr20776874qvb.6.1696975174603; 
 Tue, 10 Oct 2023 14:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEotIX5o8yq7FfyiNAMuep2MY7qo/vGcMpD7xFjy0QBUzF0E1nR1hXndUe0NWQum2ZksQ7v3Q==
X-Received: by 2002:a05:6214:4012:b0:668:e10e:3ca8 with SMTP id
 kd18-20020a056214401200b00668e10e3ca8mr20776859qvb.6.1696975174212; 
 Tue, 10 Oct 2023 14:59:34 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 o15-20020a0cf4cf000000b006590d020260sm5190205qvm.98.2023.10.10.14.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 14:59:33 -0700 (PDT)
Date: Tue, 10 Oct 2023 17:59:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH 1/3] migration/multifd: Move channels_ready semaphore
Message-ID: <ZSXJPmu4pk3Ln4kt@x1n>
References: <20230922145319.27380-1-farosas@suse.de>
 <20230922145319.27380-2-farosas@suse.de> <ZSW7dfSgV2dc6n0D@x1n>
 <87edi25f2u.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87edi25f2u.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Oct 10, 2023 at 06:43:05PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Sep 22, 2023 at 11:53:17AM -0300, Fabiano Rosas wrote:
> >> Commit d2026ee117 ("multifd: Fix the number of channels ready") moved
> >> the "post" of channels_ready to the start of the multifd_send_thread()
> >> loop and added a missing "wait" at multifd_send_sync_main(). While it
> >> does work, the placement of the wait goes against what the rest of the
> >> code does.
> >> 
> >> The sequence at multifd_send_thread() is:
> >> 
> >>     qemu_sem_post(&multifd_send_state->channels_ready);
> >>     qemu_sem_wait(&p->sem);
> >>     <work>
> >>     if (flags & MULTIFD_FLAG_SYNC) {
> >>         qemu_sem_post(&p->sem_sync);
> >>     }
> >> 
> >> Which means that the sending thread makes itself available
> >> (channels_ready) and waits for more work (sem). So the sequence in the
> >> migration thread should be to check if any channel is available
> >> (channels_ready), give it some work and set it off (sem):
> >> 
> >>     qemu_sem_wait(&multifd_send_state->channels_ready);
> >
> > Here it means we have at least 1 free send thread, then...
> >
> >>     <enqueue work>
> >>     qemu_sem_post(&p->sem);
> >
> > ... here we enqueue some work to the current thread (pointed by "i"), no
> > matter it's free or not, as "i" may not always point to the free thread.
> >
> 
> Yes. Which means channels_ready is currently useless. Since I posted
> this I realized that and have been working on a series to remove it
> completely.
> 
> ... I'm not opposed to "fixing" whatever needs to be fixed here as well, but
> I think removing it makes sense. I'll try to focus on that and post a v2
> here.

Happy to read it.

> 
> >>     if (flags & MULTIFD_FLAG_SYNC) {
> >>         qemu_sem_wait(&p->sem_sync);
> >>     }
> >
> > So I must confess I never fully digest how these sem/mutex/.. worked in
> > multifd, since the 1st day it's introduced.. so please take below comment
> > with a grain of salt..
> 
> We definitely need to clarify some things in the multifd
> design. Specially if we're going to use it as the main migration
> infrastructure moving forward.

Exactly.

> 
> I think what we lack is a design direction. I'm not really interested in
> how things work currently, but in how they *should* work based on the
> design.

Unfortunately we can't ignore how old code works; normally old code has its
reason to work like that. So the best way to go is trying to figure out
exactly how it works with the author, unless reaching the consensus it was
a design mistake after that conversation.

The luckiest thing here is we have the author around (Juan).  Let's discuss
thoroughly with him to make sure nothing is overlooked.

> 
> I'm confused about:
> 
> 1) why channels_ready exists? Were we trying to do some lockstep
> movement of: populate MultiFDPages -> release the sender thread -> move
> to next channel -> wait for it to become ready -> repeat. If so, that
> semaphore should be per-channel I think.
> 
> (my future proposal will be to remove the channels_ready semaphore)
> 
> 2) why do we need sem_sync? The SYNC flag makes sense, but why the
> source needs to sync with itself when syncing with dst?
> 
> (my proposal in this series is to rename sem_sync to sem_done and use it
> to track sending completion)
> 
> 3) why do we need to take the params lock? Shouldn't the semaphores
> already ensure that only one of the main thread and the sender thread
> will touch the params? The comment in multifd_send_pages says that we
> don't take locks for the pages structure, but that seems pointeless to
> me since we still lock the params structure.

Heh, so I'm not the only one who is confused with all these. :) You
reminded me of the days when I was reviewing the initial versions of
multifd, since when I failed to understand the code..

It's great to start discussing this again.  I'd say go ahead and propose
your patches; I'll read them.

> 
> > It seems to me that the current design allows >1 pending_job for a thread.
> > Here the current code didn't do "wait(channels_ready)" because it doesn't
> > need to - it simply always queue an MULTIFD_FLAG_SYNC pending job over the
> > thread, and wait for it to run.
> >
> > From that POV I think I can understand why "wait(channels_ready)" is not
> > needed here.  But then I'm confused because we don't have a real QUEUE to
> > put those requests; we simply apply this:
> >
> > multifd_send_sync_main():
> >         p->flags |= MULTIFD_FLAG_SYNC;
> >
> > Even if this send thread can be busy handling a batch of pages and
> > accessing p->flags.  I think it can actually race with the send thread
> > reading the flag at the exact same time:
> >
> > multifd_send_thread():
> >             multifd_send_fill_packet(p);
> >             flags = p->flags;  <-------------- here
> 
> It doesn't race in reading due to the p->mutex lock. But it looks like
> it could miss a newly set flag when it unlocks to start sending
> (qio_channel_write*).

Right. See my follow up email, I think the "race" is that it's
unpredictable on what will happen, and I think it's possible src qemu
generates an useless packet.  Not a real race.

If I'm doing the multifd thing, I'll avoid any form of modifying p->flags
if a job was assigned already to be clear.

Also please feel free to have a look at the SYNC issue I raised in that
same follow up email.  I hope I'm wrong somewhere.

-- 
Peter Xu


