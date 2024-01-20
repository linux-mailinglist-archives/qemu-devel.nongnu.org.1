Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F44683335E
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 10:45:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rR7to-0006OP-TI; Sat, 20 Jan 2024 04:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rR7tk-0006OF-FZ
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 04:44:20 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rR7ti-0001RX-9y
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 04:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705743858; x=1737279858;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=c+HAb0QhWrtxF6Hn0AxR5wtL6vM51S4sx0bPBIE+FW0=;
 b=JUK0j8RSbYayZFcSSEi1yHc7JFgN/6sTIiYTZpcHqJSd+6yHZrFqDVRf
 Tdn+GEk0Rf0Qlg30k0Sge3z/8/iFGmO+iOuNPNtUn7kHBag9sMXYHFQc5
 X/ZpZWZ+2Vd8XFYIrdF1I4OlNL5FjPb/70u6Vb3SzSaU/Gbjx+V6x9+tb
 wQsADXS6Fi2LdrMl+3HQCWvxDZN1CMIRO8mZsz6httGrK2QlndJ7F1XCx
 aMB1+LFg4z2hlEbtsou4hdDGsoQxeCcPL4i9vmdhN8J3ewRY3LXxDEoC9
 Q8IxGarWme1xYQIb5LcX1l5R0L1CQkRmyg2OWAW/m2xkVGFUMeB0O6gai A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="7606907"
X-IronPort-AV: E=Sophos;i="6.05,207,1701158400"; 
   d="scan'208";a="7606907"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2024 01:44:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="904379718"
X-IronPort-AV: E=Sophos;i="6.05,207,1701158400"; d="scan'208";a="904379718"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.33.17])
 ([10.93.33.17])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2024 01:44:10 -0800
Message-ID: <b6950a34-0ef6-4945-9e50-5a47e86490e1@intel.com>
Date: Sat, 20 Jan 2024 17:44:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why invtsc (CPUID_APM_INVTSC) is unmigratable?
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Lei Wang <lei4.wang@intel.com>
References: <825f29d7-9112-45a2-b4a3-7d3b54c3c0a2@intel.com>
 <Zaqf839r8TXvkIAf@tpad>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Zaqf839r8TXvkIAf@tpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/20/2024 12:14 AM, Marcelo Tosatti wrote:
> On Fri, Jan 19, 2024 at 02:46:22PM +0800, Xiaoyao Li wrote:
>> I'm wondering why CPUID_APM_INVTSC is set as unmigratable_flags. Could
>> anyone explain it?
> 
> 
> commit 68bfd0ad4a1dcc4c328d5db85dc746b49c1ec07e
> Author: Marcelo Tosatti <mtosatti@redhat.com>
> Date:   Wed May 14 16:30:09 2014 -0300
> 
>      target-i386: block migration and savevm if invariant tsc is exposed
>      
>      Invariant TSC documentation mentions that "invariant TSC will run at a
>      constant rate in all ACPI P-, C-. and T-states".
>      
>      This is not the case if migration to a host with different TSC frequency
>      is allowed, or if savevm is performed. So block migration/savevm.
> 
> So the rationale here was that without ensuring the destination host
> has the same TSC clock frequency, we can't migrate.

It seems to me the concept of invtsc was extended to "tsc freq will not 
change even after the machine is live migrated". I'm not sure it is 
correct to extend the concept of invtsc.

The main reason of introducing invtsc is to tell the tsc hardware keeps 
counting (at the same rate) even at deep C state, so long as other states.

For example, a guest is created on machine A with X GHz tsc, and invtsc 
exposed (machine A can ensure the guest's tsc counts at X GHz at any 
state). If the guest is migrated to machine B with Y GHz tsc, and 
machine B can also ensure the invtsc of its guest, i.e., the guest's tsc 
counts at Y GHz at any state. IMHO, in this case, the invtsc is 
supported at both src and dest, which means it is a migratable feature. 
However, the migration itself fails, due to mismatched/different 
configuration of tsc freq, not due to invtsc.

> However, this was later extended to allow invtsc migratioon when setting
> tsc-khz explicitly:
> 
> commit d99569d9d8562c480e0befab601756b0b7b5d0e0
> Author: Eduardo Habkost <ehabkost@redhat.com>
> Date:   Sun Jan 8 15:32:34 2017 -0200
> 
>      kvm: Allow invtsc migration if tsc-khz is set explicitly
>      
>      We can safely allow a VM to be migrated with invtsc enabled if
>      tsc-khz is set explicitly, because:
>      * QEMU already refuses to start if it can't set the TSC frequency
>        to the configured value.
>      * Management software is already required to keep device
>        configuration (including CPU configuration) the same on
>        migration source and destination.
>      
>      Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>      Message-Id: <20170108173234.25721-3-ehabkost@redhat.com>
>      Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

But in the case that user doesn't set tsc freq explicitly, the live 
migration is likely to fail or have issues even without invtsc exposed 
to guest, if the destination host has a different tsc frequency than src 
host.

So why bother checking invtsc only?

> And support for libvirt was added:
> 
> https://listman.redhat.com/archives/libvir-list/2017-January/141757.html
> 
>>
>> When the host supports invtsc, it can be exposed to guest.
>> When the src VM has invtsc exposed, what will forbid it to be migrated to a
>> dest that also supports VMs with invtsc exposed?
>>
>>
> 


