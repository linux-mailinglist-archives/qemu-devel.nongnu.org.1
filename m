Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3C5715FB4
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:32:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yVJ-0005Y4-Hx; Tue, 30 May 2023 08:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1q3yUN-0003kc-H7; Tue, 30 May 2023 08:30:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1q3yUJ-00013Z-Tj; Tue, 30 May 2023 08:30:10 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8AxretI7HVk3pYCAA--.5723S3;
 Tue, 30 May 2023 20:30:00 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxFLFH7HVk4JuAAA--.12519S3; 
 Tue, 30 May 2023 20:30:00 +0800 (CST)
Subject: Re: [PATCH 05/10] hw/loongarch/virt: Use memory_devices_init()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230530113838.257755-1-david@redhat.com>
 <20230530113838.257755-6-david@redhat.com>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <7218db88-ec2f-58cb-a113-5ebce8d57688@loongson.cn>
Date: Tue, 30 May 2023 20:29:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230530113838.257755-6-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxFLFH7HVk4JuAAA--.12519S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7AFWfJryxCr1ruw45uF4fuFg_yoW8ury5pF
 yfAas8Gr4Fqr9xGwn7Ww1DWFy8Jw4kCa4FqFyxZrWv9FnrXr90k34UJ34kt3y8A39IqF4U
 ZFWkJF1fX3W5J3DanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
 bDkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
 1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
 wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
 x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AF
 wI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
 c4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
 Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
 6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
 AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
 1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8RuWPUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
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



在 2023/5/30 下午7:38, David Hildenbrand 写道:
> Let's use our new helper.
>
> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> Cc: Song Gao <gaosong@loongson.cn>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/loongarch/virt.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index ceddec1b23..a6790714fe 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -45,7 +45,7 @@
>   #include "sysemu/block-backend.h"
>   #include "hw/block/flash.h"
>   #include "qemu/error-report.h"
> -
> +#include "hw/mem/memory-device.h"
>   
>   static void virt_flash_create(LoongArchMachineState *lams)
>   {
> @@ -805,8 +805,8 @@ static void loongarch_init(MachineState *machine)
>   
>       /* initialize device memory address space */
>       if (machine->ram_size < machine->maxram_size) {
> -        machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
>           ram_addr_t device_mem_size = machine->maxram_size - machine->ram_size;
> +        hwaddr device_mem_base;
>   
>           if (machine->ram_slots > ACPI_MAX_RAM_SLOTS) {
>               error_report("unsupported amount of memory slots: %"PRIu64,
> @@ -821,14 +821,8 @@ static void loongarch_init(MachineState *machine)
>               exit(EXIT_FAILURE);
>           }
>           /* device memory base is the top of high memory address. */
> -        machine->device_memory->base = 0x90000000 + highram_size;
> -        machine->device_memory->base =
> -            ROUND_UP(machine->device_memory->base, 1 * GiB);
> -
> -        memory_region_init(&machine->device_memory->mr, OBJECT(lams),
> -                           "device-memory", device_mem_size);
> -        memory_region_add_subregion(address_space_mem, machine->device_memory->base,
> -                                    &machine->device_memory->mr);
> +        device_mem_base = ROUND_UP(0x90000000 + highram_size, 1 * GiB);
Use  VIRT_HIGHMEM_BASE.

Otherwise,
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> +        memory_devices_init(machine, device_mem_base, device_mem_size);
>       }
>   
>       /* Add isa io region */


