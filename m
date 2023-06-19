Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7A57356DF
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 14:29:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBE0K-00048R-2R; Mon, 19 Jun 2023 08:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBE0E-00045p-7D
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:29:02 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBE0C-0006HT-Il
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w+L3IV1gmYHf1Du/x0SZqikPU0CqAoYI4OlX1wlSl78=; b=Qda4oZia4lkDzLi8iEq27LIg8Z
 Cqp4NmqvsJCrkwYqbLlvFM9f2e5vuA4ZwX/XuU/7apOnCTppfZzcKqoM/Ysl9xfxxIoI5BBGYEyzS
 3Q9luNFqOapnju1N98N1PhMhk7T85OKQLA8AKIGKM4ZEpne2UFqzDS63QXZ/9kcBnPab02hqb62lQ
 wiRa5JVUjqfNoCUTEwU6ZQIM8mCyRPpAQEnfXzpimbVXa8npcvkCdRl7LHH1M5S6L/9ufMmj9K8da
 gwpeCsdcXH91OG/InSSjZKCfAzsn4yTNtOUg+zIuYYKoXsWIyE1V9YkGdJC+XF/hIaacKg5zT5NbM
 20N1Al4ZGvojEIBSvnh3XuS1gt+EwXk0D0r6Q29DjFPfs/TA7NYjrJk1ZTEO/ur7TCE6gW2WGnq2w
 6hvqyCKPj7ESTnDkADW+u293jVWRa9e0n9K9j3rzIiNE6HIXr10rM/VMqzf7dRzstbJUyl2ae6lxB
 RZr4tkaqVcfVsxiGBenHz+9CtzzzAN+hIdMoCDsUH5f2OIXpNMeSHV6OkH7TY4PWAdNQFCYoP8eWS
 0TpPdurqiTMCD3jL1smCUhidqkPsTcTl3Xa1MjOJrXyN/rq/HHMc3mYnFuvdIeYcXIkzRiCzzAHeV
 fBfn74IO6MI6VObuqkiLHxh6ggFn9UXb6jQiUxLyc=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBE00-0007hm-Cb; Mon, 19 Jun 2023 13:28:52 +0100
Message-ID: <1af5ad0a-f44a-de4e-18d2-9ce5b44f39cc@ilande.co.uk>
Date: Mon, 19 Jun 2023 13:28:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 laurent@vivier.eu, qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-6-mark.cave-ayland@ilande.co.uk>
 <92959cb6-5539-17ef-4fbf-f54cefe7d0cb@linaro.org>
 <87jzwoczq6.fsf@pond.sub.org>
 <d3e2d573-dc09-6c31-be8e-fab0e3fc9ce5@ilande.co.uk>
 <87y1l38sm0.fsf@pond.sub.org>
 <c5137e13-5055-15d8-2f05-c132232e415c@ilande.co.uk>
 <871qiffunb.fsf@pond.sub.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <871qiffunb.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 05/23] q800: move CPU object into Q800MachineState
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 13/06/2023 12:50, Markus Armbruster wrote:

> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
> 
>> On 01/06/2023 10:00, Markus Armbruster wrote:
>>
>>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
>>>
>>>> On 31/05/2023 16:00, Markus Armbruster wrote:
>>>>
>>>>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>>>>
>>>>>> On 31/5/23 14:53, Mark Cave-Ayland wrote:
>>>>>>> Also change the instantiation of the CPU to use object_initialize_child()
>>>>>>> followed by a separate realisation.
>>>>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>>>> ---
>>>>>>>      hw/m68k/q800.c         | 13 ++++++++-----
>>>>>>>      include/hw/m68k/q800.h |  2 ++
>>>>>>>      2 files changed, 10 insertions(+), 5 deletions(-)
>>>>>>> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
>>>>>>> index 3730b30dd1..c34b2548ca 100644
>>>>>>> --- a/hw/m68k/q800.c
>>>>>>> +++ b/hw/m68k/q800.c
>>>>>>> @@ -364,7 +364,7 @@ static uint8_t fake_mac_rom[] = {
>>>>>>>        static void q800_machine_init(MachineState *machine)
>>>>>>>      {
>>>>>>> -    M68kCPU *cpu = NULL;
>>>>>>> +    Q800MachineState *m = Q800_MACHINE(machine);
>>>>>>>          int linux_boot;
>>>>>>>          int32_t kernel_size;
>>>>>>>          uint64_t elf_entry;
>>>>>>> @@ -407,8 +407,10 @@ static void q800_machine_init(MachineState *machine)
>>>>>>>          }
>>>>>>>            /* init CPUs */
>>>>>>> -    cpu = M68K_CPU(cpu_create(machine->cpu_type));
>>>>>>> -    qemu_register_reset(main_cpu_reset, cpu);
>>>>>>> +    object_initialize_child(OBJECT(machine), "cpu", &m->cpu,
>>>>>>> +                            M68K_CPU_TYPE_NAME("m68040"));
>>>>>>> +    object_property_set_bool(OBJECT(&m->cpu), "realized", true, &error_fatal);
>>>>>>
>>>>>> CPUs are QDev-based, shouldn't we use qdev_realize()?
>>>>>
>>>>> Yes, we should.
>>>>> [...]
>>>>
>>>> Interesting. I remember thinking that CPUs were different, so I'm fairly sure I borrowed this from some similar code in hw/arm :)
>>>>
>>>> Shouldn't the above be directly equivalent to qdev_realize(dev, NULL, &error_fatal) given that the CPU doesn't connect to a bus?
>>>
>>> It's been a while since I worked on this...
>>>
>>> Commit ce189ab230b (qdev: Convert bus-less devices to qdev_realize()
>>> with Coccinelle) looks like you're right.
>>
>> Thanks for the confirmation! Given that this matches existing code that doesn't use cpu_create(), I'm inclined to keep this as-is to avoid creating another pattern for instantiating CPUs.
> 
> Wherever you *can* use qdev_realize(), you should.  The less we access
> property "realized" outside qdev core, the better.

No worries, in that case I will switch it to use qdev_realize() in v4.

> I few accesses have crept in since I converted the tree to
> qdev_realize() & friends.  Another conversion pass would be in order.


ATB,

Mark.


