Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF0876D6A8
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 20:17:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRGNX-0002cp-Fk; Wed, 02 Aug 2023 14:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRGNU-0002cE-DL
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 14:15:20 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRGNS-00028Z-Q2
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 14:15:20 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bb893e6365so1117365ad.2
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 11:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691000116; x=1691604916;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3wOR0kQWOcIzlKyOpLj9KPr1CfNwBQ3Dgeld4x3FsTs=;
 b=boMO9HO2gilTBhniKMQjkj5snZIWQI+5o3am7qjbuRRQkuyPKCn9KqD+XC1qQqtm3P
 GBEr9jwfZFa8WNMrAeFUT5q9jnI4rF7xY5LdDJhwykw/SwPzRRhW4GXXX3O1Io7+7xKN
 WA9yAHw7SOaCsDjNx56v9rOAyhowwWxm5+SK7VAlqGWB1XrdWDL2hTaarFErJjbNWq0D
 rTvE/Bqlv0/jObj58XaCg1MXyFvXX4LEwIQb9HBcwLZYBbV2dfxQv1YOonPQccSoZeFs
 cTJDgkOvyMwRr13LMHKbxbok9XSS7e0GQOp+96dO2fxnJ02GPUfjPt3kkefeguvUeFHT
 ANtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691000116; x=1691604916;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3wOR0kQWOcIzlKyOpLj9KPr1CfNwBQ3Dgeld4x3FsTs=;
 b=VM39xTXkDNM+b2Y0N1rbENrWDeUmE4BvvoHx5NiNqGJ6YqfO9sCRPB6WyL2rxEGk/G
 yWNmClznVpMqe3NDg2Z5X3vvpEgcHa/irmIUMxPSSMqrhuFw8cELlcd596YehSsK9Uo3
 CgjOuVi/B+XiAVd0QABVMrPzr5U4OHjFqd9Tlf0QL4J/xa6VTwS5j/moRgZaP6TDQZkB
 076ZBhshQakGzvqo7jUknuqSaZcJ7Xdj3B/2QG8wleSUMXb/jICO6MEULLyn6//23mje
 KXVXYel9KlUeHZ6IDx7i5L7tMN8zUMIGuxgGonvt8JHi9ZdsjxfoUCgwhiWloaBTXQr1
 op8g==
X-Gm-Message-State: ABy/qLZZCe+N9bZDMDApTDoa2alQcIV5UxDDI2A/wRhUpkPyc7rPWNHn
 vywBpjVIvnUhzwu8LXdRx+wDXw==
X-Google-Smtp-Source: APBJJlGomX+/MPLnVu8cNW2LOJYL0mWfqbaM/hS1pUQUmVpU7LovZWUAhR0qANJiXHQFaTK3Bx4XwQ==
X-Received: by 2002:a17:903:32ce:b0:1b6:79e3:636d with SMTP id
 i14-20020a17090332ce00b001b679e3636dmr19458885plr.58.1691000116511; 
 Wed, 02 Aug 2023 11:15:16 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:b659:bbad:1a22:7ef9?
 ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 y23-20020a17090264d700b001a6d4ea7301sm12896145pli.251.2023.08.02.11.15.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 11:15:16 -0700 (PDT)
Message-ID: <52cb992d-90b5-e28c-8184-6f3637f2459e@linaro.org>
Date: Wed, 2 Aug 2023 11:15:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] linux-user: Emulate /proc/cpuinfo on aarch64 and
 arm
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230801230842.414421-1-deller@gmx.de>
 <20230801230842.414421-3-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230801230842.414421-3-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
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

On 8/1/23 16:08, Helge Deller wrote:
> +#if defined(TARGET_AARCH64) || defined(TARGET_ARM)
> +static int open_cpuinfo(CPUArchState *cpu_env, int fd)
> +{
> +    const int is64 = TARGET_ABI_BITS == 64;
> +    ARMCPU *cpu = ARM_CPU(thread_cpu);
> +    uint64_t midr = cpu->midr;
> +    const int rev  = (midr & 0xf);
> +    const int arch = is64 ? 8 : 7;

The 32-bit arch is not automatically v7: -cpu max is v8 and -cpu ti925t is v4.

You need an if ladder for this:

     if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
         arch = 8;
     } else if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
         arch = 7;
     } else if (arm_feature(&cpu->env, ARM_FEATURE_V6)) {
         arch = 6;
     } else if (arm_feature(&cpu->env, ARM_FEATURE_V5)) {
         arch = 5;
     } else {
         arch = 4;
     }

Also,

     ref = FIELD_EX64(cpu->midr, MIDR_EL1, REVISION);

etc, instead of masking by hand.

> +        dprintf(fd, "model name\t: ARMv%d Processor rev %d (%s%c)\n",
> +            arch, rev, is64 ? "v8" : "armv7",

Will need adjustment.

> +#if TARGET_BIG_ENDIAN
> +            'b'
> +#else
> +            'l'
> +#endif

Don't need an ifdef: (TARGET_BIG_ENDIAN ? 'b' : 'l').

> +        dprintf(fd, "CPU implementer\t: %#02x\n", (int)(midr >> 24) & 0xff);
> +        dprintf(fd, "CPU architecture: %d\n",     arch);
> +        dprintf(fd, "CPU variant\t: %#x\n",       (int)(midr >> 20) & 0xf );
> +        dprintf(fd, "CPU part\t: %#03x\n",        (int)(midr >> 4) & 0xfff);
> +        dprintf(fd, "CPU revision\t: %d\n\n",     rev);
> +    }

FIELD_EX64(midr, MIDR_EL1, ...)

Though I have some memory of these fields changing across arch versions.
You might need to extract them earlier, within the if ladder.


r~

