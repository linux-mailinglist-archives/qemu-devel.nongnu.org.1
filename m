Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9027AA60B
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 02:25:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjTyC-0002hS-Ia; Thu, 21 Sep 2023 20:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qjTy9-0002gz-Lr
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 20:24:29 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qjTy7-000565-VC
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 20:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695342267; x=1726878267;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Yz/UzV6kHqKGL5M88pH/K0nRDaCXriDTqQPkONdxErU=;
 b=b8I2PnqQPhPg++fc5Jx3w3/qPmW3x5Zf00AoOS3rr4lY8N2t4KJvEjnv
 Mh6KW6434Yj/TvkCCADs1YgNMk595mkc7BIU7bLhkwb75H6TIWd4YzHsT
 Z5KL4FTeBzAF9LOUkmIFE32Mqs9lkYPPY0bC6viGKf6bUwJTMy56Py31T
 +UBSWx3rSHNFo6b0c6NX6mME1C2KhyEUlo3PAxTvDBfHJaDIRcdISJgWP
 8EdCHkV4dUsHISWrAf0l+CMAKvijc8Yl7V2Sa6htr3qW6+/zE0MJmDHCp
 DwFJ0VYGQMguNHyf7vTksnDisCXIHnAIqxp13QDmTgEQZmhgXTJ9sBnJt Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="365764649"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; d="scan'208";a="365764649"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 17:24:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="862721080"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; d="scan'208";a="862721080"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.11.250])
 ([10.93.11.250])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 17:24:20 -0700
Message-ID: <11ada91d-4054-2ce9-9a3b-4d182106e860@intel.com>
Date: Fri, 22 Sep 2023 08:24:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 07/21] i386/pc: Drop pc_machine_kvm_type()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <20230914035117.3285885-8-xiaoyao.li@intel.com>
 <b5ebeeac-9f0f-eb57-b5e2-4c03698e5ee4@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <b5ebeeac-9f0f-eb57-b5e2-4c03698e5ee4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=xiaoyao.li@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-1.473,
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

On 9/21/2023 4:51 PM, David Hildenbrand wrote:
> On 14.09.23 05:51, Xiaoyao Li wrote:
>> pc_machine_kvm_type() was introduced by commit e21be724eaf5 ("i386/xen:
>> add pc_machine_kvm_type to initialize XEN_EMULATE mode") to do Xen
>> specific initialization by utilizing kvm_type method.
>>
>> commit eeedfe6c6316 ("hw/xen: Simplify emulated Xen platform init")
>> moves the Xen specific initialization to pc_basic_device_init().
>>
>> There is no need to keep the PC specific kvm_type() implementation
>> anymore.
> 
> So we'll fallback to kvm_arch_get_default_type(), which simply returns 0.
> 
>> On the other hand, later patch will implement kvm_type()
>> method for all x86/i386 machines to support KVM_X86_SW_PROTECTED_VM.
>>
> 
> ^ I suggest dropping that and merging that patch ahead-of-time as a 
> simple cleanup.

I suppose the "that" here means "this patch", right?

If so, I can submit this patch separately.

> Reviewed-by: David Hildenbrand <david@redhat.com>
> 


