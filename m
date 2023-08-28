Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 657CF78AA77
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 12:23:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaZO9-00075R-5b; Mon, 28 Aug 2023 06:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1qaZO5-00074d-7R; Mon, 28 Aug 2023 06:22:25 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1qaZO2-0000iN-L0; Mon, 28 Aug 2023 06:22:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3738C63912;
 Mon, 28 Aug 2023 10:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555A1C433C9;
 Mon, 28 Aug 2023 10:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693218140;
 bh=7ktxWAkLH8pwnj9yDk0gdbhn65ONmst95owH2lG7e8k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=K37jqMS0zbZnTgR9knVlcOW7CJBxMH+uMZwDp1RqpS+YrlakFbz+M0s4UBxZgbopJ
 fQayBRcQdEd2ztpLx02FuIEZygmjLFyH3yYzBhhyC3n2X10BpAuvGoxUowErPkT0Gy
 7BpoCk2zbepWeUAs1aqoOWoXcj/72gWoAiNn8rxtg9nZrcrmJospbJsBfFOVWFmJVM
 Jt2ZEFD1zhgzf/ReAeuso7/+eR+hUUmkDrrZf8ufblN0U6imWUV4x2Amf+hRuXA2Im
 v6LFblS5O2aEidxGVtW1HCUX3GsWDGXOUjMYyOhmrTYNucWXV3fsaWxnRJ6nDxpYbP
 ER10LazAXC+hA==
Message-ID: <aeeeaf19-ce27-a3a2-7be0-9acbae24bb5e@kernel.org>
Date: Mon, 28 Aug 2023 19:22:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/4] qcow2: add configurations for zoned format
 extension
Content-Language: en-US
To: Sam Li <faithilikerun@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 hare@suse.de, Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20230814085802.61459-1-faithilikerun@gmail.com>
 <20230814085802.61459-3-faithilikerun@gmail.com>
 <20230821133131.GA37847@fedora>
 <CAAAx-8JL1ieece-noWNo3ZJ4fDD-x-Z4u+WOgsO4jnvpoqLqTw@mail.gmail.com>
 <f1144d47-209d-c376-f179-1af2ad2d3f1b@kernel.org>
 <CAAAx-8KHyTNDKL6FvAifZmH6LW46U5ccM+c=Rp0Hf=XpbErczg@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAAAx-8KHyTNDKL6FvAifZmH6LW46U5ccM+c=Rp0Hf=XpbErczg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=dlemoal@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.414, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

On 8/28/23 19:18, Sam Li wrote:
> Damien Le Moal <dlemoal@kernel.org> 于2023年8月28日周一 18:13写道：
>>
>> On 8/28/23 18:22, Sam Li wrote:
>>> Stefan Hajnoczi <stefanha@redhat.com> 于2023年8月21日周一 21:31写道：
>>>>
>>>> On Mon, Aug 14, 2023 at 04:58:00PM +0800, Sam Li wrote:
>>>>> diff --git a/block/qcow2.h b/block/qcow2.h
>>>>> index f789ce3ae0..3694c8d217 100644
>>>>> --- a/block/qcow2.h
>>>>> +++ b/block/qcow2.h
>>>>> @@ -236,6 +236,20 @@ typedef struct Qcow2CryptoHeaderExtension {
>>>>>      uint64_t length;
>>>>>  } QEMU_PACKED Qcow2CryptoHeaderExtension;
>>>>>
>>>>> +typedef struct Qcow2ZonedHeaderExtension {
>>>>> +    /* Zoned device attributes */
>>>>> +    uint8_t zoned_profile;
>>>>> +    uint8_t zoned;
>>>>> +    uint16_t reserved16;
>>>>> +    uint32_t zone_size;
>>>>> +    uint32_t zone_capacity;
>>>>
>>>> Should zone capacity be stored individually for each zone (alongside the
>>>> write pointer and other per zone metadata) instead of as a global value
>>>> for all zones? My understanding is that NVMe ZNS does not have a global
>>>> value and each zone could have a different zone capacity value.
>>>
>>> Though zone capacity is per-zone attribute, it remains same for all
>>> zones in most cases. Referring to the NVMe ZNS spec, zone capacity
>>> changes associate to RESET_ZONE op when the variable zone capacity bit
>>> is '1'. It hasn't specifically tell what it is changed to. Current ZNS
>>> emulation doesn't change zone capacity as well.
>>>
>>> If the Variable Zone Capacity bit is cleared to ‘0’ in the Zone
>>> Operation Characteristics field in the Zoned
>>> Namespace Command Set specific Identify Namespace data structure, then
>>> this field does not change without a change to the format of the zoned
>>> namespace.
>>>
>>> If the Variable Zone Capacity bit is set to ‘1’ in the Zone Operation
>>> Characteristics field in the Zoned
>>> Namespace Command Set specific Identify Namespace data structure, then
>>> the zone capacity may
>>> change upon successful completion of a Zone Management Send command
>>> specifying the Zone Send
>>> Action of Reset Zone.
>>
>> Regardless of the variable zone capacity feature, zone capacity is per zone and
>> may be different between zones. That is why it is reported per zone in zone
>> report. The IO path code should not assume that the zone capacity is the same
>> for all zones.
> 
> How is zone capacity changed, by devices or commands? Can you give
> some example please?

If the device does not support variable zone capacity, the zone capacity is
fixed at device manufacturing time and never changes. It is reported per zone
and you have to make things work with whatever value you see. The user cannot
change device zone capacity.

For you qcow2 zoned image, the equivalent is to fix the zone capacity when the
image is created and not allowing to change it. And for simplicity, the same
zone capacity value can be used for all zones, so having the zone capacity
value in the header is OK.

> 
>>
>> For this particular case though, given that this is QCow2 emulation, limiting
>> ourselves to the same zone capacity for all zones is I think fine. But that
>> should be clearly stated somewhere may be...
> 
> I see. The qcow2 documentaion can add that.
> 
>>
>>>
>>>>
>>>>> +    uint32_t nr_zones;
>>>>
>>>> Is this field necessary since it can be derived from other image
>>>> options: nr_zones = DIV_ROUND_UP(total_length, zone_capacity)?
>>>
>>> It can be dropped. I added this for reducing duplication. Thanks!
>>
>> --
>> Damien Le Moal
>> Western Digital Research
>>

-- 
Damien Le Moal
Western Digital Research


