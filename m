Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0AB7FE9CA
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 08:36:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8baT-00058M-W9; Thu, 30 Nov 2023 02:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r8baP-00056a-Ox
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 02:35:50 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r8baK-00056l-8j
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 02:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701329743; x=1732865743;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=99FlI+lUby8pT37iELGoU1c/gT0psdPhOS/BFhYOTBY=;
 b=jA+jOtTcFWLL/0Had/JA42jcpOPPYD0RkKuolZYGj2APE9ww1YaOQwGX
 mxck4kdjfPQSG1Cr2V4/60W7RR2IbS11JU8k1ayRcc63xkSujPqR2S/z1
 Ms1NDjfLxf2SD+76nBPi2v2kfMuBTYxTKPeZc3h2GPm075S7edvjxbT1y
 Wmjel7GFDr3uvoYTS3y2VIZCOTPQlXGzwm2Ot4jziKxBTIaTCufi/e4Ib
 fbNl+j4IIYCK3omrw29tV7wHjkiOn+G8UKKufllLa1Q6FdlC/A/Q7hgRk
 eBki7ZSDwXLP15d+elt5JECQt81RfgmJObQ+jFNnq6EBiLfvRPIH5c6wu A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="6555318"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="6555318"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 23:35:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="719045110"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; d="scan'208";a="719045110"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.29.154])
 ([10.93.29.154])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 23:35:35 -0800
Message-ID: <994afc73-1929-4706-9510-e33bb7048487@intel.com>
Date: Thu, 30 Nov 2023 15:35:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/70] RAMBlock: Add support of KVM private guest memfd
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, Sean Christopherson
 <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-3-xiaoyao.li@intel.com>
 <ed599765-65b7-4253-8de2-61afba178e2d@redhat.com>
 <37b5ba85-021a-418b-8eda-8a716b7b7fb3@intel.com>
 <c3a7704f-12d8-457e-aad2-1c2ece896286@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <c3a7704f-12d8-457e-aad2-1c2ece896286@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/20/2023 5:19 PM, David Hildenbrand wrote:
> On 16.11.23 03:45, Xiaoyao Li wrote:
>> On 11/16/2023 1:54 AM, David Hildenbrand wrote:
>>> On 15.11.23 08:14, Xiaoyao Li wrote:
>>>> Add KVM guest_memfd support to RAMBlock so both normal hva based memory
>>>> and kvm guest memfd based private memory can be associated in one
>>>> RAMBlock.
>>>>
>>>> Introduce new flag RAM_GUEST_MEMFD. When it's set, it calls KVM 
>>>> ioctl to
>>>> create private guest_memfd during RAMBlock setup.
>>>>
>>>> Note, RAM_GUEST_MEMFD is supposed to be set for memory backends of
>>>> confidential guests, such as TDX VM. How and when to set it for memory
>>>> backends will be implemented in the following patches.
>>>
>>> Can you elaborate (and add to the patch description if there is good
>>> reason) why we need that flag and why we cannot simply rely on the VM
>>> type instead to decide whether to allocate a guest_memfd or not?
>>>
>>
>> The reason is, relying on the VM type is sort of hack that we need to
>> get the MachineState instance and retrieve the vm type info. I think
>> it's better not to couple them.
>>
>> More importantly, it's not flexible and extensible for future case that
>> not all the memory need guest memfd.
>>
> 
> Okay. In that case, please update the documentation of all functions 
> where we are allowed to pass in RAM_GUEST_MEMFD. There are a couple of 
> them in include/exec/memory.h

sure, thanks!

> I'll note that the name/terminology of "RAM_GUEST_MEMFD" is extremely 
> Linux+kvm specific. But I cannot really come up with something better 
> right now.
> 


