Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AD27ABDC7
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 06:53:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjucY-00046K-Q1; Sat, 23 Sep 2023 00:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qjucW-000462-Vb
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 00:51:56 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qjucU-0005jo-Qr
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 00:51:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 26C9124746;
 Sat, 23 Sep 2023 07:52:15 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 506DD2A2BD;
 Sat, 23 Sep 2023 07:51:50 +0300 (MSK)
Message-ID: <2ea2d21c-e788-b44d-4302-b3a8f58c0e82@tls.msk.ru>
Date: Sat, 23 Sep 2023 07:51:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/9] Replace remaining target_ulong in system-mode accel
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org
References: <20230807155706.9580-1-anjo@rev.ng>
 <b284644e-5777-f20c-bf57-3354f9724f69@tls.msk.ru>
 <2c7usd46qtdk42zsvc3kpuv35f7xzfz5gw4o6egb5u4cpqhz5f@dej5s6imgnyu>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <2c7usd46qtdk42zsvc3kpuv35f7xzfz5gw4o6egb5u4cpqhz5f@dej5s6imgnyu>
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

[Trimming Cc list]

22.09.2023 13:45, Anton Johansson:
> On 21/09/23, Michael Tokarev wrote:

>>> Anton Johansson (9):
>>>     accel/kvm: Widen pc/saved_insn for kvm_sw_breakpoint
>>>     accel/hvf: Widen pc/saved_insn for hvf_sw_breakpoint
>>>     target: Use vaddr for kvm_arch_[insert|remove]_hw_breakpoint
>>>     target: Use vaddr for hvf_arch_[insert|remove]_hw_breakpoint
>>>     Replace target_ulong with abi_ptr in cpu_[st|ld]*()
>>>     include/exec: typedef abi_ptr to vaddr in softmmu
>>>     include/exec: Widen tlb_hit/tlb_hit_page()
>>>     accel/tcg: Widen address arg. in tlb_compare_set()
>>>     accel/tcg: Update run_on_cpu_data static assert
>>
>> Pinging a relatively old patchset, - which fixes from here needs to
>> go to stable-8.1?
...
> The rest of the patches can be delayed without issue.

Now I'm confused.  What do you mean "delayed"?
Should the rest be picked up for 8.1.2 or 8.1.3 or maybe 8.1.4?

The whole series has been accepted/applied to master, I asked which
changes should be picked up for stable-8.1, - there's no delay involved,
it is either picked up or not, either needed in stable or not.

Yes, "Widen tlb_hit/tlb_hit_page()" fixes a known bug and I picked
up that one, - unfortunately it missed 8.1.1 release.  The question
is about the other changes in this patch set, - do they fix other
similar, not yet discovered, bugs in other places, or not fixing
anything? Or should we delay picking them up until a bug is reported? :)

Thank you for the changes and the reply!

/mjt

