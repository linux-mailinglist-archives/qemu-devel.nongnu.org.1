Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC4172EA68
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 19:59:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q98Hc-0002SD-9R; Tue, 13 Jun 2023 13:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1q98HZ-0002RT-F7
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 13:58:17 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1q98HX-0003rj-3R
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 13:58:17 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1q98HB-0000Lu-6Q; Tue, 13 Jun 2023 19:57:53 +0200
Message-ID: <1b107fba-38e0-cced-e19f-b62684072bfd@maciej.szmigiero.name>
Date: Tue, 13 Jun 2023 19:57:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
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
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH][RESEND v5 3/3] Add a Hyper-V Dynamic Memory Protocol
 driver (hv-balloon)
In-Reply-To: <f54e55d0-b8dd-a431-7634-02fdec0611bb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.098,
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

On 12.06.2023 19:42, David Hildenbrand wrote:
> On 12.06.23 16:00, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> This driver is like virtio-balloon on steroids: it allows both changing the
>> guest memory allocation via ballooning and inserting pieces of extra RAM
>> into it on demand from a provided memory backend.
>>
>> One of advantages of these over ACPI-based PC DIMM hotplug is that such
>> memory can be hotplugged in much smaller granularity because the ACPI DIMM
>> slot limit does not apply.
>>
>> In order to enable hot-adding additional memory a new memory backend needs
>> to be created and provided to the driver via the "memdev" parameter.
>> This can be achieved by, for example, adding
>> "-object memory-backend-ram,id=mem1,size=32G" to the QEMU command line and
>> then instantiating the driver with "memdev=mem1" parameter.
>>
>> In contrast with ACPI DIMM hotplug where one can only request to unplug a
>> whole DIMM stick this driver allows removing memory from guest in single
>> page (4k) units via ballooning.
>>
>> The actual resizing is done via ballooning interface (for example, via
>> the "balloon" HMP command)
>> This includes resizing the guest past its boot size - that is, hot-adding
>> additional memory in granularity limited only by the guest alignment
>> requirements.
>>
>> After a VM reboot the guest is back to its original (boot) size.
>>
>> In the future, the guest boot memory size might be changed on reboot
>> instead, taking into account the effective size that VM had before that
>> reboot (much like Hyper-V does).
>>
>> For performance reasons, the guest-released memory is tracked in a few
>> range trees, as a series of (start, count) ranges.
>> Each time a new page range is inserted into such tree its neighbors are
>> checked as candidates for possible merging with it.
>>
>> Besides performance reasons, the Dynamic Memory protocol itself uses page
>> ranges as the data structure in its messages, so relevant pages need to be
>> merged into such ranges anyway.
>>
>> One has to be careful when tracking the guest-released pages, since the
>> guest can maliciously report returning pages outside its current address
>> space, which later clash with the address range of newly added memory.
>> Similarly, the guest can report freeing the same page twice.
>>
>> The above design results in much better ballooning performance than when
>> using virtio-balloon with the same guest: 230 GB / minute with this driver
>> versus 70 GB / minute with virtio-balloon.
>>
>> During a ballooning operation most of time is spent waiting for the guest
>> to come up with newly freed page ranges, processing the received ranges on
>> the host side (in QEMU and KVM) is nearly instantaneous.
>>
>> The unballoon operation is also pretty much instantaneous:
>> thanks to the merging of the ballooned out page ranges 200 GB of memory can
>> be returned to the guest in about 1 second.
>> With virtio-balloon this operation takes about 2.5 minutes.
>>
>> These tests were done against a Windows Server 2019 guest running on a
>> Xeon E5-2699, after dirtying the whole memory inside guest before each
>> balloon operation.
>>
>> Using a range tree instead of a bitmap to track the removed memory also
>> means that the solution scales well with the guest size: even a 1 TB range
>> takes just a few bytes of such metadata.
>>
>> Since the required GTree operations aren't present in every Glib version
>> a check for them was added to the meson build script, together with new
>> "--enable-hv-balloon" and "--disable-hv-balloon" configure arguments.
>> If these GTree operations are missing in the system's Glib version this
>> driver will be skipped during QEMU build.
>>
>> An optional "status-report=on" device parameter requests memory status
>> events from the guest (typically sent every second), which allow the host
>> to learn both the guest memory available and the guest memory in use
>> counts.
>> They are emitted externally as "HV_BALLOON_STATUS_REPORT" QMP events.
>>
>> The driver is named hv-balloon since the Linux kernel client driver for
>> the Dynamic Memory Protocol is named as such and to follow the naming
>> pattern established by the virtio-balloon driver.
>> The whole protocol runs over Hyper-V VMBus.
>>
>> The driver was tested against Windows Server 2012 R2, Windows Server 2016
>> and Windows Server 2019 guests and obeys the guest alignment requirements
>> reported to the host via DM_CAPABILITIES_REPORT message.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
(...)
>> +/* OurRangePlugged */
>> +static OurRangePlugged *our_range_plugged_new(MemoryDeviceState *md,
>> +                                              HostMemoryBackend *hostmem,
>> +                                              uint64_t align,
>> +                                              Error **errp)
>> +{
>> +    ERRP_GUARD();
>> +    OurRangePlugged *our_range;
>> +    MachineState *ms = MACHINE(qdev_get_machine());
>> +    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
>> +    uint64_t addr, count;
>> +
>> +    if (!align) {
>> +        align = HV_BALLOON_PAGE_SIZE;
>> +    }
>> +
>> +    if (host_memory_backend_is_mapped(hostmem)) {
>> +        error_setg(errp, "memory backend already mapped");
>> +        return NULL;
>> +    }
>> +
>> +    count = memory_device_get_region_size(md, &error_abort) / HV_BALLOON_PAGE_SIZE;
>> +    if (!count) {
>> +        error_setg(errp, "memory backend too small to be usable");
>> +        return NULL;
>> +    }
>> +
>> +    memory_device_pre_plug(md, ms, &align, errp);
>> +    if (*errp) {
>> +        return NULL;
>> +    }
>> +
> 
> This usage is still problematic I suspect (well, and a layer violation regarding the machine). The machine hotplug handler is supposed to call the pre_plug/plug/unplug hooks as response to pre_plug/plug/unplug notifications from the core. See how we handle virtio-mem/virtio-pmem/nvdimms as an example.
> 
> We assume that when memory_device_pre_plug() gets called, that the device is not realized yet, but once it gets plugged, that it already is realized, and that the device will actually vanish (get unrealized) when unplugging the device.
> Otherwise memory device logic like in get_plugged_memory_size() stops working.

get_plugged_memory_size() just calls get_plugged_size() method on every
realized TYPE_MEMORY_DEVICE.

While this now always returns the whole backing memory size (once the
backend gets plugged) I don't see a reason why this method could not be
overridden in hv-balloon to return just the currently hot-added size.

By the way, this function seems to be used just for reporting stats via QMP.

> 
> As an example, see device_set_realized() on the pre_plug+realize+plug interaction.
> 
> IIRC, you're reusing the already-realized hv-balloon device here, correct?

Yes - in this version of the driver.

The previous version used separate virtual DIMM devices instead but you have
recommended against that approach.

> 
> Why can't you call the pre_plug/plug/unplug functions from the machine pre_plug/plug/unplug hooks -- exactly once for the memory device when plugging the hv-balloon device?
>
> Is it to support the !memdev case or why is this this plugging/unplugging in our_range_plugged_new()/our_range_plugged_free() required?

At least for three (four) reasons:
1a) At the hv-balloon plug time the device doesn't yet know the guest
alignement requirements - or whether the guest supports memory hot add at
all - that's what the device will learn only once the guest connects
to the protocol.

1b) For the same reason the memory region has to be unplugged at the VM
reset time - the new guest might have stricter alignement requirements.

By the way, the memory region *can't* be unplugged yet at VMBus device
reset time - Windows keeps on using it until the system is restarted,
even after disconnecting from the VMBus.

2) The !memdev case, when the driver is just used for Windows-native
ballooning and stats reporting.

3) This will hopefully allow sharing the backing memory device between
virtio-mem and hv-balloon in the future - Linux guests will connect to
the former interface while Windows guests will connect to the later.

> 
> Supporting the !memdev case is interesting: you essentially want to plug a memory device without a device region (or with an empty stub). I guess we should get that figured out somehow.
> 

That's why the previous version of this driver used a parent VMBus
device (non-TYPE_MEMORY_DEVICE) which then had virtual DIMMs as its
children carrying memory for hot add.

I guess both approaches have its own pros and cons.

Thanks,
Maciej



