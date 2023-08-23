Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E023784F81
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 06:00:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYf1k-00066Q-EZ; Tue, 22 Aug 2023 23:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qYf1h-000666-Uv
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 23:59:25 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qYf1f-0003yQ-8u
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 23:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692763163; x=1724299163;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=OfOKcDn12jJixf7HQHLas2JHhxjBtPqMOoB2H3L4wXQ=;
 b=KHUZgDqy45NyN6u4BBvykMn951dzvaE0lvDwVuK8ex6rmzf7zTujSHUN
 rHRPj6Y7KjIrB2Gga+iqv3Fv/I9BdSoOi7jluCWeJFYvYoWYuRqaWtB0b
 DNxpnu4+ze9/fPph8OUc8/fD/4LheUxHla4HYniiT2VxeES/lQkglpBB9
 0o7DruW0GeodCDzP3Fvh14FxR9noLi/4mjV9KLpORj2nTT1WoxoFRUiRb
 fkH0Qw6Aa6SBRqA6Dj3zE4avPbGNYVhU3UE6q4v9yzPhrqONqVmexyubs
 CsW/NrNwdRKUjOnr7CQxPCz20m1qG6XPKePGJFz6b613VWpkHwwfvVN9I g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="377816088"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; d="scan'208";a="377816088"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 20:59:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="826564613"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; d="scan'208";a="826564613"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77])
 ([10.93.6.77])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 20:59:12 -0700
Message-ID: <44c62f53-f066-d359-c980-5b24af11e6d7@intel.com>
Date: Wed, 23 Aug 2023 11:59:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2 08/58] i386/tdx: Adjust the supported CPUID based on
 TDX restrictions
Content-Language: en-US
To: Isaku Yamahata <isaku.yamahata@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 erdemaktas@google.com, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-9-xiaoyao.li@intel.com>
 <20230821230054.GB3642077@ls.amr.corp.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230821230054.GB3642077@ls.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-1.767,
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

On 8/22/2023 7:00 AM, Isaku Yamahata wrote:
> On Fri, Aug 18, 2023 at 05:49:51AM -0400,
> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> 
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index 56cb826f6125..3198bc9fd5fb 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
> ...
>> +static inline uint32_t host_cpuid_reg(uint32_t function,
>> +                                      uint32_t index, int reg)
>> +{
>> +    uint32_t eax, ebx, ecx, edx;
>> +    uint32_t ret = 0;
>> +
>> +    host_cpuid(function, index, &eax, &ebx, &ecx, &edx);
>> +
>> +    switch (reg) {
>> +    case R_EAX:
>> +        ret |= eax;
>> +        break;
>> +    case R_EBX:
>> +        ret |= ebx;
>> +        break;
>> +    case R_ECX:
>> +        ret |= ecx;
>> +        break;
>> +    case R_EDX:
>> +        ret |= edx;
> 
> Nitpick: "|" isn't needed as we initialize ret = 0 above. Just '='.

Will fix it in next version.

thanks!

