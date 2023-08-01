Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D301B76A6B7
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 04:04:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQeir-0000Tt-Ts; Mon, 31 Jul 2023 22:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQeip-0000Tf-AD
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 22:02:51 -0400
Received: from [192.55.52.120] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQein-0005j0-6M
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 22:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690855369; x=1722391369;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=eQdIzvbewvwesb8c3esY+r02/rqLnE+EOFZ+QULBn5w=;
 b=cIEtoOquN0OH5cXADxUgrDYDFqvgLg/yvCRNDLavYcU6Y4Dz1yUb+705
 HhqX4E0ubE2AHsJ7QrPRj3CGv/Lj+BG26rIHwfTAK89WvOR7P8Im1JEU0
 T0t38FtOFACtNFOQlWf0lBU8bT0DyOJ5Er9IQQ2OWK2yQd2Z/woD7hXmn
 64trrzv8mvKrYp/rOc39F3SqRXWaL+4J14hYlMAN5vC+t/zqbtnGgNzEI
 kpwNfKXGCHrx5HOfXl3E/MC2SwWcs9WslG7WUo/hR4+WukDhQkEORTbfx
 ujo/j4/T3cmvedYsdFHCoE+L951vaQMvEfCtQ/ytd+UnAC4QMp1fm5W7K A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="368074448"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; d="scan'208";a="368074448"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 18:55:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="678514344"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; d="scan'208";a="678514344"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77])
 ([10.93.6.77])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 18:55:30 -0700
Message-ID: <70746276-b748-aa5e-4a25-9399496c32e4@intel.com>
Date: Tue, 1 Aug 2023 09:55:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 00/19] QEMU gmem implemention
Content-Language: en-US
To: Isaku Yamahata <isaku.yamahata@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <20230731171041.GB1807130@ls.amr.corp.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230731171041.GB1807130@ls.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.55.52.120 (failed)
Received-SPF: pass client-ip=192.55.52.120; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-0.101,
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

On 8/1/2023 1:10 AM, Isaku Yamahata wrote:
> On Mon, Jul 31, 2023 at 12:21:42PM -0400,
> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> 
>> This is the first RFC version of enabling KVM gmem[1] as the backend for
>> private memory of KVM_X86_PROTECTED_VM.
>>
>> It adds the support to create a specific KVM_X86_PROTECTED_VM type VM,
>> and introduces 'private' property for memory backend. When the vm type
>> is KVM_X86_PROTECTED_VM and memory backend has private enabled as below,
>> it will call KVM gmem ioctl to allocate private memory for the backend.
>>
>>      $qemu -object memory-backend-ram,id=mem0,size=1G,private=on \
>>            -machine q35,kvm-type=sw-protected-vm,memory-backend=mem0 \
>> 	  ...
>>
>> Unfortunately this patch series fails the boot of OVMF at very early
>> stage due to triple fault because KVM doesn't support emulate string IO
>> to private memory. We leave it as an open to be discussed.
>>
>> There are following design opens that need to be discussed:
>>
>> 1. how to determine the vm type?
>>
>>     a. like this series, specify the vm type via machine property
>>        'kvm-type'
>>     b. check the memory backend, if any backend has 'private' property
>>        set, the vm-type is set to KVM_X86_PROTECTED_VM.
> 
> Hi Xiaoyao.  Because qemu has already confidential guest support, we should
> utilize it.  Say,
> qemu  \
>    -object sw-protected, id=swp0, <more options for KVM_X86_SW_PROTECTED_VM> \
>    -machine confidential-guest-support=swp0

thanks for pointing out this option. I thought of it and forgot to list 
it as option.

It seems better and I'll go this direction if no one has different opinion.

> 
>> 2. whether 'private' property is needed if we choose 1.b as design
>>
>>     with 1.b, QEMU can decide whether the memory region needs to be
>>     private (allocates gmem fd for it) or not, on its own.
> 
> 
> Memory region property (how to create KVM memory slot) should be independent
> from underlying VM type.  Some (e.g. TDX) may require KVM private memory slot,
> some may not.  Leave the decision to its vm type backend.  They can use qemu
> memory listener.

As I replied to Daniel, the topic is whether 'private' property is 
needed. Is it essential to let users decide which memory can be private? 
It seems OK that QEMU can make the decision based on VM type.

