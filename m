Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3902B783B20
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:47:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYM6Z-0006G0-8P; Tue, 22 Aug 2023 03:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qYM69-0006BI-Py
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:46:46 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qYM65-0002be-PV
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692690401; x=1724226401;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=SaJdRyM3XstR33ApZ9jm+dMPxuB2Q47L4hQ636PzyME=;
 b=VFhbHEQc3s9LsqWGzPC4nKRkAhrEvtswgtL4VxDD5aKzTwNZjkPnjAvV
 kEHu9HsheCbe/3bT7GtDuHD4U73W/6tJ1VMl6pO0EuKoj3nrLyg1cn5QW
 EFtmzMzegvu4/+AVMdKhX7KmosF69fYEgqT9UOWuPG/ILQeb8YBqKdPL4
 QTGvr0IQWsqjpbbx/e65gwukWhPeWxHLL+goXYxVps5E6zjGZyrhObrTT
 cFDOstq0SBk3XDBCILYL0V/hupRrdaaUaAIXCHRrKnoClxbfJ3g0l/Kkx
 UBaS+lhr273pFixJ8saw5CjLe1jcRBrhcb6WJ/R5IXcWEeJ6H+3E6Bu2P Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="437726986"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; d="scan'208";a="437726986"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 00:46:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="982789621"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; d="scan'208";a="982789621"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77])
 ([10.93.6.77])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 00:46:30 -0700
Message-ID: <ddcb487b-8bd2-5d03-b29e-dd79455c96cb@intel.com>
Date: Tue, 22 Aug 2023 15:46:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2 07/58] i386/tdx: Introduce is_tdx_vm() helper and cache
 tdx_guest object
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-8-xiaoyao.li@intel.com> <ZOMk+kaAtgBh3Qgk@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZOMk+kaAtgBh3Qgk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -77
X-Spam_score: -7.8
X-Spam_bar: -------
X-Spam_report: (-7.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-3.374,
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

On 8/21/2023 4:48 PM, Daniel P. Berrangé wrote:
> On Fri, Aug 18, 2023 at 05:49:50AM -0400, Xiaoyao Li wrote:
>> It will need special handling for TDX VMs all around the QEMU.
>> Introduce is_tdx_vm() helper to query if it's a TDX VM.
>>
>> Cache tdx_guest object thus no need to cast from ms->cgs every time.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>   target/i386/kvm/tdx.c | 13 +++++++++++++
>>   target/i386/kvm/tdx.h | 10 ++++++++++
>>   2 files changed, 23 insertions(+)
>>
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index 255c47a2a553..56cb826f6125 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -21,8 +21,16 @@
>>   #include "kvm_i386.h"
>>   #include "tdx.h"
>>   
>> +static TdxGuest *tdx_guest;
>> +
>>   static struct kvm_tdx_capabilities *tdx_caps;
>>   
>> +/* It's valid after kvm_confidential_guest_init()->kvm_tdx_init() */
>> +bool is_tdx_vm(void)
>> +{
>> +    return !!tdx_guest;
>> +}
>> +
>>   enum tdx_ioctl_level{
>>       TDX_PLATFORM_IOCTL,
>>       TDX_VM_IOCTL,
>> @@ -109,10 +117,15 @@ static void get_tdx_capabilities(void)
>>   
>>   int tdx_kvm_init(MachineState *ms, Error **errp)
>>   {
>> +    TdxGuest *tdx = (TdxGuest *)object_dynamic_cast(OBJECT(ms->cgs),
>> +                                                    TYPE_TDX_GUEST);
> 
> This method can return NULL.  Presumably tdx_kvm_init() should only
> be called if we already checked  ms->cgs == TYPE_TDX_GUEST. If so
> then use object_dynamic_cast_assert() instead.
> 

object_dynamic_cast_assert() is for OBJECT_CHECK() and INTERFACE_CHECK().

So I will use TDX_GUEST(OBJECT(ms->cgs)) (introduced in patch 2) 
instead, which is the wrapper of OBJECT_CHECK().


