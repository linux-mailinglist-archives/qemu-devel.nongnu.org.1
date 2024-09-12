Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E60C97681B
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Sep 2024 13:48:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soiIg-0007Fj-ND; Thu, 12 Sep 2024 07:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1soiIc-0007F5-QK
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 07:47:46 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1soiIZ-0002am-Vm
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 07:47:46 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Cxyuna1OJmHtcFAA--.13450S3;
 Thu, 12 Sep 2024 19:47:38 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front2 (Coremail) with SMTP id qciowMDxl8XX1OJml7EFAA--.8927S3;
 Thu, 12 Sep 2024 19:47:38 +0800 (CST)
Subject: Re: [PATCH v2 0/2] Add FDT table support with acpi ged pm register
To: gaosong <gaosong@loongson.cn>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: Ani Sinha <anisinha@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, =?UTF-8?Q?Thomas_Wei=c3=9fschuh?=
 <thomas@t-8ch.de>, qemu-devel@nongnu.org
References: <20240911030922.877259-1-maobibo@loongson.cn>
 <72d5883d-815e-1f82-236e-1d3cbdb834a9@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <3b0040be-9671-5e76-1ebd-8d2ca5801734@loongson.cn>
Date: Thu, 12 Sep 2024 19:47:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <72d5883d-815e-1f82-236e-1d3cbdb834a9@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qciowMDxl8XX1OJml7EFAA--.8927S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7trWrGF4kAryxuF4xJr48Zrc_yoW8Xw1fpa
 48Ka45ArWUGrn7Cw43Xw1UGFy5Jr1Syw4UXF17tFyUGFW5Gr1FqF1rXry2gFyUtw4fJr40
 yw17KryUuFy5ArcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU1EksDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.188,
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

Song,

On 2024/9/12 下午7:35, gaosong wrote:
> 
> 
> 在 2024/9/11 上午11:09, Bibo Mao 写道:
>> ACPI ged is used for power management on LoongArch virt platform, in
>> general it is parsed from acpi table. However if system boot directly 
>> from
>> elf kernel, no UEFI bios is provided and acpi table cannot be used also.
>>
>> Here acpi ged pm register is exposed with FDT table, it is compatbile
>> with syscon method in FDT table, only that acpi ged pm register is 
>> accessed
>> with 8-bit mode, rather with 32-bit mode.
>>
>> ---
>> v1 ... v2:
>>    1. Modify name of macro for acpi ged register from ACPI spec, and 
>> also add
>>       comments for macro definition.
>> ---
>> Bibo Mao (2):
>>    acpi: ged: Add macro for acpi sleep control register
>>    hw/loongarch/virt: Add FDT table support with acpi ged pm register
>>
> 
> 
>>   hw/acpi/generic_event_device.c         |  6 ++--
>>   hw/i386/acpi-microvm.c                 |  2 +-
>>   hw/loongarch/acpi-build.c              |  2 +-
>>   hw/loongarch/virt.c                    | 39 ++++++++++++++++++++++++++
>>   include/hw/acpi/generic_event_device.h |  9 ++++--
>>   5 files changed, 51 insertions(+), 7 deletions(-)
>>
>>
>> base-commit: a66f28df650166ae8b50c992eea45e7b247f4143
>> Reviewed-by: Song Gao <gaosong@loongson.cn>
> 
> Applied series to loongarch-next

It is not urgent and it needs approval from other maintainers :)

Regards
Bibo Mao
> 
> Thanks
> Song Gao
> 
> 


