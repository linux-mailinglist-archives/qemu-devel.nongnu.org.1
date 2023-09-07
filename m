Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A76F0797EAA
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 00:17:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeNI1-0002DX-QV; Thu, 07 Sep 2023 18:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=XW8m=EX=kaod.org=clg@ozlabs.org>)
 id 1qeNHz-0002Ch-Ea; Thu, 07 Sep 2023 18:15:51 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=XW8m=EX=kaod.org=clg@ozlabs.org>)
 id 1qeNHw-0003Qd-4G; Thu, 07 Sep 2023 18:15:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RhYTp2D3gz4x80;
 Fri,  8 Sep 2023 08:15:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RhYTm59Rbz4x5w;
 Fri,  8 Sep 2023 08:15:40 +1000 (AEST)
Message-ID: <ad943b46-0652-8fd1-49a4-c86dd6214827@kaod.org>
Date: Fri, 8 Sep 2023 00:15:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL v2 00/35] ppc queue
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20230906143653.54709-1-clg@kaod.org>
 <2b6c3dd1-430a-2e60-ea73-29c507d631d8@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <2b6c3dd1-430a-2e60-ea73-29c507d631d8@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=XW8m=EX=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.473, SPF_HELO_PASS=-0.001,
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

On 9/7/23 21:10, Michael Tokarev wrote:
> 06.09.2023 17:36, Cédric Le Goater wrote:
> ...
>> ppc queue :
>>
>> * debug facility improvements
>> * timebase and decrementer fixes
>> * record-replay fixes
>> * TCG fixes
>> * XIVE model improvements for multichip
>>
>> ----------------------------------------------------------------
>> Cédric Le Goater (4):
>>        ppc/xive: Use address_space routines to access the machine RAM
>>        ppc/xive: Introduce a new XiveRouter end_notify() handler
>>        ppc/xive: Handle END triggers between chips with MMIOs
>>        ppc/xive: Add support for the PC MMIOs
>>
>> Joel Stanley (1):
>>        ppc: Add stub implementation of TRIG SPRs
>>
>> Maksim Kostin (1):
>>        hw/ppc/e500: fix broken snapshot replay
>>
>> Nicholas Piggin (26):
>>        target/ppc: Remove single-step suppression inside 0x100-0xf00
>>        target/ppc: Improve book3s branch trace interrupt for v2.07S
>>        target/ppc: Suppress single step interrupts on rfi-type instructions
>>        target/ppc: Implement breakpoint debug facility for v2.07S
>>        target/ppc: Implement watchpoint debug facility for v2.07S
>>        spapr: implement H_SET_MODE debug facilities
>>        ppc/vhyp: reset exception state when handling vhyp hcall
>>        ppc/vof: Fix missed fields in VOF cleanup
>>        hw/ppc/ppc.c: Tidy over-long lines
>>        hw/ppc: Introduce functions for conversion between timebase and nanoseconds
>>        host-utils: Add muldiv64_round_up
>>        hw/ppc: Round up the decrementer interval when converting to ns
>>        hw/ppc: Avoid decrementer rounding errors
>>        target/ppc: Sign-extend large decrementer to 64-bits
>>        hw/ppc: Always store the decrementer value
>>        target/ppc: Migrate DECR SPR
>>        hw/ppc: Reset timebase facilities on machine reset
>>        hw/ppc: Read time only once to perform decrementer write
>>        target/ppc: Fix CPU reservation migration for record-replay
>>        target/ppc: Fix timebase reset with record-replay
>>        spapr: Fix machine reset deadlock from replay-record
>>        spapr: Fix record-replay machine reset consuming too many events
>>        tests/avocado: boot ppc64 pseries replay-record test to Linux VFS mount
>>        tests/avocado: reverse-debugging cope with re-executing breakpoints
>>        tests/avocado: ppc64 reverse debugging tests for pseries and powernv
>>        target/ppc: Fix LQ, STQ register-pair order for big-endian
>>
>> Richard Henderson (1):
>>        target/ppc: Flush inputs to zero with NJ in ppc_store_vscr
>>
>> Shawn Anastasio (1):
>>        target/ppc: Generate storage interrupts for radix RC changes
>>
>> jianchunfu (1):
>>        target/ppc: Fix the order of kvm_enable judgment about kvmppc_set_interrupt()
> 
> Is there anything in there worth to pick for -stable?
> Like, for example, some decrementer fixes, 

The decrementer fixes are good candidates but there are quite a few
patches and you might encounter conflicts.

> or some of these:
> 
>   ppc/vof: Fix missed fields in VOF cleanup
>   spapr: Fix machine reset deadlock from replay-record
>   hw/ppc/e500: fix broken snapshot replay

I can not tell if replay-record is important for stable. Nick ?
  
> or something else?

These are :

   target/ppc: Flush inputs to zero with NJ in ppc_store_vscr
   target/ppc: Fix LQ, STQ register-pair order for big-endian

Thanks,

C.


> Thanks!
> 
> /mjt


