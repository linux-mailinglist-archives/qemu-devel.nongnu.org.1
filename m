Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 488198236A8
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 21:36:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL7x3-00047w-Cg; Wed, 03 Jan 2024 15:34:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rL7wq-000433-8v
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:34:48 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rL7wm-0005gm-T5
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:34:42 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55539cac143so7696853a12.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 12:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704314078; x=1704918878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ht6u/DLoPPwz+Xjg/p0fVVia9I1Nof/IrzBPqFMEIg0=;
 b=YeJHuP8S//RomTq2P/HzPkrZQKvSaP9vekWSRLBOZmXfVPEYP+gbHX3KOfiEnmJbIg
 rxIckGZfx9fZlZQMkZynFxHcsrwjfAGlI15AGVbABp4kcwb13tnRzS5KiwHkN0FGothv
 YdAuEeUAfCX47N1RtqtNWrroctuSweB+vcz94rDaKhVK5LZXdZzWNFWaPf2dRG+80chn
 Rbnt6TQ85OaM/1WqYPJFdEaCbYbkzQ+qNOot2twOHqmc+OenRXaFOzw0/r5swV1lAnE1
 O/IS1dadvjZSVa8b57Cb/koAO8Oquo28wakhckUc484i64RHl4+Snjdssh+W/Zo1PmsL
 IPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704314078; x=1704918878;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ht6u/DLoPPwz+Xjg/p0fVVia9I1Nof/IrzBPqFMEIg0=;
 b=Ve+n1KUgtoiVSw6hquy18z82Z+Dna2NF+uxtZMbU6pZhrhIxndp4QHzegiEIGAwOUD
 AkmfPKRKCWC0rZaHpaSmCKvzrQ3tcv7jtWbErJ2GJIOMNa+1mhIf1UldoPo7Cewrt6uY
 qCQ2tJ6QCivhdSnWZGgNo30n7oX6+dBsXE2o3zuvWgYcfx7+EUfwjO5ycmTFfiJLR2fx
 vpW/elhSe14FmFjycid7Ejbb8Oa6J71kbjkbcqu8KojIAU/C0RyVEYlDg0lO7RWBiaDl
 RYnWJBua6qfpoNONiAwMoBwg6Xg7sG095Yc4lAmqH7/hfWc97/8p7ij15XBX2sCxC+Qs
 Zxaw==
X-Gm-Message-State: AOJu0YwlRrtxGowcA53/SEiAFgLDIheQ+yx2+cMLYRnZ8O3UJAK8CjZZ
 xy8zcgjvJpXWhcFDbHMJCLDis4kvGaA=
X-Google-Smtp-Source: AGHT+IEcFm7oHJeO/gMtEPST4r0y54dC5CeWJNQyfimmCmbC1w0MHKOU5pgvIB65G6vs5/16rWtvNA==
X-Received: by 2002:a17:907:789:b0:a27:4f33:96ef with SMTP id
 xd9-20020a170907078900b00a274f3396efmr6268329ejb.7.1704314078339; 
 Wed, 03 Jan 2024 12:34:38 -0800 (PST)
Received: from [127.0.0.1] ([185.109.152.64]) by smtp.gmail.com with ESMTPSA id
 dt6-20020a170906b78600b00a2699f9d5b1sm13267410ejb.177.2024.01.03.12.34.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 12:34:37 -0800 (PST)
Date: Wed, 03 Jan 2024 17:36:37 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
CC: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_hw/i386/x86=3A_Fix_PIC_int?=
 =?US-ASCII?Q?errupt_handling_if_APIC_globally_disabled?=
In-Reply-To: <8734veixvr.fsf@draig.linaro.org>
References: <20240103084900.22856-1-shentey@gmail.com>
 <20240103084900.22856-2-shentey@gmail.com> <8734veixvr.fsf@draig.linaro.org>
Message-ID: <EDAA2D17-4284-4DA4-B6E0-FC531E26852E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 3=2E Januar 2024 09:12:24 UTC schrieb "Alex Benn=C3=A9e" <alex=2Ebennee=
@linaro=2Eorg>:
>Bernhard Beschow <shentey@gmail=2Ecom> writes:
>
>> QEMU populates the apic_state attribute of x86 CPUs if supported by rea=
l
>> hardware=2E Even when the APIC is globally disabled by a guest, this at=
tribute
>> stays populated=2E This means that the APIC code paths are still used i=
n this
>> case=2E However, chapter 10=2E4=2E3 of [1] requires that:
>>
>>   When IA32_APIC_BASE[11] is 0, the processor is functionally equivalen=
t to an
>>   IA-32 processor without an on-chip APIC=2E The CPUID feature flag for=
 the APIC
>>   [=2E=2E=2E] is also set to 0=2E
>>
>> Fix this by checking the APIC feature flag rather than apic_state when =
deciding
>> whether PIC or APIC behavior is required=2E This fixes some real-world =
BIOSes=2E
>>
>> Notice that presence of the CPUID_APIC flag implies that apic_state is =
non-NULL=2E
>>
>> [1] Intel 64 and IA-32 Architectures Software Developer's Manual, Vol=
=2E 3A:
>>     System Programming Guide, Part 1
>>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>  hw/i386/x86=2Ec | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/i386/x86=2Ec b/hw/i386/x86=2Ec
>> index 2b6291ad8d=2E=2Ea753d1aeca 100644
>> --- a/hw/i386/x86=2Ec
>> +++ b/hw/i386/x86=2Ec
>> @@ -516,10 +516,10 @@ static void x86_nmi(NMIState *n, int cpu_index, E=
rror **errp)
>>      CPU_FOREACH(cs) {
>>          X86CPU *cpu =3D X86_CPU(cs);
>> =20
>> -        if (!cpu->apic_state) {
>> -            cpu_interrupt(cs, CPU_INTERRUPT_NMI);
>> -        } else {
>> +        if (cpu->env=2Efeatures[FEAT_1_EDX] & CPUID_APIC) {
>
>You could assert the relationship between the feature and ->apic_state wi=
th:
>
>  g_assert(cpu->apic_state)
>
>But probably unnecessary in the grand scheme of things=2E

I like the idea so I'll respin=2E

Thanks,
Bernhard=20

> Anyway:
>
>Reviewed-by: Alex Benn=C3=A9e <alex=2Ebennee@linaro=2Eorg>
>

