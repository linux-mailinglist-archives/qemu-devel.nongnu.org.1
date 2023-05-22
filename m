Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4430970C2A5
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 17:42:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q17fq-0002Vw-10; Mon, 22 May 2023 11:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q17fo-0002Uu-63
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:42:12 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q17fm-0003bN-Fg
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:42:11 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-96f50e26b8bso797530566b.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684770128; x=1687362128;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ntBwRRWm0xdALQrGuEtYHqvRbQtMjEFrpMKv/FDPAtc=;
 b=Bq+iCjCjRCZk7Z2o2PEXXeN3EHl2PVNoeR7dHYGP77ELQXFLrOsTqbRZNuu2EZXNox
 ee4KV72bxzASbNu8HHDb+tecCgvuR1+j9zcQuziJ3WHXgGbDgMgR4q35VvaAvQ8FIzhd
 7BH7AFq52xE4g3RpUx86aW1PvdW2V9Ih7SQVS6OCPje7weuu4TmPucCfY8QPq554ONKh
 clrmC4luNFd0SSLT6qeD3mKwfFdwOBez4hfM2ae+Z6si5DOoX53MgZ8dc0DuEBSKZ6PM
 a1t9uxlb3K5N0McFOznAuyrBO9Or/4Cg+9jkY6n5rQpK6mtOO6vRrHc8hpGr/m3xTHGe
 HFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684770128; x=1687362128;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ntBwRRWm0xdALQrGuEtYHqvRbQtMjEFrpMKv/FDPAtc=;
 b=Au/1c0ivMn4E7PMJJCVHr4JPfsQRWfPyscR4Gyhv9zpkzToRuZO7r7eG7e6Zo4wKld
 6v4fQg5lcwNjoWQa9eBQpKrFhuEr8TqvxuLKQVukPubes0bJo69+2/y1Jw04RA5GYOy6
 SaeaiYCrrwd7dwBexS6cRoxE1UFjpmjPe62S/0Z3Lga17+ijNPgLTwgCFO6BdB1z+GBH
 Xm5uEMkaTe+oOHCbqR2jCadjy94oSZ/8ATC7ivk3/prOp9E85PDCyX3CSy/EWJH1AwoC
 XDxojDIG0CYOpvqCM6VZTmPBL1/UT325ZB+Gy4H3nzYRV6rhT1NzUoYY9X2DyT++LLpQ
 Sx4A==
X-Gm-Message-State: AC+VfDy7ExijUafwn3m9pA4L2pA4qwPgFsWPM+DJam2+qYZHNRpSh+wm
 7KxvM3lGFCoeZSjW652VVyM=
X-Google-Smtp-Source: ACHHUZ7G6JHBlLpI2JhNhYUZZZnAm4QfrynURn4NvO9azaPSCc58vc0V5uJ4Z0Rkvw7XgawRIq94UA==
X-Received: by 2002:a17:907:72c5:b0:96f:5f44:ea02 with SMTP id
 du5-20020a17090772c500b0096f5f44ea02mr10250547ejc.8.1684770128067; 
 Mon, 22 May 2023 08:42:08 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-012-142-218.89.12.pool.telefonica.de.
 [89.12.142.218]) by smtp.gmail.com with ESMTPSA id
 z14-20020a1709067e4e00b00969dfd160aesm3224573ejr.109.2023.05.22.08.42.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 08:42:07 -0700 (PDT)
Date: Mon, 22 May 2023 15:42:03 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Stefano Stabellini <sstabellini@kernel.org>, mst@redhat.com
CC: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Woodhouse <dwmw@amazon.co.uk>, Eduardo Habkost <eduardo@habkost.net>,
 Chuck Zmudzinski <brchuckz@aol.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 0/7] Resolve TYPE_PIIX3_XEN_DEVICE
In-Reply-To: <alpine.DEB.2.22.394.2305151350180.4125828@ubuntu-linux-20-04-desktop>
References: <20230403074124.3925-1-shentey@gmail.com>
 <20230421033757-mutt-send-email-mst@kernel.org>
 <9EB9A984-61E5-4226-8352-B5DDC6E2C62E@gmail.com>
 <alpine.DEB.2.22.394.2305151350180.4125828@ubuntu-linux-20-04-desktop>
Message-ID: <EB3E61EB-B543-4B15-94A9-C16A66437601@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



Am 15=2E Mai 2023 20:52:40 UTC schrieb Stefano Stabellini <sstabellini@ker=
nel=2Eorg>:
>On Sat, 13 May 2023, Bernhard Beschow wrote:
>> Am 21=2E April 2023 07:38:10 UTC schrieb "Michael S=2E Tsirkin" <mst@re=
dhat=2Ecom>:
>> >On Mon, Apr 03, 2023 at 09:41:17AM +0200, Bernhard Beschow wrote:
>> >> There is currently a dedicated PIIX3 device model for use under Xen=
=2E By reusing
>> >> existing PCI API during initialization this device model can be elim=
inated and
>> >> the plain PIIX3 device model can be used instead=2E
>> >>=20
>> >> Resolving TYPE_PIIX3_XEN_DEVICE results in less code while also maki=
ng Xen
>> >> agnostic towards the precise south bridge being used in the PC machi=
ne=2E The
>> >> latter might become particularily interesting once PIIX4 becomes usa=
ble in the
>> >> PC machine, avoiding the "Frankenstein" use of PIIX4_ACPI in PIIX3=
=2E
>> >
>> >xen stuff so I assume that tree?
>>=20
>> Ping
>
>I am OK either way=2E Michael, what do you prefer?
>
>Normally I would suggest for you to pick up the patches=2E But as it
>happens I'll have to likely send another pull request in a week or two
>and I can add these patches to it=2E
>
>Let me know your preference and I am happy to follow it=2E

Hi Stefano,

Michael's PR was merged last week=2E How about including this series into =
your PR then?

Best regards,
Bernhard

>
>
>> >
>> >> Testing done:
>> >> - `make check`
>> >> - Run `xl create` with the following config:
>> >>     name =3D "Manjaro"
>> >>     type =3D 'hvm'
>> >>     memory =3D 1536
>> >>     apic =3D 1
>> >>     usb =3D 1
>> >>     disk =3D [ "file:manjaro-kde-21=2E2=2E6-220416-linux515=2Eiso,hd=
c:cdrom,r" ]
>> >>     device_model_override =3D "/usr/bin/qemu-system-x86_64"
>> >>     vga =3D "stdvga"
>> >>     sdl =3D 1
>> >> - `qemu-system-x86_64 -M pc -m 2G -cpu host -accel kvm \
>> >>     -cdrom manjaro-kde-21=2E2=2E6-220416-linux515=2Eiso`
>> >>=20
>> >> v4:
>> >> - Add patch fixing latent memory leak in pci_bus_irqs() (Anthony)
>> >>=20
>> >> v3:
>> >> - Rebase onto master
>> >>=20
>> >> v2:
>> >> - xen_piix3_set_irq() is already generic=2E Just rename it=2E (Chuck=
)
>> >>=20
>> >> Tested-by: Chuck Zmudzinski <brchuckz@aol=2Ecom>
>> >>=20
>> >> Bernhard Beschow (7):
>> >>   include/hw/xen/xen: Rename xen_piix3_set_irq() to xen_intx_set_irq=
()
>> >>   hw/pci/pci=2Ec: Don't leak PCIBus::irq_count[] in pci_bus_irqs()
>> >>   hw/isa/piix3: Reuse piix3_realize() in piix3_xen_realize()
>> >>   hw/isa/piix3: Wire up Xen PCI IRQ handling outside of PIIX3
>> >>   hw/isa/piix3: Avoid Xen-specific variant of piix3_write_config()
>> >>   hw/isa/piix3: Resolve redundant k->config_write assignments
>> >>   hw/isa/piix3: Resolve redundant TYPE_PIIX3_XEN_DEVICE
>> >>=20
>> >>  include/hw/southbridge/piix=2Eh |  1 -
>> >>  include/hw/xen/xen=2Eh          |  2 +-
>> >>  hw/i386/pc_piix=2Ec             | 36 +++++++++++++++++++--
>> >>  hw/i386/xen/xen-hvm=2Ec         |  2 +-
>> >>  hw/isa/piix3=2Ec                | 60 +-----------------------------=
-----
>> >>  hw/pci/pci=2Ec                  |  2 ++
>> >>  stubs/xen-hw-stub=2Ec           |  2 +-
>> >>  7 files changed, 39 insertions(+), 66 deletions(-)
>> >>=20
>> >> --=20
>> >> 2=2E40=2E0
>> >>=20
>> >
>>=20

