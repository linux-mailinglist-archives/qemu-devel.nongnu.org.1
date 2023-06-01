Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE94719652
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:04:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4eBG-0001Uv-O4; Thu, 01 Jun 2023 05:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q4eAg-0001F7-No
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:00:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q4eAf-0000tF-59
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685610036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uYzJKyMm8JKwbDit39SmDgZQgUaYcq9OcZP871om2qs=;
 b=HksgD9cNecR9PMs3xfbvLyMi/KIV7zXWSaW1Teye2jjhLWu0+zCyX+yPtyjY+O9SLH35RJ
 +KWKR6BVRsTko5c1DJezs227+RlzoDs2hLih5mvuqoajOo36dLG8L/lpIZg1avu/TBYdwD
 SjWFkMHEReHe/g1ymGi+oGKeOgkWjEU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-uC3R8f4kPZO1QMmeTZ3cog-1; Thu, 01 Jun 2023 05:00:25 -0400
X-MC-Unique: uC3R8f4kPZO1QMmeTZ3cog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27740185A78F;
 Thu,  1 Jun 2023 09:00:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1A03140E963;
 Thu,  1 Jun 2023 09:00:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E990D21E692E; Thu,  1 Jun 2023 11:00:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 05/23] q800: move CPU object into Q800MachineState
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-6-mark.cave-ayland@ilande.co.uk>
 <92959cb6-5539-17ef-4fbf-f54cefe7d0cb@linaro.org>
 <87jzwoczq6.fsf@pond.sub.org>
 <d3e2d573-dc09-6c31-be8e-fab0e3fc9ce5@ilande.co.uk>
Date: Thu, 01 Jun 2023 11:00:23 +0200
In-Reply-To: <d3e2d573-dc09-6c31-be8e-fab0e3fc9ce5@ilande.co.uk> (Mark
 Cave-Ayland's message of "Thu, 1 Jun 2023 09:00:42 +0100")
Message-ID: <87y1l38sm0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> On 31/05/2023 16:00, Markus Armbruster wrote:
>
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>>> On 31/5/23 14:53, Mark Cave-Ayland wrote:
>>>> Also change the instantiation of the CPU to use object_initialize_chil=
d()
>>>> followed by a separate realisation.
>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> ---
>>>>    hw/m68k/q800.c         | 13 ++++++++-----
>>>>    include/hw/m68k/q800.h |  2 ++
>>>>    2 files changed, 10 insertions(+), 5 deletions(-)
>>>> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
>>>> index 3730b30dd1..c34b2548ca 100644
>>>> --- a/hw/m68k/q800.c
>>>> +++ b/hw/m68k/q800.c
>>>> @@ -364,7 +364,7 @@ static uint8_t fake_mac_rom[] =3D {
>>>>      static void q800_machine_init(MachineState *machine)
>>>>    {
>>>> -    M68kCPU *cpu =3D NULL;
>>>> +    Q800MachineState *m =3D Q800_MACHINE(machine);
>>>>        int linux_boot;
>>>>        int32_t kernel_size;
>>>>        uint64_t elf_entry;
>>>> @@ -407,8 +407,10 @@ static void q800_machine_init(MachineState *machi=
ne)
>>>>        }
>>>>          /* init CPUs */
>>>> -    cpu =3D M68K_CPU(cpu_create(machine->cpu_type));
>>>> -    qemu_register_reset(main_cpu_reset, cpu);
>>>> +    object_initialize_child(OBJECT(machine), "cpu", &m->cpu,
>>>> +                            M68K_CPU_TYPE_NAME("m68040"));
>>>> +    object_property_set_bool(OBJECT(&m->cpu), "realized", true, &erro=
r_fatal);
>>>
>>> CPUs are QDev-based, shouldn't we use qdev_realize()?
>>
>> Yes, we should.
>> [...]
>
> Interesting. I remember thinking that CPUs were different, so I'm fairly =
sure I borrowed this from some similar code in hw/arm :)
>
> Shouldn't the above be directly equivalent to qdev_realize(dev, NULL, &er=
ror_fatal) given that the CPU doesn't connect to a bus?

It's been a while since I worked on this...

Commit ce189ab230b (qdev: Convert bus-less devices to qdev_realize()
with Coccinelle) looks like you're right.


