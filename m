Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE6DAD814D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Jun 2025 04:56:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPuaN-0003H6-6h; Thu, 12 Jun 2025 22:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uPuaK-0003FT-CC
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 22:56:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uPuaH-0007jf-Pw
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 22:56:03 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bxlmk+k0toBHYVAQ--.51332S3;
 Fri, 13 Jun 2025 10:55:58 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxDcU6k0toqaMYAQ--.5533S3;
 Fri, 13 Jun 2025 10:55:57 +0800 (CST)
Subject: Re: [PATCH V1 1/2] hw/rtc: Fixed loongson rtc emulation errors
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <cover.1749777563.git.lixianglai@loongson.cn>
 <b83fa4c3319e372b2a7b3b7b994821441ff9ca7c.1749777563.git.lixianglai@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <beb3b653-d73f-022e-476e-3938af322fc0@loongson.cn>
Date: Fri, 13 Jun 2025 10:54:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b83fa4c3319e372b2a7b3b7b994821441ff9ca7c.1749777563.git.lixianglai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxDcU6k0toqaMYAQ--.5533S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr17Kw4DAryUZw15WFW7GFX_yoW7Jry3pF
 W7Crn5Ja43JFZrWrWxZ3sIv3WrCws5JrySgr17Ca1Fv34kXw1rJF18X3y2yFWUC3Z5Ja1r
 ZFsYqr95W3W2grXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwmhFDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.554,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2025/6/13 上午9:31, Xianglai Li wrote:
> The expire time is sent to the timer only
> when the expire Time is greater than 0 or
> greater than now. Otherwise, the timer
> will trigger interruption continuously.
Again, one line of the comments should no more than 75 bytes :)

I think it should be split into two patches, one is fixup with irq pulse 
type setting, the other is fixup with expired time out calculation in 
rtc emulation driver.

Regards
Bibo Mao
> 
> Timer interrupts are sent using pulse functions.

> 
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: Xianglai Li <lixianglai@loongson.cn>
> 
>   hw/loongarch/virt-fdt-build.c | 11 +++++++++--
>   hw/rtc/ls7a_rtc.c             | 26 +++++++++++++++++---------
>   2 files changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
> index 728ce46699..c613131a07 100644
> --- a/hw/loongarch/virt-fdt-build.c
> +++ b/hw/loongarch/virt-fdt-build.c
> @@ -17,6 +17,11 @@
>   #include "system/reset.h"
>   #include "target/loongarch/cpu.h"
>   
> +#define FDT_IRQ_FLAGS_EDGE_LO_HI 1
> +#define FDT_IRQ_FLAGS_EDGE_HI_LO 2
> +#define FDT_IRQ_FLAGS_LEVEL_HI 4
> +#define FDT_IRQ_FLAGS_LEVEL_LO 8
> +
>   static void create_fdt(LoongArchVirtMachineState *lvms)
>   {
>       MachineState *ms = MACHINE(lvms);
> @@ -416,7 +421,8 @@ static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
>       if (chosen) {
>           qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
>       }
> -    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq, 0x4);
> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq,
> +                           FDT_IRQ_FLAGS_LEVEL_HI);
>       qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
>                             *pch_pic_phandle);
>       g_free(nodename);
> @@ -436,7 +442,8 @@ static void fdt_add_rtc_node(LoongArchVirtMachineState *lvms,
>                               "loongson,ls7a-rtc");
>       qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
>       qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
> -                           VIRT_RTC_IRQ - VIRT_GSI_BASE , 0x4);
> +                           VIRT_RTC_IRQ - VIRT_GSI_BASE ,
> +                           FDT_IRQ_FLAGS_EDGE_LO_HI);
>       qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
>                             *pch_pic_phandle);
>       g_free(nodename);
> diff --git a/hw/rtc/ls7a_rtc.c b/hw/rtc/ls7a_rtc.c
> index 10097b2db7..7eca75a42a 100644
> --- a/hw/rtc/ls7a_rtc.c
> +++ b/hw/rtc/ls7a_rtc.c
> @@ -145,20 +145,24 @@ static void toymatch_write(LS7ARtcState *s, uint64_t val, int num)
>           now = qemu_clock_get_ms(rtc_clock);
>           toymatch_val_to_time(s, val, &tm);
>           expire_time = now + (qemu_timedate_diff(&tm) - s->offset_toy) * 1000;
> -        timer_mod(s->toy_timer[num], expire_time);
> +        if (expire_time > now) {
> +            timer_mod(s->toy_timer[num], expire_time);
> +        }
>       }
>   }
>   
>   static void rtcmatch_write(LS7ARtcState *s, uint64_t val, int num)
>   {
> -    uint64_t expire_ns;
> +    int64_t expire_ns;
>   
>       /* it do not support write when toy disabled */
>       if (rtc_enabled(s)) {
>           s->rtcmatch[num] = val;
>           /* calculate expire time */
>           expire_ns = ticks_to_ns(val) - ticks_to_ns(s->offset_rtc);
> -        timer_mod_ns(s->rtc_timer[num], expire_ns);
> +        if (expire_ns > 0) {
> +            timer_mod_ns(s->rtc_timer[num], expire_ns);
> +        }
>       }
>   }
>   
> @@ -185,7 +189,7 @@ static void ls7a_rtc_stop(LS7ARtcState *s)
>   static void ls7a_toy_start(LS7ARtcState *s)
>   {
>       int i;
> -    uint64_t expire_time, now;
> +    int64_t expire_time, now;
>       struct tm tm = {};
>   
>       now = qemu_clock_get_ms(rtc_clock);
> @@ -194,19 +198,23 @@ static void ls7a_toy_start(LS7ARtcState *s)
>       for (i = 0; i < TIMER_NUMS; i++) {
>           toymatch_val_to_time(s, s->toymatch[i], &tm);
>           expire_time = now + (qemu_timedate_diff(&tm) - s->offset_toy) * 1000;
> -        timer_mod(s->toy_timer[i], expire_time);
> +        if (expire_time > now) {
> +            timer_mod(s->toy_timer[i], expire_time);
> +        }
>       }
>   }
>   
>   static void ls7a_rtc_start(LS7ARtcState *s)
>   {
>       int i;
> -    uint64_t expire_time;
> +    int64_t expire_time;
>   
>       /* recalculate expire time and enable timer */
>       for (i = 0; i < TIMER_NUMS; i++) {
>           expire_time = ticks_to_ns(s->rtcmatch[i]) - ticks_to_ns(s->offset_rtc);
> -        timer_mod_ns(s->rtc_timer[i], expire_time);
> +        if (expire_time > 0) {
> +            timer_mod_ns(s->rtc_timer[i], expire_time);
> +        }
>       }
>   }
>   
> @@ -370,7 +378,7 @@ static void toy_timer_cb(void *opaque)
>       LS7ARtcState *s = opaque;
>   
>       if (toy_enabled(s)) {
> -        qemu_irq_raise(s->irq);
> +        qemu_irq_pulse(s->irq);
>       }
>   }
>   
> @@ -379,7 +387,7 @@ static void rtc_timer_cb(void *opaque)
>       LS7ARtcState *s = opaque;
>   
>       if (rtc_enabled(s)) {
> -        qemu_irq_raise(s->irq);
> +        qemu_irq_pulse(s->irq);
>       }
>   }
>   
> 


