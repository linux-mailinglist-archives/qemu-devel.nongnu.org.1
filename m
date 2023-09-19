Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE177A6BFD
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 22:03:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qigvZ-0004e7-3X; Tue, 19 Sep 2023 16:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qigvW-0004cY-KQ
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 16:02:30 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qigvU-0000UG-Rm
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 16:02:30 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3214de9cd8bso2449924f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 13:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695153746; x=1695758546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O4MvxlwOAuFe9rdoF6HBbC/2fx9cp5v+GhJrBkfXYUs=;
 b=K7wNTsObdVB2ag8StjrO8T7o9av5aTw+J9ulwdYf59lKxMLm1WTUz82GOw5N4Gm/Iu
 A+dSNhP8YBPuDPQHOqofcCE/oDpgSsCOCGgg0nqRRDRMfT2yjPzi4l7zk87wa/rO3Kdt
 /XEBYSAVFKFTaK8+JbgeGPvSQzpu45+2ffbshEARmgoF5Ou1Rh+UL4ncs1/QsQploPzl
 490OLbIlx8C8DVnf4/PWgAjQr/CcJJE+t3EzA1x4KeDiv5msJp8aKVu8mXWf8kcX+oP9
 j8ter9Hg+lIGDTtoTeITlm7JqVTFq9Y6W11dGZBB9lUq+GGnKTkbqkeLQnzZHZzIiHER
 uJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695153746; x=1695758546;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O4MvxlwOAuFe9rdoF6HBbC/2fx9cp5v+GhJrBkfXYUs=;
 b=Bu+SufYbNM3+JrRU3N/mHowmFC5EYzcQ8Cgz2wS5BFvt8kKIj1pSzofKLxbWs4YVPU
 BFttuY7KT+eSoABi/Tb5zt0IluPX4fd6PejpniXoB+z6g9JqkfC9/E4/ypk8X2/t1NtJ
 565MfN5EVPb4jh+VdziByiTLzkLjq6hoF9jR+KpOtxaTmsiA+rv9R8jTdsFs3v+Fr7BX
 WWVnjkooWr2iHv3YQBQ6i7jR5FUB55FsCFxPD2hGx3mYWoQxjMm2baOe4hNsFIZYents
 7b4ZNMfHnsWXemz5N0GPUrzDqEGBg/MG4/Vc5mThC8rtbHj1xxBTewmTZorXUAHV1gKq
 5hmw==
X-Gm-Message-State: AOJu0YwZNf7IsdN7+5J2frfwVA4AJLYmMKo2f8L26LpTmGq+wsPtxOEY
 YoRu2sJfL70pQHcrnrBEy5s=
X-Google-Smtp-Source: AGHT+IHA3Rcz/q54UukTkrot0NmdG02c+UqNugRafaiM1sEG/EUtJ2udAeBzQyZALWCxc0HNDpODHQ==
X-Received: by 2002:a5d:6a8c:0:b0:31f:f72c:dfa3 with SMTP id
 s12-20020a5d6a8c000000b0031ff72cdfa3mr512869wru.68.1695153746122; 
 Tue, 19 Sep 2023 13:02:26 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-183-084-126.77.183.pool.telefonica.de.
 [77.183.84.126]) by smtp.gmail.com with ESMTPSA id
 r2-20020adfe682000000b0031fe0576460sm6771659wrm.11.2023.09.19.13.02.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 13:02:25 -0700 (PDT)
Date: Tue, 19 Sep 2023 20:02:19 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Jason Andryuk <jandryuk@gmail.com>,
 Anthony PERARD <anthony.perard@citrix.com>
CC: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <eduardo@habkost.net>, 
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Chuck Zmudzinski <brchuckz@aol.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_2/6=5D_hw/isa/piix3=3A_Reuse?=
 =?US-ASCII?Q?_piix3=5Frealize=28=29_in_piix3=5Fxen=5Frealize=28=29?=
In-Reply-To: <CAKf6xpvxf=F52etJ8o3eLQV4JVD5WM57znGoP3ctONRf7uPisA@mail.gmail.com>
References: <20230312120221.99183-1-shentey@gmail.com>
 <20230312120221.99183-3-shentey@gmail.com>
 <f52c41f7-e662-4afd-8ac9-ce2c0da2b1be@perard>
 <7F45B51F-F1E3-4F04-A46F-4C80509C7195@gmail.com>
 <622b9674-fffd-4634-ac30-d0db3230478e@perard>
 <CAKf6xpvxf=F52etJ8o3eLQV4JVD5WM57znGoP3ctONRf7uPisA@mail.gmail.com>
Message-ID: <B0FF78F4-1193-495B-919C-84A1FF8ADF12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x433.google.com
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



Am 3=2E April 2023 12:27:14 UTC schrieb Jason Andryuk <jandryuk@gmail=2Eco=
m>:
>On Mon, Apr 3, 2023 at 5:33=E2=80=AFAM Anthony PERARD <anthony=2Eperard@c=
itrix=2Ecom> wrote:
>>
>> On Sat, Apr 01, 2023 at 10:36:45PM +0000, Bernhard Beschow wrote:
>> >
>> >
>> > Am 30=2E M=C3=A4rz 2023 13:00:25 UTC schrieb Anthony PERARD <anthony=
=2Eperard@citrix=2Ecom>:
>> > >On Sun, Mar 12, 2023 at 01:02:17PM +0100, Bernhard Beschow wrote:
>> > >> This is a preparational patch for the next one to make the followi=
ng
>> > >> more obvious:
>> > >>
>> > >> First, pci_bus_irqs() is now called twice in case of Xen where the
>> > >> second call overrides the pci_set_irq_fn with the Xen variant=2E
>> > >
>> > >pci_bus_irqs() does allocates pci_bus->irq_count, so the second call=
 in
>> > >piix3_xen_realize() will leak `pci_bus->irq_count`=2E Could you look=
 if
>> > >pci_bus_irqs_cleanup() can be called before the second pci_bus_irqs(=
)
>> > >call, or maybe some other way to avoid the leak?
>> >
>> > Thanks for catching this! I'll post a v4=2E
>> >
>> > I think the most fool-proof way to fix this is to free irq_count just=
 before the assignment=2E pci_bus_irqs_cleanup() would then have to NULL th=
e attribute such that pci_bus_irqs() can be called afterwards=2E
>> >
>> > BTW: I tried running qemu-system-x86_64 with PIIX4 rather than PIIX3 =
as Xen guest with my pc-piix4 branch without success=2E This branch essenti=
ally just provides slightly different PCI IDs for PIIX=2E Does xl or someth=
ing else in Xen check these? If not then this means I'm still missing somet=
hing=2E Under KVM this branch works just fine=2E Any idea?
>>
>> Maybe the ACPI tables provided by libxl needs to be updated=2E
>> Or maybe something in the firmware (SeaBIOS or OVMF/OvmfXen) check the
>> id (I know that the PCI id of the root bus is checked, but I don't know
>> if that's the one that's been changed)=2E
>
>Xen also has hvmloader, which runs before SeaBIOS/OVMF=2E  Looking at
>tools/firmware/hvmloader/pci=2Ec, it has
>        ASSERT((devfn !=3D PCI_ISA_DEVFN) ||
>               ((vendor_id =3D=3D 0x8086) && (device_id =3D=3D 0x7000)));
>
>From QEMU, it looks like 0x7000 is PCI_DEVICE_ID_INTEL_82371SB_0, but
>PIIX4 uses 0x7110 (PCI_DEVICE_ID_INTEL_82371AB_0)=2E  Maybe try removing
>that check?

I was finally able to build Xen successfully (without my distribution prov=
iding too recent dependencies that prevent compilation)=2E With 0x7110 adde=
d in the line above I could indeed run a Xen guest with PIIX4=2E Yay!

Now I just need to respin my PIIX consolidation series=2E=2E=2E

Best regards,
Bernhard

>
>Regards,
>Jason

