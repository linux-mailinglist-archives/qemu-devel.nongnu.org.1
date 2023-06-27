Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E2E740412
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 21:44:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEEaR-0001Fp-Iz; Tue, 27 Jun 2023 15:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qEEaJ-0001Ex-LG; Tue, 27 Jun 2023 15:42:44 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qEEaE-00054Z-Jq; Tue, 27 Jun 2023 15:42:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a49a:0:640:edd6:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 61AE65FEFC;
 Tue, 27 Jun 2023 22:42:22 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b68e::1:39] (unknown
 [2a02:6b8:b081:b68e::1:39])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id KgRIo70OeiE0-o8hyPEOk; Tue, 27 Jun 2023 22:42:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1687894941; bh=LwcQf1a6E02L8raJDsZGBXR0X9CGPapZWmoYtg6B+H8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=jxGjpBwQZq7hG+9brf++Zpty/BgCLFmcv80j/AvjPx/CM2I9sFb3gTpcyljOM1s98
 rMMuEmkucsbf8EIlH/lJxzAfOIVE/zdO2V/LZd5Np7705wduyTvJ2aQhs5HpTrOOqS
 hX3fMWJlKL68Hjg5ig5EPsu0TuViADXhUUrNfxpM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e09fb0df-ddc2-d731-f735-6f5ccca69846@yandex-team.ru>
Date: Tue, 27 Jun 2023 22:42:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 24/24] nbd/server: Add FLAG_PAYLOAD support to
 CMD_BLOCK_STATUS
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-25-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230608135653.2918540-25-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

[..]

> +static int
> +nbd_co_block_status_payload_read(NBDClient *client, NBDRequest *request,
> +                                 Error **errp)
> +{
> +    int payload_len = request->len;
> +    g_autofree char *buf = NULL;
> +    size_t count, i, nr_bitmaps;
> +    uint32_t id;
> +
> +    assert(request->len <= NBD_MAX_BUFFER_SIZE);
> +    assert(client->contexts.exp == client->exp);
> +    nr_bitmaps = client->exp->nr_export_bitmaps;
> +    request->contexts = g_new0(NBDMetaContexts, 1);
> +    request->contexts->exp = client->exp;
> +
> +    if (payload_len % sizeof(uint32_t) ||
> +        payload_len < sizeof(NBDBlockStatusPayload) ||
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
> +            request->contexts->base_allocation = true;
> +        } else if (id == NBD_META_ID_ALLOCATION_DEPTH) {
> +            if (request->contexts->allocation_depth) {
> +                goto skip;
> +            }
> +            request->contexts->allocation_depth = true;
> +        } else {

maybe,

int ind = id - NBD_META_ID_DIRTY_BITMAP;


> +            if (id - NBD_META_ID_DIRTY_BITMAP > nr_bitmaps ||

>= ?

> +                request->contexts->bitmaps[id - NBD_META_ID_DIRTY_BITMAP]) {
> +                goto skip;
> +            }
> +            request->contexts->bitmaps[id - NBD_META_ID_DIRTY_BITMAP] = true;
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
>   /* nbd_co_receive_request
>    * Collect a client request. Return 0 if request looks valid, -EIO to drop
>    * connection right away, -EAGAIN to indicate we were interrupted and the
> @@ -2470,7 +2552,13 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *

[..]

> @@ -2712,7 +2804,8 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>                                         "discard failed", errp);
> 
>       case NBD_CMD_BLOCK_STATUS:
> -        if (!request->len) {
> +        assert(request->contexts);
> +        if (!request->len && !(request->flags & NBD_CMD_FLAG_PAYLOAD_LEN)) {

why not error-out for len=0 in case of payload?

>               return nbd_send_generic_reply(client, request, -EINVAL,
>                                             "need non-zero length", errp);
>           }
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 1d155fc2c66..cbca0eeee62 100644


-- 
Best regards,
Vladimir


