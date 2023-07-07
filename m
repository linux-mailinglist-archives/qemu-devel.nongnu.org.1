Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5F474AF96
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:22:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjWU-0000Ca-8V; Fri, 07 Jul 2023 07:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qHjWS-0000CS-3o
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 07:21:12 -0400
Received: from relay2-d.mail.gandi.net ([2001:4b98:dc4:8::222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qHjWO-00033F-HV
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 07:21:11 -0400
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6DB2140009;
 Fri,  7 Jul 2023 11:21:03 +0000 (UTC)
Message-ID: <005e9be8-74f6-5d68-f839-4f3b369c1672@ovn.org>
Date: Fri, 7 Jul 2023 13:21:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: i.maximets@ovn.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
References: <20230622215824.2173343-1-i.maximets@ovn.org>
 <CACGkMEsE6_91mOhCP5ezT96zz-Tb-bLXQr9ktrLg6zG0TZC3Lg@mail.gmail.com>
 <CAJSP0QXPiNK2rH6_8bB7sjMpdQjT--oX0u4FkdaTj7Ew3qs8CA@mail.gmail.com>
 <CACGkMEuN_PeXZhqaN4EJP8rKRVK=wftpkH3--y267j9+7smCOw@mail.gmail.com>
 <CAJSP0QVg-mmtnMXZpxRKutbdgpdNeawJT45iQSp4cf=MRedZAQ@mail.gmail.com>
 <CACGkMEtdk-Qi+5M+pEa9v=S_ehRs=m7Ux4=Sf6aqk0EqNzyQ5g@mail.gmail.com>
 <CAJSP0QW22f18V0pXTO-w4BXONJ3wLCbczMjKSKCRnxiF+7W=eg@mail.gmail.com>
 <CACGkMEvCV6JcQ3LOQvCx=9KXKqE_SAQwzxFXe1c+PdSMH_KbDg@mail.gmail.com>
 <CAJSP0QUtCnE49YWA6PmVSExMaFf2VZi3St1Wysk9ruDS37ALHg@mail.gmail.com>
 <CACGkMEu1V4HBdP3JFYV-+Uec1s6f0U3fj5f9tV0FApQ+U8rbrw@mail.gmail.com>
 <CAJSP0QU-p_cKCevxTabKhfq9T2=UShLqcced-OCmfCx3dE+6rQ@mail.gmail.com>
 <CACGkMEv2u-pcFY_+Y-r6ODj6hjEDUhVG5VV-cX0Fko7VNPZ=0g@mail.gmail.com>
 <CAJSP0QXbq2s-VoWyPz7wWXCnhrt3nOMeoxdhUL8cerxm1sMfeg@mail.gmail.com>
 <CACGkMEsk65V4OiDB==fKSZ8us=FGz4u3Cj5un+2YYXep+OrQXw@mail.gmail.com>
From: Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH] net: add initial support for AF_XDP network backend
In-Reply-To: <CACGkMEsk65V4OiDB==fKSZ8us=FGz4u3Cj5un+2YYXep+OrQXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2001:4b98:dc4:8::222;
 envelope-from=i.maximets@ovn.org; helo=relay2-d.mail.gandi.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.092,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_NEUTRAL=0.779,
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

On 7/7/23 03:43, Jason Wang wrote:
> On Fri, Jul 7, 2023 at 3:08 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>
>> On Wed, 5 Jul 2023 at 02:02, Jason Wang <jasowang@redhat.com> wrote:
>>>
>>> On Mon, Jul 3, 2023 at 5:03 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>>>
>>>> On Fri, 30 Jun 2023 at 09:41, Jason Wang <jasowang@redhat.com> wrote:
>>>>>
>>>>> On Thu, Jun 29, 2023 at 8:36 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>>>>>
>>>>>> On Thu, 29 Jun 2023 at 07:26, Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>
>>>>>>> On Wed, Jun 28, 2023 at 4:25 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>>>>>>>
>>>>>>>> On Wed, 28 Jun 2023 at 10:19, Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> On Wed, Jun 28, 2023 at 4:15 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On Wed, 28 Jun 2023 at 09:59, Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Wed, Jun 28, 2023 at 3:46 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On Wed, 28 Jun 2023 at 05:28, Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Wed, Jun 28, 2023 at 6:45 AM Ilya Maximets <i.maximets@ovn.org> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 6/27/23 04:54, Jason Wang wrote:
>>>>>>>>>>>>>>> On Mon, Jun 26, 2023 at 9:17 PM Ilya Maximets <i.maximets@ovn.org> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On 6/26/23 08:32, Jason Wang wrote:
>>>>>>>>>>>>>>>>> On Sun, Jun 25, 2023 at 3:06 PM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> On Fri, Jun 23, 2023 at 5:58 AM Ilya Maximets <i.maximets@ovn.org> wrote:
>>>>>>>>>>>>>>>> It is noticeably more performant than a tap with vhost=on in terms of PPS.
>>>>>>>>>>>>>>>> So, that might be one case.  Taking into account that just rcu lock and
>>>>>>>>>>>>>>>> unlock in virtio-net code takes more time than a packet copy, some batching
>>>>>>>>>>>>>>>> on QEMU side should improve performance significantly.  And it shouldn't be
>>>>>>>>>>>>>>>> too hard to implement.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Performance over virtual interfaces may potentially be improved by creating
>>>>>>>>>>>>>>>> a kernel thread for async Tx.  Similarly to what io_uring allows.  Currently
>>>>>>>>>>>>>>>> Tx on non-zero-copy interfaces is synchronous, and that doesn't allow to
>>>>>>>>>>>>>>>> scale well.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Interestingly, actually, there are a lot of "duplication" between
>>>>>>>>>>>>>>> io_uring and AF_XDP:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> 1) both have similar memory model (user register)
>>>>>>>>>>>>>>> 2) both use ring for communication
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I wonder if we can let io_uring talks directly to AF_XDP.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Well, if we submit poll() in QEMU main loop via io_uring, then we can
>>>>>>>>>>>>>> avoid cost of the synchronous Tx for non-zero-copy modes, i.e. for
>>>>>>>>>>>>>> virtual interfaces.  io_uring thread in the kernel will be able to
>>>>>>>>>>>>>> perform transmission for us.
>>>>>>>>>>>>>
>>>>>>>>>>>>> It would be nice if we can use iothread/vhost other than the main loop
>>>>>>>>>>>>> even if io_uring can use kthreads. We can avoid the memory translation
>>>>>>>>>>>>> cost.
>>>>>>>>>>>>
>>>>>>>>>>>> The QEMU event loop (AioContext) has io_uring code
>>>>>>>>>>>> (utils/fdmon-io_uring.c) but it's disabled at the moment. I'm working
>>>>>>>>>>>> on patches to re-enable it and will probably send them in July. The
>>>>>>>>>>>> patches also add an API to submit arbitrary io_uring operations so
>>>>>>>>>>>> that you can do stuff besides file descriptor monitoring. Both the
>>>>>>>>>>>> main loop and IOThreads will be able to use io_uring on Linux hosts.
>>>>>>>>>>>
>>>>>>>>>>> Just to make sure I understand. If we still need a copy from guest to
>>>>>>>>>>> io_uring buffer, we still need to go via memory API for GPA which
>>>>>>>>>>> seems expensive.
>>>>>>>>>>>
>>>>>>>>>>> Vhost seems to be a shortcut for this.
>>>>>>>>>>
>>>>>>>>>> I'm not sure how exactly you're thinking of using io_uring.
>>>>>>>>>>
>>>>>>>>>> Simply using io_uring for the event loop (file descriptor monitoring)
>>>>>>>>>> doesn't involve an extra buffer, but the packet payload still needs to
>>>>>>>>>> reside in AF_XDP umem, so there is a copy between guest memory and
>>>>>>>>>> umem.
>>>>>>>>>
>>>>>>>>> So there would be a translation from GPA to HVA (unless io_uring
>>>>>>>>> support 2 stages) which needs to go via qemu memory core. And this
>>>>>>>>> part seems to be very expensive according to my test in the past.
>>>>>>>>
>>>>>>>> Yes, but in the current approach where AF_XDP is implemented as a QEMU
>>>>>>>> netdev, there is already QEMU device emulation (e.g. virtio-net)
>>>>>>>> happening. So the GPA to HVA translation will happen anyway in device
>>>>>>>> emulation.
>>>>>>>
>>>>>>> Just to make sure we're on the same page.
>>>>>>>
>>>>>>> I meant, AF_XDP can do more than e.g 10Mpps. So if we still use the
>>>>>>> QEMU netdev, it would be very hard to achieve that if we stick to
>>>>>>> using the Qemu memory core translations which need to take care about
>>>>>>> too much extra stuff. That's why I suggest using vhost in io threads
>>>>>>> which only cares about ram so the translation could be very fast.
>>>>>>
>>>>>> What does using "vhost in io threads" mean?
>>>>>
>>>>> It means a vhost userspace dataplane that is implemented via io threads.
>>>>
>>>> AFAIK this does not exist today. QEMU's built-in devices that use
>>>> IOThreads don't use vhost code. QEMU vhost code is for vhost kernel,
>>>> vhost-user, or vDPA but not built-in devices that use IOThreads. The
>>>> built-in devices implement VirtioDeviceClass callbacks directly and
>>>> use AioContext APIs to run in IOThreads.
>>>
>>> Yes.
>>>
>>>>
>>>> Do you have an idea for using vhost code for built-in devices? Maybe
>>>> it's fastest if you explain your idea and its advantages instead of me
>>>> guessing.
>>>
>>> It's something like I'd proposed in [1]:
>>>
>>> 1) a vhost that is implemented via IOThreads
>>> 2) memory translation is done via vhost memory table/IOTLB
>>>
>>> The advantages are:
>>>
>>> 1) No 3rd application like DPDK application
>>> 2) Attack surface were reduced
>>> 3) Better understanding/interactions with device model for things like
>>> RSS and IOMMU
>>>
>>> There could be some dis-advantages but it's not obvious to me :)
>>
>> Why is QEMU's native device emulation API not the natural choice for
>> writing built-in devices? I don't understand why the vhost interface
>> is desirable for built-in devices.
> 
> Unless the memory helpers (like address translations) were optimized
> fully to satisfy this 10M+ PPS.
> 
> Not sure if this is too hard, but last time I benchmark, perf told me
> most of the time spent in the translation.
> 
> Using a vhost is a workaround since its memory model is much more
> simpler so it can skip lots of memory sections like I/O and ROM etc.

So, we can have a thread running as part of QEMU process that implements
vhost functionality for a virtio-net device.  And this thread has an
optimized way to access memory.  What prevents current virtio-net emulation
code accessing memory in the same optimized way?  i.e. we likely don't
actually need to implement the whole vhost-virtio communication protocol
in order to have faster memory access from the device emulation code.
I mean, if vhost can access device memory faster, why device itself can't?

With that we could probably split the "datapath" part of the virtio-net
emulation into a separate thread driven by iothread loop.

Then add batch API for communication with a network backend (af-xdp) to
avoid per-packet calls.

These are 3 more or less independent tasks that should allow the similar
performance to a full fledged vhost control and dataplane implementation
inside QEMU.

Or am I missing something? (Probably)

> 
> Thanks
> 
>>
>>>
>>> It's something like linking SPDK/DPDK to Qemu.
>>
>> Sergio Lopez tried loading vhost-user devices as shared libraries that
>> run in the QEMU process. It worked as an experiment but wasn't pursued
>> further.
>>
>> I think that might make sense in specific cases where there is an
>> existing vhost-user codebase that needs to run as part of QEMU.
>>
>> In this case the AF_XDP code is new, so it's not a case of moving
>> existing code into QEMU.
>>
>>>
>>>>
>>>>>>>> Regarding pinning - I wonder if that's something that can be refined
>>>>>>>> in the kernel by adding an AF_XDP flag that enables on-demand pinning
>>>>>>>> of umem. That way only rx and tx buffers that are currently in use
>>>>>>>> will be pinned. The disadvantage is the runtime overhead to pin/unpin
>>>>>>>> pages. I'm not sure whether it's possible to implement this, I haven't
>>>>>>>> checked the kernel code.
>>>>>>>
>>>>>>> It requires the device to do page faults which is not commonly
>>>>>>> supported nowadays.
>>>>>>
>>>>>> I don't understand this comment. AF_XDP processes each rx/tx
>>>>>> descriptor. At that point it can getuserpages() or similar in order to
>>>>>> pin the page. When the memory is no longer needed, it can put those
>>>>>> pages. No fault mechanism is needed. What am I missing?
>>>>>
>>>>> Ok, I think I kind of get you, you mean doing pinning while processing
>>>>> rx/tx buffers? It's not easy since GUP itself is not very fast, it may
>>>>> hit PPS for sure.
>>>>
>>>> Yes. It's not as fast as permanently pinning rx/tx buffers, but it
>>>> supports unpinned guest RAM.
>>>
>>> Right, it's a balance between pin and PPS. PPS seems to be more
>>> important in this case.
>>>
>>>>
>>>> There are variations on this approach, like keeping a certain amount
>>>> of pages pinned after they have been used so the cost of
>>>> pinning/unpinning can be avoided when the same pages are reused in the
>>>> future, but I don't know how effective that is in practice.
>>>>
>>>> Is there a more efficient approach without relying on hardware page
>>>> fault support?
>>>
>>> I guess so, I see some slides that say device page fault is very slow.
>>>
>>>>
>>>> My understanding is that hardware page fault support is not yet
>>>> deployed. We'd be left with pinning guest RAM permanently or using a
>>>> runtime pinning/unpinning approach like I've described.
>>>
>>> Probably.
>>>
>>> Thanks
>>>
>>>>
>>>> Stefan
>>>>
>>>
>>
> 


