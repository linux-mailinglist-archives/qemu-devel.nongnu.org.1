Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AADBA8630C
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Apr 2025 18:19:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3H4y-0006M4-T9; Fri, 11 Apr 2025 12:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u3H4v-0006LX-8M
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 12:18:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u3H4r-000206-DX
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 12:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744388280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t293FxxwVKQqL+kz+7YwjQMHUMWESqxhQG4gyqOeaaM=;
 b=BErzUmr1s+w5psKZiRpjnbSHnNGEFPcZ1LlzjyWTSaaAojHqP8D53wbvlsRM1gCIHsMpQi
 dMnU5efEeMa9ddeJ1wO/4lHb3dYyMQupk6eqwRHTxJpBFxtnXmp++L9gkhag1AkbKc9rTw
 qk2JLBECVY3+f46yJ+zJfiYoZEOn51k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-zGHM7koxP2CuC91aPux2_g-1; Fri,
 11 Apr 2025 12:17:56 -0400
X-MC-Unique: zGHM7koxP2CuC91aPux2_g-1
X-Mimecast-MFC-AGG-ID: zGHM7koxP2CuC91aPux2_g_1744388276
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4AAC180035E; Fri, 11 Apr 2025 16:17:55 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F66D1955DCE; Fri, 11 Apr 2025 16:17:52 +0000 (UTC)
Date: Fri, 11 Apr 2025 11:17:49 -0500
From: Eric Blake <eblake@redhat.com>
To: Pinku Deb Nath <prantoran@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] block/file-posix.c: Use pwritev2() with RWF_DSYNC for
 FUA
Message-ID: <hprpncy5apskgzurv3zibh7tzeixnhtrh6irhaer24yt2h6txm@igsd74elzh7q>
References: <20250407154730.23008-1-prantoran@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407154730.23008-1-prantoran@gmail.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Apr 07, 2025 at 08:47:30AM -0700, Pinku Deb Nath wrote:
> Full Unit Access (FUA) is an optimization where a disk write with the
> flag set will be persisted to disk immediately instead of potentially
> remaining in the disk's write cache.
> 
> This commit address the todo task
> for using pwritev2() with RWF_DSYNC in the thread pool section of
> raw_co_prw(), if pwritev2() with RWF_DSYNC is available in the host,
> which is always the case for Linux kernel >= 4.7.

[Side note - I should take a look at using this syscall in libnbd's
file plugin]

> @@ -1698,10 +1718,16 @@ static ssize_t handle_aiocb_rw_vector(RawPosixAIOData *aiocb)
>  
>      len = RETRY_ON_EINTR(
>          (aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) ?
> -            qemu_pwritev(aiocb->aio_fildes,
> -                           aiocb->io.iov,
> -                           aiocb->io.niov,
> -                           aiocb->aio_offset) :
> +            (aiocb->flags &  BDRV_REQ_FUA) ?
> +                qemu_pwritev_fua(aiocb->aio_fildes,
> +                                aiocb->io.iov,
> +                                aiocb->io.niov,
> +                                aiocb->aio_offset,
> +                                aiocb) :
> +                qemu_pwritev(aiocb->aio_fildes,
> +                            aiocb->io.iov,
> +                            aiocb->io.niov,
> +                            aiocb->aio_offset) :
>              qemu_preadv(aiocb->aio_fildes,
>                            aiocb->io.iov,
>                            aiocb->io.niov,

This ?: chain is getting ridiculous.  Can we instead do:

if (aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
    if (aiocb->flags & BDRV_REQ_FUA) {
        fn = qemu_pwritev_fua;
    } else {
        fn = qemu_pwritev;
    }
} else {
    fn = qemu_preadv;
}
len = RETRY_ON_EINTR(fn(aiocb->aio_fildes, ... ))

by having all of the various dispatch functions take the same
signature and a suitably-defined fn function pointer variable?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


