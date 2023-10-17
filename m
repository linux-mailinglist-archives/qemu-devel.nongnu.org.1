Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 663DA7CCA65
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsoXD-0003j5-Qw; Tue, 17 Oct 2023 14:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qsoXC-0003dr-CM
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:11:14 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qsoXA-0006na-GP
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697566269; x=1698171069; i=deller@gmx.de;
 bh=CwbnYozw8VgRXI2vxmKHMftPX+RNScFf3sE+XOs3pWM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=d8RJiJpjdMEUKwYkwnhG5EtZ31iStfh/zxv5pJJzpIdOI5FuXXuWeqjJKte7FgmDrPKIZ98j6FE
 FeEO3QfEvNDClabPxENfVAnkH86L7GYt3C8wcNAVX+Yi6aGZhuWxlszzTKAf5ldA1I8CYBoCVzT17
 lZzBrFFf87NlxaV9YN+v9yv5Z6I9zmr+sXFpHfe/0EK2T+2rJnWzLAmubVmhWTAQhoQ+Hj6XClHuB
 //aL/hSrAA2x83u7hEfxYnEWa6n4SCIsxT+RVr1wYk/bn3r8NFqa7C93er8c1u4AHVaCprl5F2q5X
 qGIPduGsvph4er8awCQwRp3agru/z1FPHJCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.254]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzFr-1rAcX61XeL-00HySe; Tue, 17
 Oct 2023 20:11:09 +0200
Message-ID: <cdcbec86-f0ce-4ec7-b10b-ff0f273b6cb7@gmx.de>
Date: Tue, 17 Oct 2023 20:11:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] hw/hppa: Export machine name, BTLBs,
 power-button address via fw_cfg
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, deller@kernel.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20231017154645.95844-1-deller@kernel.org>
 <20231017154645.95844-9-deller@kernel.org>
 <5a4278fe-461b-5ec6-852b-d77371babf7a@eik.bme.hu>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <5a4278fe-461b-5ec6-852b-d77371babf7a@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:36R8ynfPWB2j5VH3yiwoedb+0QomyCLlXtFgq68FEHSQy1g+jK1
 uXCRs7biQJVDDaq4n51dMMaSwzm5ckcEcAEaSkSnO8u1A2babPT/Th9qt+2FEQfWgPCWBrp
 +WLG6eSqv1wQ13g5MAtut2fsMEendJ2eoVhqhIJDc1cGkTJQ5WvtC/uXgdryCxa8VysCAg+
 XZW7n9yl4GUBIdJHAbcHg==
UI-OutboundReport: notjunk:1;M01:P0:ecVYR2pcuv0=;koqKIgC6RX1IbnnSqeLOpCjUcm1
 7WLask+xEWYYEhpekXgwTvljZ2AkDwILtnXPvDgIGs6aOJQPa3M8nwNHMLsoiJu/dO2YMroCk
 WLG2Pl404h8Jyoj6Rg033P4L9CHlaTnNigrj35Ox5eVF8X0LgQ3Kjs9iQu8ZF0pNIwAjChpNx
 GsQw6vhSR77LTfyep+YtAZk8fhtmzs44KLHwSmQrVeLlSvAvqjlZDyqsAjfroP0RoFXC+SbyJ
 b7fdNELcgJ7JlyxCUkMSIDz2H6/EnDMDeKzWGogRixNVeR4J88BeYKZRz0HNyjjwrC9pZr0+y
 3dUircOpgJEDY21FkVz3NyKLv1zuod1IwFLqVLnWlIq+60Y2rziTGzmS1JOKlKBygDBesWzm2
 y04VZAz9FGf8qEHwed1EtERzU3bTcXA0NBw0llKCi9eMT3JS+hb2IQPxHLrMvEuX/xfqp1ZV6
 Kbx7qOa2rjnJtgxh4nxnjG/NuTASvfvLz7SfJQ+LJsgNPf+HK3npeghUr2NT3c3fCrpBc9UMH
 lmWayGJlvEfiFTs1w6yRed+d+akk25qP78G7lO/C3EDYbtbiEG1Caq98BuvdjRNYr7E3UcWMr
 /+79oTkPeijD/+fhfHkaD/wZqly46xbQAlfyThsQ2rVrpdjOfRZ4tLzO8F7bPEOtGYC3HNMqx
 X4mkrG/xGuiWvX+VOiMIbWTloIcEYycMpE5FniLNyR3lDA44q6Hugem+2LAk+eXEmutJctJxD
 I/Gtgus0F2vn/9RXVedMisyKc7SjFu7eD9Ncr0EWQmXicqpllOBElkmWoI1v0ac529mC8jq5m
 fw5YAkOiWZ4iBloErRcA1Zxw3kdy4mhBreVjDYJjHYR0G8NIp4uc4wecL5fXxEWIYkEnZ0vxg
 wmbM2U+aPTCDnZbtKfCmmEW+rDV8bdlOIcQh6DG0zcCsLmnrr5Y2J2wqgKz4sgRh73b+dGV2r
 elj7Pg==
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/17/23 18:33, BALATON Zoltan wrote:
> On Tue, 17 Oct 2023, deller@kernel.org wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> Provide necessary info to SeaBIOS-hppa.
>
> If this is needed by the updated SeaBIOS in patch 1 shouldn't this come =
before that?

SeaBIOS has default values, so it's not dependend on the changed values he=
re.

Helge


> Regards,
> BALATON Zoltan
>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>> hw/hppa/machine.c | 22 +++++++++++++++++++---
>> 1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>> index c6d8deffcf..de925259ea 100644
>> --- a/hw/hppa/machine.c
>> +++ b/hw/hppa/machine.c
>> @@ -118,11 +118,13 @@ static void fw_cfg_boot_set(void *opaque, const c=
har *boot_device,
>> =C2=A0=C2=A0=C2=A0 fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_d=
evice[0]);
>> }
>>
>> -static FWCfgState *create_fw_cfg(MachineState *ms)
>> +static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus)
>> {
>> =C2=A0=C2=A0=C2=A0 FWCfgState *fw_cfg;
>> =C2=A0=C2=A0=C2=A0 uint64_t val;
>> =C2=A0=C2=A0=C2=A0 const char qemu_version[] =3D QEMU_VERSION;
>> +=C2=A0=C2=A0=C2=A0 MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>> +=C2=A0=C2=A0=C2=A0 int len;
>>
>> =C2=A0=C2=A0=C2=A0 fw_cfg =3D fw_cfg_init_mem(FW_CFG_IO_BASE, FW_CFG_IO=
_BASE + 4);
>> =C2=A0=C2=A0=C2=A0 fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, ms->smp.cpus)=
;
>> @@ -137,8 +139,20 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
>> =C2=A0=C2=A0=C2=A0 fw_cfg_add_file(fw_cfg, "/etc/cpu/tlb_entries",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_memdup(&val, sizeof(val)),=
 sizeof(val));
>>
>> +=C2=A0=C2=A0=C2=A0 val =3D cpu_to_le64(HPPA_BTLB_ENTRIES);
>> +=C2=A0=C2=A0=C2=A0 fw_cfg_add_file(fw_cfg, "/etc/cpu/btlb_entries",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_memdup(&val, sizeof(val)),=
 sizeof(val));
>> +
>> +=C2=A0=C2=A0=C2=A0 len =3D strlen(mc->name) + 1;
>> +=C2=A0=C2=A0=C2=A0 fw_cfg_add_file(fw_cfg, "/etc/hppa/machine",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_memdup(mc->name, len), len=
);
>> +
>> =C2=A0=C2=A0=C2=A0 val =3D cpu_to_le64(HPA_POWER_BUTTON);
>> -=C2=A0=C2=A0=C2=A0 fw_cfg_add_file(fw_cfg, "/etc/power-button-addr",
>> +=C2=A0=C2=A0=C2=A0 fw_cfg_add_file(fw_cfg, "/etc/hppa/power-button-add=
r",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_memdup(&val, sizeof(val)),=
 sizeof(val));
>> +
>> +=C2=A0=C2=A0=C2=A0 val =3D cpu_to_le64(CPU_HPA + 24);
>> +=C2=A0=C2=A0=C2=A0 fw_cfg_add_file(fw_cfg, "/etc/hppa/DebugOutputPort"=
,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_memdup(&val, sizeof(val)),=
 sizeof(val));
>>
>> =C2=A0=C2=A0=C2=A0 fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ms->boot_=
config.order[0]);
>> @@ -148,6 +162,8 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_memdup(qemu_version, sizeo=
f(qemu_version)),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(qemu_version));
>>
>> +=C2=A0=C2=A0=C2=A0 fw_cfg_add_extra_pci_roots(pci_bus, fw_cfg);
>> +
>> =C2=A0=C2=A0=C2=A0 return fw_cfg;
>> }
>>
>> @@ -250,7 +266,7 @@ static void machine_hppa_init(MachineState *machine=
)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parallel_hds[0]);
>>
>> =C2=A0=C2=A0=C2=A0 /* fw_cfg configuration interface */
>> -=C2=A0=C2=A0=C2=A0 create_fw_cfg(machine);
>> +=C2=A0=C2=A0=C2=A0 create_fw_cfg(machine, pci_bus);
>>
>> =C2=A0=C2=A0=C2=A0 /* SCSI disk setup. */
>> =C2=A0=C2=A0=C2=A0 dev =3D DEVICE(pci_create_simple(pci_bus, -1, "lsi53=
c895a"));
>>


