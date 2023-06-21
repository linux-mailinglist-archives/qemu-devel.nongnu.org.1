Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FB1738E6C
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 20:18:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC2On-0000lt-V9; Wed, 21 Jun 2023 14:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qC2Ol-0000la-Ad
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:17:43 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qC2Oi-0002ZF-NH
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:17:43 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1qC2OX-0004k3-Um; Wed, 21 Jun 2023 20:17:29 +0200
Message-ID: <0a7cc359-f308-21a1-6c6d-7bcb51051f7e@maciej.szmigiero.name>
Date: Wed, 21 Jun 2023 20:17:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US, pl-PL
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <cover.1686577753.git.maciej.szmigiero@oracle.com>
 <896327748bde906826e24ce7cc45301e325e14a7.1686577753.git.maciej.szmigiero@oracle.com>
 <f54e55d0-b8dd-a431-7634-02fdec0611bb@redhat.com>
 <1b107fba-38e0-cced-e19f-b62684072bfd@maciej.szmigiero.name>
 <008fced2-1bcf-7a89-d642-bb724eb63ddf@redhat.com>
 <987af80f-9636-42da-26de-e2d07dc25ce3@maciej.szmigiero.name>
 <acf9402f-3baf-6c07-6662-7e0638f78263@redhat.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH][RESEND v5 3/3] Add a Hyper-V Dynamic Memory Protocol
 driver (hv-balloon)
In-Reply-To: <acf9402f-3baf-6c07-6662-7e0638f78263@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.093,
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

On 21.06.2023 12:32, David Hildenbrand wrote:
> On 20.06.23 22:13, Maciej S. Szmigiero wrote:
>> On 19.06.2023 17:58, David Hildenbrand wrote:
>>> [...]
>>>
>>> Sorry for the late reply!
>>>
>>> Still trying to make up my mind what the right way forward with this is.
>>>
>>>>>
>>>>> This usage is still problematic I suspect (well, and a layer violation regarding the machine). The machine hotplug handler is supposed to call the pre_plug/plug/unplug hooks as response to pre_plug/plug/unplug notifications from the core. See how we handle virtio-mem/virtio-pmem/nvdimms as an example.
>>>>>
>>>>> We assume that when memory_device_pre_plug() gets called, that the device is not realized yet, but once it gets plugged, that it already is realized, and that the device will actually vanish (get unrealized) when unplugging the device.
>>>>> Otherwise memory device logic like in get_plugged_memory_size() stops working.
>>>>
>>>> get_plugged_memory_size() just calls get_plugged_size() method on every
>>>> realized TYPE_MEMORY_DEVICE.
>>>>
>>>> While this now always returns the whole backing memory size (once the
>>>> backend gets plugged) I don't see a reason why this method could not be
>>>> overridden in hv-balloon to return just the currently hot-added size.
>>>>
>>>> By the way, this function seems to be used just for reporting stats via QMP.
>>>
>>> memory_device_build_list() is another example, used for memory_device_get_free_addr().
>>
>> I don't see it calling get_plugged_size() method, I can see it only using
>> (indirectly) get_addr() method.
> 
> It similarly contains the TYPE_MEMORY_DEVICE -> dev->realized logic.

All right, I thought at first you meant just that the get_plugged_memory_size()
function reports misleading values.

> 
>>
>>> You'd be blocking memory address ranges with an unplugged-but-realized memory device.>
>>> Memory device code expects that realized memory devices are plugged and vice versa.
>>
>> Which QEMU code you mean specifically? Maybe it just needs a trivial
>> change.
>>
>> Before the driver hot-adds the first chunk of memory it does not use any
>> part of the address space.
>>
>> After that, it has to reserve address space for the whole backing memory
>> device, so no other devices will claim parts of it and because a
>> TYPE_MEMORY_DEVICE (currently) can have just a single range.
>>
>> This address space is released when the VM is restarted.
>>
> 
> As I said, memory device code currently expects that you don't have realized
> TYPE_MEMORY_DEVICE that are not plugged, and currently that holds true for all
> memory devices.
> 
> We could modify memory device code to change that, but IMHO it's the wrong way
> around: the machine (hotplug) is responsible for (un)plugging memory devices
> as they get realized.
> 
> Doing a qdev_get_machine()/current_machine from device code and then
> modifying the state of the machine (here: calling plug/unplug handlers)
> is usually a warning sign that there is a layer violation.
> 
> That's why I'm thinking about a cleaner way to handle that.

Okay, now I think I understand what you think is questionable:
calling memory_device_pre_plug(), memory_device_plug() and friends from
the driver when hot-adding the first memory chunk, even thought no actual
device is getting plugged in at that time.

I'm open to other approaches here (besides the virtual DIMMs one that we
already tried in the past).

> [...]
> 
>>>>> Is it to support the !memdev case or why is this this plugging/unplugging in our_range_plugged_new()/our_range_plugged_free() required?
>>>>
>>>> At least for three (four) reasons:
>>>> 1a) At the hv-balloon plug time the device doesn't yet know the guest
>>>> alignement requirements - or whether the guest supports memory hot add at
>>>> all - that's what the device will learn only once the guest connects
>>>> to the protocol.
>>>
>>> Understood, so you want to at least expose the memory dynamically to the VM (map the MR on demand).
>>>
>>> That could be done using a memory region container like virtio-mem is planning [1] on using fairly easily.
>>>
>>> [1] https://lkml.kernel.org/r/20230616092654.175518-14-david@redhat.com
>>
>> Thanks for the pointer to your series - I've looked at it and it seems
>> to me that while it allows multiple memory subregions, each backed by
>> a separate memslot it still needs a single big main region for
>> the particular TYPE_MEMORY_DEVICE, am I right?
> 
> Yes.
> 
>>
>>>> 1b) For the same reason the memory region has to be unplugged at the VM
>>>> reset time - the new guest might have stricter alignement requirements
>>>
>>> Alignment is certainly interesting, but is it a real problem?
>>>
>>> As default (not other memory devices) you get an address that's aligned to 1 GiB. And, in fact, you can simply always request a 1 GiB alignment for the device, independent of the guest requirement.
>>>
>>> Would the guest requirement be even stricter than that (e.g., 2 GiB)?
>>
>> The protocol allows up to 32 GiB alignement so we cannot simply
>> hardcode the alignement to 1 GiB, especially since this is Windows
>> we're talking about (so this parameter is subject to unpredictable
>> changes).
> 
> Note that anything bigger than 1 GiB is not really guaranteed to work in
> QEMU on x86-64. See the warning in memory_device_get_free_addr():
> 
>      /* start of address space indicates the maximum alignment we expect */
>      if (!QEMU_IS_ALIGNED(range_lob(&as), align)) {
>          warn_report("the alignment (0x%" PRIx64 ") exceeds the expected"
>                      " maximum alignment, memory will get fragmented and not"
>                      " all 'maxmem' might be usable for memory devices.",
>                      align);
>      }
> 
> 
> So assume you do a "-m 4G,maxmem=36G"
> 
> You cannot add a 32 GiB device with an alignment of 32 GiB -- thee is not
> sufficient room in the device region size. To achieve that, you'd have to
> increase maxmem to something like:
> 
> "-m 4G,maxmem=68G"
> 
> to eventually make that work.
> 
> So "it's complicated" already to guarantee anything > 1 GiB, even when doing it
> from within QEMU.
> 
> 
> Thinking about how to handle it with a device memory region container:
> With the 32 GiB max alignment, you could similarly always size the device managed
> region container effectively sizeof(memdev)+32 GiB, and document that. Adding a
> 32 GiB device to the "-m 4G,maxmem=36G" configuration would fail right from the
> start, instead of later at runtime when you fail to find an aligned address range
> in the configuration.
> 
> Within that region container, you can then align the address as you want, without
> getting warnings about alignment from the core or failing hotplug if the alignment
> in the configuration cannot be satisfied.

Won't using a bigger container also require up-sizing the backing memory
device?

In other words, is it possible to attach the backing memory device at
non-zero offset in the container only at runtime, when the required
alignement becomes known?
If such offset attachment is indeed possible, then I don't see a problem
with using such container.

In the current driver form, with the effective requirement of
maxmem=32G+sizeof(memdev), we're just wasting address space, not parts of
the actual backing memory device.

>>
>>> In theory, when using a memory region container (again [1]) into which you dynamically map the RAM region, you can do this alignment internally.
>>>
>>> So it might be an option to use a memory region container and dynamically map into that one as you please (it just has to have a fixed size).
>>
>> Still, demand-allocating just the right memory region (with the right
>> alignement) seems to me like a cleaner solution than allocating a huge
>> worst-case memory region upfront and then trying to carve the right
>> part of it.
> 
> See above, this does not work in the general case as you would need it.
> 
> [...]
> 
>>>> 3) This will hopefully allow sharing the backing memory device between
>>>> virtio-mem and hv-balloon in the future - Linux guests will connect to
>>>> the former interface while Windows guests will connect to the later.
>>>>
>>>
>>> I've been told that the virtio-mem driver for Windows will show up polished in the near future ... we'll see :)
>>
>> virtio-mem driver for Windows is still at version 1 at [1] so I guess
>> it's going to take a while for it to be production-ready - due to, in part,
>> difficulty in acquiring stability guarantees for the required Windows
>> kernel MM APIs.
> 
> I heard that there is progress on both, and that it should be upstream soonish. But I'm not
> involved in the actual development (and Microsoft discussions), so I can only echo what
> people told me.

As you said, we'll see - competition is generally a good thing (if kept
within reason).

>>
>>> Anyhow, I consider that a secondary requirement. (virtio-mem is not compatible with shared memdevs)
>>>
>>>
>>>>>
>>>>> Supporting the !memdev case is interesting: you essentially want to plug a memory device without a device region (or with an empty stub). I guess we should get that figured out somehow.
>>>>>
>>>>
>>>> That's why the previous version of this driver used a parent VMBus
>>>> device (non-TYPE_MEMORY_DEVICE) which then had virtual DIMMs as its
>>>> children carrying memory for hot add.
>>>
>>> So we have the following two options I think
>>>
>>> (1) Make the hv-balloon device a memory device,
>>
>> It's already a TYPE_MEMORY_DEVICE, so no change required here.
>>
>>> plug/unplug it from the machine code when plug/unplug'ing the hv-balloon device.
>>
>> Don't quite follow that - the device is not designed to be hot-pluggable
>> (I'm not sure that Windows would even allow hot-plugging a DM protocol
>> device).
> 
> There is coldplug and hotplug. Coldplug is just specifying a device on the QEMU
> cmdline and letting the (hot)plug handler wire it up correctly.

So we'll only have to support the coldplug case for the hv-balloon driver
itself.

On the other hand, previous versions of the driver used to hot-plug
virtual DIMM devices.

>>
>> It is rather designed to be instantiated at the QEMU command line for the
>> lifetime of the VM.
>>
> 
> Right, and I assume it cannot get unplugged.

That's right.

>>> We'd use a memory region container as device memory region (like [1]) and would have to handle the !memdev case (I can help with that). > Into that, you can map the RAM memory region on demand (and eventually even using multiple slots like [1]).
>>>
>>> (2) Use a single virtual DIMM and (un)plug that on demand. Let the machine code handle (un)plugging of the device.
>>>
>>>
>>> (1) feels cleanest to me, although it will require a bit more work.
>>>
>>
>> I also think approach (1) makes more sense as it avoids memslot metadata
>> overhead for not-yet-hot-added parts of the memory backing device.
>>
>> Not sure what you mean that the !memdev case would be problematic in this
>> case - it is working in the current driver shape so why would adding
>> potential memory subregions (used in the memdev case) change that?
> 
> I'm thinking about the case where you have a hv-balloon device without a memdev.
> 
> Without -m X,maxmem=y we don't currently expect to have memory devices around
> (and especially them getting (un)plugged. But why should we "force" to set the
> "maxmem" option

I guess it's only a small change to QEMU to allow having hv-balloon
device (without a memdev) even in the case where there's no "maxmem"
option given on the QEMU command line.

> 
> I hope I'll find some time soonish to prototype what I have in mind, to see
> if it could be made working.
> 

Okay, so I'll wait for your prototype before commencing further work on
the next version of this driver.

Thanks,
Maciej


