Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E69C8951E6
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Apr 2024 13:33:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcNo-0005cP-6W; Tue, 02 Apr 2024 07:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rrcNl-0005Un-0T; Tue, 02 Apr 2024 07:32:49 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rrcNB-0003zf-LA; Tue, 02 Apr 2024 07:32:48 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4A72C4E6043;
 Tue,  2 Apr 2024 13:32:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id onQHBpdBT4lX; Tue,  2 Apr 2024 13:32:03 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 09A494E6039; Tue,  2 Apr 2024 13:32:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 06656745708;
 Tue,  2 Apr 2024 13:32:03 +0200 (CEST)
Date: Tue, 2 Apr 2024 13:32:02 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org
cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: TCG change broke MorphOS boot on sam460ex
In-Reply-To: <2a286d38-1fd7-d53a-d7db-e953e6aefbf2@eik.bme.hu>
Message-ID: <3386e6ec-9b87-fa01-9bf0-967a362bf90a@eik.bme.hu>
References: <fe59ceb1-e8cd-f488-d6f0-6372923a8a33@eik.bme.hu>
 <48e5e0b8-9b0a-4c9f-9f3e-c30e2fddc502@linaro.org>
 <2a286d38-1fd7-d53a-d7db-e953e6aefbf2@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2066289844-1712057523=:5716"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2066289844-1712057523=:5716
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 21 Mar 2024, BALATON Zoltan wrote:
> On 27/2/24 17:47, BALATON Zoltan wrote:
>> Hello,
>> 
>> Commit 18a536f1f8 (accel/tcg: Always require can_do_io) broke booting 
>> MorphOS on sam460ex (this was before 8.2.0 and I thought I've verified it 
>> before that release but apparently missed it back then). It can be 
>> reproduced with https://www.morphos-team.net/morphos-3.18.iso and following 
>> command:
>> 
>> qemu-system-ppc -M sam460ex -serial stdio -d unimp,guest_errors \
>>    -drive if=none,id=cd,format=raw,file=morphos-3.18.iso \
>>    -device ide-cd,drive=cd,bus=ide.1

Any idea on this one? While MorphOS boots on other machines and other OSes 
seem to boot on this machine it may still suggest there's some problem 
somewhere as this worked before. So it may worth investigating it to make 
sure there's no bug that could affect other OSes too even if they boot. I 
don't know how to debug this so some help would be needed.

Regards,
BALATON Zoltan

> Although it breaks at the TCG change it may also be related to tlbwe changes 
> somehow but I don't really understand it. I've tried to get some more debug 
> info in case somebody can tell what's happening. With 18a536f1f8^ (the commit 
> before the one it broke at and still works) I get:
>
> ----------------
> IN:
> ppcemb_tlb_check: TLB 0 address 00c01000 PID 0 <=> f0000000 f0000000 0 7f
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 1 address 00c01000 PID 0 <=> d0000000 f0000000 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 2 address 00c01000 PID 0 <=> 80000000 f0000000 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 3 address 00c01000 PID 0 <=> 90000000 f0000000 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 4 address 00c01000 PID 0 <=> a0000000 f0000000 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 5 address 00c01000 PID 0 <=> b0000000 f0000000 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 6 address 00c01000 PID 0 <=> c0000000 f0000000 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 7 address 00c01000 PID 0 <=> e0000000 ff000000 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 8 address 00c01000 PID 0 <=> e1000000 ff000000 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 9 address 00c01000 PID 0 <=> e3000000 fffffc00 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 10 address 00c01000 PID 0 <=> e3001000 fffffc00 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 11 address 00c01000 PID 0 <=> e4000000 ffffc000 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 12 address 00c01000 PID 0 <=> e5000000 fff00000 0 7f
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 13 address 00c01000 PID 0 <=> ef000000 ff000000 0 7f
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 14 address 00c01000 PID 0 <=> e2000000 fff00000 0 7f
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 15 address 00c01000 PID 0 <=> 00000000 f0000000 0 7f
> mmubooke_check_tlb: good TLB!
> mmubooke_get_physical_address: access granted 00c01000 => 0000000000c01000 7 
> 0
> 0x00c01354:  38c00040  li       r6, 0x40
> 0x00c01358:  38e10204  addi     r7, r1, 0x204
> 0x00c0135c:  39010104  addi     r8, r1, 0x104
> 0x00c01360:  39410004  addi     r10, r1, 4
> 0x00c01364:  39200000  li       r9, 0
> 0x00c01368:  7cc903a6  mtctr    r6
> 0x00c0136c:  84c70004  lwzu     r6, 4(r7)
> 0x00c01370:  7cc907a4  tlbwehi  r6, r9
> 0x00c01374:  84c80004  lwzu     r6, 4(r8)
> 0x00c01378:  7cc90fa4  tlbwelo  r6, r9
> 0x00c0137c:  84ca0004  lwzu     r6, 4(r10)
> 0x00c01380:  7cc917a4  tlbwehi  r6, r9
> 0x00c01384:  39290001  addi     r9, r9, 1
> 0x00c01388:  4200ffe4  bdnz     0xc0136c
>
> helper_440_tlbwe word 0 entry 0 value 00000290
> ppcemb_tlb_check: TLB 0 address 0df6bfb0 PID 0 <=> 00000000 f0000000 0 7f
> mmubooke_check_tlb: good TLB!
> mmubooke_get_physical_address: access granted 0df6bfb0 => 00000004fdf6bfb0 7 
> 0
> Invalid read at addr 0x4FDF6BFB0, size 4, region '(null)', reason: rejected
> helper_440_tlbwe word 1 entry 0 value 00000000
> ppcemb_tlb_check: TLB 0 address 0df6beb0 PID 0 <=> 00000000 f0000000 0 7f
> mmubooke_check_tlb: good TLB!
> mmubooke_get_physical_address: access granted 0df6beb0 => 000000000df6beb0 7 
> 0
> helper_440_tlbwe word 2 entry 0 value 0000003f
> ppcemb_tlb_check: TLB 0 address 00c0136c PID 0 <=> 00000000 f0000000 0 7f
> mmubooke_check_tlb: good TLB!
> mmubooke_get_physical_address: access granted 00c0136c => 0000000000c0136c 7 
> 0
> ----------------
>
> and with commit 18a536f1f8 this changes to
>
> ----------------
> IN:
> ppcemb_tlb_check: TLB 0 address 00c01000 PID 0 <=> f0000000 f0000000 0 7f
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 1 address 00c01000 PID 0 <=> d0000000 f0000000 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 2 address 00c01000 PID 0 <=> 80000000 f0000000 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 3 address 00c01000 PID 0 <=> 90000000 f0000000 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 4 address 00c01000 PID 0 <=> a0000000 f0000000 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 5 address 00c01000 PID 0 <=> b0000000 f0000000 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 6 address 00c01000 PID 0 <=> c0000000 f0000000 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 7 address 00c01000 PID 0 <=> e0000000 ff000000 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 8 address 00c01000 PID 0 <=> e1000000 ff000000 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 9 address 00c01000 PID 0 <=> e3000000 fffffc00 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 10 address 00c01000 PID 0 <=> e3001000 fffffc00 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 11 address 00c01000 PID 0 <=> e4000000 ffffc000 0 3b
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 12 address 00c01000 PID 0 <=> e5000000 fff00000 0 7f
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 13 address 00c01000 PID 0 <=> ef000000 ff000000 0 7f
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 14 address 00c01000 PID 0 <=> e2000000 fff00000 0 7f
> mmubooke_check_tlb: TLB entry not found
> ppcemb_tlb_check: TLB 15 address 00c01000 PID 0 <=> 00000000 f0000000 0 7f
> mmubooke_check_tlb: good TLB!
> mmubooke_get_physical_address: access granted 00c01000 => 0000000000c01000 7 
> 0
> 0x00c01354:  38c00040  li       r6, 0x40
> 0x00c01358:  38e10204  addi     r7, r1, 0x204
> 0x00c0135c:  39010104  addi     r8, r1, 0x104
> 0x00c01360:  39410004  addi     r10, r1, 4
> 0x00c01364:  39200000  li       r9, 0
> 0x00c01368:  7cc903a6  mtctr    r6
> 0x00c0136c:  84c70004  lwzu     r6, 4(r7)
> 0x00c01370:  7cc907a4  tlbwehi  r6, r9
> 0x00c01374:  84c80004  lwzu     r6, 4(r8)
> 0x00c01378:  7cc90fa4  tlbwelo  r6, r9
> 0x00c0137c:  84ca0004  lwzu     r6, 4(r10)
> 0x00c01380:  7cc917a4  tlbwehi  r6, r9
> 0x00c01384:  39290001  addi     r9, r9, 1
> 0x00c01388:  4200ffe4  bdnz     0xc0136c
>
> helper_440_tlbwe word 0 entry 0 value 00000290
> ppcemb_tlb_check: TLB 0 address 0df6bfb0 PID 0 <=> 00000000 f0000000 0 7f
> mmubooke_check_tlb: good TLB!
> mmubooke_get_physical_address: access granted 0df6bfb0 => 00000004fdf6bfb0 7 
> 0
> ppcemb_tlb_check: TLB 0 address 00c01374 PID 0 <=> 00000000 f0000000 0 7f
> mmubooke_check_tlb: good TLB!
> mmubooke_get_physical_address: access granted 00c01374 => 00000004f0c01374 7 
> 0
> Invalid read at addr 0x4F0C01374, size 4, region '(null)', reason: rejected
> invalid/unsupported opcode: 00 - 00 - 00 - 00 (00000000) 00c01374
> ----------------
>
> Any idea?
>
> Regards,
> BALATON Zoltan
--3866299591-2066289844-1712057523=:5716--

