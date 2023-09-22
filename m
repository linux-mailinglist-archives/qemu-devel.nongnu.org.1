Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E65177AA9AD
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 09:05:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjaDU-0001QC-1O; Fri, 22 Sep 2023 03:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qjaDR-0001Q3-Mn
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:04:41 -0400
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qjaDO-00071C-Jj
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695366278; x=1726902278;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/UUAcVXG2ViI9IVF3s/SfGomnPqiRRaiDBRjonZhOLE=;
 b=OH7w/XrDU0MYsm/rWjt/DJY2Ni7QsG+1VOKsF6yiPrJq+JWNXb6XdNE9
 S4/YbHC4QNr1FZQp1GN8oo/PL8uWvnZdJHZGhQnR/tT1JeNEwX+wsZGB1
 +jrEksRN8wg3iTLEC/N5FVFOYNS9rTGWvqWnUA9sjA4WJNybsJ5Dc3NNn
 i29gHJ/w90+uwQaLYB07oaDGyBZ3QdAt2WqSTwjB5gk4OCioPDMonKuqL
 s23ka4+S/SH8TWh/bH2carkccdyJnxI1/08nLJd3qsm5sIebpqHwZSYS7
 vxs9Gl8zHI+wEggXoS7RdEeshA527cLPUoPxCnPuFahnndRR0OW0wCvUR g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="411699616"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; d="scan'208";a="411699616"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2023 00:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="1078262936"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; d="scan'208";a="1078262936"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.11.250])
 ([10.93.11.250])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2023 00:03:56 -0700
Message-ID: <ace06668-81fd-3153-5b93-30b0b82aea46@intel.com>
Date: Fri, 22 Sep 2023 15:03:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 00/21] QEMU gmem implemention
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 isaku.yamahata@gmail.com, Claudio Fontana <cfontana@suse.de>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <fe9f3d19-df01-01e6-a253-f7fe5bdea41f@redhat.com>
 <ZQOu+OE8LWtLTyno@google.com>
 <103096a6-f4b5-d88a-2aac-07dcc86825d6@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <103096a6-f4b5-d88a-2aac-07dcc86825d6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/21/2023 5:11 PM, David Hildenbrand wrote:
>>>> 3. What is KVM_X86_SW_PROTECTED_VM going to look like? and do we 
>>>> need it?
>>>>
>>>
>>> Why implement it when you have to ask others for a motivation? 😉
>>>
>>> Personally, I'm not sure if it is really useful, especially in this 
>>> state.
>>
>> Yeah, as of today, KVM_X86_SW_PROTECTED_VM is mainly a development 
>> vehicle,
>> e.g. so that testing gmem doesn't require TDX/SNP hardware, debugging 
>> gmem guests
>> isn't brutally painful, etc.
>>
>> Longer term, I have aspirations of being able to back most VMs with 
>> gmem, but
>> that's going to require quite a bit more work, e.g. gmem needs to be 
>> mappable
>> (when hardware allows it) so that gmem doesn't all but require double 
>> mapping,
>> KVM obviously needs to be able to read/write gmem, etc.
>>
>> The value proposition is that having a guest-first memory type will 
>> allow KVM to
>> optimize and harden gmem in ways that wouldn't be feasible for a more 
>> generic
>> memory implementation.  E.g. memory isn't mapped into host userspace 
>> by default
>> (makes it harder to accidentally corrupt the guest), the guest can 
>> have *larger*
>> mappings than host userspace, guest memory can be served from a 
>> dedicated pool
>> (similar-ish to hugetlb), the pool can be omitted from the direct map, 
>> etc.
>>
> Thanks for that information. Personally, I don't believe "to back most 
> VMs with gmem", but that's a different discussion.
> 
> As a development vehicle to get TDX up and running it might be very 
> valuable indeed. But it doesn't necessarily have to be merged in QEMU 
> for that case -- especially in a semi-finished form.

It's true and I agree with it. I'll drop the KVM_X86_SW_PROTECTED_VM 
part in next version.

How would you like this series to proceed in next version? only the 
patches of gmem support without a user? or together with next QEMU TDX 
series?

