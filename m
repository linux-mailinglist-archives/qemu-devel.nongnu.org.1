Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6079081AEB4
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 07:19:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGCO6-00017z-Au; Thu, 21 Dec 2023 01:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rGCO2-00017e-M5
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 01:18:27 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rGCO0-0003px-Ct
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 01:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703139504; x=1734675504;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=BsYBvZXpNmDxnhkK3p7HJV3JL+6lmwWO8f24hANixYY=;
 b=MPZwGvw57wJwuq8ybfZmH/TDMiIDcdctn9BoQhwiXEJ7y4fNeyXiLl65
 iUMD1D/eFh3Xl0O+dfBc8o/fAOkYVzz2fb90Q5f5FJUXFXvJHbx5xOgp2
 obW/nmdDtKVzGIxxv56jf56h4UrsKWc4/IeSXwIRmNxeGTVi+DH1h6obw
 ccB4EAagTt0P58QtzCgtUbe85bTcfCPVPkAZkFilnM8guD2zG86qqJHyW
 aDc04U6edemfeoeDnwJHWz9cWoZZ85t/gZQl+Gnmjvh6gB33V1f0iJSMe
 HI+XXgTF3uphaZ5A5aRJrknlskNUtyuddijInhevmviGqezk4yxTldYta A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="399757492"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; d="scan'208";a="399757492"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Dec 2023 22:18:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="810867965"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; d="scan'208";a="810867965"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.12.199])
 ([10.93.12.199])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Dec 2023 22:18:14 -0800
Message-ID: <f5f21e2d-b462-4402-b728-46ab4124efb8@intel.com>
Date: Thu, 21 Dec 2023 14:18:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/70] physmem: Introduce ram_block_convert_range() for
 page conversion
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 isaku.yamahata@intel.com
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-10-xiaoyao.li@intel.com>
 <20231117210304.GC1645850@ls.amr.corp.intel.com>
 <8f20d060-38fe-49d7-8fea-fe665c3c6c78@intel.com>
 <0dc03b42-23c3-4e02-868e-289b3fedf6af@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <0dc03b42-23c3-4e02-868e-289b3fedf6af@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 12/8/2023 7:52 PM, David Hildenbrand wrote:
> On 08.12.23 08:59, Xiaoyao Li wrote:
>> On 11/18/2023 5:03 AM, Isaku Yamahata wrote:
>>> On Wed, Nov 15, 2023 at 02:14:18AM -0500,
>>> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>>
>>>> It's used for discarding opposite memory after memory conversion, for
>>>> confidential guest.
>>>>
>>>> When page is converted from shared to private, the original shared
>>>> memory can be discarded via ram_block_discard_range();
>>>>
>>>> When page is converted from private to shared, the original private
>>>> memory is back'ed by guest_memfd. Introduce
>>>> ram_block_discard_guest_memfd_range() for discarding memory in
>>>> guest_memfd.
>>>>
>>>> Originally-from: Isaku Yamahata <isaku.yamahata@intel.com>
>>>> Codeveloped-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>> ---
>>>>    include/exec/cpu-common.h |  2 ++
>>>>    system/physmem.c          | 50 
>>>> +++++++++++++++++++++++++++++++++++++++
>>>>    2 files changed, 52 insertions(+)
>>>>
>>>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>>>> index 41115d891940..de728a18eef2 100644
>>>> --- a/include/exec/cpu-common.h
>>>> +++ b/include/exec/cpu-common.h
>>>> @@ -175,6 +175,8 @@ typedef int (RAMBlockIterFunc)(RAMBlock *rb, 
>>>> void *opaque);
>>>>    int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
>>>>    int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t 
>>>> length);
>>>> +int ram_block_convert_range(RAMBlock *rb, uint64_t start, size_t 
>>>> length,
>>>> +                            bool shared_to_private);
>>>>    #endif
>>>> diff --git a/system/physmem.c b/system/physmem.c
>>>> index ddfecddefcd6..cd6008fa09ad 100644
>>>> --- a/system/physmem.c
>>>> +++ b/system/physmem.c
>>>> @@ -3641,6 +3641,29 @@ err:
>>>>        return ret;
>>>>    }
>>>> +static int ram_block_discard_guest_memfd_range(RAMBlock *rb, 
>>>> uint64_t start,
>>>> +                                               size_t length)
>>>> +{
>>>> +    int ret = -1;
>>>> +
>>>> +#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>>>> +    ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | 
>>>> FALLOC_FL_KEEP_SIZE,
>>>> +                    start, length);
>>>> +
>>>> +    if (ret) {
>>>> +        ret = -errno;
>>>> +        error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx 
>>>> (%d)",
>>>> +                     __func__, rb->idstr, start, length, ret);
>>>> +    }
>>>> +#else
>>>> +    ret = -ENOSYS;
>>>> +    error_report("%s: fallocate not available %s:%" PRIx64 " +%zx 
>>>> (%d)",
>>>> +                 __func__, rb->idstr, start, length, ret);
>>>> +#endif
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>>    bool ramblock_is_pmem(RAMBlock *rb)
>>>>    {
>>>>        return rb->flags & RAM_PMEM;
>>>> @@ -3828,3 +3851,30 @@ bool ram_block_discard_is_required(void)
>>>>        return qatomic_read(&ram_block_discard_required_cnt) ||
>>>>               
>>>> qatomic_read(&ram_block_coordinated_discard_required_cnt);
>>>>    }
>>>> +
>>>> +int ram_block_convert_range(RAMBlock *rb, uint64_t start, size_t 
>>>> length,
>>>> +                            bool shared_to_private)
>>>> +{
>>>> +    if (!rb || rb->guest_memfd < 0) {
>>>> +        return -1;
>>>> +    }
>>>> +
>>>> +    if (!QEMU_PTR_IS_ALIGNED(start, qemu_host_page_size) ||
>>>> +        !QEMU_PTR_IS_ALIGNED(length, qemu_host_page_size)) {
>>>> +        return -1;
>>>> +    }
>>>> +
>>>> +    if (!length) {
>>>> +        return -1;
>>>> +    }
>>>> +
>>>> +    if (start + length > rb->max_length) {
>>>> +        return -1;
>>>> +    }
>>>> +
>>>> +    if (shared_to_private) {
>>>> +        return ram_block_discard_range(rb, start, length);
>>>> +    } else {
>>>> +        return ram_block_discard_guest_memfd_range(rb, start, length);
>>>> +    }
>>>> +}
>>>
>>> Originally this function issued KVM_SET_MEMORY_ATTRIBUTES, the 
>>> function name
>>> mad sense. But now it doesn't, and it issues only punch hole. We 
>>> should rename
>>> it to represent what it actually does. discard_range?
>>
>> ram_block_discard_range() already exists for non-guest-memfd memory 
>> discard.
>>
>> I cannot come up with a proper name. e.g.,
>> ram_block_discard_opposite_range() while *opposite* seems unclear.
>>
>> Do you have any better idea?
> 
> Having some indication that this is about "guest_memfd" back and forth 
> switching/conversion will make sense. But I'm also not able to come up 
> with a better name.
> 
> Maybe have two functions:
> 
> ram_block_activate_guest_memfd_range
> ram_block_deactivate_guest_memfd_range
> 

finally, I decide to drop this function and expose 
ram_block_discard_guest_memfd_range() instead. So caller can call the 
ram_block_discard_*() on its own.

