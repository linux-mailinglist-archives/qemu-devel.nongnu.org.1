Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDEA71895D
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 20:27:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4QX2-0000cb-1S; Wed, 31 May 2023 14:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4QWx-0000VQ-8Z; Wed, 31 May 2023 14:26:43 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4QWu-0008GI-Al; Wed, 31 May 2023 14:26:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5515:0:640:d92d:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id AEE7062D8D;
 Wed, 31 May 2023 21:26:27 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a512::1:34] (unknown
 [2a02:6b8:b081:a512::1:34])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id QQSfRP0Opa60-0tHkLddH; Wed, 31 May 2023 21:26:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1685557586; bh=qqWWNwPJNJH7RURl03UBYNAt1niHoBFMShJkypDJ/JM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=YbnH3PKNwPTSqmbfgYHwMXcQxElAnfSsBBvRwzGxIdA8rh/gIwydiR4hXbedDRUvW
 0JNlUnLnqu9JU88/VmliNDC8gX1egsXwF50/TodroFG3MsRMUafuimhjMfR1pr95M/
 N5mvXJXAbUszt/H/fL6iinp8m479DEHCFKue0Eg4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <483f8e63-2178-901b-cb2b-6afe28258c43@yandex-team.ru>
Date: Wed, 31 May 2023 21:26:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 11/14] nbd/client: Accept 64-bit block status chunks
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, libguestfs@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-12-eblake@redhat.com>
 <f2f89a4e-816e-165e-2d6a-7076f1ced823@yandex-team.ru>
 <vwat2jjjdojzbo6ip4gy33bivhfkq5k3mjsj6bj54k5axegy6y@gcanen54pjwg>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <vwat2jjjdojzbo6ip4gy33bivhfkq5k3mjsj6bj54k5axegy6y@gcanen54pjwg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 31.05.23 20:40, Eric Blake wrote:
> On Wed, May 31, 2023 at 08:00:43PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 15.05.23 22:53, Eric Blake wrote:
>>> Because we use NBD_CMD_FLAG_REQ_ONE with NBD_CMD_BLOCK_STATUS, a
>>> client in narrow mode should not be able to provoke a server into
>>> sending a block status result larger than the client's 32-bit request.
>>> But in extended mode, a 64-bit status request must be able to handle a
>>> 64-bit status result, once a future patch enables the client
>>> requesting extended mode.  We can also tolerate a non-compliant server
>>> sending the new chunk even when it should not.
>>>
>>> @@ -672,7 +681,8 @@ static int nbd_parse_blockstatus_payload(BDRVNBDState *s,
>>>         * connection; just ignore trailing extents, and clamp things to
>>>         * the length of our request.
>>>         */
>>> -    if (chunk->length > sizeof(context_id) + sizeof(*extent)) {
>>> +    if (count != wide ||
>>
>> hard to read for me. Could it be simply "count > 1 ||" ?
> 
> For existing commands (compact), count is initialized to 0 as it is
> not transferred over the wire.  For extended commands, count is
> transferred over the wire, but we expect it to be 1 (and not 0).
> Comparing count != wide is more precise than checking count > 0 (which
> should never happen for compact, but would be a bug for extended).

The only case you add to the check is when count = 0 for extended. But in this case "more than one extent" message is counterintuitive.

> 
>>
>>> +        chunk->length > sizeof(context_id) + wide * sizeof(count) + len) {
>>>            trace_nbd_parse_blockstatus_compliance("more than one extent");
>>>        }
>>>        if (extent->length > orig_length) {
>>> @@ -1117,7 +1127,7 @@ static int coroutine_fn nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t h
>>>
>>>    static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
>>>                                                             uint64_t handle, uint64_t length,
>>> -                                                         NBDExtent *extent,
>>> +                                                         NBDExtentExt *extent,
>>>                                                             int *request_ret, Error **errp)
>>>    {
>>>        NBDReplyChunkIter iter;
>>> @@ -1125,6 +1135,7 @@ static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
>>>        void *payload = NULL;
>>>        Error *local_err = NULL;
>>>        bool received = false;
>>> +    bool wide = false;
>>>
>>>        assert(!extent->length);
>>>        NBD_FOREACH_REPLY_CHUNK(s, iter, handle, false, NULL, &reply, &payload) {
>>> @@ -1134,7 +1145,13 @@ static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
>>>            assert(nbd_reply_is_structured(&reply));
>>>
>>>            switch (chunk->type) {
>>> +        case NBD_REPLY_TYPE_BLOCK_STATUS_EXT:
>>> +            wide = true;
>>> +            /* fallthrough */
>>>            case NBD_REPLY_TYPE_BLOCK_STATUS:
>>> +            if (s->info.extended_headers != wide) {
>>> +                trace_nbd_extended_headers_compliance("block_status");
>>
>> You set wide to true once, on first "NBD_REPLY_TYPE_BLOCK_STATUS_EXT", and then parse following "NBD_REPLY_TYPE_BLOCK_STATUS" if the come with wide=true.
>>
>> Should it be:
>>
>> --- a/block/nbd.c
>> +++ b/block/nbd.c
>> @@ -1135,7 +1135,7 @@ static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
>>       void *payload = NULL;
>>       Error *local_err = NULL;
>>       bool received = false;
>> -    bool wide = false;
>> +    bool wide;
>>       assert(!extent->length);
>>       NBD_FOREACH_REPLY_CHUNK(s, iter, handle, false, NULL, &reply, &payload) {
>> @@ -1146,9 +1146,8 @@ static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
>>           switch (chunk->type) {
>>           case NBD_REPLY_TYPE_BLOCK_STATUS_EXT:
>> -            wide = true;
>> -            /* fallthrough */
>>           case NBD_REPLY_TYPE_BLOCK_STATUS:
>> +            wide = chunk->type == NBD_REPLY_TYPE_BLOCK_STATUS_EXT;
>>               if (s->info.extended_headers != wide) {
> 
> Good observation, since we reach this multiple times in a loop.  I'm
> squashing that in.
> 

-- 
Best regards,
Vladimir


