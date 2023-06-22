Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4AA73981A
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:32:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCEnA-00047c-7l; Thu, 22 Jun 2023 03:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=yb1G=CK=kaod.org=clg@ozlabs.org>)
 id 1qCEma-000457-K1; Thu, 22 Jun 2023 03:31:12 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=yb1G=CK=kaod.org=clg@ozlabs.org>)
 id 1qCEmX-0006XX-Qd; Thu, 22 Jun 2023 03:31:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QmsVZ2PRlz4x04;
 Thu, 22 Jun 2023 17:31:02 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QmsVX6X0Hz4wjF;
 Thu, 22 Jun 2023 17:31:00 +1000 (AEST)
Message-ID: <35689504-df1e-0590-b393-a65673562404@kaod.org>
Date: Thu, 22 Jun 2023 09:30:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/4] ppc/pnv: Add chiptod and core timebase state machine
 models
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230603233612.125879-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230603233612.125879-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=yb1G=CK=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.093, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/4/23 01:36, Nicholas Piggin wrote:
> This adds support for chiptod and core timebase state machine models in
> the powernv POWER9 and POWER10 models.
> 
> This does not actually change the time or the value in TB registers
> (because they are alrady synced in QEMU), but it does go through the
> motions. It is enough to be able to run skiboot's chiptod initialisation
> code that synchronises core timebases (after a patch to prevent skiboot
> skipping chiptod for QEMU, posted to skiboot mailing list).
> 
> Sorry there was some delay since the last posting. There is a bit more
> interest in this recently but feedback and comments from RFC was not
> forgotten and is much appreciated.
> 
> https://lists.gnu.org/archive/html/qemu-ppc/2022-08/msg00324.html
> 
> I think I accounted for everything except moving register defines to the
> .h file. I'm on the fence about that but if they are only used in the .c
> file I think it's okay to keep them there for now. I cut out a lot of
> unused ones so it's not so cluttered now.
> 
> Lots of other changes and fixes since that RFC. Notably:
> - Register names changed to match the workbook names instead of skiboot.
> - TFMR moved to timebase_helper.c from misc_helper.c
> - More comprehensive model and error checking, particularly of TFMR.
> - POWER10 with multi-chip support.
> - chiptod and core timebase linked via specific state instead of TFMR.
> 
> There is still a vast amount that is not modeled, but most of it related
> to error handling, injection, failover, etc that is very complicated and
> not required for normal operation.
> 
> Thanks,
> Nick
> 
> Nicholas Piggin (4):
>    pnv/chiptod: Add POWER9/10 chiptod model
>    target/ppc: Tidy POWER book4 SPR registration
>    target/ppc: add TFMR SPR implementation with read and write helpers
>    target/ppc: Implement core timebase state machine and TFMR

patch 2-4 could be merged in the next PR. Could you please rebase on
ppc-next and resend ?

Then we still have 2+ weeks to polish pnv/chiptod which would be a
nice addition to QEMU 8.1.

Thanks,

C.


> 
>   hw/ppc/meson.build           |   1 +
>   hw/ppc/pnv.c                 |  38 +++
>   hw/ppc/pnv_chiptod.c         | 488 +++++++++++++++++++++++++++++++++++
>   hw/ppc/pnv_xscom.c           |   2 +
>   hw/ppc/trace-events          |   4 +
>   include/hw/ppc/pnv_chip.h    |   3 +
>   include/hw/ppc/pnv_chiptod.h |  64 +++++
>   include/hw/ppc/pnv_core.h    |   3 +
>   include/hw/ppc/pnv_xscom.h   |   9 +
>   target/ppc/cpu.h             |  40 +++
>   target/ppc/cpu_init.c        |  92 ++++---
>   target/ppc/helper.h          |   2 +
>   target/ppc/spr_common.h      |   2 +
>   target/ppc/timebase_helper.c | 156 +++++++++++
>   target/ppc/translate.c       |  10 +
>   15 files changed, 882 insertions(+), 32 deletions(-)
>   create mode 100644 hw/ppc/pnv_chiptod.c
>   create mode 100644 include/hw/ppc/pnv_chiptod.h
> 


