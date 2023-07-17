Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 286F8755ED0
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 10:56:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLK1q-0006K4-Mf; Mon, 17 Jul 2023 04:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qLK1g-0006Jf-6W; Mon, 17 Jul 2023 04:56:17 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qLK1e-0004wc-4C; Mon, 17 Jul 2023 04:56:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 755E514428;
 Mon, 17 Jul 2023 11:56:11 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 068CB151EF;
 Mon, 17 Jul 2023 11:56:10 +0300 (MSK)
Message-ID: <f6b86073-365c-3ab9-63aa-9a15cd24699b@tls.msk.ru>
Date: Mon, 17 Jul 2023 11:56:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tcg/ppc: Fix race in goto_tb implementation
Content-Language: en-US
To: Jordan Niethe <jniethe5@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, dbarboza@ventanamicro.com, npiggin@gmail.com,
 anushree.mathur@linux.vnet.ibm.com, clg@kaod.org, bgray@linux.ibm.com
References: <20230717012327.20149-1-jniethe5@gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230717012327.20149-1-jniethe5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

17.07.2023 04:23, Jordan Niethe wrote:
> Commit 20b6643324 ("tcg/ppc: Reorg goto_tb implementation") modified
> goto_tb to ensure only a single instruction was patched to prevent
> incorrect behaviour if a thread was in the middle of multiple
> instructions when they were replaced. However this introduced a race
> between loading the jmp target into TCG_REG_TB and patching and
> executing the direct branch.
> 
> The relevent part of the goto_tb implementation:
> 
>      ld TCG_REG_TB, TARGET_ADDR_LOCATION(TCG_REG_TB)
>    patch_location:
>      mtctr TCG_REG_TB
>      bctr
> 
> tb_target_set_jmp_target() will replace 'patch_location' with a direct
> branch if the target is in range. The direct branch now relies on
> TCG_REG_TB being set up correctly by the ld. Prior to this commit
> multiple instructions were patched in for the direct branch case; these
> instructions would initalise TCG_REG_TB to the same value as the branch
> target.
> 
> Imagine the following sequence:
> 
> 1) Thread A is executing the goto_tb sequence and loads the jmp
>     target into TCG_REG_TB.
> 
> 2) Thread B updates the jmp target address and calls
>     tb_target_set_jmp_target(). This patches a new direct branch into the
>     goto_tb sequence.
> 
> 3) Thread A executes the newly patched direct branch. The value in
>     TCG_REG_TB still contains the old jmp target.
> 
> TCG_REG_TB MUST contain the translation block's tc.ptr. Execution will
> eventually crash after performing memory accesses generated from a
> faulty value in TCG_REG_TB.
> 
> This presents as segfaults or illegal instruction exceptions.
> 
> Do not revert commit 20b6643324 as it did fix a different race
> condition. Instead remove the direct branch optimization and always use
> indirect branches.
> 
> The direct branch optimization can be re-added later with a race free
> sequence.
> 
> Gitlab issue: https://gitlab.com/qemu-project/qemu/-/issues/1726

I confirm this fixes the issue hit by debian as well, - 30 runs in
a row already with this patch and counting, while before it failed
almost reliable on first try, sometimes on 2nd.

Tested-by: Michael Tokarev <mjt@tls.msk.ru>

(this is max I can do, as I don't know tcg at all :) )

Thank you very much for the fix!

/mjt

> @@ -2565,10 +2564,11 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
>       intptr_t diff = addr - jmp_rx;
>       tcg_insn_unit insn;
>   
> +    if (USE_REG_TB)
> +        return;
> +
>       if (in_range_b(diff)) {
>           insn = B | (diff & 0x3fffffc);



