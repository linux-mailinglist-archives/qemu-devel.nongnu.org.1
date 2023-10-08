Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8D37BCBCD
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 05:01:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpK1C-0006Tf-JN; Sat, 07 Oct 2023 22:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qpK1A-0006TX-O8
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 22:59:44 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qpK18-0007WT-Dk
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 22:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696733982; x=1728269982;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=JY61nxrnTIgPfkug6sU6RVyQBMUpJyqCJ0YRGP8Yq7w=;
 b=Gp+PmuF9FnzLdSeX+7ILJCb+XnVOLldiQ8HsjDySvDMC45bkUWLjI40/
 x2VUiT/Qz46PveQf2TOgiCZR4sTokwFtg1iIVi2n2WzmG8Tz55GLAwOAe
 WYSfTQcfeHfgwkZxakbEEAjc9WUV4rQkRUvMjRLZLJHXXnoH44mofPQl4
 To03sjietwnf/poCuR7jo5lAOs+C83ppNOYnwqO4spnDcEqkvTDpokNKa
 JL2JRU6liipZEaIDCU6xQqyiHXun8fW8vKMzcu9244d2UKui/PhxuCAFn
 /HJrSk090fNerINq6eAmgr+gioLHcVae7khmT3C6SHl64eEEgqfN32MSG Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="387839841"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; d="scan'208";a="387839841"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2023 19:59:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="787812956"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; d="scan'208";a="787812956"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.19.128])
 ([10.93.19.128])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2023 19:59:30 -0700
Message-ID: <5334cca3-6e96-7771-0ca4-de124ed40176@intel.com>
Date: Sun, 8 Oct 2023 10:59:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 02/21] RAMBlock: Add support of KVM private gmem
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <20230914035117.3285885-3-xiaoyao.li@intel.com>
 <678bf0bf-57e7-a596-1ddf-6d0b47cd8677@redhat.com>
 <6eeb5568-2faa-85c3-8f42-ed6317ea376c@intel.com>
 <998a0ef6-a74c-feec-eca2-644aee91f27b@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <998a0ef6-a74c-feec-eca2-644aee91f27b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, NICE_REPLY_A=-0.644,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 9/22/2023 3:08 PM, David Hildenbrand wrote:
> On 22.09.23 02:22, Xiaoyao Li wrote:
>> On 9/21/2023 4:55 PM, David Hildenbrand wrote:
>>> On 14.09.23 05:50, Xiaoyao Li wrote:
>>>> From: Chao Peng <chao.p.peng@linux.intel.com>
>>>>
>>>> Add KVM gmem support to RAMBlock so both normal hva based memory
>>>> and kvm gmem fd based private memory can be associated in one RAMBlock.
>>>>
>>>> Introduce new flag RAM_KVM_GMEM. It calls KVM ioctl to create private
>>>> gmem for the RAMBlock when it's set.
>>>
>>>
>>> But who sets RAM_KVM_GMEM and when?
>>
>> The answer is in the next patch. When `private` property of memory
>> backend is set to true, it will pass RAM_KVM_GMEM flag to
>> memory_region_init_ram_*()
> 
> Okay, assuming that patch (and property) will go away, I assume this 
> flag can also go away, right?
> 

If dropping the flag RAM_KVM_GMEM, it seems we need go back to the 
approach of rfc v1[1][2], that allocating gmem inside .region_add() 
callback. Is it accepted by you?

Another option is allocating gmem inside ram_block_add() by checking the 
vm_type (it looks hacky for me). What's your opinion on this option?

One more option is, we keep the RAM_KVM_GMEM as this patch, and change 
"private" property of memory backend into "need_kvm_gmem" field (make it 
not user settable) and "need_kvm_gmem" field will be set to true in 
tdx_kvm_init() specific cgs initialization function.


[1] 
https://lore.kernel.org/qemu-devel/a154c33d-b24d-b713-0dc0-027d54f2340f@redhat.com/
[2] 
https://lore.kernel.org/qemu-devel/20230731162201.271114-10-xiaoyao.li@intel.com/





