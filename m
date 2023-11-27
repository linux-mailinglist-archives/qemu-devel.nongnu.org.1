Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BD67FA6D8
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 17:49:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7emk-0006pE-Aq; Mon, 27 Nov 2023 11:48:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <madvenka@linux.microsoft.com>)
 id 1r7emi-0006p6-Ol
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 11:48:36 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <madvenka@linux.microsoft.com>) id 1r7emh-00018T-12
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 11:48:36 -0500
Received: from [192.168.4.26] (unknown [47.186.13.91])
 by linux.microsoft.com (Postfix) with ESMTPSA id 862F420B74C0;
 Mon, 27 Nov 2023 08:48:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 862F420B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1701103712;
 bh=jeMkp5Q+EKa19c6aqn2EEeUT1WIFRK1lWII/T1Aq+rQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aDtpsQCv5Z7lrnyBfZDtXIQ5YkOeXU+eDniqpgG5DSD+i9xBYSIgXtJO6yM/hN7oZ
 EiQi/S+Yjy2TnSaq8aWFJwrDCDQJ4E01iXdFLG0uIDqHbnx9CwBuz6XIqHOPh2NLet
 Jzp9sNlniTRePSjgypI8ZiHOZ0a54xSepS+7ZLF8=
Message-ID: <a52d8885-43cc-4a4e-bb47-9a800070779e@linux.microsoft.com>
Date: Mon, 27 Nov 2023 10:48:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 17/19] heki: x86: Update permissions counters
 during text patching
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>,
 Alexander Graf <graf@amazon.com>, Chao Peng <chao.p.peng@linux.intel.com>,
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
From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
In-Reply-To: <20231113081929.GA16138@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=madvenka@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

Apologies for the late reply. I was on vacation. Please see my response below:

On 11/13/23 02:19, Peter Zijlstra wrote:
> On Sun, Nov 12, 2023 at 09:23:24PM -0500, Mickaël Salaün wrote:
>> From: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
>>
>> X86 uses a function called __text_poke() to modify executable code. This
>> patching function is used by many features such as KProbes and FTrace.
>>
>> Update the permissions counters for the text page so that write
>> permissions can be temporarily established in the EPT to modify the
>> instructions in that page.
>>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: H. Peter Anvin <hpa@zytor.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
>> Cc: Mickaël Salaün <mic@digikod.net>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Sean Christopherson <seanjc@google.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Cc: Wanpeng Li <wanpengli@tencent.com>
>> Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
>> ---
>>
>> Changes since v1:
>> * New patch
>> ---
>>  arch/x86/kernel/alternative.c |  5 ++++
>>  arch/x86/mm/heki.c            | 49 +++++++++++++++++++++++++++++++++++
>>  include/linux/heki.h          | 14 ++++++++++
>>  3 files changed, 68 insertions(+)
>>
>> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
>> index 517ee01503be..64fd8757ba5c 100644
>> --- a/arch/x86/kernel/alternative.c
>> +++ b/arch/x86/kernel/alternative.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/mmu_context.h>
>>  #include <linux/bsearch.h>
>>  #include <linux/sync_core.h>
>> +#include <linux/heki.h>
>>  #include <asm/text-patching.h>
>>  #include <asm/alternative.h>
>>  #include <asm/sections.h>
>> @@ -1801,6 +1802,7 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
>>  	 */
>>  	pgprot = __pgprot(pgprot_val(PAGE_KERNEL) & ~_PAGE_GLOBAL);
>>  
>> +	heki_text_poke_start(pages, cross_page_boundary ? 2 : 1, pgprot);
>>  	/*
>>  	 * The lock is not really needed, but this allows to avoid open-coding.
>>  	 */
>> @@ -1865,7 +1867,10 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
>>  	}
>>  
>>  	local_irq_restore(flags);
>> +
>>  	pte_unmap_unlock(ptep, ptl);
>> +	heki_text_poke_end(pages, cross_page_boundary ? 2 : 1, pgprot);
>> +
>>  	return addr;
>>  }
> 
> This makes no sense, we already use a custom CR3 with userspace alias
> for the actual pages to write to, why are you then frobbing permissions
> on that *again* ?

Today, the permissions for a guest page in the extended page table (EPT) are RWX (unless permissions are
restricted for some specific reason like for shadow page table pages). In this Heki feature, we don't allow
RWX by default in the EPT. We only allow those permissions in the EPT that the guest page actually needs.
E.g., for a text page, it is R_X in both the guest page table and the EPT.

For text patching, the above code establishes an alternate mapping in the guest page table that is RW_ so
that the text can be patched. That needs to be reflected in the EPT so that the EPT permissions will change
from R_X to RWX. In other words, RWX is allowed only as necessary. At the end of patching, the EPT permissions
are restored to R_X.

Does that address your comment?

Madhavan

