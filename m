Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C352B713B4C
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 19:38:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3KKS-0006Ez-Dn; Sun, 28 May 2023 13:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3KKE-0006Ei-R1; Sun, 28 May 2023 13:37:03 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3KKC-0008Rg-O6; Sun, 28 May 2023 13:37:02 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B9CD28F2B;
 Sun, 28 May 2023 20:36:44 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4A0EA7F75;
 Sun, 28 May 2023 20:36:44 +0300 (MSK)
Message-ID: <2ccafb44-d09a-e71c-005b-9a36f128b275@tls.msk.ru>
Date: Sun, 28 May 2023 20:36:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/10] ppc queue
Content-Language: en-US
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Nicholas Piggin <npiggin@gmail.com>, Bernhard Beschow <shentey@gmail.com>
References: <20230528164922.20364-1-danielhb413@gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230528164922.20364-1-danielhb413@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.093,
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

28.05.2023 19:49, Daniel Henrique Barboza wrote:
> 
>    https://gitlab.com/danielhb/qemu.git tags/pull-ppc-20230528
> 
> ppc patch queue for 2023-05-28:
> 
> This queue includes several assorted fixes for PowerPC SPR
> emulation, a change in the default Pegasos2 CPU, the addition
> of AIL mode 3 for spapr, a PIC->CPU interrupt fix for prep and
> performance enhancements in fpu_helper.c.

 From the patch description, it looks like the following changes
are suitable for -stable:

01/10 target/ppc: Fix fallback to MFSS for MFFS* instructions on pre 3.0 ISAs
02/10 target/ppc: Fix width of some 32-bit SPRs
03/10 target/ppc: Alignment faults do not set DSISR in ISA v3.0 onward
05/10 hw/ppc/prep: Fix wiring of PIC -> CPU interrupt

Or are these not important for -stable?  Or maybe there are other changes
which should be picked too?

Please add "Cc: qemu-stable@nongnu.org" tag for the future patches which
needs to be backported to previous/stable version of qemu.

Thanks!

/mjt
> ---------------------------------------------------------------
> Alexander Bulekov (1):
>        pnv_lpc: disable reentrancy detection for lpc-hc
> 
> BALATON Zoltan (1):
>        ppc/pegasos2: Change default CPU to 7457
> 
> Bernhard Beschow (1):
>        hw/ppc/prep: Fix wiring of PIC -> CPU interrupt
> 
> Nicholas Piggin (5):
>        target/ppc: Fix width of some 32-bit SPRs
>        target/ppc: Alignment faults do not set DSISR in ISA v3.0 onward
>        spapr: Add SPAPR_CAP_AIL_MODE_3 for AIL mode 3 support for H_SET_MODE hcall
>        target/ppc: Use SMT4 small core chip type in POWER9/10 PVRs
>        target/ppc: Add POWER9 DD2.2 model
> 
> Richard Henderson (1):
>        target/ppc: Merge COMPUTE_CLASS and COMPUTE_FPRF
> 
> Richard Purdie (1):
>        target/ppc: Fix fallback to MFSS for MFFS* instructions on pre 3.0 ISAs
> 


