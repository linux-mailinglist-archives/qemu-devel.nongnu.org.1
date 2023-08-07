Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5833C772CF4
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 19:29:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT42N-0007YF-8S; Mon, 07 Aug 2023 13:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qT42I-0007Wz-Pe; Mon, 07 Aug 2023 13:28:54 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qT42F-0006MT-Dr; Mon, 07 Aug 2023 13:28:54 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:151e:0:640:1960:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 7E8805F211;
 Mon,  7 Aug 2023 20:28:39 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:25::1:2] (unknown [2a02:6b8:b081:25::1:2])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id cSbg901OqGk0-Vyg5LQSg; 
 Mon, 07 Aug 2023 20:28:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1691429318; bh=grEHBkgU9hu1yZmz7YNJC6ZtLO5h/bgvf8jfgBw3y+c=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=WTLV8BUWYa0nHUQG5xC5EsYV9J+I/YYaZ5SVoQoTnHPlhEKRv3L4wcWcyoRU9doMl
 vKoje2nGGp9sr3/jTejVNleIy29xfTtW4GTzRfV9y9axEXB5s9VQk71eJq9MZhhRpR
 /KZ209dWngT8U9djpVFzEFkKZFQcLkopi62Zxc+o=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <712acbc9-ad05-6ac3-1bce-55f9d451ec2b@yandex-team.ru>
Date: Mon, 7 Aug 2023 20:28:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 16/24] nbd/server: Support 64-bit block status
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, libguestfs@redhat.com
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-17-eblake@redhat.com>
 <26b732b9-c1e5-a032-6139-a01ac1fbd2bd@yandex-team.ru>
 <g2kaumiey7rwho4p6awywn4aikyjmdelmiyexqmqfa3634se54@34nc5ekwvtki>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <g2kaumiey7rwho4p6awywn4aikyjmdelmiyexqmqfa3634se54@34nc5ekwvtki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
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

On 04.08.23 22:36, Eric Blake wrote:
> On Tue, Jun 27, 2023 at 04:23:49PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 08.06.23 16:56, Eric Blake wrote:
>>> The NBD spec states that if the client negotiates extended headers,
>>> the server must avoid NBD_REPLY_TYPE_BLOCK_STATUS and instead use
>>> NBD_REPLY_TYPE_BLOCK_STATUS_EXT which supports 64-bit lengths, even if
>>> the reply does not need more than 32 bits.  As of this patch,
>>> client->mode is still never NBD_MODE_EXTENDED, so the code added here
>>> does not take effect until the next patch enables negotiation.
>>>
>>> For now, all metacontexts that we know how to export never populate
>>> more than 32 bits of information, so we don't have to worry about
>>> NBD_REP_ERR_EXT_HEADER_REQD or filtering during handshake, and we
>>> always send all zeroes for the upper 32 bits of status during
>>> NBD_CMD_BLOCK_STATUS.
>>>
>>> Note that we previously had some interesting size-juggling on call
>>> chains, such as:
>>>
>>> nbd_co_send_block_status(uint32_t length)
>>> -> blockstatus_to_extents(uint32_t bytes)
>>>     -> bdrv_block_status_above(bytes, &uint64_t num)
>>>     -> nbd_extent_array_add(uint64_t num)
>>>       -> store num in 32-bit length
>>>
>>> But we were lucky that it never overflowed: bdrv_block_status_above
>>> never sets num larger than bytes, and we had previously been capping
>>> 'bytes' at 32 bits (since the protocol does not allow sending a larger
>>> request without extended headers).  This patch adds some assertions
>>> that ensure we continue to avoid overflowing 32 bits for a narrow
>>
>>
>> [..]
>>
>>> @@ -2162,19 +2187,23 @@ static void nbd_extent_array_convert_to_be(NBDExtentArray *ea)
>>>     * would result in an incorrect range reported to the client)
>>>     */
>>>    static int nbd_extent_array_add(NBDExtentArray *ea,
>>> -                                uint32_t length, uint32_t flags)
>>> +                                uint64_t length, uint32_t flags)
>>>    {
>>>        assert(ea->can_add);
>>>
>>>        if (!length) {
>>>            return 0;
>>>        }
>>> +    if (!ea->extended) {
>>> +        assert(length <= UINT32_MAX);
>>> +    }
>>>
>>>        /* Extend previous extent if flags are the same */
>>>        if (ea->count > 0 && flags == ea->extents[ea->count - 1].flags) {
>>> -        uint64_t sum = (uint64_t)length + ea->extents[ea->count - 1].length;
>>> +        uint64_t sum = length + ea->extents[ea->count - 1].length;
>>>
>>> -        if (sum <= UINT32_MAX) {
>>> +        assert(sum >= length);
>>> +        if (sum <= UINT32_MAX || ea->extended) {
>>
>> that "if" and uint64_t sum was to avoid overflow. I think, we can't just assert, instead include the check into if:
>>
>> if (sum >= length && (sum <= UINT32_MAX || ea->extended) {
> 
> Why?  The assertion is stating that there was no overflow, because we
> are in control of ea->extents[ea->count - 1].length (it came from
> local code performing block status, and our block layer guarantees
> that no block status returns more than 2^63 bytes because we don't
> support images larger than off_t).  At best, all I need is a comment
> why the assertion is valid.

OK. Small comment would be good. Keep my r-b.

The only my point is that you make this small "extent API" block-layer dependent. But I'm not sure that is the only dependency, and I don't insist anyway.

> 
>>
>>   ...
>>
>> }
>>
>> with this:
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>
>> -- 
>> Best regards,
>> Vladimir
>>
> 

-- 
Best regards,
Vladimir


