Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48134781136
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:06:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX2um-0005fV-Ps; Fri, 18 Aug 2023 13:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX2uZ-0005bo-8x
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:05:24 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX2uW-0006hu-AD
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:05:22 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b9b904bb04so18252611fa.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378318; x=1692983118;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=php5sYodc4HHGmotxhihN653QTZrU8HbzRy+YarPOdo=;
 b=zmW0SczY1wKPVNI1wgom1ZtcT+ZJC5Pwgfh1ksz6DlkH+dPkm1q0srGNh7D4GT+jhD
 8HEtOqpUIDyeade5IhmvIhVtoH4/ZRfPX4LzrRpdWT0DPWGjQxxhYyMVAlzDxBM+h20B
 oqeBkkvq5i581c6ZaIMPfLZFvKr0S+f3JDa4nqbs6lum4CBZak+kcJm1HfTLPnC+PKt4
 Nq7ULpleKO4RDx19joBoXhx3lYFp9qJ1Pq7BApC2W8fmUo+wYU7T+M+P1Vj+5S/osVk0
 6qjj+8wW0Sk/TMb8UAJTICRpgDbHmgnAhzzSMUpSNLNjzj0hIHoA67OE0A4aSC0DJFP8
 cV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378318; x=1692983118;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=php5sYodc4HHGmotxhihN653QTZrU8HbzRy+YarPOdo=;
 b=gEUAaZouOymqbDsEm44wC9XfW2sDY1eWZg246OnV0DDJBmKRrCu3hMb5WuqbzpXU3H
 ZOl7FJuwUzK8aIROnmUeb7YsZ1+d29sEJRYjGFzzXBNVTuauOGu87G9OfWG0CXhs+/+h
 RMs950Nt1cC4jFW0KehSi1+EJW22NO5VKgzkiCA0nxiZeRG4OxIAtFmOWcGbEO7wQkGv
 UNX6xSkLHkydMZiS83f10Kfah+nJ+UPk+4T1Bf8eZXAc06/xFe2Fp1rGm/T4NhuLsVS4
 PMJg9G72jYImyBXcDvf/LITXzJlAJoJgJLtSkVjks6LJIvOUN1nBn72SQYhwKqQTF9iK
 e58g==
X-Gm-Message-State: AOJu0Yyp1r7ilrM9dlTn0RsElb6dz8SbdhqRjh89mnwxHBBPCjB65jWg
 Tdf2L0VYu4HVKmNYfPSeir6hkg==
X-Google-Smtp-Source: AGHT+IF3+R/B8uF1DPzGIDaW/XV6m2vqYdrKPp7U5SB4HSqbVAi5vA/uVPHhHiic9GWK3NngaB+syA==
X-Received: by 2002:a2e:8881:0:b0:2b9:e831:f15f with SMTP id
 k1-20020a2e8881000000b002b9e831f15fmr2347206lji.32.1692378317867; 
 Fri, 18 Aug 2023 10:05:17 -0700 (PDT)
Received: from [192.168.69.115] (cnf78-h01-176-184-27-79.dsl.sta.abo.bbox.fr.
 [176.184.27.79]) by smtp.gmail.com with ESMTPSA id
 y17-20020a170906525100b00992c92af6f4sm1406699ejm.144.2023.08.18.10.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 10:05:17 -0700 (PDT)
Message-ID: <ee302180-616c-23eb-1b3d-26e9ba3a5e29@linaro.org>
Date: Fri, 18 Aug 2023 19:05:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 08/18] target/loongarch: Truncate high 32 bits of
 address in VA32 mode
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: c@jia.je, maobibo@loongson.cn, yangxiaojuan@loongson.cn,
 yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230817093121.1053890-1-gaosong@loongson.cn>
 <20230817093121.1053890-9-gaosong@loongson.cn>
 <095e6d5a-a19d-abc0-4a9a-d23dddd33755@linaro.org>
 <b03c7041-83c1-3a79-da4e-a2a5fd523c22@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <b03c7041-83c1-3a79-da4e-a2a5fd523c22@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.454,
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

On 18/8/23 17:25, Richard Henderson wrote:
> On 8/18/23 02:41, Philippe Mathieu-Daudé wrote:
>>> +static inline void set_pc(CPULoongArchState *env, uint64_t value)
>>> +{
>>> +    if (is_va32(env)) {
>>> +        env->pc = (uint32_t)value;
>>
>> That would become loongarch32_cpu_set_pc().
>>
>>> +    } else {
>>> +        env->pc = value;
>>
>> This is the current loongarch_cpu_set_pc().
> 
> No, it would not.  LA64 has a 32-bit address mode, much like MIPS, 
> Power, and others.

Got it!


