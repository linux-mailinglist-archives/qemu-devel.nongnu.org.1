Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F4699DB43
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Oct 2024 03:21:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0WEt-0000Go-Lw; Mon, 14 Oct 2024 21:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t0WEq-0000Gd-Ns
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 21:20:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t0WEn-0002cV-Sm
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 21:20:40 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Axholdww1nyV4cAA--.40862S3;
 Tue, 15 Oct 2024 09:20:29 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMDx_9daww1naTQqAA--.7718S3;
 Tue, 15 Oct 2024 09:20:26 +0800 (CST)
Subject: Re: [PULL v2 40/61] hw/acpi: Update GED _EVT method AML with CPU scan
To: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, zhukeqian <zhukeqian1@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Gavin Shan
 <gshan@redhat.com>, Vishnu Pajjuri <vishnu@os.amperecomputing.com>,
 Xianglai Li <lixianglai@loongson.cn>, Miguel Luis <miguel.luis@oracle.com>,
 Shaoqin Huang <shahuang@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
 <549c9a9dcbc1592ea79496f7b3ab234f366adeba.1721731723.git.mst@redhat.com>
 <ac9244d8-660a-ade6-9987-352c3c646a76@loongson.cn>
 <30c0297bd01f48868694e47e18841fab@huawei.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <d6c51e74-5e11-e375-30fd-6d6fb23c7271@loongson.cn>
Date: Tue, 15 Oct 2024 09:20:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <30c0297bd01f48868694e47e18841fab@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_9daww1naTQqAA--.7718S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Wr17XrW7GFW8Zw1DXry8Xrc_yoW7WF4Dpa
 9FkF4Y9rWkGr1j9w4YqasIya9rKrs5GwsrWF4DJF109asFvr1fGF10gw15CF90yF4Iga1r
 Z3WIg3s2gr13ArXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.396,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Salil,

On 2024/10/15 上午3:59, Salil Mehta wrote:
> Hi Bibo,
> 
>>   From: maobibo <maobibo@loongson.cn>
>>   Sent: Monday, October 14, 2024 9:53 AM
>>   To: qemu-devel@nongnu.org; Salil Mehta <salil.mehta@huawei.com>
>>   Cc: Michael S. Tsirkin <mst@redhat.com>; Peter Maydell
>>   <peter.maydell@linaro.org>; Salil Mehta <salil.mehta@huawei.com>;
>>   zhukeqian <zhukeqian1@huawei.com>; Jonathan Cameron
>>   <jonathan.cameron@huawei.com>; Gavin Shan <gshan@redhat.com>;
>>   Vishnu Pajjuri <vishnu@os.amperecomputing.com>; Xianglai Li
>>   <lixianglai@loongson.cn>; Miguel Luis <miguel.luis@oracle.com>; Shaoqin
>>   Huang <shahuang@redhat.com>; Zhao Liu <zhao1.liu@intel.com>; Igor
>>   Mammedov <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>
>>   Subject: Re: [PULL v2 40/61] hw/acpi: Update GED _EVT method AML with
>>   CPU scan
>>   
>>   Hi Salil,
>>   
>>   When I debug cpu hotplug on LoongArch system, It reports error like this:
>>        ACPI BIOS Error (bug): Could not resolve symbol [\_SB.GED.CSCN],
>>   AE_NOT_FOUND
>>        ACPI Error: Aborting method \_SB.GED._EVT due to previous error
>>   (AE_NOT_FOUND)
>>        acpi-ged ACPI0013:00: IRQ method execution failed
>>   
>>   
>>   With this patch, GED CPU call method is "\\_SB.GED.CSCN", however in
>>   function build_cpus_aml(), its method name is "\\_SB.CPUS.CSCN".
>>        method = aml_method(event_handler_method, 0,
>>   AML_NOTSERIALIZED);
>>        aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
>>        aml_append(table, method);
>>   
>>   It seems that CPU scanning method name is not consistent between
>>   function build_cpus_aml() and build_ged_aml().
> 
> 
> I believe your question stems from the following patch I've sent recently:
> 
> https://lore.kernel.org/qemu-devel/20241009031815.250096-16-salil.mehta@huawei.com/
> 
> I’ve already proposed a fix for this issue. Does that not work for you?
yes, it works for me if AML_GED_EVT_CPU_SCAN_METHOD is used as parameter 
in function build_cpus_aml().

Sorry for the noise.

Regards
Bibo Mao
> 
> Thanks
> Salil.
> 
> 
>>   
>>   Regards
>>   Bibo Mao
>>   
>>   On 2024/7/23 下午6:59, Michael S. Tsirkin wrote:
>>   > From: Salil Mehta <salil.mehta@huawei.com>
>>   >
>>   > OSPM evaluates _EVT method to map the event. The CPU hotplug event
>>   > eventually results in start of the CPU scan. Scan figures out the CPU
>>   > and the kind of
>>   > event(plug/unplug) and notifies it back to the guest. Update the GED
>>   > AML _EVT method with the call to method \\_SB.CPUS.CSCN (via
>>   > \\_SB.GED.CSCN)
>>   >
>>   > Architecture specific code [1] might initialize its CPUs AML code by
>>   > calling common function build_cpus_aml() like below for ARM:
>>   >
>>   > build_cpus_aml(scope, ms, opts, xx_madt_cpu_entry,
>>   memmap[VIRT_CPUHP_ACPI].base,
>>   >                 "\\_SB", "\\_SB.GED.CSCN", AML_SYSTEM_MEMORY);
>>   >
>>   > [1]
>>   > https://lore.kernel.org/qemu-devel/20240613233639.202896-13-salil.meht
>>   > a@huawei.com/
>>   >
>>   > Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
>>   > Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>>   > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>   > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>   > Reviewed-by: Gavin Shan <gshan@redhat.com>
>>   > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>>   > Tested-by: Xianglai Li <lixianglai@loongson.cn>
>>   > Tested-by: Miguel Luis <miguel.luis@oracle.com>
>>   > Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
>>   > Tested-by: Zhao Liu <zhao1.liu@intel.com>
>>   > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>>   > Message-Id: <20240716111502.202344-5-salil.mehta@huawei.com>
>>   > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>   > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>   > ---
>>   >   include/hw/acpi/generic_event_device.h | 1 +
>>   >   hw/acpi/generic_event_device.c         | 3 +++
>>   >   2 files changed, 4 insertions(+)
>>   >
>>   > diff --git a/include/hw/acpi/generic_event_device.h
>>   > b/include/hw/acpi/generic_event_device.h
>>   > index e091ac2108..40af3550b5 100644
>>   > --- a/include/hw/acpi/generic_event_device.h
>>   > +++ b/include/hw/acpi/generic_event_device.h
>>   > @@ -87,6 +87,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState,
>>   ACPI_GED)
>>   >   #define GED_DEVICE      "GED"
>>   >   #define AML_GED_EVT_REG "EREG"
>>   >   #define AML_GED_EVT_SEL "ESEL"
>>   > +#define AML_GED_EVT_CPU_SCAN_METHOD "\\_SB.GED.CSCN"
>>   >
>>   >   /*
>>   >    * Platforms need to specify the GED event bitmap diff --git
>>   > a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
>>   > index 4641933a0f..15b4c3ebbf 100644
>>   > --- a/hw/acpi/generic_event_device.c
>>   > +++ b/hw/acpi/generic_event_device.c
>>   > @@ -108,6 +108,9 @@ void build_ged_aml(Aml *table, const char *name,
>>   HotplugHandler *hotplug_dev,
>>   >                   aml_append(if_ctx, aml_call0(MEMORY_DEVICES_CONTAINER
>>   "."
>>   >                                                MEMORY_SLOT_SCAN_METHOD));
>>   >                   break;
>>   > +            case ACPI_GED_CPU_HOTPLUG_EVT:
>>   > +                aml_append(if_ctx,
>>   aml_call0(AML_GED_EVT_CPU_SCAN_METHOD));
>>   > +                break;
>>   >               case ACPI_GED_PWR_DOWN_EVT:
>>   >                   aml_append(if_ctx,
>>   >
>>   > aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
>>   >
> 


