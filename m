Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED79D7CFDE3
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 17:32:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtUzr-0005r3-MQ; Thu, 19 Oct 2023 11:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtUze-0005kF-Ea
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtUzb-0006XD-J6
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697729480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/nrgFXRIIEIwC54pWoL/DcX9Gtkfq+aEIvZff2LbdIg=;
 b=R17TqcV7/Mb9sZmGje6gwdVcU0e+7vgB9DZ0fNLZlnq727Rvnvctup8CQmPC+JQFI4QEYG
 rqcEG+l7jKn7IfLMMRRhyAJO4McwNorIPsN3WktebxqHic75eJJ/wQbdo4bxc+IRb/aI2g
 i1UleXr/xfNFW7o9IEr/mEnhthsa4kk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-ISFjelbCPva5C6BW-mlO6Q-1; Thu, 19 Oct 2023 11:31:17 -0400
X-MC-Unique: ISFjelbCPva5C6BW-mlO6Q-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-637948b24bdso17653066d6.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 08:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697729477; x=1698334277;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nrgFXRIIEIwC54pWoL/DcX9Gtkfq+aEIvZff2LbdIg=;
 b=kHWY5pVw1BNymKChUIlF1Q1zPzZv2r3Dc9yBGUWVsBEK2XHVbvotbYEbh1EKei0KBh
 iAd8Ert56qd9tK7YXqd4p/5y3WEaxuT86JYqJnZ3xXVD23U3ta7uzYSRrTlqkKbeyi0Y
 vfDtJy1BlosCjoQ1GWl+TrDCrFeGSBEeR1XlViPYAv2VP5lrL6fmmdemGyu1QQdRZyHg
 7m35+bm6sWloXV8TVArvh+B3Uxi/YLskUMV3SNoM3OBIZPGivw5gnmfCatWFqIKrXgAy
 D5QIhIcdsnkaSOVDCnuITgzeBPe1cXreaLEn7ktgogZk1snJEj2vgP361B5UE7yjuMEe
 cCJw==
X-Gm-Message-State: AOJu0YxbfGNWC0MusLU8BBp0Q4gIxp7lsYvHmHA5UJwvDAZw1KNsUyHB
 dmdZ3gRTFJzxWk69qvzbVqKDqVamUbjyUjf7gz+U5P5uP4S/8POM0VLP1SXKBufwxhcgvZQpr6p
 rn8hSFXKG8IcQDvs=
X-Received: by 2002:a0c:edac:0:b0:66d:4caa:8d8c with SMTP id
 h12-20020a0cedac000000b0066d4caa8d8cmr2602090qvr.4.1697729477329; 
 Thu, 19 Oct 2023 08:31:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgW0Dkl/ur8iW2J+78KtViO9vaUgT1k6mgj/ur0GE+S7hKTL5F9YnhwOFDRgniz1Yq+emegQ==
X-Received: by 2002:a0c:edac:0:b0:66d:4caa:8d8c with SMTP id
 h12-20020a0cedac000000b0066d4caa8d8cmr2602056qvr.4.1697729476974; 
 Thu, 19 Oct 2023 08:31:16 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 l15-20020ad4452f000000b0064c1b27bf2dsm846871qvu.140.2023.10.19.08.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:31:16 -0700 (PDT)
Date: Thu, 19 Oct 2023 11:31:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 3/6] migration/multifd: Decouple control flow from
 the SYNC packet
Message-ID: <ZTFLw/cgrOcSJTxG@x1n>
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-4-farosas@suse.de>
 <87fs267voo.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fs267voo.fsf@secure.mitica>
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

On Thu, Oct 19, 2023 at 12:28:39PM +0200, Juan Quintela wrote:
> Fabiano Rosas <farosas@suse.de> wrote:
> > We currently use the 'sem_sync' semaphore on the sending side:
> >
> > 1) to know when the multifd_send_thread() has finished sending the
> >    MULTIFD_FLAG_SYNC packet;
> >
> >   This is unnecessary. Multifd sends packets one by one and completion
> >   is already bound by the 'sem' semaphore. The SYNC packet has nothing
> >   special that would require it to have a separate semaphore on the
> >   sending side.
> 
> What migration basically does is:
> 
> sync_dirty_bitmap()
> while (too_much_dirty_memory)
>    foreach(dirty_page)
>       send(dirty_page)
>    sync_dirty_bitmap()
> 
> I know, this is an over simplification, but it is enough to explain the
> problem that this code tries to fix.
> 
> Once that we have multifd, we can have several channels, each of one
> going through a different network connection.  Yes, networks are a black
> box and there is no guarantees about how packets arrive on different
> sockets.
> 
> In one iteration, page 99 is dirty.  We send it through channel 0.
> We end the iteration and we synchronize the bitmap again.
> We send the SYNC packet in both channels.
> Page 99 is dirty again, and this time it gets sent through channel 1.
> 
> What we want, we want the communication to be:
> 
>     Channel 0          migration thread    Channel 1
> 
> (1) sent page 99
> (2)                    sync bitmap
> (3)                                        sent page 99
> 
> And we want destination to make sure that it never gets packet with page
> 99 from channel 0 AFTER page 99 from channel 1.
> 
> Notice, this is something that it is highly improbable to happen, but it
> _can_ happen (and zero copy increases the probability of it).
> 
> So we create this SYNC packet that does that:
> 
> foreach (channel)
>    create_job_to_send_sync() packet
> foreach (channel)
>    wait_until_it_has_sent_the_sync_packet()
> 
> Notice that this is the main migration thread, it will net send new work
> to any channel until it receives the sem_sync for every channel.
> 
> Now, how do we deal on the target:
> 
> foreach (channel)
>    wait(sem_sync)
> foreach (channel)
>    send(sem_sync)
> 
> So, trying to do my best at ASCII art, what happens when we end a round
> of memory iteration
> 
> MigrationThread(send)           MigrationThread(recv)   channel_n (send)         channel_n(recv)
> 
> sync_bitmap()
> foreach(channel)
>    create_job_with_SYNC
>    post(channel->sem)
>                                                         wait(channel->sem)
>                                                         write(SYNC)
>                                                         post(channel->sem_sync)
> foreach(channel)
>    wait(channel->sem_sync)
> 
> write(MULTIFD_FLUSH)
>                                                                                   read(SYNC)
>                                                                                   post(main->sem_sync)
>                                                                                   wait(channel->sem_sync)
>                                 read(MULTIFD_FLUSH)
>                                 foreach(channel)
>                                    wait(main->sem_sync)
>                                 foreach(channel)
>                                    post(channel->sem_sync)

Hmm, I think I missed the fact that the main thread also sends something
(in this case, MULTIFD_FLUSH), when I was raising the question in the other
thread on sync.

Now I think it should work indeed.

I'm not sure what is the case before this commit, though:

        commit 294e5a4034e81b3d8db03b4e0f691386f20d6ed3
        Author: Juan Quintela <quintela@redhat.com>
        Date:   Tue Jun 21 13:36:11 2022 +0200

        multifd: Only flush once each full round of memory

> 
> Interesting points:
> 
> 1- We guarantee that packets inside the same channel are in order.
> 
> 2- Migration send thread don't send a MULTIFD_FLUSH packet until every
>    channel has sent a SYNC packet

IMHO this is not required? Main thread can send MULTIFD_FLUSH early too, I
think the important thing is dest recv threads will always sync with this
one, early or late.  Then it's impossible that one new page appears earlier
than another old version (in another channel) because when reading the new
page dest threads must have digested the old.

> 
> 3- After reception of a SYNC packet.  A channel:
>    a -> communicates to the main migration thread that it has received
>         it (post(main->sem_sync))
>    b -> it waits on (channel->sem_sync)
> 
> 4- Main recv thread receives a MULTIFD_FLUSH
>    a -> waits for every channel to say that it has received a SYNC
>         packet
>    b -> communicates to every channel that they can continue.
> 
> Send channels can send new data after the main channel does a
> write(MULTIFD_FLUSH).  But reception channels will not read it until the
> main recv thread is sure that every reception channel has received a
> SYNC, so we are sure that (in the previous example) page 99 from thread
> 0 is already written.
> 
> Is it clearer now?
> 
> And yes, after discussion I will convert this email in documentation.

Please do so, and I suggest we start to do more with docs/*.rst and not use
wiki pages unless necessary, then doc is with code.

We may consider create docs/migration/ and this can belong to multifd.rst.

Thanks,

-- 
Peter Xu


