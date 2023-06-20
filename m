Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2709737161
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:24:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBe9K-0004hx-8H; Tue, 20 Jun 2023 12:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBe9I-0004hW-3m
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:24:08 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBe9G-0005xA-JR
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:24:07 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-519c0ad1223so6052958a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 09:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687278244; x=1689870244;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tRg0XuoqRlFKU4g3Sn9PAxcBhRPkgu72HvhpDBUsS5c=;
 b=C2gsNzk/sfWvYFGa9pllfgTKkO1+XV6/+NFVCaAwQ0k8Bcfuk6nJsMe+fD0Lwn+Tqs
 7hXutvbaUy+FE9UUbqjE1dY0TLyUjw9JEusYIdFhfVkclOGXRa8qB2Rj/nVyxWlspLQH
 SniEdxWxl0rI83iiR5s968+sE+LiCIwuBK0NbAFDtH48ALMf1NlFKu+74Fd2+5Q161FR
 akkgXS1mXvji7caQ1kWosoIBv+aTUjtkZGSRHT5PRSc413PDsL7CdKk8Pm52lcqBXtb8
 E6mbLeoy5dZTSeteUNHWTH+J4I/YMhfQ+UodrcakoQEcY23IjEBxprgBKWqt7VWmNqkL
 J9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687278244; x=1689870244;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tRg0XuoqRlFKU4g3Sn9PAxcBhRPkgu72HvhpDBUsS5c=;
 b=X/0bLZeHQ1YaeRsomWqwBZeKmw0ud9DMjDM8Qnlva2SG3GAzKL+VTW2ekWd++6oY7H
 HzUK7C5MAQJQ4EoRDk/31eL0LquS3hCiee4HaB9ZeAs28uEOZ1LrYyycT7baXpr+rTNh
 S6SUcdMwkUrIBg8wEPSP62Icag+dfmVNg3dpHNGOedzEWrGyuSkSKEA9OwiYEm8brbMB
 tFLV4k6QyhdCWSuyM5pIncLzz3x33KPIaBzpMBNMeaFAdZrjFJrJnVmpdz9IYySbQApX
 uuGi5HIh4kKEOokse4M+BSRoRs7KuzOO4jmykHo7izC0+ifTb/lJ/awOO+DVrHnMyTIt
 B3Bw==
X-Gm-Message-State: AC+VfDxqeZ5gnjpburMh7DLNAYMtcHjE7w5R+epSfzf+ZqsXP6Wr53j4
 dNpKkUA+WtFbFcDGQ6snYnB0zQ==
X-Google-Smtp-Source: ACHHUZ6cTenyC9ydWIBAdooX502U7cYpkZGxPIlbOLljQl07Wu/7/2Z23tKbvogaOfOdoG4qLenbkA==
X-Received: by 2002:a05:6402:1504:b0:51a:5f4f:1bd2 with SMTP id
 f4-20020a056402150400b0051a5f4f1bd2mr3859636edw.23.1687278244581; 
 Tue, 20 Jun 2023 09:24:04 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 bo4-20020a0564020b2400b0051a59d81c4dsm1442652edb.3.2023.06.20.09.24.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 09:24:04 -0700 (PDT)
Message-ID: <c0624482-6b69-70f7-4d02-88d150822e7a@linaro.org>
Date: Tue, 20 Jun 2023 18:24:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 03/10] target/i386: TCG supports RDSEED
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230620151634.21053-1-pbonzini@redhat.com>
 <20230620151634.21053-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620151634.21053-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/20/23 17:16, Paolo Bonzini wrote:
> TCG implements RDSEED, and in fact uses qcrypto_random_bytes which is
> secure enough to match hardware behavior.  Expose it to guests.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/cpu.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index ff3dcd02dcb..fc4246223d4 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -657,11 +657,10 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>             CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ADX | \
>             CPUID_7_0_EBX_PCOMMIT | CPUID_7_0_EBX_CLFLUSHOPT |            \
>             CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_FSGSBASE | \
> -          CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2)
> +          CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_RDSEED)
>             /* missing:
>             CPUID_7_0_EBX_HLE
> -          CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM,
> -          CPUID_7_0_EBX_RDSEED */
> +          CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM */
>   #define TCG_7_0_ECX_FEATURES (CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU | \
>             /* CPUID_7_0_ECX_OSPKE is dynamic */ \
>             CPUID_7_0_ECX_LA57 | CPUID_7_0_ECX_PKS | CPUID_7_0_ECX_VAES)

Still missing the check for CPUID_7_0_EBX_RDSEED at the RDSEED insn.


r~

