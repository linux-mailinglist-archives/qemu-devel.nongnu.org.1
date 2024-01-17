Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3145183042B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 12:06:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ3jr-0003uV-CJ; Wed, 17 Jan 2024 06:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rQ3ji-0003u6-By; Wed, 17 Jan 2024 06:05:34 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rQ3jg-0000aC-6j; Wed, 17 Jan 2024 06:05:34 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5534dcfdd61so19228975a12.0; 
 Wed, 17 Jan 2024 03:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705489529; x=1706094329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aTMbsHsrO4MrYT6vSy6ZhZxs09701ZYspzOhmvylig0=;
 b=ZjiRG/Ah53Q1q7UrPwgDojfmyI7RSZk32x1uLKjARNBORdhCI/H5GVVjwN6YhEZ1LN
 /WiCY99+gqxs5OMF+DaIvat9a7jgQb0iltbWXPhvv9ShKObfjV+uob9K/xwwNYX4pS83
 Iiu2abqiUzVYayiIpJECgFGg99mimUQJYdeKaIqNX6BflwHuxBS8N2dSfbUy8K/+4oWg
 taE+6egB7xHCdtTDEWxraH2oX72uQo7aVG4Jg3trF8LTsk8vj3vb+VZ1UlIzjfL4LcJ1
 toqLdLq7nFpaznSN7iseAS3tueyPy+6lPpVCFrDEM41/4fFZwf2kSEeaspX3j019AnG+
 qw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705489529; x=1706094329;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aTMbsHsrO4MrYT6vSy6ZhZxs09701ZYspzOhmvylig0=;
 b=w1eSaYZMWj9QuAyJaIqBiTpFiMDgGFnoTQwYKSxxJfCKbevKgMAG03iL8cGbfSYpjS
 ILPKvDThidmhmmFwi0vYoIP9Neo1KDmYPE5dB3vO6KnhmRRwnGirFYfl9lr3ve4aDgDo
 SfDP+sx64rXlZmnfDkcgQiqgb5hbNikaLEQAnQjBTm+DCENThFSv2iHZYVRCAAhyZ/I7
 yE3E6BB7jI+lh4hncrvp7sQiMrrJX+rCImW8bbcirZVLE1jUtmhwSkH7uaZjCZxq7QlR
 lfei46HVTiOhLZJLCDBy4/g5MXkbpATQuRIFoJ+lKJknc7i6BGPQGrclncpDAKd97uRF
 JFHQ==
X-Gm-Message-State: AOJu0YzXi3iIzJUpikKTgaHlijatUCOnq3+XfldCpOdqx26xKP0K9y+J
 CAAaPJSxRFK4/XivhxzWkn0DduW1Fk8=
X-Google-Smtp-Source: AGHT+IEHrRia/UkLpmAPBMrhUYru/zQGXDVqbNUklo1gn0/+IewEJZv+RVs7CLT6DxNrY9RJk/jYvQ==
X-Received: by 2002:a05:6402:2052:b0:558:b89d:8e39 with SMTP id
 bc18-20020a056402205200b00558b89d8e39mr720307edb.37.1705489528778; 
 Wed, 17 Jan 2024 03:05:28 -0800 (PST)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 v21-20020a50a455000000b005527c02c1d6sm8254309edb.50.2024.01.17.03.05.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 03:05:27 -0800 (PST)
Date: Wed, 17 Jan 2024 11:05:20 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
CC: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: =?US-ASCII?Q?Re=3A_Re=3A_=5BPATCH_1/3=5D_hw/arm=3A_Add_EHCI/OHCI_co?=
 =?US-ASCII?Q?ntrollers_to_Allwinner_R40_and_Bananapi_board?=
In-Reply-To: <ccs4nfcdm7e5iek2enycw4echbyny2okstx4pg2es7pggjlgld@5vftyjpgfot2>
References: <20240113191651.1313226-1-linux@roeck-us.net>
 <20240113191651.1313226-2-linux@roeck-us.net>
 <56f692d8-41b1-4126-96b9-80d274624984@linaro.org>
 <56fde49f-7dc6-4f8e-9bbf-0336a20a9ebf@roeck-us.net>
 <ccs4nfcdm7e5iek2enycw4echbyny2okstx4pg2es7pggjlgld@5vftyjpgfot2>
Message-ID: <51F3A473-7A20-4C0C-BDF1-98D839E56A0F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x531.google.com
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



Am 16=2E Januar 2024 10:13:37 UTC schrieb Gerd Hoffmann <kraxel@redhat=2Ec=
om>:
>On Mon, Jan 15, 2024 at 08:12:29AM -0800, Guenter Roeck wrote:
>> On 1/15/24 03:02, Philippe Mathieu-Daud=C3=A9 wrote:
>> > On 13/1/24 20:16, Guenter Roeck wrote:
>> > > If machine USB support is not enabled, create unimplemented devices
>> > > for the USB memory ranges to avoid crashes when booting Linux=2E
>> >=20
>> > I never really understood the reason for machine_usb() and had on my
>> > TODO to do some archeology research to figure it out since quite some
>> > time=2E Having to map an UnimpDevice due to CLI options seems like an
>> > anti-pattern when the device is indeed implemented in the repository=
=2E
>>=20
>> Me not either=2E I copied the code from aw_a10_init(), trying to use th=
e
>> same pattern=2E I am perfectly fine with making it unconditional, but t=
hen
>> I would argue that it should be unconditional for Allwinner A10 as well
>> (not that I really care much, just for consistency)=2E
>>=20
>> The "-usb" option says "enable on-board USB host controller (if not
>> enabled by default)"=2E Unfortunately, that doesn't tell me much,
>> and most specifically it doesn't tell me how to enable it by default=2E
>> One option I can think of would be to enable it on the machine level,
>> i=2Ee=2E, from bananapi_m2u=2Ec, but then, again, I don't see if/how
>> that is done for other boards=2E Any suggestions ?
>
>The -usb switch is there as long as I remember (which goes back to qemu
>0=2E1x days)=2E  I suspect it was introduced in the early usb emulation
>days, where usb emulation was more fragile and turning it on by default
>didn't look like a good plan=2E
>
>usb emulation in modern qemu should be stable enough that enabling it by
>default should not be much of a problem=2E  ohci/uhci/ehci emulation is
>somewhat expensive due to polling being wired into the hardware design,
>but as long as there are no usb devices connected this should not be
>much of a concern either as the guest drivers usually put the usb host
>adapter to sleep in that case (which saves power on physical hardware
>and stops the polling timer in qemu)=2E
>
>So, turning on usb support by default makes sense to me when emulating
>boards, where guests expect the usb controllers being present at
>specific MMIO addresses, so mapping UnimpDevice is not needed=2E

Good idea, this might make upstreaming my VIA-south-bridges-in-the-pc-mach=
ine work simpler=2E

>
>In case guests detect hardware via generated device tree / generated
>ACPI tables / pci bus scan (i=2Ee=2E arm virt + microvm + pc + q35) it IM=
HO
>makes sense to keep current behavior=2E

I remember similar discussions with Phil during PIIX consolidation where t=
he motivation was to make the code simpler by removing options=2E That is, =
if a piece of silicon contains multiple functions, the QEMU model should al=
ways instantiate all (available) functions rather than providing options fo=
r cherry-picking=2E

Especially in highly integrated devices (such as south bridges) there migh=
t be interconnections between functions that are hard to handle when some a=
re optional=2E For example, the ACPI function in the VIA south bridges dete=
ct activity from all other functions=2E In both PIIX and VIA, the USB funct=
ion can be (de)activated by software from the ISA function (not implemented=
 yet)=2E

The latter would allow the current behavior of the pc machine(s) to be imp=
lemented while avoiding the cherry picking problem: The BIOS could switch t=
he USB function on or off depending on fw_cfg (please correct me if I'm wro=
ng)=2E I think this would't even need compat machinery=2E Of course, suppor=
t would need to be added in SeaBIOS and -- I guess -- Tianocore=2E I'd like=
 to look into that but, as usual, no guarantees when this will arrive=2E

Best regards,
Bernhard

>
>take care,
>  Gerd
>
>

