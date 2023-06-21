Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 730387386FE
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:28:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByot-0008Rv-QH; Wed, 21 Jun 2023 10:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qByom-0008Pe-Ic
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:28:20 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qByok-0002EX-V1
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F5MJ8i8ZnCYoqFs+rXH4qD/9kPCbBOJXMuJwzbeBkc4=; b=wHjB5kUF3ZRW2vuBjq+qEVaIFV
 3RljLPwM2VGkwXBPEZzGNh0jgzAoo2FH8R+afR3uzFpmyrfG0bmLvlXWqG3ppGoBW59j11z215W7D
 hcdYQdbOe4wHXAy5EcGk4zVCukdwL9IZCd52zsdjIiOGFk8dmJy+4YGSanzY/lVf8weKcqq3SNWdI
 CQc3vldHguHwJrs799KbaiPGvhaONVeEQmMQkdrWzY7kVowR3U9dDjTn1+BTYZ1hoI9/oa9RovEaQ
 TYJalkT3hlp/0o8+oDVzVSkywP7okIXd17Gi/8LU8TgMtjO6VZCis0DiY/JEvJxll7yyUCOPN1d3G
 9jNceGhIWyr0Frstn0gmxX0Nsw4qMazBTnyNNod9lm9oO3CCyMNFrPNND4BvW4i+zo7QSw4rIdvdp
 Pf0+PkPG7jyUX4DHss3CTDJRDpUY9tiHKowet7UPzhl6H8MqLLOgwsFkMimN5QyQgKYZZxXHSvrUv
 x67BI13Fr0KlRZh/yCu55znq+zfpnb8NvFO5AyJyaEoXLRYw/tVhVS6V69oKU6X64vUPD9Gbx3q+9
 NNawvkVIMbWtm7Jtd1/RzhcitLCZQv/v7nCa+5tSY8M2x/iGzAsq3UQLeZFgpKRljPtTT5r1/7Rj1
 ADjJrUl3Sg2Y9fvnfjt536WuzMSPbaP7yxrQUWutA=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qByoY-0003Nt-I3; Wed, 21 Jun 2023 15:28:10 +0100
Message-ID: <be3b7427-5f76-76af-d47a-d2f233357349@ilande.co.uk>
Date: Wed, 21 Jun 2023 15:28:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: laurent@vivier.eu, qemu-devel@nongnu.org
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
 <20230621085353.113233-6-mark.cave-ayland@ilande.co.uk>
 <eaa9eb9e-1a1f-82a6-7daa-3fe547f59c24@eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <eaa9eb9e-1a1f-82a6-7daa-3fe547f59c24@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v4 05/24] q800: move CPU object into Q800MachineState
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 21/06/2023 12:56, BALATON Zoltan wrote:

> On Wed, 21 Jun 2023, Mark Cave-Ayland wrote:
>> Also change the instantiation of the CPU to use object_initialize_child()
>> followed by a separate realisation.
> 
> Also seems to restrict valid CPU types but not mentioned in commit message. Should 
> this patch be split up?

Hmmm good point. Laurent, would you like me to split this into a separate patch or 
would updating the commit message be sufficient?

>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> hw/m68k/q800.c         | 18 +++++++++++++-----
>> include/hw/m68k/q800.h |  3 +++
>> 2 files changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
>> index 062a3c6c76..2b651de3c1 100644
>> --- a/hw/m68k/q800.c
>> +++ b/hw/m68k/q800.c
>> @@ -364,7 +364,7 @@ static uint8_t fake_mac_rom[] = {
>>
>> static void q800_machine_init(MachineState *machine)
>> {
>> -    M68kCPU *cpu = NULL;
>> +    Q800MachineState *m = Q800_MACHINE(machine);
>>     int linux_boot;
>>     int32_t kernel_size;
>>     uint64_t elf_entry;
>> @@ -407,8 +407,9 @@ static void q800_machine_init(MachineState *machine)
>>     }
>>
>>     /* init CPUs */
>> -    cpu = M68K_CPU(cpu_create(machine->cpu_type));
>> -    qemu_register_reset(main_cpu_reset, cpu);
>> +    object_initialize_child(OBJECT(machine), "cpu", &m->cpu, machine->cpu_type);
>> +    qdev_realize(DEVICE(&m->cpu), NULL, &error_fatal);
>> +    qemu_register_reset(main_cpu_reset, &m->cpu);
>>
>>     /* RAM */
>>     memory_region_add_subregion(get_system_memory(), 0, machine->ram);
>> @@ -430,7 +431,8 @@ static void q800_machine_init(MachineState *machine)
>>
>>     /* IRQ Glue */
>>     glue = qdev_new(TYPE_GLUE);
>> -    object_property_set_link(OBJECT(glue), "cpu", OBJECT(cpu), &error_abort);
>> +    object_property_set_link(OBJECT(glue), "cpu", OBJECT(&m->cpu),
>> +                             &error_abort);
>>     sysbus_realize_and_unref(SYS_BUS_DEVICE(glue), &error_fatal);
>>
>>     /* VIA 1 */
>> @@ -605,7 +607,7 @@ static void q800_machine_init(MachineState *machine)
>>
>>     macfb_mode = (NUBUS_MACFB(dev)->macfb).mode;
>>
>> -    cs = CPU(cpu);
>> +    cs = CPU(&m->cpu);
>>     if (linux_boot) {
>>         uint64_t high;
>>         void *param_blob, *param_ptr, *param_rng_seed;
>> @@ -735,6 +737,11 @@ static GlobalProperty hw_compat_q800[] = {
>> };
>> static const size_t hw_compat_q800_len = G_N_ELEMENTS(hw_compat_q800);
>>
>> +static const char *q800_machine_valid_cpu_types[] = {
>> +    M68K_CPU_TYPE_NAME("m68040"),
>> +    NULL
>> +};
>> +
>> static void q800_machine_class_init(ObjectClass *oc, void *data)
>> {
>>     MachineClass *mc = MACHINE_CLASS(oc);
>> @@ -742,6 +749,7 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
>>     mc->desc = "Macintosh Quadra 800";
>>     mc->init = q800_machine_init;
>>     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
>> +    mc->valid_cpu_types = q800_machine_valid_cpu_types;
>>     mc->max_cpus = 1;
>>     mc->block_default_type = IF_SCSI;
>>     mc->default_ram_id = "m68k_mac.ram";
>> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
>> index f3bc17aa1b..4cb1a51dfe 100644
>> --- a/include/hw/m68k/q800.h
>> +++ b/include/hw/m68k/q800.h
>> @@ -25,6 +25,7 @@
>>
>> #include "hw/boards.h"
>> #include "qom/object.h"
>> +#include "target/m68k/cpu-qom.h"
>>
>> /*
>>  * The main Q800 machine
>> @@ -32,6 +33,8 @@
>>
>> struct Q800MachineState {
>>     MachineState parent_obj;
>> +
>> +    M68kCPU cpu;
>> };
>>
>> #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")

ATB,

Mark.


