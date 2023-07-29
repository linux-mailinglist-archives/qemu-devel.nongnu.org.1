Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F46768270
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 00:07:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPrWu-0003ve-1W; Sat, 29 Jul 2023 17:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1qPrWs-0003vU-HU
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 17:31:14 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1qPrWq-0005D0-VG
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 17:31:14 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so3438402f8f.2
 for <qemu-devel@nongnu.org>; Sat, 29 Jul 2023 14:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690666271; x=1691271071;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yA0ile9O8Uyl85D4tcaRLRR/T8U082XP+mq8Jri7j1E=;
 b=Lm2Kffa7RqQ/yV7kMg5IkpAOJ6yPyxpEiF5HvCOTdCo2vCMC2nutixEgOEUmTWj5ma
 hobc3IfFiJ2b4U1JZ4HVvi4v2BW3vrFPdCaOSbuny9dEUKdr0EPG5ulFXbwxMSeUPNXd
 MUaqoKK3tSlO3lmzwLQG2A/c70sYF/flZiXWWYuGAZflA3/5TY/7Yt9w2hC9AUnIK6y0
 r2T6oyHmS9RFaT5aXFOcgK/GKCGW16vO92tQLsLWRAyLxkXIqw43qkI8Z7rTudemzBmU
 0x2ETRQqBYL0YTU1vlnxwg5vfmy+x3zGuTlrvD+cm1tPQiCKP0jyAlpSiEppv1jVumuh
 oMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690666271; x=1691271071;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yA0ile9O8Uyl85D4tcaRLRR/T8U082XP+mq8Jri7j1E=;
 b=exUZM72gCIpEm8mBy0j0PsNV3uv7ec35Ht4cgWKq4hcZ4/OehO+1G53f8+Rfe/BvzR
 eTxYUMFGEpaMDCaSDPY57ogLmYX4C13EskR5VdgX4+mrkAI5qOEz6DXvL1VpTyfyTFbs
 AsVBzw+fGmjETs87kOQxGQ7XrsCEX41YTkA/YZn7UqM5VpKEYUrXL/IDEvRzBLRQGBpE
 Ethbg0CyTb1iA9h1F/5wIFW+Anakdb1Tx79Q1gKopLcHg1bPRxyAW4AEbWEpPMTSJiuk
 ObEi7AhAZ0vvgxCniN1S41R10uQIWBVshYK5561jxghnJNLWcBmWjznh+8CNuZfae0uw
 ZCVQ==
X-Gm-Message-State: ABy/qLaO/zdoohse1VrQLgb14yAI0egGfQ/+PTaOMHXIW39BdPq0I8dR
 Kg3XaRlL7bcTXUDox64DsKrMQFMVYi9Qbg==
X-Google-Smtp-Source: APBJJlHWb4/zZ/iMMpJy8Y1gU2WapQF7XNruqtjAhviJz1nkbwJGlMOnnebKfoHul0u3va9J7pdrRg==
X-Received: by 2002:adf:f185:0:b0:314:385d:6099 with SMTP id
 h5-20020adff185000000b00314385d6099mr4888915wro.35.1690666270730; 
 Sat, 29 Jul 2023 14:31:10 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 b18-20020adfe312000000b0031437ec7ec1sm8433034wrj.2.2023.07.29.14.31.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jul 2023 14:31:10 -0700 (PDT)
Date: Sat, 29 Jul 2023 22:31:09 +0100
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Subject: Re: [PATCH] target/openrisc: Set EPCR to next PC on FPE exceptions
Message-ID: <ZMWFHU+lw/Fj6xBL@antec>
References: <20230729210851.3097340-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729210851.3097340-1-shorne@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=shorne@gmail.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sat, Jul 29, 2023 at 10:08:51PM +0100, Stafford Horne wrote:
> The architecture specification calls for the EPCR to be set to "Address
> of next not executed instruction" when there is a floating point
> exception (FPE).  This was not being done, so fix it by using the same
> method as syscall.  Note, this may need a lot more work if we start
> seeing floating point operations in delay slots which exceptions
> enabled.

It should be "with exceptions enabled."

> 
> Without this patch FPU exceptions will loop, as the exception hanlding

"handling"

> will always return back to the failed floating point instruction.
> 
> This was not noticed in earlier testing because:
> 
>  1. The compiler usually generates code which clobbers the input operand
>     such as:
> 
>       lf.div.s r19,r17,r19
> 
>  2. The target will store the operation output before to the register
>     before handling the exception.  So an operation such as:
> 
>       float a = 100.0f;
>       float b = 0.0f;
>       float c = a / b;    /* lf.div.s r19,r17,r19 */
> 
>     Will first execute:
> 
>       100 / 0    -> Store inf to c (r19)
>                  -> triggering divide by zero exception
>                  -> handle and return
> 
>     Then it will exectute:
> 
>       100 / inf  -> Store 0 to c  (no exception)
> 
> To confirm the looping behavoid and the fix I used the following:

"behavior"

>     float fpu_div(float a, float b) {
> 	float c;
> 	asm volatile("lf.div.s %0, %1, %2"
> 		      : "+r" (c)
> 		      : "r" (a), "r" (b));
> 	return c;
>     }
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>

-Stafford

> ---
>  target/openrisc/interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
> index 3887812810..9b14b8a2c6 100644
> --- a/target/openrisc/interrupt.c
> +++ b/target/openrisc/interrupt.c
> @@ -34,7 +34,7 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
>      int exception = cs->exception_index;
>  
>      env->epcr = env->pc;
> -    if (exception == EXCP_SYSCALL) {
> +    if (exception == EXCP_SYSCALL || exception == EXCP_FPE) {
>          env->epcr += 4;
>      }
>      /* When we have an illegal instruction the error effective address
> -- 
> 2.39.1
> 

