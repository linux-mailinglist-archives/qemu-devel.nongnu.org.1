Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB782ABB30D
	for <lists+qemu-devel@lfdr.de>; Mon, 19 May 2025 04:05:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGprA-0006Qt-Es; Sun, 18 May 2025 22:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uGpr7-0006QR-4r
 for qemu-devel@nongnu.org; Sun, 18 May 2025 22:03:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uGpr4-0005uW-GN
 for qemu-devel@nongnu.org; Sun, 18 May 2025 22:03:52 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxmnF8kSpo24fxAA--.62897S3;
 Mon, 19 May 2025 10:03:40 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxn8V4kSposjbgAA--.49748S3;
 Mon, 19 May 2025 10:03:40 +0800 (CST)
Subject: Re: [PATCH 3/6] tests/qtest/bios-tables-test: Add basic testing for
 LoongArch64
To: Igor Mammedov <imammedo@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20250228092729.543097-1-maobibo@loongson.cn>
 <20250228092729.543097-4-maobibo@loongson.cn>
 <20250401154104.13219e16@imammedo.users.ipa.redhat.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <438115c3-b33f-f798-7a42-c6bfe210882a@loongson.cn>
Date: Mon, 19 May 2025 10:02:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250401154104.13219e16@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8V4kSposjbgAA--.49748S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr1rXFW8CFy8Kr48JF4DKFX_yoWrXr1Dpr
 ZrArn0krWUJr9Fgw1xG3s0vry5trs7GrnruF9Fga18KrWqkryvvF1xKFy5WFyvkw40ga10
 va48Gr1UW3WrJFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.872,
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



On 2025/4/1 下午9:41, Igor Mammedov wrote:
> On Fri, 28 Feb 2025 17:27:26 +0800
> Bibo Mao <maobibo@loongson.cn> wrote:
> 
>> Add basic ACPI table test case for LoongArch64.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   tests/qtest/bios-tables-test.c | 62 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 62 insertions(+)
>>
>> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
>> index 0a333ec435..008d7a0497 100644
>> --- a/tests/qtest/bios-tables-test.c
>> +++ b/tests/qtest/bios-tables-test.c
>> @@ -2420,6 +2420,59 @@ static void test_acpi_aarch64_virt_oem_fields(void)
>>       g_free(args);
>>   }
>>   
>> +#define LOONGARCH64_INIT_TEST_DATA(data)                          \
>> +    test_data data = {                                            \
>> +        .machine = "virt",                                        \
>> +        .arch    = "loongarch64",                                 \
>> +        .tcg_only = true,                                         \
>> +        .uefi_fl1 = "pc-bios/edk2-loongarch64-code.fd",           \
>> +        .uefi_fl2 = "pc-bios/edk2-loongarch64-vars.fd",           \
>> +        .cd = "tests/data/uefi-boot-images/"                      \
>> +              "bios-tables-test.loongarch64.iso.qcow2",           \
>> +        .ram_start = 0,                                           \
>> +        .scan_len = 128ULL * 1024 * 1024,                         \
> 
> while it consistent with other test, we should switch to using MiB macro
> so I'd like to ask
>   * 1st convert all similar places in bios-tables-test.c 'x * MiB' style
>   * fix up this patch to use that as well
yes, will use MiB macro.

> 
>> +    }
>> +
>> +static void test_acpi_loongarch64_virt(void)
>> +{
>> +    LOONGARCH64_INIT_TEST_DATA(data);
>> +
>> +    test_acpi_one("-cpu la464 ", &data);
>> +    free_test_data(&data);
>> +}
>> +
>> +static void test_acpi_loongarch64_virt_topology(void)
>> +{
>> +    LOONGARCH64_INIT_TEST_DATA(data);
>> +
>> +    data.variant = ".topology";
>> +    test_acpi_one("-cpu la464 -smp sockets=1,cores=4,threads=2", &data);
>> +    free_test_data(&data);
>> +}
>> +
>> +static void test_acpi_loongarch64_virt_numamem(void)
>> +{
>> +    LOONGARCH64_INIT_TEST_DATA(data);
>> +
>> +    data.variant = ".numamem";
>> +    test_acpi_one(" -cpu la464 -object memory-backend-ram,id=ram0,size=128M"
>> +                  " -numa node,memdev=ram0", &data);
>> +    free_test_data(&data);
>> +}
>> +
> 
>> +static void test_acpi_loongarch64_virt_memhp(void)
>> +{
>> +    LOONGARCH64_INIT_TEST_DATA(data);
>> +
>> +    data.variant = ".memhp";
>> +    test_acpi_one(" -cpu la464 -m 128,slots=3,maxmem=1G"
> 
>> +                  " -object memory-backend-ram,id=ram0,size=64M"
>> +                  " -object memory-backend-ram,id=ram1,size=64M"
>> +                  " -numa node,memdev=ram0 -numa node,memdev=ram1"
>> +                  " -numa dist,src=0,dst=1,val=21",
> I'd test numa specific stuff in test_acpi_loongarch64_virt_numamem()
> and simplify this test case.
Actually it is a little strange here. There is no SLIT information in 
numamem(), however it is in memhp() test case.

Will move it to numa test case and make memory hotplug case simpler.
> 
>> +                  &data);
>> +    free_test_data(&data);
>> +}
>>   
>>   int main(int argc, char *argv[])
>>   {
>> @@ -2593,6 +2646,15 @@ int main(int argc, char *argv[])
>>               qtest_add_func("acpi/virt/numamem",
>>                              test_acpi_riscv64_virt_tcg_numamem);
>>           }
>> +    } else if (strcmp(arch, "loongarch64") == 0) {
>> +        if (has_tcg && qtest_has_device("virtio-blk-pci")) {
>                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> is it necessary?
> if yes, then add explanation to commit message, why it's need.
 From the code it is not necessary if UEFI bios is used here. It passes 
to run if it is removed.

Will remove it in next patch.

Regards
Bibo Mao
> 
>> +            qtest_add_func("acpi/virt", test_acpi_loongarch64_virt);
>> +            qtest_add_func("acpi/virt/topology",
>> +                           test_acpi_loongarch64_virt_topology);
>> +            qtest_add_func("acpi/virt/numamem",
>> +                           test_acpi_loongarch64_virt_numamem);
>> +            qtest_add_func("acpi/virt/memhp", test_acpi_loongarch64_virt_memhp);
>> +        }
>>       }
>>       ret = g_test_run();
>>       boot_sector_cleanup(disk);


