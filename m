Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B492C876192
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Mar 2024 11:10:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riXAh-0004ue-1I; Fri, 08 Mar 2024 05:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1riXAe-0004uA-2K
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 05:09:44 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1riXAb-0000Gu-4n
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 05:09:43 -0500
Received: from loongson.cn (unknown [117.67.153.132])
 by gateway (Coremail) with SMTP id _____8Dx_7vh4+pl+D8WAA--.35485S3;
 Fri, 08 Mar 2024 18:09:37 +0800 (CST)
Received: from [192.168.2.12] (unknown [117.67.153.132])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxRMze4+pldU9RAA--.10510S3; 
 Fri, 08 Mar 2024 18:09:34 +0800 (CST)
Message-ID: <5fc9373c-d9d9-73a8-5888-6d0ebc2fe511@loongson.cn>
Date: Fri, 8 Mar 2024 18:09:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v6 06/17] hw/loongarch: Init efi_boot_memmap table
To: maobibo <maobibo@loongson.cn>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240307164835.300412-1-gaosong@loongson.cn>
 <20240307164835.300412-7-gaosong@loongson.cn>
 <55380fac-8d89-7914-3f1d-e64e5864f719@loongson.cn>
From: gaosong <gaosong@loongson.cn>
In-Reply-To: <55380fac-8d89-7914-3f1d-e64e5864f719@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxRMze4+pldU9RAA--.10510S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtr4DKF48uw1fJF15XryDXFc_yoWxWFy5pF
 ykAFWrJrWrGrn7JrnrXw1UJFy5Jrn7K3ZrGw1xXF1jkr47ArnFgF45Xryq9FyDJr48Ar1j
 yFnYgrW7uF47J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.08,
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



在 2024/3/8 16:37, maobibo 写道:
> 
> 
> On 2024/3/8 上午12:48, Song Gao wrote:
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> Message-Id: <20240301093839.663947-7-gaosong@loongson.cn>
>> ---
>>   hw/loongarch/boot.c         | 39 +++++++++++++++++++++++++++++++++++++
>>   hw/loongarch/virt.c         | 11 ++---------
>>   include/hw/loongarch/boot.h | 27 +++++++++++++++++++++++++
>>   include/hw/loongarch/virt.h | 10 ++++++++++
>>   4 files changed, 78 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
>> index 1e31e2a59f..2896c1ea40 100644
>> --- a/hw/loongarch/boot.c
>> +++ b/hw/loongarch/boot.c
>> @@ -63,8 +63,40 @@ static const unsigned int slave_boot_code[] = {
>>       0x4c000020,   /* jirl       $r0,$r1,0           */
>>   };
>> +static inline void *guidcpy(void *dst, const void *src)
>> +{
>> +    return memcpy(dst, src, sizeof(efi_guid_t));
>> +}
>> +
>> +static void init_efi_boot_memmap(struct efi_system_table *systab,
>> +                                 void *p, void *start)
>> +{
>> +    unsigned i;
>> +    struct efi_boot_memmap *boot_memmap = p;
>> +    efi_guid_t tbl_guid = LINUX_EFI_BOOT_MEMMAP_GUID;
>> +
>> +    /* efi_configuration_table 1 */
>> +    guidcpy(&systab->tables[0].guid, &tbl_guid);
>> +    systab->tables[0].table = (struct efi_configuration_table *)(p - 
>> start);
>> +    systab->nr_tables = 1;
>> +
>> +    boot_memmap->desc_size = sizeof(efi_memory_desc_t);
>> +    boot_memmap->desc_ver = 1;
>> +    boot_memmap->map_size = 0;
>> +
>> +    efi_memory_desc_t *map = p + sizeof(struct efi_boot_memmap);
>> +    for (i = 0; i < memmap_entries; i++) {
>> +        map = (void *)boot_memmap + sizeof(*map);
>> +        map[i].type = memmap_table[i].type;
>> +        map[i].phys_addr = memmap_table[i].address;
>> +        map[i].num_pages = memmap_table[i].length >> 16; /* 64KB align*/
> 64KB aligned or 64KB page size? In generic page size is 4K by EFI spec 
> IIRC.
> 
Thank you for pointing it out., I will correct it on v7.

> Regards
> Bibo Mao
> 
>> +        p += sizeof(efi_memory_desc_t);
>> +    }
>> +}
>> +
>>   static void init_systab(struct loongarch_boot_info *info, void *p, 
>> void *start)
>>   {
>> +    void *bp_tables_start;
>>       struct efi_system_table *systab = p;
>>       info->a2 = (uint64_t)p - (uint64_t)start;
>> @@ -80,6 +112,13 @@ static void init_systab(struct loongarch_boot_info 
>> *info, void *p, void *start)
>>       p += ROUND_UP(sizeof(struct efi_system_table), 64);
>>       systab->tables = p;
>> +    bp_tables_start = p;
>> +
>> +    init_efi_boot_memmap(systab, p, start);
>> +    p += ROUND_UP(sizeof(struct efi_boot_memmap) +
>> +                  sizeof(efi_memory_desc_t) * memmap_entries, 64);
>> +
>> +    systab->tables = (struct efi_configuration_table 
>> *)(bp_tables_start - start);
>>   }
>>   static void init_cmdline(struct loongarch_boot_info *info, void *p, 
>> void *start)
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index bbd5cc1d4d..8981b57b12 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -377,15 +377,8 @@ static void virt_powerdown_req(Notifier 
>> *notifier, void *opaque)
>>       acpi_send_event(s->acpi_ged, ACPI_POWER_DOWN_STATUS);
>>   }
>> -struct memmap_entry {
>> -    uint64_t address;
>> -    uint64_t length;
>> -    uint32_t type;
>> -    uint32_t reserved;
>> -};
>> -
>> -static struct memmap_entry *memmap_table;
>> -static unsigned memmap_entries;
>> +struct memmap_entry *memmap_table;
>> +unsigned memmap_entries;
>>   static void memmap_add_entry(uint64_t address, uint64_t length, 
>> uint32_t type)
>>   {
>> diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
>> index 65ad406f02..f71c693f43 100644
>> --- a/include/hw/loongarch/boot.h
>> +++ b/include/hw/loongarch/boot.h
>> @@ -21,6 +21,15 @@ typedef struct {
>>       uint8_t b[16];
>>   } efi_guid_t __attribute__((aligned(8)));
>> +#define EFI_GUID(a, b, c, d...) (efi_guid_t){ 
>> {                                \
>> +        (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 
>> 24) & 0xff, \
>> +        (b) & 0xff, ((b) >> 8) & 
>> 0xff,                                         \
>> +        (c) & 0xff, ((c) >> 8) & 0xff, d } }
>> +
>> +#define LINUX_EFI_BOOT_MEMMAP_GUID \
>> +        EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, \
>> +                 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
>> +
>>   struct efi_config_table {
>>       efi_guid_t guid;
>>       uint64_t *ptr;
>> @@ -56,6 +65,24 @@ struct efi_system_table {
>>       struct efi_configuration_table *tables;
>>   };
>> +typedef struct {
>> +    uint32_t type;
>> +    uint32_t pad;
>> +    uint64_t phys_addr;
>> +    uint64_t virt_addr;
>> +    uint64_t num_pages;
>> +    uint64_t attribute;
>> +} efi_memory_desc_t;
>> +
>> +struct efi_boot_memmap {
>> +    uint64_t map_size;
>> +    uint64_t desc_size;
>> +    uint32_t desc_ver;
>> +    uint64_t map_key;
>> +    uint64_t buff_size;
>> +    efi_memory_desc_t map[32];
>> +};
>> +
>>   struct loongarch_boot_info {
>>       uint64_t ram_size;
>>       const char *kernel_filename;
>> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
>> index d7a074d69f..8a9fe4053d 100644
>> --- a/include/hw/loongarch/virt.h
>> +++ b/include/hw/loongarch/virt.h
>> @@ -35,6 +35,16 @@
>>   #define COMMAND_LINE_SIZE       512
>> +extern struct memmap_entry *memmap_table;
>> +extern unsigned memmap_entries;
>> +
>> +struct memmap_entry {
>> +    uint64_t address;
>> +    uint64_t length;
>> +    uint32_t type;
>> +    uint32_t reserved;
>> +};
>> +
>>   struct LoongArchMachineState {
>>       /*< private >*/
>>       MachineState parent_obj;
>>


