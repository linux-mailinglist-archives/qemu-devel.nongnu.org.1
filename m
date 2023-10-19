Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1016A7CF55B
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:30:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQH1-0003zX-24; Thu, 19 Oct 2023 06:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtQGr-0003eg-3a
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:28:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtQGp-0007Bu-6V
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697711329;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=tneNM1XuIMOzOm3QJiTs/N6HyS35VchsfJFWb4Nf+RI=;
 b=X/M/6KbjKqPmAqskal6sy2G1AWeeevNuHWZp8BHHT+lcGqvDqvPKIeYvBpITo2o1yxUaGH
 4OSuZ1jlf7k41lK09Vylo87PeCzeWmrditsl0aRUXZlHyeUAcOB3QOwenc6JSQAh+z6fHL
 xOBvgd6X8TzB98aktjOkj+E3vzpSNds=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-u__1etECO62LuvngxvB50Q-1; Thu, 19 Oct 2023 06:28:42 -0400
X-MC-Unique: u__1etECO62LuvngxvB50Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32d33e3aea5so4957670f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697711321; x=1698316121;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tneNM1XuIMOzOm3QJiTs/N6HyS35VchsfJFWb4Nf+RI=;
 b=jQTo6VXdupfHklg1mvgptuLvj0sqxStchk19Kz4uPmhcARYm8z7cALtj7Pa6E8g73K
 VEmnAyqrUxleJJOpyTak7wuThzlYSU47Mpa3TqAWMHLTVOLV2cwpUqJBPXiPY4//DXFl
 nTsmmLRAcsC9Q06denqqndTFXSqeshBRFFFU9VsHn9cyp74H+fqbehvfILtpiy6KA4yp
 jNxhJxHKTWd2mG239ze8JPNW11f/ElXK7YAfCAvsdEg8BP5f9i0UgIYeHjkXE68etE0a
 LCVOedRmCyTuHDSpyt2epj4TmQ+qTGQDpg/EnEJY+SEX43VTBSZLdUhx46hfSfo6/Q/T
 BX4g==
X-Gm-Message-State: AOJu0Yy/Kh8vpl2aYW/FeBR/1oggLSJn8JPJoaYdgOEA2T3burHxQfF+
 hJiBUZMCQdkLUTDYaOqGsM1IECYXWUAJZVpH89DugMiFDOHKa6irA//UtEQUMOWrnQi9gCrlPJF
 rd6SoKHI26UMP9Qs=
X-Received: by 2002:adf:fccc:0:b0:32d:8e54:29fa with SMTP id
 f12-20020adffccc000000b0032d8e5429famr1118226wrs.44.1697711321568; 
 Thu, 19 Oct 2023 03:28:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAgOVsy8M5SLP6zpItFczC0OMHpHEL/c8CxNqKqOsS8axFKmJojQPqOCM3phwiEv6Jy+H1pw==
X-Received: by 2002:adf:fccc:0:b0:32d:8e54:29fa with SMTP id
 f12-20020adffccc000000b0032d8e5429famr1118212wrs.44.1697711321150; 
 Thu, 19 Oct 2023 03:28:41 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 v7-20020adfebc7000000b003196b1bb528sm4139311wrn.64.2023.10.19.03.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:28:40 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 3/6] migration/multifd: Decouple control flow
 from the SYNC packet
In-Reply-To: <20231012140651.13122-4-farosas@suse.de> (Fabiano Rosas's message
 of "Thu, 12 Oct 2023 11:06:48 -0300")
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-4-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 12:28:39 +0200
Message-ID: <87fs267voo.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> We currently use the 'sem_sync' semaphore on the sending side:
>
> 1) to know when the multifd_send_thread() has finished sending the
>    MULTIFD_FLAG_SYNC packet;
>
>   This is unnecessary. Multifd sends packets one by one and completion
>   is already bound by the 'sem' semaphore. The SYNC packet has nothing
>   special that would require it to have a separate semaphore on the
>   sending side.

What migration basically does is:

sync_dirty_bitmap()
while (too_much_dirty_memory)
   foreach(dirty_page)
      send(dirty_page)
   sync_dirty_bitmap()

I know, this is an over simplification, but it is enough to explain the
problem that this code tries to fix.

Once that we have multifd, we can have several channels, each of one
going through a different network connection.  Yes, networks are a black
box and there is no guarantees about how packets arrive on different
sockets.

In one iteration, page 99 is dirty.  We send it through channel 0.
We end the iteration and we synchronize the bitmap again.
We send the SYNC packet in both channels.
Page 99 is dirty again, and this time it gets sent through channel 1.

What we want, we want the communication to be:

    Channel 0          migration thread    Channel 1

(1) sent page 99
(2)                    sync bitmap
(3)                                        sent page 99

And we want destination to make sure that it never gets packet with page
99 from channel 0 AFTER page 99 from channel 1.

Notice, this is something that it is highly improbable to happen, but it
_can_ happen (and zero copy increases the probability of it).

So we create this SYNC packet that does that:

foreach (channel)
   create_job_to_send_sync() packet
foreach (channel)
   wait_until_it_has_sent_the_sync_packet()

Notice that this is the main migration thread, it will net send new work
to any channel until it receives the sem_sync for every channel.

Now, how do we deal on the target:

foreach (channel)
   wait(sem_sync)
foreach (channel)
   send(sem_sync)

So, trying to do my best at ASCII art, what happens when we end a round
of memory iteration

MigrationThread(send)           MigrationThread(recv)   channel_n (send)         channel_n(recv)

sync_bitmap()
foreach(channel)
   create_job_with_SYNC
   post(channel->sem)
                                                        wait(channel->sem)
                                                        write(SYNC)
                                                        post(channel->sem_sync)
foreach(channel)
   wait(channel->sem_sync)

write(MULTIFD_FLUSH)
                                                                                  read(SYNC)
                                                                                  post(main->sem_sync)
                                                                                  wait(channel->sem_sync)
                                read(MULTIFD_FLUSH)
                                foreach(channel)
                                   wait(main->sem_sync)
                                foreach(channel)
                                   post(channel->sem_sync)

Interesting points:

1- We guarantee that packets inside the same channel are in order.

2- Migration send thread don't send a MULTIFD_FLUSH packet until every
   channel has sent a SYNC packet

3- After reception of a SYNC packet.  A channel:
   a -> communicates to the main migration thread that it has received
        it (post(main->sem_sync))
   b -> it waits on (channel->sem_sync)

4- Main recv thread receives a MULTIFD_FLUSH
   a -> waits for every channel to say that it has received a SYNC
        packet
   b -> communicates to every channel that they can continue.

Send channels can send new data after the main channel does a
write(MULTIFD_FLUSH).  But reception channels will not read it until the
main recv thread is sure that every reception channel has received a
SYNC, so we are sure that (in the previous example) page 99 from thread
0 is already written.

Is it clearer now?

And yes, after discussion I will convert this email in documentation.

> 2) to wait for the multifd threads to finish before cleaning up;
>
>    This happens because multifd_send_sync_main() blocks
>    ram_save_complete() from finishing until the semaphore is
>    posted. This is surprising and not documented.
>
> Clarify the above situation by renaming 'sem_sync' to 'sem_done' and
> making the #2 usage the main one. Post to 'sem_sync' only when there's
> no more pending_jobs.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> I remove the parts about the receiving side. I wasn't sure about them
> and we don't need to mix the two. Potentially we need the sem_sync on
> the recv to ensure all channels wait before becoming available to read
> once again after a FLUSH.

I think this is not needed.  It is the source how decides when it is
needed to wait for all the packets in the middle.

Later, Juan.


