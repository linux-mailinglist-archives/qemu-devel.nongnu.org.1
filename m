Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA7C772CAF
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 19:21:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3uk-0004EK-N4; Mon, 07 Aug 2023 13:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qT3uh-0004CY-KZ; Mon, 07 Aug 2023 13:21:03 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qT3ue-0004FW-Ld; Mon, 07 Aug 2023 13:21:03 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:168f:0:640:3294:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id C740660264;
 Mon,  7 Aug 2023 20:20:47 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:25::1:2] (unknown [2a02:6b8:b081:25::1:2])
 by mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id lKbQlA1OdOs0-EjaV4EiQ; 
 Mon, 07 Aug 2023 20:20:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1691428847; bh=960Lc+AAXhe/A4Hc3QAA22T7xc5H9zhBO0QuD4ugtm4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Vd4mYiTkWw1T6yViqGQcHIlqcOwMGgg1oH2cFLWAKkzrL2UTS1xUIMLxjMp99Il/y
 EPdvWo2dyjocm8z28CoyVV5RBpIQRLZmNJVbAFRfJi93ek4gT+esA/Na5jNp05xB+k
 fEkakhBd/XRu8jotxqd6XW2TcjlK2F7cU4pmXgXo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <596265ff-727c-bbc2-9a4a-9b4d2cb0aff3@yandex-team.ru>
Date: Mon, 7 Aug 2023 20:20:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 15/24] nbd/server: Prepare to send extended header
 replies
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, libguestfs@redhat.com
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-16-eblake@redhat.com>
 <90f29beb-c032-b057-733e-b272ccb8deb0@yandex-team.ru>
 <ihi2p477ztmxttpcr4u5kajb3xbc777yqjzwumlzvrhiuub62m@bhtdkgqftdcg>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <ihi2p477ztmxttpcr4u5kajb3xbc777yqjzwumlzvrhiuub62m@bhtdkgqftdcg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
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

On 04.08.23 22:28, Eric Blake wrote:
> On Fri, Jun 16, 2023 at 09:48:18PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 08.06.23 16:56, Eric Blake wrote:
>>> Although extended mode is not yet enabled, once we do turn it on, we
>>> need to reply with extended headers to all messages.  Update the low
>>> level entry points necessary so that all other callers automatically
>>> get the right header based on the current mode.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>
>>> v4: new patch, split out from v3 9/14
>>> ---
>>>    nbd/server.c | 30 ++++++++++++++++++++++--------
>>>    1 file changed, 22 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/nbd/server.c b/nbd/server.c
>>> index 119ac765f09..84c848a31d3 100644
>>> --- a/nbd/server.c
>>> +++ b/nbd/server.c
>>> @@ -1947,8 +1947,6 @@ static inline void set_be_chunk(NBDClient *client, struct iovec *iov,
>>>                                    size_t niov, uint16_t flags, uint16_t type,
>>>                                    NBDRequest *request)
>>>    {
>>> -    /* TODO - handle structured vs. extended replies */
>>> -    NBDStructuredReplyChunk *chunk = iov->iov_base;
>>>        size_t i, length = 0;
>>>
>>>        for (i = 1; i < niov; i++) {
>>> @@ -1956,12 +1954,26 @@ static inline void set_be_chunk(NBDClient *client, struct iovec *iov,
>>>        }
>>>        assert(length <= NBD_MAX_BUFFER_SIZE + sizeof(NBDStructuredReadData));
>>>
>>> -    iov[0].iov_len = sizeof(*chunk);
>>> -    stl_be_p(&chunk->magic, NBD_STRUCTURED_REPLY_MAGIC);
>>> -    stw_be_p(&chunk->flags, flags);
>>> -    stw_be_p(&chunk->type, type);
>>> -    stq_be_p(&chunk->cookie, request->cookie);
>>> -    stl_be_p(&chunk->length, length);
>>> +    if (client->mode >= NBD_MODE_EXTENDED) {
>>> +        NBDExtendedReplyChunk *chunk = iov->iov_base;
>>> +
>>> +        iov->iov_len = sizeof(*chunk);
>>
>> I'd prefer to keep iov[0].iov_len notation, to stress that iov is an array
>>
>> anyway:
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> I can make that change, and keep your R-b.

OK

> 
>>
>>> +        stl_be_p(&chunk->magic, NBD_EXTENDED_REPLY_MAGIC);
>>> +        stw_be_p(&chunk->flags, flags);
>>> +        stw_be_p(&chunk->type, type);
>>> +        stq_be_p(&chunk->cookie, request->cookie);
>>
>> Hm. Not about this patch:
>>
>> we now moved to simple cookies. And it seems that actually, 64bit is too much for number of request.
> 
> You're right that it's more than qemu cared about.  But there may be
> other implementations that really do store a 64-bit pointer as their
> opaque cookie, for ease of reverse-lookup on which command the
> server's reply corresponds to, so I don't see it changing any time
> soon in the NBD protocol.
> 

Agree

-- 
Best regards,
Vladimir


