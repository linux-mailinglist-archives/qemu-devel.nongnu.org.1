Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66174726993
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 21:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ydP-0004rj-Gp; Wed, 07 Jun 2023 15:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6ydL-0004qb-4x
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 15:15:51 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6ydJ-0006yH-7K
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 15:15:50 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-653bed78635so721346b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 12:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686165347; x=1688757347;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bS5nlC4EcdlXmAJkGrfbY/FSI7ZzjpOcEAyzjrb5rgw=;
 b=UqolIEEwJcldZCC5ZMecOwOymqIXDCb3cQIQTxiOijrwhXv9MhnbEipy581m2TMMB0
 OoCcRK3+iBxp19PYe5DQR6ZMIwtNgSJzbKdngZVWMxtds5WSopHa04zxjxjcB/qydZc3
 PsZDDxmI83gX7G9ST5/j2tr0/QXdiLld+OX3qcRWDJh6pFswXgXMQIOD1+DgxbWpmc6+
 ON/9nfRZWIW7OgjJwoEB2Is/8saBqJZHU7qu2s9jaYoSKE6rkw7KKSSKY63y6jWPOWmZ
 MqvcaaXOzuA2SSvm5tXuLdXRZkVpdYoU/Ed8D4Y5PqSmQG/hO/0I8fz+6a30MpU2gReR
 Wn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686165347; x=1688757347;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bS5nlC4EcdlXmAJkGrfbY/FSI7ZzjpOcEAyzjrb5rgw=;
 b=D2fP39Q1FHpuTVvkGAwG7EgnwzzHXrb4FdmHHiCRIe/d5pqdlf2qDQu6urs9Ntu+UR
 ZP62W7BOpBdtWZmdbrWQ1ilPhAcLIuRoULeXyNkSxlD5pXUXEd0sYx9yK0FYMtkz4KZD
 YsmhR4abhaHMj1rcdosasD5vckwsQhL5ozkHnJUxQTdYJ1/bqzs9QIxg376IC5dWJPSe
 fDoJjZ8JgsARifdFgJXU+fDgjcFpS23MylchSLDbPZN9Z4/cnVhVc6v5VqVvGrEyYq00
 uw//VWAqTwma/+4RYwnYmXFwVp59pPTmYacIjiZaKBUiuTrxB61N0gaP8Zk0qGwQU9zG
 e5CQ==
X-Gm-Message-State: AC+VfDz49bG4BHca++C6V60fo5L635oCoURjR3WwE83D1zv+VCNFxBwi
 AIzoRHOVUsuvj8fqxB6VtEJnZQ==
X-Google-Smtp-Source: ACHHUZ6sMlUa261AjJFU5AGOKRoT7t68VwSvIxI+nerAVte9149lH5nmbGy7+jF+IsuiZqa4hIqYZg==
X-Received: by 2002:a17:902:c614:b0:1a0:76e8:a4d with SMTP id
 r20-20020a170902c61400b001a076e80a4dmr13126880plr.14.1686165347367; 
 Wed, 07 Jun 2023 12:15:47 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:1f09:2b0b:a56e:7a17?
 ([2602:ae:1598:4c01:1f09:2b0b:a56e:7a17])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a170902a50a00b001a64851087bsm10773521plq.272.2023.06.07.12.15.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 12:15:46 -0700 (PDT)
Message-ID: <a7d4ae32-a779-e50a-d484-fdfc07a305c1@linaro.org>
Date: Wed, 7 Jun 2023 12:15:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC v2 4/6] target/mips: Add native library calls
Content-Language: en-US
To: Yeqi Fu <fufuyqqqqqq@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
 <20230607164750.829586-5-fufuyqqqqqq@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230607164750.829586-5-fufuyqqqqqq@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 6/7/23 09:47, Yeqi Fu wrote:
> +void helper_native_memcpy(CPUMIPSState *env)
> +{
> +    CPUState *cs = env_cpu(env);
> +    NATIVE_FN_W_3W();
> +    void *ret;
> +    void *dest = g2h(cs, arg0);
> +    void *src = g2h(cs, arg1);
> +    size_t n = (size_t)arg2;
> +    ret = memcpy(dest, src, n);
> +    env->active_tc.gpr[2] = (target_ulong)h2g(ret);
> +}

I would expect everything except for the guest ABI to be handled by common code, so that 
you do not have N copies of every native emulated function.  This needs to be something like

abi_ptr do_native_memcpy(CPUArchState *env, abi_ptr dst, abi_ptr src,
                          abi_ptr len, uintptr_t ra);

void helper_native_memcpy(CPUMIPSState *env)
{
     env->active_tc.gpr[2] =
         do_native_memcpy(env, env->active_tc.gpr[4],
                          env->active_tc.gpr[5],
                          env->active_tc.gpr[6], GETPC());
}

Even better, provide some guest abstraction akin to va_start/va_arg so that all of the 
per-native function code becomes shared.


r~

