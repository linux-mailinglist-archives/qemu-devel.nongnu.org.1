Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0187DA7DE
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 17:45:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwlUj-0002MV-3q; Sat, 28 Oct 2023 11:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qwlUg-0002ME-U5
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 11:44:58 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qwlUe-00071h-Ve
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 11:44:58 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9c773ac9b15so451129466b.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 08:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698507895; x=1699112695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4tz98nv3wAnex/tjbVWYAyAd3IpouF1Z9Yl2y8VZ6w=;
 b=TkbA71LmGGE/qtyKwqvJzjtGoVbWmeKEttvRcFXtZp+v7QIsNUNRP4rZk4kPVMfuKT
 g/noDf/xYlWsT6pQs/7hW7sbED7fjEIP+KlEzuqFg5IeL9p2Tw6eqm86cYPOP/GK2VcC
 4Ebzwhr9Izi7+bnKt3L9cUwoLUaXg1eD9mufJa4V4OcbDnWDupvljEGEJhU/xw2wdL93
 Ejtc8Q5UHMhcwwGsdhwFZqct8cDX2NQ8U3UeE8w8BVhLwV19cT7fjifr6L88QyWx1PBj
 0xIyD24ScEAkoh393Z8ZGxNAl3MrZXDuL2Oc9dWDSTE94CF4b0kz3LEVYfWiT9rG55Xn
 tzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698507895; x=1699112695;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S4tz98nv3wAnex/tjbVWYAyAd3IpouF1Z9Yl2y8VZ6w=;
 b=AIJ6t1eupjKBNZIOLZITNiKVpooJpmuFPZL+WQWu7LUcgFZiAGh4B9bJ0MWepsbIFl
 no3doRGow5UKk3U5J05hcwavHdUS9pgRctU0YiZsRC+0+RBBprF8sM5iYNIFLh+Vy3Gr
 wgJnBF6ote7Bs1FzowaPBaXj5FBPC8FqRMA8NuQgvPo+Mz1tNkJG6xPlEpcY7WoZodL4
 G29H1scwHTGGgcNShFnP2JX6vwX/jNVaARZWZZ7lpCWqsJ/YEpnFWJw0cFLwpibpAzQc
 Xk0EIj8xXKYxDDFDJLfJ7WKbEBTMVEGihjSOMBWL/KZWrzlfwCFS5P3bV7QjcuVcLSJN
 3nag==
X-Gm-Message-State: AOJu0YyqpW7AXOSrTni78nglXghqA+dU6Fu5w710O4JsR4u3ASPyKS9h
 KGb13i3yU5VYKHEQbG3R4f8=
X-Google-Smtp-Source: AGHT+IHwRsPCH9y/09G1aCLcZx6Z24E5ts7bRDERsxhqUj4BMxeYUYLOGf+rdg3Crhf0QpZ/qAGpWQ==
X-Received: by 2002:a17:907:7251:b0:9ad:e298:a5d with SMTP id
 ds17-20020a170907725100b009ade2980a5dmr5433661ejc.19.1698507895308; 
 Sat, 28 Oct 2023 08:44:55 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-012-044-170.89.12.pool.telefonica.de.
 [89.12.44.170]) by smtp.gmail.com with ESMTPSA id
 i19-20020a1709063c5300b0098884f86e41sm2884316ejg.123.2023.10.28.08.44.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 08:44:54 -0700 (PDT)
Date: Sat, 28 Oct 2023 15:44:20 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_5/5=5D_hw/isa/vt82c686=3A_I?=
 =?US-ASCII?Q?mplement_software-based_SMI_triggering?=
In-Reply-To: <95144ce6-b340-11bf-354b-e73c2fbc795e@eik.bme.hu>
References: <20231028091606.23700-1-shentey@gmail.com>
 <20231028091606.23700-6-shentey@gmail.com>
 <95144ce6-b340-11bf-354b-e73c2fbc795e@eik.bme.hu>
Message-ID: <02D892F2-0778-40EF-A583-A4728B119EF8@gmail.com>
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



Am 28=2E Oktober 2023 13:03:41 UTC schrieb BALATON Zoltan <balaton@eik=2Eb=
me=2Ehu>:
>On Sat, 28 Oct 2023, Bernhard Beschow wrote:
>> If enabled, SMIs can be triggered via software by writing to an IO-mapp=
ed port=2E
>> SMIs usually trigger execution of BIOS code=2E If appropriate values ar=
e written
>> to the port, the BIOS transitions the system into or out of ACPI mode=
=2E
>>=20
>> Note that APMState implements Intel-specific behavior where there are t=
wo IO
>> ports which are mapped at fixed addresses=2E In VIA, there is only one =
such port
>> which is located inside a relocatable IO-mapped region=2E Hence, there =
is no point
>> in reusing APMState=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> hw/isa/vt82c686=2Ec | 95 +++++++++++++++++++++++++++++++++++++++++++---=
-
>> 1 file changed, 87 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/hw/isa/vt82c686=2Ec b/hw/isa/vt82c686=2Ec
>> index e8ec63dea9=2E=2E361b3bed0a 100644
>> --- a/hw/isa/vt82c686=2Ec
>> +++ b/hw/isa/vt82c686=2Ec
>> @@ -27,7 +27,6 @@
>> #include "hw/timer/i8254=2Eh"
>> #include "hw/rtc/mc146818rtc=2Eh"
>> #include "migration/vmstate=2Eh"
>> -#include "hw/isa/apm=2Eh"
>> #include "hw/acpi/acpi=2Eh"
>> #include "hw/i2c/pm_smbus=2Eh"
>> #include "qapi/error=2Eh"
>> @@ -42,6 +41,16 @@
>> #define TYPE_VIA_PM "via-pm"
>> OBJECT_DECLARE_SIMPLE_TYPE(ViaPMState, VIA_PM)
>>=20
>> +#define VIA_PM_IO_GBLEN 0x2a
>> +#define VIA_PM_IO_GBLEN_SW_SMI_EN (1 << 6)
>> +
>> +#define VIA_PM_IO_GBLCTL 0x2c
>> +#define VIA_PM_IO_GBLCTL_SMI_EN 1
>> +#define VIA_PM_IO_GBLCTL_SMIIG (1 << 4)
>> +#define VIA_PM_IO_GBLCTL_INSMI (1 << 8)
>> +
>> +#define VIA_PM_IO_SMI_CMD 0x2f
>> +
>> #define VIA_PM_GPE_LEN 4
>>=20
>> #define VIA_PM_SCI_SELECT_OFS 0x42
>
>If we'll make a copy of the data sheet in form of #defines could these be=
 in the header to less clutter the source?

Last time I did that I was asked to move the defines back into the source =
file=2E I can't find the link right now, otherwise I'd have placed it here=
=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>> @@ -49,14 +58,19 @@ OBJECT_DECLARE_SIMPLE_TYPE(ViaPMState, VIA_PM)
>>=20
>> struct ViaPMState {
>>     PCIDevice dev;
>> +
>>     MemoryRegion io;
>>     ACPIREGS ar;
>> -    APMState apm;
>> +    uint16_t gbl_en;
>> +    uint16_t gbl_ctl;
>> +    uint8_t smi_cmd;
>> +
>>     PMSMBus smb;
>>=20
>>     Notifier powerdown_notifier;
>>=20
>>     qemu_irq sci_irq;
>> +    qemu_irq smi_irq;
>> };
>>=20
>> static void pm_io_space_update(ViaPMState *s)
>> @@ -90,7 +104,7 @@ static int vmstate_acpi_post_load(void *opaque, int =
version_id)
>>=20
>> static const VMStateDescription vmstate_acpi =3D {
>>     =2Ename =3D "vt82c686b_pm",
>> -    =2Eversion_id =3D 1,
>> +    =2Eversion_id =3D 2,
>>     =2Eminimum_version_id =3D 1,
>>     =2Epost_load =3D vmstate_acpi_post_load,
>>     =2Efields =3D (VMStateField[]) {
>> @@ -98,9 +112,11 @@ static const VMStateDescription vmstate_acpi =3D {
>>         VMSTATE_UINT16(ar=2Epm1=2Eevt=2Ests, ViaPMState),
>>         VMSTATE_UINT16(ar=2Epm1=2Eevt=2Een, ViaPMState),
>>         VMSTATE_UINT16(ar=2Epm1=2Ecnt=2Ecnt, ViaPMState),
>> -        VMSTATE_STRUCT(apm, ViaPMState, 0, vmstate_apm, APMState),
>>         VMSTATE_TIMER_PTR(ar=2Etmr=2Etimer, ViaPMState),
>>         VMSTATE_INT64(ar=2Etmr=2Eoverflow_time, ViaPMState),
>> +        VMSTATE_UINT16(gbl_en, ViaPMState),
>> +        VMSTATE_UINT16(gbl_ctl, ViaPMState),
>> +        VMSTATE_UINT8(smi_cmd, ViaPMState),
>>         VMSTATE_END_OF_LIST()
>>     }
>> };
>> @@ -128,15 +144,75 @@ static void pm_write_config(PCIDevice *d, uint32_=
t addr, uint32_t val, int len)
>>     }
>> }
>>=20
>> +static void via_pm_apm_ctrl_changed(ViaPMState *s, uint8_t val)
>> +{
>> +    s->smi_cmd =3D val;
>> +
>> +    if (s->gbl_en & VIA_PM_IO_GBLEN_SW_SMI_EN
>> +        && s->gbl_ctl & VIA_PM_IO_GBLCTL_SMI_EN
>> +        && !(s->gbl_ctl & VIA_PM_IO_GBLCTL_SMIIG
>> +             && s->gbl_ctl & VIA_PM_IO_GBLCTL_INSMI)) {
>> +        s->gbl_ctl |=3D VIA_PM_IO_GBLCTL_INSMI;
>> +
>> +        if (s->smi_irq) {
>> +            qemu_irq_raise(s->smi_irq);
>> +        }
>> +    }
>> +}
>> +
>> static void pm_io_write(void *op, hwaddr addr, uint64_t data, unsigned =
size)
>> {
>> +    ViaPMState *s =3D op;
>> +
>>     trace_via_pm_io_write(addr, data, size);
>> +
>> +    switch (addr) {
>> +    case VIA_PM_IO_GBLEN:
>> +        s->gbl_en =3D (s->gbl_en & 0xff00) | data;
>> +        break;
>> +    case VIA_PM_IO_GBLEN + 1:
>> +        s->gbl_en =3D (s->gbl_en & 0x00ff) | (data << 8);
>> +        break;
>> +    case VIA_PM_IO_GBLCTL:
>> +        s->gbl_ctl =3D (s->gbl_ctl & 0xff00) | data;
>> +        break;
>> +    case VIA_PM_IO_GBLCTL + 1:
>> +        data <<=3D 8;
>> +        data &=3D ~(s->gbl_ctl & VIA_PM_IO_GBLCTL_INSMI);
>> +        s->gbl_ctl =3D (s->gbl_ctl & 0x00ff) | data;
>> +        break;
>> +    case VIA_PM_IO_SMI_CMD:
>> +        via_pm_apm_ctrl_changed(s, data);
>> +        break;
>> +    }
>> }
>>=20
>> static uint64_t pm_io_read(void *op, hwaddr addr, unsigned size)
>> {
>> -    trace_via_pm_io_read(addr, 0, size);
>> -    return 0;
>> +    ViaPMState *s =3D op;
>> +    uint64_t data =3D 0;
>> +
>> +    switch (addr) {
>> +    case VIA_PM_IO_GBLEN:
>> +        data =3D s->gbl_en & 0xff;
>> +        break;
>> +    case VIA_PM_IO_GBLEN + 1:
>> +        data =3D s->gbl_en >> 8;
>> +        break;
>> +    case VIA_PM_IO_GBLCTL:
>> +        data =3D s->gbl_ctl & 0xff;
>> +        break;
>> +    case VIA_PM_IO_GBLCTL + 1:
>> +        data =3D (s->gbl_ctl >> 8) & 0xd;
>> +        break;
>> +    case VIA_PM_IO_SMI_CMD:
>> +        data =3D s->smi_cmd;
>> +        break;
>> +    }
>> +
>> +    trace_via_pm_io_read(addr, data, size);
>> +
>> +    return data;
>> }
>>=20
>> static const MemoryRegionOps pm_io_ops =3D {
>> @@ -166,6 +242,10 @@ static void via_pm_reset(DeviceState *d)
>>     /* SMBus IO base */
>>     pci_set_long(s->dev=2Econfig + 0x90, 1);
>>=20
>> +    s->gbl_en =3D 0;
>> +    s->gbl_ctl =3D VIA_PM_IO_GBLCTL_SMIIG;
>> +    s->smi_cmd =3D 0;
>> +
>>     acpi_pm1_evt_reset(&s->ar);
>>     acpi_pm1_cnt_reset(&s->ar);
>>     acpi_pm_tmr_reset(&s->ar);
>> @@ -194,8 +274,6 @@ static void via_pm_realize(PCIDevice *dev, Error **=
errp)
>>     memory_region_add_subregion(pci_address_space_io(dev), 0, &s->smb=
=2Eio);
>>     memory_region_set_enabled(&s->smb=2Eio, false);
>>=20
>> -    apm_init(dev, &s->apm, NULL, s);
>> -
>>     memory_region_init_io(&s->io, OBJECT(dev), &pm_io_ops, s, "via-pm",=
 128);
>>     memory_region_add_subregion(pci_address_space_io(dev), 0, &s->io);
>>     memory_region_set_enabled(&s->io, false);
>> @@ -214,6 +292,7 @@ static void via_pm_init(Object *obj)
>>     ViaPMState *s =3D VIA_PM(obj);
>>=20
>>     qdev_init_gpio_out_named(DEVICE(obj), &s->sci_irq, "sci", 1);
>> +    qdev_init_gpio_out_named(DEVICE(obj), &s->smi_irq, "smi-irq", 1);
>> }
>>=20
>> typedef struct via_pm_init_info {
>>=20

