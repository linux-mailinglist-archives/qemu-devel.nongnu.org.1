Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 960D7A9820B
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Apr 2025 10:01:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7V2D-0000v9-Ai; Wed, 23 Apr 2025 04:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u7V2A-0000u8-9a
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 04:00:42 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u7V27-0005e1-3M
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 04:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745395239; x=1776931239;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=DIVsRo5Vp1MPCiO30FsW3DWSH0sxANFdHXeL/mukb38=;
 b=IMCP5AZtFECx7GzPjosRDYUUEa3Eu6Q+VjkMmPibKSRMxmgSbwnwwEfe
 ce83BaPqX2dnizxKws8v5GQgaFXlRBKNFRBXI1e+4x+wD7++U8BlYLrhy
 uvDn/p0N2NQdqz+wcmaUkdvYUyIdyA5poCAGqpa2ozAESj7esbh/HlM8k
 IFGSzwMM8hqk50HhLgwojtgQJYk4nvhFkTPTs/5o7Tf1TugDwi3CSEp7W
 XmVw7LKIGUOP+dbirDuzydEZ0hd92NkFYbuvdfxRAf8Fh9UFNlk9MmYDV
 pqFlJDuGVMKPda7XDfvagHEG/EAz3YCPUAWisUP3JihzHB64F2U8e4PbK w==;
X-CSE-ConnectionGUID: cwUsbLGCTzyaUlK71dh2pA==
X-CSE-MsgGUID: 6CqAYHVxQMCtkfkJW4r2/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="50806278"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="50806278"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 01:00:36 -0700
X-CSE-ConnectionGUID: YRsH/AXiQ/6A1+iy/cqUbQ==
X-CSE-MsgGUID: 9l0+wQbaQ1e3igJMjgpeww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="137111565"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 01:00:33 -0700
Message-ID: <dd516742-ceae-44a4-8f80-23f7c73e596f@intel.com>
Date: Wed, 23 Apr 2025 16:00:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/55] i386/tdx: Initialize TDX before creating TD vcpus
To: Zhao Liu <zhao1.liu@intel.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-9-xiaoyao.li@intel.com> <Z-0iV-xIeu0hoaaC@redhat.com>
 <54c19255-0b05-4f50-83a5-256567724df4@intel.com> <aAe27bMcwIwpDB6m@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aAe27bMcwIwpDB6m@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 4/22/2025 11:34 PM, Zhao Liu wrote:
>>>> +int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>>>> +{
>>>> +    X86CPU *x86cpu = X86_CPU(cpu);
>>>> +    CPUX86State *env = &x86cpu->env;
>>>> +    g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
>>>> +    Error *local_err = NULL;
>>>> +    int retry = 10000;
>>>> +    int r = 0;
>>>> +
>>>> +    QEMU_LOCK_GUARD(&tdx_guest->lock);
>>>> +    if (tdx_guest->initialized) {
>>>> +        return r;
>>>> +    }
>>>> +
>>>> +    init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
>>>> +                        sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
>>>> +
>>>> +    r = setup_td_xfam(x86cpu, errp);
>>>> +    if (r) {
>>>> +        return r;
>>>> +    }
>>>> +
>>>> +    init_vm->cpuid.nent = kvm_x86_build_cpuid(env, init_vm->cpuid.entries, 0);
>>>> +    tdx_filter_cpuid(&init_vm->cpuid);
>>>> +
>>>> +    init_vm->attributes = tdx_guest->attributes;
>>>> +    init_vm->xfam = tdx_guest->xfam;
>>>> +
>>>> +    /*
>>>> +     * KVM_TDX_INIT_VM gets -EAGAIN when KVM side SEAMCALL(TDH_MNG_CREATE)
>>>> +     * gets TDX_RND_NO_ENTROPY due to Random number generation (e.g., RDRAND or
>>>> +     * RDSEED) is busy.
>>>> +     *
>>>> +     * Retry for the case.
>>>> +     */
>>>> +    do {
>>>> +        error_free(local_err);
>>>> +        local_err = NULL;
>>>> +        r = tdx_vm_ioctl(KVM_TDX_INIT_VM, 0, init_vm, &local_err);
>>>> +    } while (r == -EAGAIN && --retry);
>>>> +
>>>> +    if (r < 0) {
>>>> +        if (!retry) {
>>>> +            error_report("Hardware RNG (Random Number Generator) is busy "
>>>> +                         "occupied by someone (via RDRAND/RDSEED) maliciously, "
>>>> +                         "which leads to KVM_TDX_INIT_VM keeping failure "
>>>> +                         "due to lack of entropy.");
>>>
>>> This needs to be
>>>
>>>        error_append_hint(local_err, ....);
>>>
>>> so that this message gets associated with the error object that
>>> is propagated, and the top level will print it all at once.
>>
>> Good suggestion! Will change to it in the next version.
> 
> A little suggestion:
> 
> With error_append_hint(local_err, ...), you can add "ERRP_GUARD()" at
> the beginning of tdx_pre_create_vcpu(), just like the commit 95e9053a34ca.

I don't think ERRP_GUARD() is needed.

ERRP_GUARD() is used to guard @errp, while here error_append_hint() is 
used on @local_err.


