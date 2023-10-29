Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E00577DAA53
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 02:08:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwuHC-0002vZ-7Q; Sat, 28 Oct 2023 21:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qwuH7-0002vI-He
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 21:07:34 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qwuH4-0008Mc-H5
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 21:07:32 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9d10f94f70bso183724666b.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 18:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698541649; x=1699146449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7zjUxvNmqoSK1xsAm0KpwaS2ds2Pb3sj7EnE4RzHMzM=;
 b=JeZbjSj7akG+QYFU2XIRlSDP+bmGPhiPWmFbHEkpDTJSyIj4vZL0SvzQtAUsYZ+ORr
 Gd3JsZTlNHq7GZKfdH/C/QGTrPkdXQZ3SxVPzjqHSRo4ajwLFYm4i/4MzI7rdwqR4aCn
 6L29Zqxoo7Ft7heYo/JiQKB4Hg13ZSp+AEunuaXWCupUuO5ovaLHTfmJCSlQF3isb3Ua
 m6Hja8/EOS3I60J4OFH/yO7/BPdq1evneQZSSGpXncgxR9F8aCyE6a5mfWXAX/jXMDTa
 OVScU9XndnpmncZH5b7YKIM91mHA2vzh42YSRowKZJ1QEwRRfidXhkVt2lmECgyLPOJ6
 KnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698541649; x=1699146449;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7zjUxvNmqoSK1xsAm0KpwaS2ds2Pb3sj7EnE4RzHMzM=;
 b=v+A0lIfQCCrcuaeNyh+xsXyB053ObDgAxjwGnGhSetgidbOx6Ek+lZtagqgj49HoYl
 Ro1/ye4lZehh27cInJPzIQzCGAMsFVZbyTZ6K4eK371ukj0QLsx4B6PefvKWpqHQ+dw2
 QYdychhcORBpl7EelNCuG5BNu5ihCvHzdCxFKvtYpc71fWYSlR3lnnKsOeoE+1y6R0fv
 zqWESgen7ln6icd0J6vZYd5mpW6wR/RQ+fkvn+rB8g6WuimfZR7dexslHMvEUMzd3MTB
 x2pQYGdkLKlCNkVhXryylLLnIEgFwF+Gy+uAPYFNRGtLXI+TIMeCs9bGDY6enKrXsCPl
 LTew==
X-Gm-Message-State: AOJu0YzhQQBXQzFnhQaoxRjNq0fIibtCoprCrshYyINkA3T74KZR4+nN
 rj4bLHxSSFQaKN7Y6bPYgig=
X-Google-Smtp-Source: AGHT+IEO+n0KrZhUgnt0CeGDj7AaYttSf1eAcQopn1kjDN59jlOnEtvsOtpwaAXgVZoMJls2kwTK5Q==
X-Received: by 2002:a17:907:7b8e:b0:9ae:69ff:bcdb with SMTP id
 ne14-20020a1709077b8e00b009ae69ffbcdbmr5838567ejc.31.1698541648801; 
 Sat, 28 Oct 2023 18:07:28 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-013-030-128.77.13.pool.telefonica.de.
 [77.13.30.128]) by smtp.gmail.com with ESMTPSA id
 dx15-20020a170906a84f00b0099bccb03eadsm3470726ejb.205.2023.10.28.18.07.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 18:07:28 -0700 (PDT)
Date: Sun, 29 Oct 2023 01:07:24 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 3/5] hw/isa/vt82c686: Reuse acpi_update_sci()
In-Reply-To: <4d959097-0c53-c0fd-b1a0-3d8250e1a314@eik.bme.hu>
References: <20231028091606.23700-1-shentey@gmail.com>
 <20231028091606.23700-4-shentey@gmail.com>
 <4d959097-0c53-c0fd-b1a0-3d8250e1a314@eik.bme.hu>
Message-ID: <2BE36521-C092-47EE-92AD-3F70AC8D8140@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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

Why? This function works well as is for other device models=2E

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

