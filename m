Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5910E72E240
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:51:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q92YD-0002zb-Kd; Tue, 13 Jun 2023 07:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q92YA-0002yq-OS
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 07:51:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q92Y7-0005s5-6C
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 07:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686657057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fTUyuDhwz4DsPkWiR2OeeNHh5sOowwwQJuQnfMt8Fak=;
 b=X1PqCPjzS6582+T39GIf3ARxMZdO17v1ga9qVdp0kcjL9MjK0YtXyREuaenUyg0QokXSHM
 hAn12aDRk3ZOW0FA2C88ULP58c/cmMuMlB1p0w3tdT3rVxI6sXhzs9+O8YB80NSyoKzGet
 zGt0Ufw1+Q547rGYcfoxzOCo+xT7Y8A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-kY6qkLBPOEq2JsxDz4W-GA-1; Tue, 13 Jun 2023 07:50:51 -0400
X-MC-Unique: kY6qkLBPOEq2JsxDz4W-GA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB4FC85A5AA;
 Tue, 13 Jun 2023 11:50:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 190FC2907;
 Tue, 13 Jun 2023 11:50:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DB08C21E675B; Tue, 13 Jun 2023 13:50:48 +0200 (CEST)
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
 <87y1l38sm0.fsf@pond.sub.org>
 <c5137e13-5055-15d8-2f05-c132232e415c@ilande.co.uk>
Date: Tue, 13 Jun 2023 13:50:48 +0200
In-Reply-To: <c5137e13-5055-15d8-2f05-c132232e415c@ilande.co.uk> (Mark
 Cave-Ayland's message of "Sat, 3 Jun 2023 21:42:14 +0100")
Message-ID: <871qiffunb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> On 01/06/2023 10:00, Markus Armbruster wrote:
>
>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
>>=20
>>> On 31/05/2023 16:00, Markus Armbruster wrote:
>>>
>>>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>>>
>>>>> On 31/5/23 14:53, Mark Cave-Ayland wrote:
>>>>>> Also change the instantiation of the CPU to use object_initialize_ch=
ild()
>>>>>> followed by a separate realisation.
>>>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>>> ---
>>>>>>     hw/m68k/q800.c         | 13 ++++++++-----
>>>>>>     include/hw/m68k/q800.h |  2 ++
>>>>>>     2 files changed, 10 insertions(+), 5 deletions(-)
>>>>>> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
>>>>>> index 3730b30dd1..c34b2548ca 100644
>>>>>> --- a/hw/m68k/q800.c
>>>>>> +++ b/hw/m68k/q800.c
>>>>>> @@ -364,7 +364,7 @@ static uint8_t fake_mac_rom[] =3D {
>>>>>>       static void q800_machine_init(MachineState *machine)
>>>>>>     {
>>>>>> -    M68kCPU *cpu =3D NULL;
>>>>>> +    Q800MachineState *m =3D Q800_MACHINE(machine);
>>>>>>         int linux_boot;
>>>>>>         int32_t kernel_size;
>>>>>>         uint64_t elf_entry;
>>>>>> @@ -407,8 +407,10 @@ static void q800_machine_init(MachineState *mac=
hine)
>>>>>>         }
>>>>>>           /* init CPUs */
>>>>>> -    cpu =3D M68K_CPU(cpu_create(machine->cpu_type));
>>>>>> -    qemu_register_reset(main_cpu_reset, cpu);
>>>>>> +    object_initialize_child(OBJECT(machine), "cpu", &m->cpu,
>>>>>> +                            M68K_CPU_TYPE_NAME("m68040"));
>>>>>> +    object_property_set_bool(OBJECT(&m->cpu), "realized", true, &er=
ror_fatal);
>>>>>
>>>>> CPUs are QDev-based, shouldn't we use qdev_realize()?
>>>>
>>>> Yes, we should.
>>>> [...]
>>>
>>> Interesting. I remember thinking that CPUs were different, so I'm fairl=
y sure I borrowed this from some similar code in hw/arm :)
>>>
>>> Shouldn't the above be directly equivalent to qdev_realize(dev, NULL, &=
error_fatal) given that the CPU doesn't connect to a bus?
>>
>> It's been a while since I worked on this...
>>
>> Commit ce189ab230b (qdev: Convert bus-less devices to qdev_realize()
>> with Coccinelle) looks like you're right.
>
> Thanks for the confirmation! Given that this matches existing code that d=
oesn't use cpu_create(), I'm inclined to keep this as-is to avoid creating =
another pattern for instantiating CPUs.

Wherever you *can* use qdev_realize(), you should.  The less we access
property "realized" outside qdev core, the better.

I few accesses have crept in since I converted the tree to
qdev_realize() & friends.  Another conversion pass would be in order.


