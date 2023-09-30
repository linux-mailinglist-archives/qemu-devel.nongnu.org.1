Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D837B4073
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 15:25:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmZxC-0007bS-Qh; Sat, 30 Sep 2023 09:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qmZxA-0007aW-4P; Sat, 30 Sep 2023 09:24:16 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qmZx7-0007b1-3z; Sat, 30 Sep 2023 09:24:15 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7d8a:0:640:8fc3:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 763A7635D5;
 Sat, 30 Sep 2023 16:24:04 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b5a0::1:9] (unknown
 [2a02:6b8:b081:b5a0::1:9])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2OTuxF1Oq4Y0-PUKe5ueZ; Sat, 30 Sep 2023 16:24:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696080243;
 bh=h5cjJQBImGgEOMGtyDZNTpxntdCtsMNRighQmjrE/l8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=VvhBYTW4ttNI1ri0+XjLFmpCBZ2gW1FUysksQd3t/N5jrdj7UtBvOwXI5AxDKsd2W
 b72rtYY0uU0SfnDGfPnJT/QPx7gI/+KMFFnKvLKHtAliof4xicnZJeKKhPWaVKD4wB
 0g/9hAVidmq5fexAycPD0Kbw5cpMEL9x1o8fHEZM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6b380866-b707-89d5-7478-476582cdd255@yandex-team.ru>
Date: Sat, 30 Sep 2023 16:24:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 12/12] nbd/server: Add FLAG_PAYLOAD support to
 CMD_BLOCK_STATUS
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20230925192229.3186470-14-eblake@redhat.com>
 <20230925192229.3186470-26-eblake@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230925192229.3186470-26-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.587,
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

On 25.09.23 22:22, Eric Blake wrote:
> Allow a client to request a subset of negotiated meta contexts.  For
> example, a client may ask to use a single connection to learn about
> both block status and dirty bitmaps, but where the dirty bitmap
> queries only need to be performed on a subset of the disk; forcing the
> server to compute that information on block status queries in the rest
> of the disk is wasted effort (both at the server, and on the amount of
> traffic sent over the wire to be parsed and ignored by the client).
> 
> Qemu as an NBD client never requests to use more than one meta
> context, so it has no need to use block status payloads.  Testing this
> instead requires support from libnbd, which CAN access multiple meta
> contexts in parallel from a single NBD connection; an interop test
> submitted to the libnbd project at the same time as this patch
> demonstrates the feature working, as well as testing some corner cases
> (for example, when the payload length is longer than the export
> length), although other corner cases (like passing the same id
> duplicated) requires a protocol fuzzer because libnbd is not wired up
> to break the protocol that badly.
> 
> This also includes tweaks to 'qemu-nbd --list' to show when a server
> is advertising the capability, and to the testsuite to reflect the
> addition to that output.
> 
> Of note: qemu will always advertise the new feature bit during
> NBD_OPT_INFO if extended headers have alreay been negotiated
> (regardless of whether any NBD_OPT_SET_META_CONTEXT negotiation has
> occurred); but for NBD_OPT_GO, qemu only advertises the feature if
> block status is also enabled (that is, if the client does not
> negotiate any contexts, then NBD_CMD_BLOCK_STATUS cannot be used, so
> the feature is not advertised).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 

[..]

> 
> +/*
> + * nbd_co_block_status_payload_read
> + * Called when a client wants a subset of negotiated contexts via a
> + * BLOCK_STATUS payload.  Check the payload for valid length and
> + * contents.  On success, return 0 with request updated to effective
> + * length.  If request was invalid but all payload consumed, return 0
> + * with request->len and request->contexts->count set to 0 (which will
> + * trigger an appropriate NBD_EINVAL response later on).  Return
> + * negative errno if the payload was not fully consumed.
> + */
> +static int
> +nbd_co_block_status_payload_read(NBDClient *client, NBDRequest *request,
> +                                 Error **errp)

[..]

> +        payload_len > (sizeof(NBDBlockStatusPayload) +
> +                       sizeof(id) * client->contexts.count)) {
> +        goto skip;
> +    }
> +
> +    buf = g_malloc(payload_len);
> +    if (nbd_read(client->ioc, buf, payload_len,
> +                 "CMD_BLOCK_STATUS data", errp) < 0) {
> +        return -EIO;
> +    }
> +    trace_nbd_co_receive_request_payload_received(request->cookie,
> +                                                  payload_len);
> +    request->contexts->bitmaps = g_new0(bool, nr_bitmaps);
> +    count = (payload_len - sizeof(NBDBlockStatusPayload)) / sizeof(id);
> +    payload_len = 0;
> +
> +    for (i = 0; i < count; i++) {
> +        id = ldl_be_p(buf + sizeof(NBDBlockStatusPayload) + sizeof(id) * i);
> +        if (id == NBD_META_ID_BASE_ALLOCATION) {
> +            if (request->contexts->base_allocation) {
> +                goto skip;
> +            }

should we also check that base_allocation is negotiated?

> +            request->contexts->base_allocation = true;
> +        } else if (id == NBD_META_ID_ALLOCATION_DEPTH) {
> +            if (request->contexts->allocation_depth) {
> +                goto skip;
> +            }

same here

> +            request->contexts->allocation_depth = true;
> +        } else {
> +            int idx = id - NBD_META_ID_DIRTY_BITMAP;
> +

I think, we also should check that idx >=0 after this operation.

> +            if (idx > nr_bitmaps || request->contexts->bitmaps[idx]) {
> +                goto skip;
> +            }
> +            request->contexts->bitmaps[idx] = true;
> +        }
> +    }
> +
> +    request->len = ldq_be_p(buf);
> +    request->contexts->count = count;
> +    return 0;
> +
> + skip:
> +    trace_nbd_co_receive_block_status_payload_compliance(request->from,
> +                                                         request->len);
> +    request->len = request->contexts->count = 0;
> +    return nbd_drop(client->ioc, payload_len, errp);
> +}
> +

[..]

> diff --git a/nbd/trace-events b/nbd/trace-events
> index 8f4e20ee9f2..ac186c19ec0 100644
> --- a/nbd/trace-events
> +++ b/nbd/trace-events
> @@ -70,6 +70,7 @@ nbd_co_send_chunk_read(uint64_t cookie, uint64_t offset, void *data, uint64_t si
>   nbd_co_send_chunk_read_hole(uint64_t cookie, uint64_t offset, uint64_t size) "Send structured read hole reply: cookie = %" PRIu64 ", offset = %" PRIu64 ", len = %" PRIu64
>   nbd_co_send_extents(uint64_t cookie, unsigned int extents, uint32_t id, uint64_t length, int last) "Send block status reply: cookie = %" PRIu64 ", extents = %u, context = %d (extents cover %" PRIu64 " bytes, last chunk = %d)"
>   nbd_co_send_chunk_error(uint64_t cookie, int err, const char *errname, const char *msg) "Send structured error reply: cookie = %" PRIu64 ", error = %d (%s), msg = '%s'"
> +nbd_co_receive_block_status_payload_compliance(uint64_t from, int len) "client sent unusable block status payload: from=0x%" PRIx64 ", len=0x%x"

both passed parameters request->from and request->len are uint64_t actually

>   nbd_co_receive_request_decode_type(uint64_t cookie, uint16_t type, const char *name) "Decoding type: cookie = %" PRIu64 ", type = %" PRIu16 " (%s)"
>   nbd_co_receive_request_payload_received(uint64_t cookie, uint64_t len) "Payload received: cookie = %" PRIu64 ", len = %" PRIu64
>   nbd_co_receive_ext_payload_compliance(uint64_t from, uint64_t len) "client sent non-compliant write without payload flag: from=0x%" PRIx64 ", len=0x%" PRIx64

[..]

-- 
Best regards,
Vladimir


