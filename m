Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F36773A0F
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 14:09:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTLWV-0003aO-TV; Tue, 08 Aug 2023 08:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qTLWS-0003aF-O0
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 08:09:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qTLWP-0004Vi-Nq
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 08:09:12 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8BxnutgMNJk1NUSAA--.39399S3;
 Tue, 08 Aug 2023 20:09:04 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx3yNfMNJkrvROAA--.28242S3; 
 Tue, 08 Aug 2023 20:09:04 +0800 (CST)
Subject: Re: [PATCH 3/8] Introduced a new function to disconnect GPIO
 connections
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <cover.1689837093.git.lixianglai@loongson.cn>
 <6f3c91ecab2d61c2cfb2d1a34a0f2120138e28ed.1689837093.git.lixianglai@loongson.cn>
 <CAFEAcA9_yJki9Ntp-diviYHfxts-eJawcFiV1tYvpB2V0e7Mqw@mail.gmail.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <806a8cee-1690-36e1-083a-5b57ba0b3ca3@loongson.cn>
Date: Tue, 8 Aug 2023 20:09:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9_yJki9Ntp-diviYHfxts-eJawcFiV1tYvpB2V0e7Mqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bx3yNfMNJkrvROAA--.28242S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxKr4UZrWxXw47XF4kXrW8uFX_yoWxtF4DpF
 y8WF1YgrW8Zr18Aa4jq3WUuFyUtrZ0k3ZrCr1rta18Cw1DCw1Yvr17XFyFgry5C395tr1j
 vF1rX340v3Z8AwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1
 WlkUUUUU=
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.14,
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

Hi,Peter Maydell :


On 7/28/23 8:38 PM, Peter Maydell wrote:
> On Thu, 20 Jul 2023 at 08:16, xianglai li <lixianglai@loongson.cn> wrote:
>> It introduces a new function to unwire the
>> vcpu<->exioi interrupts for the vcpu hot-(un)plug cases.
>>
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
> This function as currently written is intended only for
> use in qdev_intercept_gpio_out(), which in turn is there
> only for qtest test case use. I would be a bit cautious
> about whether there are unexpected issues with trying
> to use it in "production" functionality with a running
> QEMU (eg when perhaps some device might be trying to
> signal the gpio line in another thread while this one
> is trying to disconnect it).

That's how I understand it:

Take Loongarch's extended interrupt controller, for example:

1.The interrupt pin of the extended interrupt controller is initialized in

static void loongarch_extioi_instance_init(Object *obj)

{

....

     for (cpu = 0; cpu < EXTIOI_CPUS; cpu++) {
....
         for (pin = 0; pin < LS3A_INTC_IP; pin++) {
             qdev_init_gpio_out(DEVICE(obj), &s->parent_irq[cpu][pin], 1);
         }
     }

.....

}

The above function binds the extended interrupt pin to the variable 
s->parent_irq[cpu][pin] pointer.

2.The assignment of the interrupt pin of the extended interrupt 
controller operates in

static LoongArchCPU *loongarch_cpu_create(MachineState *machine, 
LoongArchCPU *cpu, Error **errp)
{
...
         for (pin = 0; pin < LS3A_INTC_IP; pin++) {
             qdev_connect_gpio_out(extioi, (cpu_index * 8 + pin), 
qdev_get_gpio_in(cpudev, pin + 2));
         }
...
}

The above function binds the extended interrupt pin to the return value 
of the qdev_get_gpio_in(cpudev, pin + 2).

You actually do the following:

s->parent_irq[cpu][pin] = qdev_get_gpio_in(cpudev, pin + 2);

Variables are only accessed when the interrupt controller's IO space is 
extended to read and write.

There are QEMU thread locks when reading and writing in IO space：

static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL, 
hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result, enum 
device_endian endian)
{
...
     RCU_READ_LOCK();
...
     release_lock |= prepare_mmio_access(mr);
     r = memory_region_dispatch_write(mr, addr1, val, MO_16 | 
devend_memop(endian), attrs);
...
     if (release_lock) {
         qemu_mutex_unlock_iothread();
     }
     RCU_READ_UNLOCK();
...
}

Therefore, both are locked by the thread of QEMU when the CPU is 
unplugged or interrupted sent, which can ensure that the two are 
mutually exclusive.

 From the call stack below, it can be seen that interrupt sending and 
CPU unplugging are in two worker threads, but both worker threads are 
mutexe.

for example:

Thread 1 "qemu-system-loo" hit Breakpoint 5, qemu_set_irq
41          if (!irq)
(gdb) bt
#0  0x000000aaab1e3630 in qemu_set_irq
#1  0x000000aaab1324d8 in loongarch_msi_mem_write
#2  0x000000aaab1835e0 in memory_region_write_accessor
#3  0x000000aaab182e38 in access_with_adjusted_size
#4  0x000000aaab18323c in memory_region_dispatch_write
#5  0x000000aaab190cf8 in address_space_stl_internal
#6  0x000000aaab190cf8 in address_space_stl_le
#7  0x000000aaab3714a8 in aio_dispatch_handler
#8  0x000000aaab371e20 in aio_dispatch_handlers
#9  0x000000aaab371e20 in aio_dispatch
#10 0x000000aaab388ae0 in aio_ctx_dispatch
#11 0x000000fff724d334 in g_main_context_dispatch
#12 0x000000aaab38a390 in glib_pollfds_poll
#13 0x000000aaab38a390 in os_host_main_loop_wait
#14 0x000000aaab38a390 in main_loop_wait
#15 0x000000aaab05aa0c in qemu_main_loop
#16 0x000000aaab1ddf2c in qemu_default_main
#17 0x000000fff60d9670 in __libc_start_main
#18 0x000000aaaae719fc in _start ()
(gdb) call qemu_mutex_iothread_locked()
$5 = true

Thread 4 "qemu-system-loo" hit Breakpoint 2, loongarch_cpu_destroy
1177        LoongArchMachineState *lsms = LOONGARCH_MACHINE(machine);
(gdb) bt
#0  0x000000aaab0eeb60 in loongarch_cpu_destroy
#1  0x000000aaab0eeb60 in loongarch_cpu_unplug
#2  0x000000aaab0eeb60 in virt_machine_device_unplug
#3  0x000000aaab0eeb60 in virt_machine_device_unplug
#4  0x000000aaaaeca0d8 in cpu_hotplug_wr
#5  0x000000aaab1835e0 in memory_region_write_accessor
#6  0x000000aaab182e38 in access_with_adjusted_size
#7  0x000000aaab18323c in memory_region_dispatch_write
#8  0x000000aaab18a914 in flatview_write_continue
#9  0x000000aaab18aae0 in flatview_write
#10 0x000000aaab18ab7c in subpage_write
#11 0x000000aaab183328 in memory_region_write_with_attrs_accessor
#12 0x000000aaab182e38 in access_with_adjusted_size
#13 0x000000aaab18323c in memory_region_dispatch_write
#14 0x000000aaab1ca714 in io_writex
#15 0x000000aaab1cfdfc in helper_stb_mmu
#16 0x000000ffa55a2224 in code_gen_buffer ()
#17 0x000000aaab1be7d0 in tb_lookup
#18 0x000000aaab1be7d0 in cpu_exec_loop
#19 0x000000aaab1bf04c in cpu_exec_setjmp
#20 0x000000aaab1bf0f8 in cpu_exec
#21 0x000000aaab1da660 in tcg_cpus_exec
#22 0x000000aaab1da7e0 in mttcg_cpu_thread_fn
#23 0x000000aaab374fd4 in qemu_thread_start
#24 0x000000fff623ddc8 in start_thread
#25 0x000000fff618d8fc in __thread_start
(gdb) call qemu_mutex_iothread_locked()
$6 = true

Thanks,

xianglai

> thanks
> -- PMM


