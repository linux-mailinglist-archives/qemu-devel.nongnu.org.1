Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D91EE9E6041
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Dec 2024 22:50:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJk0-0003fU-D4; Thu, 05 Dec 2024 16:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJJjy-0003fF-Am
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:50:30 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJJjw-00058y-7L
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:50:30 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 80DD91F393;
 Thu,  5 Dec 2024 21:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733435426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Ar+gf8ieFmC6vB7wBPVHCrpk2Q+qXWALFLdwxETb0E=;
 b=dzuzFIEFpEr0voJQ/xi8oBiMc+x+GUj1/HIO3IEukYR21SBZu0A5B6IbsJ0hxZoH9OvnVp
 q/PEyqUmVQrJ3aI/SzFtlLHt/YCcIMmcZ6ZJB1CqAFBzB2ooazehlNw0ewOzIckiByT+Gp
 guZ0hMmnY8UiDLJvNV3m0yxkdesA/GE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733435426;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Ar+gf8ieFmC6vB7wBPVHCrpk2Q+qXWALFLdwxETb0E=;
 b=Xcxu3kYu5krba9rEoAikYL8J0lCwoWJuWkD6VhXg3u3PsZKNaaCGKg3cRmNRFAWmt9WkJk
 7l/NsQdy9BqQCyBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dzuzFIEF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Xcxu3kYu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733435426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Ar+gf8ieFmC6vB7wBPVHCrpk2Q+qXWALFLdwxETb0E=;
 b=dzuzFIEFpEr0voJQ/xi8oBiMc+x+GUj1/HIO3IEukYR21SBZu0A5B6IbsJ0hxZoH9OvnVp
 q/PEyqUmVQrJ3aI/SzFtlLHt/YCcIMmcZ6ZJB1CqAFBzB2ooazehlNw0ewOzIckiByT+Gp
 guZ0hMmnY8UiDLJvNV3m0yxkdesA/GE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733435426;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Ar+gf8ieFmC6vB7wBPVHCrpk2Q+qXWALFLdwxETb0E=;
 b=Xcxu3kYu5krba9rEoAikYL8J0lCwoWJuWkD6VhXg3u3PsZKNaaCGKg3cRmNRFAWmt9WkJk
 7l/NsQdy9BqQCyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01702138A5;
 Thu,  5 Dec 2024 21:50:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id z53XLSEgUmclYgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 05 Dec 2024 21:50:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero"
 <mail@maciej.szmigiero.name>, Alex Williamson
 <alex.williamson@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 2/2] migration/multifd: Allow to sync with sender
 threads only
In-Reply-To: <Z1IOlJemNxrhOg3z@x1n>
References: <20241205185303.897010-1-peterx@redhat.com>
 <20241205185303.897010-3-peterx@redhat.com> <875xnxj37e.fsf@suse.de>
 <Z1IOlJemNxrhOg3z@x1n>
Date: Thu, 05 Dec 2024 18:50:23 -0300
Message-ID: <87h67hdckg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 80DD91F393
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Dec 05, 2024 at 05:16:05PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > Teach multifd_send_sync_main() to sync with threads only.
>> >
>> > We already have such requests, which is when mapped-ram is enabled with
>> > multifd.  In that case, no SYNC messages will be pushed to the stream when
>> > multifd syncs the sender threads because there's no destination threads
>> > waiting for that.  The whole point of the sync is to make sure all threads
>> > flushed their jobs.
>> >
>> > So fundamentally we have a request to do the sync in different ways:
>> >
>> >   - Either to sync the threads only,
>> >   - Or to sync the threads but also with the destination side
>> >
>> > Mapped-ram did it already because of the use_packet check in the sync
>> > handler of the sender thread.  It works.
>> >
>> > However it may stop working when e.g. VFIO may start to reuse multifd
>> > channels to push device states.  In that case VFIO has similar request on
>> > "thread-only sync" however we can't check a flag because such sync request
>> > can still come from RAM which needs the on-wire notifications.
>> >
>> > Paving way for that by allowing the multifd_send_sync_main() to specify
>> > what kind of sync the caller needs.  We can use it for mapped-ram already.
>> >
>> > No functional change intended.
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  migration/multifd.h        | 16 +++++++++++++---
>> >  migration/multifd-nocomp.c |  8 +++++++-
>> >  migration/multifd.c        | 14 ++++++++------
>> >  3 files changed, 28 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/migration/multifd.h b/migration/multifd.h
>> > index 50d58c0c9c..6b2f60a917 100644
>> > --- a/migration/multifd.h
>> > +++ b/migration/multifd.h
>> > @@ -19,6 +19,15 @@
>> >  typedef struct MultiFDRecvData MultiFDRecvData;
>> >  typedef struct MultiFDSendData MultiFDSendData;
>> >  
>> > +typedef enum {
>> > +    /* No sync request */
>> > +    MULTIFD_SYNC_NONE = 0,
>> > +    /* Sync on the sender threads without pushing messages */
>> > +    MULTIFD_SYNC_THREADS,
>> > +    /* Sync on the sender threads, meanwhile push "SYNC" message to the wire */
>> 
>> s/meanwhile//
>> 
>> > +    MULTIFD_SYNC_THREADS_AND_NOTIFY,
>> > +} MultiFDSyncReq;
>> 
>> I think I'd prefer the local vs. remote terminology I introduced in my
>> proposal [1] for cleaning up the multifd_flush_after_each_section() code:
>
> I'm ok with your naming, as long as the comment will explain.
>
>> 
>> LOCAL - sync the local threads between themselves
>> REMOTE - put a message on the stream for the remote end to perform a
>>          sync on their threads.
>> 
>> Down below you're passing the
>> MULTIFD_SYNC_THREADS_AND_NOTIFY into the send thread, but the "sync
>> threads" part of this is really done outside the thread, so that part
>> doesn't have a meaning inside the thread.
>> 
>> 1- https://lore.kernel.org/r/875xo8n4ue.fsf@suse.de
>> 
>> Also, please provide your input there^, it would be nice to unify the
>> terminology and reasoning about both changes.
>
> Yes, I'm mostly flushing my inbox in time order unless prioritized, so I'm
> getting there today or tomorrow.
>
>> 
>> > +
>> >  bool multifd_send_setup(void);
>> >  void multifd_send_shutdown(void);
>> >  void multifd_send_channel_created(void);
>> > @@ -28,7 +37,7 @@ void multifd_recv_shutdown(void);
>> >  bool multifd_recv_all_channels_created(void);
>> >  void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
>> >  void multifd_recv_sync_main(void);
>> > -int multifd_send_sync_main(void);
>> > +int multifd_send_sync_main(MultiFDSyncReq req);
>> >  bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
>> >  bool multifd_recv(void);
>> >  MultiFDRecvData *multifd_get_recv_data(void);
>> > @@ -143,7 +152,7 @@ typedef struct {
>> >      /* multifd flags for each packet */
>> >      uint32_t flags;
>> >      /*
>> > -     * The sender thread has work to do if either of below boolean is set.
>> > +     * The sender thread has work to do if either of below field is set.
>> >       *
>> >       * @pending_job:  a job is pending
>> >       * @pending_sync: a sync request is pending
>> > @@ -152,7 +161,8 @@ typedef struct {
>> >       * cleared by the multifd sender threads.
>> >       */
>> >      bool pending_job;
>> > -    bool pending_sync;
>> > +    MultiFDSyncReq pending_sync;
>> > +
>> >      MultiFDSendData *data;
>> >  
>> >      /* thread local variables. No locking required */
>> > diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
>> > index 55191152f9..f64c4c9abd 100644
>> > --- a/migration/multifd-nocomp.c
>> > +++ b/migration/multifd-nocomp.c
>> > @@ -345,6 +345,8 @@ retry:
>> >  
>> >  int multifd_ram_flush_and_sync(void)
>> >  {
>> > +    MultiFDSyncReq req;
>> > +
>> >      if (!migrate_multifd()) {
>> >          return 0;
>> >      }
>> > @@ -356,7 +358,11 @@ int multifd_ram_flush_and_sync(void)
>> >          }
>> >      }
>> >  
>> > -    return multifd_send_sync_main();
>> > +    /* File migrations only need to sync with threads */
>> > +    req = migrate_mapped_ram() ?
>> > +        MULTIFD_SYNC_THREADS : MULTIFD_SYNC_THREADS_AND_NOTIFY;
>> > +
>> > +    return multifd_send_sync_main(req);
>> >  }
>> >  
>> >  bool multifd_send_prepare_common(MultiFDSendParams *p)
>> > diff --git a/migration/multifd.c b/migration/multifd.c
>> > index 498e71fd10..77645e87a0 100644
>> > --- a/migration/multifd.c
>> > +++ b/migration/multifd.c
>> > @@ -523,7 +523,7 @@ static int multifd_zero_copy_flush(QIOChannel *c)
>> >      return ret;
>> >  }
>> >  
>> > -int multifd_send_sync_main(void)
>> > +int multifd_send_sync_main(MultiFDSyncReq req)
>> >  {
>> >      int i;
>> >      bool flush_zero_copy;
>> > @@ -543,8 +543,8 @@ int multifd_send_sync_main(void)
>> >           * We should be the only user so far, so not possible to be set by
>> >           * others concurrently.
>> >           */
>> > -        assert(qatomic_read(&p->pending_sync) == false);
>> > -        qatomic_set(&p->pending_sync, true);
>> > +        assert(qatomic_read(&p->pending_sync) == MULTIFD_SYNC_NONE);
>> > +        qatomic_set(&p->pending_sync, req);
>> 
>> Hmm, isn't it easier to skip the whole loop if req ==
>> MULTIFD_SYNC_THREADS? I don't remember why we kept this loop here for
>> mapped-ram.
>
> The "thread-only" version of request (or, in your preferred naming, "local"
> sync request) says: "please flush all the works enqueued in sender thread".
> Sync is still needed even for mapped-ram to make sure pwrite()s all land.
> Also needed for VFIO.

I think I remember now, what's needed is to release p->sem and wait on
p->sem_sync (one in each of these loops). We don't need to set the
pending_sync flag if it's not going to be used:

multifd_send_sync_main:
    for () {
        ...
        if (remote_sync) {
            assert(qatomic_read(&p->pending_sync) == false);
            qatomic_set(&p->pending_sync, true);
        }
        qemu_sem_post(&p->sem);
    }
    for () {
        ...
        qemu_sem_wait(&multifd_send_state->channels_ready);
        qemu_sem_wait(&p->sem_sync);
    }

in multifd_send_thread:

        if (qatomic_load_acquire(&p->pending_job)) {
            ...
            qatomic_store_release(&p->pending_job, false);
        } else if (qatomic_read(&p->pending_sync)) {
            ...
            p->flags = MULTIFD_FLAG_SYNC;
            qatomic_set(&p->pending_sync, false);
            qemu_sem_post(&p->sem_sync);
        } else {
            qemu_sem_post(&p->sem_sync);
        }

Is this clearer? Then we avoid the enum altogether, a boolean would
suffice.

>
>> 
>> >          qemu_sem_post(&p->sem);
>> >      }
>> >      for (i = 0; i < migrate_multifd_channels(); i++) {
>> > @@ -635,14 +635,16 @@ static void *multifd_send_thread(void *opaque)
>> >               */
>> >              qatomic_store_release(&p->pending_job, false);
>> >          } else {
>> > +            MultiFDSyncReq req = qatomic_read(&p->pending_sync);
>> > +
>> >              /*
>> >               * If not a normal job, must be a sync request.  Note that
>> >               * pending_sync is a standalone flag (unlike pending_job), so
>> >               * it doesn't require explicit memory barriers.
>> >               */
>> > -            assert(qatomic_read(&p->pending_sync));
>> > +            assert(req != MULTIFD_SYNC_NONE);
>> >  
>> > -            if (use_packets) {
>> > +            if (req == MULTIFD_SYNC_THREADS_AND_NOTIFY) {
>> 
>> Good, more explicit.
>> 
>> >                  p->flags = MULTIFD_FLAG_SYNC;
>> >                  multifd_send_fill_packet(p);
>> >                  ret = qio_channel_write_all(p->c, (void *)p->packet,
>> > @@ -654,7 +656,7 @@ static void *multifd_send_thread(void *opaque)
>> >                  stat64_add(&mig_stats.multifd_bytes, p->packet_len);
>> >              }
>> >  
>> > -            qatomic_set(&p->pending_sync, false);
>> > +            qatomic_set(&p->pending_sync, MULTIFD_SYNC_NONE);
>> 

