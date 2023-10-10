Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB877C42D4
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 23:42:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqKTX-0003oY-EZ; Tue, 10 Oct 2023 17:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqKTV-0003mx-9D
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 17:41:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqKTS-0002k7-3G
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 17:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696974064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=94sM3VDEjFnOB250jwnCHtjQMHQ8OY6g8VSCTAV2H+0=;
 b=du2oDeJVlo+tG1Fgew9RruNH1hIcm3h2DFUkr4VPWgNtCScm/h90WHxlZLZNPJ+ROFDF1T
 S+/u4F9xtxKTs7kfAqmnUomkLZvJZc/pvgDEPX4jbQ0RIcRVHnSAfLBgMBKNakDtUd2h6H
 YI2xr8fvhIpl/s39JGq0KR7lS3N2aSs=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-SNQCkbNXMN6wfphHRE3FFw-1; Tue, 10 Oct 2023 17:41:03 -0400
X-MC-Unique: SNQCkbNXMN6wfphHRE3FFw-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-d81b0c9295dso1194133276.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 14:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696974062; x=1697578862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94sM3VDEjFnOB250jwnCHtjQMHQ8OY6g8VSCTAV2H+0=;
 b=mFBS8hyJmofg+Ow4VZBcERACyRKszzwLEP6GdSB/djfqB6vNQeWFN/IfkazLLmK4Km
 aMtWsOrrIdAnwprScFoeI0Xnl4rjRP/nQXvpWAuBdj7TKtH3tJ4019R6UkluECiXj+ul
 HmoEXr5csDIZU/05DoeR358TcnzNGNCdEC6zmqoXaDK24SbSeGJY/StHGgmwoWSMSnot
 X635HrBnC9f8Bgq9dOti7hXeuLSz1xfHb/qDvBX5K18YNn0bkkH+/JEXY4iHDZvxbCkb
 jayAuTm3+8UqjEaGVn4ly+M55OOKww/4mXamYTT+sisdHlCqHHPcbfo7uTpL8AV46EOw
 bFPw==
X-Gm-Message-State: AOJu0Yybbs4db0p5DCr67ZitbjC3pemnA8GZ8PDqEf/Ob/4jjh8Jd5rB
 78VtGnRN9dNpZ7dyGuuWWOrTPuC6qwVGyEfyeQaEeMYELpMiLfm6H0qOWqnTG+TjRsiqZ+uG7GS
 fjgsBxonwZQzIKqI=
X-Received: by 2002:a25:69c8:0:b0:d7a:bcef:c2ab with SMTP id
 e191-20020a2569c8000000b00d7abcefc2abmr14190262ybc.4.1696974062461; 
 Tue, 10 Oct 2023 14:41:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtRC1R/Fmul5DQo3a3YZq7FydVuEtnTiJZCGkEgVxv1MT0X2GokADJOlErQjHd5QniInG8dA==
X-Received: by 2002:a25:69c8:0:b0:d7a:bcef:c2ab with SMTP id
 e191-20020a2569c8000000b00d7abcefc2abmr14190247ybc.4.1696974062025; 
 Tue, 10 Oct 2023 14:41:02 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 lf7-20020a0562142cc700b0065d0d0c752csm5079937qvb.116.2023.10.10.14.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 14:41:01 -0700 (PDT)
Date: Tue, 10 Oct 2023 17:40:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH 1/3] migration/multifd: Move channels_ready semaphore
Message-ID: <ZSXE67YbKr+Wr1/q@x1n>
References: <20230922145319.27380-1-farosas@suse.de>
 <20230922145319.27380-2-farosas@suse.de> <ZSW7dfSgV2dc6n0D@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSW7dfSgV2dc6n0D@x1n>
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

On Tue, Oct 10, 2023 at 05:00:37PM -0400, Peter Xu wrote:
> On Fri, Sep 22, 2023 at 11:53:17AM -0300, Fabiano Rosas wrote:
> > Commit d2026ee117 ("multifd: Fix the number of channels ready") moved
> > the "post" of channels_ready to the start of the multifd_send_thread()
> > loop and added a missing "wait" at multifd_send_sync_main(). While it
> > does work, the placement of the wait goes against what the rest of the
> > code does.
> > 
> > The sequence at multifd_send_thread() is:
> > 
> >     qemu_sem_post(&multifd_send_state->channels_ready);
> >     qemu_sem_wait(&p->sem);
> >     <work>
> >     if (flags & MULTIFD_FLAG_SYNC) {
> >         qemu_sem_post(&p->sem_sync);
> >     }
> > 
> > Which means that the sending thread makes itself available
> > (channels_ready) and waits for more work (sem). So the sequence in the
> > migration thread should be to check if any channel is available
> > (channels_ready), give it some work and set it off (sem):
> > 
> >     qemu_sem_wait(&multifd_send_state->channels_ready);
> 
> Here it means we have at least 1 free send thread, then...
> 
> >     <enqueue work>
> >     qemu_sem_post(&p->sem);
> 
> ... here we enqueue some work to the current thread (pointed by "i"), no
> matter it's free or not, as "i" may not always point to the free thread.
> 
> >     if (flags & MULTIFD_FLAG_SYNC) {
> >         qemu_sem_wait(&p->sem_sync);
> >     }
> 
> So I must confess I never fully digest how these sem/mutex/.. worked in
> multifd, since the 1st day it's introduced.. so please take below comment
> with a grain of salt..
> 
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
> 
> And whether it sees MULTIFD_FLAG_SYNC is unpredictable.  If it sees it,
> it'll post(sem_sync) in this round.  If it doesn't see it, it'll
> post(sem_sync) in the next round.  In whatever way, we'll generate an empty
> multifd packet to the wire I think, even though I don't know whether that's
> needed at all...

A correction: Since it's protected by p->mutex, I think we will only get an
empty multifd packet when we have pending_jobs==2.. because then we'll see
pending_job==2 with p->flags==SYNC, we send pages along with flags=SYNC to
dest, after that we kick sem_sync on src, then we found another
pending_jobs==1 even if p->flags will be zero.  The next multifd packet
will be only containing header (flags=0) and with no pages.

> 
> I'm not sure whether we should fix it in a more complete form, by not
> sending that empty multifd packet at all? Because that only contains the
> header without any real page inside, IIUC, so it seems to be a waste of
> resource.  Here what we want is only to kick sem_sync?

When thinking more about it, now I'm unsure whether sync is really working
as expected now in general..

IIUC SYNC message is used to flush all pages from source to destination.
We need that because we want to order the different versions of guest
pages, making sure the new version of a page always arrives later than its
old version, hence after all pages migrated we'll be sure all guest pages
on dest will be the latest.

Let's define "version X for page Y" as PyVx.  Version 1 of page 2 is P2V1.

So if without SYNC, a race can happen like this:

  sender 1         sender 2           receiver 1            receiver 2
  --------         --------           ----------            ----------

  send P1V1
          ...P1 changed content.. queued again in sender 2...
                   send P1V2
          ...If we got unlucky on receiving order of P1 versions...
                                                            receive P1V2
                                      receive P1V1

So if receiver 1 got P1V1 after receiver 2 got P1V2, we'll ultimately have
P1V1 on dst, which is an old data, causing data corrupt after migration.

Now we have the SYNC packet, but would it always work?  I'll discuss with
the latest RAM_SAVE_FLAG_MULTIFD_FLUSH sync message:

  src main    sender 1     sender 2    dst main  receiver 1  receiver 2
  --------    --------     --------    --------  ----------  ----------

              send P1V1
  send MULTIFD_FLUSH   
          ...P1 changed.. queued again in sender 2...
                           send P1V2
                                       receive MULTIFD_FLUSH
                                       (but since nothing received, flush nothing)
                                                             receive P1V2
                                                 receive P1V1

IIUC the problem is MULTIFD_FLUSH now does not rely on dest QEMU receiving
all existing pages sent.  Since the main channel is also a separate channel
from other multifd channels, I don't see why above cannot happen.

I think the problem will go away if e.g. src QEMU will need an SYNC_ACK
from dest qemu, making sure dest qemu digested all the sent pages.  Or, we
always send the same page via the same channel, e.g. by a hash(page_index).

I had a feeling that we have a bug, we just never hit it, because we don't
send P1V1 and P1V2 that close; we only do that for each whole iteration
looping over all ramblocks in find_dirty_block().  But it seems the bug is
possible, but I'll be very happy to be proven wrong by anyone..

-- 
Peter Xu


