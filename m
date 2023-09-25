Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 302B37AE084
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 22:58:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qksdv-0002Dw-3I; Mon, 25 Sep 2023 16:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qksds-0002Dj-T4
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 16:57:20 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qksdq-0001CB-Rk
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 16:57:20 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id B279DC0002;
 Mon, 25 Sep 2023 20:57:13 +0000 (UTC)
Message-ID: <db6df992-75a2-3e30-1ab3-affcc98b7956@ovn.org>
Date: Mon, 25 Sep 2023 22:58:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: i.maximets@ovn.org, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20230825170448.1953409-1-i.maximets@ovn.org>
 <CAJSP0QW1Ck2+XG3c9cJM5+K05ypckXjEnxrJkGwx+PVt6m_3Lg@mail.gmail.com>
 <213042b9-5ccd-bbde-2be0-ff1d32b9c52e@ovn.org>
 <CAJSP0QVf_=LgSTMDL8uyjWtHmJyPQZ-Mt6aPGvHQbRH_v9ZREw@mail.gmail.com>
 <3251b5ee-a53d-68ed-963d-5cfe893d8079@ovn.org>
 <CAJSP0QVNskqOqSW19f-SapHF8LcXeB8uweL+XHkp9zKvCZS6mg@mail.gmail.com>
From: Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH] virtio: use shadow_avail_idx while checking number of
 heads
In-Reply-To: <CAJSP0QVNskqOqSW19f-SapHF8LcXeB8uweL+XHkp9zKvCZS6mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org
Received-SPF: pass client-ip=217.70.183.198; envelope-from=i.maximets@ovn.org;
 helo=relay6-d.mail.gandi.net
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/25/23 17:38, Stefan Hajnoczi wrote:
> On Mon, 25 Sept 2023 at 11:36, Ilya Maximets <i.maximets@ovn.org> wrote:
>>
>> On 9/25/23 17:12, Stefan Hajnoczi wrote:
>>> On Mon, 25 Sept 2023 at 11:02, Ilya Maximets <i.maximets@ovn.org> wrote:
>>>>
>>>> On 9/25/23 16:23, Stefan Hajnoczi wrote:
>>>>> On Fri, 25 Aug 2023 at 13:04, Ilya Maximets <i.maximets@ovn.org> wrote:
>>>>>>
>>>>>> We do not need the most up to date number of heads, we only want to
>>>>>> know if there is at least one.
>>>>>>
>>>>>> Use shadow variable as long as it is not equal to the last available
>>>>>> index checked.  This avoids expensive qatomic dereference of the
>>>>>> RCU-protected memory region cache as well as the memory access itself
>>>>>> and the subsequent memory barrier.
>>>>>>
>>>>>> The change improves performance of the af-xdp network backend by 2-3%.
>>>>>>
>>>>>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
>>>>>> ---
>>>>>>  hw/virtio/virtio.c | 10 +++++++++-
>>>>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>>>>> index 309038fd46..04bf7cc977 100644
>>>>>> --- a/hw/virtio/virtio.c
>>>>>> +++ b/hw/virtio/virtio.c
>>>>>> @@ -999,7 +999,15 @@ void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
>>>>>>  /* Called within rcu_read_lock().  */
>>>>>>  static int virtqueue_num_heads(VirtQueue *vq, unsigned int idx)
>>>>>>  {
>>>>>> -    uint16_t num_heads = vring_avail_idx(vq) - idx;
>>>>>> +    uint16_t num_heads;
>>>>>> +
>>>>>> +    if (vq->shadow_avail_idx != idx) {
>>>>>> +        num_heads = vq->shadow_avail_idx - idx;
>>>>>> +
>>>>>> +        return num_heads;
>>>>>
>>>>> This still needs to check num_heads > vq->vring.num and return -EINVAL
>>>>> as is done below.
>>>>
>>>> Hmm, yeas, you're right.  If the value was incorrect initially, the shadow
>>>> will be incorrect.  However, I think we should just not return here in this
>>>> case and let vring_avail_idx() to grab an actual new value below.  Otherwise
>>>> we may never break out of this error.
>>>>
>>>> Does that make sense?
>>>
>>> No, because virtio_error() marks the device as broken. The device
>>> requires a reset in order to function again. Fetching
>>> vring_avail_idx() again won't help.
>>
>> OK, I see.  In this case we're talking about situation where
>> vring_avail_idx() was called in some other place and stored a bad value
>> in the shadow variable, then virtqueue_num_heads() got called.  Right?

Hmm, I suppose we also need a read barrier after all even if we use
a shadow index.  Assuming the index is correct, but the shadow variable
was updated by a call outside of this function, then we may miss a
barrier and read the descriptor out of order, in theory.  Read barrier
is going to be a compiler barrier on x86, so the performance gain from
this patch should still be mostly there.  I'll test that.

>>
>> AFAIU, we can still just fall through here and let vring_avail_idx()
>> to read the index again and fail the existing check.  That would happen
>> today without this patch applied.
> 
> Yes, that is fine.
> 
>>
>> I'm jut trying to avoid duplication of the virtio_error call, i.e.:
>>
>>     if (vq->shadow_avail_idx != idx) {
>>         num_heads = vq->shadow_avail_idx - idx;
>>
>>         /* Check it isn't doing very strange things with descriptor numbers. */
>>         if (num_heads > vq->vring.num) {
>>             virtio_error(vq->vdev, "Guest moved used index from %u to %u",
>>                          idx, vq->shadow_avail_idx);
>>             return -EINVAL;
>>         }
>>         return num_heads;
>>     }
>>
>> vs
>>
>>     if (vq->shadow_avail_idx != idx) {
>>         num_heads = vq->shadow_avail_idx - idx;
>>
>>         /* Only use the shadow value if it was good initially. */
>>         if (num_heads <= vq->vring.num) {
>>             return num_heads;
>>         }
>>     }
>>
>>
>> What do you think?
> 
> Sounds good.
> 
>>
>> Best regards, Ilya Maximets.


