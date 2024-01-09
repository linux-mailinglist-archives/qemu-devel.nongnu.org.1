Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C812C8284A1
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 12:18:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNA5u-0007vO-BI; Tue, 09 Jan 2024 06:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rNA5o-0007v9-Tz
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 06:16:27 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rNA5m-0007fA-Et
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 06:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704798971; x=1705403771; i=deller@gmx.de;
 bh=eV9IiUWhkP7TboVtOLq6UlXRp1/qIOPM96dYYerCESg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=BZK045UeTfxh62DOxKR/6/RrwqV9StX5hJArsIHpOAEEtqylLkh17jZyda4D2BVN
 H8BeWLwgNoOmBEyhlRBEs+n9aCAq3D97ICfhkbFsIy6ss03q8LkmtFAhNRNAcgklw
 9p9QRCLppwNHqXp9MJKtCgrKUGVPCSSJGcEQ1nUwcZFAGOat7WL2bwyOl2e+GVWz2
 AaIz5V/Y8uo5CUq2O8C+BqqV4U95PMentl2oc+9Vd+G98iz010/vWL5/miAh6W+2W
 rdA6SUoNKqA0kNxsBCAul5ghIR/rD/tEqqj5E3vWVgVnZCrmrSTHvFJFO11OKXHl2
 EPQm8hscKYwOs3O3fw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.149.181]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOzSu-1rX8tD33tM-00PPxO; Tue, 09
 Jan 2024 12:16:11 +0100
Message-ID: <1fde7d36-420a-4df5-821e-bcd4819ac6b7@gmx.de>
Date: Tue, 9 Jan 2024 12:16:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] hw/hppa/machine: Disable default devices with
 --nodefaults option
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, deller@kernel.org,
 qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>
References: <20240107132237.50553-1-deller@kernel.org>
 <20240107132237.50553-3-deller@kernel.org>
 <3cc1664c-9f5c-4d2f-b8f3-f8880c110e10@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <3cc1664c-9f5c-4d2f-b8f3-f8880c110e10@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5XSHt3EqhHZBgZfV/givzgIf0J1UyBcsHJ9zOnvSgvtR830bfjS
 ac+1fzjIvDTm9RuQWSAS7GbIBJys5C1qupTbUZna0Qp9JnfuUXfuUvsp73bBjl4aunlYSeJ
 ZJbYx/ZIu7DXqDznbnwyd+l1ZzerVigUBDFbLY3GBT9IeDlW9dWxhzhOyIzVbdUcQIdolQ1
 oJ0UubsfKxEC4zT5ZuQqw==
UI-OutboundReport: notjunk:1;M01:P0:wsAW0f8FUBk=;Htv/mDpjDtgfvcaMbDOJN6jE7y0
 pNO0pr0BNOJGpuVSBKANcSHkFvxpzKqibuMOFiJEPjHlJNKNcMSMpSUp6elqFNxb3tLq4QnRz
 XJFO7xFuM8AgDnHU4gqApTNQcotmzl+8Usgq4jiyco34aQRPqBYlcxq2v90oCEryblOcpdCAz
 /imNscQPmSgGIREtStsf0kFKXgvp1H1eRtgC5SWOvODr2wJna5fcC8laWxSoc8jN0AX6kAF2L
 bqZVVIhfNMfn7z2uyX+LknnPodLZ5NN6S9GMZMOvhg20epIaHXHCQ572j9od8OlLyVZ/QQHuj
 vvn6TDj7uNp/8hrDMIKSZ1P6Vmnt42/qKx68lmlx4CXTeA+wih36QWKPGEtxKjVUPxQbVSn+t
 vz0zZtQwMxD072A3M2aBO+Om2YLhAQhSOCO0oEp0CN57nxCR2a6/uWZGXmp+ZeMS1kys8UoYf
 KcTgAdEohtiywnI3zJEJk5a5wgeFNBswWKakuuYTcty73I0B8KuzgzVfnygHzPSa2/o6W2iv6
 9S+NuVdAO3YThw3a0C6lOIB11vN5Fggaw1b6DBaJV9bZgZ+F8xnrarOjUqfMrVjkQx5/Dyet6
 Ux8oPbVprwkx6koQIkw0WR+HudYqpE2xQuistlpqnfxO3Lez+IuKlj+Rkxcs95/MQcqHe9dCK
 ySwuqlH1fSIN1HkmrcZMNec5JZf5ITfNbnjwY2ypVNdgfTASt2axXIHLd1t8nSNPJTu4BAy0N
 xa818jb3njiumMXujKlCjT/1n0zpX7uFWbiDJR26AFcNjt942v6JziMt/m/SSgmrpbIlANi0i
 2MToGQrN7j2SRgdCNwCFhU98evt2YsPkXaF+l9equuo5rKNlcRthkxbbeYXw0hEjantMNxE2a
 5pP7wbWETpwwntG7wzlbN90XRHi2lfHiyfunuQNlTgd7DtRSb5bWniwWNO21oiemd/ittWMmg
 1J15o+uerLwNjsroPpOo/CeawGg=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/9/24 10:57, Richard Henderson wrote:
> On 1/8/24 00:22, deller@kernel.org wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> Add support for the qemu --nodefaults option, which will disable the
>> following default devices:
>> - lsi53c895a SCSI controller,
>> - artist graphics card,
>> - LASI 82596 NIC,
>> - tulip PCI NIC,
>> - second serial PCI card,
>> - USB OHCI controller.
>>
>> Adding this option is very useful to allow manual testing and
>> debugging of the other possible devices on the command line.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>> =C2=A0 hw/hppa/machine.c | 15 +++++++++------
>> =C2=A0 1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>> index b11907617e..8017002a2a 100644
>> --- a/hw/hppa/machine.c
>> +++ b/hw/hppa/machine.c
>> @@ -346,11 +346,14 @@ static void machine_HP_common_init_tail(MachineSt=
ate *machine, PCIBus *pci_bus,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SysBusDevice *s;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* SCSI disk setup. */
>> -=C2=A0=C2=A0=C2=A0 dev =3D DEVICE(pci_create_simple(pci_bus, -1, "lsi5=
3c895a"));
>> -=C2=A0=C2=A0=C2=A0 lsi53c8xx_handle_legacy_cmdline(dev);
>> +=C2=A0=C2=A0=C2=A0 if (defaults_enabled()) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D DEVICE(pci_create_s=
imple(pci_bus, -1, "lsi53c895a"));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lsi53c8xx_handle_legacy_cmd=
line(dev);
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Graphics setup. */
>> -=C2=A0=C2=A0=C2=A0 if (machine->enable_graphics && vga_interface_type =
!=3D VGA_NONE) {
>> +=C2=A0=C2=A0=C2=A0 if (defaults_enabled() && machine->enable_graphics =
&&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vga_interface_type !=3D VGA=
_NONE) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vga_interface_cr=
eated =3D true;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D qdev_new=
("artist");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D SYS_BUS_DE=
VICE(dev);
>> @@ -360,7 +363,7 @@ static void machine_HP_common_init_tail(MachineStat=
e *machine, PCIBus *pci_bus,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Network setup. */
>> -=C2=A0=C2=A0=C2=A0 if (enable_lasi_lan()) {
>> +=C2=A0=C2=A0=C2=A0 if (defaults_enabled() && enable_lasi_lan()) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lasi_82596_init(=
addr_space, translate(NULL, LASI_LAN_HPA),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -385,7 +388,7 @@ static void machine_HP_common_init_tail(MachineStat=
e *machine, PCIBus *pci_bus,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_set_word(&pci_dev->config[PCI_SUBSYS=
TEM_ID], 0x1227); /* Powerbar */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* create a second serial PCI card when =
running Astro */
>> -=C2=A0=C2=A0=C2=A0 if (!lasi_dev) {
>> +=C2=A0=C2=A0=C2=A0 if (defaults_enabled() && !lasi_dev) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_dev =3D pci_=
new(-1, "pci-serial-4x");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_prop_set_ch=
r(DEVICE(pci_dev), "chardev1", serial_hd(1));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_prop_set_ch=
r(DEVICE(pci_dev), "chardev2", serial_hd(2));
>> @@ -395,7 +398,7 @@ static void machine_HP_common_init_tail(MachineStat=
e *machine, PCIBus *pci_bus,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* create USB OHCI controller for USB ke=
yboard & mouse on Astro machines */
>> -=C2=A0=C2=A0=C2=A0 if (!lasi_dev && machine->enable_graphics) {
>> +=C2=A0=C2=A0=C2=A0 if (defaults_enabled() && !lasi_dev && machine->ena=
ble_graphics) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_create_simpl=
e(pci_bus, -1, "pci-ohci");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb_create_simpl=
e(usb_bus_find(-1), "usb-kbd");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb_create_simpl=
e(usb_bus_find(-1), "usb-mouse");
>
> This almost doubles the uses of default_enabled in the entire tree.
> I wonder if some of them are redundant or should be using a different
> test.

Any proposal?
Maybe introduce a local variable hppa_bare_metal =3D !defaults_enabled();
and use that instead?

Helge

