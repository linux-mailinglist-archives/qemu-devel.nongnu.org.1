Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BAF7ED9B6
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 03:47:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3SOR-0002PD-95; Wed, 15 Nov 2023 21:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3SOC-0002Om-Hw
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 21:45:57 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3SOA-0007DF-Bc
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 21:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700102754; x=1731638754;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=USgPVJryTN/nazjsm6bRr8SP6B/qY4QF0GRbSH7gwH8=;
 b=QMUP3uDvOP5R6DMK/HS4qBA7ss3fr8OrRr7ma/N25+G3ExZto8vy4sHo
 wwZg/e3ZEa5gT80CdaUQ9TSh1Wzm0PjHy+n7ei6AsQT2+EZaCEdxoJdPA
 9R4tWS+oKHlpdkGuDfqCTQi0GaJVwtktHMHnPzyKMqg1fx8+2ygoOzK0P
 FaNm2ydApZhqhamW4Ec/Bt4alK11fOvcuHNQucc7C0SWV2b77hEaHsLqy
 RIgs/5MauKaCjDHWfyuUNVRgmwaaFAuyzebqzm2p1HUBpKu6mD6ZEBQ71
 V8VoNScOEmrhQjRFKPFmrdlXlD+/zwKSSmHKuKshjbfubbrn+SMMr7o49 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="9641434"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="9641434"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 18:45:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="800039868"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; d="scan'208";a="800039868"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77])
 ([10.93.6.77])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 18:45:45 -0800
Message-ID: <37b5ba85-021a-418b-8eda-8a716b7b7fb3@intel.com>
Date: Thu, 16 Nov 2023 10:45:35 +0800
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
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ed599765-65b7-4253-8de2-61afba178e2d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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

On 11/16/2023 1:54 AM, David Hildenbrand wrote:
> On 15.11.23 08:14, Xiaoyao Li wrote:
>> Add KVM guest_memfd support to RAMBlock so both normal hva based memory
>> and kvm guest memfd based private memory can be associated in one 
>> RAMBlock.
>>
>> Introduce new flag RAM_GUEST_MEMFD. When it's set, it calls KVM ioctl to
>> create private guest_memfd during RAMBlock setup.
>>
>> Note, RAM_GUEST_MEMFD is supposed to be set for memory backends of
>> confidential guests, such as TDX VM. How and when to set it for memory
>> backends will be implemented in the following patches.
> 
> Can you elaborate (and add to the patch description if there is good 
> reason) why we need that flag and why we cannot simply rely on the VM 
> type instead to decide whether to allocate a guest_memfd or not?
> 

The reason is, relying on the VM type is sort of hack that we need to 
get the MachineState instance and retrieve the vm type info. I think 
it's better not to couple them.

More importantly, it's not flexible and extensible for future case that 
not all the memory need guest memfd.

