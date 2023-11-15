Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D0E7E9782
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 09:21:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2SBd-0005U1-Io; Mon, 13 Nov 2023 03:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterz@infradead.org>)
 id 1r2SBa-0005SB-Su
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 03:20:47 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterz@infradead.org>)
 id 1r2SBY-00081Q-JR
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 03:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=Vb6yF7Z1sBKdQY3wavT2xUDJmLu+GkW+0ySW8ghKdVA=; b=RGky/CDnkLKlTSPAu++ti06E7l
 ILAUJR6hOpprntlymw3H+pU19GgkD0k1AUHCUWsxWBB7DQLk2U3onnfv7tU0IvtJuqH7gVIbjzW44
 WRF4easbIOX+MURmTMUl5+yu0wP15LgXAhCBZKbxOp3tw7tJze4Faipi4nqb0Hme2XuwcGRMtyy+w
 vX5z+JZhNdp44hFpuTi6awZzlLxAkrlGP3IjFQLEEojz22KpxKrjdzbTI3NxR325ZnWyFWhASqy+j
 gn046ayl+YKyRr/4FsS5rohaCBgXJ2lq9X/B7+vjVBFdpVffo6jg/ruojCZv+GsGEKWKyXXDF7yJv
 Y9vMTtnA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1r2SAL-00D6tb-Gh; Mon, 13 Nov 2023 08:19:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
 id D372F300427; Mon, 13 Nov 2023 09:19:29 +0100 (CET)
Date: Mon, 13 Nov 2023 09:19:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Kees Cook <keescook@chromium.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>,
 Alexander Graf <graf@amazon.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 Forrest Yuan Yu <yuanyu@google.com>, James Gowans <jgowans@amazon.com>,
 James Morris <jamorris@linux.microsoft.com>,
 John Andersen <john.s.andersen@intel.com>,
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
 Marian Rotariu <marian.c.rotariu@gmail.com>,
 Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>,
 =?utf-8?B?TmljdciZb3IgQ8OuyJt1?= <nicu.citu@icloud.com>,
 Thara Gopinath <tgopinath@microsoft.com>,
 Trilok Soni <quic_tsoni@quicinc.com>, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>, Yu Zhang <yu.c.zhang@linux.intel.com>,
 Zahra Tarkhani <ztarkhani@microsoft.com>,
 =?utf-8?Q?=C8=98tefan_=C8=98icleru?= <ssicleru@bitdefender.com>,
 dev@lists.cloudhypervisor.org, kvm@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 x86@kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [RFC PATCH v2 17/19] heki: x86: Update permissions counters
 during text patching
Message-ID: <20231113081929.GA16138@noisy.programming.kicks-ass.net>
References: <20231113022326.24388-1-mic@digikod.net>
 <20231113022326.24388-18-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231113022326.24388-18-mic@digikod.net>
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=peterz@infradead.org; helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, Nov 12, 2023 at 09:23:24PM -0500, Micka�l Sala�n wrote:
> From: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
> 
> X86 uses a function called __text_poke() to modify executable code. This
> patching function is used by many features such as KProbes and FTrace.
> 
> Update the permissions counters for the text page so that write
> permissions can be temporarily established in the EPT to modify the
> instructions in that page.
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
> Cc: Micka�l Sala�n <mic@digikod.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
> ---
> 
> Changes since v1:
> * New patch
> ---
>  arch/x86/kernel/alternative.c |  5 ++++
>  arch/x86/mm/heki.c            | 49 +++++++++++++++++++++++++++++++++++
>  include/linux/heki.h          | 14 ++++++++++
>  3 files changed, 68 insertions(+)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 517ee01503be..64fd8757ba5c 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -18,6 +18,7 @@
>  #include <linux/mmu_context.h>
>  #include <linux/bsearch.h>
>  #include <linux/sync_core.h>
> +#include <linux/heki.h>
>  #include <asm/text-patching.h>
>  #include <asm/alternative.h>
>  #include <asm/sections.h>
> @@ -1801,6 +1802,7 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
>  	 */
>  	pgprot = __pgprot(pgprot_val(PAGE_KERNEL) & ~_PAGE_GLOBAL);
>  
> +	heki_text_poke_start(pages, cross_page_boundary ? 2 : 1, pgprot);
>  	/*
>  	 * The lock is not really needed, but this allows to avoid open-coding.
>  	 */
> @@ -1865,7 +1867,10 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
>  	}
>  
>  	local_irq_restore(flags);
> +
>  	pte_unmap_unlock(ptep, ptl);
> +	heki_text_poke_end(pages, cross_page_boundary ? 2 : 1, pgprot);
> +
>  	return addr;
>  }

This makes no sense, we already use a custom CR3 with userspace alias
for the actual pages to write to, why are you then frobbing permissions
on that *again* ?

