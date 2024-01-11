Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 494C882B71B
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 23:29:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO3Xi-0003dh-07; Thu, 11 Jan 2024 17:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rO3Xf-0003dV-F5
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 17:28:51 -0500
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rO3Xc-000753-Ps
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 17:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705012121; x=1705616921; i=deller@gmx.de;
 bh=+5YPAeKz0HcBe+GOsBFXKREwvUOH4lUUOjURfSSDalg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=EUvopRNItlOPidnYZp5k1TfcyN8qE1Px/+bFcHmzyAfHLE3iOBlYgvbC6hpGq3kh
 +DrL5uk0lkBmB5NyEeMqEgx8nJ9R9i+bekQZNEOuJe4VX3zaAd7C2gmBsxfyQC4gS
 onNoUPItTamrRPypJEG8kqsMYXLPHUAokGEa0v+oU4Zt+DwxHz4S0IWt7vbEzNubF
 Fyzl7xDt03Wkx3dKALjNexgw5h29xykquRE3/FefwpgdMe2WtyqNSAj8rijpK0EvI
 8UQHbmorlHFMPcRAudkUySkqBiwMdPg/FiB2gJmpS31MxW4Wcs+u10+wk0ton0cNw
 UyL3LSVt3wxGCfTgaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.159.195]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCOE-1rl6jN2TrQ-00NAQr; Thu, 11
 Jan 2024 23:28:41 +0100
Message-ID: <9942e915-3eef-4e3f-bd2c-7719082e7eee@gmx.de>
Date: Thu, 11 Jan 2024 23:28:40 +0100
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
 <1fde7d36-420a-4df5-821e-bcd4819ac6b7@gmx.de>
 <5c6768a6-a487-4a82-a4e1-374dff074610@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <5c6768a6-a487-4a82-a4e1-374dff074610@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:omhfR0rHsC7Rn+hXPjTpnVxUTMLKSzLfawoXjW/vUvtLsnR3qGn
 wDVj9IDbLPumLdgK4PdNKCNYCu14Az/vC5J/gQp97/Kn3QbZse7f/O6PPT2kkZ7g0aPcUuR
 7iK2zcvtyixc8QRS+gd+7N/WI+/wJRAfOMYGMYHvKRF3O1fOOCJLYHpgvGZ8rgYlrEVdAT8
 Vww4p+zkG6x2TuCQ0/acg==
UI-OutboundReport: notjunk:1;M01:P0:hXSI1XFni8c=;W6OGw2bxQQs3+J9VOWKlrt6eWq7
 OAvohR6n/NuL52g7f2EJADRSrDT+9Gve8+PZItx2MO725gCI1/NixwbRT1Uwa4C4YFHIVKQW7
 lPOYrULSol++PZ0GvvUeGQfxg9iS9OQzGB+WTvUpKGj8xvhOrfX9DVjbH+Y+D9QWxIS19jtqN
 e2YOkSe5fLFnWNQHYKNZNCHo7otmqT69LwL1zJV2EgrtV9HOPeEu+6/AVTfOpX1wEv7EGF7Aj
 7KQ+XKtGEPEtU5PVlGV1+eHLYdfvvF/VHvdCDgL9n8tS0k6lezLV41Qkn2GmvveUnBOsbtFiu
 7cx19tQGqjtYV0+abuTz+/gW9RtEb97lhNH8yPH/9xdgP7jlaX+RcPYYO1beS/kpWNH67ePg0
 vZWulqcW60KC/7mqTlRdGhs/3Ir1mTtlaXCRAlHIm39u356sJX1F45EmDeOpbXQKl/AobXPYf
 yhWdXf+U4vWi4EfQv/zs5VCRaakjxVXYwQO70wKi93lEGKGh6KZRxP1p8BGdDGM6G8VF8IjOZ
 g/Kkt22DXOWAyVy3t/wlXBsJ5iMcD2Xzw7/MGhExW4xwTK94ha1XH0S35pmvHXXf7Ha46PgdJ
 TPtTuhm8FK2sgCvO4NqdNL1U1+/Bk3TRlO++V5ynqrndzxBnr8xv7sUnBY1luVRC/tsMuEb/1
 WLnYJ1QSA8K8uCOaBdle5ROp7zIJ2VZeU0EDcYov27J4wjXDd14TDBaj1zgzuCVOuYCZRlrNo
 sTvt3MijhLTA48B+wweowYHsl/Qe+pjyaKTKFkWeq+QpIJKj4Lm8eh+SufOkH/2xsQTNnxuet
 A27wtq2vBXbOAMlEZPEKACv+hJm29MLY67IRKefQdei0wQ8xmuwpWr7OfUjAiQo6AaQC16dLT
 qgNw8PKEvM21NERRnxwurvMyWCsGFwiaosV4SPVXVGEYUSi/hiS6KyTuiedyghaiqLLepAWiY
 jhM4CYEeg5D8jFY9QG3U+N+w8Do=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
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

On 1/9/24 17:01, Richard Henderson wrote:
> On 1/9/24 22:16, Helge Deller wrote:
>> On 1/9/24 10:57, Richard Henderson wrote:
>>> On 1/8/24 00:22, deller@kernel.org wrote:
>>>> From: Helge Deller <deller@gmx.de>
>>>>
>>>> Add support for the qemu --nodefaults option, which will disable the
>>>> following default devices:
>>>> - lsi53c895a SCSI controller,
>>>> - artist graphics card,
>>>> - LASI 82596 NIC,
>>>> - tulip PCI NIC,
>>>> - second serial PCI card,
>>>> - USB OHCI controller.
>>>>
>>>> Adding this option is very useful to allow manual testing and
>>>> debugging of the other possible devices on the command line.
>>>>
>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>> ---
>>>> =C2=A0 hw/hppa/machine.c | 15 +++++++++------
>>>> =C2=A0 1 file changed, 9 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>>>> index b11907617e..8017002a2a 100644
>>>> --- a/hw/hppa/machine.c
>>>> +++ b/hw/hppa/machine.c
>>>> @@ -346,11 +346,14 @@ static void machine_HP_common_init_tail(Machine=
State *machine, PCIBus *pci_bus,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SysBusDevice *s;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* SCSI disk setup. */
>>>> -=C2=A0=C2=A0=C2=A0 dev =3D DEVICE(pci_create_simple(pci_bus, -1, "ls=
i53c895a"));
>>>> -=C2=A0=C2=A0=C2=A0 lsi53c8xx_handle_legacy_cmdline(dev);
>>>> +=C2=A0=C2=A0=C2=A0 if (defaults_enabled()) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D DEVICE(pci_create=
_simple(pci_bus, -1, "lsi53c895a"));
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lsi53c8xx_handle_legacy_c=
mdline(dev);
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Graphics setup. */
>>>> -=C2=A0=C2=A0=C2=A0 if (machine->enable_graphics && vga_interface_typ=
e !=3D VGA_NONE) {
>>>> +=C2=A0=C2=A0=C2=A0 if (defaults_enabled() && machine->enable_graphic=
s &&
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vga_interface_type !=3D V=
GA_NONE) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vga_interface_=
created =3D true;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D qdev_n=
ew("artist");
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D SYS_BUS_=
DEVICE(dev);
>>>> @@ -360,7 +363,7 @@ static void machine_HP_common_init_tail(MachineSt=
ate *machine, PCIBus *pci_bus,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Network setup. */
>>>> -=C2=A0=C2=A0=C2=A0 if (enable_lasi_lan()) {
>>>> +=C2=A0=C2=A0=C2=A0 if (defaults_enabled() && enable_lasi_lan()) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lasi_82596_ini=
t(addr_space, translate(NULL, LASI_LAN_HPA),
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> @@ -385,7 +388,7 @@ static void machine_HP_common_init_tail(MachineSt=
ate *machine, PCIBus *pci_bus,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_set_word(&pci_dev->config[PCI_SUBS=
YSTEM_ID], 0x1227); /* Powerbar */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* create a second serial PCI card whe=
n running Astro */
>>>> -=C2=A0=C2=A0=C2=A0 if (!lasi_dev) {
>>>> +=C2=A0=C2=A0=C2=A0 if (defaults_enabled() && !lasi_dev) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_dev =3D pc=
i_new(-1, "pci-serial-4x");
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_prop_set_=
chr(DEVICE(pci_dev), "chardev1", serial_hd(1));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_prop_set_=
chr(DEVICE(pci_dev), "chardev2", serial_hd(2));
>>>> @@ -395,7 +398,7 @@ static void machine_HP_common_init_tail(MachineSt=
ate *machine, PCIBus *pci_bus,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* create USB OHCI controller for USB =
keyboard & mouse on Astro machines */
>>>> -=C2=A0=C2=A0=C2=A0 if (!lasi_dev && machine->enable_graphics) {
>>>> +=C2=A0=C2=A0=C2=A0 if (defaults_enabled() && !lasi_dev && machine->e=
nable_graphics) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_create_sim=
ple(pci_bus, -1, "pci-ohci");
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb_create_sim=
ple(usb_bus_find(-1), "usb-kbd");
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb_create_sim=
ple(usb_bus_find(-1), "usb-mouse");
>>>
>>> This almost doubles the uses of default_enabled in the entire tree.
>>> I wonder if some of them are redundant or should be using a different
>>> test.
>>
>> Any proposal?
>> Maybe introduce a local variable hppa_bare_metal =3D !defaults_enabled(=
);
>> and use that instead?
>
> No, not like that.

Ok.

> In casual review I am surprised that !defaults_enabled() does not
> already imply !enable_graphics, unless the command-line goes on to
> explicitly add a graphics device.
> Am I missing something?

Will check that tommorow. If it does I'll remove that additional check.

But what other do you suggest in general how I should address your
concerns here?

Helge

