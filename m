Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3DE82498F
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 21:29:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLUKQ-0008MS-6v; Thu, 04 Jan 2024 15:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1rLUKL-0008M9-Rb
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 15:28:29 -0500
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1rLUKJ-0007lE-7U
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 15:28:29 -0500
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id 01658A00CF; Thu,  4 Jan 2024 21:28:24 +0100 (CET)
Date: Thu, 4 Jan 2024 21:28:24 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: deller@kernel.org
cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, 
 Bruno Haible <bruno@clisp.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Nelson H . F . Beebe" <beebe@math.utah.edu>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 5/9] target/hppa: Strip upper 32-bits of IOR on error in
 probe
In-Reply-To: <20240104183628.101366-6-deller@kernel.org>
Message-ID: <alpine.LMD.2.03.2401042126260.28870@eik.bme.hu>
References: <20240104183628.101366-1-deller@kernel.org>
 <20240104183628.101366-6-deller@kernel.org>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Received-SPF: none client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 4 Jan 2024, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
>
> Limit IOR to the lower 32-bits on failure.
> Keep patch short for easier backporting.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
> target/hppa/op_helper.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
> index 7f607c3afd..56930a3a8c 100644
> --- a/target/hppa/op_helper.c
> +++ b/target/hppa/op_helper.c
> @@ -353,7 +353,7 @@ target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
>     if (excp >= 0) {
>         if (env->psw & PSW_Q) {
>             /* ??? Needs tweaking for hppa64.  */
> -            env->cr[CR_IOR] = addr;
> +            env->cr[CR_IOR] = (uint32_t) addr;

I think no space needed for casts but checkpatch does not seem to notice 
this.

Regards,
BALATON Zoltan

>             env->cr[CR_ISR] = addr >> 32;
>         }
>         if (excp == EXCP_DTLB_MISS) {
> -- 
> 2.43.0
>
>
>

