Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FE171784B
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 09:32:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4GIo-0000nr-Pb; Wed, 31 May 2023 03:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4GIU-0000kv-PI; Wed, 31 May 2023 03:31:07 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4GIS-0006TP-Qz; Wed, 31 May 2023 03:31:06 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0d:3786:0:640:7c97:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 6968361C84;
 Wed, 31 May 2023 10:30:54 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a512::1:34] (unknown
 [2a02:6b8:b081:a512::1:34])
 by mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id rUHkiV5MkSw0-PGBRxraV; Wed, 31 May 2023 10:30:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1685518253; bh=NyTc55f9PORSYW6ocAcngia7QARqkd5R8eLA3AXzPq8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=p4WJLfvt+rE3Etsf/ir/p8uUv4IpQRF/qQOKtwVNcGYbJADYZBD0gRlxOaAWwFxRh
 X9jrbPPfk5eHmbLIG7/CP0h0aL8OjYRgntB/XXtwjMW3DH4oNdUoGpRM+Qb9tbEXZF
 IWOVPibwntIGZ2AgoDQmdJFSpWV2DwTj7YqQsFNo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e3f6de00-275d-8286-faae-8a6a35098f86@yandex-team.ru>
Date: Wed, 31 May 2023 10:30:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Libguestfs] [PATCH v3 05/14] nbd: Add types for extended headers
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 libguestfs@redhat.com
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-6-eblake@redhat.com>
 <b81e6f07-7c1c-f1e2-10bc-5c0ea436b5cf@yandex-team.ru>
 <xbf2ds5njx76p2sfv47dvq6p376gcoc437ezq667awgbm4nji4@x3fxx7ub4a7m>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <xbf2ds5njx76p2sfv47dvq6p376gcoc437ezq667awgbm4nji4@x3fxx7ub4a7m>
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

On 30.05.23 21:22, Eric Blake wrote:
> On Tue, May 30, 2023 at 04:23:46PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 15.05.23 22:53, Eric Blake wrote:
>>> Add the constants and structs necessary for later patches to start
>>> implementing the NBD_OPT_EXTENDED_HEADERS extension in both the client
>>> and server, matching recent commit e6f3b94a934] in the upstream nbd
>>> project.  This patch does not change any existing behavior, but merely
>>> sets the stage.
>>>
>>> This patch does not change the status quo that neither the client nor
>>> server use a packed-struct representation for the request header.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>
>>> ---
>>>    docs/interop/nbd.txt |  1 +
>>>    include/block/nbd.h  | 74 ++++++++++++++++++++++++++++++++------------
>>>    nbd/common.c         | 10 +++++-
>>>    3 files changed, 65 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
>>> index f5ca25174a6..abaf4c28a96 100644
>>> --- a/docs/interop/nbd.txt
>>> +++ b/docs/interop/nbd.txt
>>> @@ -69,3 +69,4 @@ NBD_CMD_BLOCK_STATUS for "qemu:dirty-bitmap:", NBD_CMD_CACHE
>>>    NBD_CMD_FLAG_FAST_ZERO
>>>    * 5.2: NBD_CMD_BLOCK_STATUS for "qemu:allocation-depth"
>>>    * 7.1: NBD_FLAG_CAN_MULTI_CONN for shareable writable exports
>>> +* 8.1: NBD_OPT_EXTENDED_HEADERS
>>> diff --git a/include/block/nbd.h b/include/block/nbd.h
>>> index 50626ab2744..d753fb8006f 100644
>>> --- a/include/block/nbd.h
>>> +++ b/include/block/nbd.h
>>> @@ -87,13 +87,24 @@ typedef struct NBDStructuredReplyChunk {
>>>        uint32_t length; /* length of payload */
>>>    } QEMU_PACKED NBDStructuredReplyChunk;
>>>
>>
>> [..]
>>
>>> -/* Extent chunk for NBD_REPLY_TYPE_BLOCK_STATUS */
>>> +/* Extent array for NBD_REPLY_TYPE_BLOCK_STATUS */
>>
>> Why? NBDExtent is one extent, not extent array.
> 
> It's not the entire chunk either, because that also includes the
> header and the metacontext id that are not part of the extent array.
> Maybe 'Extent array element', which matches our wire layout of:

Yes, sounds good

> 
> <-  chunk                  ->
> <- hdr -><- payload        ->
>   ...     id  <- array      ->
>               ext[0] ext[1]...
> 
>>
>>>    typedef struct NBDExtent {
>>>        uint32_t length;
>>>        uint32_t flags; /* NBD_STATE_* */
>>>    } QEMU_PACKED NBDExtent;
>>>
> 

-- 
Best regards,
Vladimir


