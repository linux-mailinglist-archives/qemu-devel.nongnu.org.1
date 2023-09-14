Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9784A7A09A7
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:48:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgoZO-000752-B2; Thu, 14 Sep 2023 11:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgoZM-00074D-6W
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgoZK-0006Wa-4Q
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694706468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I9V2hYeg7Ef03GtVVD6VK4Pn4ZxHszVKojanMTfp6bI=;
 b=YAHss/GcO5Ad1G7mplQysu0L09O6zuzm9MfgwlvVsDHMLHmlEjEJ5vJWnsEuAXAf5ybDg7
 20hVJaq3/WA85ShcKd++YlHmK5d24c0+I5DTJNVrbDJvY3Gec0aqiWXg8fWLAj2M9kYo+y
 o3VVtZF+o1CwM8XU75yGNS5dXSWm/Gw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-EnqE4Lf4NH20Vq8Kovvu5Q-1; Thu, 14 Sep 2023 11:47:46 -0400
X-MC-Unique: EnqE4Lf4NH20Vq8Kovvu5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 381F081B08C;
 Thu, 14 Sep 2023 15:47:46 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 06E7F1054FC0;
 Thu, 14 Sep 2023 15:47:39 +0000 (UTC)
Date: Thu, 14 Sep 2023 10:47:38 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/4] block/file-posix: set up Linux AIO and io_uring in
 the current thread
Message-ID: <s7uer3lawymhtpji26asve72to33szga2ftho2hhumglilzikr@d6j2tklhgw6c>
References: <20230914140101.1065008-1-stefanha@redhat.com>
 <20230914140101.1065008-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914140101.1065008-2-stefanha@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

On Thu, Sep 14, 2023 at 10:00:58AM -0400, Stefan Hajnoczi wrote:
> The file-posix block driver currently only sets up Linux AIO and
> io_uring in the BDS's AioContext. In the multi-queue block layer we must
> be able to submit I/O requests in AioContexts that do not have Linux AIO
> and io_uring set up yet since any thread can call into the block driver.
> 
> Set up Linux AIO and io_uring for the current AioContext during request
> submission. We lose the ability to return an error from
> .bdrv_file_open() when Linux AIO and io_uring setup fails (e.g. due to
> resource limits). Instead the user only gets warnings and we fall back
> to aio=threads. This is still better than a fatal error after startup.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/file-posix.c | 99 ++++++++++++++++++++++------------------------
>  1 file changed, 47 insertions(+), 52 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 4757914ac0..e9dbb87c57 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -713,17 +713,11 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>  
>  #ifdef CONFIG_LINUX_AIO
>       /* Currently Linux does AIO only for files opened with O_DIRECT */
> -    if (s->use_linux_aio) {
> -        if (!(s->open_flags & O_DIRECT)) {
> -            error_setg(errp, "aio=native was specified, but it requires "
> -                             "cache.direct=on, which was not specified.");
> -            ret = -EINVAL;
> -            goto fail;
> -        }
> -        if (!aio_setup_linux_aio(bdrv_get_aio_context(bs), errp)) {

We were previously doing setup only once during open...

> +static inline bool raw_check_linux_io_uring(BDRVRawState *s)
> +{
> +    Error *local_err = NULL;
> +    AioContext *ctx;
> +
> +    if (!s->use_linux_io_uring) {
> +        return false;
> +    }
> +
> +    ctx = qemu_get_current_aio_context();
> +    if (unlikely(!aio_setup_linux_io_uring(ctx, &local_err))) {

...now you're doing it on ever I/O request.  I had to check that setup
is idempotent; thankfully it is (once ctx has an associated linux_aio
or io_uring, setup is a no-op for subsequent calls).

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


