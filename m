Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCF68302BC
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 10:49:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ2X6-0008Mc-7H; Wed, 17 Jan 2024 04:48:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ2X4-0008MU-Tj
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 04:48:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ2X2-0003c2-Op
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 04:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705484904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e7Ul3wNieg6SsPr4N3Exitdv3G01HGugKS/5sbbqkCc=;
 b=TlPZemFVtDDWz/jtKznB6yh9X06CGkChRZzH2/dY2vUd//vwmVRg0UT8xNMYQZ2MONcits
 AsbFxQoKKPp/1y46F2YPiCxS5Y2mfa392F+PZkhF7QiTh2YyKJy/j/j4t/DzDDMuqf+YWk
 cVQlm58Fnogiuh34Z2dj1yFGtCGCx+c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-0zeYEAScPRWcJ1Wp371rQg-1; Wed, 17 Jan 2024 04:48:21 -0500
X-MC-Unique: 0zeYEAScPRWcJ1Wp371rQg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-28e7e94a63aso371944a91.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 01:48:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705484900; x=1706089700;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e7Ul3wNieg6SsPr4N3Exitdv3G01HGugKS/5sbbqkCc=;
 b=rfFxAkQXv6u9EsnadP+QWqeteJ8joP6rn2aMdrr8Nx/ABlrezQm5OXXXYAVF5JMHUl
 bMcMBQgv5CSgRvzp5V4JQ2pGsAQD7y9N2ZdjjnQRME+YZRBL37U/3pZb/5jGVdwOdFcl
 b36HmE3BM29103jP3tC/Ntle+jAy4iX0Y6cyTHx8sy7k1c46PNHzB0/W/j+PccNVqj78
 qoHLbzNMFEU9G729UxPVtFxmTQV04sa+84k7PSghP0Y/TP2HJBT+tscMPUBi3IoLHp3l
 u3eCKf++Z8uldkuG7KT1sTdnLAT04D/RBKm7x9oKMeSHpMwcR+G4BHn8QNOZPZ304lUI
 cHwA==
X-Gm-Message-State: AOJu0YxielT9s7aG4zeRZP+s48kwA/C7jF/vvoGNd9rxW2lz1JsIfbX8
 n1GUoi2495BcSWOwTbem/54UFNVeicOYlhtf0vlcJTunZAV8BU3K/EFY8HXXDkpwvyNqS5Fe45l
 PwJCDwb1YeCPK2D/3/VVqt0Hc5aEMlY4=
X-Received: by 2002:a05:6a20:2d26:b0:19a:e152:656 with SMTP id
 g38-20020a056a202d2600b0019ae1520656mr10490285pzl.3.1705484899740; 
 Wed, 17 Jan 2024 01:48:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHznu9zxulnltHgwLorhNN7rKiaILfwzvjVGuG4iTUpu6h73MXyO5uZd3Pa36zgwia9GyOGlw==
X-Received: by 2002:a05:6a20:2d26:b0:19a:e152:656 with SMTP id
 g38-20020a056a202d2600b0019ae1520656mr10490273pzl.3.1705484899422; 
 Wed, 17 Jan 2024 01:48:19 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 qn4-20020a17090b3d4400b0028b3539cd97sm15818069pjb.20.2024.01.17.01.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 01:48:18 -0800 (PST)
Date: Wed, 17 Jan 2024 17:48:14 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 15/30] io: Add a pwritev/preadv version that takes
 a discontiguous iovec
Message-ID: <ZaeiXra5hLSo0jnt@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-16-farosas@suse.de> <ZaYpKorhxEi3CEmv@x1n>
 <875xztxhyh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xztxhyh.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jan 16, 2024 at 03:15:50PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Nov 27, 2023 at 05:25:57PM -0300, Fabiano Rosas wrote:
> >> For the upcoming support to fixed-ram migration with multifd, we need
> >> to be able to accept an iovec array with non-contiguous data.
> >> 
> >> Add a pwritev and preadv version that splits the array into contiguous
> >> segments before writing. With that we can have the ram code continue
> >> to add pages in any order and the multifd code continue to send large
> >> arrays for reading and writing.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >> - split the API that was merged into a single function
> >> - use uintptr_t for compatibility with 32-bit
> >> ---
> >>  include/io/channel.h | 26 ++++++++++++++++
> >>  io/channel.c         | 70 ++++++++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 96 insertions(+)
> >> 
> >> diff --git a/include/io/channel.h b/include/io/channel.h
> >> index 7986c49c71..25383db5aa 100644
> >> --- a/include/io/channel.h
> >> +++ b/include/io/channel.h
> >> @@ -559,6 +559,19 @@ int qio_channel_close(QIOChannel *ioc,
> >>  ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
> >>                              size_t niov, off_t offset, Error **errp);
> >>  
> >> +/**
> >> + * qio_channel_pwritev_all:
> >> + * @ioc: the channel object
> >> + * @iov: the array of memory regions to write data from
> >> + * @niov: the length of the @iov array
> >> + * @offset: the iovec offset in the file where to write the data
> >> + * @errp: pointer to a NULL-initialized error object
> >> + *
> >> + * Returns: 0 if all bytes were written, or -1 on error
> >> + */
> >> +int qio_channel_pwritev_all(QIOChannel *ioc, const struct iovec *iov,
> >> +                            size_t niov, off_t offset, Error **errp);
> >> +
> >>  /**
> >>   * qio_channel_pwrite
> >>   * @ioc: the channel object
> >> @@ -595,6 +608,19 @@ ssize_t qio_channel_pwrite(QIOChannel *ioc, char *buf, size_t buflen,
> >>  ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
> >>                             size_t niov, off_t offset, Error **errp);
> >>  
> >> +/**
> >> + * qio_channel_preadv_all:
> >> + * @ioc: the channel object
> >> + * @iov: the array of memory regions to read data to
> >> + * @niov: the length of the @iov array
> >> + * @offset: the iovec offset in the file from where to read the data
> >> + * @errp: pointer to a NULL-initialized error object
> >> + *
> >> + * Returns: 0 if all bytes were read, or -1 on error
> >> + */
> >> +int qio_channel_preadv_all(QIOChannel *ioc, const struct iovec *iov,
> >> +                           size_t niov, off_t offset, Error **errp);
> >> +
> >>  /**
> >>   * qio_channel_pread
> >>   * @ioc: the channel object
> >> diff --git a/io/channel.c b/io/channel.c
> >> index a1f12f8e90..2f1745d052 100644
> >> --- a/io/channel.c
> >> +++ b/io/channel.c
> >> @@ -472,6 +472,69 @@ ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
> >>      return klass->io_pwritev(ioc, iov, niov, offset, errp);
> >>  }
> >>  
> >> +static int qio_channel_preadv_pwritev_contiguous(QIOChannel *ioc,
> >> +                                                 const struct iovec *iov,
> >> +                                                 size_t niov, off_t offset,
> >> +                                                 bool is_write, Error **errp)
> >> +{
> >> +    ssize_t ret = -1;
> >> +    int i, slice_idx, slice_num;
> >> +    uintptr_t base, next, file_offset;
> >> +    size_t len;
> >> +
> >> +    slice_idx = 0;
> >> +    slice_num = 1;
> >> +
> >> +    /*
> >> +     * If the iov array doesn't have contiguous elements, we need to
> >> +     * split it in slices because we only have one (file) 'offset' for
> >> +     * the whole iov. Do this here so callers don't need to break the
> >> +     * iov array themselves.
> >> +     */
> >> +    for (i = 0; i < niov; i++, slice_num++) {
> >> +        base = (uintptr_t) iov[i].iov_base;
> >> +
> >> +        if (i != niov - 1) {
> >> +            len = iov[i].iov_len;
> >> +            next = (uintptr_t) iov[i + 1].iov_base;
> >> +
> >> +            if (base + len == next) {
> >> +                continue;
> >> +            }
> >> +        }
> >> +
> >> +        /*
> >> +         * Use the offset of the first element of the segment that
> >> +         * we're sending.
> >> +         */
> >> +        file_offset = offset + (uintptr_t) iov[slice_idx].iov_base;
> >> +
> >> +        if (is_write) {
> >> +            ret = qio_channel_pwritev(ioc, &iov[slice_idx], slice_num,
> >> +                                      file_offset, errp);
> >> +        } else {
> >> +            ret = qio_channel_preadv(ioc, &iov[slice_idx], slice_num,
> >> +                                     file_offset, errp);
> >> +        }
> >> +
> >> +        if (ret < 0) {
> >> +            break;
> >> +        }
> >> +
> >> +        slice_idx += slice_num;
> >> +        slice_num = 0;
> >> +    }
> >> +
> >> +    return (ret < 0) ? -1 : 0;
> >> +}
> >> +
> >> +int qio_channel_pwritev_all(QIOChannel *ioc, const struct iovec *iov,
> >> +                            size_t niov, off_t offset, Error **errp)
> >> +{
> >> +    return qio_channel_preadv_pwritev_contiguous(ioc, iov, niov,
> >> +                                                 offset, true, errp);
> >> +}
> >
> > I'm not sure how Dan thinks about this, but I don't think this is pretty..
> >
> > With this implementation, iochannels' preadv/pwritev is completely not
> > compatible with most OSes now, afaiu.
> 
> This is internal QEMU code. I hope no one is expecting qio_channel_foo()
> to behave like some OS's foo() system call. We cannot guarantee that
> compatibility save for the simplest of wrappers.

I was expecting that when I started to read. :)

https://man.freebsd.org/cgi/man.cgi?query=pwritev
https://linux.die.net/man/2/pwritev

It's not "some OSes", it's mostly all.  I can understand you prefer such
approach, but even if so, shall we still try to avoid using pwritev/preadv
as the names?

> 
> >
> > The definition of offset in preadv/pwritev of current iochannel is hard to
> > understand.. if I read it right it'll later be set to:
> >       
> >                 /*
> >                  * If we subtract the host page now, we don't need to
> >                  * pass it into qio_channel_pwritev_all() below.
> >                  */
> >                 write_base = p->pages->block->pages_offset -
> >                     (uintptr_t)p->pages->block->host;
> >
> > Which I cannot easily tell what it is.. besides being an unsigned int.
> 
> This description was unfortunately dropped along the way:
> 
> "Since iovs can be non contiguous, we'd need a separate array on the
> side to carry an extra file offset for each of them, so I'm relying on
> the fact that iovs are all within a same host page and passing in an
> encoded offset that takes the host page into account."
> 
> > IIUC it's also based on the assumption that the host address of each iov
> > entry is linear to its offset in the file, but it may not be true for
> > future iochannel users of such interface called as pwritev/preadv.  So
> > error prone.
> 
> Yes, but it's also our choice whether to make this a generic API. We may
> have good reasons to consider a migration-specific function here.
> 
> > Would it be possible we keep using the offset array (p->pages->offset[x])?
> > We have it already anyway, right?  Wouldn't that be clearer?
> >
> 
> We'd have to make a copy of the array because p->pages is expected to
> change while the IO happens.

Hmm, I don't see why p->pages can change. IIUC p->pages will be there solid
at least until all IO syscalls are completed, then the next call to, e.g.,
multifd_send_pages() will swap that with multifd_send_state->pages.  But I
think I get your point, with below.

> And while we already have a copy in
> p->normal, my intention for multifd was to eliminate p->normal in the
> future, so it would be nice if we could avoid it.
> 
> Also, we cannot use p->pages->offset alone because we still need the
> pages_offset, i.e. the file offset where that ramblocks's pages begin.
> So that means also adding that to each element of the new array.
> 
> It would probably be overall clearer and less wasteful to pass in the
> host page address instead of an array of offsets. I don't see an issue
> with restricting the iovs to the same host page. The migration code is
> the only user for this code and AFAIK we don't have plans to change that
> invariant.

So I think I get your point now, the only concern (besides naming..) is,
I still want to avoid an interface that contains a field that is hard to
understand like write_base.

How about this?

  /**
   * multifd_write_ramblock_iov: Write IO vector (of ramblock) to channel
   *
   * @ioc: The iochannel to write to. The IOC must have pwritev/preadv
   *       interface must be implemented.
   * @iov: The IO vector to write.  All addresses must be within the
   *       ramblock host address range.
   * @iov_len: The IO vector size
   * @ramblock: The ramblock that covers all buffers in this IO vector
   */
  int multifd_write_ramblock_iov(ioc, iov, iov_len, ramblock);

-- 
Peter Xu


