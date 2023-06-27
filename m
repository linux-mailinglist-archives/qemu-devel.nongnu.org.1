Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A5673FCCE
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:24:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8g7-00021z-NO; Tue, 27 Jun 2023 09:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qE8fy-00020B-Ab; Tue, 27 Jun 2023 09:24:10 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qE8ft-0003bS-NE; Tue, 27 Jun 2023 09:24:09 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 1B3C6618EB;
 Tue, 27 Jun 2023 16:23:51 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b68e::1:39] (unknown
 [2a02:6b8:b081:b68e::1:39])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id nNLHu30OhOs0-Gn5egE5x; Tue, 27 Jun 2023 16:23:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1687872230; bh=sQi/wTnO27DWrDkyRU9Oz7cxgO49ymSKfrogH/U/wqo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=hPWhOi1ctUYRGDW6ch1OsnoXDAhcbjs0glZ51iM1OPAK6y7JMJ7EfpGvHHBwHk1XK
 2CzseuhPbMKDOWluhnOMUIYZyfsc6nV1aYXO8vC2L+ZIO+S9axRxAlpjNMn6joMOCs
 UlNHMCouHkEwplcpBQ9XTcUz9Xw3XuU2hUahyS7Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <26b732b9-c1e5-a032-6139-a01ac1fbd2bd@yandex-team.ru>
Date: Tue, 27 Jun 2023 16:23:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 16/24] nbd/server: Support 64-bit block status
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-17-eblake@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230608135653.2918540-17-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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
> The NBD spec states that if the client negotiates extended headers,
> the server must avoid NBD_REPLY_TYPE_BLOCK_STATUS and instead use
> NBD_REPLY_TYPE_BLOCK_STATUS_EXT which supports 64-bit lengths, even if
> the reply does not need more than 32 bits.  As of this patch,
> client->mode is still never NBD_MODE_EXTENDED, so the code added here
> does not take effect until the next patch enables negotiation.
> 
> For now, all metacontexts that we know how to export never populate
> more than 32 bits of information, so we don't have to worry about
> NBD_REP_ERR_EXT_HEADER_REQD or filtering during handshake, and we
> always send all zeroes for the upper 32 bits of status during
> NBD_CMD_BLOCK_STATUS.
> 
> Note that we previously had some interesting size-juggling on call
> chains, such as:
> 
> nbd_co_send_block_status(uint32_t length)
> -> blockstatus_to_extents(uint32_t bytes)
>    -> bdrv_block_status_above(bytes, &uint64_t num)
>    -> nbd_extent_array_add(uint64_t num)
>      -> store num in 32-bit length
> 
> But we were lucky that it never overflowed: bdrv_block_status_above
> never sets num larger than bytes, and we had previously been capping
> 'bytes' at 32 bits (since the protocol does not allow sending a larger
> request without extended headers).  This patch adds some assertions
> that ensure we continue to avoid overflowing 32 bits for a narrow


[..]

> @@ -2162,19 +2187,23 @@ static void nbd_extent_array_convert_to_be(NBDExtentArray *ea)
>    * would result in an incorrect range reported to the client)
>    */
>   static int nbd_extent_array_add(NBDExtentArray *ea,
> -                                uint32_t length, uint32_t flags)
> +                                uint64_t length, uint32_t flags)
>   {
>       assert(ea->can_add);
> 
>       if (!length) {
>           return 0;
>       }
> +    if (!ea->extended) {
> +        assert(length <= UINT32_MAX);
> +    }
> 
>       /* Extend previous extent if flags are the same */
>       if (ea->count > 0 && flags == ea->extents[ea->count - 1].flags) {
> -        uint64_t sum = (uint64_t)length + ea->extents[ea->count - 1].length;
> +        uint64_t sum = length + ea->extents[ea->count - 1].length;
> 
> -        if (sum <= UINT32_MAX) {
> +        assert(sum >= length);
> +        if (sum <= UINT32_MAX || ea->extended) {

that "if" and uint64_t sum was to avoid overflow. I think, we can't just assert, instead include the check into if:

if (sum >= length && (sum <= UINT32_MAX || ea->extended) {

  ...

}

with this:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


