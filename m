Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE94AF68BF
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Jul 2025 05:38:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXAkR-0006ul-O6; Wed, 02 Jul 2025 23:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXAkQ-0006uX-74
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 23:36:30 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXAkM-0000TU-CA
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 23:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751513786; x=1783049786;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=k6pJMW9VRfH/87FMZr+ojFdvHLHzMrkszNXu2CQRJJg=;
 b=P2CtUKEsryD61mdUBOn5p9r4Ll+8unTE/3g+x5dX8zvr+WRprSuQjDJ8
 lT95VrcG2LXoknMV7kE7YjTODClW5ghiZtW3hIa4YcDfU7KouVUclMrxi
 6itJnArY1emJ5WKCT/UBo7cfWOiI0cmKdsb4vW1/alYn6asj1nVO/7x+W
 /d2FMp/BimrIFGGJMpuDlsfi0PiOj7mu615xv46n0FpXNJnG+TgPKeLEe
 abLzctQCvKYoZTIdfHoCPQUrjfxUs4XE2mJdL6YU+pGdNhdSNs929+TKd
 uZ3h6Rr+HUy7dbIOtyBHXcC8Us5nEoShflLD50aeQ7t8xGENzTsIr4TiU A==;
X-CSE-ConnectionGUID: qqa/ppI1ROeUiHMltOdKCg==
X-CSE-MsgGUID: IFGID+qQRL+UScgQwZ7jDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="65174409"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="65174409"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 20:36:23 -0700
X-CSE-ConnectionGUID: lCaKBnL3RNibAjjbNSTCxQ==
X-CSE-MsgGUID: RAAgeyYhTQiVw7BlYlLKTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="158533898"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 20:36:20 -0700
Message-ID: <83c1bd59-8e61-4585-b68e-ba9de57c749c@intel.com>
Date: Thu, 3 Jul 2025 11:36:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] Re: [PULL 35/35] qom: reverse order of
 instance_post_init calls
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Dongli Zhang <dongli.zhang@oracle.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Like Xu <like.xu.linux@gmail.com>, Igor Mammedov <imammedo@redhat.com>
References: <aFpocfTpBLB34N3l@intel.com> <aGKryLSGlFTMSKHv@intel.com>
 <690b5bca-4345-4ee9-a332-4c2e38532309@intel.com>
 <31387ca1-4fa0-482e-8e11-e8857c10cb6c@linaro.org>
 <aGTmFGC9vZB2yEwv@intel.com> <76f8e877-e203-421f-b301-4b321534bd8b@intel.com>
 <CABgObfY-sDqw3kPSgr8b3OycA2wZVYQLcxcavierdbr-U0S_Dw@mail.gmail.com>
 <f7545434-f51f-4cb5-b1b9-afbaa26d11e8@intel.com>
 <CABgObfax21xZDKGN9b8tH-HBVeEgTjWD-xLO6DRkr3uCvkyHQQ@mail.gmail.com>
 <a7d2691b-ce43-454e-aec9-3589787dea5c@intel.com> <aGX0Im2F6R4nTUh4@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aGX0Im2F6R4nTUh4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/3/2025 11:08 AM, Zhao Liu wrote:
> On Thu, Jul 03, 2025 at 09:03:10AM +0800, Xiaoyao Li wrote:
>> Date: Thu, 3 Jul 2025 09:03:10 +0800
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: Re: [Regression] Re: [PULL 35/35] qom: reverse order of
>>   instance_post_init calls
>>
>> On 7/3/2025 2:54 AM, Paolo Bonzini wrote:
>>> Il mer 2 lug 2025, 09:25 Xiaoyao Li <xiaoyao.li@intel.com> ha scritto:
>>>
>>>> IIRC that's on rhel QEMU which ports the TDX code before it's merged
>>>> upstream. Now TDX is upstreamed, it works with upstream compat property
>>>> and I think future new compat property won't affect TDX or anything,
>>>> since it's compat property and it's to guarantee the existing behavior
>>>> when introducing new behavior?
>>>>
>>>
>>> It's a compat property that is only added by RHEL-specific machine types.
>>> But the bug is not specific to RHEL, it just happens that no upstream
>>> machine type has compat properties that overlap with TDX adjustments of
>>> CPUID.
>>>
>>>> In general I don't see how the reverse order makes sense: the subclass
>>>>> knows what the superclass does, so it can do the right thing if it runs
>>>>> last; but the superclass cannot know what all of its subclasses do in
>>>>> post_init, so it makes less sense to run it last.
>>>>
>>>> I agree in general the parent to child order makes more sense,
>>>> especially when we treat .instance_init() as the phase 1 init and
>>>> .post_instance_init() as the phase 2 init.
>>>>
>>>> But the original purpose of introducing .post_instance_init() was to
>>>> ensure qdev_prop_set_globals() is called at last for Device. Reverse the
>>>> order breaks this purpose.
>>>>
>>>
>>> Not "last", but "after instance_init". Anything that happens in the child
>>> class's instance_post_init can be moved at the end of instance_init, just
>>> like the refactoring that I did for risc-v.
>>
>> Move into the end of instance_init() can surely work. But it requires to
>> split the code in instance_post_init() to different child's instance_init()
>> or making sure the code in instance_post_init() is called at the end of each
>> lowest child class.
> 
> Initially, when I proposed the split approach, it wasn't about
> splitting for the sake of splitting, nor for the sake of "work".
> 
> A more granular split is just a means, and the goal is to place things
> at different stages in the most appropriate locations.
> 
>> Besides, it also leads to a rule that child of Device's
>> .post_instance_init() needs to be careful about changing the property or
>> anything that might affect the property,
> 
> I believe that's how things should be. instance_post_init() provides an
> opportunity to tweak properties. The order of instance_post_init()
> reflects the dependency relationships for property adjustments. As I
> mentioned earlier, if a property doesn't need to consider other factors
> and is simply being initialized, instance_init() is the most appropriate
> place for it.

The reason why accelerator's instance_init() was moved to post_init, was 
just it needs to consider other factors. Please see commit 4db4385a7ab6 
("i386: run accel_cpu_instance_init as post_init")

accelerator needs to do different tweak for "max/host", "xcc->model".

Of course we can split it and put specific handling at the end of each 
sub-class's instance_init(), like below:

- in TYPE_X86_CPU instance_init()
	
	if (accelerator_kvm) {
		kvm_instance_init_common_for_x86_cpu();
	}

- in "base" instance_init()

	if (accelerator_kvm) {
		kvm_instance_init_for_base();
	}

- in "max" instance_init()

	if (accelerator_kvm) {
		kvm_instance_init_for_max();
	}

- in "host" instance_init()

	if (accelerator_kvm) {
		kvm_instance_init_for_host();
	}

- in "named cpu model" instance_init()

	if (xcc->model)	{
		kvm_instance_init_for_xcc_model();
	}

Contrast to the current implementation in post_init()

	if (accelerator_kvm) {
		kvm_instance_init_common_for_x86_cpu();

		if (base)
			...
		if (max)
			...
		if (host)
			...
		if (xcc->model)
			...
	}

The reality for the former might be simpler since "base" doesn't have 
instance_init(), and "max/host" are same to KVM as "cpu->max_features"

But I still like the latter.



