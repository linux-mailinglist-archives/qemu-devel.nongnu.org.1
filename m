Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6FE792390
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 16:36:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdXAK-0008AN-ME; Tue, 05 Sep 2023 10:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qdXAI-00089g-4U; Tue, 05 Sep 2023 10:36:26 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qdXAE-00027V-4Y; Tue, 05 Sep 2023 10:36:25 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:ac00:0:640:e1b9:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 78A2E60C2B;
 Tue,  5 Sep 2023 17:36:16 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b518::1:22] (unknown
 [2a02:6b8:b081:b518::1:22])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id FaYZAn1Oh0U0-aYXlZuwc; Tue, 05 Sep 2023 17:36:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1693924576;
 bh=QZF2KzRfoZwU4IHy38BhJgKRSLapxZlKwh2yytzeyqM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=0ObzVaiGthXnZPGvqkv36evVyP9ByRulDvJfAZJ2pWQWjBHVV/iIpP8RuK8ERH7Nl
 8f2x8jhk4G77zqNp+t6EBPl+093YKnE1/wo4MVh1q+dbCDEPJWvMFceK4ikrgcs4J+
 ynyzC0vWeQaNfQOy+n9sheB0df9afAsVmM/rrldw=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <09aa5a8f-3600-890b-4cab-eeb5897a5719@yandex-team.ru>
Date: Tue, 5 Sep 2023 17:36:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 06/17] nbd/server: Support a request payload
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
References: <20230829175826.377251-19-eblake@redhat.com>
 <20230829175826.377251-25-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230829175826.377251-25-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 29.08.23 20:58, Eric Blake wrote:
> Upcoming additions to support NBD 64-bit effect lengths allow for the
> possibility to distinguish between payload length (capped at 32M) and
> effect length (64 bits, although we generally assume 63 bits because
> of off_t limitations).  Without that extension, only the NBD_CMD_WRITE
> request has a payload; but with the extension, it makes sense to allow
> at least NBD_CMD_BLOCK_STATUS to have both a payload and effect length
> in a future patch (where the payload is a limited-size struct that in
> turn gives the real effect length as well as a subset of known ids for
> which status is requested).  Other future NBD commands may also have a
> request payload, so the 64-bit extension introduces a new
> NBD_CMD_FLAG_PAYLOAD_LEN that distinguishes between whether the header
> length is a payload length or an effect length, rather than
> hard-coding the decision based on the command; although a client
> should never send a command with a payload without the negotiation
> phase proving such extension is available, we are now able to
> gracefully fail unexpected client payloads while keeping the
> connection alive.  Note that we do not support the payload version of
> BLOCK_STATUS yet.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> v5: retitled from v4 13/24, rewrite on top of previous patch's switch
> statement [Vladimir]
> 
> v4: less indentation on several 'if's [Vladimir]
> ---
>   nbd/server.c     | 33 ++++++++++++++++++++++++++++-----
>   nbd/trace-events |  1 +
>   2 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index dd3ab59224c..adcfcdeacb7 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -2334,7 +2334,8 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
>                                                  Error **errp)
>   {
>       NBDClient *client = req->client;
> -    bool check_length = false;
> +    bool extended_with_payload;
> +    bool check_length;
>       bool check_rofs = false;
>       bool allocate_buffer = false;
>       unsigned payload_len = 0;
> @@ -2350,6 +2351,9 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
> 
>       trace_nbd_co_receive_request_decode_type(request->cookie, request->type,
>                                                nbd_cmd_lookup(request->type));
> +    check_length = extended_with_payload = client->mode >= NBD_MODE_EXTENDED &&
> +        request->flags & NBD_CMD_FLAG_PAYLOAD_LEN;
> +
>       switch (request->type) {
>       case NBD_CMD_DISC:
>           /* Special case: we're going to disconnect without a reply,
> @@ -2366,6 +2370,14 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
>           break;
> 
>       case NBD_CMD_WRITE:
> +        if (client->mode >= NBD_MODE_EXTENDED) {
> +            if (!extended_with_payload) {
> +                /* The client is noncompliant. Trace it, but proceed. */
> +                trace_nbd_co_receive_ext_payload_compliance(request->from,
> +                                                            request->len);
> +            }
> +            valid_flags |= NBD_CMD_FLAG_PAYLOAD_LEN;
> +        }
>           payload_len = request->len;
>           check_length = true;
>           allocate_buffer = true;
> @@ -2407,6 +2419,15 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,

more context:

     /* Payload and buffer handling. */
     if (!payload_len) {
         req->complete = true;
     }
     if (check_length && request->len > NBD_MAX_BUFFER_SIZE) {
         /* READ, WRITE, CACHE */
         error_setg(errp, "len (%" PRIu64 ") is larger than max len (%u)",
                    request->len, NBD_MAX_BUFFER_SIZE);
         return -EINVAL;
     }


> +    if (extended_with_payload && !allocate_buffer) {

it's correct but strange, as allocate_buffer is (READ or WRITE), and READ is totally unrelated here.

> +        /*
> +         * For now, we don't support payloads on other commands; but
> +         * we can keep the connection alive by ignoring the payload.

Was it in specification, that we can safely ignore unknown payload for known commands?

> +         */
> +        assert(request->type != NBD_CMD_WRITE);
> +        payload_len = request->len;

what I don't like here, is that we already set req->complete to true for this request, when payload_len was zero.

Probably, for extended_with_payload requests we should initialize payload_len at top of the function?

> +        request->len = 0;
> +    }
>       if (allocate_buffer) {>           /* READ, WRITE */
>           req->data = blk_try_blockalign(client->exp->common.blk,
> @@ -2417,10 +2438,12 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
>           }
>       }
>       if (payload_len) {
> -        /* WRITE */
> -        assert(req->data);
> -        ret = nbd_read(client->ioc, req->data, payload_len,
> -                       "CMD_WRITE data", errp);
> +        if (req->data) {

and req->data is actually (READ or WRITE) ( == allocated_buffer) as well.

I'd prefer here "if (request->type == NBD_CMD_WRITE)" here

> +            ret = nbd_read(client->ioc, req->data, payload_len,
> +                           "CMD_WRITE data", errp);
> +        } else {
> +            ret = nbd_drop(client->ioc, payload_len, errp);
> +        }
>           if (ret < 0) {
>               return -EIO;
>           }
> diff --git a/nbd/trace-events b/nbd/trace-events
> index f9dccfcfb44..c1a3227613f 100644
> --- a/nbd/trace-events
> +++ b/nbd/trace-events
> @@ -71,6 +71,7 @@ nbd_co_send_extents(uint64_t cookie, unsigned int extents, uint32_t id, uint64_t
>   nbd_co_send_chunk_error(uint64_t cookie, int err, const char *errname, const char *msg) "Send structured error reply: cookie = %" PRIu64 ", error = %d (%s), msg = '%s'"
>   nbd_co_receive_request_decode_type(uint64_t cookie, uint16_t type, const char *name) "Decoding type: cookie = %" PRIu64 ", type = %" PRIu16 " (%s)"
>   nbd_co_receive_request_payload_received(uint64_t cookie, uint64_t len) "Payload received: cookie = %" PRIu64 ", len = %" PRIu64
> +nbd_co_receive_ext_payload_compliance(uint64_t from, uint64_t len) "client sent non-compliant write without payload flag: from=0x%" PRIx64 ", len=0x%" PRIx64
>   nbd_co_receive_align_compliance(const char *op, uint64_t from, uint64_t len, uint32_t align) "client sent non-compliant unaligned %s request: from=0x%" PRIx64 ", len=0x%" PRIx64 ", align=0x%" PRIx32
>   nbd_trip(void) "Reading request"
> 

-- 
Best regards,
Vladimir


