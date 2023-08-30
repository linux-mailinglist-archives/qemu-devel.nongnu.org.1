Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B378D1DB
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 03:55:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbAOx-0000Z1-TV; Tue, 29 Aug 2023 21:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qbAOs-0000XX-5g
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 21:53:42 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qbAOo-0003mp-LK
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 21:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693360418; x=1724896418;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=n7+5Tnf4oVHN1YfjOKumtJWeaf4nATSJ6NM8TmlHHaU=;
 b=ExaK5yuMCUiwAUA03RpuebL7A+/bggeYCOWdTwVGFTvkqACRw+HcBH3e
 Hd81gSRBRsdfXxkPpTxBH2klmXTmGWUyq5CJvwQ2LbywPi2CIneW1/xqB
 Lt13rR4aKV6O/gW5eZHpOT2eA7M0jHj7oOICTNjw4xLS/f1+iM6dvi/ie
 9b/G1vrGvTEZBWps7z47HjVEiwMMTWL6HCnjPNokwpuWjIwvPV90u76xm
 D68NDd4MLkSsIPoD61PP9moifYiAfGx0DmgBQr7vq78weLPttJ0hy6mQ/
 sbVH9V2QNmEmfWP9dc7BbbDyZq/CYZt5up9/g2u1hBFaPyZxPxblaHc01 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="360526156"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; d="scan'208";a="360526156"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2023 18:53:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="773937101"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; d="scan'208";a="773937101"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.16.81])
 ([10.93.16.81])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2023 18:53:29 -0700
Message-ID: <c70bee27-7277-3c9d-19fe-fe4a3a1e29b0@intel.com>
Date: Wed, 30 Aug 2023 09:53:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2 36/58] memory: Introduce memory_region_init_ram_gmem()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-37-xiaoyao.li@intel.com>
 <68526bca-6054-510e-09fe-f73bf610b005@linaro.org>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <68526bca-6054-510e-09fe-f73bf610b005@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=xiaoyao.li@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-1.242,
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

On 8/29/2023 10:33 PM, Philippe Mathieu-Daudé wrote:
> On 18/8/23 11:50, Xiaoyao Li wrote:
>> Introduce memory_region_init_ram_gmem() to allocate private gmem on the
>> MemoryRegion initialization. It's for the usercase of TDVF, which must
>> be private on TDX case.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   include/exec/memory.h |  6 +++++
>>   softmmu/memory.c      | 52 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 58 insertions(+)
> 
> 
>> diff --git a/softmmu/memory.c b/softmmu/memory.c
>> index af6aa3c1e3c9..ded44dcef1aa 100644
>> --- a/softmmu/memory.c
>> +++ b/softmmu/memory.c
>> @@ -25,6 +25,7 @@
>>   #include "qom/object.h"
>>   #include "trace.h"
>> +#include <linux/kvm.h>
> 
> Unlikely to build on non-Linux hosts.

Thanks for catching it!

Will warp it with CONFIG_KVM.

Anyway, it's the main open of how to integrating KVM gmem into QEMU's 
memory system, in QMEU gmem series[*]. I'm still working on it.

[*] 
https://lore.kernel.org/qemu-devel/20230731162201.271114-1-xiaoyao.li@intel.com/

>>   #include "exec/memory-internal.h"
>>   #include "exec/ram_addr.h"
>>   #include "sysemu/kvm.h"
> 


