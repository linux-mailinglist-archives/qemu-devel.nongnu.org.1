Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 177B97A92B6
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:39:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFDl-0003XI-L0; Thu, 21 Sep 2023 04:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qjFDg-0003Qm-EU
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:39:32 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qjFDc-0001tX-6L
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695285568; x=1726821568;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XjjSoZ7Kjr8a+VD5sxsSA7OrugdElOS9X7CAZMZJKFg=;
 b=B0Q2fZGYAnGFtYOrANHos6ENLKhkJdi2/lQttf+qpUTehOdjSyNaIv8u
 c4TYp2ybpn/tjcmaaACmuCF7cioXZlnkxePM+8VGVZ1dJ9h9pf3jcskDm
 mXLrzdpM2vlWpMG9bNrYUdyh05roZPgwVNwFYAunXecpRbU0ui/Dh/CJR
 rFUIuBLsBjyN1xyQvTSebnuWPvScqu07OmCMo2vEkGtPCnwDjg8srxgoE
 uisNPTHzbGaClv7JCm021ermYFPWPOu6tOSP1Mwq57uUQHYZk4ceCHK11
 ik4cwjkFRGAdVgetL28IDpGiRRwy6XeMlP7OaaBVZKd9YfWf8soGlkLKc g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360707407"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="360707407"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 01:39:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="696653200"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="696653200"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.29.154])
 ([10.93.29.154])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 01:38:58 -0700
Message-ID: <cfa3ac58-fb1f-b255-772a-ab369a68be68@intel.com>
Date: Thu, 21 Sep 2023 16:38:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 03/21] HostMem: Add private property and associate
 it with RAM_KVM_GMEM
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <20230914035117.3285885-4-xiaoyao.li@intel.com> <8734zazeag.fsf@pond.sub.org>
 <d0e7e2f8-581d-e708-5ddd-947f2fe9676a@intel.com>
 <878r91nvy4.fsf@pond.sub.org>
 <da598ffc-fa47-3c25-64ea-27ea90d712aa@intel.com>
 <091a40cb-ec26-dd79-aa26-191dc59c03e6@redhat.com>
 <87msxgdf5y.fsf@pond.sub.org>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <87msxgdf5y.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.151; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-1.473,
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

On 9/20/2023 11:42 PM, Markus Armbruster wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 20.09.23 16:35, Xiaoyao Li wrote:
>>> On 9/20/2023 3:30 PM, Markus Armbruster wrote:
>>>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>>>
>>>>> On 9/19/2023 5:46 PM, Markus Armbruster wrote:
>>>>>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>>>>>
>>>>>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>>>>>>
>>>>>>> Add a new property "private" to memory backends. When it's set to true,
>>>>>>> it indicates the RAMblock of the backend also requires kvm gmem.
>>>>>> Can you add a brief explanation why you need the property?
>>>>>
>>>>> It provides a mechanism for user to specify whether the memory can serve as private memory (need request kvm gmem).
>>>>
>>>> Yes, but why would a user want such memory?
>>>>
>>> Because KVM demands it for confidential guest, e.g., TDX guest. KVM
>>> demands that the mem slot needs to have KVM_MEM_PRIVATE set and has
>>> valid gmem associated if the guest accesses it as private memory.
> 
> Commit messages should explain why we want the patch.  Documenting "why"
> is at least as important as "what".  If "what" is missing, I can read
> the patch to find out.  If "why" is missing, I'm reduced to guesswork.

I'll try best to improve the commit message of this patch, and all other 
patches.

>> I think as long as there is no demand to have a TDX guest with this property be set to "off", then just don't add it.
>>
>> With a TDX VM, it will can be implicitly active. If we ever have to disable it for selective memory backends, we can add the property and have something like on/off/auto. For now it would be "auto".
> 
> Makes sense to me.

OK. I think I get the answer of open #1 in cover letter.

If no other voice, I'll drop this patch and allocate gmem RAM when 
vm_type is TDX.



