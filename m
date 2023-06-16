Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E18C733855
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 20:49:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAEUx-0003K3-5n; Fri, 16 Jun 2023 14:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qAEUr-0003He-Ss; Fri, 16 Jun 2023 14:48:36 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qAEUp-0002Nb-AW; Fri, 16 Jun 2023 14:48:33 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:1421:0:640:53a0:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 011FB6066B;
 Fri, 16 Jun 2023 21:48:19 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b4af::1:5] (unknown
 [2a02:6b8:b081:b4af::1:5])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Imidhi0OcW20-nR59QgWU; Fri, 16 Jun 2023 21:48:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1686941298; bh=tyDPw0Ljr2Pe7LvM/RtHhoWLyJVyIvlToN7WVNF8GuQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=HAmJr1W64a9PjJXiIXsIuKCHothKq/9tyqhWxVlXBrGWJhHac0NCqN7mZTR6VYeoV
 s8qNEIFh0NBV6Hg/2qZhMOugRi1kXdQUZ7p+GwzlrUjRUduCH1TVq58Fip6/Y3TXUY
 dnRDG8LKTn7CHxPkEneMWyPQMqv6iHj3Q5fcptlI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <90f29beb-c032-b057-733e-b272ccb8deb0@yandex-team.ru>
Date: Fri, 16 Jun 2023 21:48:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 15/24] nbd/server: Prepare to send extended header
 replies
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-16-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230608135653.2918540-16-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 08.06.23 16:56, Eric Blake wrote:
> Although extended mode is not yet enabled, once we do turn it on, we
> need to reply with extended headers to all messages.  Update the low
> level entry points necessary so that all other callers automatically
> get the right header based on the current mode.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> v4: new patch, split out from v3 9/14
> ---
>   nbd/server.c | 30 ++++++++++++++++++++++--------
>   1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 119ac765f09..84c848a31d3 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1947,8 +1947,6 @@ static inline void set_be_chunk(NBDClient *client, struct iovec *iov,
>                                   size_t niov, uint16_t flags, uint16_t type,
>                                   NBDRequest *request)
>   {
> -    /* TODO - handle structured vs. extended replies */
> -    NBDStructuredReplyChunk *chunk = iov->iov_base;
>       size_t i, length = 0;
> 
>       for (i = 1; i < niov; i++) {
> @@ -1956,12 +1954,26 @@ static inline void set_be_chunk(NBDClient *client, struct iovec *iov,
>       }
>       assert(length <= NBD_MAX_BUFFER_SIZE + sizeof(NBDStructuredReadData));
> 
> -    iov[0].iov_len = sizeof(*chunk);
> -    stl_be_p(&chunk->magic, NBD_STRUCTURED_REPLY_MAGIC);
> -    stw_be_p(&chunk->flags, flags);
> -    stw_be_p(&chunk->type, type);
> -    stq_be_p(&chunk->cookie, request->cookie);
> -    stl_be_p(&chunk->length, length);
> +    if (client->mode >= NBD_MODE_EXTENDED) {
> +        NBDExtendedReplyChunk *chunk = iov->iov_base;
> +
> +        iov->iov_len = sizeof(*chunk);

I'd prefer to keep iov[0].iov_len notation, to stress that iov is an array

anyway:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

> +        stl_be_p(&chunk->magic, NBD_EXTENDED_REPLY_MAGIC);
> +        stw_be_p(&chunk->flags, flags);
> +        stw_be_p(&chunk->type, type);
> +        stq_be_p(&chunk->cookie, request->cookie);

Hm. Not about this patch:

we now moved to simple cookies. And it seems that actually, 64bit is too much for number of request.

> +        stq_be_p(&chunk->offset, request->from);
> +        stq_be_p(&chunk->length, length);
> +    } else {
> +        NBDStructuredReplyChunk *chunk = iov->iov_base;
> +
> +        iov->iov_len = sizeof(*chunk);
> +        stl_be_p(&chunk->magic, NBD_STRUCTURED_REPLY_MAGIC);
> +        stw_be_p(&chunk->flags, flags);
> +        stw_be_p(&chunk->type, type);
> +        stq_be_p(&chunk->cookie, request->cookie);
> +        stl_be_p(&chunk->length, length);
> +    }
>   }
> 
>   static int coroutine_fn nbd_co_send_chunk_done(NBDClient *client,
> @@ -2478,6 +2490,8 @@ static coroutine_fn int nbd_send_generic_reply(NBDClient *client,
>   {
>       if (client->mode >= NBD_MODE_STRUCTURED && ret < 0) {
>           return nbd_co_send_chunk_error(client, request, -ret, error_msg, errp);
> +    } else if (client->mode >= NBD_MODE_EXTENDED) {
> +        return nbd_co_send_chunk_done(client, request, errp);
>       } else {
>           return nbd_co_send_simple_reply(client, request, ret < 0 ? -ret : 0,
>                                           NULL, 0, errp);

-- 
Best regards,
Vladimir


