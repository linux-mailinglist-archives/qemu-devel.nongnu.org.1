Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAA1853C55
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Feb 2024 21:39:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZzXB-0002or-EW; Tue, 13 Feb 2024 15:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZzXA-0002oQ-0S; Tue, 13 Feb 2024 15:37:40 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZzX7-0000Gi-A6; Tue, 13 Feb 2024 15:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VWgNZZV5747UVPixH+kIDMzLzwXhz+mNLpeXEeCXAyA=; b=C0gsGu08BLlKyVXa3U7oXapcXG
 xOYYrEyupzTQPqADd/xE+t7Niy+XmR6SsWpPo+gMW1Q9NdJmraZ3cKh0S+NnQ67epc6hWs0/AXBiu
 TZyo2vOk3dxhzK16i1NwfAnWj0bA+WVUqupBPO31pyZHexBEnqX6n9Hhv5lfrUkZa6+2E1cwwioif
 X/lErIH7THQ7nYYVpDG3EwfGO9aMLynEjdnzqbBTBJLQP9SvJNxHQ3QEMX9Bsk8UMN/HNCcA8qkQ1
 BZSNPTrtmGrubnhD7UC1TeR4AYfp7vCDqUwkyuK56+g7M/6+GSr/aMDef2SnThP6+Tur+feaB6O8J
 BIX0q65iwa+cM40aPjnLeFSArd8YewzA/aMmT9LyF7FeQ648qxdWuJtGjzm2NVu1k3cl2TBXiFO9K
 DVvSmP7Y/UQXcgiEQQw7mPoxZ/aU+HtpNViDdmlc/a0nLkPH30Sut2UlqvLT3sF6pb2vPdJ3/+uQW
 45xM+wWoiq+YuaEbBrd87sUXa0bpHITx6rwjOcQxbX94F/dI2Uy9RjVtb4oZvFQSoR+6qsD1IzAXn
 K3qr9FlpGdeR76SxS+jScs4P60i/wVAdkKDcQbdrJ5t363X+zZO6xnnMKb0TdjmmbQYXj41nQ6U3J
 xKL/62lALdDRWMX0wm3HEZCKNtuNAm4O8hyLSwGXY=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZzWF-0009P2-Fx; Tue, 13 Feb 2024 20:36:47 +0000
Message-ID: <7936e66b-8353-412b-a90a-6425fafea333@ilande.co.uk>
Date: Tue, 13 Feb 2024 20:37:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Bernhard Beschow
 <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20240213130341.1793-1-philmd@linaro.org>
 <20240213130341.1793-11-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20240213130341.1793-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v4 10/12] hw/sparc/leon3: Pass DeviceState opaque argument
 to leon3_set_pil_in()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 13/02/2024 13:03, Philippe Mathieu-Daudé wrote:

> By passing a DeviceState context to a QDev IRQ handler,
> we can simplify and use qdev_init_gpio_in_named() instead
> of qdev_init_gpio_in_named_with_opaque().
> 
> Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sparc/leon3.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 0df5fc949d..d2be900988 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -175,9 +175,10 @@ static void leon3_irq_ack(CPUSPARCState *env, int intno)
>    */
>   static void leon3_set_pil_in(void *opaque, int n, int level)
>   {
> -    CPUSPARCState *env = opaque;
> +    DeviceState *cpu = opaque;
> +    CPUState *cs = CPU(cpu);
> +    CPUSPARCState *env = cpu_env(cs);
>       uint32_t pil_in = level;
> -    CPUState *cs;
>   
>       assert(env != NULL);
>   
> @@ -193,7 +194,6 @@ static void leon3_set_pil_in(void *opaque, int n, int level)
>   
>                   env->interrupt_index = TT_EXTINT | i;
>                   if (old_interrupt != env->interrupt_index) {
> -                    cs = env_cpu(env);
>                       trace_leon3_set_irq(i);
>                       cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>                   }
> @@ -201,7 +201,6 @@ static void leon3_set_pil_in(void *opaque, int n, int level)
>               }
>           }
>       } else if (!env->pil_in && (env->interrupt_index & ~15) == TT_EXTINT) {
> -        cs = env_cpu(env);
>           trace_leon3_reset_irq(env->interrupt_index & 15);
>           env->interrupt_index = 0;
>           cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> @@ -261,8 +260,7 @@ static void leon3_generic_hw_init(MachineState *machine)
>   
>       /* Allocate IRQ manager */
>       irqmpdev = qdev_new(TYPE_GRLIB_IRQMP);
> -    qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
> -                                        env, "pil", 1);
> +    qdev_init_gpio_in_named(DEVICE(cpu), leon3_set_pil_in, "pil", 1);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(irqmpdev), 0, LEON3_IRQMP_OFFSET);
>       qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", 0,

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


