Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCB17D49DB
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:20:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvCdF-0004Wg-6F; Tue, 24 Oct 2023 04:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvCdC-0004WI-2W
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvCd9-0006nT-I5
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698135553;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=TPij2V05uvbtyn/G8vlgL3snFQZ/m613FKrZXZG/Pbc=;
 b=b17GA4SIcO3KTdur+KmFZEgbPE/pLwJcqZjFjEKV/EWkt8DPregspFcVQQjxbTlIZif9FO
 pzFxpMD0DiRsPMcoZTWJ++RA/6HuJvKpoDcJWXEOyGrfg56kNu3/5pflm+XSJFfwxT+BkO
 oWvcC2KPWx43qhlsV0hjwL9G757Dqp0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-7GolCiNYOMO5O7FM-bSx3w-1; Tue, 24 Oct 2023 04:19:04 -0400
X-MC-Unique: 7GolCiNYOMO5O7FM-bSx3w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC23680F925;
 Tue, 24 Oct 2023 08:19:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09707492BD9;
 Tue, 24 Oct 2023 08:19:00 +0000 (UTC)
Date: Tue, 24 Oct 2023 09:18:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 10/29] io: Add generic pwritev/preadv interface
Message-ID: <ZTd97Eb9RwLrsJsN@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-11-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023203608.26370-11-farosas@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

On Mon, Oct 23, 2023 at 05:35:49PM -0300, Fabiano Rosas wrote:
> From: Nikolay Borisov <nborisov@suse.com>
> 
> Introduce basic pwritev/preadv support in the generic channel layer.
> Specific implementation will follow for the file channel as this is
> required in order to support migration streams with fixed location of
> each ram page.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  include/io/channel.h | 82 ++++++++++++++++++++++++++++++++++++++++++++
>  io/channel.c         | 58 +++++++++++++++++++++++++++++++
>  2 files changed, 140 insertions(+)
> 
> diff --git a/include/io/channel.h b/include/io/channel.h
> index fcb19fd672..a8181d576a 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -131,6 +131,16 @@ struct QIOChannelClass {
>                             Error **errp);
>  
>      /* Optional callbacks */
> +    ssize_t (*io_pwritev)(QIOChannel *ioc,
> +                          const struct iovec *iov,
> +                          size_t niov,
> +                          off_t offset,
> +                          Error **errp);
> +    ssize_t (*io_preadv)(QIOChannel *ioc,
> +                         const struct iovec *iov,
> +                         size_t niov,
> +                         off_t offset,
> +                         Error **errp);
>      int (*io_shutdown)(QIOChannel *ioc,
>                         QIOChannelShutdown how,
>                         Error **errp);
> @@ -529,6 +539,78 @@ void qio_channel_set_follow_coroutine_ctx(QIOChannel *ioc, bool enabled);
>  int qio_channel_close(QIOChannel *ioc,
>                        Error **errp);
>  
> +/**
> + * qio_channel_pwritev_full
> + * @ioc: the channel object
> + * @iov: the array of memory regions to write data from
> + * @niov: the length of the @iov array
> + * @offset: offset in the channel where writes should begin
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Not all implementations will support this facility, so may report
> + * an error. To avoid errors, the caller may check for the feature
> + * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
> + *
> + * Behaves as qio_channel_writev_full, apart from not supporting
> + * sending of file handles as well as beginning the write at the
> + * passed @offset
> + *
> + */
> +ssize_t qio_channel_pwritev_full(QIOChannel *ioc, const struct iovec *iov,
> +                                 size_t niov, off_t offset, Error **errp);

In terms of naming this should be  just "_pwritev".

We don't support FD passing, so the "_full" suffix is not
appropriate

> +
> +/**
> + * qio_channel_pwritev
> + * @ioc: the channel object
> + * @buf: the memory region to write data into
> + * @buflen: the number of bytes to @buf
> + * @offset: offset in the channel where writes should begin
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Not all implementations will support this facility, so may report
> + * an error. To avoid errors, the caller may check for the feature
> + * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
> + *
> + */
> +ssize_t qio_channel_pwritev(QIOChannel *ioc, char *buf, size_t buflen,
> +                            off_t offset, Error **errp);

This isn't passing a vector of buffers, so it should be just
"pwrite", not "pwritev".

> +
> +/**
> + * qio_channel_preadv_full
> + * @ioc: the channel object
> + * @iov: the array of memory regions to read data into
> + * @niov: the length of the @iov array
> + * @offset: offset in the channel where writes should begin
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Not all implementations will support this facility, so may report
> + * an error.  To avoid errors, the caller may check for the feature
> + * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
> + *
> + * Behaves as qio_channel_readv_full, apart from not supporting
> + * receiving of file handles as well as beginning the read at the
> + * passed @offset
> + *
> + */
> +ssize_t qio_channel_preadv_full(QIOChannel *ioc, const struct iovec *iov,
> +                                size_t niov, off_t offset, Error **errp);

"preadv"


> +
> +/**
> + * qio_channel_preadv
> + * @ioc: the channel object
> + * @buf: the memory region to write data into
> + * @buflen: the number of bytes to @buf
> + * @offset: offset in the channel where writes should begin
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Not all implementations will support this facility, so may report
> + * an error.  To avoid errors, the caller may check for the feature
> + * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
> + *
> + */
> +ssize_t qio_channel_preadv(QIOChannel *ioc, char *buf, size_t buflen,
> +                           off_t offset, Error **errp);

"pread"


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


