Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 074ACC183C4
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Oct 2025 05:38:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDxuz-0006pg-Ik; Wed, 29 Oct 2025 00:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDxur-0006ox-Tv
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 00:36:10 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDxui-00045m-HA
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 00:36:09 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59T4ZnZu038343
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 29 Oct 2025 13:35:49 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=4ZCJqyQWMhw2pEUPsChUbdA5eVVoYaw9ntuaPvVa3qI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:From:To;
 s=rs20250326; t=1761712550; v=1;
 b=k2DjAX4r/0927GnmKP64BCA9M8Zbncr7tyIFJHfRV8zyHgqb+EQDCy+E/LHauxWl
 WY6yQ2SoMqmXAvd3oha64B2roXoumkGVBdblDP9RV2vG3puiGQlzryvIQG+uWn0S
 zbeREBw0nP7V2LFkuRqHoGmzprThLt6fRqBA9VBAmjDu22UcHaheqrNIp6g/NoME
 wIAR1/EVEZ2Aj/1xM6YFsSI/ahcpVOtOnt7KXz2bt1rxFRw0GoGsS0lXCMAG8l4w
 PI2XZzR2iLZWqGF6fJLUCYvg/lHP1FiwzpvL9YN4+KHNeAqTa7U2mLY5FsIFdgBS
 uVdH9+oLUIWQm9Rr3XfknA==
Message-ID: <7e46c5de-3227-4b24-ab95-8fb9575fe7ed@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 29 Oct 2025 13:35:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: Make FlatView root references weak
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251027-root-v1-1-ddf92b9058be@rsg.ci.i.u-tokyo.ac.jp>
 <aQE_M1qsr78RrQaw@x1.local>
 <376f8d41-6ffb-4e1b-b50b-93a0f307d017@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
In-Reply-To: <376f8d41-6ffb-4e1b-b50b-93a0f307d017@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/10/29 13:06, Akihiko Odaki wrote:
> On 2025/10/29 7:09, Peter Xu wrote:
>> On Mon, Oct 27, 2025 at 02:56:53PM +0900, Akihiko Odaki wrote:
>>> docs/devel/memory.rst says "memory_region_ref and memory_region_unref
>>> are never called on aliases", but these functions are called for
>>> FlatView roots, which can be aliases.
>>
>> IMHO the quoted doc was in a special context, where it was talking about
>> the example of address_space_map() holding adhoc refcounts of a MR, in
>> which case "memory_region_ref and memory_region_unref are never called on
>> aliases" was correct..
>>
>> The full context:
>>
>>    ...
>>    If you break this rule, the following situation can happen:
>>    - the memory region's owner had a reference taken via 
>> memory_region_ref
>>      (for example by address_space_map)
>>    - the region is unparented, and has no owner anymore
>>    - when address_space_unmap is called, the reference to the memory 
>> region's
>>      owner is leaked.
>>    There is an exception to the above rule: it is okay to call
>>    object_unparent at any time for an alias or a container region.  It is
>>    therefore also okay to create or destroy alias and container regions
>>    dynamically during a device's lifetime.
>>    This exceptional usage is valid because aliases and containers only 
>> help
>>    QEMU building the guest's memory map; they are never accessed 
>> directly.
>>    memory_region_ref and memory_region_unref are never called on aliases
>>    or containers, and the above situation then cannot happen.  Exploiting
>>    this exception is rarely necessary, and therefore it is discouraged,
>>    but nevertheless it is used in a few places.
>>    ...
>>
>> So I can't say the doc is wrong, but maybe it can be at least be 
>> clearer on
>> the scope of that sentence.. indeed.
> 
> I think statement "it is okay to call object_unparent at any time for an 
> alias or a container region" can be corrected. Practically, developers 
> will want call object_unparent() only when:
> - the memory region is not added to a container and
> - there is no manual references created with memory_region_ref().
> 
> These two conditions can be satisfied by auditing the device code that 
> owns the memory region instead of multiple devices.
> 
>>
>>>
>>> This causes object overwrite hazard in pci-bridge. Specifically,
>>> pci_bridge_region_init() expects that there are no references to
>>> w->alias_io after object_unparent() is called, allowing it to reuse the
>>> associated storage. However, if a parent bus still holds a reference to
>>> the existing object as a FlatView's root, the storage is still in use,
>>> leading to an overwrite. This hazard can be confirmed by adding the
>>> following code to pci_bridge_region_init():
>>>
>>> PCIDevice *parent_dev = parent->parent_dev;
>>> assert(!object_dynamic_cast(OBJECT(parent_dev), TYPE_PCI_BRIDGE) ||
>>>         PCI_BRIDGE(parent_dev)->as_io.current_map->root != &w- 
>>> >alias_io);
>>
>> What's interesting is I found PCIBridge.as_io / PCIBridge.as_mem are not
>> used anywhere..  because it looks like the bridge code uses MRs to 
>> operate
>> rather than address spaces.
>>
>> Does it mean we can drop the two ASes?  Then if they're the only 
>> holder of
>> the refcounts of these problematic MRs, does it solve the problem too 
>> in an
>> easier way?  Maybe there're other issues you want to fix too with this 
>> patch?
> 
> Apparently we cannot drop the ASes. See commit 55fa4be6f76a ("virtio- 
> pci: fix memory_region_find for VirtIOPCIRegion's MR"), which introduced 
> them.
> 
> I don't know any other existing devices affected by this FlatView 
> behavior, but it is also difficult to show that they are *not* affected 
> because it requires traversing MemoryRegion graphs that span across 
> several devices.
> 
> We will also need to update the documentation for future devices, but it 
> is not trivial either as the condition where aliases are referenced from 
> FlatView is complex.
> 
> Considering that, I think this patch is a pragmatic solution that 
> ensures correctness of object_unparent() on aliases.
> 
>>
>>>
>>> This assertion fails when running:
>>> meson test -C build qtest-x86_64/bios-tables-test \
>>>      '--test-args=-p /x86_64/acpi/piix4/pci-hotplug/no_root_hotplug'
>>>
>>> Make the references of FlatView roots "weak" (i.e., remove the
>>> reference to a root automatically removed when it is finalized) to
>>> avoid calling memory_region_ref and memory_region_unref and fix the
>>> hazard with pci-bridge.
>>>
>>> Alternative solutions (like removing the "never called on aliases"
>>> statement or detailing the exception) were rejected because the alias
>>> invariant is still relied upon in several parts of the codebase, and
>>> updating existing code to align with a new condition is non-trivial.
>>>
>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> ---
>>>   system/memory.c | 8 ++++++--
>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/system/memory.c b/system/memory.c
>>> index 8b84661ae36c..08fe5e791224 100644
>>> --- a/system/memory.c
>>> +++ b/system/memory.c
>>> @@ -266,7 +266,6 @@ static FlatView *flatview_new(MemoryRegion *mr_root)
>>>       view = g_new0(FlatView, 1);
>>>       view->ref = 1;
>>>       view->root = mr_root;
>>> -    memory_region_ref(mr_root);
>>>       trace_flatview_new(view, mr_root);
>>>       return view;
>>> @@ -301,7 +300,6 @@ static void flatview_destroy(FlatView *view)
>>>           memory_region_unref(view->ranges[i].mr);
>>>       }
>>>       g_free(view->ranges);
>>> -    memory_region_unref(view->root);
>>>       g_free(view);
>>>   }
>>> @@ -1796,6 +1794,12 @@ void memory_region_init_iommu(void *_iommu_mr,
>>>   static void memory_region_finalize(Object *obj)
>>>   {
>>>       MemoryRegion *mr = MEMORY_REGION(obj);
>>> +    gpointer key;
>>> +    gpointer value;
>>> +
>>> +    if (g_hash_table_steal_extended(flat_views, mr, &key, &value)) {
>>> +        ((FlatView *)value)->root = NULL;
>>> +    }
>>
>> This is definitely very tricky.. The translation path (from
>> AddressSpaceDispatch) indeed looks ok as of now, which doesn't looks at
>> view->root.. however at least I saw this:
>>
>> void flatview_unref(FlatView *view)
>> {
>>      if (qatomic_fetch_dec(&view->ref) == 1) {
>>          trace_flatview_destroy_rcu(view, view->root);
>>          assert(view->root);                            
>> <-------------------
>>          call_rcu(view, flatview_destroy, rcu);
>>      }
>> }
>>
>> I wonder how it didn't already crash.
> 
> In case of pci-bridge, I guess flatview_unref() is synchronously called, 
> but memory_region_unref(view->root) is not because of flatview_destroy() 
> is delayed with RCU.
> 
>>
>> The other stupid but working solution is we can always make the 6 aliases
>> to not be reused, IOW we can always use dynamic MRs considering
>> pci_bridge_update_mappings() should be rare?
> 
> Perhaps we may introduce memory_region_new_alias() (that calls 
> object_new()) and allow calling object_unparent() only for aliases 
> created with the function.
Speaking of alternative solutions, I think the best solution in long 
term is to use functions that dynamically update aliases such as 
memory_region_set_alias_offset() instead of dynamically calling 
object_unparent().

But that also requires considerable amount of effort, so I think this 
patch still makes sense as an immediate solution. Perhaps we may also 
expand the documentation to tell developers to use the dynamic update 
functions so that the number of object_unparent() calls on aliases will 
decrease over time and we can eventually remove the weak reference trick.

Regards,
Akihiko Odaki

