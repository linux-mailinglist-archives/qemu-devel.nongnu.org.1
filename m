Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D8B73F4CB
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 08:48:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE2Tf-0005id-Cg; Tue, 27 Jun 2023 02:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qE2Tc-0005iP-Ky
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 02:47:00 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qE2Ta-0000ka-Pi
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 02:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:References:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zGVNbCEgWXttzElrvU/OXi/u10uIXmfia4NH6NikXNU=; b=rnFGPkGwrDvqSgIYqgHG80A8a4
 LwvIyxa2IwaAz0eUsL3+HgiOAZU4hWEVDvvx4cVPYfM1wf0FGX6zF2urxrvVbnjGWg791CQ6Rlb0A
 HQETxAqmgfAvyyfsOODoH+41vlz/Pbx8NdLf7zxxpsPksNnpWOGqFGG88tUcX/e5XEZbPqFoijNjP
 kCowJjQteJJM1Z/MlqXLlsq8JQSELYM0aXR9qg2LeJtvEb9QLZbYsaanq3T9Zkex6rzjm08CE+oO0
 tKHS4oLvb6ZMeMvVyMC6fnv/DZ8U3Bdqxh0wRPnvQcQzqYWJUmphCzKkj/bY0/Y/nY53pGsf5oq6I
 Kmxx8X7dkkxk+7cNlgwnioepb7OXT30Lg0n3XLsY+YTt+ufT9XQ1MB0+4ocPBHjDFVvKJjhSPN9rr
 r44amc0YEFRKS3TAskTMbhlf6eEThlp5Y/a4dMqfIcYU8ylouGUnYQQf5Hy7VAYLmVaFz4Kg7YGae
 NkDdn321Y9r5F/uERcIWOoP5e9laP3CWNQlE2/EmtJ/a5QsLyHYRyoa5bx4h6qe/XHdgkxDNC9DI9
 Ie26p7+voUmkQKeAtqBbZQXIjkuLC2Wzsj6E0WX26VLB6ZT7cqwWrULerDE7PTseMcBqkmjziVhNA
 PNnLHlrU84MsqJZF1sIvyxgUYxsJdq7JjEv2dUPTA=;
Received: from [2a00:23c4:8bad:df00:f732:dd76:7417:d15b]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qE2TL-00021K-18; Tue, 27 Jun 2023 07:46:47 +0100
Message-ID: <c83c2500-08d1-bb03-24d6-990a2f07b01b@ilande.co.uk>
Date: Tue, 27 Jun 2023 07:46:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230621180607.1516336-1-richard.henderson@linaro.org>
 <2f11ee14-9bf2-85fe-581c-e3024efd2124@ilande.co.uk>
In-Reply-To: <2f11ee14-9bf2-85fe-581c-e3024efd2124@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bad:df00:f732:dd76:7417:d15b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 0/8] target/sparc: Use tcg_gen_lookup_and_goto_ptr
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 22/06/2023 13:26, Mark Cave-Ayland wrote:

> On 21/06/2023 19:05, Richard Henderson wrote:
> 
>> Changes from v1:
>>    * Split into teeny weeny pieces.
>>
>>    * It turns out the sparc_tr_tb_stop hunk of v1 was buggy,
>>      in that things that are not simple branches use DYNAMIC_PC,
>>      e.g. the RETT (return from trap) instruction.
>>
>>      Introduce DYNAMIC_PC_LOOKUP to distinguish the couple of
>>      places where we have a dynamic pc, but no other change
>>      of state (conditional branches, JMPL, RETURN).
>>
>>    * Drop the change for WRFPRS, because it's too infrequent.
>>      The WRASI change affects memcpy/memset, so that's more important.
>>
>> Boots Mark's sol8 install cdrom.  :-)
>>
>> Top of the profile changes from
>>
>>      41.55%  qemu-system-sparc              [.] cpu_exec_loop
>>      14.02%  qemu-system-sparc              [.] cpu_tb_exec
>>       8.74%  qemu-system-sparc              [.] tb_lookup
>>       2.11%  qemu-system-sparc              [.] tcg_splitwx_to_rw
>>       1.63%  memfd:tcg-jit (deleted)        [.] 0x0000000000000004
>>
>> to
>>
>>      31.59%  qemu-system-sparc              [.] helper_lookup_tb_ptr
>>      17.79%  qemu-system-sparc              [.] tb_lookup
>>       5.38%  qemu-system-sparc              [.] compute_all_sub
>>       2.38%  qemu-system-sparc              [.] helper_compute_psr
>>       2.36%  qemu-system-sparc              [.] helper_check_align
>>       1.79%  memfd:tcg-jit (deleted)        [.] 0x000000000063fc8e
>>
>> This probably indicates that cpu_get_tb_cpu_state could be
>> improved to not consume so much overhead.
> 
> Nice! I've just run this through all of my sun4m/sun4u/sun4v test images and I don't 
> see any regressions with v2. The guests feel noticeably more responsive too :)
> 
> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> I've skimmed the patches and without looking in too much detail they seem to be okay 
> so I'm happy to give:
> 
> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Side note: the niagara tests require the patch at 
> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03537.html which still 
> hasn't been merged yet.
> 
>> Richard Henderson (8):
>>    target/sparc: Use tcg_gen_lookup_and_goto_ptr in gen_goto_tb
>>    target/sparc: Fix npc comparison in sparc_tr_insn_start
>>    target/sparc: Drop inline markers from translate.c
>>    target/sparc: Introduce DYNAMIC_PC_LOOKUP
>>    target/sparc: Use DYNAMIC_PC_LOOKUP for conditional branches
>>    target/sparc: Use DYNAMIC_PC_LOOKUP for JMPL
>>    target/sparc: Use DYNAMIC_PC_LOOKUP for v9 RETURN
>>    target/sparc: Use tcg_gen_lookup_and_goto_ptr for v9 WRASI
>>
>>   target/sparc/translate.c | 410 ++++++++++++++++++++++-----------------
>>   1 file changed, 233 insertions(+), 177 deletions(-)

I've just noticed during testing there is an issue with this series when used with a 
real SS-5 PROM image (I was using OpenBIOS for my previous tests) which causes it to 
assert() almost immediately on startup:

$ ./qemu-system-sparc -bios ss5.bin
ERROR:../target/sparc/translate.c:5695:sparc_tr_tb_stop: code should not be reached
Bail out! ERROR:../target/sparc/translate.c:5695:sparc_tr_tb_stop: code should not be 
reached
Aborted


ATB,

Mark.


