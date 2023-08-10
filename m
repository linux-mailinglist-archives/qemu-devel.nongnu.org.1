Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 083EA777083
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 08:37:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTzGj-0005xl-Cr; Thu, 10 Aug 2023 02:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qTzGg-0005xa-Ez
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 02:35:34 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qTzGe-00075s-KO
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 02:35:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 58D2B19761;
 Thu, 10 Aug 2023 09:35:25 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CC7471D04E;
 Thu, 10 Aug 2023 09:35:18 +0300 (MSK)
Message-ID: <a5dc02df-158e-4ff8-fce9-e2ec7df980ad@tls.msk.ru>
Date: Thu, 10 Aug 2023 09:35:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PULL 1/1] target/openrisc: Set EPCR to next PC on FPE exceptions
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20230809203432.424071-1-shorne@gmail.com>
 <20230809203432.424071-2-shorne@gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230809203432.424071-2-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -109
X-Spam_score: -11.0
X-Spam_bar: -----------
X-Spam_report: (-11.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.14,
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

09.08.2023 23:34, Stafford Horne пишет:
> The architecture specification calls for the EPCR to be set to "Address
> of next not executed instruction" when there is a floating point
> exception (FPE).  This was not being done, so fix it by using the same
> pattern as syscall.  Also, we move this logic down to be done for
> instructions not in the delay slot as called for by the architecture
> manual.
> 
> Without this patch FPU exceptions will loop, as the exception handling
> will always return back to the failed floating point instruction.
> 
> This was not noticed in earlier testing because:
> 
>   1. The compiler usually generates code which clobbers the input operand
>      such as:
> 
>        lf.div.s r19,r17,r19
> 
>   2. The target will store the operation output before to the register
>      before handling the exception.  So an operation such as:
> 
>        float a = 100.0f;
>        float b = 0.0f;
>        float c = a / b;    /* lf.div.s r19,r17,r19 */
> 
>      Will first execute:
> 
>        100 / 0    -> Store inf to c (r19)
>                   -> triggering divide by zero exception
>                   -> handle and return
> 
>      Then it will execute:
> 
>        100 / inf  -> Store 0 to c  (no exception)
> 
> To confirm the looping behavior and the fix I used the following:
> 
>      float fpu_div(float a, float b) {
> 	float c;
> 	asm volatile("lf.div.s %0, %1, %2"
> 		      : "+r" (c)
> 		      : "r" (a), "r" (b));
> 	return c;
>      }

Is it a -stable material?  It applies cleanly to 8.0 and 7.2.
Or maybe it is not needed on older versions, not being noticed before?

/mjt


