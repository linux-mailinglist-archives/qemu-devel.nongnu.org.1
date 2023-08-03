Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A266676E369
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 10:44:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRTve-00033X-UT; Thu, 03 Aug 2023 04:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qRTva-00032v-RH
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 04:43:27 -0400
Received: from [192.55.52.151] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qRTvY-0007xk-EI
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 04:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691052204; x=1722588204;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=eczJyj54SDbFmE/aCyOve527h3otE0MyhmyI9fQ0DKE=;
 b=WDRke9mbq9DPckMosKisyyFsKHOxDCdLupQwpp8cKb3nv9RQb7l/QYee
 5KYy+SdNYXPPk7REdnXqKJlipUS5063KmSZLgeIQYx3ABxMQ6xLfPcZUs
 wukcamWPbZfaxfnF5tDJ9y0MXWyapn3s8tvuy+30q/0U9n6njqUIIhQTi
 lTZnhroJ6Tt5rm2YlvoGCGYHsjbrHWT1jWJeHPKcicNB+xw4lU7g0ZIhy
 H7Tm8mVJwCTs5R5Db2q0REtE2gv8NJbLfwjgONVDVK4HWrMdsXPMnSq2x
 7/lcso59HOSw1ZWbb/CjFb/fM9hTZVr0gWQunguKK0li9svTMoDAW8ffY g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="350106533"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; d="scan'208";a="350106533"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2023 01:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="732670094"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; d="scan'208";a="732670094"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.18.246])
 ([10.93.18.246])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2023 01:43:15 -0700
Message-ID: <0e0d2523-e8bd-d96d-be9e-f59cac2f52e7@intel.com>
Date: Thu, 3 Aug 2023 16:43:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 05/19] kvm: Enable KVM_SET_USER_MEMORY_REGION2 for
 memslot
Content-Language: en-US
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <20230731162201.271114-6-xiaoyao.li@intel.com>
 <abf251ad-12d5-fb05-d3af-5a6ecbf56bb4@suse.de>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <abf251ad-12d5-fb05-d3af-5a6ecbf56bb4@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.55.52.151 (failed)
Received-SPF: pass client-ip=192.55.52.151; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-0.102,
 RCVD_IN_DNSWL_MED=-2.3, RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 8/2/2023 1:10 AM, Claudio Fontana wrote:
> On 7/31/23 18:21, Xiaoyao Li wrote:
>> From: Chao Peng <chao.p.peng@linux.intel.com>
>>
>> Switch to KVM_SET_USER_MEMORY_REGION2 when supported by KVM.
>>
>> With KVM_SET_USER_MEMORY_REGION2, QEMU can set up memory region that
>> backen'ed both by hva-based shared memory and gmem fd based private
>> memory.
>>
>> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
>> Codeveloped-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   accel/kvm/kvm-all.c      | 57 +++++++++++++++++++++++++++++++++-------
>>   accel/kvm/trace-events   |  2 +-
>>   include/sysemu/kvm_int.h |  2 ++
>>   3 files changed, 51 insertions(+), 10 deletions(-)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index d8eee405de24..7b1818334ba7 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -288,35 +288,68 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram,
>>   static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, bool new)
>>   {
>>       KVMState *s = kvm_state;
>> -    struct kvm_userspace_memory_region mem;
>> +    struct kvm_userspace_memory_region2 mem;
>> +    static int cap_user_memory2 = -1;
>>       int ret;
>>   
>> +    if (cap_user_memory2 == -1) {
>> +        cap_user_memory2 = kvm_check_extension(s, KVM_CAP_USER_MEMORY2);
>> +    }
>> +
>> +    if (!cap_user_memory2 && slot->fd >= 0) {
>> +        error_report("%s, KVM doesn't support gmem!", __func__);
>> +        exit(1);
>> +    }
> 
> We handle this special error case here,
> while the existing callers of kvm_set_user_memory_region handle the other error cases in different places.
> 
> Not that the rest of kvm-all does an excellent job at error handling, but maybe we can avoid compounding on the issue.

I'm not sure how to align them. Do you have any suggestion?

>> +
>>       mem.slot = slot->slot | (kml->as_id << 16);
>>       mem.guest_phys_addr = slot->start_addr;
>>       mem.userspace_addr = (unsigned long)slot->ram;
>>       mem.flags = slot->flags;
>> +    mem.gmem_fd = slot->fd;
>> +    mem.gmem_offset = slot->ofs;
>>   
>> -    if (slot->memory_size && !new && (mem.flags ^ slot->old_flags) & KVM_MEM_READONLY) {
>> +    if (slot->memory_size && !new && (slot->flags ^ slot->old_flags) & KVM_MEM_READONLY) {
> 
> Why the change if mem.flags == slot->flags ?

I guess the goal is to make it clearer that it's comparing the (new) 
flags with old_flags of the slot.

Anyway, if this change is annoying, I can drop it. :)

>>           /* Set the slot size to 0 before setting the slot to the desired
>>            * value. This is needed based on KVM commit 75d61fbc. */
>>           mem.memory_size = 0;
>> -        ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
>> +
>> +        if (cap_user_memory2) {
>> +            ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION2, &mem);
>> +        } else {
>> +            ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
>> +	    }
>>           if (ret < 0) {
>>               goto err;
>>           }
>>       }
>>       mem.memory_size = slot->memory_size;
>> -    ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
>> +    if (cap_user_memory2) {
>> +        ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION2, &mem);
>> +    } else {
>> +        ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
>> +    }
>>       slot->old_flags = mem.flags;
>>   err:
>>       trace_kvm_set_user_memory(mem.slot >> 16, (uint16_t)mem.slot, mem.flags,
>>                                 mem.guest_phys_addr, mem.memory_size,
>> -                              mem.userspace_addr, ret);
>> +                              mem.userspace_addr, mem.gmem_fd,
>> +			      mem.gmem_offset, ret);
>>       if (ret < 0) {
>> -        error_report("%s: KVM_SET_USER_MEMORY_REGION failed, slot=%d,"
>> -                     " start=0x%" PRIx64 ", size=0x%" PRIx64 ": %s",
>> -                     __func__, mem.slot, slot->start_addr,
>> -                     (uint64_t)mem.memory_size, strerror(errno));
>> +        if (cap_user_memory2) {
>> +                error_report("%s: KVM_SET_USER_MEMORY_REGION2 failed, slot=%d,"
>> +                        " start=0x%" PRIx64 ", size=0x%" PRIx64 ","
>> +                        " flags=0x%" PRIx32 ","
>> +                        " gmem_fd=%" PRId32 ", gmem_offset=0x%" PRIx64 ": %s",
>> +                        __func__, mem.slot, slot->start_addr,
>> +                (uint64_t)mem.memory_size, mem.flags,
>> +                        mem.gmem_fd, (uint64_t)mem.gmem_offset,
>> +                        strerror(errno));
>> +        } else {
>> +                error_report("%s: KVM_SET_USER_MEMORY_REGION failed, slot=%d,"
>> +                            " start=0x%" PRIx64 ", size=0x%" PRIx64 ": %s",
>> +                __func__, mem.slot, slot->start_addr,
>> +                (uint64_t)mem.memory_size, strerror(errno));
>> +        }
>>       }
>>       return ret;
>>   }
>> @@ -472,6 +505,9 @@ static int kvm_mem_flags(MemoryRegion *mr)
>>       if (readonly && kvm_readonly_mem_allowed) {
>>           flags |= KVM_MEM_READONLY;
>>       }
>> +    if (memory_region_can_be_private(mr)) {
>> +        flags |= KVM_MEM_PRIVATE;
>> +    }
>>       return flags;
>>   }
>>   
>> @@ -1402,6 +1438,9 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
>>           mem->ram_start_offset = ram_start_offset;
>>           mem->ram = ram;
>>           mem->flags = kvm_mem_flags(mr);
>> +        mem->fd = mr->ram_block->gmem_fd;
>> +        mem->ofs = (uint8_t*)ram - mr->ram_block->host;
>> +
>>           kvm_slot_init_dirty_bitmap(mem);
>>           err = kvm_set_user_memory_region(kml, mem, true);
>>           if (err) {
>> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
>> index 14ebfa1b991c..80694683acea 100644
>> --- a/accel/kvm/trace-events
>> +++ b/accel/kvm/trace-events
>> @@ -15,7 +15,7 @@ kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
>>   kvm_irqchip_release_virq(int virq) "virq %d"
>>   kvm_set_ioeventfd_mmio(int fd, uint64_t addr, uint32_t val, bool assign, uint32_t size, bool datamatch) "fd: %d @0x%" PRIx64 " val=0x%x assign: %d size: %d match: %d"
>>   kvm_set_ioeventfd_pio(int fd, uint16_t addr, uint32_t val, bool assign, uint32_t size, bool datamatch) "fd: %d @0x%x val=0x%x assign: %d size: %d match: %d"
>> -kvm_set_user_memory(uint16_t as, uint16_t slot, uint32_t flags, uint64_t guest_phys_addr, uint64_t memory_size, uint64_t userspace_addr, int ret) "AddrSpace#%d Slot#%d flags=0x%x gpa=0x%"PRIx64 " size=0x%"PRIx64 " ua=0x%"PRIx64 " ret=%d"
>> +kvm_set_user_memory(uint16_t as, uint16_t slot, uint32_t flags, uint64_t guest_phys_addr, uint64_t memory_size, uint64_t userspace_addr, uint32_t fd, uint64_t fd_offset, int ret) "AddrSpace#%d Slot#%d flags=0x%x gpa=0x%"PRIx64 " size=0x%"PRIx64 " ua=0x%"PRIx64 " gmem_fd=%d" " gmem_fd_offset=0x%" PRIx64 " ret=%d"
>>   kvm_clear_dirty_log(uint32_t slot, uint64_t start, uint32_t size) "slot#%"PRId32" start 0x%"PRIx64" size 0x%"PRIx32
>>   kvm_resample_fd_notify(int gsi) "gsi %d"
>>   kvm_dirty_ring_full(int id) "vcpu %d"
>> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
>> index 511b42bde5c4..48220c0793ac 100644
>> --- a/include/sysemu/kvm_int.h
>> +++ b/include/sysemu/kvm_int.h
>> @@ -30,6 +30,8 @@ typedef struct KVMSlot
>>       int as_id;
>>       /* Cache of the offset in ram address space */
>>       ram_addr_t ram_start_offset;
>> +    int fd;
>> +    hwaddr ofs;
>>   } KVMSlot;
>>   
>>   typedef struct KVMMemoryUpdate {
> 


