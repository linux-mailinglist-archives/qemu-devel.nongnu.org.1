Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB527B4083
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 15:36:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qma7p-0004b2-VD; Sat, 30 Sep 2023 09:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qma7m-0004aE-B5; Sat, 30 Sep 2023 09:35:14 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qma7T-0001dt-4z; Sat, 30 Sep 2023 09:35:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:78a3:0:640:f135:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id A195965345;
 Sat, 30 Sep 2023 16:34:48 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b5a0::1:9] (unknown
 [2a02:6b8:b081:b5a0::1:9])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id lYTC8K1Ok8c0-Bqyij9KB; Sat, 30 Sep 2023 16:34:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696080888;
 bh=cZ8/OAuPw3mT5Btm/ISmio9MgQgyJ9wxXORzeIBgpIM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=xAK0i6qfZJ3gQYv/2VCupyhZ2QZL4+2LGAhy+HxqtdCixFhz49s20B8KBKVKLNtqA
 lIQnwaigZ1sbKP/AQNPUxIlGHSSp4a77GdUrYc5tv4xlgLIZ639NcDGsn7eLxOYDZV
 I452sBMmfpgYLEtCf1xHlBMKMvz6HH0/eLtS/dss=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ca247f3f-707f-d781-0c27-74c8b7a8b5b8@yandex-team.ru>
Date: Sat, 30 Sep 2023 16:34:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 01/12] nbd/server: Support a request payload
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, qemu-block@nongnu.org
References: <20230925192229.3186470-14-eblake@redhat.com>
 <20230925192229.3186470-15-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230925192229.3186470-15-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.587,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 25.09.23 22:22, Eric Blake wrote:
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
> hard-coding the decision based on the command.
> 
> According to the spec, a client should never send a command with a
> payload without the negotiation phase proving such extension is
> available.  So in the unlikely event the bit is set or cleared
> incorrectly, the client is already at fault; if the client then
> provides the payload, we can gracefully consume it off the wire and
> fail the command with NBD_EINVAL (subsequent checks for magic numbers
> ensure we are still in sync), while if the client fails to send
> payload we block waiting for it (basically deadlocking our connection
> to the bad client, but not negatively impacting our ability to service
> other clients, so not a security risk).  Note that we do not support
> the payload version of BLOCK_STATUS yet.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> v7: another try at better logic [Vladimir]
> 
> v5: retitled from v4 13/24, rewrite on top of previous patch's switch
> statement [Vladimir]
> 
> v4: less indentation on several 'if's [Vladimir]
> ---
>   nbd/server.c     | 37 +++++++++++++++++++++++++++++++++----
>   nbd/trace-events |  1 +
>   2 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 7a6f95071f8..1eabcfc908d 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -2322,9 +2322,11 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
>                                                  Error **errp)
>   {
>       NBDClient *client = req->client;
> +    bool extended_with_payload;
>       bool check_length = false;
>       bool check_rofs = false;
>       bool allocate_buffer = false;
> +    bool payload_okay = false;
>       unsigned payload_len = 0;
>       int valid_flags = NBD_CMD_FLAG_FUA;
>       int ret;
> @@ -2338,6 +2340,13 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
> 
>       trace_nbd_co_receive_request_decode_type(request->cookie, request->type,
>                                                nbd_cmd_lookup(request->type));
> +    extended_with_payload = client->mode >= NBD_MODE_EXTENDED &&
> +        request->flags & NBD_CMD_FLAG_PAYLOAD_LEN;
> +    if (extended_with_payload) {
> +        payload_len = request->len;
> +        check_length = true;
> +    }
> +
>       switch (request->type) {
>       case NBD_CMD_DISC:
>           /* Special case: we're going to disconnect without a reply,
> @@ -2354,6 +2363,15 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
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
> +        payload_okay = true;
>           payload_len = request->len;
>           check_length = true;
>           allocate_buffer = true;
> @@ -2395,6 +2413,14 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
>                      request->len, NBD_MAX_BUFFER_SIZE);
>           return -EINVAL;
>       }
> +    if (payload_len && !payload_okay) {
> +        /*
> +         * For now, we don't support payloads on other commands; but
> +         * we can keep the connection alive by ignoring the payload.
> +         */
> +        assert(request->type != NBD_CMD_WRITE);
> +        request->len = 0;

So, for sure, after this we go to

if (requests->flags & ~valid_flags)... and return -EINVAL.

Why we need to set request->len to 0? Just to not return "operation past EOF" instead of "unsupported flags", if len is too big? Maybe, that worth a comment.

Anyway, I now see nothing wrong in it, so:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

> +    }
>       if (allocate_buffer) {
>           /* READ, WRITE */
>           req->data = blk_try_blockalign(client->exp->common.blk,
> @@ -2405,10 +2431,13 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
>           }
>       }
>       if (payload_len) {
> -        /* WRITE */
> -        assert(req->data);
> -        ret = nbd_read(client->ioc, req->data, payload_len,
> -                       "CMD_WRITE data", errp);
> +        if (payload_okay) {
> +            assert(req->data);
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


