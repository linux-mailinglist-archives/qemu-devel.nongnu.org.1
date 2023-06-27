Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1407573FDBA
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 16:23:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE9aw-0005N1-BE; Tue, 27 Jun 2023 10:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qE9aO-0005Ig-Ut; Tue, 27 Jun 2023 10:22:29 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qE9aJ-0001dT-Ma; Tue, 27 Jun 2023 10:22:28 -0400
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a49a:0:640:edd6:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 2B4A66188F;
 Tue, 27 Jun 2023 17:22:11 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b68e::1:39] (unknown
 [2a02:6b8:b081:b68e::1:39])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 9MMvC40OceA0-Yma1yPHA; Tue, 27 Jun 2023 17:22:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1687875730; bh=sMRHzgDvqcgQxuqBBuuQ3vHusVhgp1XecMvQkHNddSk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=yv+LmQeHppvsB5EVZFYl/3A9iFxr2eY16SCIQ4BlR60w15e5OtUcOCzSMDBZsS8FY
 olmLOzoaDXhjyPhQBiT9pkbMTjoO692zhTt4R4mZvKPtVEvJ102vj2qvTTdJntfcC5
 RcJIUxnAKLLKmkqbOmIDGuYGpj16pe6ran/21GUY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <22e76783-92bb-50ca-798e-a849a337ee4d@yandex-team.ru>
Date: Tue, 27 Jun 2023 17:22:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 19/24] nbd/client: Initial support for extended headers
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-20-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230608135653.2918540-20-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> v4: split off errp handling to separate patch [Vladimir], better
> function naming [Vladimir]
> ---
>   include/block/nbd.h |   3 +-
>   block/nbd.c         |   2 +-
>   nbd/client.c        | 100 +++++++++++++++++++++++++++++---------------
>   nbd/trace-events    |   3 +-
>   4 files changed, 72 insertions(+), 36 deletions(-)
> 
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index dc05f5981fb..af80087e2cd 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -389,7 +389,8 @@ int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
>                Error **errp);
>   int nbd_send_request(QIOChannel *ioc, NBDRequest *request);
>   int coroutine_fn nbd_receive_reply(BlockDriverState *bs, QIOChannel *ioc,
> -                                   NBDReply *reply, Error **errp);
> +                                   NBDReply *reply, NBDMode mode,
> +                                   Error **errp);
>   int nbd_client(int fd);
>   int nbd_disconnect(int fd);
>   int nbd_errno_to_system_errno(int err);
> diff --git a/block/nbd.c b/block/nbd.c
> index c17ce935f17..e281fac43d1 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -459,7 +459,7 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
> 
>           /* We are under mutex and cookie is 0. We have to do the dirty work. */
>           assert(s->reply.cookie == 0);
> -        ret = nbd_receive_reply(s->bs, s->ioc, &s->reply, errp);
> +        ret = nbd_receive_reply(s->bs, s->ioc, &s->reply, s->info.mode, errp);
>           if (ret == 0) {
>               ret = -EIO;
>               error_setg(errp, "server dropped connection");
> diff --git a/nbd/client.c b/nbd/client.c
> index 1495a9b0ab1..a4598a95427 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -1352,22 +1352,29 @@ int nbd_disconnect(int fd)
> 
>   int nbd_send_request(QIOChannel *ioc, NBDRequest *request)
>   {
> -    uint8_t buf[NBD_REQUEST_SIZE];
> +    uint8_t buf[NBD_EXTENDED_REQUEST_SIZE];
> +    size_t len;
> 
> -    assert(request->mode <= NBD_MODE_STRUCTURED); /* TODO handle extended */
> -    assert(request->len <= UINT32_MAX);
>       trace_nbd_send_request(request->from, request->len, request->cookie,
>                              request->flags, request->type,
>                              nbd_cmd_lookup(request->type));
> 
> -    stl_be_p(buf, NBD_REQUEST_MAGIC);
>       stw_be_p(buf + 4, request->flags);
>       stw_be_p(buf + 6, request->type);
>       stq_be_p(buf + 8, request->cookie);
>       stq_be_p(buf + 16, request->from);
> -    stl_be_p(buf + 24, request->len);
> +    if (request->mode >= NBD_MODE_EXTENDED) {
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
> @@ -1394,30 +1401,36 @@ static int nbd_receive_simple_reply(QIOChannel *ioc, NBDSimpleReply *reply,
>       return 0;
>   }
> 
> -/* nbd_receive_structured_reply_chunk
> +/* nbd_receive_reply_chunk_header
>    * Read structured reply chunk except magic field (which should be already
> - * read).
> + * read).  Normalize into the compact form.
>    * Payload is not read.
>    */
> -static int nbd_receive_structured_reply_chunk(QIOChannel *ioc,
> -                                              NBDStructuredReplyChunk *chunk,
> -                                              Error **errp)
> +static int nbd_receive_reply_chunk_header(QIOChannel *ioc, NBDReply *chunk,
> +                                          Error **errp)
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
> +                   len - sizeof(chunk->magic), "structured chunk",
>                      errp);
>       if (ret < 0) {
>           return ret;
>       }
> 
> -    chunk->flags = be16_to_cpu(chunk->flags);
> -    chunk->type = be16_to_cpu(chunk->type);
> -    chunk->cookie = be64_to_cpu(chunk->cookie);
> -    chunk->length = be32_to_cpu(chunk->length);
> +    /* flags, type, and cookie occupy same space between forms */
> +    chunk->structured.flags = be16_to_cpu(chunk->structured.flags);
> +    chunk->structured.type = be16_to_cpu(chunk->structured.type);
> +    chunk->structured.cookie = be64_to_cpu(chunk->structured.cookie);
> 
>       /*
>        * Because we use BLOCK_STATUS with REQ_ONE, and cap READ requests
> @@ -1425,11 +1438,20 @@ static int nbd_receive_structured_reply_chunk(QIOChannel *ioc,
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
> @@ -1476,19 +1498,21 @@ nbd_read_eof(BlockDriverState *bs, QIOChannel *ioc, void *buffer, size_t size,
> 
>   /* nbd_receive_reply
>    *
> - * Decreases bs->in_flight while waiting for a new reply. This yield is where
> - * we wait indefinitely and the coroutine must be able to be safely reentered
> - * for nbd_client_attach_aio_context().
> + * Wait for a new reply. If this yields, the coroutine must be able to be
> + * safely reentered for nbd_client_attach_aio_context().  @mode determines
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
> +                                   NBDReply *reply, NBDMode mode, Error **errp)
>   {
>       int ret;
>       const char *type;
> +    uint32_t expected;
> 
>       ret = nbd_read_eof(bs, ioc, &reply->magic, sizeof(reply->magic), errp);
>       if (ret <= 0) {
> @@ -1497,8 +1521,13 @@ int coroutine_fn nbd_receive_reply(BlockDriverState *bs, QIOChannel *ioc,
> 
>       reply->magic = be32_to_cpu(reply->magic);
> 
> +    /* Diagnose but accept wrong-width header */
>       switch (reply->magic) {
>       case NBD_SIMPLE_REPLY_MAGIC:
> +        if (mode >= NBD_MODE_EXTENDED) {
> +            trace_nbd_receive_wrong_header(reply->magic,
> +                                           nbd_mode_lookup(mode));
> +        }
>           ret = nbd_receive_simple_reply(ioc, &reply->simple, errp);
>           if (ret < 0) {
>               break;
> @@ -1508,23 +1537,28 @@ int coroutine_fn nbd_receive_reply(BlockDriverState *bs, QIOChannel *ioc,
>                                          reply->cookie);
>           break;
>       case NBD_STRUCTURED_REPLY_MAGIC:
> -        ret = nbd_receive_structured_reply_chunk(ioc, &reply->structured, errp);
> +    case NBD_EXTENDED_REPLY_MAGIC:
> +        expected = mode >= NBD_MODE_EXTENDED ? NBD_EXTENDED_REPLY_MAGIC
> +            : NBD_STRUCTURED_REPLY_MAGIC;
> +        if (reply->magic != expected) {
> +            trace_nbd_receive_wrong_header(reply->magic,
> +                                           nbd_mode_lookup(mode));
> +        }
> +        ret = nbd_receive_reply_chunk_header(ioc, reply, errp);
>           if (ret < 0) {
>               break;
>           }

maybe

assert(reply->magic == NBD_STRUCTURED_REPLY_MAGIC)

>           type = nbd_reply_type_lookup(reply->structured.type);
> -        trace_nbd_receive_structured_reply_chunk(reply->structured.flags,
> -                                                 reply->structured.type, type,
> -                                                 reply->structured.cookie,
> -                                                 reply->structured.length);
> +        trace_nbd_receive_reply_chunk_header(reply->structured.flags,
> +                                             reply->structured.type, type,
> +                                             reply->structured.cookie,
> +                                             reply->structured.length);
>           break;
>       default:
> +        trace_nbd_receive_wrong_header(reply->magic, nbd_mode_lookup(mode));
>           error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", reply->magic);
>           return -EINVAL;
>       }
> -    if (ret < 0) {
> -        return ret;
> -    }

hmm, mistake? Seems, we'll return 1 on error with set errp this way

> 
>       return 1;
>   }
> diff --git a/nbd/trace-events b/nbd/trace-events
> index 6a34d7f027a..51bfb129c95 100644
> --- a/nbd/trace-events
> +++ b/nbd/trace-events
> @@ -33,7 +33,8 @@ nbd_client_clear_queue(void) "Clearing NBD queue"
>   nbd_client_clear_socket(void) "Clearing NBD socket"
>   nbd_send_request(uint64_t from, uint64_t len, uint64_t cookie, uint16_t flags, uint16_t type, const char *name) "Sending request to server: { .from = %" PRIu64", .len = %" PRIu64 ", .cookie = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) }"
>   nbd_receive_simple_reply(int32_t error, const char *errname, uint64_t cookie) "Got simple reply: { .error = %" PRId32 " (%s), cookie = %" PRIu64" }"
> -nbd_receive_structured_reply_chunk(uint16_t flags, uint16_t type, const char *name, uint64_t cookie, uint32_t length) "Got structured reply chunk: { flags = 0x%" PRIx16 ", type = %d (%s), cookie = %" PRIu64 ", length = %" PRIu32 " }"
> +nbd_receive_reply_chunk_header(uint16_t flags, uint16_t type, const char *name, uint64_t cookie, uint32_t length) "Got reply chunk header: { flags = 0x%" PRIx16 ", type = %d (%s), cookie = %" PRIu64 ", length = %" PRIu32 " }"
> +nbd_receive_wrong_header(uint32_t magic, const char *mode) "Server sent unexpected magic 0x%" PRIx32 " for negotiated mode %s"
> 
>   # common.c
>   nbd_unknown_error(int err) "Squashing unexpected error %d to EINVAL"

-- 
Best regards,
Vladimir


