Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A0F7212B3
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 22:37:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5XzL-0005jM-RH; Sat, 03 Jun 2023 16:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5XzJ-0005hb-IV
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 16:36:37 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5XzH-0004KG-WE
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 16:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AEEbOEfADNuoS1Q6hyLijkaDojbDhD91aigWucF/lkE=; b=G83F3zhg1Ot3CzwtxCVciwsXkq
 ftVY4zCoe4v40f+P9dXVdnW26jLAopTIdbvFF7k66Eqzh7AWyEpd+UjOvSDOYE0ZX8vShlHeDzVsZ
 kWIYRsTjtt5AKagrMlabemRlxom24RpqQ5512RwZGrsIR1usUw08JMhct+gpH4rBrFhmOZnQXpl7G
 Kk30BGMEkFXQALYdhFIqGITbXERmQaAufhgkKLhYfordJsj8fa1/hb3Ez97jKHcqyM1zf3swrmKpw
 qhwWeQ2mtWXTsk58+X5DUAXtx1T7TAoLchv3exv60lspenaagIWHMCXGi38IzMIfALL6mQ0H6455O
 +E+jwxF8XKycXh74HKfr9a291pK0I7+C5tb6nWZBkR8gmZwrDtRmfAKwLsRNG33LJD5199h7PykP8
 E0DY2fKbPLg/gQ6srxZQHG4QOp73ZZULYZLY+NC5J9XVoIcGLwzaIbWD1NyXHiy05OvMplWN1xUzS
 FnuEsKA/0keHjxANTMPlbptHyvEYqTnlQ6ZtIh7bu1zjwZmRa10C2CLYbULDmvTxU91/U3h/wvhJb
 Dz7wT/Q92BfLQaJ7Vz/L3xwvrbUXZmPoullXUtAzZLpOhibuLzL8Dz76WAjtRBzKh7HoYFfdamQBi
 ik1YYwpMG7B4Fmj7Xd9YmpGnAj18HbsWOxLMNvync=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5Xz6-000137-01; Sat, 03 Jun 2023 21:36:28 +0100
Message-ID: <96a6e0f0-b493-86c2-9b34-0e96dc423c56@ilande.co.uk>
Date: Sat, 3 Jun 2023 21:36:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 laurent@vivier.eu, qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-6-mark.cave-ayland@ilande.co.uk>
 <edd9f126-526e-ee57-767b-a1d307008a4d@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <edd9f126-526e-ee57-767b-a1d307008a4d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 31/05/2023 18:43, Philippe Mathieu-Daudé wrote:

> On 31/5/23 14:53, Mark Cave-Ayland wrote:
>> Also change the instantiation of the CPU to use object_initialize_child()
>> followed by a separate realisation.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/m68k/q800.c         | 13 ++++++++-----
>>   include/hw/m68k/q800.h |  2 ++
>>   2 files changed, 10 insertions(+), 5 deletions(-)
> 
> 
>> @@ -407,8 +407,10 @@ static void q800_machine_init(MachineState *machine)
>>       }
>>       /* init CPUs */
>> -    cpu = M68K_CPU(cpu_create(machine->cpu_type));
>> -    qemu_register_reset(main_cpu_reset, cpu);
>> +    object_initialize_child(OBJECT(machine), "cpu", &m->cpu,
>> +                            M68K_CPU_TYPE_NAME("m68040"));
> 
> Shouldn't we keep using machine->cpu_type?
> 
> If the m68040 is the single CPU usable, we should set
> MachineClass::valid_cpu_types[] in q800_machine_class_init().
> 
>> +    object_property_set_bool(OBJECT(&m->cpu), "realized", true, &error_fatal);
>> +    qemu_register_reset(main_cpu_reset, &m->cpu);

Yes I can do that: I don't think it makes any difference to the q800 machine here 
because the MacOS toolbox ROM doesn't appear to boot with anything other than a 68040 
CPU, but it could be useful to make this explicit.


ATB,

Mark.


