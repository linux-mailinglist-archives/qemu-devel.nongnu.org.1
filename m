Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8247D4AE3
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:51:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvD7A-0005aA-LI; Tue, 24 Oct 2023 04:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvD78-0005Zd-Re
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:50:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvD74-0005Qc-Mt
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698137409;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=bO734sQBuPKJJxXECXehoMv5yBruQWgkoKCScAVxALU=;
 b=cdhx0Lr3jS31DjVVXAQ0gBeToDFFFjVn0fyeK0B9ylSqvvi8fjxq8AWEPyoKW4WijN7qHW
 vuoPEOR1tkJQPNNdXWxJnu8MIM2Vwilj2+DfsjrkX3ZK4zaDzBrpdZhsW2DSj6HyoZ6Muj
 MCpUGQmifUGHcbv8G92wVXmBzvEfOug=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-IFPEqkTvPRyvjVoWbspKdw-1; Tue, 24 Oct 2023 04:50:06 -0400
X-MC-Unique: IFPEqkTvPRyvjVoWbspKdw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAFF08370E5;
 Tue, 24 Oct 2023 08:50:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23CD7492BFB;
 Tue, 24 Oct 2023 08:50:03 +0000 (UTC)
Date: Tue, 24 Oct 2023 09:50:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v2 22/29] io: Add a pwritev/preadv version that takes a
 discontiguous iovec
Message-ID: <ZTeFOUf6UzWUIXoY@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-23-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023203608.26370-23-farosas@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Oct 23, 2023 at 05:36:01PM -0300, Fabiano Rosas wrote:
> For the upcoming support to fixed-ram migration with multifd, we need
> to be able to accept an iovec array with non-contiguous data.
> 
> Add a pwritev and preadv version that splits the array into contiguous
> segments before writing. With that we can have the ram code continue
> to add pages in any order and the multifd code continue to send large
> arrays for reading and writing.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> Since iovs can be non contiguous, we'd need a separate array on the
> side to carry an extra file offset for each of them, so I'm relying on
> the fact that iovs are all within a same host page and passing in an
> encoded offset that takes the host page into account.
> ---
>  include/io/channel.h | 50 +++++++++++++++++++++++++++
>  io/channel.c         | 82 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 132 insertions(+)
> 
> diff --git a/include/io/channel.h b/include/io/channel.h
> index a8181d576a..51a99fb9f6 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -33,8 +33,10 @@ OBJECT_DECLARE_TYPE(QIOChannel, QIOChannelClass,
>  #define QIO_CHANNEL_ERR_BLOCK -2
>  
>  #define QIO_CHANNEL_WRITE_FLAG_ZERO_COPY 0x1
> +#define QIO_CHANNEL_WRITE_FLAG_WITH_OFFSET 0x2
>  
>  #define QIO_CHANNEL_READ_FLAG_MSG_PEEK 0x1
> +#define QIO_CHANNEL_READ_FLAG_WITH_OFFSET 0x2
>  
>  typedef enum QIOChannelFeature QIOChannelFeature;
>  
> @@ -559,6 +561,30 @@ int qio_channel_close(QIOChannel *ioc,
>  ssize_t qio_channel_pwritev_full(QIOChannel *ioc, const struct iovec *iov,
>                                   size_t niov, off_t offset, Error **errp);
>  
> +/**
> + * qio_channel_write_full_all:
> + * @ioc: the channel object
> + * @iov: the array of memory regions to write data from
> + * @niov: the length of the @iov array
> + * @offset: the iovec offset in the file where to write the data
> + * @fds: an array of file handles to send
> + * @nfds: number of file handles in @fds
> + * @flags: write flags (QIO_CHANNEL_WRITE_FLAG_*)
> + * @errp: pointer to a NULL-initialized error object
> + *
> + *
> + * Selects between a writev or pwritev channel writer function.
> + *
> + * If QIO_CHANNEL_WRITE_FLAG_OFFSET is passed in flags, pwritev is
> + * used and @offset is expected to be a meaningful value, @fds and
> + * @nfds are ignored; otherwise uses writev and @offset is ignored.
> + *
> + * Returns: 0 if all bytes were written, or -1 on error
> + */
> +int qio_channel_write_full_all(QIOChannel *ioc, const struct iovec *iov,
> +                               size_t niov, off_t offset, int *fds, size_t nfds,
> +                               int flags, Error **errp);
> +
>  /**
>   * qio_channel_pwritev
>   * @ioc: the channel object
> @@ -595,6 +621,30 @@ ssize_t qio_channel_pwritev(QIOChannel *ioc, char *buf, size_t buflen,
>  ssize_t qio_channel_preadv_full(QIOChannel *ioc, const struct iovec *iov,
>                                  size_t niov, off_t offset, Error **errp);
>  
> +/**
> + * qio_channel_read_full_all:
> + * @ioc: the channel object
> + * @iov: the array of memory regions to read data to
> + * @niov: the length of the @iov array
> + * @offset: the iovec offset in the file from where to read the data
> + * @fds: an array of file handles to send
> + * @nfds: number of file handles in @fds
> + * @flags: read flags (QIO_CHANNEL_READ_FLAG_*)
> + * @errp: pointer to a NULL-initialized error object
> + *
> + *
> + * Selects between a readv or preadv channel reader function.
> + *
> + * If QIO_CHANNEL_READ_FLAG_OFFSET is passed in flags, preadv is
> + * used and @offset is expected to be a meaningful value, @fds and
> + * @nfds are ignored; otherwise uses readv and @offset is ignored.
> + *
> + * Returns: 0 if all bytes were read, or -1 on error
> + */
> +int qio_channel_read_full_all(QIOChannel *ioc, const struct iovec *iov,
> +                              size_t niov, off_t offset,
> +                              int flags, Error **errp);
> +
>  /**
>   * qio_channel_preadv
>   * @ioc: the channel object
> diff --git a/io/channel.c b/io/channel.c
> index 770d61ea00..648b68451d 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -472,6 +472,76 @@ ssize_t qio_channel_pwritev_full(QIOChannel *ioc, const struct iovec *iov,
>      return klass->io_pwritev(ioc, iov, niov, offset, errp);
>  }
>  
> +static int qio_channel_preadv_pwritev_contiguous(QIOChannel *ioc,
> +                                                 const struct iovec *iov,
> +                                                 size_t niov, off_t offset,
> +                                                 bool is_write, Error **errp)
> +{
> +    ssize_t ret;
> +    int i, slice_idx, slice_num;
> +    uint64_t base, next, file_offset;
> +    size_t len;
> +
> +    slice_idx = 0;
> +    slice_num = 1;
> +
> +    /*
> +     * If the iov array doesn't have contiguous elements, we need to
> +     * split it in slices because we only have one (file) 'offset' for
> +     * the whole iov. Do this here so callers don't need to break the
> +     * iov array themselves.
> +     */
> +    for (i = 0; i < niov; i++, slice_num++) {
> +        base = (uint64_t) iov[i].iov_base;
> +
> +        if (i != niov - 1) {
> +            len = iov[i].iov_len;
> +            next = (uint64_t) iov[i + 1].iov_base;
> +
> +            if (base + len == next) {
> +                continue;
> +            }
> +        }
> +
> +        /*
> +         * Use the offset of the first element of the segment that
> +         * we're sending.
> +         */
> +        file_offset = offset + (uint64_t) iov[slice_idx].iov_base;
> +
> +        if (is_write) {
> +            ret = qio_channel_pwritev_full(ioc, &iov[slice_idx], slice_num,
> +                                           file_offset, errp);
> +        } else {
> +            ret = qio_channel_preadv_full(ioc, &iov[slice_idx], slice_num,
> +                                          file_offset, errp);
> +        }
> +
> +        if (ret < 0) {
> +            break;
> +        }
> +
> +        slice_idx += slice_num;
> +        slice_num = 0;
> +    }
> +
> +    return (ret < 0) ? -1 : 0;
> +}
> +
> +int qio_channel_write_full_all(QIOChannel *ioc,
> +                                const struct iovec *iov,
> +                                size_t niov, off_t offset,
> +                                int *fds, size_t nfds,
> +                                int flags, Error **errp)
> +{
> +    if (flags & QIO_CHANNEL_WRITE_FLAG_WITH_OFFSET) {
> +        return qio_channel_preadv_pwritev_contiguous(ioc, iov, niov,
> +                                                     offset, true, errp);
> +    }
> +
> +    return qio_channel_writev_full_all(ioc, iov, niov, NULL, 0, flags, errp);
> +}

I don't much like this as a design, as it is two completely different
APIs shoved into one facade that is easy to misunderstand and misuse.
fds, nfds, and other flags values are all silently ignored in the first
branch. offset is silently ignored in the second branch. In fact there's
no functional benefit to the second branch at all, over calling the
existing apis.

I think that there should be qio_channel_{pwritev,preadv}_all
methods that take the 'flags' parameter.

> +
>  ssize_t qio_channel_pwritev(QIOChannel *ioc, char *buf, size_t buflen,
>                              off_t offset, Error **errp)
>  {
> @@ -501,6 +571,18 @@ ssize_t qio_channel_preadv_full(QIOChannel *ioc, const struct iovec *iov,
>      return klass->io_preadv(ioc, iov, niov, offset, errp);
>  }
>  
> +int qio_channel_read_full_all(QIOChannel *ioc, const struct iovec *iov,
> +                              size_t niov, off_t offset,
> +                              int flags, Error **errp)
> +{
> +    if (flags & QIO_CHANNEL_READ_FLAG_WITH_OFFSET) {
> +        return qio_channel_preadv_pwritev_contiguous(ioc, iov, niov,
> +                                                     offset, false, errp);
> +    }
> +
> +    return qio_channel_readv_full_all(ioc, iov, niov, NULL, NULL, errp);
> +}
> +
>  ssize_t qio_channel_preadv(QIOChannel *ioc, char *buf, size_t buflen,
>                             off_t offset, Error **errp)
>  {
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


