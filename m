Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEF2830C6D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 19:07:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQAJ6-0000i0-CX; Wed, 17 Jan 2024 13:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQAIw-0000hY-ID
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 13:06:22 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQAIu-0002fm-4i
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 13:06:22 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 61B5E21D9C;
 Wed, 17 Jan 2024 18:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705514778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q5nYd9R4bf6NkKKDOCtWvG218CB7c+LoyvCN7V11Kcs=;
 b=TnxekOmXc+P0MbbVEEQEqa7xGbgxyBYr7aao88KieZ5qqKn5DLfqhEwcZp//Q7WgUuyljb
 LUeOgPdxY2fBvIhx1AIRTwN3SFrVedr9d1/vz/1eXLfAgdCfd7KlUpXg4lmH5iCAlPC3iN
 fpUk9HUuvRUizg6F6RU0zE5nUBfIvY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705514778;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q5nYd9R4bf6NkKKDOCtWvG218CB7c+LoyvCN7V11Kcs=;
 b=CoyoINeYUqydKC3fBaSTW7yK6shK4hBc5xxufJh+WKQwbiquBYzQhprBX6hM0UghtcH8ll
 6XPLbcLgNSoCFSAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705514778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q5nYd9R4bf6NkKKDOCtWvG218CB7c+LoyvCN7V11Kcs=;
 b=TnxekOmXc+P0MbbVEEQEqa7xGbgxyBYr7aao88KieZ5qqKn5DLfqhEwcZp//Q7WgUuyljb
 LUeOgPdxY2fBvIhx1AIRTwN3SFrVedr9d1/vz/1eXLfAgdCfd7KlUpXg4lmH5iCAlPC3iN
 fpUk9HUuvRUizg6F6RU0zE5nUBfIvY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705514778;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q5nYd9R4bf6NkKKDOCtWvG218CB7c+LoyvCN7V11Kcs=;
 b=CoyoINeYUqydKC3fBaSTW7yK6shK4hBc5xxufJh+WKQwbiquBYzQhprBX6hM0UghtcH8ll
 6XPLbcLgNSoCFSAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBFC713751;
 Wed, 17 Jan 2024 18:06:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IqvqJxkXqGU5SwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Jan 2024 18:06:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Juan
 Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 15/30] io: Add a pwritev/preadv version that
 takes a discontiguous iovec
In-Reply-To: <ZaeiXra5hLSo0jnt@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-16-farosas@suse.de> <ZaYpKorhxEi3CEmv@x1n>
 <875xztxhyh.fsf@suse.de> <ZaeiXra5hLSo0jnt@x1n>
Date: Wed, 17 Jan 2024 15:06:15 -0300
Message-ID: <87fryvdeco.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TnxekOmX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CoyoINeY
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
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -6.51
X-Rspamd-Queue-Id: 61B5E21D9C
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> On Tue, Jan 16, 2024 at 03:15:50PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Mon, Nov 27, 2023 at 05:25:57PM -0300, Fabiano Rosas wrote:
>> >> For the upcoming support to fixed-ram migration with multifd, we need
>> >> to be able to accept an iovec array with non-contiguous data.
>> >> 
>> >> Add a pwritev and preadv version that splits the array into contiguous
>> >> segments before writing. With that we can have the ram code continue
>> >> to add pages in any order and the multifd code continue to send large
>> >> arrays for reading and writing.
>> >> 
>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >> ---
>> >> - split the API that was merged into a single function
>> >> - use uintptr_t for compatibility with 32-bit
>> >> ---
>> >>  include/io/channel.h | 26 ++++++++++++++++
>> >>  io/channel.c         | 70 ++++++++++++++++++++++++++++++++++++++++++++
>> >>  2 files changed, 96 insertions(+)
>> >> 
>> >> diff --git a/include/io/channel.h b/include/io/channel.h
>> >> index 7986c49c71..25383db5aa 100644
>> >> --- a/include/io/channel.h
>> >> +++ b/include/io/channel.h
>> >> @@ -559,6 +559,19 @@ int qio_channel_close(QIOChannel *ioc,
>> >>  ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
>> >>                              size_t niov, off_t offset, Error **errp);
>> >>  
>> >> +/**
>> >> + * qio_channel_pwritev_all:
>> >> + * @ioc: the channel object
>> >> + * @iov: the array of memory regions to write data from
>> >> + * @niov: the length of the @iov array
>> >> + * @offset: the iovec offset in the file where to write the data
>> >> + * @errp: pointer to a NULL-initialized error object
>> >> + *
>> >> + * Returns: 0 if all bytes were written, or -1 on error
>> >> + */
>> >> +int qio_channel_pwritev_all(QIOChannel *ioc, const struct iovec *iov,
>> >> +                            size_t niov, off_t offset, Error **errp);
>> >> +
>> >>  /**
>> >>   * qio_channel_pwrite
>> >>   * @ioc: the channel object
>> >> @@ -595,6 +608,19 @@ ssize_t qio_channel_pwrite(QIOChannel *ioc, char *buf, size_t buflen,
>> >>  ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
>> >>                             size_t niov, off_t offset, Error **errp);
>> >>  
>> >> +/**
>> >> + * qio_channel_preadv_all:
>> >> + * @ioc: the channel object
>> >> + * @iov: the array of memory regions to read data to
>> >> + * @niov: the length of the @iov array
>> >> + * @offset: the iovec offset in the file from where to read the data
>> >> + * @errp: pointer to a NULL-initialized error object
>> >> + *
>> >> + * Returns: 0 if all bytes were read, or -1 on error
>> >> + */
>> >> +int qio_channel_preadv_all(QIOChannel *ioc, const struct iovec *iov,
>> >> +                           size_t niov, off_t offset, Error **errp);
>> >> +
>> >>  /**
>> >>   * qio_channel_pread
>> >>   * @ioc: the channel object
>> >> diff --git a/io/channel.c b/io/channel.c
>> >> index a1f12f8e90..2f1745d052 100644
>> >> --- a/io/channel.c
>> >> +++ b/io/channel.c
>> >> @@ -472,6 +472,69 @@ ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
>> >>      return klass->io_pwritev(ioc, iov, niov, offset, errp);
>> >>  }
>> >>  
>> >> +static int qio_channel_preadv_pwritev_contiguous(QIOChannel *ioc,
>> >> +                                                 const struct iovec *iov,
>> >> +                                                 size_t niov, off_t offset,
>> >> +                                                 bool is_write, Error **errp)
>> >> +{
>> >> +    ssize_t ret = -1;
>> >> +    int i, slice_idx, slice_num;
>> >> +    uintptr_t base, next, file_offset;
>> >> +    size_t len;
>> >> +
>> >> +    slice_idx = 0;
>> >> +    slice_num = 1;
>> >> +
>> >> +    /*
>> >> +     * If the iov array doesn't have contiguous elements, we need to
>> >> +     * split it in slices because we only have one (file) 'offset' for
>> >> +     * the whole iov. Do this here so callers don't need to break the
>> >> +     * iov array themselves.
>> >> +     */
>> >> +    for (i = 0; i < niov; i++, slice_num++) {
>> >> +        base = (uintptr_t) iov[i].iov_base;
>> >> +
>> >> +        if (i != niov - 1) {
>> >> +            len = iov[i].iov_len;
>> >> +            next = (uintptr_t) iov[i + 1].iov_base;
>> >> +
>> >> +            if (base + len == next) {
>> >> +                continue;
>> >> +            }
>> >> +        }
>> >> +
>> >> +        /*
>> >> +         * Use the offset of the first element of the segment that
>> >> +         * we're sending.
>> >> +         */
>> >> +        file_offset = offset + (uintptr_t) iov[slice_idx].iov_base;
>> >> +
>> >> +        if (is_write) {
>> >> +            ret = qio_channel_pwritev(ioc, &iov[slice_idx], slice_num,
>> >> +                                      file_offset, errp);
>> >> +        } else {
>> >> +            ret = qio_channel_preadv(ioc, &iov[slice_idx], slice_num,
>> >> +                                     file_offset, errp);
>> >> +        }
>> >> +
>> >> +        if (ret < 0) {
>> >> +            break;
>> >> +        }
>> >> +
>> >> +        slice_idx += slice_num;
>> >> +        slice_num = 0;
>> >> +    }
>> >> +
>> >> +    return (ret < 0) ? -1 : 0;
>> >> +}
>> >> +
>> >> +int qio_channel_pwritev_all(QIOChannel *ioc, const struct iovec *iov,
>> >> +                            size_t niov, off_t offset, Error **errp)
>> >> +{
>> >> +    return qio_channel_preadv_pwritev_contiguous(ioc, iov, niov,
>> >> +                                                 offset, true, errp);
>> >> +}
>> >
>> > I'm not sure how Dan thinks about this, but I don't think this is pretty..
>> >
>> > With this implementation, iochannels' preadv/pwritev is completely not
>> > compatible with most OSes now, afaiu.
>> 
>> This is internal QEMU code. I hope no one is expecting qio_channel_foo()
>> to behave like some OS's foo() system call. We cannot guarantee that
>> compatibility save for the simplest of wrappers.
>
> I was expecting that when I started to read. :)
>
> https://man.freebsd.org/cgi/man.cgi?query=pwritev
> https://linux.die.net/man/2/pwritev
>
> It's not "some OSes", it's mostly all.

What I mean is no one would ever replace a call to pwritev() with
qio_channel_pwritev() and expect the same behvior. We're not writing a
libc.

> I can understand you prefer such
> approach, but even if so, shall we still try to avoid using pwritev/preadv
> as the names?
>

Yes, it's probably better to avoid those if we're going to be doing any
extra operations.

>> 
>> >
>> > The definition of offset in preadv/pwritev of current iochannel is hard to
>> > understand.. if I read it right it'll later be set to:
>> >       
>> >                 /*
>> >                  * If we subtract the host page now, we don't need to
>> >                  * pass it into qio_channel_pwritev_all() below.
>> >                  */
>> >                 write_base = p->pages->block->pages_offset -
>> >                     (uintptr_t)p->pages->block->host;
>> >
>> > Which I cannot easily tell what it is.. besides being an unsigned int.
>> 
>> This description was unfortunately dropped along the way:
>> 
>> "Since iovs can be non contiguous, we'd need a separate array on the
>> side to carry an extra file offset for each of them, so I'm relying on
>> the fact that iovs are all within a same host page and passing in an
>> encoded offset that takes the host page into account."
>> 
>> > IIUC it's also based on the assumption that the host address of each iov
>> > entry is linear to its offset in the file, but it may not be true for
>> > future iochannel users of such interface called as pwritev/preadv.  So
>> > error prone.
>> 
>> Yes, but it's also our choice whether to make this a generic API. We may
>> have good reasons to consider a migration-specific function here.
>> 
>> > Would it be possible we keep using the offset array (p->pages->offset[x])?
>> > We have it already anyway, right?  Wouldn't that be clearer?
>> >
>> 
>> We'd have to make a copy of the array because p->pages is expected to
>> change while the IO happens.
>
> Hmm, I don't see why p->pages can change. IIUC p->pages will be there solid
> at least until all IO syscalls are completed, then the next call to, e.g.,
> multifd_send_pages() will swap that with multifd_send_state->pages.  But I
> think I get your point, with below.

Oh no, you're right. Because of p->pending_job. And thinking about
p->pending_job, wouldn't a trylock to the same job while being more
explicit?

    next_channel %= migrate_multifd_channels();
    for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
        p = &multifd_send_state->params[i];

        if(qemu_mutex_trylock(&p->mutex)) {
            if (p->quit) {
                error_report("%s: channel %d has already quit!", __func__, i);
                qemu_mutex_unlock(&p->mutex);
                return -1;
            }
            next_channel = (i + 1) % migrate_multifd_channels();
            break;
        } else {
            /* channel still busy, try the next one */
        }
    }
    multifd_send_state->pages = p->pages;
    p->pages = pages;
    qemu_mutex_unlock(&p->mutex);

>> And while we already have a copy in
>> p->normal, my intention for multifd was to eliminate p->normal in the
>> future, so it would be nice if we could avoid it.
>> 
>> Also, we cannot use p->pages->offset alone because we still need the
>> pages_offset, i.e. the file offset where that ramblocks's pages begin.
>> So that means also adding that to each element of the new array.
>> 
>> It would probably be overall clearer and less wasteful to pass in the
>> host page address instead of an array of offsets. I don't see an issue
>> with restricting the iovs to the same host page. The migration code is
>> the only user for this code and AFAIK we don't have plans to change that
>> invariant.
>
> So I think I get your point now, the only concern (besides naming..) is,
> I still want to avoid an interface that contains a field that is hard to
> understand like write_base.
>
> How about this?
>
>   /**
>    * multifd_write_ramblock_iov: Write IO vector (of ramblock) to channel
>    *
>    * @ioc: The iochannel to write to. The IOC must have pwritev/preadv
>    *       interface must be implemented.
>    * @iov: The IO vector to write.  All addresses must be within the
>    *       ramblock host address range.
>    * @iov_len: The IO vector size
>    * @ramblock: The ramblock that covers all buffers in this IO vector
>    */
>   int multifd_write_ramblock_iov(ioc, iov, iov_len, ramblock);

Ok, then I can take block->pages_offset and block->host from the
ramblock. I think I prefer something like this, that way we can be
explicit about the migration assumptions.

Thanks!

