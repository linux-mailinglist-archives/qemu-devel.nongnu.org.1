Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E2A78084D
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 11:31:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWvnq-00070i-AP; Fri, 18 Aug 2023 05:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWvnn-00070X-Ku
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:29:55 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWvnl-0006wg-8j
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:29:55 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5234f46c6f9so861063a12.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 02:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692350992; x=1692955792;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dbSVVpJeAp7w3Zk7Y13X7ZjeTi+XoDMcA8frpilYA/c=;
 b=E2M03ojcf3rxEEi+3BcnIGbQA0A2X7Bdf2G1jBavODuDwMSOY5GTzQCLdycEStZtGo
 vsUITLp21O+555rgNZ15vhPgG+pc9JrtZcrT3bTGMsoMNTN14+6WTYhADkzluO0wT0Kq
 oupqNKTfyvL9mTtxzEVLHgZWDjCGMm174dUtMLqH/2honnPUm43TP/V7NOJwGORN5cQh
 gs7amMLfCJbUGQvvws7FlpCI52zhwCi/au/mIU0JMItkbLz327stqbbfU94XhlkqSNzt
 w2JvQAoW1w7b6qhLVP/GYM6kAQBzP3D+nmYH/Iw8Jl8U1nTN5ciiB90cTZhuca/B1st4
 Wwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692350992; x=1692955792;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dbSVVpJeAp7w3Zk7Y13X7ZjeTi+XoDMcA8frpilYA/c=;
 b=IoNxLduwnIQFCOoP2+D1DbvxaOR9XiaPy8DEMH7mR5wgiBYKlw1qyxPPMadTBVwxvf
 NoSxB5A/OPMRp6wsx7+OD5OwNDIYuuK+jJ2QEYCU19cg865lyH1/hfGwJSy0agKW31xL
 PpHj7Jts3TKj3dKVGValLElQf4UKkycYy/GPE4493BK+e8QgmXDqQ1BBDvyhhXetNeOH
 qSK4ETh756Yk47Zn3kG9J2GAYty6bht6RnwSm/NqsJgayzzoeqKxtp9hkCgHzhH0A2XU
 cYmDvUThUtpiESCMV2sIBBb5r2mA1HGhETpkWhsrvkw+H2Hg7gH8RlqxmpDH/owG6NU3
 vzLQ==
X-Gm-Message-State: AOJu0Ywsu3VEeAvLnfN0Drz5HzbCbdsfH6iNO5Dg1tcX4h+YdrYwKRwE
 yT0M8tuW3wTMBSMerqIF4FNbHp9gdUfPG3Bwawo=
X-Google-Smtp-Source: AGHT+IGvfYNnj+w1TRhvYST+cvbpo6Zh0l84CQ1CQw/jz+OUh5epa2nzzziRggyCrtRc0Iq0gIZo5Q==
X-Received: by 2002:a50:ee07:0:b0:523:3ff6:dfc2 with SMTP id
 g7-20020a50ee07000000b005233ff6dfc2mr1805320eds.29.1692350991801; 
 Fri, 18 Aug 2023 02:29:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.184.114])
 by smtp.gmail.com with ESMTPSA id
 e8-20020aa7d7c8000000b005231e1780aasm860159eds.91.2023.08.18.02.29.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 02:29:51 -0700 (PDT)
Message-ID: <a650e078-bfdd-cb94-dbd3-923d7c16f7c8@linaro.org>
Date: Fri, 18 Aug 2023 11:29:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 13/18] target/loongarch: Add loongarch32 cpu la132
Content-Language: en-US
To: c@jia.je, Huacai Chen <chenhuacai@kernel.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Song Gao <gaosong@loongson.cn>, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230817093121.1053890-1-gaosong@loongson.cn>
 <20230817093121.1053890-14-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230817093121.1053890-14-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.01,
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

On 17/8/23 11:31, Song Gao wrote:
> From: Jiajie Chen <c@jia.je>
> 
> Add la132 as a loongarch32 cpu type and allow virt machine to be used
> with la132 instead of la464.
> 
> Due to lack of public documentation of la132, it is currently a
> synthetic loongarch32 cpu model. Details need to be added in the future.
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/virt.c    |  5 -----
>   target/loongarch/cpu.c | 29 +++++++++++++++++++++++++++++
>   2 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 8d95c997dc..95e00a044c 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c


> +static void loongarch_la132_initfn(Object *obj)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +    CPULoongArchState *env = &cpu->env;
> +
> +    int i;
> +
> +    for (i = 0; i < 21; i++) {
> +        env->cpucfg[i] = 0x0;
> +    }
> +
> +    cpu->dtb_compatible = "loongarch,Loongson-1C103";
> +
> +    uint32_t data = 0;
> +    data = FIELD_DP32(data, CPUCFG1, ARCH, 1); /* LA32 */
> +    data = FIELD_DP32(data, CPUCFG1, PGMMU, 1);
> +    data = FIELD_DP32(data, CPUCFG1, IOCSR, 1);
> +    data = FIELD_DP32(data, CPUCFG1, PALEN, 0x1f); /* 32 bits */
> +    data = FIELD_DP32(data, CPUCFG1, VALEN, 0x1f); /* 32 bits */
> +    data = FIELD_DP32(data, CPUCFG1, UAL, 1);
> +    data = FIELD_DP32(data, CPUCFG1, RI, 0);
> +    data = FIELD_DP32(data, CPUCFG1, EP, 0);
> +    data = FIELD_DP32(data, CPUCFG1, RPLV, 0);
> +    data = FIELD_DP32(data, CPUCFG1, HP, 1);
> +    data = FIELD_DP32(data, CPUCFG1, IOCSR_BRD, 1);
> +    env->cpucfg[1] = data;

So we have PRid = env->cpucfg[0] = 0...

The LA132 series is 0x8000, so we can use smth like:

        env->cpucfg[0] = 0x148042;  /* PRID */

> +}
> +
>   static void loongarch_cpu_list_entry(gpointer data, gpointer user_data)
>   {
>       const char *typename = object_class_get_name(OBJECT_CLASS(data));
> @@ -779,6 +807,7 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
>           .class_init = loongarch32_cpu_class_init,
>       },
>       DEFINE_LOONGARCH_CPU_TYPE("la464", loongarch_la464_initfn),
> +    DEFINE_LOONGARCH32_CPU_TYPE("la132", loongarch_la132_initfn),
>   };

CPUNAME_REG in loongarch_qemu_read() is likely incorrect, but not a
big deal.

