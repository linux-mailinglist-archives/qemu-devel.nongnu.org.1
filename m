Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D56D73F442
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 08:12:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE1uN-0002Qe-01; Tue, 27 Jun 2023 02:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qE1uJ-0002QB-9C
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 02:10:31 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qE1uH-0004qu-9i
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 02:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687846228; x=1719382228;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=M7RTINH3iWMvn5ggdXychf3DpYiQTH/lfrUJeiGZR0o=;
 b=U8ggNNy7Pb8e5ZkqAWN5TIiud3SEAW34QOLh60ApW8bKMzdbdF84N3Nh
 PPzCgmpZ4j9YoRQM71zDpfQr1upuTb2mPVl18MP+L/OGUT4xNM++HacTd
 HiPb1R7QgaWlGeaJZ2hC60Mq0cev94UuLZwZHU2XQBPJWa/ZRJ7nq5Otl
 Jsvp76YxsEW81eoufwMEYM7N/VA6paVQh+jt5IZygXIWzfAEeGQ4cN0+7
 1rn3WG3enkKqHecC4U0IJ22zCRe3pEzVJtqpW9MzzXFC+trEst4qu1vhh
 IKk7QamnTs8NmK8+5ndqziRRrGuKiK9BlBy/Y+p6ikQs0v37p1M7JDp4L Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="364937465"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; d="scan'208";a="364937465"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2023 23:10:22 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="751525347"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; d="scan'208";a="751525347"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.255.29.206])
 ([10.255.29.206])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2023 23:10:20 -0700
Message-ID: <f4b9bb58-a7d6-a02f-a307-450f3e630b3a@intel.com>
Date: Tue, 27 Jun 2023 14:10:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH 5/7] target/i386: Add few security fix bits in
 ARCH_CAPABILITIES into SapphireRapids CPU model
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, lei4.wang@intel.com,
 qian.wen@intel.com
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
 <20230616032311.19137-6-tao1.su@linux.intel.com>
 <20230626151530.24524700@imammedo.users.ipa.redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230626151530.24524700@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=xiaoyao.li@intel.com;
 helo=mga03.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/26/2023 9:15 PM, Igor Mammedov wrote:
> On Fri, 16 Jun 2023 11:23:09 +0800
> Tao Su <tao1.su@linux.intel.com> wrote:
> 
>> From: Lei Wang <lei4.wang@intel.com>
>>
>> Latest stepping (8) of SapphireRapids has bit 13, 14 and 15 of
>> MSR_IA32_ARCH_CAPABILITIES enabled, which are related to some security
>> fixes.
>>
>> Add version 2 of SapphireRapids CPU model with those bits enabled also.
> 
> don't we need to update stepping value to 8 as well?

No need.

The commit message is misleading. There 3 bits and some other bits in 
MSR_IA32_ARCH_CAPABILITIES are not tied to CPU stepping. Instead, they 
are enumerated with newer microcode.

>>
>> Signed-off-by: Lei Wang <lei4.wang@intel.com>
>> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
>> ---
>>   target/i386/cpu.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index b5321240c6..f84fd20bb1 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -3854,8 +3854,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>>           .model_id = "Intel Xeon Processor (SapphireRapids)",
>>           .versions = (X86CPUVersionDefinition[]) {
>>               { .version = 1 },
>> -            { /* end of list */ },
>> -        },
>> +            {
>> +                .version = 2,
>> +                .props = (PropValue[]) {
>> +                    { "sbdr-ssdp-no", "on" },
>> +                    { "fbsdp-no", "on" },
>> +                    { "psdp-no", "on" },
>> +                    { /* end of list */ }
>> +                }
>> +            },
>> +            { /* end of list */ }
>> +        }
>>       },
>>       {
>>           .name = "Denverton",
> 


