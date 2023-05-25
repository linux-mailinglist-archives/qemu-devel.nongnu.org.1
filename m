Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1C77106E1
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 10:09:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q260g-0005pk-Bj; Thu, 25 May 2023 04:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q260c-0005pP-R6
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:07:42 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q260b-0000tq-A7
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:07:42 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3093a7b71fbso1727774f8f.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 01:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685002059; x=1687594059;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YRot7csRaiLN2Kch1Bdcl1t2bJRWPjwFArO/OyEsHkQ=;
 b=YQCTKoWHGxLIqhvXX0jBPGAt6MPHCTISgN60WSml9MB2hDcwtvhJtFnqsQC7zJxl5p
 Q4q/hnIHOMTzKhBKHKpb6URbOnrAELw/lXT+0m8UhUB/pIE4Z+367xj5C8SDQzZ1x+O9
 XegME8dENt0ow/Ff15YMj6TkpQGqXQzC22rjO6/5QTu2/0iBBhpcqK4mk2yh+UEvzR1i
 kazm5aGtNjPtD1jhJrxjk2X3Rz0ewRXa8JmibxDzHHMNOBF8tko9pc545qmvLlopveLf
 my3GAgl8i13JOUe/dh+d27lXbMDtrWCbVttNA4JivYVc83tUFCD4tED5XsP0A9sMp+UL
 bZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685002059; x=1687594059;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YRot7csRaiLN2Kch1Bdcl1t2bJRWPjwFArO/OyEsHkQ=;
 b=Le7XaNrtdsHnYxs146ZMKjHWEQlt6Hqd/TcB7a3y7WMwJPmlP15PTWO6xzqjTRBm/L
 PU/HwmNoqehBp5Qf3JjK52uw7xRw8sEmM0A6upTWkUzo4EjlFoaWLMN1k2AhDfCp0jAz
 Y7uSwZnLIJvkseLLoS1iBt192R2B79Si67kdTPQiv7BkqPuJ/BNTUC7OMguGYzScfngM
 DLy1WycaZIyh0tVg52WaQYgNMZNmUzcJhxazyapI0n5cmyf7QbxAk8OB/uZFdSfEX12i
 a+r2SxrwfFwXV0OKYTit/iPxZq9D+Cyumzsw5piezVJMtJzfx5U/SrSgK1SHb0dTLvrW
 HU9g==
X-Gm-Message-State: AC+VfDwwqeLI0aPplbcwseF8MrCsIFiYKkHVcya1oZvqy65/7bi8Pkot
 BLKF/T1j42LjzxpJV4PyqiKVjyRONZArZj9I1Co=
X-Google-Smtp-Source: ACHHUZ7Hv1cwjtGxQjKQvP1n88ow7IAyFEVOWaQNQV3yiy+MV/U6rXe8Zdx5sIUMV8T+DzA7z8OLKw==
X-Received: by 2002:adf:eac3:0:b0:309:838:8c21 with SMTP id
 o3-20020adfeac3000000b0030908388c21mr1534572wrn.38.1685002059008; 
 Thu, 25 May 2023 01:07:39 -0700 (PDT)
Received: from [192.168.69.115] (cor91-h02-176-184-30-254.dsl.sta.abo.bbox.fr.
 [176.184.30.254]) by smtp.gmail.com with ESMTPSA id
 r11-20020a5d494b000000b00300aee6c9cesm909671wrs.20.2023.05.25.01.07.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 01:07:38 -0700 (PDT)
Message-ID: <32730af0-f4ba-221c-7b44-e034ac3c37bb@linaro.org>
Date: Thu, 25 May 2023 10:07:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 04/30] q800: move CPU object into Q800MachineState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-5-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230524211104.686087-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 24/5/23 23:10, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 10 +++++-----
>   include/hw/m68k/q800.h |  4 +++-
>   2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 976da06231..ee6175ceb4 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -363,7 +363,7 @@ static uint8_t fake_mac_rom[] = {
>   
>   static void q800_machine_init(MachineState *machine)
>   {
> -    M68kCPU *cpu = NULL;
> +    Q800MachineState *m = Q800_MACHINE(machine);
>       int linux_boot;
>       int32_t kernel_size;
>       uint64_t elf_entry;
> @@ -406,8 +406,8 @@ static void q800_machine_init(MachineState *machine)
>       }
>   
>       /* init CPUs */
> -    cpu = M68K_CPU(cpu_create(machine->cpu_type));
> -    qemu_register_reset(main_cpu_reset, cpu);
> +    m->cpu = M68K_CPU(cpu_create(machine->cpu_type));
> +    qemu_register_reset(main_cpu_reset, m->cpu);
>   
>       /* RAM */
>       memory_region_add_subregion(get_system_memory(), 0, machine->ram);


> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index 560fd6f93d..5867c3ae33 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -29,9 +29,11 @@
>   
>   struct Q800MachineState {
>       MachineState parent_obj;
> +
> +    M68kCPU *cpu;

This is a good opportunity to allocate M68kCPU in Q800MachineState
and call object_initialize_child/qdev_realize instead of cpu_create.

Can be done later, so meanwhile:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   };
>   
>   #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
> -OBJECT_DECLARE_SIMPLE_TYPE(Q800MachineState, q800, Q800_MACHINE, MachineState)
> +OBJECT_DECLARE_SIMPLE_TYPE(Q800MachineState, Q800_MACHINE)
>   
>   #endif


