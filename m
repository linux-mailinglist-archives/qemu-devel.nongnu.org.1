Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDEC7A9C08
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 21:05:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjOyS-0004pj-Rn; Thu, 21 Sep 2023 15:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qjOy7-0004ml-OE
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 15:04:13 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qjOy3-0007v8-VM
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 15:04:06 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3916024095;
 Thu, 21 Sep 2023 22:04:20 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CD25429D9D;
 Thu, 21 Sep 2023 22:03:57 +0300 (MSK)
Message-ID: <b284644e-5777-f20c-bf57-3354f9724f69@tls.msk.ru>
Date: Thu, 21 Sep 2023 22:03:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/9] Replace remaining target_ulong in system-mode accel
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, agraf@csgraf.de, dirty@apple.com, rbolshakov@ddn.com,
 anielhb413@gmail.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
References: <20230807155706.9580-1-anjo@rev.ng>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230807155706.9580-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

07.08.2023 18:56, Anton Johansson via wrote:
> This patchset replaces the remaining uses of target_ulong in the accel/
> directory.  Specifically, the address type of a few kvm/hvf functions
> is widened to vaddr, and the address type of the cpu_[st|ld]*()
> functions is changed to abi_ptr (which is re-typedef'd to vaddr in
> system mode).
> 
> As a starting point, my goal is to be able to build cputlb.c once for
> system mode, and this is a step in that direction by reducing the
> target-dependence of accel/.
> 
> * Changes in v2:
>      - Removed explicit target_ulong casts from 3rd and 4th patches.
> 
> Anton Johansson (9):
>    accel/kvm: Widen pc/saved_insn for kvm_sw_breakpoint
>    accel/hvf: Widen pc/saved_insn for hvf_sw_breakpoint
>    target: Use vaddr for kvm_arch_[insert|remove]_hw_breakpoint
>    target: Use vaddr for hvf_arch_[insert|remove]_hw_breakpoint
>    Replace target_ulong with abi_ptr in cpu_[st|ld]*()
>    include/exec: typedef abi_ptr to vaddr in softmmu
>    include/exec: Widen tlb_hit/tlb_hit_page()
>    accel/tcg: Widen address arg. in tlb_compare_set()
>    accel/tcg: Update run_on_cpu_data static assert

Pinging a relatively old patchset, - which fixes from here needs to
go to stable-8.1?

The context: https://lore.kernel.org/qemu-devel/20230721205827.7502-1-anjo@rev.ng/
And according to this email:

https://lore.kernel.org/qemu-devel/00e9e08eae1004ef67fe8dca3aaf5043e6863faa.camel@gmail.com/

at least "include/exec: Widen tlb_hit/tlb_hit_page()" should go to 8.1,
something else?

Thanks,

/mjt

