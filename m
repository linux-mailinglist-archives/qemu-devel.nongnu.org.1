Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DC9799EAA
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 16:37:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfLXF-0000W8-J1; Sun, 10 Sep 2023 10:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfLXB-0000VZ-T2; Sun, 10 Sep 2023 10:35:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfLX8-00047s-5Y; Sun, 10 Sep 2023 10:35:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 352F6208E1;
 Sun, 10 Sep 2023 17:35:23 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CC36A27086;
 Sun, 10 Sep 2023 17:35:22 +0300 (MSK)
Message-ID: <aeaf35f2-c2da-345d-82f8-2b04b0d51a70@tls.msk.ru>
Date: Sun, 10 Sep 2023 17:35:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PULL v2 00/35] ppc queue
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20230906143653.54709-1-clg@kaod.org>
 <2b6c3dd1-430a-2e60-ea73-29c507d631d8@tls.msk.ru>
 <ad943b46-0652-8fd1-49a4-c86dd6214827@kaod.org>
 <CVD90VD3O9W1.1UBFXQ7MSVZEO@wheely>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CVD90VD3O9W1.1UBFXQ7MSVZEO@wheely>
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

08.09.2023 07:24, Nicholas Piggin wrote:

>>>> Nicholas Piggin (26):
>>>>         target/ppc: Remove single-step suppression inside 0x100-0xf00
>>>>         target/ppc: Improve book3s branch trace interrupt for v2.07S
>>>>         target/ppc: Suppress single step interrupts on rfi-type instructions
>>>>         target/ppc: Implement breakpoint debug facility for v2.07S
>>>>         target/ppc: Implement watchpoint debug facility for v2.07S
>>>>         spapr: implement H_SET_MODE debug facilities
>>>>         ppc/vhyp: reset exception state when handling vhyp hcall
>>>>         ppc/vof: Fix missed fields in VOF cleanup
>>>>         hw/ppc/ppc.c: Tidy over-long lines
>>>>         hw/ppc: Introduce functions for conversion between timebase and nanoseconds
>>>>         host-utils: Add muldiv64_round_up
>>>>         hw/ppc: Round up the decrementer interval when converting to ns
>>>>         hw/ppc: Avoid decrementer rounding errors
>>>>         target/ppc: Sign-extend large decrementer to 64-bits
>>>>         hw/ppc: Always store the decrementer value
>>>>         target/ppc: Migrate DECR SPR
>>>>         hw/ppc: Reset timebase facilities on machine reset
>>>>         hw/ppc: Read time only once to perform decrementer write
>>>>         target/ppc: Fix CPU reservation migration for record-replay
>>>>         target/ppc: Fix timebase reset with record-replay
>>>>         spapr: Fix machine reset deadlock from replay-record
>>>>         spapr: Fix record-replay machine reset consuming too many events
>>>>         tests/avocado: boot ppc64 pseries replay-record test to Linux VFS mount
>>>>         tests/avocado: reverse-debugging cope with re-executing breakpoints
>>>>         tests/avocado: ppc64 reverse debugging tests for pseries and powernv
>>>>         target/ppc: Fix LQ, STQ register-pair order for big-endian
...
>> The decrementer fixes are good candidates but there are quite a few
>> patches and you might encounter conflicts.

So, there are 6 patches in there:

  7798f5c576 hw/ppc: Introduce functions for conversion between timebase and nanoseconds
  47de6c4c28 host-utils: Add muldiv64_round_up
  eab0888418 hw/ppc: Round up the decrementer interval when converting to ns
  8e0a5ac878 hw/ppc: Avoid decrementer rounding errors
  c8fbc6b9f2 target/ppc: Sign-extend large decrementer to 64-bits
  febb71d543 hw/ppc: Always store the decrementer value

It all applies cleanly to 8.1 (running ci now), which is fine.
For 8.0 and 7.2 things are a bit fun though.  6th patch (febb71d543)
has minor context conflict with this commit:

commit 17dd1354c1d1aba9caf4af01e11aa7dbe128474f
Author: Nicholas Piggin <npiggin@gmail.com>
Date:   Tue May 30 23:12:13 2023 +1000

     target/ppc: Decrementer fix BookE semantics

Technically, while the two touches nearby areas in
hw/ppc/ppc.c:__cpu_ppc_store_decr(), they don't actually
conflict, it is just the comment context.  But git is unable
to figure this out by its own.  With commit 17dd1354c1d applied,
everything goes flawlessly.  It looks like 17dd1354c1d can be
picked up too for stable just fine, without resorting to context
fixing.

Also, 2 more patches applies cleanly (to 8.1 anyway):

  30d0647bcf hw/ppc: Reset timebase facilities on machine reset
  ea62f8a517 hw/ppc: Read time only once to perform decrementer write

but it does not look like you mean these, esp. ea62f8a517.


> Decrementer I was nervous about since there were quite a lot of
> interacting issues. Decrementer has worked okay for a while, so
> even though there are some bugs, they're mostly in edge cases
> that most OSes don't hit or care so much about.

Ok.

> Possibly the decrementer migration patch could be a candidate.

I'm guessing this is this change:

  578912ad73 target/ppc: Migrate DECR SPR

This one is a bit more difficult.   First it requires the following:

  d5ee641cfc target/ppc: Implement watchpoint debug facility for v2.07S
  14192307ef target/ppc: Implement breakpoint debug facility for v2.07S

which aren't present in 8.1.  And second, I'm not sure for the
migration compatibility here, - will whole thing become unmigratable
between 8.1.0 and some 8.1.x this way?  (and how about 8.1 and 8.2?).

> In any case I would like them to get more testing upstream for
> a while first.

Ok, let's give it a try.

Thanks,

/mjt

