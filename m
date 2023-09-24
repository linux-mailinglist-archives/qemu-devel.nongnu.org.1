Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E70A87ACA98
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Sep 2023 17:44:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkRG2-0005Q2-Jf; Sun, 24 Sep 2023 11:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qkRG0-0005PI-UD
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 11:42:52 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qkRFy-0007G8-8k
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 11:42:52 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9a65f9147ccso600793666b.1
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695570168; x=1696174968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWBG+YH766oJNTrELCkIiNWNPaRxfIwWYhgiFOEvuKg=;
 b=C1nxQqdp4EB6CtQ35Qw2ZgmO4rtgg09Z+XwdHhhp0orw/lXivaKYV3GnfaGmmiFvvF
 wcA1SLHXVC2F9/hQ14xxFa/Z8XPNR9XTAkZyofpttA2nW5KUu3XZUiKSmMrc4b6Qrite
 4P9ftYeBWVrlY4YcRPY7YgK+XZYpvpcrRmxEci8m8qlNEAsImTLqKuFGTvLhjp6QWHUM
 C9LlPIp4ByJhxH2hFsBYrS4z5zsg7Aw67E1533HEUSqysxYLLdPqd4zAto0nPVIykCI0
 bTGgj8DgG5TeAz2f21JJRkMpHMJf5X8GoeB8b+aVio9Qjbl7joti8MhUAYBqu3cpAmaj
 PMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695570168; x=1696174968;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LWBG+YH766oJNTrELCkIiNWNPaRxfIwWYhgiFOEvuKg=;
 b=pQo5OeyN3t9Ug0PwrUqzPSursamnmytEmFFYGzNer7oD+LYWxT5bgCqEcX6W0bdHzP
 w5dSouncXBfsvc+qa85uc3ZqyUjLQkzSYL4gj1kfJnkOvR7Dp6iorvAlrDnLSomOsic8
 iiZY4PCF3OhCMvOM+VIMhY2v0MqpHEth0dgv8da0acMUtJePdDzZh4x0BVi9I7KtWE00
 QpMG4DFeMRxf5oiyCV6vRuC/VPrxOwGyLSWPWDutPvyzEGI/cS10NVyhHtzsQ2rJVy0+
 AJBY+HQwOsq9CuZyL0Yeocys5bxIoLfWPhirCxcyf19qtnP5i6LL2wBf4PekhDjK1d0D
 pfow==
X-Gm-Message-State: AOJu0Yzk/KgIElxYV0exCjfvu5BoWkte/wlLnpcilLeA9oIiiTC16peF
 FZCLp4IiWDtrFAB8162y/cM=
X-Google-Smtp-Source: AGHT+IGPnzNMZCBk+2gBWnkiDWgieKr3VB50FHyY5+zKG+3R7UkW+kmw8eSQ6bRZTQpMn944x+9hyw==
X-Received: by 2002:a17:906:3089:b0:9a2:1e03:1572 with SMTP id
 9-20020a170906308900b009a21e031572mr4325758ejv.19.1695570168028; 
 Sun, 24 Sep 2023 08:42:48 -0700 (PDT)
Received: from [127.0.0.1] ([45.156.240.107]) by smtp.gmail.com with ESMTPSA id
 cb8-20020a170906a44800b00988dbbd1f7esm5084289ejb.213.2023.09.24.08.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Sep 2023 08:42:47 -0700 (PDT)
Date: Sun, 24 Sep 2023 15:41:54 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Chuck Zmudzinski <brchuckz@aol.com>, Jason Andryuk <jandryuk@gmail.com>,
 Anthony PERARD <anthony.perard@citrix.com>
CC: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <eduardo@habkost.net>, 
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_2/6=5D_hw/isa/piix3=3A_Reuse?=
 =?US-ASCII?Q?_piix3=5Frealize=28=29_in_piix3=5Fxen=5Frealize=28=29?=
In-Reply-To: <6cd8d49f-2b69-471c-84b7-890f31f585b5@aol.com>
References: <20230312120221.99183-1-shentey@gmail.com>
 <20230312120221.99183-3-shentey@gmail.com>
 <f52c41f7-e662-4afd-8ac9-ce2c0da2b1be@perard>
 <7F45B51F-F1E3-4F04-A46F-4C80509C7195@gmail.com>
 <622b9674-fffd-4634-ac30-d0db3230478e@perard>
 <CAKf6xpvxf=F52etJ8o3eLQV4JVD5WM57znGoP3ctONRf7uPisA@mail.gmail.com>
 <B0FF78F4-1193-495B-919C-84A1FF8ADF12@gmail.com>
 <6cd8d49f-2b69-471c-84b7-890f31f585b5@aol.com>
Message-ID: <2541916E-6DA9-4DB9-A022-CD865B70F453@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 20=2E September 2023 14:44:23 UTC schrieb Chuck Zmudzinski <brchuckz@ao=
l=2Ecom>:
>On 9/19/2023 4:02 PM, Bernhard Beschow wrote:
>>=20
>>=20
>> Am 3=2E April 2023 12:27:14 UTC schrieb Jason Andryuk <jandryuk@gmail=
=2Ecom>:
>>>On Mon, Apr 3, 2023 at 5:33=E2=80=AFAM Anthony PERARD <anthony=2Eperard=
@citrix=2Ecom> wrote:
>>>>
>>>> On Sat, Apr 01, 2023 at 10:36:45PM +0000, Bernhard Beschow wrote:
>>>> >
>>>> >
>>>> > Am 30=2E M=C3=A4rz 2023 13:00:25 UTC schrieb Anthony PERARD <anthon=
y=2Eperard@citrix=2Ecom>:
>>>> > >On Sun, Mar 12, 2023 at 01:02:17PM +0100, Bernhard Beschow wrote:
>>>> > >> This is a preparational patch for the next one to make the follo=
wing
>>>> > >> more obvious:
>>>> > >>
>>>> > >> First, pci_bus_irqs() is now called twice in case of Xen where t=
he
>>>> > >> second call overrides the pci_set_irq_fn with the Xen variant=2E
>>>> > >
>>>> > >pci_bus_irqs() does allocates pci_bus->irq_count, so the second ca=
ll in
>>>> > >piix3_xen_realize() will leak `pci_bus->irq_count`=2E Could you lo=
ok if
>>>> > >pci_bus_irqs_cleanup() can be called before the second pci_bus_irq=
s()
>>>> > >call, or maybe some other way to avoid the leak?
>>>> >
>>>> > Thanks for catching this! I'll post a v4=2E
>>>> >
>>>> > I think the most fool-proof way to fix this is to free irq_count ju=
st before the assignment=2E pci_bus_irqs_cleanup() would then have to NULL =
the attribute such that pci_bus_irqs() can be called afterwards=2E
>>>> >
>>>> > BTW: I tried running qemu-system-x86_64 with PIIX4 rather than PIIX=
3 as Xen guest with my pc-piix4 branch without success=2E This branch essen=
tially just provides slightly different PCI IDs for PIIX=2E Does xl or some=
thing else in Xen check these? If not then this means I'm still missing som=
ething=2E Under KVM this branch works just fine=2E Any idea?
>>>>
>>>> Maybe the ACPI tables provided by libxl needs to be updated=2E
>>>> Or maybe something in the firmware (SeaBIOS or OVMF/OvmfXen) check th=
e
>>>> id (I know that the PCI id of the root bus is checked, but I don't kn=
ow
>>>> if that's the one that's been changed)=2E
>>>
>>>Xen also has hvmloader, which runs before SeaBIOS/OVMF=2E  Looking at
>>>tools/firmware/hvmloader/pci=2Ec, it has
>>>        ASSERT((devfn !=3D PCI_ISA_DEVFN) ||
>>>               ((vendor_id =3D=3D 0x8086) && (device_id =3D=3D 0x7000))=
);
>>>
>>>From QEMU, it looks like 0x7000 is PCI_DEVICE_ID_INTEL_82371SB_0, but
>>>PIIX4 uses 0x7110 (PCI_DEVICE_ID_INTEL_82371AB_0)=2E  Maybe try removin=
g
>>>that check?
>>=20
>> I was finally able to build Xen successfully (without my distribution p=
roviding too recent dependencies that prevent compilation)=2E With 0x7110 a=
dded in the line above I could indeed run a Xen guest with PIIX4=2E Yay!
>>=20
>> Now I just need to respin my PIIX consolidation series=2E=2E=2E
>
>Welcome to the world of running guests on Xen! I am the one who tested yo=
ur earlier patches with Xen guests,

Thanks, I remember for sure!

> and I just wanted to say thanks for keeping me in the loop=2E Please Cc =
me when you post your respin of the PIIX consolidation series since I would=
 like to also test it in my Xen environment=2E I understand I will also nee=
d to patch hvmloader=2Ec on the Xen side to set the correct device id=2E

I'd add your e-mail to the recipients list in my Git then=2E

For those who want a sneak preview of PIIX4 in the PC machine may compile =
https://github=2Ecom/shentok/qemu/tree/piix-consolidate and run `qemu-syste=
m-x86_64 -M pc,south-bridge=3Dpiix4-isa`=2E It should work with all availab=
le virtualization technologies=2E

Best regards,
Bernhard

>
>Kind regards,
>
>Chuck
>
>>=20
>> Best regards,
>> Bernhard
>>=20
>>>
>>>Regards,
>>>Jason
>

