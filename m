Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D94E718243
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:41:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4M4J-0004WD-5y; Wed, 31 May 2023 09:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4M3y-0004Tz-5w
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:40:31 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4M3u-0008E3-MT
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:40:29 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f6d7abe9a4so43505445e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685540423; x=1688132423;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IjzNUV7CQAMKl84w7Im4aa51sj1CqDxL1J5ZS1gi1XA=;
 b=QH1DqpuoKhElBd7PSUKuS4/SBwsJz6bBHZcXxSxGtGsk0kWnfr/XzPXLeECMidSKFV
 0m+8ioKzfYYr+lK1nVUVK+SRyfp9Bb5MOdxtwD61ZKCnmughd1SvfaSMem6pQ8D0Zhru
 zeSsrCoaFcrL5nCUC5KPUCXoepj6rXzWYVYqdV9DzfBg3qq+N4y+HpYYKITlh//G9sEv
 rGQ6Jn8oWEJUVjjXmcF134gpy+llaNnKZEQIEgnvtdvP9aUADTTDKyIxkBeWCQeONmJX
 ORxiaaYwVJyfWjMClcY8Ac9gSt+NAW8iUSqfD/PGiw2FhzyIVnKLwtIiD6AMt7LNrzUu
 vA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685540423; x=1688132423;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IjzNUV7CQAMKl84w7Im4aa51sj1CqDxL1J5ZS1gi1XA=;
 b=cxAxg4mPom2a1Iwo8B6tKXtgIyUVzlyxgU2MRl+6amxqJz7YCJqZyxTpT53r1a9CH1
 wOQdElh4+8tT93RCxgXN1oLI8yK+mormc2xb6Z7WAtx/BQcbrsIr4+YzaA3v51v1fokj
 SFxJApWdvIrBSaG/CYEebePBAmmvWKf58u7q60cvH/ZyOOClxtbcASHlfgCB1dUEFQgS
 l/2b0djYhrjY3u0clc9nL0959TXO9wxk5rbuVjrkcFyXvMwP+SK6NFPwKmLBwz04QJsw
 VorytkkZ/QvBoKVvrmBU3dR7UhfSCDKZ3pqrQRY2MJ1YLB3bWMSG8rTNjhtb9M4eDoRP
 DP7g==
X-Gm-Message-State: AC+VfDx/z4ts2ZXnR8DOxLqCkJYmwNLotOwgUnzfK82hrINcIVtMwvTy
 TkGe4vqHSr5cNa48R35pfJIFdw==
X-Google-Smtp-Source: ACHHUZ4XclMpIBHWad3nAGT4NQcUrmv+mq3f/BlwLO65shhB300UZVnHHW3dWE8Lzyrf4igx0wAC1Q==
X-Received: by 2002:a1c:e901:0:b0:3f6:795:6d1a with SMTP id
 q1-20020a1ce901000000b003f607956d1amr4155615wmc.22.1685540422892; 
 Wed, 31 May 2023 06:40:22 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a05600c290200b003eddc6aa5fasm24522094wmd.39.2023.05.31.06.40.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:40:22 -0700 (PDT)
Message-ID: <92959cb6-5539-17ef-4fbf-f54cefe7d0cb@linaro.org>
Date: Wed, 31 May 2023 15:40:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 05/23] q800: move CPU object into Q800MachineState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-6-mark.cave-ayland@ilande.co.uk>
Cc: Markus Armbruster <armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531125400.288917-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 31/5/23 14:53, Mark Cave-Ayland wrote:
> Also change the instantiation of the CPU to use object_initialize_child()
> followed by a separate realisation.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 13 ++++++++-----
>   include/hw/m68k/q800.h |  2 ++
>   2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 3730b30dd1..c34b2548ca 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -364,7 +364,7 @@ static uint8_t fake_mac_rom[] = {
>   
>   static void q800_machine_init(MachineState *machine)
>   {
> -    M68kCPU *cpu = NULL;
> +    Q800MachineState *m = Q800_MACHINE(machine);
>       int linux_boot;
>       int32_t kernel_size;
>       uint64_t elf_entry;
> @@ -407,8 +407,10 @@ static void q800_machine_init(MachineState *machine)
>       }
>   
>       /* init CPUs */
> -    cpu = M68K_CPU(cpu_create(machine->cpu_type));
> -    qemu_register_reset(main_cpu_reset, cpu);
> +    object_initialize_child(OBJECT(machine), "cpu", &m->cpu,
> +                            M68K_CPU_TYPE_NAME("m68040"));
> +    object_property_set_bool(OBJECT(&m->cpu), "realized", true, &error_fatal);

CPUs are QDev-based, shouldn't we use qdev_realize()?

> +    qemu_register_reset(main_cpu_reset, &m->cpu);
>   
>       /* RAM */
>       memory_region_add_subregion(get_system_memory(), 0, machine->ram);
> @@ -430,7 +432,8 @@ static void q800_machine_init(MachineState *machine)
>   
>       /* IRQ Glue */
>       glue = qdev_new(TYPE_GLUE);
> -    object_property_set_link(OBJECT(glue), "cpu", OBJECT(cpu), &error_abort);
> +    object_property_set_link(OBJECT(glue), "cpu", OBJECT(&m->cpu),
> +                             &error_abort);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(glue), &error_fatal);
>   
>       /* VIA 1 */
> @@ -605,7 +608,7 @@ static void q800_machine_init(MachineState *machine)
>   
>       macfb_mode = (NUBUS_MACFB(dev)->macfb).mode;
>   
> -    cs = CPU(cpu);
> +    cs = CPU(&m->cpu);
>       if (linux_boot) {
>           uint64_t high;
>           void *param_blob, *param_ptr, *param_rng_seed;
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index 76ea6560b2..0f54f1c2cf 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -29,6 +29,8 @@
>   
>   struct Q800MachineState {
>       MachineState parent_obj;
> +
> +    M68kCPU cpu;

Declared in "target/m68k/cpu-qom.h" (missing #include).

>   };
>   
>   #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")


