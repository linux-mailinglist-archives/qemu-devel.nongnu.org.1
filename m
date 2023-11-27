Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC3E7FAA2B
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 20:23:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7hBe-0005mz-Mo; Mon, 27 Nov 2023 14:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7hBc-0005mh-Pq
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 14:22:28 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7hBb-0006q1-40
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 14:22:28 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-332e42469f0so2958468f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 11:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701112945; x=1701717745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a/cEV5PFwy+um53WGLT77w6QW42HdrXByXrpmwoFkrs=;
 b=VSr+utGWqkoSMoA+cyk1axj0lbdXl7gKygMnDPe64QySZ2EPRykJuJn79NyX4i7ozY
 H/9XXSHM3Z1Pg6gjie5U0TRTZdoS2FBk4J87FXZYpWELsEtVDOS5d5fXv1VkiEwDcOCG
 U74zDPrJ1X81L9LUJyp97h0rkD3KJuFQnaSd2dAcfnYdnyuzV7QUT/OFkgK0QhYcjSHZ
 hhuxQeW25s00F4mLJSNb5k7cWPd3oPJuyyQFoupwz5vnUMNrvze65rgDiIbHWECKb98c
 DQUpVaKv9LGRbY7shM+4HxOYS3qCY7XYj4ojerNYfCHkaL0HjpIoR5FWsLqfquJ37B/E
 4Tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701112945; x=1701717745;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a/cEV5PFwy+um53WGLT77w6QW42HdrXByXrpmwoFkrs=;
 b=BSIkqGJjDi3H791IBKfDCWBPn/e3xuKF4u/ZcINUZ/zqwC8NAa2r39mDsT5n0Wzp2w
 FypCjoV6Ug52vfBsy6DN22JCi9G+84GuSarybSHpN0zRDib8kYHFRsZhra0LI+akBSMb
 ukJwTBV+H4mbxn8MxZOh/DA2rkVzV90fBDptefCzc/9QJ1LYH8Qs+1pM2r0bsah0990v
 z0iEuML1fIK03S1okWWXA46JvtEkP9nrOWDL3PjyuzFKUF723a+MhfQ7UAOVlllKJTJ9
 KDNjlhnz/Pdju6n6/wjWG8IVPybZNsr2GDwWbRJaaO7TLRAu68Vokdeu7LjMSGJKDJgq
 Kb5g==
X-Gm-Message-State: AOJu0YxKHbWkvtBew6D8CkACoSJyT0q/0I85Ur72BlyK8KElJfnssmkM
 YccE81ciERLleUB2Kif965Iv+g==
X-Google-Smtp-Source: AGHT+IGyP4o08/Zk2rXUgsIoXJ78KwDBqxDdTQOWvA7zZrltgf3g+yJevAYFbWnELfkW0n9Shr9WOg==
X-Received: by 2002:adf:e38e:0:b0:32f:6fc3:7963 with SMTP id
 e14-20020adfe38e000000b0032f6fc37963mr9222597wrm.15.1701112945146; 
 Mon, 27 Nov 2023 11:22:25 -0800 (PST)
Received: from [192.168.69.100] ([176.187.209.101])
 by smtp.gmail.com with ESMTPSA id
 a8-20020adffb88000000b00333083a20e5sm1571773wrr.113.2023.11.27.11.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 11:22:24 -0800 (PST)
Message-ID: <e63b3129-9b42-46d5-877d-da6dcb2ec133@linaro.org>
Date: Mon, 27 Nov 2023 20:22:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] avr: Fix wrong initial value of stack pointer
Content-Language: en-US
To: Gihun Nam <gihun.nam@outlook.com>, qemu-devel@nongnu.org
Cc: Michael Rolnik <mrolnik@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <PH0P222MB0010877445B594724D40C924DEBDA@PH0P222MB0010.NAMP222.PROD.OUTLOOK.COM>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <PH0P222MB0010877445B594724D40C924DEBDA@PH0P222MB0010.NAMP222.PROD.OUTLOOK.COM>
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

Hi Gihun,

On 27/11/23 03:54, Gihun Nam wrote:
> The current implementation initializes the stack pointer of AVR devices
> to 0. Although older AVR devices used to be like that, newer ones set
> it to RAMEND.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1525
> Signed-off-by: Gihun Nam <gihun.nam@outlook.com>
> ---
> Edit code to use QOM property and add more description to commit message
> about the changes
> 
> Thanks for the detailed help, Mr. Peter!
> 
> P.S. I don't understand how replies work with git send-email, so
>       if I've done something wrong, please bear with me.
> 
>   hw/avr/atmega.c  |  4 ++++
>   target/avr/cpu.c | 10 +++++++++-
>   target/avr/cpu.h |  3 +++
>   3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
> index a34803e642..31c8992d75 100644
> --- a/hw/avr/atmega.c
> +++ b/hw/avr/atmega.c
> @@ -233,6 +233,10 @@ static void atmega_realize(DeviceState *dev, Error **errp)
>   
>       /* CPU */
>       object_initialize_child(OBJECT(dev), "cpu", &s->cpu, mc->cpu_type);
> +
> +    object_property_set_uint(OBJECT(&s->cpu), "init-sp",
> +                             mc->io_size + mc->sram_size - 1, &error_abort);

Since the CPU implements the QDev interface, you can use:

        qdev_prop_set_uint32(DEVICE(&s->cpu), "init-sp",
                             mc->io_size + mc->sram_size - 1);

>       qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
>       cpudev = DEVICE(&s->cpu);
>   
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index 44de1e18d1..999c010ded 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -25,6 +25,7 @@
>   #include "cpu.h"
>   #include "disas/dis-asm.h"
>   #include "tcg/debug-assert.h"
> +#include "hw/qdev-properties.h"
>   
>   static void avr_cpu_set_pc(CPUState *cs, vaddr value)
>   {
> @@ -95,7 +96,7 @@ static void avr_cpu_reset_hold(Object *obj)
>       env->rampY = 0;
>       env->rampZ = 0;
>       env->eind = 0;
> -    env->sp = 0;
> +    env->sp = cpu->init_sp;
>   
>       env->skip = 0;
>   
> @@ -152,6 +153,11 @@ static void avr_cpu_initfn(Object *obj)
>                         sizeof(cpu->env.intsrc) * 8);
>   }
>   
> +static Property avr_cpu_properties[] = {
> +    DEFINE_PROP_UINT32("init-sp", AVRCPU, init_sp, 0),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
>   static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
>   {
>       ObjectClass *oc;
> @@ -228,6 +234,8 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
>   
>       device_class_set_parent_realize(dc, avr_cpu_realizefn, &mcc->parent_realize);
>   
> +    device_class_set_props(dc, avr_cpu_properties);
> +
>       resettable_class_set_parent_phases(rc, NULL, avr_cpu_reset_hold, NULL,
>                                          &mcc->parent_phases);
>   
> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> index 8a17862737..7960c5c57a 100644
> --- a/target/avr/cpu.h
> +++ b/target/avr/cpu.h
> @@ -145,6 +145,9 @@ struct ArchCPU {
>       CPUState parent_obj;
>   
>       CPUAVRState env;
> +
> +    /* Initial value of stack pointer */
> +    uint32_t init_sp;

Hmm the stack is 16-bit wide. I suppose AVRCPU::sp is 32-bit
wide because tcg_global_mem_new_i32() forces us to (the smaller
TCG register is 16-bit).

Preferably using uint16_t/DEFINE_PROP_UINT16/qdev_prop_set_uint16:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   };
>   
>   /**


