Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBCE77482E
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 21:28:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTSLt-0007Do-9N; Tue, 08 Aug 2023 15:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTSLr-0007Dg-5l
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 15:26:43 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTSLp-0003a5-CQ
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 15:26:42 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bbc06f830aso1468915ad.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 12:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691522799; x=1692127599;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G57+QLp/Q50AvK+z5c7yqYc+RRe5NrRiRa/4zojgaxo=;
 b=WUOTonUg5LyYkg9FiENfUD5HVSkn1xXLvhhm93LMt2t371cUNZcsPVecFCLItuSLKA
 dVrd+7u3US/v2wiJAEc1aWAZ2NuLi3iBzF9EeH/YO9bb3ys8JhxwRUaZTbe2TwDdMiwE
 jUQJxe0+yUaCurE53LqF2OYFKhsx6K9URW8xmFFuXdJeWYEtqpU0MvIDB1unuQUcctiK
 yQpj3ownolzQBVV07DmYxLY95mBaXVK1MpjahyEZt5INXzRPdui2Rlewh0R5zf45bScv
 3kluFovkwJM+HbupmhvhoPsBPsLh/rxXULZtvgIffkcXefYELnYeJEyev+9kZ9bFG2Qf
 f7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691522799; x=1692127599;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G57+QLp/Q50AvK+z5c7yqYc+RRe5NrRiRa/4zojgaxo=;
 b=SM8z0xmjef11q672gSWgE56PP5kZcdhj5C8QZt0NUvzkDDRsrmgOBqtB1ZWiLQtVpP
 mAx5SEyRO1IUbu9taAGE6bLa4ooKkVF6bm8JBV20QofFRrWWTAdR8hsAdIPP+qaM/ZHA
 QkaZZJJ1KvnhthIDCfJHPxQtfA60rwQSEbn1pdNDgdxrGyvPAexSRFNaMsUQtORFwwKJ
 PoVjuczuPmrrX0dlKCfgMuoEGpePwq5rjyDSJfnJrZ2ZfFI1TbZzuI30oz/FTPXjD8g9
 mPFQDLwNThaTwshnZIJygcwYtNZj7/pif4r94cG5N4i2te8fogFXBoRSZC0kcoZvzolC
 3HPA==
X-Gm-Message-State: AOJu0YySEC1XV86sWoaH0bhdoEypXKlZ6FuLpt01mjwG0w7vcZ+gRrlP
 ciu0L8G7FyzawMDr3pERs4xEKg==
X-Google-Smtp-Source: AGHT+IFN1GC2ZEkrVIkVCeb6PEpOvvt5wU1vgNTyfpNQWpb5O3l/nw6bN5D75/FyzYsx5vBkC4iQ3Q==
X-Received: by 2002:a17:902:b191:b0:1bc:e37:aa76 with SMTP id
 s17-20020a170902b19100b001bc0e37aa76mr10106899plr.6.1691522799464; 
 Tue, 08 Aug 2023 12:26:39 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a639d05000000b005637030d00csm7006490pgd.30.2023.08.08.12.26.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 12:26:39 -0700 (PDT)
Message-ID: <cc87d409-861a-a3dc-eb3b-57e58c88619a@linaro.org>
Date: Tue, 8 Aug 2023 12:26:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 11/11] target/loongarch: Add loongarch32 cpu la132
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, gaosong@loongson.cn,
 i.qemu@xen0n.name
References: <20230808015506.1705140-1-c@jia.je>
 <20230808015506.1705140-12-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808015506.1705140-12-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 18:54, Jiajie Chen wrote:
> +static void loongarch_la464_initfn(Object *obj)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +    CPULoongArchState *env = &cpu->env;
> +
> +    loongarch_cpu_initfn_common(env);
> +
> +    cpu->dtb_compatible = "loongarch,Loongson-3A5000";
> +    env->cpucfg[0] = 0x14c010;  /* PRID */
> +
> +    uint32_t data = env->cpucfg[1];
> +    data = FIELD_DP32(data, CPUCFG1, ARCH, 2); /* LA64 */
> +    data = FIELD_DP32(data, CPUCFG1, PALEN, 0x2f); /* 48 bits */
> +    data = FIELD_DP32(data, CPUCFG1, VALEN, 0x2f); /* 48 bits */
> +    data = FIELD_DP32(data, CPUCFG1, RI, 1);
> +    data = FIELD_DP32(data, CPUCFG1, EP, 1);
> +    data = FIELD_DP32(data, CPUCFG1, RPLV, 1);
> +    env->cpucfg[1] = data;
> +}
> +
> +static void loongarch_la132_initfn(Object *obj)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +    CPULoongArchState *env = &cpu->env;
> +
> +    loongarch_cpu_initfn_common(env);
> +
> +    cpu->dtb_compatible = "loongarch,Loongson-1C103";
> +
> +    uint32_t data = env->cpucfg[1];
> +    data = FIELD_DP32(data, CPUCFG1, ARCH, 1); /* LA32 */
> +    data = FIELD_DP32(data, CPUCFG1, PALEN, 0x1f); /* 32 bits */
> +    data = FIELD_DP32(data, CPUCFG1, VALEN, 0x1f); /* 32 bits */
> +    data = FIELD_DP32(data, CPUCFG1, RI, 0);
> +    data = FIELD_DP32(data, CPUCFG1, EP, 0);
> +    data = FIELD_DP32(data, CPUCFG1, RPLV, 0);
> +    env->cpucfg[1] = data;
> +}

The use of the loongarch_cpu_initfn_common function is not going to scale.
Compare the set of *_initfn in target/arm/tcg/cpu32.c

In general, you want to copy data in bulk from the processor manual, so that the reviewer 
can simply read through the table and see that the code is correct, without having to 
check between multiple functions to see that the combination is correct.

For our existing la464, that table is Table 54 in the 3A5000 manual.

Is there a public specification for the la132?  I could not find one in 
https://www.loongson.cn/EN/product/, but perhaps that's just the english view.


r~

