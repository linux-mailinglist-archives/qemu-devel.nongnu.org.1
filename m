Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF07473FCE1
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:32:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8n9-0007zh-HQ; Tue, 27 Jun 2023 09:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qE8mt-0007vd-Bc; Tue, 27 Jun 2023 09:31:20 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qE8mr-0005sY-10; Tue, 27 Jun 2023 09:31:19 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:168f:0:640:3294:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id F21F9605FE;
 Tue, 27 Jun 2023 16:31:03 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b68e::1:39] (unknown
 [2a02:6b8:b081:b68e::1:39])
 by mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2VLEZ40OqKo0-ijbxX89l; Tue, 27 Jun 2023 16:31:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1687872663; bh=xDm3ADCGX0/CWtSIa4dc3ZBjQn+mRUug2ewMaSIvCkI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=vdnIMiJL6gAXcb8ubEDqE46AzEF2BA6tJMTnJv4RlaUfGgKAZY6oYFvCM1u6sbD1u
 na4lFnZZ4us1SWzzUPCkX67jxsFQiGKLD3jPgCa5yo/Kk0s8bb4fVVoj5+zbSprgs8
 DObKd0dZs8FazporJiVbiGMbRZwu6uyQKWMJc71g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <29ea1bc9-e4d5-c3bc-cd8c-d82a98123041@yandex-team.ru>
Date: Tue, 27 Jun 2023 16:31:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 18/24] nbd/client: Plumb errp through
 nbd_receive_replies
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-19-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230608135653.2918540-19-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 08.06.23 16:56, Eric Blake wrote:
> Instead of ignoring the low-level error just to refabricate our own
> message to pass to the caller, we can just plump the caller's errp
> down to the low level.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> v4: new patch [Vladimir]
> ---
>   block/nbd.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 57123c17f94..c17ce935f17 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -417,7 +417,8 @@ static void coroutine_fn GRAPH_RDLOCK nbd_reconnect_attempt(BDRVNBDState *s)
>       reconnect_delay_timer_del(s);
>   }
> 
> -static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie)
> +static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
> +                                            Error **errp)
>   {
>       int ret;
>       uint64_t ind = COOKIE_TO_INDEX(cookie), ind2;
> @@ -458,9 +459,12 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie)
> 
>           /* We are under mutex and cookie is 0. We have to do the dirty work. */
>           assert(s->reply.cookie == 0);
> -        ret = nbd_receive_reply(s->bs, s->ioc, &s->reply, NULL);
> -        if (ret <= 0) {
> -            ret = ret ? ret : -EIO;
> +        ret = nbd_receive_reply(s->bs, s->ioc, &s->reply, errp);
> +        if (ret == 0) {
> +            ret = -EIO;
> +            error_setg(errp, "server dropped connection");

we also need to set errp for further negative returns in the function

> +        }
> +        if (ret < 0) {
>               nbd_channel_error(s, ret);
>               return ret;
>           }
> @@ -843,9 +847,9 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
>       }
>       *request_ret = 0;
> 
> -    ret = nbd_receive_replies(s, cookie);
> +    ret = nbd_receive_replies(s, cookie, errp);
>       if (ret < 0) {
> -        error_setg(errp, "Connection closed");
> +        error_prepend(errp, "Connection closed: ");
>           return -EIO;
>       }
>       assert(s->ioc);

-- 
Best regards,
Vladimir


