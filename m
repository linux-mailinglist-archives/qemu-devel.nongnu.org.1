Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5D0956F09
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Aug 2024 17:41:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg4Uw-0002Oz-AH; Mon, 19 Aug 2024 11:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sg4Uu-0002OU-5Y
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 11:40:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sg4Ur-0003gY-1a
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 11:40:43 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WncD36CTkz6K97G;
 Mon, 19 Aug 2024 23:37:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 75B651400C9;
 Mon, 19 Aug 2024 23:40:26 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 19 Aug
 2024 16:40:25 +0100
Date: Mon, 19 Aug 2024 16:40:24 +0100
To: John Groves <John@groves.net>
CC: David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
 <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny
 <ira.weiny@intel.com>, <virtualization@lists.linux.dev>, Oscar Salvador
 <osalvador@suse.de>, <qemu-devel@nongnu.org>, Dave Jiang
 <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 <linuxarm@huawei.com>, <wangkefeng.wang@huawei.com>, John Groves
 <jgroves@micron.com>, "Fan Ni" <fan.ni@samsung.com>, "Navneet Singh"
 <navneet.singh@intel.com>, "=?UTF-8?Q?=E2=80=9CMichael?= S. =?UTF-8?Q?Tsi?=
 =?UTF-8?Q?rkin=E2=80=9D?=" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Philippe =?UTF-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [RFC] Virtualizing tagged disaggregated memory capacity (app
 specific, multi host shared)
Message-ID: <20240819164024.00005a0a@Huawei.com>
In-Reply-To: <sjz2xzwkgkq6bun5lssqbsimbggczarotpjdhcsq3itoq5h7jc@x5ormqciwofo>
References: <20240815172223.00001ca7@Huawei.com>
 <sjz2xzwkgkq6bun5lssqbsimbggczarotpjdhcsq3itoq5h7jc@x5ormqciwofo>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Sun, 18 Aug 2024 21:12:34 -0500
John Groves <John@groves.net> wrote:

> On 24/08/15 05:22PM, Jonathan Cameron wrote:
> > Introduction
> > ============
> > 
> > If we think application specific memory (including inter-host shared memory) is
> > a thing, it will also be a thing people want to use with virtual machines,
> > potentially nested. So how do we present it at the Host to VM boundary?
> > 
> > This RFC is perhaps premature given we haven't yet merged upstream support for
> > the bare metal case. However I'd like to get the discussion going given we've
> > touched briefly on this in a number of CXL sync calls and it is clear no one is  
> 
> Excellent write-up, thanks Jonathan.
> 
> Hannes' idea of an in-person discussion at LPC is a great idea - count me in.

Had a feeling you might say that ;)

> 
> As the proprietor of famfs [1] I have many thoughts.
> 
> First, I like the concept of application-specific memory (ASM), but I wonder
> if there might be a better term for it. ASM suggests that there is one
> application, but I'd suggest that a more concise statement of the concept
> is that the Linux kernel never accesses or mutates the memory - even though
> multiple apps might share it (e.g. via famfs). It's a subtle point, but
> an important one for RAS etc. ASM might better be called non-kernel-managed
> memory - though that name does not have as good a ring to it. Will mull this
> over further...

Naming is always the hard bit :)  I agree that one doesn't work for
shared capacity. You can tell I didn't start there :)

> 
> Now a few level-setting comments on CXL and Dynamic Capacity Devices (DCDs),
> some of which will be obvious to many of you:
> 
> * A DCD is just a memory device with an allocator and host-level
>   access-control built in.
> * Usable memory from a DCD is not available until the fabric manger (likely
>   on behalf of an orchestrator) performs an Initiate Dynamic Capacity Add
>   command to the DCD.
> * A DCD allocation has a tag (uuid) which is the invariant way of identifying
>   the memory from that allocation.
> * The tag becomes known to the host from the DCD extents provided via
>   a CXL event following succesful allocation.
> * The memory associated with a tagged allocation will surface as a dax device
>   on each host that has access to it. But of course dax device naming &
>   numbering won't be consistent across separate hosts - so we need to use
>   the uuid's to find specific memory.
> 
> A few less foundational observations:
> 
> * It does not make sense to "online" shared or sharable memory as system-ram,
>   because system-ram gets zeroed, which blows up use cases for sharable memory.
>   So the default for sharable memory must be devdax mode.
(CXL specific diversion)

Absolutely agree this this. There is a 'corner' that irritates me in the spec though
which is that there is no distinction between shareable and shared capacity.
If we are in a constrained setup with limited HPA or DPA space, we may not want
to have separate DCD regions for these.  Thus it is plausible that an orchestrator
might tell a memory appliance to present memory for general use and yet it
surfaces as shareable.  So there may need to be an opt in path at least for
going ahead and using this memory as normal RAM.

> * Tags are mandatory for sharable allocations, and allowed but optional for
>   non-sharable allocations. The implication is that non-sharable allocations
>   may get onlined automatically as system-ram, so we don't need a namespace
>   for those. (I argued for mandatory tags on all allocations - hey you don't
>   have to use them - but encountered objections and dropped it.)
> * CXL access control only goes to host root ports; CXL has no concept of
>   giving access to a VM. So some component on a host (perhaps logically
>   an orchestrator component) needs to plumb memory to VMs as appropriate.

Yes.  It's some mashup of an orchestrator and VMM / libvirt, local library
of your choice. We can just group into into the ill defined concept of
a distributed orchestrator.

> 
> So tags are a namespace to find specific memory "allocations" (which in the
> CXL consortium, we usually refer to as "tagged capacity").
> 
> In an orchestrated environment, the orchestrator would allocate resources
> (including tagged memory capacity), make that capacity visible on the right
> host(s), and then provide the tag when starting the app if needed.
> 
> if (e.g.) the memory cotains a famfs file system, famfs needs the uuid of the
> root memory allocation to find the right memory device. Once mounted, it's a
> file sytem so apps can be directed to the mount path. Apps that consume the
> dax devices directly also need the uuid because /dev/dax0.0 is not invariant
> across a cluster...
> 
> I have been assuming that when the CXL stack discovers a new DCD allocation,
> it will configure the devdax device and provide some way to find it by tag.
> /sys/cxl/<tag>/dev or whatever. That works as far as it goes, but I'm coming
> around to thinking that the uuid-to-dax map should not be overtly CXL-specific.

Agreed. Whether that's a nice kernel side thing, or a utility pulling data
from various kernel subsystem interfaces doesn't really matter. I'd prefer
the kernel presents this but maybe that won't work for some reason.

> 
> General thoughts regarding VMs and qemu
> 
> Physical connections to CXL memory are handled by physical servers. I don't
> think there is a scenario in which a VM should interact directly with the
> pcie function(s) of CXL devices. They will be configured as dax devices
> (findable by their tags!) by the host OS, and should be provided to VMs
> (when appropriate) as DAX devices. And software in a VM needs to be able to
> find the right DAX device the same way it would running on bare metal - by
> the tag.

Limiting to typical type 3 memory pool devices. Agreed. The other CXL device
types are a can or worms for another day.

> 
> Qemu can already get memory from files (-object memory-backend-file,...), and
> I believe this works whether it's an actual file or a devdax device. So far,
> so good.
> 
> Qemu can back a virtual pmem device by one of these, but currently (AFAIK)
> not a virtual devdax device. I think virtual devdax is needed as a first-class
> abstraction. If we can add the tag as a property of the memory-backend-file,
> we're almost there - we just need away to lookup a daxdev by tag.

I'm not sure that is simple. We'd need to define a new interface capable of:
1) Hotplug - potentially of many separate regions (think nested VMs).
   That more or less rules out using separate devices on a discoverable hotpluggable
   bus. We'd run out of bus numbers too quickly if putting them on PCI.
   ACPI style hotplug is worse because we have to provision slots at the outset.
2) Runtime provision of metadata - performance data very least (bandwidth /
   latency etc). In theory could wire up ACPI _HMA but no one has ever bothered.
3) Probably do want async error signaling.  We 'could' do that with
   FW first error injection - I'm not sure it's a good idea but it's definitely
   an option.

A locked down CXL device is a bit more than that, but not very much more.
It's easy to fake registers for things that are always in one state so
that the software stack is happy.

virtio-mem has some of the parts and could perhaps be augmented
to support this use case with the advantage of no implicit tie to CXL.


> 
> Summary thoughts:
> 
> * A mechanism for resolving tags to "tagged capacity" devdax devices is
>   essential (and I don't think there are specific proposals about this
>   mechanism so far).

Agreed.

> * Said mechanism should not be explicitly CXL-specific.

Somewhat agreed, but I don't want to invent a new spec just to avoid explicit
ties to CXL. I'm not against using CXL to present HBM / ACPI Specific Purpose
memory for example to a VM. It will trivially work if that is what a user
wants to do and also illustrates that this stuff doesn't necessarily just
apply to capacity on a memory pool - it might just be 'weird' memory on the host.

> * Finding a tagged capacity devdax device in a VM should work the same as it
>   does running on bare metal.

Absolutely - that's a requirement.

> * The file-backed (and devdax-backed) devdax abstraction is needed in qemu.

Maybe. I'm not convinced the abstraction is needed at that particular level.

> * Beyond that, I'm not yet sure what the lookup mechanism should be. Extra
>   points for being easy to implement in both physical and virtual systems.

For physical systems we aren't going to get agreement :(  For the systems
I have visibility of there will be some diversity in hardware, but the
presentation to userspace and up consistency should be doable.

Jonathan

> 
> Thanks for teeing this up!
> John
> 
> 
> [1] https://github.com/cxl-micron-reskit/famfs/blob/master/README.md
> 


