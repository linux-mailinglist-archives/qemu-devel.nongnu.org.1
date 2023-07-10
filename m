Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC4E74D42B
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 13:04:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIofs-00084T-0t; Mon, 10 Jul 2023 07:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIofc-00083Q-Ej
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 07:03:08 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIofa-0007bu-CP
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 07:03:08 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51e35791a83so4558923a12.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 04:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688986984; x=1691578984;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IG7XheuJQGDsZFQTfCkf4wf9j3JZvm+M4kEuHZWmXsE=;
 b=QsqRt38BE3H6EiDL6D5w7uXR4xMK55QgHO2a5+uc+bETtASEHrkHSN0CWKwdX+NuyH
 kEdtUMpzw3HFBLoNHjs9+CXR5kmrnddYbbBzPHHkUzVau3g9wNKudbFDz9w3EUH1L5my
 yEEaYQmB9oqjsbIFWKEetUTrx8d4u7CLhOvXudzHIrxoJ7vwV18qJUUAk/xvtQvTBuOE
 ixdJUZKsyRkiDhqE18ioeksoh+YHEmUFgZZGkElt8aDNUsP0yQMIsYX7/Mc6210m5dtW
 hjEDDmVuPFt7lsqqCobcn27DILL40UtxG/DS5NdrbY2dIKeK4beIoHF86iaukfdhXTWa
 1iTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688986984; x=1691578984;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IG7XheuJQGDsZFQTfCkf4wf9j3JZvm+M4kEuHZWmXsE=;
 b=j5CSyyfsHeBm0th2beodhzl2igNzRAeLERjqklD3r7lW4hi4uLR7R1/X3/vHJop7XB
 EMztA/5jquB0bKdiU+QuYrZzYc+PG8Fpf8aZLw4tTwvsxAQGFsuiOYlBW79ij8CPYR+K
 jSTVEGJbrPJnjXpFtufTRlMM3aQVAAIdZs8QOLP+A2legkzP1tI7Sv0YiJIC/N/7BYnG
 mNmaz3TMQdbxrjU3fztQrRBgO8xMQ8qdChgvV97j1uvA+zOEs3j8H3jz9spkZ4zk5uDG
 49lltNlhJx4/au308Ck4Smu7vqTujmkg1IBxXIzKyBghKNw0Wq6V3SzCWXJMAHqbsA2J
 w+hQ==
X-Gm-Message-State: ABy/qLauDN93aNp5jUwcHyvLEbrzs0GCpo/8/BF0Sw1RWMsh3CEBkurZ
 h/PciNYf9eW6xh5NYeR/dWhkdA==
X-Google-Smtp-Source: APBJJlEIvuZcCIi1klkElZPXOwEVKDklhzyL35wIgTMcv5Xk77AxWYKiFV88kMTKxgt37h3k71SbCg==
X-Received: by 2002:a17:907:b9d3:b0:993:6382:6e34 with SMTP id
 xa19-20020a170907b9d300b0099363826e34mr9664197ejc.72.1688986984473; 
 Mon, 10 Jul 2023 04:03:04 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 xo15-20020a170907bb8f00b00982d0563b11sm5954273ejc.197.2023.07.10.04.03.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 04:03:04 -0700 (PDT)
Message-ID: <62d0d9d2-f802-60d4-8e67-645ce1290a68@linaro.org>
Date: Mon, 10 Jul 2023 13:03:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] target/mips: Implement Loongson CSR instructions
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: yangxiaojuan@loongson.cn, gaosong@loongson.cn, chenhuacai@kernel.org
References: <20230521214832.20145-1-jiaxun.yang@flygoat.com>
 <20230521214832.20145-2-jiaxun.yang@flygoat.com>
 <9b8fcbe7-af56-7265-75ea-817460dbf6e8@linaro.org>
In-Reply-To: <9b8fcbe7-af56-7265-75ea-817460dbf6e8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 22/5/23 08:00, Philippe Mathieu-Daudé wrote:
> Hi Jiaxun,
> 
> On 21/5/23 23:48, Jiaxun Yang wrote:
>> Loongson introduced CSR instructions since 3A4000, which looks
>> similar to IOCSR and CPUCFG instructions we seen in LoongArch.
>>
>> Unfortunately we don't have much document about those instructions,
>> bit fields of CPUCFG instructions and IOCSR registers can be found
>> at 3A4000's user manual, while instruction encodings can be found
>> at arch/mips/include/asm/mach-loongson64/loongson_regs.h from
>> Linux Kernel.
>>
>> Our predefined CPUCFG bits are differ from actual 3A4000, since
>> we can't emulate all CPUCFG features present in 3A4000 for now,
>> we just enable bits for what we have in TCG.
>>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>   target/mips/cpu-defs.c.inc           |  9 ++++
>>   target/mips/cpu.c                    |  8 ++++
>>   target/mips/cpu.h                    | 40 ++++++++++++++++
>>   target/mips/helper.h                 |  4 ++
>>   target/mips/internal.h               |  2 +
>>   target/mips/tcg/lcsr.decode          | 17 +++++++
>>   target/mips/tcg/lcsr_translate.c     | 69 ++++++++++++++++++++++++++++
>>   target/mips/tcg/meson.build          |  2 +
>>   target/mips/tcg/op_helper.c          | 16 +++++++
>>   target/mips/tcg/sysemu/lcsr_helper.c | 45 ++++++++++++++++++
>>   target/mips/tcg/sysemu/meson.build   |  4 ++
>>   target/mips/tcg/sysemu_helper.h.inc  |  8 ++++
>>   target/mips/tcg/translate.c          |  3 ++
>>   target/mips/tcg/translate.h          |  7 +++
>>   14 files changed, 234 insertions(+)
>>   create mode 100644 target/mips/tcg/lcsr.decode
>>   create mode 100644 target/mips/tcg/lcsr_translate.c
>>   create mode 100644 target/mips/tcg/sysemu/lcsr_helper.c


>> @@ -1281,6 +1315,12 @@ static inline bool 
>> ase_msa_available(CPUMIPSState *env)
>>       return env->CP0_Config3 & (1 << CP0C3_MSAP);
>>   }
>> +/* Check presence of Loongson CSR instructions */
>> +static inline bool ase_lcsr_available(CPUMIPSState *env)
>> +{
>> +    return env->lcsr_cpucfg1 & (1 << CPUCFG2_LCSRP);
> 
> You are checking CPUCFG1_ITLBT. Surely you want lcsr_cpucfg2 instead.

Ping?

Anyhow:

Applying: target/mips: Implement Loongson CSR instructions
error: patch failed: target/mips/cpu.c:507
error: target/mips/cpu.c: patch does not apply
error: patch failed: target/mips/cpu.h:1162
error: target/mips/cpu.h: patch does not apply
Patch failed at 0001 target/mips: Implement Loongson CSR instructions


