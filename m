Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04451717987
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 10:05:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Gp6-0008Iv-IX; Wed, 31 May 2023 04:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4Gok-00086W-1F; Wed, 31 May 2023 04:04:26 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4Gog-0005Qr-34; Wed, 31 May 2023 04:04:25 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:1421:0:640:53a0:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 6E7E861382;
 Wed, 31 May 2023 11:04:09 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a512::1:34] (unknown
 [2a02:6b8:b081:a512::1:34])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 84ISHb6OiCg0-apgvScSb; Wed, 31 May 2023 11:04:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1685520248; bh=Y7lV1XJm3p+mxZ7RvYxTYTIq+5CDlCVIJX6OH4Vhh6s=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ltRt9sP9W3KTNGQjKFbL0UBfkIKJGknM1Glam6CUzjAy1D38zRReou9b0vJu9UcUd
 kKLPfSjZ2OmOW2ktu/8GYcQ6/MF1loCTfEKU0ocVa0yto9UJ0xNZlPMofhrm3U1Phk
 XB+vyOonYwcIELnvZ37YsgF1qpGAvW+p3ezwAgAA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <71fe2382-4738-6f6b-8541-629edc726464@yandex-team.ru>
Date: Wed, 31 May 2023 11:04:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 06/14] nbd/server: Refactor handling of request payload
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: libguestfs@redhat.com,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-7-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230515195343.1915857-7-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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
> Upcoming additions to support NBD 64-bit effect lengths allow for the
> possibility to distinguish between payload length (capped at 32M) and
> effect length (up to 63 bits).  Without that extension, only the
> NBD_CMD_WRITE request has a payload; but with the extension, it makes
> sense to allow at least NBD_CMD_BLOCK_STATUS to have both a payload
> and effect length (where the payload is a limited-size struct that in
> turns gives the real effect length as well as a subset of known ids
> for which status is requested).  Other future NBD commands may also
> have a request payload, so the 64-bit extension introduces a new
> NBD_CMD_FLAG_PAYLOAD_LEN that distinguishes between whether the header
> length is a payload length or an effect length, rather than
> hard-coding the decision based on the command.  Note that we do not
> support the payload version of BLOCK_STATUS yet.
> 
> For this patch, no semantic change is intended for a compliant client.
> For a non-compliant client, it is possible that the error behavior
> changes (a different message, a change on whether the connection is
> killed or remains alive for the next command, or so forth), but all
> errors should still be handled gracefully.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   nbd/server.c     | 55 +++++++++++++++++++++++++++++++++---------------
>   nbd/trace-events |  1 +
>   2 files changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index cf38a104d9a..5812a773ace 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -2316,6 +2316,8 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
>                                                  Error **errp)
>   {
>       NBDClient *client = req->client;
> +    bool extended_with_payload;
> +    int payload_len = 0;
>       int valid_flags;
>       int ret;
> 
> @@ -2329,27 +2331,41 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
>       trace_nbd_co_receive_request_decode_type(request->handle, request->type,
>                                                nbd_cmd_lookup(request->type));
> 
> -    if (request->type != NBD_CMD_WRITE) {
> -        /* No payload, we are ready to read the next request.  */
> -        req->complete = true;
> -    }
> -
>       if (request->type == NBD_CMD_DISC) {
>           /* Special case: we're going to disconnect without a reply,
>            * whether or not flags, from, or len are bogus */
> +        req->complete = true;
>           return -EIO;
>       }
> 
> +    /* Payload and buffer handling. */
> +    extended_with_payload = client->header_style >= NBD_HEADER_EXTENDED &&
> +        (request->flags & NBD_CMD_FLAG_PAYLOAD_LEN);
>       if (request->type == NBD_CMD_READ || request->type == NBD_CMD_WRITE ||
> -        request->type == NBD_CMD_CACHE)
> -    {
> +        request->type == NBD_CMD_CACHE || extended_with_payload) {
>           if (request->len > NBD_MAX_BUFFER_SIZE) {
>               error_setg(errp, "len (%" PRIu64" ) is larger than max len (%u)",
>                          request->len, NBD_MAX_BUFFER_SIZE);

hmm pre-patch, here req->complete is set to true, except for WRITE request

>               return -EINVAL;
>           }
> 

the whole big if with sub-ifs becomes really hard to read. At least, I think, no reason to keep the following two ifs inside the bigger if, as small ifs just check the same conditions.

> -        if (request->type != NBD_CMD_CACHE) {
> +        if (request->type == NBD_CMD_WRITE || extended_with_payload) {
> +            payload_len = request->len;
> +            if (request->type != NBD_CMD_WRITE) {
> +                /*
> +                 * For now, we don't support payloads on other
> +                 * commands; but we can keep the connection alive.
> +                 */
> +                request->len = 0;
> +            } else if (client->header_style >= NBD_HEADER_EXTENDED &&
> +                       !extended_with_payload) {
> +                /* The client is noncompliant. Trace it, but proceed. */
> +                trace_nbd_co_receive_ext_payload_compliance(request->from,
> +                                                            request->len);
> +            }
> +        }
> +
> +        if (request->type == NBD_CMD_WRITE || request->type == NBD_CMD_READ) {
>               req->data = blk_try_blockalign(client->exp->common.blk,
>                                              request->len);
>               if (req->data == NULL) {
> @@ -2359,18 +2375,20 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
>           }
>       }
> 
> -    if (request->type == NBD_CMD_WRITE) {
> -        assert(request->len <= NBD_MAX_BUFFER_SIZE);
> -        if (nbd_read(client->ioc, req->data, request->len, "CMD_WRITE data",
> -                     errp) < 0)
> -        {
> +    if (payload_len) {
> +        if (req->data) {
> +            ret = nbd_read(client->ioc, req->data, payload_len,
> +                           "CMD_WRITE data", errp);
> +        } else {
> +            ret = nbd_drop(client->ioc, payload_len, errp);
> +        }
> +        if (ret < 0) {
>               return -EIO;
>           }
> -        req->complete = true;
> -
>           trace_nbd_co_receive_request_payload_received(request->handle,
> -                                                      request->len);
> +                                                      payload_len);
>       }
> +    req->complete = true;
> 
>       /* Sanity checks. */
>       if (client->exp->nbdflags & NBD_FLAG_READ_ONLY &&
> @@ -2400,7 +2418,10 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
>                                                 client->check_align);
>       }
>       valid_flags = NBD_CMD_FLAG_FUA;
> -    if (request->type == NBD_CMD_READ &&
> +    if (request->type == NBD_CMD_WRITE &&
> +        client->header_style >= NBD_HEADER_EXTENDED) {
> +        valid_flags |= NBD_CMD_FLAG_PAYLOAD_LEN;
> +    } else if (request->type == NBD_CMD_READ &&
>           client->header_style >= NBD_HEADER_STRUCTURED) {
>           valid_flags |= NBD_CMD_FLAG_DF;
>       } else if (request->type == NBD_CMD_WRITE_ZEROES) {
> diff --git a/nbd/trace-events b/nbd/trace-events
> index e2c1d68688d..adf5666e207 100644
> --- a/nbd/trace-events
> +++ b/nbd/trace-events
> @@ -71,6 +71,7 @@ nbd_co_send_extents(uint64_t handle, unsigned int extents, uint32_t id, uint64_t
>   nbd_co_send_structured_error(uint64_t handle, int err, const char *errname, const char *msg) "Send structured error reply: handle = %" PRIu64 ", error = %d (%s), msg = '%s'"
>   nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type, const char *name) "Decoding type: handle = %" PRIu64 ", type = %" PRIu16 " (%s)"
>   nbd_co_receive_request_payload_received(uint64_t handle, uint64_t len) "Payload received: handle = %" PRIu64 ", len = %" PRIu64
> +nbd_co_receive_ext_payload_compliance(uint64_t from, uint64_t len) "client sent non-compliant write without payload flag: from=0x%" PRIx64 ", len=0x%" PRIx64
>   nbd_co_receive_align_compliance(const char *op, uint64_t from, uint64_t len, uint32_t align) "client sent non-compliant unaligned %s request: from=0x%" PRIx64 ", len=0x%" PRIx64 ", align=0x%" PRIx32
>   nbd_trip(void) "Reading request"
> 

-- 
Best regards,
Vladimir


