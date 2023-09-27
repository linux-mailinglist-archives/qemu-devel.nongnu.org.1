Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A777B0932
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 17:47:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlWkc-00039U-BD; Wed, 27 Sep 2023 11:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qlWka-00039K-Aw
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:46:56 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qlWkV-0000ut-25
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:46:56 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id 44F73E000B;
 Wed, 27 Sep 2023 15:46:46 +0000 (UTC)
Message-ID: <142a9657-550b-6c04-5a23-d45011c160e8@ovn.org>
Date: Wed, 27 Sep 2023 17:47:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: i.maximets@ovn.org, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio: remove unnecessary thread fence while reading
 next descriptor
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230825170136.1953236-1-i.maximets@ovn.org>
 <CAJSP0QW2LZQgHFSp=ajokFpAzaLWhDXBL0tP8Lj-vXTaMKJcqQ@mail.gmail.com>
 <fd5f15c1-87b7-bd00-be5f-987a02f35482@ovn.org>
 <28993913-624a-a437-1382-54a95933474c@ovn.org>
 <20230927114117-mutt-send-email-mst@kernel.org>
From: Ilya Maximets <i.maximets@ovn.org>
In-Reply-To: <20230927114117-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org
Received-SPF: pass client-ip=217.70.183.196; envelope-from=i.maximets@ovn.org;
 helo=relay4-d.mail.gandi.net
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/27/23 17:41, Michael S. Tsirkin wrote:
> On Wed, Sep 27, 2023 at 04:06:41PM +0200, Ilya Maximets wrote:
>> On 9/25/23 20:04, Ilya Maximets wrote:
>>> On 9/25/23 16:32, Stefan Hajnoczi wrote:
>>>> On Fri, 25 Aug 2023 at 13:02, Ilya Maximets <i.maximets@ovn.org> wrote:
>>>>>
>>>>> It was supposed to be a compiler barrier and it was a compiler barrier
>>>>> initially called 'wmb' (??) when virtio core support was introduced.
>>>>> Later all the instances of 'wmb' were switched to smp_wmb to fix memory
>>>>> ordering issues on non-x86 platforms.  However, this one doesn't need
>>>>> to be an actual barrier.  It's enough for it to stay a compiler barrier
>>>>> as its only purpose is to ensure that the value is not read twice.
>>>>>
>>>>> There is no counterpart read barrier in the drivers, AFAICT.  And even
>>>>> if we needed an actual barrier, it shouldn't have been a write barrier.
>>>>>
>>>>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
>>>>> ---
>>>>>  hw/virtio/virtio.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>>>> index 309038fd46..6eb8586858 100644
>>>>> --- a/hw/virtio/virtio.c
>>>>> +++ b/hw/virtio/virtio.c
>>>>> @@ -1051,7 +1051,7 @@ static int virtqueue_split_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
>>>>>      /* Check they're not leading us off end of descriptors. */
>>>>>      *next = desc->next;
>>>>
>>>> I don't see a caller that uses *next. Can the argument be eliminated?
>>>
>>> Yes, it can.  The 'next' was converted from a local variable to
>>> an output parameter in commit:
>>>   412e0e81b174 ("virtio: handle virtqueue_read_next_desc() errors")
>>>
>>> And that didn't actually make sense even then, because all the
>>> actual uses of the 'i/next' as an output were removed a few months
>>> prior in commit:
>>>   aa570d6fb6bd ("virtio: combine the read of a descriptor")
>>>
>>> I can post a separate patch for this.
>>>
>>>>
>>>>>      /* Make sure compiler knows to grab that: we don't want it changing! */
>>>>> -    smp_wmb();
>>>>> +    barrier();
>>>>
>>>> What is the purpose of this barrier? desc is not guest memory and
>>>> nothing modifies desc's fields while this function is executing. I
>>>> think the barrier can be removed.
>>>
>>> True.  In fact, that was the first thing I did, but then the comment
>>> derailed me into thinking that it somehow can be updated concurrently,
>>> so I went with a safer option.  :/
>>> It is indeed a local variable and the barrier is not needed today.
>>> It had a little more sense before the previously mentioned commit:
>>>   aa570d6fb6bd ("virtio: combine the read of a descriptor")
>>> because we were reading guest memory before the barrier and used the
>>> result after.
>>>
>>> I'll remove it.
>>
>> Converted this into a cleanup patch set.  Posted here:
>>   https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg06780.html
>>
>> Best regards, Ilya Maximets.
> 
> Ugh, these archives are useless. use lore please. 
> 

OK.  The lore link is the following:
  https://lore.kernel.org/qemu-devel/20230927140016.2317404-1-i.maximets@ovn.org/

Best regards, Ilya Maximets.

