Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2075860942
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Feb 2024 04:14:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdM05-0004jL-18; Thu, 22 Feb 2024 22:13:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1rdM03-0004jB-2k
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:13:23 -0500
Received: from mx2.zhaoxin.com ([203.110.167.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1rdM00-0002Sx-Ei
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:13:22 -0500
X-ASG-Debug-ID: 1708657989-1eb14e0c7e46ae0001-jgbH7p
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by
 mx2.zhaoxin.com with ESMTP id G3D2oEORI4UkFBrN (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Fri, 23 Feb 2024 11:13:09 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 23 Feb
 2024 11:13:09 +0800
Received: from [10.28.66.62] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 23 Feb
 2024 11:13:08 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <c6e96802-4f68-4ba2-aa24-0a68ca412024@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.28.66.62
Date: Thu, 22 Feb 2024 22:13:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/i386/kvm: Refine VMX controls setting for
 backward compatibility
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
X-ASG-Orig-Subj: Re: [PATCH v2] target/i386/kvm: Refine VMX controls setting
 for backward compatibility
To: Xiaoyao Li <xiaoyao.li@intel.com>, <pbonzini@redhat.com>,
 <mtosatti@redhat.com>, <kvm@vger.kernel.org>, <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, <cobechen@zhaoxin.com>, <ewanhai@zhaoxin.com>
References: <20231127034326.257596-1-ewanhai-oc@zhaoxin.com>
 <b041fdb3-5b08-4a85-913a-ebb3c7dfbe1d@intel.com>
 <3cf7eac6-0a95-46dd-81b0-0ac12735349b@zhaoxin.com>
Content-Language: en-US
In-Reply-To: <3cf7eac6-0a95-46dd-81b0-0ac12735349b@zhaoxin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1708657989
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3157
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.121203
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=203.110.167.99;
 envelope-from=EwanHai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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



On 2/20/24 06:07, Ewan Hai wrote:
> On 2/20/24 03:32, Xiaoyao Li wrote:
>>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>>> index 11b8177eff..c8f6c0b531 100644
>>> --- a/target/i386/kvm/kvm.c
>>> +++ b/target/i386/kvm/kvm.c
>>> @@ -2296,6 +2296,7 @@ void kvm_arch_do_init_vcpu(X86CPU *cpu)
>>>   static int kvm_get_supported_feature_msrs(KVMState *s)
>>>   {
>>>       int ret = 0;
>>> +    int i;
>>>
>>>       if (kvm_feature_msrs != NULL) {
>>>           return 0;
>>> @@ -2330,6 +2331,19 @@ static int 
>>> kvm_get_supported_feature_msrs(KVMState *s)
>>>           return ret;
>>>       }
>>>
>>> +    /*
>>> +     * Compatibility fix:
>>> +     * Older Linux kernels(<5.3) include the 
>>> MSR_IA32_VMX_PROCBASED_CTLS2
>>
>> we can be more accurate, that kernel version 4.17 to 5.2, reports
>> MSR_IA32_VMX_PROCBASED_CTLS2 in KVM_GET_MSR_FEATURE_INDEX_LIST but not
>> KVM_GET_MSR_INDEX_LIST.
>>
> Yeah, I'll add this more precise comment to the next patch.
>>> +     * only in feature msr list, but not in regular msr list. This 
>>> lead to
>>> +     * an issue in older kernel versions where QEMU, through the 
>>> regular
>>> +     * MSR list check, assumes the kernel doesn't maintain this msr,
>>> +     * resulting in incorrect settings by QEMU for this msr.
>>> +     */
>>> +    for (i = 0; i < kvm_feature_msrs->nmsrs; i++) {
>>> +        if (kvm_feature_msrs->indices[i] == 
>>> MSR_IA32_VMX_PROCBASED_CTLS2) {
>>> +            has_msr_vmx_procbased_ctls2 = true;
>>> +        }
>>> +    }
>>
>> I'm wondering should we move all the initialization of has_msr_*, that
>> associated with feature MSRs, to here. e.g., has_msr_arch_capabs,
>> has_msr_vmx_vmfunc,...
>>
> I believe this is a more elegant way to fix the issue, which will be 
> reflected in my next patch.
When attempting to move the detection logic for feature MSRs (currently
including VMX_VMFUNC, UCODE_REV, ARCH_CAPABILITIES,
PROCBASED_CTLS2) from kvm_get_supported_msrs to
kvm_get_supported_feature_msrs in the current QEMU,
I encountered an "error: failed to set MSR 0x491 to 0x***" on kernel 
4.19.67.
This issue is due to commit 27c42a1bb ("KVM: nVMX: Enable VMFUNC for
the L1 hypervisor", 2017-08-03) exposing VMFUNC to the QEMU guest
without corresponding VMFUNC MSR modification code, leading to an error
when QEMU proactively tries to set the VMFUNC MSR. This bug affects kernels
from 4.14 to 5.2, with a fix introduced in 5.3 by Paolo (e8a70bd4e ("KVM:
nVMX: allow setting the VMFUNC controls MSR", 2019-07-02)).

Therefore, even if we were to move all feature MSRs to
kvm_get_supported_feature_msrs,VMX_VMFUNC could not be moved due to
the need to maintain compatibility with different kernel versions. This
exception makes our move less elegant. Hence, I am wondering whether we
need to move all feature MSRs to kvm_get_supported_feature_msrs. Perhaps
we just need to simply move PROCBASED_CTLS2 to fix the "failed set 0x48b 
..."
type of bugs, and add a comment about it?



