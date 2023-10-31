Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D96C7DD855
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 23:31:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxxG6-0008B4-L9; Tue, 31 Oct 2023 18:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxxG3-0008AO-1q
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:30:48 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxxG1-0001eI-BO
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:30:46 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b6f4c118b7so5653826b3a.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 15:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698791443; x=1699396243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zP5Qhx/HBEHlMGroO1ro7JINtdOM49u30PcFo99pRfA=;
 b=xQjSTC+DoiowY6AW5XMU6XbjAcVYf3ZSc6jAbH+J1ZUgfULSY2amaOaXSwhpZJU0Vc
 MzdmQh4tqgaWtSrmcwwsMRaE0sGn2gI8l7frkRgqz2k/0zU26+/eJc5+3FpkU8O3d0S4
 eXuJkbXycRgcD3pXwsvg8x7Se0x525J4zk5FejBlfKr8UhniPT70URTYIj17uvkrDSXB
 UG5EOIPwb2J8TGvgqzireNBDFKWGMaRKRkNQj6o77mOTaky9fA94ywu4KnddvOx2P35f
 uRi4mAOlUReGJXRWzWHf4VRuvk33bH/TdKIDFY05e/h0NDvbstjtZPfnnuplMl4RxV4l
 6+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698791443; x=1699396243;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zP5Qhx/HBEHlMGroO1ro7JINtdOM49u30PcFo99pRfA=;
 b=FZfMpqFZd9U6f2C3ifAvZqCDZMZ1z3CKtJIhgX4AJq5GyIGLutWRuEk7OKF32D43Pq
 qycllIIVReehPqgBLI+ZlrrVfIebMOb4vvNxltlMPZ5ngS1to2lJpjc7Wd/kpTftQBgC
 NmsSv9nDZsdbHg4XXcNXmSaEPUnnwRuNeA1uizvhhxq6VdkVDFE3c1830R6Mkw7eR9lD
 Q90dmCF/wJwOTby6JJCgJyEB7zsykOhmH61D3KIuMVhkyYz8l8aJZ29WfVryAlELgc+F
 HSivn44cR84whrKiEQBWxvicnqWKjaaa7qwn3iM97J5+T+KqHC04hWXReuwLP1/Xqdp6
 wwtQ==
X-Gm-Message-State: AOJu0Yxz2JeTcpgb/BWL/PyBat42lL8E+fYZmA47GnudEtkk1UE5hawJ
 n65Hs6UvGaRmBc8pgN878GYaMA==
X-Google-Smtp-Source: AGHT+IFFq+oNxuftM+arqei1P/nZR3NNuilrQvsO4+Ac+ogVvoqV5mFcI4C85LLZmOEWJmILg/t3bA==
X-Received: by 2002:a05:6a20:1607:b0:17b:3438:cf92 with SMTP id
 l7-20020a056a20160700b0017b3438cf92mr14166523pzj.5.1698791443401; 
 Tue, 31 Oct 2023 15:30:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 gx14-20020a056a001e0e00b00694f14a784bsm116272pfb.52.2023.10.31.15.30.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 15:30:42 -0700 (PDT)
Message-ID: <5b672e41-f106-469c-b0d6-36f5d8fc3c0c@linaro.org>
Date: Tue, 31 Oct 2023 15:30:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Only allow injecting MCE on x86 CPUs
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Markus Armbruster <armbru@redhat.com>
References: <20231030102122.67105-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231030102122.67105-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/30/23 03:21, Philippe Mathieu-Daudé wrote:
> When using heterogeneous machines, we can try to inject a MCE on
> a non-x86 CPU. Filter the CPU is injectable, otherwise display a
> hint.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/monitor.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)

I guess this or somtthing like it is required, though that's certainly not the end of it. 
Everything in that file, as well as every other target/*/monitor.c is target-specific.

Do we have a general plan for the monitor?


r~

> 
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 6512846327..7ef540eda7 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -579,7 +579,6 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
>   
>   void hmp_mce(Monitor *mon, const QDict *qdict)
>   {
> -    X86CPU *cpu;
>       CPUState *cs;
>       int cpu_index = qdict_get_int(qdict, "cpu_index");
>       int bank = qdict_get_int(qdict, "bank");
> @@ -593,11 +592,17 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
>           flags |= MCE_INJECT_BROADCAST;
>       }
>       cs = qemu_get_cpu(cpu_index);
> -    if (cs != NULL) {
> -        cpu = X86_CPU(cs);
> -        cpu_x86_inject_mce(mon, cpu, bank, status, mcg_status, addr, misc,
> -                           flags);
> +    if (cs == NULL) {
> +        monitor_printf(mon, "CPU #%d not found\n", cpu_index);
> +        return;
>       }
> +    if (!object_dynamic_cast(OBJECT(cs), TYPE_X86_CPU)) {
> +        monitor_printf(mon, "Can only inject MCE on x86 CPU (CPU #%d is %s)\n",
> +                            cpu_index, object_get_typename(OBJECT(cs)));
> +        return;
> +    }
> +    cpu_x86_inject_mce(mon, X86_CPU(cs), bank, status, mcg_status, addr, misc,
> +                       flags);
>   }
>   
>   static target_long monitor_get_pc(Monitor *mon, const struct MonitorDef *md,


