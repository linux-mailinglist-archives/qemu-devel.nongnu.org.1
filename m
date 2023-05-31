Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 405957188A2
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 19:41:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4PoA-0006vq-J6; Wed, 31 May 2023 13:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4Pnw-0006uq-Lo; Wed, 31 May 2023 13:40:13 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4Pnp-0003HH-NJ; Wed, 31 May 2023 13:40:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0d:3786:0:640:7c97:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 464C961DAA;
 Wed, 31 May 2023 20:39:55 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a512::1:34] (unknown
 [2a02:6b8:b081:a512::1:34])
 by mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id sdRjRd5MeSw0-b39VKY0B; Wed, 31 May 2023 20:39:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1685554794; bh=KsPuSIMh+7o+C2fPDGfJum0T8YZ/Arl/+7GOB6zbQ1I=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=P266/+/tC7bwdqZQhxscT8qiW8B7M6lt4piJakFXCrLOgSEJtE1KsMaxVHgpUVnzU
 Wp9uK+9iU+pk3Fs7eBXfLIaS2tZUS7awNVg5eyW2LXFbY6pkSLfFoDRscw52Xuupxd
 UV1CnlnxYeuM4l+13C1IVoU6AC7Wjx84ZePO6EwQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <1af7f692-b5de-c767-2568-1fc024a57133@yandex-team.ru>
Date: Wed, 31 May 2023 20:39:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 12/14] nbd/client: Request extended headers during
 negotiation
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-13-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230515195343.1915857-13-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 15.05.23 22:53, Eric Blake wrote:
> All the pieces are in place for a client to finally request extended
> headers.  Note that we must not request extended headers when qemu-nbd

why must not? It should gracefully report ENOTSUP? Or not?

> is used to connect to the kernel module (as nbd.ko does not expect
> them), but there is no harm in all other clients requesting them.
> 
> Extended headers are not essential to the information collected during
> 'qemu-nbd --list', but probing for it gives us one more piece of
> information in that output.  Update the iotests affected by the new
> line of output.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   block/nbd.c                                   |  5 +--
>   nbd/client-connection.c                       |  2 +-
>   nbd/client.c                                  | 38 ++++++++++++-------
>   qemu-nbd.c                                    |  3 ++
>   tests/qemu-iotests/223.out                    |  6 +++
>   tests/qemu-iotests/233.out                    |  5 +++
>   tests/qemu-iotests/241.out                    |  3 ++
>   tests/qemu-iotests/307.out                    |  5 +++
>   .../tests/nbd-qemu-allocation.out             |  1 +
>   9 files changed, 51 insertions(+), 17 deletions(-)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 150dfe7170c..db107ff0806 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -1146,10 +1146,9 @@ static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
> 
>           switch (chunk->type) {
>           case NBD_REPLY_TYPE_BLOCK_STATUS_EXT:
> -            wide = true;
> -            /* fallthrough */
>           case NBD_REPLY_TYPE_BLOCK_STATUS:
> -            if (s->info.extended_headers != wide) {
> +            wide = chunk->type == NBD_REPLY_TYPE_BLOCK_STATUS_EXT;
> +            if ((s->info.header_style == NBD_HEADER_EXTENDED) != wide) {

O, that's a part of previous commit. Also, initialization of wide to false becomes unneeded.

>                   trace_nbd_extended_headers_compliance("block_status");
>               }
>               if (received) {
> diff --git a/nbd/client-connection.c b/nbd/client-connection.c
> index 62d75af0bb3..8e0606cadf0 100644
> --- a/nbd/client-connection.c
> +++ b/nbd/client-connection.c
> @@ -93,7 +93,7 @@ NBDClientConnection *nbd_client_connection_new(const SocketAddress *saddr,
>           .do_negotiation = do_negotiation,
> 
>           .initial_info.request_sizes = true,
> -        .initial_info.header_style = NBD_HEADER_STRUCTURED,
> +        .initial_info.header_style = NBD_HEADER_EXTENDED,
>           .initial_info.base_allocation = true,
>           .initial_info.x_dirty_bitmap = g_strdup(x_dirty_bitmap),
>           .initial_info.name = g_strdup(export_name ?: "")
> diff --git a/nbd/client.c b/nbd/client.c
> index e5db3c8b79d..7edddfd2f83 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -879,11 +879,12 @@ static int nbd_list_meta_contexts(QIOChannel *ioc,
>    *          1: server is newstyle, but can only accept EXPORT_NAME
>    *          2: server is newstyle, but lacks structured replies
>    *          3: server is newstyle and set up for structured replies
> + *          4: server is newstyle and set up for extended headers
>    */
>   static int nbd_start_negotiate(AioContext *aio_context, QIOChannel *ioc,
>                                  QCryptoTLSCreds *tlscreds,
>                                  const char *hostname, QIOChannel **outioc,
> -                               bool structured_reply, bool *zeroes,
> +                               NBDHeaderStyle style, bool *zeroes,
>                                  Error **errp)
>   {
>       ERRP_GUARD();
> @@ -961,15 +962,23 @@ static int nbd_start_negotiate(AioContext *aio_context, QIOChannel *ioc,
>           if (fixedNewStyle) {
>               int result = 0;
> 
> -            if (structured_reply) {
> +            if (style >= NBD_HEADER_EXTENDED) {
> +                result = nbd_request_simple_option(ioc,
> +                                                   NBD_OPT_EXTENDED_HEADERS,
> +                                                   false, errp);
> +                if (result) {
> +                    return result < 0 ? -EINVAL : 4;
> +                }
> +            }
> +            if (style >= NBD_HEADER_STRUCTURED) {
>                   result = nbd_request_simple_option(ioc,
>                                                      NBD_OPT_STRUCTURED_REPLY,
>                                                      false, errp);
> -                if (result < 0) {
> -                    return -EINVAL;
> +                if (result) {
> +                    return result < 0 ? -EINVAL : 3;
>                   }
>               }
> -            return 2 + result;
> +            return 2;
>           } else {
>               return 1;
>           }
> @@ -1031,8 +1040,7 @@ int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
>       trace_nbd_receive_negotiate_name(info->name);
> 
>       result = nbd_start_negotiate(aio_context, ioc, tlscreds, hostname, outioc,
> -                                 info->header_style >= NBD_HEADER_STRUCTURED,
> -                                 &zeroes, errp);
> +                                 info->header_style, &zeroes, errp);
> 
>       info->header_style = NBD_HEADER_SIMPLE;
>       info->base_allocation = false;
> @@ -1041,8 +1049,10 @@ int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
>       }
> 
>       switch (result) {
> +    case 4: /* newstyle, with extended headers */
>       case 3: /* newstyle, with structured replies */
> -        info->header_style = NBD_HEADER_STRUCTURED;
> +        /* Relies on encoding of _STRUCTURED and _EXTENDED */
> +        info->header_style = result - 2;

I'd prefer explicit

info->header_style = (result == 4 ? NBD_HEADER_EXTENDED : NBD_HEADER_STRUCTURED);

with no comment

>           if (base_allocation) {
>               result = nbd_negotiate_simple_meta_context(ioc, info, errp);
>               if (result < 0) {
> @@ -1151,8 +1161,8 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
>       QIOChannel *sioc = NULL;
> 
>       *info = NULL;
> -    result = nbd_start_negotiate(NULL, ioc, tlscreds, hostname, &sioc, true,
> -                                 NULL, errp);
> +    result = nbd_start_negotiate(NULL, ioc, tlscreds, hostname, &sioc,
> +                                 NBD_HEADER_EXTENDED, NULL, errp);
>       if (tlscreds && sioc) {
>           ioc = sioc;
>       }
> @@ -1160,6 +1170,7 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
>       switch (result) {
>       case 2:
>       case 3:
> +    case 4:
>           /* newstyle - use NBD_OPT_LIST to populate array, then try
>            * NBD_OPT_INFO on each array member. If structured replies
>            * are enabled, also try NBD_OPT_LIST_META_CONTEXT. */
> @@ -1180,8 +1191,9 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
>               memset(&array[count - 1], 0, sizeof(*array));
>               array[count - 1].name = name;
>               array[count - 1].description = desc;
> -            array[count - 1].header_style = result == 3 ?
> -                NBD_HEADER_STRUCTURED : NBD_HEADER_SIMPLE;
> +
> +            /* Depends on values of _SIMPLE, _STRUCTURED, and _EXTENDED */
> +            array[count - 1].header_style = result - 2;

Personally, I don't like enum-based arithmetics.. It's something to be very careful with and check enum definition every time.

Maybe, add enum NBDConnectionStyle : NBD_STYLE_OLD, NBD_STYLE_EXPORT_NAME, NBD_STYLE_SIMPLE, NBD_STYLE_STRUCTURED, NBD_STYLE_EXTENDED,
and a simple function nbd_con_style_to_hdr_style: NBDConnectionStyle -> NBDHeaderStyle

Or, better, nbd_start_negotiate() may return only 0/1/2 as success values, and additionally set OUT argument *header_style?

And anyway, 0/1/2/3/4 - sounds like too much magic numeric logic


(I feel, that's all a kind of taste and don't want to insist anyway)

>           }
> 
>           for (i = 0; i < count; i++) {
> @@ -1197,7 +1209,7 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
>                   break;
>               }
> 
> -            if (result == 3 &&
> +            if (result >= 3 &&
>                   nbd_list_meta_contexts(ioc, &array[i], errp) < 0) {
>                   goto out;
>               }
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 6ff45308a9c..8c35442626a 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -238,6 +238,9 @@ static int qemu_nbd_client_list(SocketAddress *saddr, QCryptoTLSCreds *tls,
>               printf("  opt block: %u\n", list[i].opt_block);
>               printf("  max block: %u\n", list[i].max_block);
>           }
> +        printf("  transaction size: %s\n",
> +               list[i].header_style >= NBD_HEADER_EXTENDED ?
> +               "64-bit" : "32-bit");
>           if (list[i].n_contexts) {
>               printf("  available meta contexts: %d\n", list[i].n_contexts);
>               for (j = 0; j < list[i].n_contexts; j++) {
> diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
> index 26fb347c5da..b98582c38ea 100644
> --- a/tests/qemu-iotests/223.out
> +++ b/tests/qemu-iotests/223.out
> @@ -87,6 +87,7 @@ exports available: 3
>     min block: 1
>     opt block: 4096
>     max block: 33554432
> +  transaction size: 64-bit
>     available meta contexts: 2
>      base:allocation
>      qemu:dirty-bitmap:b
> @@ -97,6 +98,7 @@ exports available: 3
>     min block: 1
>     opt block: 4096
>     max block: 33554432
> +  transaction size: 64-bit
>     available meta contexts: 2
>      base:allocation
>      qemu:dirty-bitmap:b2
> @@ -106,6 +108,7 @@ exports available: 3
>     min block: 1
>     opt block: 4096
>     max block: 33554432
> +  transaction size: 64-bit
>     available meta contexts: 2
>      base:allocation
>      qemu:dirty-bitmap:b3
> @@ -206,6 +209,7 @@ exports available: 3
>     min block: 1
>     opt block: 4096
>     max block: 33554432
> +  transaction size: 64-bit
>     available meta contexts: 2
>      base:allocation
>      qemu:dirty-bitmap:b
> @@ -216,6 +220,7 @@ exports available: 3
>     min block: 1
>     opt block: 4096
>     max block: 33554432
> +  transaction size: 64-bit
>     available meta contexts: 2
>      base:allocation
>      qemu:dirty-bitmap:b2
> @@ -225,6 +230,7 @@ exports available: 3
>     min block: 1
>     opt block: 4096
>     max block: 33554432
> +  transaction size: 64-bit
>     available meta contexts: 2
>      base:allocation
>      qemu:dirty-bitmap:b3
> diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
> index 237c82767ea..33cb622ecf0 100644
> --- a/tests/qemu-iotests/233.out
> +++ b/tests/qemu-iotests/233.out
> @@ -53,6 +53,11 @@ exports available: 1
>    export: ''
>     size:  67108864
>     min block: 1
> +  opt block: 4096
> +  max block: 33554432
> +  transaction size: 64-bit
> +  available meta contexts: 1
> +   base:allocation
> 
>   == check TLS with different CA fails ==
>   qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': The certificate hasn't got a known issuer
> diff --git a/tests/qemu-iotests/241.out b/tests/qemu-iotests/241.out
> index 88e8cfcd7e2..a9efb876521 100644
> --- a/tests/qemu-iotests/241.out
> +++ b/tests/qemu-iotests/241.out
> @@ -6,6 +6,7 @@ exports available: 1
>    export: ''
>     size:  1024
>     min block: 1
> +  transaction size: 64-bit
>   [{ "start": 0, "length": 1000, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
>   { "start": 1000, "length": 24, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET}]
>   1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
> @@ -16,6 +17,7 @@ exports available: 1
>    export: ''
>     size:  1024
>     min block: 512
> +  transaction size: 64-bit
>   [{ "start": 0, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
>   1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
>   WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
> @@ -28,6 +30,7 @@ exports available: 1
>    export: ''
>     size:  1024
>     min block: 1
> +  transaction size: 64-bit
>   [{ "start": 0, "length": 1000, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
>   { "start": 1000, "length": 24, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET}]
>   1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
> diff --git a/tests/qemu-iotests/307.out b/tests/qemu-iotests/307.out
> index 390f05d1b78..2b9a6a67a1a 100644
> --- a/tests/qemu-iotests/307.out
> +++ b/tests/qemu-iotests/307.out
> @@ -19,6 +19,7 @@ exports available: 1
>     min block: XXX
>     opt block: XXX
>     max block: XXX
> +  transaction size: 64-bit
>     available meta contexts: 1
>      base:allocation
> 
> @@ -47,6 +48,7 @@ exports available: 1
>     min block: XXX
>     opt block: XXX
>     max block: XXX
> +  transaction size: 64-bit
>     available meta contexts: 1
>      base:allocation
> 
> @@ -78,6 +80,7 @@ exports available: 2
>     min block: XXX
>     opt block: XXX
>     max block: XXX
> +  transaction size: 64-bit
>     available meta contexts: 1
>      base:allocation
>    export: 'export1'
> @@ -87,6 +90,7 @@ exports available: 2
>     min block: XXX
>     opt block: XXX
>     max block: XXX
> +  transaction size: 64-bit
>     available meta contexts: 1
>      base:allocation
> 
> @@ -113,6 +117,7 @@ exports available: 1
>     min block: XXX
>     opt block: XXX
>     max block: XXX
> +  transaction size: 64-bit
>     available meta contexts: 1
>      base:allocation
> 
> diff --git a/tests/qemu-iotests/tests/nbd-qemu-allocation.out b/tests/qemu-iotests/tests/nbd-qemu-allocation.out
> index 9d938db24e6..659276032b0 100644
> --- a/tests/qemu-iotests/tests/nbd-qemu-allocation.out
> +++ b/tests/qemu-iotests/tests/nbd-qemu-allocation.out
> @@ -21,6 +21,7 @@ exports available: 1
>     min block: 1
>     opt block: 4096
>     max block: 33554432
> +  transaction size: 64-bit
>     available meta contexts: 2
>      base:allocation
>      qemu:allocation-depth

-- 
Best regards,
Vladimir


