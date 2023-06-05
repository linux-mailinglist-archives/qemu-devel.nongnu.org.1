Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D60721EBB
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 09:02:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q64Dx-000843-80; Mon, 05 Jun 2023 03:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q64Dv-00082M-En
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 03:01:51 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q64Dt-0006qg-9c
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 03:01:50 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5151934a4e3so6584789a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 00:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685948506; x=1688540506;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7UQKx1Vra6b36tz31tTD8RN/rkvjtkXk/RzFAKZXu0E=;
 b=pBcehvCYH6qSx65EDcfNNfpH93AFHMaomk71RdZH3u3UdRaj8ppj/N5On8IYZ2ZhFH
 GgoDBnNgEG+48D4D4hVSEGQS+K6uweOCx/O2Vv718xVYF1oCAFFPoeDTOyE8SYMuUuTZ
 9YBSsUigw8F7+zz2sUvxzlK59ZIG37EAVeiK9n6ZA+ZnauEG1JPXi0RV3mkRdNkWsGHF
 Hofa/wabnAuRb3HngJYMd3u33Zy0TNYaXGsrglRQOh+2NfzW+7XAdTiU3mymKIpUpPTm
 gtHhrDzjfVJJn8jQ2sDPFaATy8Wa8ABX3Lx+upxQ5mspQM2nnXtXyKaaEK2WypjtAz3q
 i3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685948506; x=1688540506;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7UQKx1Vra6b36tz31tTD8RN/rkvjtkXk/RzFAKZXu0E=;
 b=LjZqmV6xQo7CA8j1PFLxcqt2I/1NpOogq1Q1P65YWPrvxB7g1I8KwpKErcCquE9Nbk
 vMeXiQEj+NdSosQswu5GwszL9RZmxYiy7Q6RADdd5EokUzwSbVntg6IpCx2awzOrG8sB
 G9l6U4X4txRo5/NO9Mh4u4oqACBkX4LYmt+lv3sK+/j1h8rp6cGkrD6T/egLzKZSsbPW
 W6eHpsKyFOzWpYPdTziBuyWwepV0YENV76hSRtUKoBXtl8xt/HYlWTJsD+SmtAfzsTmc
 4hyTet2PzJGbWhQo8MlAmDSxsPw4LkoByZTDtBz4Yt4+//v4Y9j0P2f0YADFwt83rWMl
 7Smg==
X-Gm-Message-State: AC+VfDwsUfDcmDESynVP9CaKH3LOgvSLm3zvH3fUz10ppUV1a4m0hPE3
 sJN/eJT0HhXlHsIBqaplO2s=
X-Google-Smtp-Source: ACHHUZ7WpGHFe3EMd73SsBT4DywvlubfrU2Oc5O+jKTVzYcA2EVb6dEnTmMIiL6fz/MRavCGIEJ3wg==
X-Received: by 2002:a05:6402:708:b0:505:745:a271 with SMTP id
 w8-20020a056402070800b005050745a271mr7369088edx.23.1685948505716; 
 Mon, 05 Jun 2023 00:01:45 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-014-188-226.89.14.pool.telefonica.de.
 [89.14.188.226]) by smtp.gmail.com with ESMTPSA id
 q22-20020aa7d456000000b0051631518aabsm3531431edr.93.2023.06.05.00.01.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 00:01:45 -0700 (PDT)
Date: Mon, 05 Jun 2023 07:01:42 +0000
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
In-Reply-To: <EB3E61EB-B543-4B15-94A9-C16A66437601@gmail.com>
References: <20230403074124.3925-1-shentey@gmail.com>
 <20230421033757-mutt-send-email-mst@kernel.org>
 <9EB9A984-61E5-4226-8352-B5DDC6E2C62E@gmail.com>
 <alpine.DEB.2.22.394.2305151350180.4125828@ubuntu-linux-20-04-desktop>
 <EB3E61EB-B543-4B15-94A9-C16A66437601@gmail.com>
Message-ID: <ADD39905-0305-477A-8801-C1F561E0DFD4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
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



Am 22=2E Mai 2023 15:42:03 UTC schrieb Bernhard Beschow <shentey@gmail=2Ec=
om>:
>
>
>Am 15=2E Mai 2023 20:52:40 UTC schrieb Stefano Stabellini <sstabellini@ke=
rnel=2Eorg>:
>>On Sat, 13 May 2023, Bernhard Beschow wrote:
>>> Am 21=2E April 2023 07:38:10 UTC schrieb "Michael S=2E Tsirkin" <mst@r=
edhat=2Ecom>:
>>> >On Mon, Apr 03, 2023 at 09:41:17AM +0200, Bernhard Beschow wrote:
>>> >> There is currently a dedicated PIIX3 device model for use under Xen=
=2E By reusing
>>> >> existing PCI API during initialization this device model can be eli=
minated and
>>> >> the plain PIIX3 device model can be used instead=2E
>>> >>=20
>>> >> Resolving TYPE_PIIX3_XEN_DEVICE results in less code while also mak=
ing Xen
>>> >> agnostic towards the precise south bridge being used in the PC mach=
ine=2E The
>>> >> latter might become particularily interesting once PIIX4 becomes us=
able in the
>>> >> PC machine, avoiding the "Frankenstein" use of PIIX4_ACPI in PIIX3=
=2E
>>> >
>>> >xen stuff so I assume that tree?
>>>=20
>>> Ping
>>
>>I am OK either way=2E Michael, what do you prefer?
>>
>>Normally I would suggest for you to pick up the patches=2E But as it
>>happens I'll have to likely send another pull request in a week or two
>>and I can add these patches to it=2E
>>
>>Let me know your preference and I am happy to follow it=2E
>
>Hi Stefano,
>
>Michael's PR was merged last week=2E How about including this series into=
 your PR then?

Ping

>
>Best regards,
>Bernhard
>
>>
>>
>>> >
>>> >> Testing done:
>>> >> - `make check`
>>> >> - Run `xl create` with the following config:
>>> >>     name =3D "Manjaro"
>>> >>     type =3D 'hvm'
>>> >>     memory =3D 1536
>>> >>     apic =3D 1
>>> >>     usb =3D 1
>>> >>     disk =3D [ "file:manjaro-kde-21=2E2=2E6-220416-linux515=2Eiso,h=
dc:cdrom,r" ]
>>> >>     device_model_override =3D "/usr/bin/qemu-system-x86_64"
>>> >>     vga =3D "stdvga"
>>> >>     sdl =3D 1
>>> >> - `qemu-system-x86_64 -M pc -m 2G -cpu host -accel kvm \
>>> >>     -cdrom manjaro-kde-21=2E2=2E6-220416-linux515=2Eiso`
>>> >>=20
>>> >> v4:
>>> >> - Add patch fixing latent memory leak in pci_bus_irqs() (Anthony)
>>> >>=20
>>> >> v3:
>>> >> - Rebase onto master
>>> >>=20
>>> >> v2:
>>> >> - xen_piix3_set_irq() is already generic=2E Just rename it=2E (Chuc=
k)
>>> >>=20
>>> >> Tested-by: Chuck Zmudzinski <brchuckz@aol=2Ecom>
>>> >>=20
>>> >> Bernhard Beschow (7):
>>> >>   include/hw/xen/xen: Rename xen_piix3_set_irq() to xen_intx_set_ir=
q()
>>> >>   hw/pci/pci=2Ec: Don't leak PCIBus::irq_count[] in pci_bus_irqs()
>>> >>   hw/isa/piix3: Reuse piix3_realize() in piix3_xen_realize()
>>> >>   hw/isa/piix3: Wire up Xen PCI IRQ handling outside of PIIX3
>>> >>   hw/isa/piix3: Avoid Xen-specific variant of piix3_write_config()
>>> >>   hw/isa/piix3: Resolve redundant k->config_write assignments
>>> >>   hw/isa/piix3: Resolve redundant TYPE_PIIX3_XEN_DEVICE
>>> >>=20
>>> >>  include/hw/southbridge/piix=2Eh |  1 -
>>> >>  include/hw/xen/xen=2Eh          |  2 +-
>>> >>  hw/i386/pc_piix=2Ec             | 36 +++++++++++++++++++--
>>> >>  hw/i386/xen/xen-hvm=2Ec         |  2 +-
>>> >>  hw/isa/piix3=2Ec                | 60 +----------------------------=
------
>>> >>  hw/pci/pci=2Ec                  |  2 ++
>>> >>  stubs/xen-hw-stub=2Ec           |  2 +-
>>> >>  7 files changed, 39 insertions(+), 66 deletions(-)
>>> >>=20
>>> >> --=20
>>> >> 2=2E40=2E0
>>> >>=20
>>> >
>>>=20

