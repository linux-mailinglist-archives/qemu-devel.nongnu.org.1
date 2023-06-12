Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F7272C95C
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 17:08:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8j9X-00050w-V2; Mon, 12 Jun 2023 11:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q8j9U-000509-NS; Mon, 12 Jun 2023 11:08:17 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q8j9Q-0001wJ-Hs; Mon, 12 Jun 2023 11:08:16 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2c24:0:640:73f8:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 37CC65ED82;
 Mon, 12 Jun 2023 18:08:00 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8910::1:11] (unknown
 [2a02:6b8:b081:8910::1:11])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id x7bB4U1OiqM0-A5qJOVdc; Mon, 12 Jun 2023 18:07:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1686582479; bh=yNnL9wSOI8+5BRI8QYT0ERYKBYIdFV4YveyFCJGQq6o=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=v8l7arwPNPqsKZtlh/KWs2HtLwQEzEKEC5X3Nbkkk+FC5QtIJwbu4eJO66R7/rLGG
 NMJ4ATjj7YZ4HK9qtKH+gIwybg3qV1EmWOeRX3lGAjClwi5tCwthFzJooj7vxGKVkT
 BuCvmlKF62Lkrypk8cbjrX54PKLtFwX0ILLNdM9U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0b857f56-8d61-dcad-d62f-5ca067c138bd@yandex-team.ru>
Date: Mon, 12 Jun 2023 18:07:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 09/24] nbd: Replace bool structured_reply with mode enum
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-10-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230608135653.2918540-10-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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
> The upcoming patches for 64-bit extensions requires various points in
> the protocol to make decisions based on what was negotiated.  While we
> could easily add a 'bool extended_headers' alongside the existing
> 'bool structured_reply', this does not scale well if more modes are
> added in the future.  Better is to expose the mode enum added in the
> previous patch out to a wider use in the code base.
> 
> Where the code previously checked for structured_reply being set or
> clear, it now prefers checking for an inequality; this works because
> the nodes are in a continuum of increasing abilities, and allows us to
> touch fewer places if we ever insert other modes in the middle of the
> enum.  There should be no semantic change in this patch.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> v4: new patch, expanding enum idea from v3 4/14
> ---

[..]

> diff --git a/nbd/server.c b/nbd/server.c
> index 8486b64b15d..bade4f7990c 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -143,7 +143,7 @@ struct NBDClient {
> 
>       uint32_t check_align; /* If non-zero, check for aligned client requests */
> 
> -    bool structured_reply;
> +    NBDMode mode;
>       NBDExportMetaContexts export_meta;
> 
>       uint32_t opt; /* Current option being negotiated */
> @@ -502,7 +502,7 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, bool no_zeroes,
>       }
> 
>       myflags = client->exp->nbdflags;
> -    if (client->structured_reply) {
> +    if (client->mode >= NBD_MODE_STRUCTURED) {
>           myflags |= NBD_FLAG_SEND_DF;
>       }
>       trace_nbd_negotiate_new_style_size_flags(client->exp->size, myflags);
> @@ -687,7 +687,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
> 
>       /* Send NBD_INFO_EXPORT always */
>       myflags = exp->nbdflags;
> -    if (client->structured_reply) {
> +    if (client->mode >= NBD_MODE_STRUCTURED) {
>           myflags |= NBD_FLAG_SEND_DF;
>       }
>       trace_nbd_negotiate_new_style_size_flags(exp->size, myflags);
> @@ -985,7 +985,8 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
>       size_t i;
>       size_t count = 0;
> 
> -    if (client->opt == NBD_OPT_SET_META_CONTEXT && !client->structured_reply) {
> +    if (client->opt == NBD_OPT_SET_META_CONTEXT &&
> +        client->mode < NBD_MODE_STRUCTURED) {
>           return nbd_opt_invalid(client, errp,
>                                  "request option '%s' when structured reply "
>                                  "is not negotiated",
> @@ -1261,13 +1262,13 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
>               case NBD_OPT_STRUCTURED_REPLY:
>                   if (length) {
>                       ret = nbd_reject_length(client, false, errp);
> -                } else if (client->structured_reply) {
> +                } else if (client->mode >= NBD_MODE_STRUCTURED) {
>                       ret = nbd_negotiate_send_rep_err(
>                           client, NBD_REP_ERR_INVALID, errp,
>                           "structured reply already negotiated");
>                   } else {
>                       ret = nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
> -                    client->structured_reply = true;
> +                    client->mode = NBD_MODE_STRUCTURED;

Hmm. in all other cases in server code client.mode remains zero = OLDSTYLE, which is not quite correct.

>                   }
>                   break;
> 
> @@ -1907,7 +1908,9 @@ static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
>       };
> 
>       assert(!len || !nbd_err);
> -    assert(!client->structured_reply || request->type != NBD_CMD_READ);
> +    assert(client->mode < NBD_MODE_STRUCTURED ||
> +           (client->mode == NBD_MODE_STRUCTURED &&
> +            request->type != NBD_CMD_READ));
>       trace_nbd_co_send_simple_reply(request->cookie, nbd_err,
>                                      nbd_err_lookup(nbd_err), len);
>       set_be_simple_reply(&reply, nbd_err, request->cookie);
> @@ -2409,7 +2412,7 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
>                                                 client->check_align);
>       }
>       valid_flags = NBD_CMD_FLAG_FUA;

[..]

-- 
Best regards,
Vladimir


