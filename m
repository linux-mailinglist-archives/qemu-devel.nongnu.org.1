Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A35C82C7E1
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 00:18:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOQlP-0003UW-El; Fri, 12 Jan 2024 18:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rOQlM-0003Ty-5l
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 18:16:32 -0500
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rOQlF-0001Qc-Jq
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 18:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705101355; x=1705706155; i=deller@gmx.de;
 bh=E8Q9OPAep4TXYJKjygEZsYNzgQrAZEab8YwyROJ+9x0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=g/AcCUUUC1dcIicmLdz236zHE/w2LhTaq0dzpEHJJumn7esGK48eNtX1t82pc2n5
 ZAlRnv8GWZnD427G35uqkLbe/E7M2vQfike3IRZlEt2urjrE4bOBgYZjfF6XUO+73
 2A5rROsC9a5XcTiFe8Z9XomRY5oUV3h99PRYr5HZNKeImqZWd8RrweCFHJtTJe9vg
 pZt9PneZ7m5LcWtehJDpfnNQPElsPHUlrlzQiRvRRK8gqHcQQ++LqmULwZIGMsVeh
 cxrUZFoHyvZXw/039lb8w8euB3lrQIDv0vBzQylSu1wg9zuaOBIi2s3p8EQnoPVO9
 t1vQRg9TH+IQfX2sVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.156.180]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfUo-1rHrAQ3YJU-00B62i; Sat, 13
 Jan 2024 00:15:55 +0100
Message-ID: <774b5908-c043-4b0b-889b-a964f92d2659@gmx.de>
Date: Sat, 13 Jan 2024 00:15:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] hw/hppa: Move software power button address back
 into PDC
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org
References: <20240112102927.35406-1-deller@kernel.org>
 <20240112102927.35406-6-deller@kernel.org>
 <477fa733-0957-4026-ac06-57d76d4b0388@linaro.org> <ZaHAwUC1V3WJpk5T@p100>
 <f2b0458c-f793-4b9d-a0bf-c7af22aaf099@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <f2b0458c-f793-4b9d-a0bf-c7af22aaf099@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h7X+QPLbX+m5SwimjRDTTv/LKMkJ5+D0ReDDnC0qOc5A6JIPM8D
 nBIh3MF+MeUPUhOGqVWPSjRKC+O0EYy3Lw+Xd8EsZuBd6br/ViHo4apRTtgPadHozyCq897
 hgOAZEkau1//AtCUh6aoJj6kuGwodsnEMyO2ij2D4W+bNAosUyLGmRl9rcsBX1nxX0XqzxH
 IqokVcXVnPDadFcrH6kjw==
UI-OutboundReport: notjunk:1;M01:P0:jHPlbzVcIRM=;vmn1wBEkOlcU5lsQrILUmwOJQs0
 Xb5o9sPWC/bkHPHt6GndWedkff5NZ1LOfLnwkxl0M2hVVp3bQ8eqEJ5ZX0pejeKhscXs6uslG
 ZBiuhM6c/9PUmRNZl6Yxrm7zES5SZD9gVfWnDZ627ZSTkYn7KPYn/7YcFD04UjKABI5CKCOqJ
 bFRQWP9or8AbtNO/FuD1XYfJD9bTejCMYM3KjODsTwtw0IkeO/Y+BKKL6bSGETdDTb0H8NabS
 mrZkMdYE3gpCrwcgQNlviax2UeBOZ+BNSvaurQcJXcArmT2/fPkJteQDuEGr30WE3bI/eFNO6
 IiO9HYQp2+Vyf3UfKwHo2ctMCoUU7exlEE/rVUnAbl0Tt4fqizuf4R1kk/l8UQdgeaamHnzVU
 V85CwXYpN7Z68Fc+iXqR1ByA2PSH5JwUc0mBXISriXWYJGwedhvp1E7VINgh6tXUu6RCUyp8o
 N7/0A2EObh7FwdTdG3GmhodMa+YzmF4m7ZS0HQDAuZotoc76Keno/W/yKR7jgQn+AV88JJM1B
 c/FILRHxGl1nER4LPjlUMndVsBrZI5vHLsZbI2jwBC63TrPkRf6BHgjMgEPBjtD//K5ozPQra
 vS06EHw2p04LFEHKlWSmtYpDrRggOKi82wVcss5f8geASrOkVDr3E3Tb7vpZuOOFxHqZrXCxl
 KXiOzfdzEM2GSfkVaS7a6I9vZdYTWldqZdgRiaDiJJICD16WvI4fqrRHU7clZOMmzhqN1Yp2t
 Z7k+0LhOOnUBsdjkDnQo9QoSzQhjyFzMo1ZM7Jy9QZCiDTKXbNm5nqdk0t4tLU6D82xZpRYwb
 afVL4SViG6biJJmkIOO1i0Yx+TtSP8c8cxhT/SftjYWZ81Fkcs49L6xqrn5kIF6uKsJQnIjDU
 q/+VxoOe0tzVxPaWCvsqFYZeQ6zzhxHqTRDiOk4SLs0Th8gQBy6Y1SPouHHXv0BzO3Hwv0DSq
 kU3iiw==
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/13/24 00:11, Richard Henderson wrote:
> On 1/13/24 09:44, Helge Deller wrote:
>>> I think it would be better to pass this as a parameter to create_fw_cf=
g, or
>>> to drop the translated FW_CFG_IO_BASE parameter and merely pass in tra=
nslate
>>> itself.
>>
>> Like this?
>>
>>
>> The various operating systems (e.g. Linux, NetBSD) have issues
>> mapping the power button when it's stored in page zero.
>> NetBSD even crashes, because it fails to map that page and then
>> accesses unmapped memory.
>>
>> Since we now have a consistent memory mapping of PDC in 32-bit
>> and 64-bit address space (the lower 32-bits of the address are in
>> sync) the power button can be moved back to PDC space.
>>
>> This patch fixes the power button on Linux, NetBSD and HP-UX.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Tested-by: Bruno Haible <bruno@clisp.org>
>>
>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>> index 54ca2fd91a..da85050f60 100644
>> --- a/hw/hppa/machine.c
>> +++ b/hw/hppa/machine.c
>> @@ -36,8 +36,8 @@
>> =C2=A0 #define MIN_SEABIOS_HPPA_VERSION 12 /* require at least this fw =
version */
>> -/* Power button address at &PAGE0->pad[4] */
>> -#define HPA_POWER_BUTTON (0x40 + 4 * sizeof(uint32_t))
>> +#define HPA_POWER_BUTTON=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (FI=
RMWARE_END - 0x10)
>> +static hwaddr soft_power_reg;
>
> You've forgotten to remove the global.

No... I did not forgot it.
This is still needed by other functions (e.g. hppa_powerdown_req())
in the same file.

If we want to remove it, it will become a much bigger and intrusive patch
(if there is even a nice clean way to do it).

Helge
> r~
>
>> =C2=A0 #define enable_lasi_lan()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>> @@ -45,7 +45,6 @@ static DeviceState *lasi_dev;
>> =C2=A0 static void hppa_powerdown_req(Notifier *n, void *opaque)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 hwaddr soft_power_reg =3D HPA_POWER_BUTTON;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t val;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D ldl_be_phys(&address_space_memor=
y, soft_power_reg);
>> @@ -191,7 +190,7 @@ static void fw_cfg_boot_set(void *opaque, const cha=
r *boot_device,
>> =C2=A0 }
>> =C2=A0 static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_b=
us,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwaddr addr)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwaddr addr, hwaddr pw=
r_button_addr)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FWCfgState *fw_cfg;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t val;
>> @@ -221,7 +220,7 @@ static FWCfgState *create_fw_cfg(MachineState *ms, =
PCIBus *pci_bus,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fw_cfg_add_file(fw_cfg, "/etc/hppa/machi=
ne",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_memdup(mc->nam=
e, len), len);
>> -=C2=A0=C2=A0=C2=A0 val =3D cpu_to_le64(HPA_POWER_BUTTON);
>> +=C2=A0=C2=A0=C2=A0 val =3D cpu_to_le64(pwr_button_addr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fw_cfg_add_file(fw_cfg, "/etc/hppa/power=
-button-addr",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_memdup(&val, s=
izeof(val)), sizeof(val));
>> @@ -295,6 +294,8 @@ static TranslateFn *machine_HP_common_init_cpus(Mac=
hineState *machine)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ram_max =3D 0xf0=
000000;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 3.75 GB (32-bit CPU) */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 soft_power_reg =3D translate(NULL, HPA_POWER_BUTTON=
);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (unsigned int i =3D 0; i < smp_cpus;=
 i++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_autofree char =
*name =3D g_strdup_printf("cpu%u-io-eir", i);
>> @@ -407,7 +408,8 @@ static void machine_HP_common_init_tail(MachineStat=
e *machine, PCIBus *pci_bus,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_register_powerdown_notifier(&hppa_s=
ystem_powerdown_notifier);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* fw_cfg configuration interface */
>> -=C2=A0=C2=A0=C2=A0 create_fw_cfg(machine, pci_bus, translate(NULL, FW_=
CFG_IO_BASE));
>> +=C2=A0=C2=A0=C2=A0 create_fw_cfg(machine, pci_bus, translate(NULL, FW_=
CFG_IO_BASE),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 translate(NULL, HPA_POWER_B=
UTTON));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Load firmware.=C2=A0 Given that this =
is not "real" firmware,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 but one explicitly wri=
tten for the emulation, we might as
>


