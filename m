Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6510784609
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 17:46:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYTZi-0004xY-5q; Tue, 22 Aug 2023 11:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qYTZd-0004xD-RG
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:45:43 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qYTZa-00016y-RP
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692719138; x=1724255138;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5v6aCju/1g5fNSmLz1BLj1E+RPrUqsxUNIS0WONK45U=;
 b=SVx3JXvpv8rMSoCtOgo8BycMhkrcQ6Et5Rgu4ySJ8dZvNEuNBNVKEVR8
 nh0OCX4LE7pYraMdX6yzLxaTa0kBgQh/9Qj1tdvrle8WgL8KLVoknieTa
 YUXwN533CzKaDH6sOo8QL+bmi9rTIc2uzeOmVRMq+T9+3U8uT0+3L1/jc
 c9awtMx+MamnpSjUexEyrfByyBFuVftfVvF6zeICxdGpzGm75RH+iJmEg
 DImtMWf6xVLATTnraPNrEZffUNju/2wOWr7Trl5QiA/aBXtOvx99Qnbj4
 ac4i/inePi6A7+E9gib8QPQBTAOsxCwblwAI9L+3xB4zOiBnKHFEdGbfk g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="371335826"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; d="scan'208";a="371335826"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 08:45:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="859961159"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; d="scan'208";a="859961159"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77])
 ([10.93.6.77])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 08:45:12 -0700
Message-ID: <fa401024-2a19-229b-932e-d3541c763422@intel.com>
Date: Tue, 22 Aug 2023 23:45:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2 32/58] i386/tdx: Track RAM entries for TDX VM
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
 <20230818095041.1973309-33-xiaoyao.li@intel.com>
 <20230821234052.GD3642077@ls.amr.corp.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230821234052.GD3642077@ls.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.93; envelope-from=xiaoyao.li@intel.com;
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

On 8/22/2023 7:40 AM, Isaku Yamahata wrote:
> On Fri, Aug 18, 2023 at 05:50:15AM -0400,
> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> 
>> diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
>> index e9d2888162ce..9b3c427766ef 100644
>> --- a/target/i386/kvm/tdx.h
>> +++ b/target/i386/kvm/tdx.h
>> @@ -15,6 +15,17 @@ typedef struct TdxGuestClass {
>>       ConfidentialGuestSupportClass parent_class;
>>   } TdxGuestClass;
>>   
>> +enum TdxRamType{
>> +    TDX_RAM_UNACCEPTED,
>> +    TDX_RAM_ADDED,
>> +};
>> +
>> +typedef struct TdxRamEntry {
>> +    uint64_t address;
>> +    uint64_t length;
>> +    uint32_t type;
> 
> nitpick: enum TdxRamType. and related function arguments.
> 

Will do it.

Thanks!


