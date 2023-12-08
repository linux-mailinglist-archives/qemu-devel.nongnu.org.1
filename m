Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD7480AC50
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 19:41:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBfnE-0002N2-C4; Fri, 08 Dec 2023 13:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <madvenka@linux.microsoft.com>)
 id 1rBfnD-0002Mh-34
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 13:41:43 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <madvenka@linux.microsoft.com>) id 1rBfn7-0001Vf-K9
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 13:41:42 -0500
Received: from [192.168.4.26] (unknown [47.186.13.91])
 by linux.microsoft.com (Postfix) with ESMTPSA id B588020B74C0;
 Fri,  8 Dec 2023 10:41:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B588020B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1702060894;
 bh=AnIC6fr2QG8zWjE8bckg2NFATj2evZRXlwuerxjzhrk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YFYB3WmwcuV32c52iaz4igd8ovlIWvHBEPQVmbIZEw3i94LbeUVkav4NsxSNfPmIk
 iUXKkjZRomhyqjplJTf78F4BLpGH4vEdrl44twJ+PBdhRrhrueH+3FqPyjppZtB4ge
 /VJ2zHgNQUxArYnpRJ/nZXtyaTbYEsmb8Xq9ZQ7A=
Message-ID: <eb41ec87-8e46-4880-9d94-d86849ddadd2@linux.microsoft.com>
Date: Fri, 8 Dec 2023 12:41:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 17/19] heki: x86: Update permissions counters
 during text patching
To: Peter Zijlstra <peterz@infradead.org>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Kees Cook <keescook@chromium.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Wanpeng Li <wanpengli@tencent.com>, Alexander Graf <graf@amazon.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 Forrest Yuan Yu <yuanyu@google.com>, James Gowans <jgowans@amazon.com>,
 James Morris <jamorris@linux.microsoft.com>,
 John Andersen <john.s.andersen@intel.com>,
 Marian Rotariu <marian.c.rotariu@gmail.com>,
 =?UTF-8?Q?Mihai_Don=C8=9Bu?= <mdontu@bitdefender.com>,
 =?UTF-8?B?TmljdciZb3IgQ8OuyJt1?= <nicu.citu@icloud.com>,
 Thara Gopinath <tgopinath@microsoft.com>,
 Trilok Soni <quic_tsoni@quicinc.com>, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>, Yu Zhang <yu.c.zhang@linux.intel.com>,
 Zahra Tarkhani <ztarkhani@microsoft.com>,
 =?UTF-8?Q?=C8=98tefan_=C8=98icleru?= <ssicleru@bitdefender.com>,
 dev@lists.cloudhypervisor.org, kvm@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 x86@kernel.org, xen-devel@lists.xenproject.org
References: <20231113022326.24388-1-mic@digikod.net>
 <20231113022326.24388-18-mic@digikod.net>
 <20231113081929.GA16138@noisy.programming.kicks-ass.net>
 <a52d8885-43cc-4a4e-bb47-9a800070779e@linux.microsoft.com>
 <20231127200841.GZ3818@noisy.programming.kicks-ass.net>
 <ea63ae4e-e8ea-4fbf-9383-499e14de2f5e@linux.microsoft.com>
 <20231130113315.GE20191@noisy.programming.kicks-ass.net>
 <624a310b-c0d2-406c-a4a7-d851b3cc68f5@linux.microsoft.com>
 <20231206185134.GA9899@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
In-Reply-To: <20231206185134.GA9899@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=madvenka@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, T_SPF_HELO_TEMPERROR=0.01,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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



On 12/6/23 12:51, Peter Zijlstra wrote:
> On Wed, Dec 06, 2023 at 10:37:33AM -0600, Madhavan T. Venkataraman wrote:
>>
>>
>> On 11/30/23 05:33, Peter Zijlstra wrote:
>>> On Wed, Nov 29, 2023 at 03:07:15PM -0600, Madhavan T. Venkataraman wrote:
>>>
>>>> Kernel Lockdown
>>>> ---------------
>>>>
>>>> But, we must provide at least some security in V2. Otherwise, it is useless.
>>>>
>>>> So, we have implemented what we call a kernel lockdown. At the end of kernel
>>>> boot, Heki establishes permissions in the extended page table as mentioned
>>>> before. Also, it adds an immutable attribute for kernel text and kernel RO data.
>>>> Beyond that point, guest requests that attempt to modify permissions on any of
>>>> the immutable pages will be denied.
>>>>
>>>> This means that features like FTrace and KProbes will not work on kernel text
>>>> in V2. This is a temporary limitation. Once authentication is in place, the
>>>> limitation will go away.
>>>
>>> So either you're saying your patch 17 / text_poke is broken (so why
>>> include it ?!?) or your statement above is incorrect. Pick one.
>>>
>>
>> It has been included so that people can be aware of the changes.
>>
>> I will remove the text_poke() changes from the patchset and send it later when
>> I have some authentication in place. It will make sense then.
> 
> If you know its broken then fucking say so in the Changelog instead of
> wasting everybody's time.. OMG.

It is not broken. It addresses one part of the problem. The other part is WIP.

I am preparing a detailed response to your comments. I ask you to be patient until then. In fact, I would appreciate your input/suggestions on some problems we are trying to solve in this context. I will mention them in my response.

Madhavan


