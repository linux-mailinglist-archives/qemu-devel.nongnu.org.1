Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1D37DA7DD
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 17:42:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwlRC-0001QN-Ok; Sat, 28 Oct 2023 11:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qwlQr-0001Mb-IL
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 11:41:03 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qwlQo-0006eg-IH
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 11:41:01 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-542d3e46ee7so1019272a12.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698507655; x=1699112455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHWSZ4OOPkIYmLigDuxuM+rHpTeuLcxaDofWRHPxUZc=;
 b=VkEh/AlXJaTuJzyGk0Nh/5LqWHmqBlLE/B0shwrw0mBriKMVCp+y3qV1D2PdM2dwBi
 2DDeyIJcWW0nJMGQ0xYqhVfiMW4Mq4CaCUiFL/aXaAWT2VEpEUryqnA+U8Lnc9TidCZO
 r9fsXJqh2ilrWPl5vJaMDJ5Z5gLgal6AQcb84D4S5kpkzIt4Cb2/+OOWV8mk+Ru87i4K
 EI5USONm1p58VQHpmzZrP+Cj21pEHJvGF6CxSjYmDb2Ozo4fwTSKjRY8Mnuc8+2GPEDv
 fc6t+Q2rSIxM4SvhEdCJrzdUQgdMOMs55rZWR+Cgu/yknOZ0SUfV/I3iPxAAb8XhbTFa
 Xv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698507655; x=1699112455;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHWSZ4OOPkIYmLigDuxuM+rHpTeuLcxaDofWRHPxUZc=;
 b=qZpvZKioLBRh8JjomVbgH9pZU00T1sFI4Xv/ZKL1bzhgLEb+ARpj+m53Tfsnx4qOgl
 tzQcdvcaUOPGT8Et0M57DjPTnY8dtcAgUGPy4/U6hC8MkGSTYU8ExMe1P4M2+T6rQ7aJ
 9+zHG1K9t84IYMGte8GclMRkk9t8+lYzBWivdEPDx9Zr3d3s57r+CLG5jjWUKP69gL7h
 krL5qWL7AN6KaT15NRFHuhtFLFVUQFSLzDKjkyw8rJVLQ9ifK8EMyu2+/haA/ZA9tCGV
 Bb6u/cp5c8KU8wx8DMAvGW3WKS73Bj/szDDOJ4aHfcka1HwGoh6D9vE3PawptlSoViDl
 2hZg==
X-Gm-Message-State: AOJu0YxZxAP47IOOCvGNre2b6QcmaYoOMuq6Xr8ZnF6WVb4L1B+IU6TQ
 7ol2df2jFNikGagHY991NHc=
X-Google-Smtp-Source: AGHT+IHjoI2G8b33+BTozHN9utXgyC/LYeCA0UulS2S7XVRy3doNPPmFM8owDYDH6XeYUeo7qqOvUA==
X-Received: by 2002:a05:6402:1a39:b0:540:e598:a35f with SMTP id
 be25-20020a0564021a3900b00540e598a35fmr4985852edb.5.1698507654837; 
 Sat, 28 Oct 2023 08:40:54 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-012-044-170.89.12.pool.telefonica.de.
 [89.12.44.170]) by smtp.gmail.com with ESMTPSA id
 s27-20020a50d49b000000b0053db0df6970sm3102776edi.54.2023.10.28.08.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 08:40:54 -0700 (PDT)
Date: Sat, 28 Oct 2023 15:40:49 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 3/5] hw/isa/vt82c686: Reuse acpi_update_sci()
In-Reply-To: <6199fe57-94b1-7633-e195-13519ef42a0c@eik.bme.hu>
References: <20231028091606.23700-1-shentey@gmail.com>
 <20231028091606.23700-4-shentey@gmail.com>
 <6199fe57-94b1-7633-e195-13519ef42a0c@eik.bme.hu>
Message-ID: <38F5BA50-A699-47E4-A342-5C53A225DC03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
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



Am 28=2E Oktober 2023 12:59:56 UTC schrieb BALATON Zoltan <balaton@eik=2Eb=
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
>
>The level calculation in acpi_update_sci() is different than the above=2E=
 Which one is correct and why?

acpi_update_sci() just covers the GPE registers in addition which are stan=
dard ACPI registers=2E As written in the commit message these aren't curren=
tly mapped by the device model so shouldn't cause any interferences=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
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

