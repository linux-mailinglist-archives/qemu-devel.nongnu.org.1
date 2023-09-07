Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2923797C93
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 21:12:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeKOq-0001LS-UZ; Thu, 07 Sep 2023 15:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeKOo-0001L8-4y; Thu, 07 Sep 2023 15:10:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeKOl-0002IQ-GH; Thu, 07 Sep 2023 15:10:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 805B71FDF7;
 Thu,  7 Sep 2023 22:11:20 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 13114266E2;
 Thu,  7 Sep 2023 22:10:31 +0300 (MSK)
Message-ID: <2b6c3dd1-430a-2e60-ea73-29c507d631d8@tls.msk.ru>
Date: Thu, 7 Sep 2023 22:10:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PULL v2 00/35] ppc queue
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20230906143653.54709-1-clg@kaod.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230906143653.54709-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

06.09.2023 17:36, Cédric Le Goater wrote:
...
> ppc queue :
> 
> * debug facility improvements
> * timebase and decrementer fixes
> * record-replay fixes
> * TCG fixes
> * XIVE model improvements for multichip
> 
> ----------------------------------------------------------------
> Cédric Le Goater (4):
>        ppc/xive: Use address_space routines to access the machine RAM
>        ppc/xive: Introduce a new XiveRouter end_notify() handler
>        ppc/xive: Handle END triggers between chips with MMIOs
>        ppc/xive: Add support for the PC MMIOs
> 
> Joel Stanley (1):
>        ppc: Add stub implementation of TRIG SPRs
> 
> Maksim Kostin (1):
>        hw/ppc/e500: fix broken snapshot replay
> 
> Nicholas Piggin (26):
>        target/ppc: Remove single-step suppression inside 0x100-0xf00
>        target/ppc: Improve book3s branch trace interrupt for v2.07S
>        target/ppc: Suppress single step interrupts on rfi-type instructions
>        target/ppc: Implement breakpoint debug facility for v2.07S
>        target/ppc: Implement watchpoint debug facility for v2.07S
>        spapr: implement H_SET_MODE debug facilities
>        ppc/vhyp: reset exception state when handling vhyp hcall
>        ppc/vof: Fix missed fields in VOF cleanup
>        hw/ppc/ppc.c: Tidy over-long lines
>        hw/ppc: Introduce functions for conversion between timebase and nanoseconds
>        host-utils: Add muldiv64_round_up
>        hw/ppc: Round up the decrementer interval when converting to ns
>        hw/ppc: Avoid decrementer rounding errors
>        target/ppc: Sign-extend large decrementer to 64-bits
>        hw/ppc: Always store the decrementer value
>        target/ppc: Migrate DECR SPR
>        hw/ppc: Reset timebase facilities on machine reset
>        hw/ppc: Read time only once to perform decrementer write
>        target/ppc: Fix CPU reservation migration for record-replay
>        target/ppc: Fix timebase reset with record-replay
>        spapr: Fix machine reset deadlock from replay-record
>        spapr: Fix record-replay machine reset consuming too many events
>        tests/avocado: boot ppc64 pseries replay-record test to Linux VFS mount
>        tests/avocado: reverse-debugging cope with re-executing breakpoints
>        tests/avocado: ppc64 reverse debugging tests for pseries and powernv
>        target/ppc: Fix LQ, STQ register-pair order for big-endian
> 
> Richard Henderson (1):
>        target/ppc: Flush inputs to zero with NJ in ppc_store_vscr
> 
> Shawn Anastasio (1):
>        target/ppc: Generate storage interrupts for radix RC changes
> 
> jianchunfu (1):
>        target/ppc: Fix the order of kvm_enable judgment about kvmppc_set_interrupt()

Is there anything in there worth to pick for -stable?
Like, for example, some decrementer fixes, or some of these:

  ppc/vof: Fix missed fields in VOF cleanup
  spapr: Fix machine reset deadlock from replay-record
  hw/ppc/e500: fix broken snapshot replay

or something else?

Thanks!

/mjt

