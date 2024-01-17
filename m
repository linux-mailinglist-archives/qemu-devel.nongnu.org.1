Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 129E2830803
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:27:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6tG-0008CD-Bp; Wed, 17 Jan 2024 09:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rQ6tE-0008Bz-PV
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:27:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rQ6tC-0005oo-Me
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705501653;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7URkYapgNnSv0CJJDxOFDX2gRAQ5T3O93GtNU3lZSnk=;
 b=V5U5XqcG8lR05HDN5+LOo4EMtgEi/t+L0mCc/rZ7+J3xkAU45VrMyO5J1TE51gqbtjjTEt
 8oyr8Kqmh+KclNkM642CnqHygI3PoZog4pmbztB/zXer//Uf1T5NhbaSqkTFcrNYngsPjB
 my3Oy6krXmzINqWIxdJ01lddcbUHbcQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-Qz1dHHI2PRiN6Bk0LNxhOw-1; Wed,
 17 Jan 2024 09:27:31 -0500
X-MC-Unique: Qz1dHHI2PRiN6Bk0LNxhOw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFFCD282D3DF;
 Wed, 17 Jan 2024 14:27:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 876123C27;
 Wed, 17 Jan 2024 14:27:28 +0000 (UTC)
Date: Wed, 17 Jan 2024 14:27:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 15/30] io: Add a pwritev/preadv version that takes
 a discontiguous iovec
Message-ID: <Zafjzq5YDTfbYzV-@redhat.com>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-16-farosas@suse.de>
 <ZafKft029nRUKC4z@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZafKft029nRUKC4z@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Jan 17, 2024 at 12:39:26PM +0000, Daniel P. Berrangé wrote:
> On Mon, Nov 27, 2023 at 05:25:57PM -0300, Fabiano Rosas wrote:
> > For the upcoming support to fixed-ram migration with multifd, we need
> > to be able to accept an iovec array with non-contiguous data.
> > 
> > Add a pwritev and preadv version that splits the array into contiguous
> > segments before writing. With that we can have the ram code continue
> > to add pages in any order and the multifd code continue to send large
> > arrays for reading and writing.
> > 
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> > - split the API that was merged into a single function
> > - use uintptr_t for compatibility with 32-bit
> > ---
> >  include/io/channel.h | 26 ++++++++++++++++
> >  io/channel.c         | 70 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 96 insertions(+)
> > 
> > diff --git a/include/io/channel.h b/include/io/channel.h
> > index 7986c49c71..25383db5aa 100644
> > --- a/include/io/channel.h
> > +++ b/include/io/channel.h
> > @@ -559,6 +559,19 @@ int qio_channel_close(QIOChannel *ioc,
> >  ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
> >                              size_t niov, off_t offset, Error **errp);
> >  
> > +/**
> > + * qio_channel_pwritev_all:
> > + * @ioc: the channel object
> > + * @iov: the array of memory regions to write data from
> > + * @niov: the length of the @iov array
> > + * @offset: the iovec offset in the file where to write the data
> > + * @errp: pointer to a NULL-initialized error object
> > + *
> > + * Returns: 0 if all bytes were written, or -1 on error
> > + */
> > +int qio_channel_pwritev_all(QIOChannel *ioc, const struct iovec *iov,
> > +                            size_t niov, off_t offset, Error **errp);
> > +
> >  /**
> >   * qio_channel_pwrite
> >   * @ioc: the channel object
> > @@ -595,6 +608,19 @@ ssize_t qio_channel_pwrite(QIOChannel *ioc, char *buf, size_t buflen,
> >  ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
> >                             size_t niov, off_t offset, Error **errp);
> >  
> > +/**
> > + * qio_channel_preadv_all:
> > + * @ioc: the channel object
> > + * @iov: the array of memory regions to read data to
> > + * @niov: the length of the @iov array
> > + * @offset: the iovec offset in the file from where to read the data
> > + * @errp: pointer to a NULL-initialized error object
> > + *
> > + * Returns: 0 if all bytes were read, or -1 on error
> > + */
> > +int qio_channel_preadv_all(QIOChannel *ioc, const struct iovec *iov,
> > +                           size_t niov, off_t offset, Error **errp);
> > +
> >  /**
> >   * qio_channel_pread
> >   * @ioc: the channel object
> > diff --git a/io/channel.c b/io/channel.c
> > index a1f12f8e90..2f1745d052 100644
> > --- a/io/channel.c
> > +++ b/io/channel.c
> > @@ -472,6 +472,69 @@ ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
> >      return klass->io_pwritev(ioc, iov, niov, offset, errp);
> >  }
> >  
> > +static int qio_channel_preadv_pwritev_contiguous(QIOChannel *ioc,
> > +                                                 const struct iovec *iov,
> > +                                                 size_t niov, off_t offset,
> > +                                                 bool is_write, Error **errp)
> > +{
> > +    ssize_t ret = -1;
> > +    int i, slice_idx, slice_num;
> > +    uintptr_t base, next, file_offset;
> > +    size_t len;
> > +
> > +    slice_idx = 0;
> > +    slice_num = 1;
> > +
> > +    /*
> > +     * If the iov array doesn't have contiguous elements, we need to
> > +     * split it in slices because we only have one (file) 'offset' for
> > +     * the whole iov. Do this here so callers don't need to break the
> > +     * iov array themselves.
> > +     */
> > +    for (i = 0; i < niov; i++, slice_num++) {
> > +        base = (uintptr_t) iov[i].iov_base;
> > +
> > +        if (i != niov - 1) {
> > +            len = iov[i].iov_len;
> > +            next = (uintptr_t) iov[i + 1].iov_base;
> > +
> > +            if (base + len == next) {
> > +                continue;
> > +            }
> > +        }
> > +
> > +        /*
> > +         * Use the offset of the first element of the segment that
> > +         * we're sending.
> > +         */
> > +        file_offset = offset + (uintptr_t) iov[slice_idx].iov_base;
> > +
> > +        if (is_write) {
> > +            ret = qio_channel_pwritev(ioc, &iov[slice_idx], slice_num,
> > +                                      file_offset, errp);
> > +        } else {
> > +            ret = qio_channel_preadv(ioc, &iov[slice_idx], slice_num,
> > +                                     file_offset, errp);
> > +        }
> 
> iov_base is the address of a pointer in RAM, so could be
> potentially any 64-bit value.
> 
> We're assigning file_offset to this pointer address with an
> user supplied offset, and then using it as an offset on disk.
> First this could result in 64-bit overflow when 'offset' is
> added to 'iov_base', and second this could result in a file
> that's 16 Exabytes in size (with holes of course).
> 
> I don't get how this is supposed to work, or be used ?

I feel like this whole method might become clearer if we separated
out the logic for merging memory adjacent iovecs.

How about adding a 'iov_collapse' method in iov.h / iov.c to do
the merging and then let the actual I/O code be simpler ?

> 
> > +
> > +        if (ret < 0) {
> > +            break;
> > +        }
> > +
> > +        slice_idx += slice_num;
> > +        slice_num = 0;
> > +    }
> > +
> > +    return (ret < 0) ? -1 : 0;
> > +}



> > +
> > +int qio_channel_pwritev_all(QIOChannel *ioc, const struct iovec *iov,
> > +                            size_t niov, off_t offset, Error **errp)
> > +{
> > +    return qio_channel_preadv_pwritev_contiguous(ioc, iov, niov,
> > +                                                 offset, true, errp);
> > +}
> > +
> >  ssize_t qio_channel_pwrite(QIOChannel *ioc, char *buf, size_t buflen,
> >                             off_t offset, Error **errp)
> >  {
> > @@ -501,6 +564,13 @@ ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
> >      return klass->io_preadv(ioc, iov, niov, offset, errp);
> >  }
> >  
> > +int qio_channel_preadv_all(QIOChannel *ioc, const struct iovec *iov,
> > +                           size_t niov, off_t offset, Error **errp)
> > +{
> > +    return qio_channel_preadv_pwritev_contiguous(ioc, iov, niov,
> > +                                                 offset, false, errp);
> > +}
> > +
> >  ssize_t qio_channel_pread(QIOChannel *ioc, char *buf, size_t buflen,
> >                            off_t offset, Error **errp)
> >  {
> > -- 
> > 2.35.3
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


