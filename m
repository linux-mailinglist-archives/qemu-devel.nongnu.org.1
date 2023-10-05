Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 662C67BA021
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 16:34:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoPQF-0007Lb-KA; Thu, 05 Oct 2023 10:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoPPz-0007Cm-Cd; Thu, 05 Oct 2023 10:33:37 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoPPv-0005nw-RX; Thu, 05 Oct 2023 10:33:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7d8a:0:640:8fc3:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 6FDA560E16;
 Thu,  5 Oct 2023 17:33:27 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b584::1:2f] (unknown
 [2a02:6b8:b081:b584::1:2f])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id QXZdiZ4OoeA0-NDjjSqdO; Thu, 05 Oct 2023 17:33:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696516406;
 bh=kVkUUuqAW+75tq8WI7pw+QSXJ9B8Z9ugKl/fh73HT8g=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=vD7dv9OHgcR+6nmIekkIJwtGwVy3dqaPc4iJ1yMzEm//2t8pLVckgVvFktswlVTlB
 mEYbCeSNh7DPVOMCTFV9/iFVSGpUrXGxEK+LTxDz6Vw8SRCPJD/MhsYshyEqtEXJ3U
 b0Xbp0OvTS5oRH1JCMrGm0aIqJ/wQo6RllQeWjCU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0ebcd70e-faf2-4a63-9fa6-6a2334151c22@yandex-team.ru>
Date: Thu, 5 Oct 2023 17:33:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/12] nbd/server: Add FLAG_PAYLOAD support to
 CMD_BLOCK_STATUS
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20230925192229.3186470-14-eblake@redhat.com>
 <20230925192229.3186470-26-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230925192229.3186470-26-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
> v5: factor out 'id - NBD_MTA_ID_DIRTY_BITMAP' [Vladimir], rework logic
> on zero-length requests to be clearer [Vladimir], rebase to earlier
> changes

[..]

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
> +{
> +    int payload_len = request->len;

payload_len should be uint64_t

> +    g_autofree char *buf = NULL;
> +    size_t count, i, nr_bitmaps;
> +    uint32_t id;
> +

otherwise, we may do something unexpected here, when reqeuest->len is too big for int:

> +    if (payload_len > NBD_MAX_BUFFER_SIZE) {
> +        error_setg(errp, "len (%" PRIu64 ") is larger than max len (%u)",
> +                   request->len, NBD_MAX_BUFFER_SIZE);
> +        return -EINVAL;
> +    }
> +
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

[..]

>    * connection right away, -EAGAIN to indicate we were interrupted and the
> @@ -2505,7 +2593,18 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
>           break;
> 
>       case NBD_CMD_BLOCK_STATUS:
> -        request->contexts = &client->contexts;
> +        if (extended_with_payload) {
> +            ret = nbd_co_block_status_payload_read(client, request, errp);
> +            if (ret < 0) {
> +                return ret;
> +            }
> +            /* payload now consumed */
> +            check_length = extended_with_payload = false;

why set extended_with_payload to false? it's a bit misleading. And you don't do this for WRITE request.

> +            payload_len = 0;
> +            valid_flags |= NBD_CMD_FLAG_PAYLOAD_LEN;
> +        } else {
> +            request->contexts = &client->contexts;
> +        }
>           valid_flags |= NBD_CMD_FLAG_REQ_ONE;
>           break;
> 

[..]


with payload_len changed to uint64_t, your squash-in applied and s/>/>=/ fixed:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


-- 
Best regards,
Vladimir


