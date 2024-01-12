Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9978982C39C
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 17:35:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOKTX-0003Bx-U0; Fri, 12 Jan 2024 11:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qInK=IW=kaod.org=clg@ozlabs.org>)
 id 1rOKTQ-00033c-Q4
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 11:33:36 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qInK=IW=kaod.org=clg@ozlabs.org>)
 id 1rOKTN-0002ue-VK
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 11:33:36 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TBRtJ1QGSz4xF1;
 Sat, 13 Jan 2024 03:33:28 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TBRtB5PmDz4x7q;
 Sat, 13 Jan 2024 03:33:22 +1100 (AEDT)
Message-ID: <484ebf77-6b62-418c-8319-d69ccaf90c17@kaod.org>
Date: Fri, 12 Jan 2024 17:33:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible race condition in aspeed ast2600 smp boot on TCG QEMU
Content-Language: en-US
To: Stephen Longfield <slongfield@google.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au
Cc: Joe Komlodi <komlodi@google.com>, Patrick Venture <venture@google.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Troy Lee <troy_lee@aspeedtech.com>
References: <CAK_0=F+RznDdq27z3r3H1d4pj=QTD-9WZP8xH7jOP75QXJhHpw@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CAK_0=F+RznDdq27z3r3H1d4pj=QTD-9WZP8xH7jOP75QXJhHpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=qInK=IW=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Adding Aspeed Engineers. This reminds me of a discussion a while ago.

On 1/11/24 18:38, Stephen Longfield wrote:
> We’ve noticed inconsistent behavior when running a large number of aspeed ast2600 executions, that seems to be tied to a race condition in the smp boot when executing on TCG-QEMU, and were wondering what a good mediation strategy might be.
> 
> The problem first shows up as part of SMP boot. On a run that’s likely to later run into issues, we’ll see something like:
> 
> ```
> [    0.008350] smp: Bringing up secondary CPUs ...
> [    1.168584] CPU1: failed to come online
> [    1.187277] smp: Brought up 1 node, 1 CPU
> ```
> 
> Compared to the more likely to succeed:
> 
> ```
> [    0.080313] smp: Bringing up secondary CPUs ...
> [    0.093166] smp: Brought up 1 node, 2 CPUs
> [    0.093345] SMP: Total of 2 processors activated (4800.00 BogoMIPS).
> ```
> 
> It’s somewhat reliably reproducible by running the ast2600-evb with an OpenBMC image, using ‘-icount auto’ to slow execution and make the race condition more frequent (it happens without this, just easier to debug if we can reproduce):
> 
> 
> ```
> ./aarch64-softmmu/qemu-system-aarch64 -machine ast2600-evb -nographic -drive file=~/bmc-bin/image-obmc-ast2600,if=mtd,bus=0,unit=0,snapshot=on -nic user -icount auto
> ```
> 
> Our current hypothesis is that the problem comes up in the platform uboot.  As part of the boot, the secondary core waits for the smp mailbox to get a magic number written by the primary core:
> 
> https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-v2019.04/arch/arm/mach-aspeed/ast2600/platform.S#L168 <https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-v2019.04/arch/arm/mach-aspeed/ast2600/platform.S#L168>
> 
> However, this memory address is cleared on boot:
> 
> https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-v2019.04/arch/arm/mach-aspeed/ast2600/platform.S#L146 <https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-v2019.04/arch/arm/mach-aspeed/ast2600/platform.S#L146>
> 
> The race condition occurs if the primary core runs far ahead of the secondary core: if the primary core gets to the point where it signals the secondary core’s mailbox before the secondary core gets past the point where it does the initial reset and starts waiting, the reset will clear the signal, and then the secondary core will never get past the point where it’s looping in `poll_smp_mbox_ready`.
> 
> We’ve observed this race happening by dumping all SCU reads and writes, and validated that this is the problem by using a modified `platform.S` that doesn’t clear the =SCU_SMP_READY mailbox on reset, but would rather not have to use a modified version of SMP boot just for QEMU-TCG execution.

you could use '-trace aspeed_scu*' to collect the MMIO accesses on
the SCU unit. A TCG plugin also.

> Is there a way to have QEMU insert a barrier synchronization at some point in the bootloader?  I think getting both cores past the =SCU_SMP_READY reset would get rid of this race, but I’m not aware of a way to do that kind of thing in QEMU-TCG.
> 
> Thanks for any insights!

Could we change the default value to registers 0x180 ... 0x18C in
hw/misc/aspeed_scu.c to make sure the SMP regs are immune to the
race ?

Thanks,

C.





