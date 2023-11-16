Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C16EA7EDC60
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:52:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3XAQ-0001p3-DN; Thu, 16 Nov 2023 02:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3XAC-0001ch-6H
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:51:49 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3XA9-0000gy-6R
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:51:47 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32f7c44f6a7so353250f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700121104; x=1700725904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fGPIIo+oWgUbTH02UBSRyk9mwsyIl/36Lb2JEBEbS7Y=;
 b=nbaH0u6a19VXMxC2NNTg9W5+SM+go8s8spLW/LOqqnPgdVwNwgIDk1iipArc2MSGFf
 CjmHyMTMa94gsJTJqX3IGNKbJ6ENUWaIYqzJC9gOLtEb9z8yZKVDRN0Nkwyz1BBYnQ9a
 dow3S3yXggP6T9hP/Ul0yM4aDpZ21/KR7opE01ZxWa4gbpggfRRKcUhhNs10I3GbKWu5
 LTYt1i1WsPZQQSRujSyWpqHH0vTGydIAJBiq1ze0o4BU3afWSbp+t8WHnyKCeOkGZFwu
 SF0FtqU9SYvhqCNaP7TteWAQ0tqpGqgBN+aVgRMC7OFYMcTWr368sHA9vu7NRJXxr+/t
 MyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700121104; x=1700725904;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fGPIIo+oWgUbTH02UBSRyk9mwsyIl/36Lb2JEBEbS7Y=;
 b=flhh+IKfC+W/6VLh80MUJjgYzaTTPtEXaA5025arNjY8R7LnaCa+NhG8+zg/bYLpRz
 BjhDpJGjr6dDnou3A94ux6G9ESOWy3MDiQDhRoKIZmlnct0PirY9ZHwjKodA5KcIIBz0
 9fRTWbajgyvqcnhSDkmS4VikgiJrXeJ6Hif+aEn9q7w9rK7o4Mtlr5jda7V2fD+wkz09
 jWCrCs8EDRl62pB3BDWyikYPDm9CWr/WwL56e0PN1xqtffQhbW1O+IQAN//opRqqGJH8
 G1c2B4uiLYTfJ2eHEx/OfpK7Glzq2J/P6UN66eMywuXHcWrABp8nENl5O3t0iQIGy4K0
 ADEQ==
X-Gm-Message-State: AOJu0Yy7waKlRqgNrOMe+nimkDQ4d93Os9pn/JQow7P5amIOOSC9amc+
 XKfxcIB/ZbhaUKMYND4W7Pk5jw==
X-Google-Smtp-Source: AGHT+IFaw+qaF9TAlYNqCmSBQ1ddepFKfbYNwb3dbHrKLcMqAvRgE4EtE4FBmShMA35PuoZQif20aA==
X-Received: by 2002:adf:e685:0:b0:32d:9541:b1e3 with SMTP id
 r5-20020adfe685000000b0032d9541b1e3mr8930365wrm.26.1700121103683; 
 Wed, 15 Nov 2023 23:51:43 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a056000024400b0032fb0e2087asm12582889wrz.82.2023.11.15.23.51.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 23:51:43 -0800 (PST)
Message-ID: <1ade7285-7f0b-406e-9d8f-8386da038087@linaro.org>
Date: Thu, 16 Nov 2023 08:51:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/31] target/arm: Use generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 imp@bsdimp.com, kevans@freebsd.org, richard.henderson@linaro.org,
 pbonzini@redhat.com, peter.maydell@linaro.org, imammedo@redhat.com,
 b.galvani@gmail.com, strahinja.p.jankovic@gmail.com, sundeep.lkml@gmail.com,
 kfting@nuvoton.com, wuhaotsh@google.com, nieklinnenbank@gmail.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 laurent@vivier.eu, vijai@behindbytes.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, mrolnik@gmail.com,
 edgar.iglesias@gmail.com, bcain@quicinc.com, gaosong@loongson.cn,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com, aleksandar.rikalo@syrmia.com,
 chenhuacai@kernel.org, shorne@gmail.com, npiggin@gmail.com, clg@kaod.org,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com, shan.gavin@gmail.com
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-9-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231114235628.534334-9-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 15/11/23 00:56, Gavin Shan wrote:
> No changes of the output from the following command before and
> after it's applied.
> 
> [gshan@gshan q]$ ./build/qemu-system-aarch64 -cpu ?
> Available CPUs:
>    a64fx
>    arm1026
>    arm1136
>    arm1136-r2
>    arm1176
>    arm11mpcore
>    arm926
>    arm946
>    cortex-a15
>    cortex-a35
>    cortex-a53
>    cortex-a55
>    cortex-a57
>    cortex-a7
>    cortex-a710
>    cortex-a72
>    cortex-a76
>    cortex-a8
>    cortex-a9
>    cortex-m0
>    cortex-m3
>    cortex-m33
>    cortex-m4
>    cortex-m55
>    cortex-m7
>    cortex-r5
>    cortex-r52
>    cortex-r5f
>    max
>    neoverse-n1
>    neoverse-n2
>    neoverse-v1
>    pxa250
>    pxa255
>    pxa260
>    pxa261
>    pxa262
>    pxa270-a0
>    pxa270-a1
>    pxa270
>    pxa270-b0
>    pxa270-b1
>    pxa270-c0
>    pxa270-c5
>    sa1100
>    sa1110
>    ti925t
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/arm/cpu.h    |  3 ---
>   target/arm/helper.c | 46 ---------------------------------------------
>   2 files changed, 49 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


