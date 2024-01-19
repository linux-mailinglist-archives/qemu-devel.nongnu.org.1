Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9698329CB
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 13:57:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQoQw-0006SN-7P; Fri, 19 Jan 2024 07:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQoQt-0006SC-B7
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 07:57:15 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQoQp-0006PF-Si
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 07:57:14 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CCCAC1F7F1;
 Fri, 19 Jan 2024 12:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705669029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DoYJOsyLE2A9E9DXRvLDcnilkf6/csqFFUEYNXLIs4s=;
 b=cEW0rKIdbjTeMSV4D406VwQbNaDI/0b7YFX2RrVOmFNTOPJ5tjEZx0LThwqeaStK/umOWc
 trrx515vMr/UsFbRXWNtzUoPNyNEPfetyYbVl6fy2kCkSoGGWkg0GHGneOXiMG4OLg4eMh
 d9hw/5OpE2Wk2AboSpjJQfGmtVI6i5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705669029;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DoYJOsyLE2A9E9DXRvLDcnilkf6/csqFFUEYNXLIs4s=;
 b=HAP2dqDbQjAGViko/T8dsydXYOjKzWa+fRtgzrqWP9z36sEwrhqI+Kjs4+KY3IppLHROjb
 7GGN3lrqhl7ZT5Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705669028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DoYJOsyLE2A9E9DXRvLDcnilkf6/csqFFUEYNXLIs4s=;
 b=BdsPcEIlItGfaAnZ42VUAQ8wqTGx130EbGyP3JPvp0dEWQ4cZOFjKNiy3ycEoRynXMOUml
 ZSeXIeaOY67TfeeJ1WDUd1jUmBUHXZ7Zd9ez0WmOtwgcxT4o0QFN7KinbkyYBw2vDv+mdw
 eBkQo4ZOctdX7JBGML7HySUbPWxRA5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705669028;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DoYJOsyLE2A9E9DXRvLDcnilkf6/csqFFUEYNXLIs4s=;
 b=AKSp7OSfCT6kvzjD6HV+NVbedMmw7SXSfwU/GuWdHh524qIvwTMCC2fmhiFDBINqrBgZkv
 Sfwek30K+kA1T6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56B86136F5;
 Fri, 19 Jan 2024 12:57:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id o+yzB6RxqmXtEwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Jan 2024 12:57:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Juan
 Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 18/30] migration/multifd: Allow receiving pages
 without packets
In-Reply-To: <ZanAW8sdXpGmTjHs@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-19-farosas@suse.de> <ZaY6E4tefb5DGEp9@x1n>
 <87wms9f2lc.fsf@suse.de> <ZanAW8sdXpGmTjHs@x1n>
Date: Fri, 19 Jan 2024 09:57:05 -0300
Message-ID: <87y1clzdjy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BdsPcEIl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AKSp7OSf
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -6.51
X-Rspamd-Queue-Id: CCCAC1F7F1
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Tue, Jan 16, 2024 at 05:25:03PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Mon, Nov 27, 2023 at 05:26:00PM -0300, Fabiano Rosas wrote:
>> >> Currently multifd does not need to have knowledge of pages on the
>> >> receiving side because all the information needed is within the
>> >> packets that come in the stream.
>> >> 
>> >> We're about to add support to fixed-ram migration, which cannot use
>> >> packets because it expects the ramblock section in the migration file
>> >> to contain only the guest pages data.
>> >> 
>> >> Add a data structure to transfer pages between the ram migration code
>> >> and the multifd receiving threads.
>> >> 
>> >> We don't want to reuse MultiFDPages_t for two reasons:
>> >> 
>> >> a) multifd threads don't really need to know about the data they're
>> >>    receiving.
>> >> 
>> >> b) the receiving side has to be stopped to load the pages, which means
>> >>    we can experiment with larger granularities than page size when
>> >>    transferring data.
>> >> 
>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >> ---
>> >> - stopped using MultiFDPages_t and added a new structure which can
>> >>   take offset + size
>> >> ---
>> >>  migration/multifd.c | 122 ++++++++++++++++++++++++++++++++++++++++++--
>> >>  migration/multifd.h |  20 ++++++++
>> >>  2 files changed, 138 insertions(+), 4 deletions(-)
>> >> 
>> >> diff --git a/migration/multifd.c b/migration/multifd.c
>> >> index c1381bdc21..7dfab2367a 100644
>> >> --- a/migration/multifd.c
>> >> +++ b/migration/multifd.c
>> >> @@ -142,17 +142,36 @@ static void nocomp_recv_cleanup(MultiFDRecvParams *p)
>> >>  static int nocomp_recv_data(MultiFDRecvParams *p, Error **errp)
>> >>  {
>> >>      uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
>> >> +    ERRP_GUARD();
>> >>  
>> >>      if (flags != MULTIFD_FLAG_NOCOMP) {
>> >>          error_setg(errp, "multifd %u: flags received %x flags expected %x",
>> >>                     p->id, flags, MULTIFD_FLAG_NOCOMP);
>> >>          return -1;
>> >>      }
>> >> -    for (int i = 0; i < p->normal_num; i++) {
>> >> -        p->iov[i].iov_base = p->host + p->normal[i];
>> >> -        p->iov[i].iov_len = p->page_size;
>> >> +
>> >> +    if (!migrate_multifd_packets()) {
>> >> +        MultiFDRecvData *data = p->data;
>> >> +        size_t ret;
>> >> +
>> >> +        ret = qio_channel_pread(p->c, (char *) data->opaque,
>> >> +                                data->size, data->file_offset, errp);
>> >> +        if (ret != data->size) {
>> >> +            error_prepend(errp,
>> >> +                          "multifd recv (%u): read 0x%zx, expected 0x%zx",
>> >> +                          p->id, ret, data->size);
>> >> +            return -1;
>> >> +        }
>> >> +
>> >> +        return 0;
>> >> +    } else {
>> >> +        for (int i = 0; i < p->normal_num; i++) {
>> >> +            p->iov[i].iov_base = p->host + p->normal[i];
>> >> +            p->iov[i].iov_len = p->page_size;
>> >> +        }
>> >> +
>> >> +        return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
>> >>      }
>> >
>> > I guess you managed to squash the file loads into "no compression" handler
>> > of multifd, but IMHO it's not as clean.
>> >
>> > Firstly, if to do so, we'd better make sure multifd-compression is not
>> > enabled anywhere together with fixed-ram.  I didn't yet see such protection
>> > in the series.  I think if it happens we should expect crashes because
>> > they'll go into zlib/zstd paths for the file.
>> 
>> Yes, we need some checks around this.
>> 
>> >
>> > IMHO the only model fixed-ram can share with multifd is the task management
>> > part, mutexes, semaphores, etc..
>> 
>> AFAIU, that's what multifd *is*. Compression would just be another
>> client of this task management code. This "nocomp" thing always felt off
>> to me.
>> 
>> > IIRC I used to mention that it'll be nice
>> > if we have simply a pool of threads so we can enqueue tasks.
>> 
>> Right, I don't disagree. However I don't think we can just show up with
>> a thread pool and start moving stuff into it. I think the safest way to
>> do this is to:
>> 
>> 1- Adapt multifd so that the client code is the sole responsible for the
>>    data being sent. No data knowledge by the multifd thread.
>> 
>>    With this, nothing should need to touch multifd threads code
>>    anymore. New clients just define their methods and prepare the data
>>    as they please.
>> 
>> 2- Move everything that is left into multifd. Zero pages, postcopy, etc.
>> 
>> With 1 and 2 we'd have a pretty good picture of what kinds of operations
>> we need to do and what are the requirements for the thread
>> infrastructure.
>> 
>> 3- Try to use existing abstractions within QEMU to replace
>>    multifd. Write from scratch if none are suitable.
>> 
>> What do you think? We could put an action plan in place and start
>> picking at it. My main concern is about what sorts of hidden assumptions
>> are present in the current code that we'd start discovering if we just
>> replaced it with something new.
>
> You plan sounds good.  Generalization (3) can happen even before (2), IMHO.
>
> I suppose you already have the wiki account working now, would you please
> add an entry into the todo page, with all these thoughts?
>
> https://wiki.qemu.org/ToDo/LiveMigration
>
> You can also mention you plan to look into it if you're taking the lead,
> then people know it's in progress.
>
> It can be under "cleanups" I assume.
>
>> 
>> > If that's too
>> > far away, would something like below closer to that?  What I'm thinking:
>> >
>> >   - patch 1: rename MultiFDMethods to MultiFDCompressMethods, this can
>> >     replace the other patch to do s/recv_pages/recv_data/
>> >
>> >   - patch 2: introduce MultiFDMethods (on top of MultiFDCompressMethods),
>> >     refactor the current code to provide the socket version of MultiFDMethods.
>> >
>> >   - patch 3: add the fixed-ram "file" version of MultiFDMethods
>> 
>> We also have zero page moving to multifd and compression accelerators
>> being developed. We need to take those into account. We might need an
>> ops structure that accounts for the current "phases" (setup, prepare,
>> recv, cleanup)[1], but within those also allow for composing arbitrary
>> data transformations.
>> 
>>  (1)- there's no equivalent to send_prepare on dst and no equivalent to
>>  recv_pages on src. We might need to add a recv_prepare and a send_pages
>>  hook. The fixed-ram migration for instance would benefit from being able
>>  to choose a different IO function to send data.
>> 
>> I'll send the patches moving zero pages to multifd once I find some
>> time, but another question I had was whether we should add zero page
>> detection as a new phase: setup - zero page detection - prepare - send -
>> cleanup.
>
> As you know I haven't yet followed those threads, only a rough memory on
> the zero page movement but that can be obsolete and I'll need to read what
> you have.  I agree all these are multifd-relevant, and we should consider
> them.
>
> Now the question is even if we will have a good thread model for multifd,
> whether file operations should be put into the compression layer (what you
> already did in this patch) or move it out.  Libvirt supports compression on
> images so I assume file operations shouldn't need to rely on compression,
> from that pov I think maybe it's better we leave all compression stuff
> along from file: perspective.
>

I'm thinking maybe divide multifd in phases (very similar to what we
have), but fold compression into one or more of those phases. So we'd
have:

send_prepare:
  if compression:
      ops->compression_prepare()

I'm working on something similar for zero pages. It's currently a 3
patch series from Juan, probably easier if we discuss there.

>> > MultiFDCompressMethods doesn't need to be used at all for "file" version of
>> > MultiFDMethods.
>> >
>> > Would that work?
>> 
>> We definitely need _something_ to help us stop adding code to the middle
>> of multifd_send_thread every time there's a new feature.
>> 
>> >
>> >> -    return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
>> >>  }
>> >>  
>> >>  static MultiFDMethods multifd_nocomp_ops = {
>> >> @@ -989,6 +1008,7 @@ int multifd_save_setup(Error **errp)
>> >>  
>> >>  struct {
>> >>      MultiFDRecvParams *params;
>> >> +    MultiFDRecvData *data;
>> >
>> > (If above would work, maybe we can split MultiFDRecvParams into two chunks,
>> >  one commonly used for both, one only for sockets?)
>> >
>> 
>> If we assume the use of packets in multifd is coupled to the socket
>> channel usage then yes. However, I suspect that what we might want is a
>> streaming migration vs. non-streaming migration abstraction. Because we
>> can still use packets with file migration after all.
>> 
>> >>      /* number of created threads */
>> >>      int count;
>> >>      /* syncs main thread and channels */
>> >> @@ -999,6 +1019,49 @@ struct {
>> >>      MultiFDMethods *ops;
>> >>  } *multifd_recv_state;
>> >>  
>> >> +int multifd_recv(void)
>> >> +{
>> >> +    int i;
>> >> +    static int next_recv_channel;
>> >> +    MultiFDRecvParams *p = NULL;
>> >> +    MultiFDRecvData *data = multifd_recv_state->data;
>> >> +
>> >> +    /*
>> >> +     * next_channel can remain from a previous migration that was
>> >> +     * using more channels, so ensure it doesn't overflow if the
>> >> +     * limit is lower now.
>> >> +     */
>> >> +    next_recv_channel %= migrate_multifd_channels();
>> >> +    for (i = next_recv_channel;; i = (i + 1) % migrate_multifd_channels()) {
>> >> +        p = &multifd_recv_state->params[i];
>> >> +
>> >> +        qemu_mutex_lock(&p->mutex);
>> >> +        if (p->quit) {
>> >> +            error_report("%s: channel %d has already quit!", __func__, i);
>> >> +            qemu_mutex_unlock(&p->mutex);
>> >> +            return -1;
>> >> +        }
>> >> +        if (!p->pending_job) {
>> >> +            p->pending_job++;
>> >> +            next_recv_channel = (i + 1) % migrate_multifd_channels();
>> >> +            break;
>> >> +        }
>> >> +        qemu_mutex_unlock(&p->mutex);
>> >> +    }
>> >> +    assert(p->data->size == 0);
>> >> +    multifd_recv_state->data = p->data;
>> >> +    p->data = data;
>> >> +    qemu_mutex_unlock(&p->mutex);
>> >> +    qemu_sem_post(&p->sem);
>> >> +
>> >> +    return 1;
>> >> +}
>> >
>> > PS: so if we have the pool model we can already mostly merge above code
>> > with multifd_send_pages().. because this will be a common helper to enqueue
>> > a task to a pool, no matter it's for writting (to file/socket) or reading
>> > (only from file).
>> >
>> >> +
>> >> +MultiFDRecvData *multifd_get_recv_data(void)
>> >> +{
>> >> +    return multifd_recv_state->data;
>> >> +}
>> >> +
>> >>  static void multifd_recv_terminate_threads(Error *err)
>> >>  {
>> >>      int i;
>> >> @@ -1020,6 +1083,7 @@ static void multifd_recv_terminate_threads(Error *err)
>> >>  
>> >>          qemu_mutex_lock(&p->mutex);
>> >>          p->quit = true;
>> >> +        qemu_sem_post(&p->sem);
>> >>          /*
>> >>           * We could arrive here for two reasons:
>> >>           *  - normal quit, i.e. everything went fine, just finished
>> >> @@ -1069,6 +1133,7 @@ void multifd_load_cleanup(void)
>> >>          p->c = NULL;
>> >>          qemu_mutex_destroy(&p->mutex);
>> >>          qemu_sem_destroy(&p->sem_sync);
>> >> +        qemu_sem_destroy(&p->sem);
>> >>          g_free(p->name);
>> >>          p->name = NULL;
>> >>          p->packet_len = 0;
>> >> @@ -1083,6 +1148,8 @@ void multifd_load_cleanup(void)
>> >>      qemu_sem_destroy(&multifd_recv_state->sem_sync);
>> >>      g_free(multifd_recv_state->params);
>> >>      multifd_recv_state->params = NULL;
>> >> +    g_free(multifd_recv_state->data);
>> >> +    multifd_recv_state->data = NULL;
>> >>      g_free(multifd_recv_state);
>> >>      multifd_recv_state = NULL;
>> >>  }
>> >> @@ -1094,6 +1161,21 @@ void multifd_recv_sync_main(void)
>> >>      if (!migrate_multifd() || !migrate_multifd_packets()) {
>> >
>> > [1]
>> >
>> >>          return;
>> >>      }
>> >> +
>> >> +    if (!migrate_multifd_packets()) {
>> >
>> > Hmm, isn't this checked already above at [1]?  Could this path ever trigger
>> > then?  Maybe we need to drop the one at [1]?
>> 
>> That was a rebase mistake.
>> 
>> >
>> > IIUC what you wanted to do here is relying on the last RAM_SAVE_FLAG_EOS in
>> > the image file to do a full flush to make sure all pages are loaded.
>> >
>> 
>> Bear with me if I take it slow with everything below here. The practical
>> effect of changing any of these is causing the threads to go off-sync
>> and that results in a time dependent bug where memory is not properly
>> migrated, which just comes up as an assert in check_guests_ram() in the
>> tests. It gets hard to reproduce and has taken me whole weeks to debug
>> before.
>
> Per-iteration sync_main is needed for file, but only on sender side, IIUC.
>
> Actually it's not needed for your use case at all to move the VM to file,
> because in that case we could already stop the VM first.  Now to be
> compatible with Libvirt's sake on live snapshot on Windows, we assume VM
> can run, then yes sync_main is needed at least on src, because otherwise
> the same page can be queued >1 times on different threads, and it's not
> guaranteed that the latest page will always land last.
>
> Said that, I don't think it's needed on recver side?  Because for both use
> cases (either "move to file", or "take a snapshot"), the loader is actually
> the same process where we read data from the file and relaunch the VM.  In
> that case there's no need to sync.

You're right.

> For socket-based multifd, the sync_main on recver side is only triggered
> when RAM_SAVE_FLAG_MULTIFD_FLUSH packet is received on 9.0 machine type.
> And then you'll also notice you don't even have that for file: URI multifd
> migrations, isn't it?

Right, because socket migration is a stream, so if done live they'll
need to sync. File migration takes everything from the file as is.

> When you said you hit a bug, did you have the sender side sync_main
> available, or you missed both?  I would expect that bug triggered because
> you missed the sync_main on src, not on dest.  For dest, IMHO we only need
> a last phase sync to make sure all RAM loaded before we relaunch the VM.

You might be right.

I hit several different bugs, synchronization issues, dirty bitmap
issues, threads finishing too soon, etc. They all have the same symptom:
one or more pages get "corrupted". So I cannot speak about any specific
one right now.

On that topic, I have played a bit with adding more information to the
file such as start and end of ramblocks or some greppable markers. Since
it is a file, it's way more prone to these kinds of debugging helpers
than the socket stream.

>
>> 
>> > You may want to be careful on the side effect of flush_after_each_section
>> > parameter:
>> >
>> >         case RAM_SAVE_FLAG_EOS:
>> >             /* normal exit */
>> >             if (migrate_multifd() &&
>> >                 migrate_multifd_flush_after_each_section()) {
>> >                 multifd_recv_sync_main();
>> >             }
>> >
>> > You may want to flush always for file?
>> 
>> Next patch restricts the setting of flush_after_each_section.
>> 
>> >
>> >> +        for (i = 0; i < migrate_multifd_channels(); i++) {
>> >> +            MultiFDRecvParams *p = &multifd_recv_state->params[i];
>> >> +
>> >> +            qemu_sem_post(&p->sem);
>> >> +            qemu_sem_wait(&p->sem_sync);
>> >> +
>> >> +            qemu_mutex_lock(&p->mutex);
>> >> +            assert(!p->pending_job || p->quit);
>> >> +            qemu_mutex_unlock(&p->mutex);
>> >> +        }
>> >> +        return;
>> >
>> > Btw, how does this kick off all the recv threads?  Is it because you did a
>> > sem_post(&sem) with p->pending_job==false this time?
>> 
>> Yes, when the last piece of memory is received, the thread will loop
>> around and hang at qemu_sem_wait(&p->sem):
>> 
>>         } else {
>>             /*
>>              * No packets, so we need to wait for the vmstate code to
>>              * give us work.
>>              */
>>             qemu_sem_wait(&p->sem);
>>             qemu_mutex_lock(&p->mutex);
>>             if (!p->pending_job) {
>>                 qemu_mutex_unlock(&p->mutex);
>>                 break;
>>             }
>>             has_data = !!p->data->size;
>>         }
>> 
>> So here we release the p->sem one last time so the thread can see
>> p->pending_job = false and proceed to inform it has finished:
>> 
>>     if (!use_packets) {
>>         qemu_sem_post(&p->sem_sync);
>>     }
>
> (see below)
>
>> 
>> > Maybe it's clearer to just set p->quit (or a global quite knob) somewhere?
>> > That'll be clear that this is a one-shot thing, only needed at the end of
>> > the file incoming migration.
>> >
>> 
>> Maybe I'm not following you, but the thread needs to check
>> p->pending_job before it knows there's no more work. And it can only do
>> that if the migration thread releases p->sem. Do you mean setting
>> p->quit on the thread instead of posting sem_sync? That's racy I think.
>
> I want to make the quit event not rely on pending_job.  I think we should
> allow pending_job==false and the thread should just sleep again.

Hmm, this could be a good thing. Because then we'll have only one source
of the "quit event" and we'd know all thread would wait until they see
that quit.

> That should also match recver side with sender, I remember we just reworked
> that so as to reference to the global "quit" flag:

Almost. The sender still has the ability of just exiting. So even though
it respects the 'exiting' flag, it might have already returned at the
end of the function.

>
> multifd_send_thread():
>         ...
>         qemu_sem_wait(&p->sem);
>         if (qatomic_read(&multifd_send_state->exiting)) {
>             break;
>         }
>         ...
>
> Something like that.
>
>> 
>> >> +    }
>> >> +
>> >>      for (i = 0; i < migrate_multifd_channels(); i++) {
>> >>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>> >>  
>> >> @@ -1156,6 +1238,18 @@ static void *multifd_recv_thread(void *opaque)
>> >>  
>> >>              p->total_normal_pages += p->normal_num;
>> >>              has_data = !!p->normal_num;
>> >> +        } else {
>> >> +            /*
>> >> +             * No packets, so we need to wait for the vmstate code to
>> >> +             * give us work.
>> >> +             */
>> >> +            qemu_sem_wait(&p->sem);
>> >> +            qemu_mutex_lock(&p->mutex);
>> >> +            if (!p->pending_job) {
>> >> +                qemu_mutex_unlock(&p->mutex);
>> >> +                break;
>> >> +            }
>> >> +            has_data = !!p->data->size;
>> >>          }
>> >>  
>> >>          qemu_mutex_unlock(&p->mutex);
>> >> @@ -1171,6 +1265,17 @@ static void *multifd_recv_thread(void *opaque)
>> >>              qemu_sem_post(&multifd_recv_state->sem_sync);
>> >>              qemu_sem_wait(&p->sem_sync);
>> >>          }
>> >> +
>> >> +        if (!use_packets) {
>> >> +            qemu_mutex_lock(&p->mutex);
>> >> +            p->data->size = 0;
>> >> +            p->pending_job--;
>> >> +            qemu_mutex_unlock(&p->mutex);
>> >> +        }
>> >> +    }
>> >> +
>> >> +    if (!use_packets) {
>> >> +        qemu_sem_post(&p->sem_sync);
>> >
>> > Currently sem_sync is only posted with MULTIFD_FLAG_SYNC flag.  We'd better
>> > be careful on reusing it.
>> >
>> > Maybe add some comment above recv_state->sem_sync?
>> >
>> >   /*
>> >    * For sockets: this is posted once for each MULTIFD_FLAG_SYNC flag.
>> >    *
>> >    * For files: this is only posted at the end of the file load to mark
>> >    *            completion of the load process.
>> >    */
>> >
>> 
>> Sure. I would rename it to sem_done if I could, but we already went
>> through that.
>> 
>> >>      }
>> >>  
>> >>      if (local_err) {
>> >> @@ -1205,6 +1310,10 @@ int multifd_load_setup(Error **errp)
>> >>      thread_count = migrate_multifd_channels();
>> >>      multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
>> >>      multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
>> >> +
>> >> +    multifd_recv_state->data = g_new0(MultiFDRecvData, 1);
>> >> +    multifd_recv_state->data->size = 0;
>> >> +
>> >>      qatomic_set(&multifd_recv_state->count, 0);
>> >>      qemu_sem_init(&multifd_recv_state->sem_sync, 0);
>> >>      multifd_recv_state->ops = multifd_ops[migrate_multifd_compression()];
>> >> @@ -1214,9 +1323,14 @@ int multifd_load_setup(Error **errp)
>> >>  
>> >>          qemu_mutex_init(&p->mutex);
>> >>          qemu_sem_init(&p->sem_sync, 0);
>> >> +        qemu_sem_init(&p->sem, 0);
>> >>          p->quit = false;
>> >> +        p->pending_job = 0;
>> >>          p->id = i;
>> >>  
>> >> +        p->data = g_new0(MultiFDRecvData, 1);
>> >> +        p->data->size = 0;
>> >> +
>> >>          if (use_packets) {
>> >>              p->packet_len = sizeof(MultiFDPacket_t)
>> >>                  + sizeof(uint64_t) * page_count;
>> >> diff --git a/migration/multifd.h b/migration/multifd.h
>> >> index 406d42dbae..abaf16c3f2 100644
>> >> --- a/migration/multifd.h
>> >> +++ b/migration/multifd.h
>> >> @@ -13,6 +13,8 @@
>> >>  #ifndef QEMU_MIGRATION_MULTIFD_H
>> >>  #define QEMU_MIGRATION_MULTIFD_H
>> >>  
>> >> +typedef struct MultiFDRecvData MultiFDRecvData;
>> >> +
>> >>  int multifd_save_setup(Error **errp);
>> >>  void multifd_save_cleanup(void);
>> >>  int multifd_load_setup(Error **errp);
>> >> @@ -24,6 +26,8 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
>> >>  void multifd_recv_sync_main(void);
>> >>  int multifd_send_sync_main(QEMUFile *f);
>> >>  int multifd_queue_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset);
>> >> +int multifd_recv(void);
>> >> +MultiFDRecvData *multifd_get_recv_data(void);
>> >>  
>> >>  /* Multifd Compression flags */
>> >>  #define MULTIFD_FLAG_SYNC (1 << 0)
>> >> @@ -66,6 +70,13 @@ typedef struct {
>> >>      RAMBlock *block;
>> >>  } MultiFDPages_t;
>> >>  
>> >> +struct MultiFDRecvData {
>> >> +    void *opaque;
>> >> +    size_t size;
>> >> +    /* for preadv */
>> >> +    off_t file_offset;
>> >> +};
>> >> +
>> >>  typedef struct {
>> >>      /* Fields are only written at creating/deletion time */
>> >>      /* No lock required for them, they are read only */
>> >> @@ -156,6 +167,8 @@ typedef struct {
>> >>  
>> >>      /* syncs main thread and channels */
>> >>      QemuSemaphore sem_sync;
>> >> +    /* sem where to wait for more work */
>> >> +    QemuSemaphore sem;
>> >>  
>> >>      /* this mutex protects the following parameters */
>> >>      QemuMutex mutex;
>> >> @@ -167,6 +180,13 @@ typedef struct {
>> >>      uint32_t flags;
>> >>      /* global number of generated multifd packets */
>> >>      uint64_t packet_num;
>> >> +    int pending_job;
>> >> +    /*
>> >> +     * The owner of 'data' depends of 'pending_job' value:
>> >> +     * pending_job == 0 -> migration_thread can use it.
>> >> +     * pending_job != 0 -> multifd_channel can use it.
>> >> +     */
>> >> +    MultiFDRecvData *data;
>> >
>> > Right after the main thread assigns a chunk of memory to load for a recv
>> > thread, the main thread job done, afaict.  I don't see how a race could
>> > happen here.
>> >
>> > I'm not sure, but I _think_ if we rely on p->quite or something similar to
>> > quite all recv threads, then this can be dropped?
>> >
>> 
>> We still need to know whether a channel is in use so we can skip to the
>> next.
>
> Oh, yes.
>
>> 
>> >>  
>> >>      /* thread local variables. No locking required */
>> >>  
>> >> -- 
>> >> 2.35.3
>> >> 
>> 

