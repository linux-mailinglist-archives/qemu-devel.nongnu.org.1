Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE3E717834
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 09:28:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4GFp-0007kO-NA; Wed, 31 May 2023 03:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4GFm-0007jh-1f; Wed, 31 May 2023 03:28:18 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4GFi-0005cO-UE; Wed, 31 May 2023 03:28:17 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0d:3786:0:640:7c97:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 425BD61DC7;
 Wed, 31 May 2023 10:28:04 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a512::1:34] (unknown
 [2a02:6b8:b081:a512::1:34])
 by mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2SHmgV5Me4Y0-1b4Hwnln; Wed, 31 May 2023 10:28:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1685518083; bh=QMkxd62VFk8EV417UUVj/25yVDpSo40/9FGxxMN47L4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=VgEZczmopm+nj3o2mTiMFyySgeiBCfa3foaitKBvx8q/ITyWV0ViuNPFTbSXU8iLL
 IsBxgB1xXayd6ZTk/G8xmR7VJJL+bADhODT0duydDC3t63dgazggDCLFEj3s62vFK1
 y531wcknFzw/zM2Le9NOe7ppdZm3IoirV+WAzlxQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <75188c78-2bcf-326e-1d85-43ca81e4648a@yandex-team.ru>
Date: Wed, 31 May 2023 10:28:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 03/14] nbd/server: Prepare for alternate-size headers
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, libguestfs@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-4-eblake@redhat.com>
 <7f9afa94-4817-d33a-4565-20b654190e3d@yandex-team.ru>
 <xheanhxhevlqm7fcnvnvpjv3e3bnmjbf2nwfnu7g54pzeu2jn4@rybss73nu4gq>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <xheanhxhevlqm7fcnvnvpjv3e3bnmjbf2nwfnu7g54pzeu2jn4@rybss73nu4gq>
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

On 30.05.23 19:29, Eric Blake wrote:
> On Mon, May 29, 2023 at 05:26:50PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 15.05.23 22:53, Eric Blake wrote:
>>> Upstream NBD now documents[1] an extension that supports 64-bit effect
>>> lengths in requests.  As part of that extension, the size of the reply
>>> headers will change in order to permit a 64-bit length in the reply
>>> for symmetry[2].  Additionally, where the reply header is currently
>>> 16 bytes for simple reply, and 20 bytes for structured reply; with the
>>> extension enabled, there will only be one structured reply type, of 32
>>> bytes.  Since we are already wired up to use iovecs, it is easiest to
>>> allow for this change in header size by splitting each structured
>>> reply across two iovecs, one for the header (which will become
>>> variable-length in a future patch according to client negotiation),
>>> and the other for the payload, and removing the header from the
>>> payload struct definitions.  Interestingly, the client side code never
>>> utilized the packed types, so only the server code needs to be
>>> updated.
>>
>> Actually, it does, since previous patch :) But, it becomes even better now? Anyway some note somewhere is needed I think.
> 
> Oh, indeed - but only in a sizeof expression for an added assertion
> check, and not actually for in-memory storage.
> 
> If you are envisioning a comment addition, where are you thinking it
> should be placed?

Thinking of it again, the check in 02 is incorrect originally, as it calculates NBDStructuredReplyChunk as part of payload, and with 03 it becomes correct. So, swapping 02 and 03 commits will make everything correct with no additional comments.

> 
>>
>>>
>>> -static inline void set_be_chunk(NBDStructuredReplyChunk *chunk, uint16_t flags,
>>> -                                uint16_t type, uint64_t handle, uint32_t length)
>>> +static inline void set_be_chunk(NBDClient *client, struct iovec *iov,
>>
>> Suggestion: pass niov here too, and caluculate "length" as a sum of iov lengths starting from second extent automatically.
> 
> Makes sense.
> 
>>
>> Also, worth documenting that set_be_chunk() expects half-initialized iov, with .iov_base pointing to NBDReply (IN parameter) and .iov_len unset (OUT parameter), as that's not usual practice
> 
> Yeah, I'm not sure if there is a better interface, but either I come
> up with one, or at least better document what I landed on.
> 
>>
>>> +                                uint16_t flags, uint16_t type,
>>> +                                uint64_t handle, uint32_t length)
>>>    {
>>> +    NBDStructuredReplyChunk *chunk = iov->iov_base;
>>> +
>>> +    iov->iov_len = sizeof(*chunk);
>>>        stl_be_p(&chunk->magic, NBD_STRUCTURED_REPLY_MAGIC);
>>>        stw_be_p(&chunk->flags, flags);
>>>        stw_be_p(&chunk->type, type);
>>
>> [..]
>>
>> -- 
>> Best regards,
>> Vladimir
>>
> 

-- 
Best regards,
Vladimir


