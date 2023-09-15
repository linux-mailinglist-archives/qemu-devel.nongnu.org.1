Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEDA7A16CA
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 09:02:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh2oy-0004Yd-Qg; Fri, 15 Sep 2023 03:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qh2ow-0004YR-BM
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:00:54 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qh2os-00014N-7i
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:00:54 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8Dx_7sbAQRlkzAoAA--.18296S3;
 Fri, 15 Sep 2023 15:00:43 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxvt4YAQRl1K0GAA--.608S2; 
 Fri, 15 Sep 2023 15:00:41 +0800 (CST)
Subject: Re: [PATCH v2 03/10] make qdev_disconnect_gpio_out_named() public
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Salil Mehta <salil.mehta@opnsrc.net>
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>, 
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>
References: <cover.1694433326.git.lixianglai@loongson.cn>
 <d3e388d55f36a93108d0f7b1736f97435237cb77.1694433326.git.lixianglai@loongson.cn>
 <043acdaf-219b-b2b5-6b2d-056ba1bd9ce2@linaro.org>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <1070551b-ceaf-b2c2-5151-379a76456b33@loongson.cn>
Date: Fri, 15 Sep 2023 15:00:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <043acdaf-219b-b2b5-6b2d-056ba1bd9ce2@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bxvt4YAQRl1K0GAA--.608S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw45tF1kXFyUJrWxtr1fuFX_yoWrKr1xpF
 1ktF15AryUJr18Ar17Zr17CFy7Jr1DG3W7Jr18JFyUAr1UJwn0qr4UXr1qg34UJr48KF4U
 Jr1UXFy8ZF1UArcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
 Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
 14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4s2-UUUUU
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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

Hi Philippe Mathieu-Daudé :
> Hi,
>
> On 12/9/23 04:11, xianglai li wrote:
>> It will be reused in loongarch/virt.c for unwiring
>> the vcpu<->exioi interrupts for the vcpu hot-(un)plug
>> cases.
>
> Since we never had to use this, I'm surprised we really need it.
>
> QEMU IRQs/GPIOs are similar to hardware ones, and aren't expected
> to be rewired at runtime. Usually another hot-pluggable bus layer is
> used, and the bus is physically wired toward the hardware.
>
>
> I suppose you want to add that because a unplugged vCPU is still
> receiving IRQs. The question is, why? Before unplugging, I expect
> the INTC (IPI) here to be signaled a vCPU is going to be unplugged,
> so maybe you are missing handling the unplug event there. See


I did not receive an interrupt signal after pulling out the vcpu.

Whether to use the qdev_disconnect_gpio_out_named function does not 
affect the cpu hot swap function.

The qdev_disconnect_gpio_out_named function is used only to make

loongarch_cpu_irq_init and loongarch_cpu_irq_uninit symmetrical.

I thought it would make the whole process more regular and nice.

If this causes confusion I think with the next patch I can remove the 
reference to this function.

Thanks,

xianglai.


> in loongarch_ipi_writel():
>
>     switch (addr) {
>     case CORE_EN_OFF:
>         s->en = val;
>         break;
>     case CORE_SET_OFF:
>         s->status |= val;
>         if (s->status != 0 && (s->status & s->en) != 0) {
>             qemu_irq_raise(s->irq);
>         }
>         break;
>     case CORE_CLEAR_OFF:
>         s->status &= ~val;
>         if (s->status == 0 && s->en != 0) {
>             qemu_irq_lower(s->irq);
>         }
>         break;
>
> Maybe you need to factor ipi_raise/lower() helpers which check cores
> are available & enabled before propagating IRQ?
>
>> Co-authored-by: "Salil Mehta" <salil.mehta@opnsrc.net>
>> Cc: "Salil Mehta" <salil.mehta@opnsrc.net>
>> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
>> Cc: Song Gao <gaosong@loongson.cn>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Ani Sinha <anisinha@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Eduardo Habkost <eduardo@habkost.net>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
>> Cc: Yanan Wang <wangyanan55@huawei.com>
>> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Bibo Mao <maobibo@loongson.cn>
>> Signed-off-by: xianglai li <lixianglai@loongson.cn>
>> ---
>>   hw/core/gpio.c         | 4 ++--
>>   include/hw/qdev-core.h | 2 ++
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/core/gpio.c b/hw/core/gpio.c
>> index 80d07a6ec9..4fc6409545 100644
>> --- a/hw/core/gpio.c
>> +++ b/hw/core/gpio.c
>> @@ -143,8 +143,8 @@ qemu_irq qdev_get_gpio_out_connector(DeviceState 
>> *dev, const char *name, int n)
>>     /* disconnect a GPIO output, returning the disconnected input (if 
>> any) */
>>   -static qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
>> -                                               const char *name, int n)
>> +qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
>> +                                        const char *name, int n)
>>   {
>>       char *propname = g_strdup_printf("%s[%d]",
>>                                        name ? name : 
>> "unnamed-gpio-out", n);
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index 151d968238..32bb54163e 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -739,6 +739,8 @@ qemu_irq qdev_get_gpio_out_connector(DeviceState 
>> *dev, const char *name, int n);
>>    */
>>   qemu_irq qdev_intercept_gpio_out(DeviceState *dev, qemu_irq icpt,
>>                                    const char *name, int n);
>> +qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
>> +                                        const char *name, int n);
>>     BusState *qdev_get_child_bus(DeviceState *dev, const char *name);


