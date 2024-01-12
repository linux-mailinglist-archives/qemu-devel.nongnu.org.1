Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C682282BC10
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 08:54:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOCLq-0001rX-Pn; Fri, 12 Jan 2024 02:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rOCLp-0001rP-6w
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 02:53:13 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rOCLm-0004im-UW
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 02:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705045980; x=1705650780; i=deller@gmx.de;
 bh=MmLEvs1xImVEFana9gQZaLsKuU95UTY0B784sM0vakw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=hwKt8NdmT9O2lWunq3P5gkaKuII+kV09Q6R3fh6bpxQ7ULUNJRv01h21C7mn4IGF
 zVlwCDId9tseTuUSYGrKlcyFjYH/1tHmPcSbVqx7chrpixpDWipdqjuzLYtnnz+tK
 YziwW6AxeJ/D3zTgkBYFbzA5+PxlRg1J1uMjpadY5rVCd55yktSJpDOL6lRNAkRIj
 Vq8fgi3AqR/3mPaHkqlGDKzjmeofMOf7sruJm2vaBek3xecYh6HvVklVd8IHJatD0
 7ODw5MGW0X2gRGrF3M0h2vDjmKP0+UVT1siUvPtD7Kis255jrHJLeEMhE4RvxEaAJ
 zDkepv5/H0OiIxNHDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.156.180]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0oFz-1rCB8T2A33-00wkIR; Fri, 12
 Jan 2024 08:53:00 +0100
Message-ID: <62b4eb04-48f9-4cda-bb03-1efbc1c97dca@gmx.de>
Date: Fri, 12 Jan 2024 08:52:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] hw/hppa/machine: Disable default devices with
 --nodefaults option
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, deller@kernel.org,
 qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>
References: <20240107132237.50553-1-deller@kernel.org>
 <20240107132237.50553-3-deller@kernel.org>
 <3cc1664c-9f5c-4d2f-b8f3-f8880c110e10@linaro.org>
 <1fde7d36-420a-4df5-821e-bcd4819ac6b7@gmx.de>
 <5c6768a6-a487-4a82-a4e1-374dff074610@linaro.org>
 <9942e915-3eef-4e3f-bd2c-7719082e7eee@gmx.de>
 <9496438f-a12b-4eca-8b2d-c8c6bbc52e69@redhat.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <9496438f-a12b-4eca-8b2d-c8c6bbc52e69@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UJHxediii48cwSm8OJubnHMUwyKHfmazjiA3JG0+57di6++BUpy
 3pFAZu3eXHL84dZJIpG6mCGBFs+PA0ZIA6/rGHmBSl7GOl6eghvMnxyJpL0R8jTUbnilzNX
 alpV79nHswQ01rb7Pk5u7+FPhfjPY416g1uuoxRmeS7/TSPpVgx7vXvEN0Tafcnfoq6vRF+
 AWuNAuHH8n1MdVD21GlGg==
UI-OutboundReport: notjunk:1;M01:P0:3i42yFBA+eI=;jZwklk7yVTlVOwOE2AoFDphke2Q
 A7LCt6mFsSfPQaYC48UIszfycnwv5J5BDzmKgvyijFlWI9ZSPAiJk/9z80/UHIqFD5QvQfeV8
 9g00G2vxWAVjG71gOlB68fjS7x4CyfG8CHHTf3MSOQidG7ub2sL/i5pZumsdjGuJy8zkoSzqT
 vINvJYpyuWbvWLelUEAPK2QXw76paxkm0+znavkwq/bElGl6SjrS+s25mWAfqtA36deMvO9MN
 zPKXMc2z9MF6erEKSwaITbg7IF7I2vQOX3ZCJ+Ud7Ie16RWowakN47TsQRuv2QFM6uPKufohi
 CKsK15mDINzDOtcaejpkpiNT/0tNYU22GO88Ix032pqnseeodu/NvajTCeXM6P4uIq7U2fDmk
 4FdFNnlKC0iwv0x7iffdcYBlKwbpVFa6ib6zgsnFxv066k2pE+dj8FGUPmgmzrjhNXxIvSHdB
 eaIZzXtQeUDToH1mF4BRIX5VSJOXdPP2SpeN53nNFMD5ICEzyo3TLzBqd4GlVoYFBCFSMl7B8
 jFJlo1bVP0gUHjDWGP17CzTzyHxknE5xvl+DzvCR1NOUze8c7uz7e46Eu8m5WkJyFH6Ibg+M0
 aXUOa9sdZ2rmR4Ep4A+TIkL7XcmTWfaIPSIzh6aG/GUEJF4NcG+0oK4ZWEgvHLHGDBSYLJC1i
 d9VkMcoemofoEuNIsNfhvwoluE7HTIAo8VYHlrOBox3q49eriyAyW22HyQclntrawW7doMgC9
 dyu/H8tJXNy0omTU9Y3LpbQ8tayjLbo1iAQJCvNKMhWaj9Aa8sf7TWTdmzIB5i0299n4b4ah0
 sLNR7GKE2oz/1BMaArq0Nl8KVjgTjclVJwXfjYP2gueJuSw17sUC2iPsU5BtF5AxcbLFAmXzp
 Y/WbuatV/x/yNjld0YQ0pv1AOFBnT2qPbL1u9WrBCZJnl/sOfYWoDOhp2YrxSD8ZMiGDzwSQh
 DtZN1w==
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/12/24 06:09, Thomas Huth wrote:
> On 11/01/2024 23.28, Helge Deller wrote:
>> On 1/9/24 17:01, Richard Henderson wrote:
>>> On 1/9/24 22:16, Helge Deller wrote:
>>>> On 1/9/24 10:57, Richard Henderson wrote:
>>>>> On 1/8/24 00:22, deller@kernel.org wrote:
>>>>>> From: Helge Deller <deller@gmx.de>
>>>>>>
>>>>>> Add support for the qemu --nodefaults option, which will disable th=
e
>>>>>> following default devices:
>>>>>> - lsi53c895a SCSI controller,
>>>>>> - artist graphics card,
>>>>>> - LASI 82596 NIC,
>>>>>> - tulip PCI NIC,
>>>>>> - second serial PCI card,
>>>>>> - USB OHCI controller.
>>>>>>
>>>>>> Adding this option is very useful to allow manual testing and
>>>>>> debugging of the other possible devices on the command line.
>>>>>>
>>>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>>>> ---
>>>>>> =C2=A0 hw/hppa/machine.c | 15 +++++++++------
>>>>>> =C2=A0 1 file changed, 9 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>>>>>> index b11907617e..8017002a2a 100644
>>>>>> --- a/hw/hppa/machine.c
>>>>>> +++ b/hw/hppa/machine.c
>>>>>> @@ -346,11 +346,14 @@ static void machine_HP_common_init_tail(Machi=
neState *machine, PCIBus *pci_bus,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SysBusDevice *s;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* SCSI disk setup. */
>>>>>> -=C2=A0=C2=A0=C2=A0 dev =3D DEVICE(pci_create_simple(pci_bus, -1, "=
lsi53c895a"));
>>>>>> -=C2=A0=C2=A0=C2=A0 lsi53c8xx_handle_legacy_cmdline(dev);
>>>>>> +=C2=A0=C2=A0=C2=A0 if (defaults_enabled()) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D DEVICE(pci_crea=
te_simple(pci_bus, -1, "lsi53c895a"));
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lsi53c8xx_handle_legacy=
_cmdline(dev);
>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Graphics setup. */
>>>>>> -=C2=A0=C2=A0=C2=A0 if (machine->enable_graphics && vga_interface_t=
ype !=3D VGA_NONE) {
>>>>>> +=C2=A0=C2=A0=C2=A0 if (defaults_enabled() && machine->enable_graph=
ics &&
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vga_interface_type !=3D=
 VGA_NONE) {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vga_interfac=
e_created =3D true;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D qdev=
_new("artist");
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D SYS_BU=
S_DEVICE(dev);
>>>>>> @@ -360,7 +363,7 @@ static void machine_HP_common_init_tail(Machine=
State *machine, PCIBus *pci_bus,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Network setup. */
>>>>>> -=C2=A0=C2=A0=C2=A0 if (enable_lasi_lan()) {
>>>>>> +=C2=A0=C2=A0=C2=A0 if (defaults_enabled() && enable_lasi_lan()) {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lasi_82596_i=
nit(addr_space, translate(NULL, LASI_LAN_HPA),
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA));
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> @@ -385,7 +388,7 @@ static void machine_HP_common_init_tail(Machine=
State *machine, PCIBus *pci_bus,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_set_word(&pci_dev->config[PCI_SU=
BSYSTEM_ID], 0x1227); /* Powerbar */
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* create a second serial PCI card w=
hen running Astro */
>>>>>> -=C2=A0=C2=A0=C2=A0 if (!lasi_dev) {
>>>>>> +=C2=A0=C2=A0=C2=A0 if (defaults_enabled() && !lasi_dev) {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_dev =3D =
pci_new(-1, "pci-serial-4x");
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_prop_se=
t_chr(DEVICE(pci_dev), "chardev1", serial_hd(1));
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_prop_se=
t_chr(DEVICE(pci_dev), "chardev2", serial_hd(2));
>>>>>> @@ -395,7 +398,7 @@ static void machine_HP_common_init_tail(Machine=
State *machine, PCIBus *pci_bus,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* create USB OHCI controller for US=
B keyboard & mouse on Astro machines */
>>>>>> -=C2=A0=C2=A0=C2=A0 if (!lasi_dev && machine->enable_graphics) {
>>>>>> +=C2=A0=C2=A0=C2=A0 if (defaults_enabled() && !lasi_dev && machine-=
>enable_graphics) {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_create_s=
imple(pci_bus, -1, "pci-ohci");
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb_create_s=
imple(usb_bus_find(-1), "usb-kbd");
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb_create_s=
imple(usb_bus_find(-1), "usb-mouse");
>>>>>
>>>>> This almost doubles the uses of default_enabled in the entire tree.
>>>>> I wonder if some of them are redundant or should be using a differen=
t
>>>>> test.
>>>>
>>>> Any proposal?
>>>> Maybe introduce a local variable hppa_bare_metal =3D !defaults_enable=
d();
>>>> and use that instead?
>>>
>>> No, not like that.
>>
>> Ok.
>>
>>> In casual review I am surprised that !defaults_enabled() does not
>>> already imply !enable_graphics, unless the command-line goes on to
>>> explicitly add a graphics device.
>>> Am I missing something?
>>
>> Will check that tommorow. If it does I'll remove that additional check.
>>
>> But what other do you suggest in general how I should address your
>> concerns here?
>
> IIRC enable_graphics is not influenced by --nodefaults, but it should be=
 possible to simply check vga_interface_type only - that should get set to=
 VGA_NONE when the user started QEMU with --nodefaults.
>
> For networking, other boards normally check nd_table[0]. And for serial,=
 you can check whether serial_hd(0) returns a non-NULL value.
>
> For checking whether you have to create SCSI devices by default, you can=
 check drive_get_max_bus(IF_SCSI), I think.

Thanks a lot!
Those hints really helped me to avoid usage of defaults_enabled().

Helge

