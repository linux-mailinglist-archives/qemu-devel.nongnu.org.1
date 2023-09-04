Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC72791B5C
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:17:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCEy-0007xi-OB; Mon, 04 Sep 2023 12:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qdCEP-0007Fz-1E; Mon, 04 Sep 2023 12:15:18 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qdCEI-00082S-Fb; Mon, 04 Sep 2023 12:15:16 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:549c:0:640:379e:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 2BFDF5F437;
 Mon,  4 Sep 2023 19:15:05 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b518::1:22] (unknown
 [2a02:6b8:b081:b518::1:22])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 4FZoKO0OhSw0-YLFI65uu; Mon, 04 Sep 2023 19:15:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1693844104;
 bh=SGj/5sWnnuBnXLOp/4doL2OL7co9SKvNnmPYdBNOEpI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=exgcd/MSNoN7sDkCcZjVtPX9oBm9O1TUI+Fy4NHFax8evPd4A+zJNwPxy0rQ8p5FM
 o8rN5wpeWJwQJsjCF3AUlY0FX8R9yGrBzoYpu1w9iIylITfzlj4avrObjEwX+hr/Ng
 VfTKwWyJ6N2QYIvOpA2rD2wyjlN5s6LX7v4KPF6w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3a136ddb-2ea7-ef26-d9b8-7f55f068996c@yandex-team.ru>
Date: Mon, 4 Sep 2023 19:15:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 04/17] nbd: Prepare for 64-bit request effect lengths
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
References: <20230829175826.377251-19-eblake@redhat.com>
 <20230829175826.377251-23-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230829175826.377251-23-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> Widen the length field of NBDRequest to 64-bits, although we can
> assert that all current uses are still under 32 bits: either because
> of NBD_MAX_BUFFER_SIZE which is even smaller (and where size_t can
> still be appropriate, even on 32-bit platforms), or because nothing
> ever puts us into NBD_MODE_EXTENDED yet (and while future patches will
> allow larger transactions, the lengths in play here are still capped
> at 32-bit).  There are no semantic changes, other than a typo fix in a
> couple of error messages.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> v6: fix sign extension bug
> 
> v5: tweak commit message, adjust a few more spots [Vladimir]
> 
> v4: split off enum changes to earlier patches [Vladimir]

[..]

> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1165,7 +1165,7 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
>           client->optlen = length;
> 
>           if (length > NBD_MAX_BUFFER_SIZE) {
> -            error_setg(errp, "len (%" PRIu32" ) is larger than max len (%u)",
> +            error_setg(errp, "len (%" PRIu32 ") is larger than max len (%u)",
>                          length, NBD_MAX_BUFFER_SIZE);
>               return -EINVAL;
>           }
> @@ -1441,7 +1441,7 @@ static int coroutine_fn nbd_receive_request(NBDClient *client, NBDRequest *reque
>       request->type   = lduw_be_p(buf + 6);
>       request->cookie = ldq_be_p(buf + 8);
>       request->from   = ldq_be_p(buf + 16);
> -    request->len    = ldl_be_p(buf + 24);
> +    request->len    = (uint32_t)ldl_be_p(buf + 24); /* widen 32 to 64 bits */

should it be "(uint64_t)" ?

> 
>       trace_nbd_receive_request(magic, request->flags, request->type,
>                                 request->from, request->len);
> @@ -1899,7 +1899,7 @@ static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
>                                                    NBDRequest *request,
>                                                    uint32_t error,
>                                                    void *data,
> -                                                 size_t len,
> +                                                 uint64_t len,
>                                                    Error **errp)
>   {
>       NBDSimpleReply reply;
> @@ -1910,6 +1910,7 @@ static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
>       };
> 
>       assert(!len || !nbd_err);
> +    assert(len <= NBD_MAX_STRING_SIZE);

NBD_MAX_BUFFER_SIZE ?

with that fixed:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>



-- 
Best regards,
Vladimir


