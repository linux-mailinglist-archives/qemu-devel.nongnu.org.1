Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DA976AB23
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 10:34:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQkob-0001QK-Ct; Tue, 01 Aug 2023 04:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qQkoY-0001QC-VO
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 04:33:10 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qQkoV-0004CM-Dl
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 04:33:10 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8DxqOo7w8hkaP4NAA--.23570S3;
 Tue, 01 Aug 2023 16:32:59 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxriM5w8hk6MFDAA--.5274S3; 
 Tue, 01 Aug 2023 16:32:57 +0800 (CST)
Subject: Re: [PATCH 3/8] Introduced a new function to disconnect GPIO
 connections
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <cover.1689837093.git.lixianglai@loongson.cn>
 <6f3c91ecab2d61c2cfb2d1a34a0f2120138e28ed.1689837093.git.lixianglai@loongson.cn>
 <20230728135930.456842ad@imammedo.users.ipa.redhat.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <909037ca-0708-6c1a-681a-5ef9f8f6a681@loongson.cn>
Date: Tue, 1 Aug 2023 16:32:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230728135930.456842ad@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxriM5w8hk6MFDAA--.5274S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWr17Gr15ZFWxAw15WFW7GFX_yoW5Xw4DpF
 WDG3Z8AFnrtr1UAwnFv3ZFkFy7Xw4kKa4xuwn3G340kr9Fg3s8Jr4Iq3W5Z34Dur9YgF4U
 WFWYgay0qa48ZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jY
 SoJUUUUU=
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.101,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi, Igor Mammedov:

On 7/28/23 7:59 PM, Igor Mammedov wrote:
> On Thu, 20 Jul 2023 15:15:08 +0800
> xianglai li <lixianglai@loongson.cn> wrote:
>
>> It introduces a new function to unwire the
>> vcpu<->exioi interrupts for the vcpu hot-(un)plug cases.
> it's not a new function.
> You probably wanted to say:
>
> subj: make foo() public
>
> it will be reused .someplace. for ...
Ok, I'll fix it in the next version of patch.
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
>> Signed-off-by: xianglai li <lixianglai@loongson.cn>
>> ---
>>   hw/core/gpio.c         | 4 ++--
>>   include/hw/qdev-core.h | 2 ++
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/core/gpio.c b/hw/core/gpio.c
>> index 80d07a6ec9..4fc6409545 100644
>> --- a/hw/core/gpio.c
>> +++ b/hw/core/gpio.c
>> @@ -143,8 +143,8 @@ qemu_irq qdev_get_gpio_out_connector(DeviceState *dev, const char *name, int n)
>>   
>>   /* disconnect a GPIO output, returning the disconnected input (if any) */
>>   
>> -static qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
>> -                                               const char *name, int n)
>> +qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
>> +                                        const char *name, int n)
>>   {
>>       char *propname = g_strdup_printf("%s[%d]",
>>                                        name ? name : "unnamed-gpio-out", n);
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index 884c726a87..992f5419fa 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -739,6 +739,8 @@ qemu_irq qdev_get_gpio_out_connector(DeviceState *dev, const char *name, int n);
>>    */
>>   qemu_irq qdev_intercept_gpio_out(DeviceState *dev, qemu_irq icpt,
>>                                    const char *name, int n);
>> +qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
>> +                                               const char *name, int n);
> watch for proper alignment
>
> have you tried to run ./scripts/checkpatch.pl on you series?
> (it should catch such cases)

Ok, I'll fix it in the next version of patch.

I ran ./scripts/checkpatch.pl on my patch.pl but didn't check for the 
problem.

>>   
>>   BusState *qdev_get_child_bus(DeviceState *dev, const char *name);
>>   

Thanks,

xianglai.


