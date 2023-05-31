Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99702718647
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 17:27:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Nip-0007gu-Mv; Wed, 31 May 2023 11:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4Nii-0007ff-RE; Wed, 31 May 2023 11:26:41 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4Nic-0007uY-IC; Wed, 31 May 2023 11:26:40 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:1421:0:640:53a0:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 7AEDF61E21;
 Wed, 31 May 2023 18:26:18 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a512::1:34] (unknown
 [2a02:6b8:b081:a512::1:34])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HQPrih6Opa60-6cC2ws2e; Wed, 31 May 2023 18:26:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1685546777; bh=7+T7owi8UYTb3KjYsvSjhw5z3ipS+jIj6FY7br5jCZQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Myhx+Iq5//OXU8MmhKyEX9aq3pC1rWHAID54qqnac7Nrw4ER215+fcBV28RYUYnSr
 Ot9W30dJ6tAAeMEGNO78NyItfpuLmdHeCm6t1/Hn5vScKaX23HbpXKKVusoZH0Bh0A
 uc+ab8vlfYVCkycdwqZpA62J1gtfXHN78E1/oLeE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b9dba014-3df4-e87e-8341-3653895d9e9b@yandex-team.ru>
Date: Wed, 31 May 2023 18:26:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 10/14] nbd/client: Initial support for extended headers
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-11-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230515195343.1915857-11-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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
> Update the client code to be able to send an extended request, and
> parse an extended header from the server.  Note that since we reject
> any structured reply with a too-large payload, we can always normalize
> a valid header back into the compact form, so that the caller need not
> deal with two branches of a union.  Still, until a later patch lets
> the client negotiate extended headers, the code added here should not
> be reached.  Note that because of the different magic numbers, it is
> just as easy to trace and then tolerate a non-compliant server sending
> the wrong header reply as it would be to insist that the server is
> compliant.
> 
> The only caller to nbd_receive_reply() always passed NULL for errp;
> since we are changing the signature anyways, I decided to sink the
> decision to ignore errors one layer lower.

This way nbd_receive_simple_reply() and nbd_receive_structured_reply_chunk() are called now only with explicit NULL last argument.. And we start to drop all errors.

Also, actually, we'd better add errp parameter to the caller - nbd_receive_replies(), because its caller (nbd_co_do_receive_one_chunk()) will benefit of it, as it already has errp.

> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   include/block/nbd.h |  2 +-
>   block/nbd.c         |  3 +-
>   nbd/client.c        | 86 +++++++++++++++++++++++++++++++--------------
>   nbd/trace-events    |  1 +
>   4 files changed, 63 insertions(+), 29 deletions(-)
> 
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index d753fb8006f..865bb4ee2e1 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -371,7 +371,7 @@ int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
>                Error **errp);
>   int nbd_send_request(QIOChannel *ioc, NBDRequest *request, NBDHeaderStyle hdr);
>   int coroutine_fn nbd_receive_reply(BlockDriverState *bs, QIOChannel *ioc,
> -                                   NBDReply *reply, Error **errp);
> +                                   NBDReply *reply, NBDHeaderStyle hdr);
>   int nbd_client(int fd);
>   int nbd_disconnect(int fd);
>   int nbd_errno_to_system_errno(int err);
> diff --git a/block/nbd.c b/block/nbd.c
> index 6ad6a4f5ecd..d6caea44928 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -458,7 +458,8 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t handle)
> 
>           /* We are under mutex and handle is 0. We have to do the dirty work. */
>           assert(s->reply.handle == 0);
> -        ret = nbd_receive_reply(s->bs, s->ioc, &s->reply, NULL);
> +        ret = nbd_receive_reply(s->bs, s->ioc, &s->reply,
> +                                s->info.header_style);
>           if (ret <= 0) {
>               ret = ret ? ret : -EIO;
>               nbd_channel_error(s, ret);
> diff --git a/nbd/client.c b/nbd/client.c
> index 17d1f57da60..e5db3c8b79d 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -1350,22 +1350,29 @@ int nbd_disconnect(int fd)
> 
>   int nbd_send_request(QIOChannel *ioc, NBDRequest *request, NBDHeaderStyle hdr)
>   {
> -    uint8_t buf[NBD_REQUEST_SIZE];
> +    uint8_t buf[NBD_EXTENDED_REQUEST_SIZE];
> +    size_t len;
> 
> -    assert(hdr < NBD_HEADER_EXTENDED);
> -    assert(request->len <= UINT32_MAX);
>       trace_nbd_send_request(request->from, request->len, request->handle,
>                              request->flags, request->type,
>                              nbd_cmd_lookup(request->type));
> 
> -    stl_be_p(buf, NBD_REQUEST_MAGIC);
>       stw_be_p(buf + 4, request->flags);
>       stw_be_p(buf + 6, request->type);
>       stq_be_p(buf + 8, request->handle);
>       stq_be_p(buf + 16, request->from);
> -    stl_be_p(buf + 24, request->len);
> +    if (hdr >= NBD_HEADER_EXTENDED) {
> +        stl_be_p(buf, NBD_EXTENDED_REQUEST_MAGIC);
> +        stq_be_p(buf + 24, request->len);
> +        len = NBD_EXTENDED_REQUEST_SIZE;
> +    } else {
> +        assert(request->len <= UINT32_MAX);
> +        stl_be_p(buf, NBD_REQUEST_MAGIC);
> +        stl_be_p(buf + 24, request->len);
> +        len = NBD_REQUEST_SIZE;
> +    }
> 
> -    return nbd_write(ioc, buf, sizeof(buf), NULL);
> +    return nbd_write(ioc, buf, len, NULL);
>   }
> 
>   /* nbd_receive_simple_reply
> @@ -1394,28 +1401,34 @@ static int nbd_receive_simple_reply(QIOChannel *ioc, NBDSimpleReply *reply,
> 
>   /* nbd_receive_structured_reply_chunk
>    * Read structured reply chunk except magic field (which should be already
> - * read).
> + * read).  Normalize into the compact form.
>    * Payload is not read.
>    */
> -static int nbd_receive_structured_reply_chunk(QIOChannel *ioc,
> -                                              NBDStructuredReplyChunk *chunk,
> +static int nbd_receive_structured_reply_chunk(QIOChannel *ioc, NBDReply *chunk,
>                                                 Error **errp)

Hmm, _structured_or_extened_ ? Or at least in comment above the function we should mention this.

>   {
>       int ret;
> +    size_t len;
> +    uint64_t payload_len;
> 
> -    assert(chunk->magic == NBD_STRUCTURED_REPLY_MAGIC);
> +    if (chunk->magic == NBD_STRUCTURED_REPLY_MAGIC) {
> +        len = sizeof(chunk->structured);
> +    } else {
> +        assert(chunk->magic == NBD_EXTENDED_REPLY_MAGIC);
> +        len = sizeof(chunk->extended);
> +    }
> 
>       ret = nbd_read(ioc, (uint8_t *)chunk + sizeof(chunk->magic),
> -                   sizeof(*chunk) - sizeof(chunk->magic), "structured chunk",

Would be good to print "extended chunk" in error message for EXTENDED case.

> +                   len - sizeof(chunk->magic), "structured chunk",
>                      errp);
>       if (ret < 0) {
>           return ret;
>       }
> 
> -    chunk->flags = be16_to_cpu(chunk->flags);
> -    chunk->type = be16_to_cpu(chunk->type);
> -    chunk->handle = be64_to_cpu(chunk->handle);
> -    chunk->length = be32_to_cpu(chunk->length);
> +    /* flags, type, and handle occupy same space between forms */
> +    chunk->structured.flags = be16_to_cpu(chunk->structured.flags);
> +    chunk->structured.type = be16_to_cpu(chunk->structured.type);
> +    chunk->structured.handle = be64_to_cpu(chunk->structured.handle);
> 
>       /*
>        * Because we use BLOCK_STATUS with REQ_ONE, and cap READ requests
> @@ -1423,11 +1436,20 @@ static int nbd_receive_structured_reply_chunk(QIOChannel *ioc,
>        * this.  Even if we stopped using REQ_ONE, sane servers will cap
>        * the number of extents they return for block status.
>        */
> -    if (chunk->length > NBD_MAX_BUFFER_SIZE + sizeof(NBDStructuredReadData)) {
> +    if (chunk->magic == NBD_STRUCTURED_REPLY_MAGIC) {
> +        payload_len = be32_to_cpu(chunk->structured.length);
> +    } else {
> +        /* For now, we are ignoring the extended header offset. */
> +        payload_len = be64_to_cpu(chunk->extended.length);
> +        chunk->magic = NBD_STRUCTURED_REPLY_MAGIC;
> +    }
> +    if (payload_len > NBD_MAX_BUFFER_SIZE + sizeof(NBDStructuredReadData)) {
>           error_setg(errp, "server chunk %" PRIu32 " (%s) payload is too long",
> -                   chunk->type, nbd_rep_lookup(chunk->type));
> +                   chunk->structured.type,
> +                   nbd_rep_lookup(chunk->structured.type));
>           return -EINVAL;
>       }
> +    chunk->structured.length = payload_len;
> 
>       return 0;
>   }
> @@ -1474,30 +1496,35 @@ nbd_read_eof(BlockDriverState *bs, QIOChannel *ioc, void *buffer, size_t size,
> 
>   /* nbd_receive_reply
>    *
> - * Decreases bs->in_flight while waiting for a new reply. This yield is where
> - * we wait indefinitely and the coroutine must be able to be safely reentered
> - * for nbd_client_attach_aio_context().
> + * Wait for a new reply. If this yields, the coroutine must be able to be
> + * safely reentered for nbd_client_attach_aio_context().  @hdr determines
> + * which reply magic we are expecting, although this normalizes the result
> + * so that the caller only has to work with compact headers.
>    *
>    * Returns 1 on success
> - *         0 on eof, when no data was read (errp is not set)
> - *         negative errno on failure (errp is set)
> + *         0 on eof, when no data was read
> + *         negative errno on failure
>    */
>   int coroutine_fn nbd_receive_reply(BlockDriverState *bs, QIOChannel *ioc,
> -                                   NBDReply *reply, Error **errp)
> +                                   NBDReply *reply, NBDHeaderStyle hdr)
>   {
>       int ret;
>       const char *type;
> 
> -    ret = nbd_read_eof(bs, ioc, &reply->magic, sizeof(reply->magic), errp);
> +    ret = nbd_read_eof(bs, ioc, &reply->magic, sizeof(reply->magic), NULL);
>       if (ret <= 0) {
>           return ret;
>       }
> 
>       reply->magic = be32_to_cpu(reply->magic);
> 
> +    /* Diagnose but accept wrong-width header */
>       switch (reply->magic) {
>       case NBD_SIMPLE_REPLY_MAGIC:
> -        ret = nbd_receive_simple_reply(ioc, &reply->simple, errp);
> +        if (hdr >= NBD_HEADER_EXTENDED) {
> +            trace_nbd_receive_wrong_header(reply->magic);

maybe, trace also expected style

> +        }
> +        ret = nbd_receive_simple_reply(ioc, &reply->simple, NULL);
>           if (ret < 0) {
>               break;
>           }
> @@ -1506,7 +1533,12 @@ int coroutine_fn nbd_receive_reply(BlockDriverState *bs, QIOChannel *ioc,
>                                          reply->handle);
>           break;
>       case NBD_STRUCTURED_REPLY_MAGIC:
> -        ret = nbd_receive_structured_reply_chunk(ioc, &reply->structured, errp);
> +    case NBD_EXTENDED_REPLY_MAGIC:
> +        if ((hdr >= NBD_HEADER_EXTENDED) !=
> +            (reply->magic == NBD_EXTENDED_REPLY_MAGIC)) {
> +            trace_nbd_receive_wrong_header(reply->magic);
> +        }
> +        ret = nbd_receive_structured_reply_chunk(ioc, reply, NULL);
>           if (ret < 0) {
>               break;
>           }
> @@ -1517,7 +1549,7 @@ int coroutine_fn nbd_receive_reply(BlockDriverState *bs, QIOChannel *ioc,
>                                                    reply->structured.length);
>           break;
>       default:
> -        error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", reply->magic);
> +        trace_nbd_receive_wrong_header(reply->magic);
>           return -EINVAL;
>       }
>       if (ret < 0) {
> diff --git a/nbd/trace-events b/nbd/trace-events
> index adf5666e207..c20df33a431 100644
> --- a/nbd/trace-events
> +++ b/nbd/trace-events
> @@ -34,6 +34,7 @@ nbd_client_clear_socket(void) "Clearing NBD socket"
>   nbd_send_request(uint64_t from, uint64_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name) "Sending request to server: { .from = %" PRIu64", .len = %" PRIu64 ", .handle = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) }"
>   nbd_receive_simple_reply(int32_t error, const char *errname, uint64_t handle) "Got simple reply: { .error = %" PRId32 " (%s), handle = %" PRIu64" }"
>   nbd_receive_structured_reply_chunk(uint16_t flags, uint16_t type, const char *name, uint64_t handle, uint32_t length) "Got structured reply chunk: { flags = 0x%" PRIx16 ", type = %d (%s), handle = %" PRIu64 ", length = %" PRIu32 " }"
> +nbd_receive_wrong_header(uint32_t magic) "Server sent unexpected magic 0x%" PRIx32
> 
>   # common.c
>   nbd_unknown_error(int err) "Squashing unexpected error %d to EINVAL"

-- 
Best regards,
Vladimir


