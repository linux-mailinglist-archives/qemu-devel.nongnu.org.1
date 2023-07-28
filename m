Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FBF766F88
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 16:33:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPO94-0004V7-MG; Fri, 28 Jul 2023 10:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <markus@oberhumer.com>)
 id 1qPGI7-000588-EI
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 01:45:31 -0400
Received: from mail.servus.at ([193.170.194.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <markus@oberhumer.com>)
 id 1qPGI4-0002Ka-C9
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 01:45:31 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.servus.at (Postfix) with ESMTP id 8583229722;
 Fri, 28 Jul 2023 07:45:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oberhumer.com; h=
 content-transfer-encoding:content-type:content-type:in-reply-to
 :mime-version:user-agent:date:date:message-id:organization:from
 :from:references:subject:subject:received:received; s=main; t=
 1690523122; x=1692337523; bh=wkz/JU8lebbXBt0ByfX+Yqc28ivJDCO2B+J
 +XwyJ3P0=; b=licsjnynPnF3DVtWRqY7LgPSVu5YooTDCVUJWh2pc/Z6ILFiVA6
 f6z6FNHFxy3bkLFXc1fRPLtQ/tStvU0tvrMILPj9MEwqUcFoGkc70yOWyatJ0pjn
 xtRbkmwdwjy88r+SoPOqqYIxZMb/A7LHzSg8NVsJP1sawxV3RUKbBqY4=
X-Virus-Scanned: amavisd-new at servus.at
Received: from mail.servus.at ([127.0.0.1])
 by localhost (mail.servus.at [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gJgCXyEN72DS; Fri, 28 Jul 2023 07:45:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at servus.at
Received: from [192.168.216.53] (unknown [81.10.228.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: oh_markus)
 by mail.servus.at (Postfix) with ESMTPSA id 0BAFD2196F;
 Fri, 28 Jul 2023 07:45:18 +0200 (CEST)
Subject: Re: [PATCH v2] linux-user/armeb: Fix __kernel_cmpxchg() for armeb
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <ZMNJ+Ga7A4zDXjAg@p100>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 John Reiser <jreiser@bitwagon.com>
From: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Organization: oberhumer.com
Message-ID: <64C355ED.4050405@oberhumer.com>
Date: Fri, 28 Jul 2023 07:45:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <ZMNJ+Ga7A4zDXjAg@p100>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=193.170.194.20; envelope-from=markus@oberhumer.com;
 helo=mail.servus.at
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 28 Jul 2023 10:08:37 -0400
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

The fix in arm_kernel_cmpxchg64_helper probably should use tswap64() instead
of tswap32().

~Markus

On 2023-07-28 06:54, Helge Deller wrote:
> Commit 7f4f0d9ea870 ("linux-user/arm: Implement __kernel_cmpxchg with host
> atomics") switched to use qatomic_cmpxchg() to swap a word with the memory
> content, but missed to endianess-swap the oldval and newval values when
> emulating an armeb CPU, which expects words to be stored in big endian in
> the guest memory.
> 
> The bug can be verified with qemu >= v7.2 on any little-endian host, when
> starting the armeb binary of the upx program, which just hangs without
> this patch.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-stable@nongnu.org
> Reported-by: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
> Reported-by: John Reiser <jreiser@BitWagon.com>
> Closes: https://github.com/upx/upx/issues/687
> 
> --
> v2:
> - add tswap32() in arm_kernel_cmpxchg64_helper()
> 
> 
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index a992423257..0907cd8c15 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -117,8 +117,9 @@ static void arm_kernel_cmpxchg32_helper(CPUARMState *env)
>  {
>      uint32_t oldval, newval, val, addr, cpsr, *host_addr;
> 
> -    oldval = env->regs[0];
> -    newval = env->regs[1];
> +    /* endianess-swap if emulating armeb */
> +    oldval = tswap32(env->regs[0]);
> +    newval = tswap32(env->regs[1]);
>      addr = env->regs[2];
> 
>      mmap_lock();
> @@ -174,6 +175,10 @@ static void arm_kernel_cmpxchg64_helper(CPUARMState *env)
>          return;
>      }
> 
> +    /* endianess-swap if emulating armeb */
> +    oldval = tswap32(oldval);
> +    newval = tswap32(newval);
> +
>  #ifdef CONFIG_ATOMIC64
>      val = qatomic_cmpxchg__nocheck(host_addr, oldval, newval);
>      cpsr = (val == oldval) * CPSR_C;
> 

-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/

