Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2E97CEDCC
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 03:56:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtIFZ-0006DY-Mu; Wed, 18 Oct 2023 21:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qtIFY-0006Cx-1M
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 21:55:00 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qtIFV-0001DW-Gr
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 21:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697680497; x=1729216497;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=uM+5tmkpxsCrRg5okmQ9uPSS8aK9gSzXxcPiaIb+iAA=;
 b=K/owIxPksXC8KNDQRSNRaroZr/dyDNw2GfbNmg5qfly0YUXsO4ikSKGR
 o20ZkrdA1pgNYEJYeKB2ofXN5HD9T6BgMNit5+MteAmzDIXEe8LhotRLM
 OiJV69lSn21/AUjxXkT/xq5CnVm4IoXcWhKzE/pZfC6mAA+Qq0Z+/CUh1
 zMNKum34yze+K16PbBtdLRq5ELgU3CvjpE4vDY1hEX0WLhuYKTtTY8xMb
 d7Nrd6125P3PPkR3zy0xGjQ83jXFqX6i+QGT3WtZiNkXnrYe8+dG0ITVk
 iYOiTPsp7//3DKZNkltvdAPfwJqLm5vFCF0gCfbmrXDPO/ydc+MMMwHBO Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="389014688"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; d="scan'208";a="389014688"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2023 18:54:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="791827789"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; d="scan'208";a="791827789"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.19.128])
 ([10.93.19.128])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2023 18:54:50 -0700
Message-ID: <64b15539-3821-4dda-8bc9-64d11a0db797@intel.com>
Date: Thu, 19 Oct 2023 09:54:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/pc: Drop pc_machine_kvm_type()
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>
References: <20231007065819.27498-1-xiaoyao.li@intel.com>
 <20231018092715-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20231018092715-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.24; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 10/18/2023 9:27 PM, Michael S. Tsirkin wrote:
> On Sat, Oct 07, 2023 at 02:58:19AM -0400, Xiaoyao Li wrote:
>> pc_machine_kvm_type() was introduced by commit e21be724eaf5 ("i386/xen:
>> add pc_machine_kvm_type to initialize XEN_EMULATE mode") to do Xen
>> specific initialization by utilizing kvm_type method.
>>
>> commit eeedfe6c6316 ("hw/xen: Simplify emulated Xen platform init")
>> moves the Xen specific initialization to pc_basic_device_init().
>>
>> There is no need to keep the PC specific kvm_type() implementation
>> anymore. So we'll fallback to kvm_arch_get_default_type(), which
>> simply returns 0.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Acked-by: David Woodhouse <dwmw@amazon.co.uk>
> 
> Seems ok
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks, Michael!

> kvm thing so please merge through that tree.

Paolo, would you please handle it?

> 
>> ---
>>   hw/i386/pc.c         | 5 -----
>>   include/hw/i386/pc.h | 3 ---
>>   2 files changed, 8 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index aad7e8ccd1d7..41783b137b9a 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1730,11 +1730,6 @@ static void pc_machine_initfn(Object *obj)
>>       cxl_machine_init(obj, &pcms->cxl_devices_state);
>>   }
>>   
>> -int pc_machine_kvm_type(MachineState *machine, const char *kvm_type)
>> -{
>> -    return 0;
>> -}
>> -
>>   static void pc_machine_reset(MachineState *machine, ShutdownCause reason)
>>   {
>>       CPUState *cs;
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index bec38cb92cf7..ad7149cb10b5 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -305,15 +305,12 @@ extern const size_t pc_compat_1_5_len;
>>   extern GlobalProperty pc_compat_1_4[];
>>   extern const size_t pc_compat_1_4_len;
>>   
>> -int pc_machine_kvm_type(MachineState *machine, const char *vm_type);
>> -
>>   #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>>       static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
>>       { \
>>           MachineClass *mc = MACHINE_CLASS(oc); \
>>           optsfn(mc); \
>>           mc->init = initfn; \
>> -        mc->kvm_type = pc_machine_kvm_type; \
>>       } \
>>       static const TypeInfo pc_machine_type_##suffix = { \
>>           .name       = namestr TYPE_MACHINE_SUFFIX, \
>>
>> base-commit: 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d
>> -- 
>> 2.34.1
> 


