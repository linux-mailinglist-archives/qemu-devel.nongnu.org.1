Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8E37874EC
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:10:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCuR-0001mu-94; Thu, 24 Aug 2023 12:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qZCuP-0001mI-Dn; Thu, 24 Aug 2023 12:10:09 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qZCuM-0002d7-Un; Thu, 24 Aug 2023 12:10:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E77E11F88D;
 Thu, 24 Aug 2023 16:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692893401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pwvWHNkAuglN/CpRdzIilovc7AKLsIxjl2WMOwoBMcA=;
 b=VG1dXX6TDkFlZSngDiq6Up4jAsQsNuHz/pa7PGxiw0a5rHGouogHfUnJC7ElaK6DE2SaUk
 cGXMTF6xWt7u83EaALz6pVD+vwglj07iC9kLpN062FTu/oeKdjUNr9HeFb8c75Bp/dHo3t
 Aeciok2yjbreJ7MCAALiHuTJe2MRLBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692893401;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pwvWHNkAuglN/CpRdzIilovc7AKLsIxjl2WMOwoBMcA=;
 b=Q6JaXDZ+nMTNEUFFXSLZ7UWqqxu2Os14EYv+EFv4vCd1qD3hKGHjFMRD2rh5DK9FbLlB4j
 M3270G0YMOSfKRCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E83C132F2;
 Thu, 24 Aug 2023 16:10:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mil+DtmA52RhVgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 24 Aug 2023 16:10:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, kwolf@redhat.com, Fam Zheng
 <fam@euphon.net>, Juan Quintela <quintela@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Daniel Berrange
 <berrange@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-block@nongnu.org, Leonardo Bras
 <leobras@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>, Peter Xu
 <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 2/2] io: follow coroutine AioContext in qio_channel_yield()
In-Reply-To: <20230823234504.1387239-3-stefanha@redhat.com>
References: <20230823234504.1387239-1-stefanha@redhat.com>
 <20230823234504.1387239-3-stefanha@redhat.com>
Date: Thu, 24 Aug 2023 13:09:59 -0300
Message-ID: <874jko8lrc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> @@ -2089,10 +2088,6 @@ static void nbd_attach_aio_context(BlockDriverState *bs,
>       * the reconnect_delay_timer cannot be active here.
>       */
>      assert(!s->reconnect_delay_timer);
> -
> -    if (s->ioc) {
> -        qio_channel_attach_aio_context(s->ioc, new_context);
> -    }
>  }
>  
>  static void nbd_detach_aio_context(BlockDriverState *bs)
> @@ -2101,10 +2096,6 @@ static void nbd_detach_aio_context(BlockDriverState *bs)
>  
>      assert(!s->open_timer);
>      assert(!s->reconnect_delay_timer);
> -
> -    if (s->ioc) {
> -        qio_channel_detach_aio_context(s->ioc);
> -    }
>  }

The whole attach/detach functions could go away.

>  
>  static BlockDriver bdrv_nbd = {
> diff --git a/io/channel-command.c b/io/channel-command.c
> index 7ed726c802..1f61026222 100644
> --- a/io/channel-command.c
> +++ b/io/channel-command.c
> @@ -331,14 +331,21 @@ static int qio_channel_command_close(QIOChannel *ioc,
>  
>  
>  static void qio_channel_command_set_aio_fd_handler(QIOChannel *ioc,
> -                                                   AioContext *ctx,
> +                                                   AioContext *read_ctx,
>                                                     IOHandler *io_read,
> +                                                   AioContext *write_ctx,
>                                                     IOHandler *io_write,
>                                                     void *opaque)
>  {
>      QIOChannelCommand *cioc = QIO_CHANNEL_COMMAND(ioc);
> -    aio_set_fd_handler(ctx, cioc->readfd, io_read, NULL, NULL, NULL, opaque);
> -    aio_set_fd_handler(ctx, cioc->writefd, NULL, io_write, NULL, NULL, opaque);
> +    if (read_ctx) {
> +        aio_set_fd_handler(read_ctx, cioc->readfd, io_read, NULL,
> +                NULL, NULL, opaque);
> +    }
> +    if (write_ctx) {
> +        aio_set_fd_handler(write_ctx, cioc->writefd, NULL, io_write,
> +                NULL, NULL, opaque);
> +    }
>  }
>  
>  

...

> diff --git a/nbd/client.c b/nbd/client.c
> index 479208d5d9..81877d088d 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -948,7 +948,7 @@ static int nbd_start_negotiate(AioContext *aio_context, QIOChannel *ioc,
>                  ioc = *outioc;
>                  if (aio_context) {
>                      qio_channel_set_blocking(ioc, false, NULL);
> -                    qio_channel_attach_aio_context(ioc, aio_context);
> +                    qio_channel_set_follow_coroutine_ctx(ioc, true);

This is actually unreachable, aio_context is always NULL here.

>                  }
>              } else {
>                  error_setg(errp, "Server does not support STARTTLS");

