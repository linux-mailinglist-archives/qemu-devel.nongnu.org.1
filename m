Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FA17A01D7
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 12:40:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgjlX-00084M-WF; Thu, 14 Sep 2023 06:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgjlQ-0007yG-8n
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:40:02 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgjlM-0005zo-O9
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:Reply-To:MIME-Version:Date:Message-ID:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=T2e2Y7JHT9nzA8eg0KjzTVJeBrFKaDmJWwmzFJ0Zak0=; b=IRV1Z1MFvF1peFf8PFw8ki1kbq
 cxXoZP6h1KPF+EP+E9r/wVttate0GsiTUXMNgdOkU2iZFM7fVfNwsl2QjGAnNTk31tW5SRaJABpQS
 RvpQMbDG8+MiMYE10sxIwjYmliet/JHTKXvt1rZZ2/kjCyS9xr92knPeEBiMqsUqyzdk=;
Message-ID: <9742a48e-1570-409f-a610-1c2c67d8c1a7@rev.ng>
Date: Thu, 14 Sep 2023 12:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/24] accel/tcg: Remove env_neg()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-16-richard.henderson@linaro.org>
Organization: rev.ng
In-Reply-To: <20230914024435.1381329-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  anjo@rev.ng
X-ACL-Warn: ,  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On 9/14/23 04:44, Richard Henderson wrote:
> Replace the single use within env_tlb() and remove.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h | 13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 9db8544125..af9516654a 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -451,17 +451,6 @@ static inline CPUState *env_cpu(CPUArchState *env)
>       return (void *)env - sizeof(CPUState);
>   }
>   
> -/**
> - * env_neg(env)
> - * @env: The architecture environment
> - *
> - * Return the CPUNegativeOffsetState associated with the environment.
> - */
> -static inline CPUNegativeOffsetState *env_neg(CPUArchState *env)
> -{
> -    return (void *)env - sizeof(CPUNegativeOffsetState);
> -}
> -
>   /**
>    * env_tlb(env)
>    * @env: The architecture environment
> @@ -470,7 +459,7 @@ static inline CPUNegativeOffsetState *env_neg(CPUArchState *env)
>    */
>   static inline CPUTLB *env_tlb(CPUArchState *env)
>   {
> -    return &env_neg(env)->tlb;
> +    return &env_cpu(env)->neg.tlb;
>   }
>   
>   #endif /* CPU_ALL_H */
Reviewed-by: Anton Johansson <anjo@rev.ng>

