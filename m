Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0977AAFE0
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 12:46:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjdfz-0005Y3-1d; Fri, 22 Sep 2023 06:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qjdfw-0005Xs-6R
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 06:46:20 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qjdfu-0002ob-BX
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 06:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Hv36ZLSGm+4m05APNXiowcHwuXCDuKBxbkV/j/JLZqE=; b=xkujC1o6cajS6Ndwe70BPCaMwp
 AcqG9IXajWfeINagtG6ac/QkSgJ8ilu+XIRw7K2feZ9ecHXUYovJs0HNYWpR1QGNFGqZ8Nhplx+jW
 qbWmaAoAq0XCFmNiBKjLjFIm2soNVdIDoEFAKjN1VGExxYEjT48b4PxLrQ7m7VHQlF4s=;
Date: Fri, 22 Sep 2023 12:45:51 +0200
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, ale@rev.ng, richard.henderson@linaro.org, 
 pbonzini@redhat.com, philmd@linaro.org, agraf@csgraf.de, dirty@apple.com, 
 rbolshakov@ddn.com, anielhb413@gmail.com, pasic@linux.ibm.com, 
 borntraeger@linux.ibm.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bin.meng@windriver.com, ysato@users.sourceforge.jp, peter.maydell@linaro.org
Subject: Re: [PATCH 0/9] Replace remaining target_ulong in system-mode accel
Message-ID: <2c7usd46qtdk42zsvc3kpuv35f7xzfz5gw4o6egb5u4cpqhz5f@dej5s6imgnyu>
References: <20230807155706.9580-1-anjo@rev.ng>
 <b284644e-5777-f20c-bf57-3354f9724f69@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b284644e-5777-f20c-bf57-3354f9724f69@tls.msk.ru>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 21/09/23, Michael Tokarev wrote:
> 07.08.2023 18:56, Anton Johansson via wrote:
> > This patchset replaces the remaining uses of target_ulong in the accel/
> > directory.  Specifically, the address type of a few kvm/hvf functions
> > is widened to vaddr, and the address type of the cpu_[st|ld]*()
> > functions is changed to abi_ptr (which is re-typedef'd to vaddr in
> > system mode).
> > 
> > As a starting point, my goal is to be able to build cputlb.c once for
> > system mode, and this is a step in that direction by reducing the
> > target-dependence of accel/.
> > 
> > * Changes in v2:
> >      - Removed explicit target_ulong casts from 3rd and 4th patches.
> > 
> > Anton Johansson (9):
> >    accel/kvm: Widen pc/saved_insn for kvm_sw_breakpoint
> >    accel/hvf: Widen pc/saved_insn for hvf_sw_breakpoint
> >    target: Use vaddr for kvm_arch_[insert|remove]_hw_breakpoint
> >    target: Use vaddr for hvf_arch_[insert|remove]_hw_breakpoint
> >    Replace target_ulong with abi_ptr in cpu_[st|ld]*()
> >    include/exec: typedef abi_ptr to vaddr in softmmu
> >    include/exec: Widen tlb_hit/tlb_hit_page()
> >    accel/tcg: Widen address arg. in tlb_compare_set()
> >    accel/tcg: Update run_on_cpu_data static assert
> 
> Pinging a relatively old patchset, - which fixes from here needs to
> go to stable-8.1?
> 
> The context: https://lore.kernel.org/qemu-devel/20230721205827.7502-1-anjo@rev.ng/
> And according to this email:
> 
> https://lore.kernel.org/qemu-devel/00e9e08eae1004ef67fe8dca3aaf5043e6863faa.camel@gmail.com/
> 
> at least "include/exec: Widen tlb_hit/tlb_hit_page()" should go to 8.1,
> something else?
> 
> Thanks,
> 
> /mjt

If the patch above is the only one needed to fix the segfault (haven't
tested myself), pulling it in isolation is fine as it doesn't depend on 
any of the other patches.

The rest of the patches can be delayed without issue.

-- 
Anton Johansson
rev.ng Labs Srl.

