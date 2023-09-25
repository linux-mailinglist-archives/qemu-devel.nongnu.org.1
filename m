Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C40E17AD71E
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 13:43:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkjyy-0005dk-TL; Mon, 25 Sep 2023 07:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qkjyw-0005dN-5l
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:42:30 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qkjyt-0004cC-Ut
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cgd/ev+BmnR/w2lcJXPwYRC9PySswDgc7TBWPFhO268=; b=X5FW01/VBKwuDLnK4UQbJswBFv
 1hnq7u0iP7EekrF1bgq0WwMJC3nc5xLXuLTdQ/JBoFMkvXmu5HoiFE3scQfZwZS3ycM70xjzlmfWs
 EPW7yFdUkgbZda1qL7bHErmxTbRxA7tSDrHN9i2+AJOu/lBQ1azIKAHf2S7luQMfh5lI=;
Date: Mon, 25 Sep 2023 13:41:59 +0200
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/9] Replace remaining target_ulong in system-mode accel
Message-ID: <rsieaihh2dxc4a4ag5sbul2kvyh4zuudu7ys6dev5rrnh3ne7k@3ojxrt7jnk6k>
References: <20230807155706.9580-1-anjo@rev.ng>
 <b284644e-5777-f20c-bf57-3354f9724f69@tls.msk.ru>
 <2c7usd46qtdk42zsvc3kpuv35f7xzfz5gw4o6egb5u4cpqhz5f@dej5s6imgnyu>
 <2ea2d21c-e788-b44d-4302-b3a8f58c0e82@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ea2d21c-e788-b44d-4302-b3a8f58c0e82@tls.msk.ru>
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

On 23/09/23, Michael Tokarev wrote:
> [Trimming Cc list]
> 
> 22.09.2023 13:45, Anton Johansson:
> > On 21/09/23, Michael Tokarev wrote:
> 
> > > > Anton Johansson (9):
> > > >     accel/kvm: Widen pc/saved_insn for kvm_sw_breakpoint
> > > >     accel/hvf: Widen pc/saved_insn for hvf_sw_breakpoint
> > > >     target: Use vaddr for kvm_arch_[insert|remove]_hw_breakpoint
> > > >     target: Use vaddr for hvf_arch_[insert|remove]_hw_breakpoint
> > > >     Replace target_ulong with abi_ptr in cpu_[st|ld]*()
> > > >     include/exec: typedef abi_ptr to vaddr in softmmu
> > > >     include/exec: Widen tlb_hit/tlb_hit_page()
> > > >     accel/tcg: Widen address arg. in tlb_compare_set()
> > > >     accel/tcg: Update run_on_cpu_data static assert
> > > 
> > > Pinging a relatively old patchset, - which fixes from here needs to
> > > go to stable-8.1?
> ...
> > The rest of the patches can be delayed without issue.
> 
> Now I'm confused.  What do you mean "delayed"?
> Should the rest be picked up for 8.1.2 or 8.1.3 or maybe 8.1.4?
> 
> The whole series has been accepted/applied to master, I asked which
> changes should be picked up for stable-8.1, - there's no delay involved,
> it is either picked up or not, either needed in stable or not.
> 
> Yes, "Widen tlb_hit/tlb_hit_page()" fixes a known bug and I picked
> up that one, - unfortunately it missed 8.1.1 release.  The question
> is about the other changes in this patch set, - do they fix other
> similar, not yet discovered, bugs in other places, or not fixing
> anything? Or should we delay picking them up until a bug is reported? :)
> 
> Thank you for the changes and the reply!
> 
> /mjt

Oh I see what you mean now, thanks for the clarification!:) I'm not that 
used to think in terms of what patches end up in stable.

The other patches in this series are refactors to reduce 
target-dependence in accel/, and they do not fix any bugs directly. 
Eventually we'll need to pick them up for compiling cputlb.c once for 
system mode etc., or other patches that depend on the refactor, but they 
are not critical to get in due to fixing some bug, that's what I meant 
by "can be delayed without issue".

How do you usually deal with these types of refactor heavy changes? 
Picking asap vs delaying until absolutely needed?

Thanks again for the explanation, I hope this was of some help.

//Anton

