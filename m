Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BB77A5A11
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 08:42:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiUQs-0006Fz-Jr; Tue, 19 Sep 2023 02:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qiUQr-0006Fp-Bh
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 02:42:01 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qiUQp-0003bS-Or
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 02:42:01 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-530ab2d9e89so4012137a12.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 23:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695105716; x=1695710516; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q/tfBxN/NXggd16foxJu/ZBUi4cONdS2FDezZB493rA=;
 b=P2Se0ZfeqsQo9+S7ZkhD3Uf8t0Q0/uuNDfYMuGVS/VaOxXlXbH9EQ2YIf5vmCT0ni9
 fbQf3UHCH7Dy39w19sXcR9pvGyVUdG0j8IN2EbB9F7/U3XIOqS8JCR7NW5uTomvgfp4J
 blngNPwunmp7Ab1k91wd913j3Xk+q8f6qnvzYYRRdD5z32qHL1gzW5lm9w4++VDoZ675
 SWWdVFLhYJowSa7icyjsMBTpczIFIwC/li4rjSC927kXGLIBjDXQ9XVj/VKgc1fxIRYl
 52hzV/K9dnYGDh9CgpSdWX7stIeC2Gs6OBm6aAOsjPu26o6it0fIXwd+JkSiwPWxEMMO
 cstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695105716; x=1695710516;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q/tfBxN/NXggd16foxJu/ZBUi4cONdS2FDezZB493rA=;
 b=Qsigu4PYGodmIHHHPubv+RGX+BFqw/PrMONYhB9QUeRSJJwR4Cdfp0ozqR1i6nyHTT
 Jo8bqPJqOd4JGFhHIZEeTJstWBpX6ez773eBT8M9yItaVRdsGQkrQWPRqHbynyd6aHpB
 rUOmBSggHC15NIqNvC4Ynabiwf93oEaKYm5KINj/H/+mLJRTsa8nOlsnhWyYxgtHpqTx
 5C3LeLy0nt77ydANMUjxg8JWIZWhLaOVxBep2eLXLBJQfGp89ok9uvjfkDXYGSqxN24g
 AFnpCyZX84wx/N3SkeS53F2j7eAl7ojKLBZhC2poiV8PYGuNs++IOqH3ZfUNTpDUYdfv
 pPsA==
X-Gm-Message-State: AOJu0YxQbHZV7wiYs7q5gxZ7gLH/W7ViCSs1d4GN595Uj5Y4olcfCknV
 1i5uzEaDf6iZ+JXN6H3Sbvbczg==
X-Google-Smtp-Source: AGHT+IEt9oTgGJ0E6wqgmY/j1HQyWWr7Vr8IIRmSp21t4yBgiknO6Y3kKK9JX1/ulAStx3BLYoqLCg==
X-Received: by 2002:a17:907:2cc9:b0:9aa:1e43:d0b9 with SMTP id
 hg9-20020a1709072cc900b009aa1e43d0b9mr8654250ejc.5.1695105715846; 
 Mon, 18 Sep 2023 23:41:55 -0700 (PDT)
Received: from [172.20.66.192] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 t25-20020a1709064f1900b009ad8084e08asm7334861eju.0.2023.09.18.23.41.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 23:41:55 -0700 (PDT)
Message-ID: <6f97e558-f070-2d9e-74db-e3d612b10065@linaro.org>
Date: Tue, 19 Sep 2023 08:41:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] hw/misc/mips_itu: Make MIPSITUState target agnostic
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230918073023.3846-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230918073023.3846-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 9/18/23 09:30, Philippe Mathieu-Daudé wrote:
> @@ -530,9 +530,12 @@ static void mips_itu_realize(DeviceState *dev, Error **errp)
>       if (!s->cpu0) {
>           error_setg(errp, "Missing 'cpu[0]' property");
>           return;
> +    } else if (!object_dynamic_cast(OBJECT(s->cpu0), TYPE_MIPS_CPU)) {
> +        error_setg(errp, "MIPS ITU expects a MIPS CPU");
> +        return;
>       }
>   
> -    env = &s->cpu0->env;
> +    env = &MIPS_CPU(s->cpu0)->env;
>       if (env->saarp) {
>           s->saar = env->CP0_SAAR;
>       }...
> @@ -563,7 +566,7 @@ static Property mips_itu_properties[] = {
>                        ITC_FIFO_NUM_MAX),
>      DEFINE_PROP_UINT32("num-semaphores", MIPSITUState, num_semaphores,
>                        ITC_SEMAPH_NUM_MAX),
> -    DEFINE_PROP_LINK("cpu[0]", MIPSITUState, cpu0, TYPE_MIPS_CPU, MIPSCPU *),
> +    DEFINE_PROP_LINK("cpu[0]", MIPSITUState, cpu0, TYPE_CPU, CPUState *),
>      DEFINE_PROP_END_OF_LIST(),

I think you want to keep TYPE_MIPS_CPU here.  If you do that, I believe you could remove 
the dynamic_cast check above and let the MIPS_CPU macro assert, because the link cannot be 
set with an incorrect type.


r~

