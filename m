Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EED7DB7CD
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 11:19:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxPMV-00080R-4l; Mon, 30 Oct 2023 06:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qxPMT-000803-BR
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:19:09 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qxPMR-0005A9-Qy
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:19:09 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9cf83c044b7so575027866b.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 03:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698661146; x=1699265946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JHU+5fB02MW8VKD71h+NE+LetAbRaq8q48PvAOu1CKU=;
 b=Cp3dzeQ/ES7eFRx9Fs+jZhS7sWmxwgC+I78Q1kuD9YU+czljIq/b5gRMObOoeiHGJ6
 PAaNgYz6kNAx6qbHWmjeUTzp4Q326PNrdnaxFtrIsCKBcgUMfj//waN8foxy8oMPADKA
 PRzu59tyeFbm+tSSlmXBOufAkg1IXdRk/GUqI0nHWTunsklPjn0keN+S+VcUrUPFtuEG
 8U4vmQHNDdrbv3NZFbefQqBQyKA7wlPQw25YcoOvhqSckysWt5jEHW8u6phThfIZOG28
 yGoQ62mCPyjbUsWldPmQEe6S4XlEqXzsJkJ9IVjRYzO9ajr86VDiRF/fYHvXGrB8YjnK
 EFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698661146; x=1699265946;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JHU+5fB02MW8VKD71h+NE+LetAbRaq8q48PvAOu1CKU=;
 b=nBVSkdR77lJPQStiU/BQM4dcoEk0dGambQQC3kheKoqVSqc8KsjxUcDRoQhG49sB3u
 EWnfVIjWPoCzbeEO4z1/EoN3WK46c8rHlpVJ52EjACptkkRrjsPmZLQoJ3GApbb3m4YG
 wXZ/Z3qM5ecvJgJvOJX8ZTvw1FFuQd5fhPArsgtAsfahFB4lz9hXBpuQRMx4fq2xhrEd
 YGhkFIkI7nxXwwlfk+mVMex177cr3cP13yw18+lWINkGBsZkJvVWBQgbZEvKfSXi0CFe
 XwvPWlGH6TjweXLom/YlS0fhHC70rSJYzUA8eL8oIU6oJG1De6UAFFPo/U/mRVix4Gy/
 zU6A==
X-Gm-Message-State: AOJu0Yw/87+cMW6MUP2P9YWFm76Ab2So/zGe2ZrPpD0GHjIiO2Z/GJMa
 LZyKEyCaN1g96ROUhxWLqAE=
X-Google-Smtp-Source: AGHT+IFyf93MOwGLYDKYNXZhajCiQqDLbqt4lVTaD6ZZ849bBXFrugvdkQKWiKASrf/Ejjs4/rOvtQ==
X-Received: by 2002:a17:907:72c3:b0:9c7:fd91:4309 with SMTP id
 du3-20020a17090772c300b009c7fd914309mr6953365ejc.0.1698661145922; 
 Mon, 30 Oct 2023 03:19:05 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 eu6-20020a170907298600b009d2eb40ff9dsm2517240ejc.33.2023.10.30.03.19.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 03:19:05 -0700 (PDT)
Date: Mon, 30 Oct 2023 09:45:49 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 3/5] hw/isa/vt82c686: Reuse acpi_update_sci()
In-Reply-To: <4d959097-0c53-c0fd-b1a0-3d8250e1a314@eik.bme.hu>
References: <20231028091606.23700-1-shentey@gmail.com>
 <20231028091606.23700-4-shentey@gmail.com>
 <4d959097-0c53-c0fd-b1a0-3d8250e1a314@eik.bme.hu>
Message-ID: <8F8EE81A-9153-4DB9-ADE3-C24B64CD4D1E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 29=2E Oktober 2023 00:07:00 UTC schrieb BALATON Zoltan <balaton@eik=2Eb=
me=2Ehu>:
>On Sat, 28 Oct 2023, Bernhard Beschow wrote:
>> acpi_update_sci() covers everything pm_update_sci() does=2E It implemen=
ts common
>> ACPI funtionality in a generic fashion=2E Note that it agnostic to any
>> Frankenstein usage of the general purpose event registers in other devi=
ce
>> models=2E It just implements a generic mechanism which can be wired to =
arbitrary
>> functionality=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> hw/isa/vt82c686=2Ec | 20 ++------------------
>> 1 file changed, 2 insertions(+), 18 deletions(-)
>>=20
>> diff --git a/hw/isa/vt82c686=2Ec b/hw/isa/vt82c686=2Ec
>> index 60ca781e03=2E=2E7b44ad9485 100644
>> --- a/hw/isa/vt82c686=2Ec
>> +++ b/hw/isa/vt82c686=2Ec
>> @@ -145,26 +145,10 @@ static const MemoryRegionOps pm_io_ops =3D {
>>     },
>> };
>>=20
>> -static void pm_update_sci(ViaPMState *s)
>> -{
>> -    int sci_level, pmsts;
>> -
>> -    pmsts =3D acpi_pm1_evt_get_sts(&s->ar);
>> -    sci_level =3D (((pmsts & s->ar=2Epm1=2Eevt=2Een) &
>> -                  (ACPI_BITMASK_RT_CLOCK_ENABLE |
>> -                   ACPI_BITMASK_POWER_BUTTON_ENABLE |
>> -                   ACPI_BITMASK_GLOBAL_LOCK_ENABLE |
>> -                   ACPI_BITMASK_TIMER_ENABLE)) !=3D 0);
>> -    qemu_set_irq(s->sci_irq, sci_level);
>> -    /* schedule a timer interruption if needed */
>> -    acpi_pm_tmr_update(&s->ar, (s->ar=2Epm1=2Eevt=2Een & ACPI_BITMASK_=
TIMER_ENABLE) &&
>> -                       !(pmsts & ACPI_BITMASK_TIMER_STATUS));
>> -}
>> -
>> static void pm_tmr_timer(ACPIREGS *ar)
>> {
>>     ViaPMState *s =3D container_of(ar, ViaPMState, ar);
>> -    pm_update_sci(s);
>> +    acpi_update_sci(&s->ar, s->sci_irq);
>
>To avoid needing an interrupt here maybe you could modify acpi_update_sci=
() to allow NULL irq then call via_isa_set_irq here so the interrupt routin=
g can be done within the ISA bridge=2E

Given the interesting behavior of the amigaone boot loader I'd respin this=
 series with the last two patches only=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>> }
>>=20
>> static void via_pm_reset(DeviceState *d)
>> @@ -182,7 +166,7 @@ static void via_pm_reset(DeviceState *d)
>>     acpi_pm1_cnt_reset(&s->ar);
>>     acpi_pm_tmr_reset(&s->ar);
>>     acpi_gpe_reset(&s->ar);
>> -    pm_update_sci(s);
>> +    acpi_update_sci(&s->ar, s->sci_irq);
>>=20
>>     pm_io_space_update(s);
>>     smb_io_space_update(s);
>>=20

