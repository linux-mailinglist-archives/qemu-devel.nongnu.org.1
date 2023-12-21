Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9276F81B989
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 15:30:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGK3Z-0005ce-B1; Thu, 21 Dec 2023 09:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGK3X-0005cC-5S; Thu, 21 Dec 2023 09:29:47 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGK3V-0006e5-Ho; Thu, 21 Dec 2023 09:29:46 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a236456fee1so102918066b.1; 
 Thu, 21 Dec 2023 06:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703168982; x=1703773782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pdSaC/fndvMGKUjEzphpaCYLwkDVUXBTTEuv6Vyh+pc=;
 b=Nyy7tm1jwX8MLei27+4lN6cXw5RE7dxr+oxIh1kAw3nqKMnPb2Vp55Yw+G32V84pmE
 aaP2HftI+IXjCtcNXw/BYbwCeFoVa55PIESdmqRHu9lVVJl5NlbUMHktoyRg1wjgu0Wn
 S3S2IlYAMMQ4wD+2JV7KA5ib7B81FZR1D1f/Xotub0DujkE2fJeGA+7sst7dDirnUF4Q
 CF5kX1Pu2rhTf2E7A2aouNriFsECsCG8uefRW5lYtDgXHhwJTg+VTXURZovwbjehmmW0
 MnGIZNVkDaMJsqlRDYwpn4WV0aci42vQ98AiLxWSo+GF7873rNBbi+GVoMp7FYuqxGnc
 m9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703168982; x=1703773782;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pdSaC/fndvMGKUjEzphpaCYLwkDVUXBTTEuv6Vyh+pc=;
 b=l+nwJww3pTBQhXN58LVgBeCpFk0tgLwJJUopkBN5cBZFQjduEbs9EOBS3/uLgREvHk
 yHVIQ+QCzv/7RyIUx7zo6XHqywJrehH9O27eoWSZojgchHxRZzSHy8zSfCLo4SG3X488
 cQJbF3nXiKMEssdks/twKJT6+MW14JQ1b7XBsXk3X99bCv3kOSSALd4nRrED+EfYlR8S
 +GfRJbvCxh4w4abJzMwWK6zib13yRlgi9eU2YAy1Pjbnn67of9cJ77NAEkEQ8YHXBUYf
 6PoVf2chJDatPBYod3JdP43pm5JAxe5p6a1LChJVkF33Rurt9zvZ3vFXO712KZnuFxmG
 2EtA==
X-Gm-Message-State: AOJu0YxwNgvTtGhbBmuhXkTjZnxgZ9FJIrsIPKwOWYdbtwjpmOmu9p1w
 XoA94LVLD33SVW9aXxmXYXE=
X-Google-Smtp-Source: AGHT+IGQdnxxGqxZ33HYGKZhcaTKqmko1lz4deeL7vz3CejJWKFkzWxQmqjuNq3iPyAmv+JWhV5dig==
X-Received: by 2002:a17:906:44c:b0:a23:671c:228a with SMTP id
 e12-20020a170906044c00b00a23671c228amr3230833eja.55.1703168982159; 
 Thu, 21 Dec 2023 06:29:42 -0800 (PST)
Received: from ?IPv6:::1?
 (p200300faaf1724005cbed9e46dc30ccf.dip0.t-ipconnect.de.
 [2003:fa:af17:2400:5cbe:d9e4:6dc3:ccf])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a170906715100b00a26966683e3sm1026275ejj.144.2023.12.21.06.29.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 06:29:41 -0800 (PST)
Date: Thu, 21 Dec 2023 14:29:35 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_11/12=5D_hw/ppc/pegasos2=3A_Let_p?=
 =?US-ASCII?Q?egasos2_machine_configure_SuperI/O_functions?=
In-Reply-To: <9ccd94d1-130f-b009-cd25-f32122c78908@eik.bme.hu>
References: <20231218185114.119736-1-shentey@gmail.com>
 <20231218185114.119736-12-shentey@gmail.com>
 <9ccd94d1-130f-b009-cd25-f32122c78908@eik.bme.hu>
Message-ID: <30F2BEE1-8EBB-4C24-9C6F-BBE5938AAAE5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
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



Am 19=2E Dezember 2023 00:11:37 UTC schrieb BALATON Zoltan <balaton@eik=2E=
bme=2Ehu>:
>On Mon, 18 Dec 2023, Bernhard Beschow wrote:
>> This is a preparation for implementing relocation and toggling of Super=
I/O
>> functions in the VT8231 device model=2E Upon reset, all SuperI/O functi=
ons will be
>> deactivated, so in case if no -bios is given, let the machine configure=
 those
>> functions the same way pegasos2=2Erom would do=2E For now the meantime =
this will be
>
>"same way pegasos2 firmware would do"=2E

Good idea=2E Will change=2E

> You can drop the last sentence about no-op as it does not make much sens=
e as it is or reword it if you want to keep it=2E

Yeah, I messed up the last sentence somehow=2E I'll drop it then=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>> a no-op=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> hw/ppc/pegasos2=2Ec | 15 +++++++++++++++
>> 1 file changed, 15 insertions(+)
>>=20
>> diff --git a/hw/ppc/pegasos2=2Ec b/hw/ppc/pegasos2=2Ec
>> index 3203a4a728=2E=2E0a40ebd542 100644
>> --- a/hw/ppc/pegasos2=2Ec
>> +++ b/hw/ppc/pegasos2=2Ec
>> @@ -285,6 +285,15 @@ static void pegasos2_pci_config_write(Pegasos2Mach=
ineState *pm, int bus,
>>     pegasos2_mv_reg_write(pm, pcicfg + 4, len, val);
>> }
>>=20
>> +static void pegasos2_superio_write(Pegasos2MachineState *pm, uint32_t =
addr,
>> +                                   uint32_t val)
>> +{
>> +    AddressSpace *as =3D CPU(pm->cpu)->as;
>> +
>> +    stb_phys(as, PCI1_IO_BASE + 0x3f0, addr);
>> +    stb_phys(as, PCI1_IO_BASE + 0x3f1, val);
>> +}
>> +
>> static void pegasos2_machine_reset(MachineState *machine, ShutdownCause=
 reason)
>> {
>>     Pegasos2MachineState *pm =3D PEGASOS2_MACHINE(machine);
>> @@ -310,6 +319,12 @@ static void pegasos2_machine_reset(MachineState *m=
achine, ShutdownCause reason)
>>=20
>>     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
>>                               PCI_INTERRUPT_LINE, 2, 0x9);
>> +    pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
>> +                              0x50, 1, 0x6);
>> +    pegasos2_superio_write(pm, 0xf4, 0xbe);
>> +    pegasos2_superio_write(pm, 0xf6, 0xef);
>> +    pegasos2_superio_write(pm, 0xf7, 0xfc);
>> +    pegasos2_superio_write(pm, 0xf2, 0x14);
>>     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
>>                               0x50, 1, 0x2);
>>     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
>>=20

