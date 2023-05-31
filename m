Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5178D718549
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 16:48:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4N6d-0004kD-6z; Wed, 31 May 2023 10:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4N6b-0004hP-59; Wed, 31 May 2023 10:47:17 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4N6Y-0007J5-1H; Wed, 31 May 2023 10:47:16 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:151e:0:640:1960:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 8E7F260516;
 Wed, 31 May 2023 17:46:56 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a512::1:34] (unknown
 [2a02:6b8:b081:a512::1:34])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id tkOtw45OdOs0-5ft1mk8B; Wed, 31 May 2023 17:46:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1685544415; bh=LeyNUhZf8g0b4isNfquBzCjcPzFSDcwbS5kGWmmHG28=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=FaHiqIkmlrZKM6N2CxQWw+ONScP/89XpWyYfea6VLNLFBCsT0ykijMBzV+kBq89I/
 yMAbaZVWzou6/2lp6SWLgWnS5HQmH+b17aY05k6qlQng/tH52TvPFK0KgZ+yosWb65
 XtARN1UZkAXYYD0t40TrkcGpd1rm2ADHaCGoQdis=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <21c33b7e-d2b2-e40b-9388-1caffe9ed5c2@yandex-team.ru>
Date: Wed, 31 May 2023 17:46:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 09/14] nbd/server: Initial support for extended headers
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: libguestfs@redhat.com,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-10-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230515195343.1915857-10-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 15.05.23 22:53, Eric Blake wrote:
> Time to support clients that request extended headers.  Now we can
> finally reach the code added across several previous patches.
> 
> Even though the NBD spec has been altered to allow us to accept
> NBD_CMD_READ larger than the max payload size (provided our response
> is a hole or broken up over more than one data chunk), we are not
> planning to take advantage of that, and continue to cap NBD_CMD_READ
> to 32M regardless of header size.
> 
> For NBD_CMD_WRITE_ZEROES and NBD_CMD_TRIM, the block layer already
> supports 64-bit operations without any effort on our part.  For
> NBD_CMD_BLOCK_STATUS, the client's length is a hint, and the previous
> patch took care of implementing the required
> NBD_REPLY_TYPE_BLOCK_STATUS_EXT.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   nbd/nbd-internal.h |   5 +-

[..]

> 
>   static inline void set_be_simple_reply(NBDClient *client, struct iovec *iov,
> -                                       uint64_t error, NBDRequest *request)
> +                                       uint32_t error, NBDStructuredError *err,
> +                                       NBDRequest *request)
>   {
> -    NBDSimpleReply *reply = iov->iov_base;
> +    if (client->header_style >= NBD_HEADER_EXTENDED) {
> +        NBDExtendedReplyChunk *chunk = iov->iov_base;
> 
> -    iov->iov_len = sizeof(*reply);
> -    stl_be_p(&reply->magic, NBD_SIMPLE_REPLY_MAGIC);
> -    stl_be_p(&reply->error, error);
> -    stq_be_p(&reply->handle, request->handle);
> +        iov->iov_len = sizeof(*chunk);
> +        stl_be_p(&chunk->magic, NBD_EXTENDED_REPLY_MAGIC);
> +        stw_be_p(&chunk->flags, NBD_REPLY_FLAG_DONE);
> +        stq_be_p(&chunk->handle, request->handle);
> +        stq_be_p(&chunk->offset, request->from);
> +        if (error) {
> +            assert(!iov[1].iov_base);
> +            iov[1].iov_base = err;
> +            iov[1].iov_len = sizeof(*err);
> +            stw_be_p(&chunk->type, NBD_REPLY_TYPE_ERROR);
> +            stq_be_p(&chunk->length, sizeof(*err));
> +            stl_be_p(&err->error, error);
> +            stw_be_p(&err->message_length, 0);
> +        } else {
> +            stw_be_p(&chunk->type, NBD_REPLY_TYPE_NONE);
> +            stq_be_p(&chunk->length, 0);
> +        }
> +    } else {
> +        NBDSimpleReply *reply = iov->iov_base;
> +
> +        iov->iov_len = sizeof(*reply);
> +        stl_be_p(&reply->magic, NBD_SIMPLE_REPLY_MAGIC);
> +        stl_be_p(&reply->error, error);
> +        stq_be_p(&reply->handle, request->handle);
> +    }
>   }
> 
>   static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
> @@ -1906,30 +1966,44 @@ static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,

So, that's not _simple_ now.. The function should be renamed. As well as set_be_simple_reply(). _simple_or_extended_ ? a bit too long. But continuing to use "simple" is in bad relation with use of "simple" word in specification.

Probably better to update callers? The only caller isi nbd_send_generic_reply(). So, could we just add nbd_co_send_single_extended_reply() to call from nbd_send_generic_reply() in case of EXTENDED?

Also, transformation of set_be_simple_reply() do look like it should be two separate functions.

>   {
>       NBDReply hdr;
>       int nbd_err = system_errno_to_nbd_errno(error);
> +    NBDStructuredError err;
>       struct iovec iov[] = {
>           {.iov_base = &hdr},
>           {.iov_base = data, .iov_len = len}
>       };
> 
> +    assert(!len || !nbd_err);
>       trace_nbd_co_send_simple_reply(request->handle, nbd_err,
>                                      nbd_err_lookup(nbd_err), len);
> -    set_be_simple_reply(client, &iov[0], nbd_err, request);
> +    set_be_simple_reply(client, &iov[0], nbd_err, &err, request);
> 
> -    return nbd_co_send_iov(client, iov, len ? 2 : 1, errp);
> +    return nbd_co_send_iov(client, iov, iov[1].iov_len ? 2 : 1, errp);
>   }
> 
>   static inline void set_be_chunk(NBDClient *client, struct iovec *iov,
>                                   uint16_t flags, uint16_t type,
>                                   NBDRequest *request, uint32_t length)
>   {
> -    NBDStructuredReplyChunk *chunk = iov->iov_base;
> +    if (client->header_style >= NBD_HEADER_EXTENDED) {
> +        NBDExtendedReplyChunk *chunk = iov->iov_base;
> 
> -    iov->iov_len = sizeof(*chunk);
> -    stl_be_p(&chunk->magic, NBD_STRUCTURED_REPLY_MAGIC);
> -    stw_be_p(&chunk->flags, flags);
> -    stw_be_p(&chunk->type, type);
> -    stq_be_p(&chunk->handle, request->handle);
> -    stl_be_p(&chunk->length, length);
> +        iov->iov_len = sizeof(*chunk);
> +        stl_be_p(&chunk->magic, NBD_EXTENDED_REPLY_MAGIC);
> +        stw_be_p(&chunk->flags, flags);
> +        stw_be_p(&chunk->type, type);
> +        stq_be_p(&chunk->handle, request->handle);
> +        stq_be_p(&chunk->offset, request->from);
> +        stq_be_p(&chunk->length, length);
> +    } else {
> +        NBDStructuredReplyChunk *chunk = iov->iov_base;
> +
> +        iov->iov_len = sizeof(*chunk);
> +        stl_be_p(&chunk->magic, NBD_STRUCTURED_REPLY_MAGIC);
> +        stw_be_p(&chunk->flags, flags);
> +        stw_be_p(&chunk->type, type);
> +        stq_be_p(&chunk->handle, request->handle);
> +        stl_be_p(&chunk->length, length);
> +    }
>   }
> 
>   static int coroutine_fn nbd_co_send_structured_done(NBDClient *client,




-- 
Best regards,
Vladimir


