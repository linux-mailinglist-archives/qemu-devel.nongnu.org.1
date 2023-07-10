Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB1974E03A
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 23:29:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIyQ1-0007lc-5L; Mon, 10 Jul 2023 17:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qIyPz-0007lL-DO; Mon, 10 Jul 2023 17:27:39 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qIyPv-0001mt-0o; Mon, 10 Jul 2023 17:27:39 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbc244d384so51572365e9.0; 
 Mon, 10 Jul 2023 14:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689024451; x=1691616451;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FlZDtAUxorZUjAFvFdKBgpsVq2UqX+aQYXVngrJMv7w=;
 b=gFkWGTpu2ESQS4ZsfSwhoRNQp5wzCuQupGoZXjZJKGjuiyvGfWmzAWuO+KwVlko4zL
 ZIpAR85ET5qrCm00VaMMYRKfAIYYPLbl2GNWLB+3cmKRRM7veXtg/1zzaIVQJxg6x0F8
 G7aI7VPxgEKVdFwv6BVAn2qHxY4QZDB3x1JdYjLGFohIJ1OBPXYii/yUN2bqtQrpg6e6
 QdvM/qKij+OQSK6wDg03V8RvOdLv+wpB/9PBssDWT51KQIjNzAnOrn5hRALApS1B0vNy
 afo3iBSgkZC3A83u7gVQH+d7LOUc94MYoAHvkD5ag2bfSOPRD8VeoD/g8tAcDfoj6OlA
 x6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689024451; x=1691616451;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FlZDtAUxorZUjAFvFdKBgpsVq2UqX+aQYXVngrJMv7w=;
 b=LoxIqYRBYOlnIZMwSMmulzis+Ej9clDnSKGenUtVErwP2P7Kbd6Rxe77JYFUDU0JJP
 /1Y2Oich8h8tSZirAYOx8JGwoF+s03icwQ7jqAcNgzLix8du7DHExLybn8zNcI45rEEU
 d/x3OK2SzJClDElNq8CGqxFYVy8WgL/11cZSytduZIoVvGO4JtpsyB7HtQtHZ2PAE3Y4
 cea4/yqTzbifKlj8JvY2pW13Sz7s0HPixQYyftGoeWQpEcM25tePPxeibhwBrcX19c6i
 kEmZCHDM9zWhZvekMWc0GNKfHPSiFNgDtTJVKjzbSpAXnKtz6M2b8IveO8WEXrNv/Rqb
 RrvQ==
X-Gm-Message-State: ABy/qLY+hzizNV4GSwfH4CDRzMpmiH1Qs9O++p4ayTtmlMIzMsd7MZ74
 ZibLkQcQq44IQpV/0lONPeXvSibxuVk=
X-Google-Smtp-Source: APBJJlHxREfTNXCL5tMVdfSHARVm6ClnGX+f/pU4jZmxWQLPejNrxN/zJDylBCD8KCurnLzEdZZyTA==
X-Received: by 2002:a1c:e915:0:b0:3fb:b5dc:dab1 with SMTP id
 q21-20020a1ce915000000b003fbb5dcdab1mr11327651wmc.39.1689024450438; 
 Mon, 10 Jul 2023 14:27:30 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-013-218-005.77.13.pool.telefonica.de.
 [77.13.218.5]) by smtp.gmail.com with ESMTPSA id
 x10-20020a05600c21ca00b003fa96fe2bebsm770780wmj.41.2023.07.10.14.27.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 14:27:29 -0700 (PDT)
Date: Mon, 10 Jul 2023 21:27:22 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v3 0/7] VIA and general PCI IDE cleanup
In-Reply-To: <20230531211043.41724-1-shentey@gmail.com>
References: <20230531211043.41724-1-shentey@gmail.com>
Message-ID: <C8104E7E-5DCD-473F-A3E3-AA8773B6B97C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x332.google.com
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



Am 31=2E Mai 2023 21:10:36 UTC schrieb Bernhard Beschow <shentey@gmail=2Ec=
om>:
>This series is split off from a more general PCI IDE refactoring aiming f=
or a
>
>common implementation of the PCI IDE controller specification for all
>
>TYPE_PCI_IDE models [1]=2E
>
>
>
>The first three patches resolve a circular dependency between the VIA IDE=

>
>controller and its south bridge=2E The next three patches resolves redund=
ant code
>
>accross all TYPE_PCI_IDE models=2E The last patch modernizes VM state set=
up in
>
>PIIX IDE=2E
>
>
>
>Testing done:
>
>* `make check`
>
>* `make check-avocado`
>
>* `qemu-system-ppc -machine pegasos2 -rtc base=3Dlocaltime -device \
>
>   ati-vga,guest_hwcursor=3Dtrue,romfile=3D"" -cdrom morphos-3=2E17=2Eiso=
 \
>
>   -bios pegasos2=2Erom`
>
>   The machine booted successfully and a startup sound was hearable
>
>* `qemu-system-ppc -machine sam460ex -rtc base=3Dlocaltime -drive \
>
>   if=3Dnone,id=3Dcd,file=3Dmorphos-3=2E17=2Eiso,format=3Draw -device \
>
>   ide-cd,drive=3Dcd,bus=3Dide=2E1`
>
>   The machine booted successfully into graphical desktop environment
>
>
>
>v3:
>
>* Fix formatting (Mark) =2E=2E=2E and split into two commits (Bernhard)
>
>
>
>v2:
>
>* Add missing Signed-off-by tag to last commit (Zoltan)
>
>
>
>Changes since [1]:
>
>* Turn legacy IRQs into named GPIOs (Mark)
>
>* Don't make VIA IDE legacy IRQs routable; just wire up in host device (Z=
oltan)
>
>* Rename extracted bmdma_clear_status() (Zoltan)
>
>   =2E=2E=2E to bmdma_status_writeb() (Mark)
>
>
>
>[1] https://lore=2Ekernel=2Eorg/qemu-devel/20230422150728=2E176512-1-shen=
tey@gmail=2Ecom/
>
>
>
>Bernhard Beschow (7):
>
>  hw/ide/pci: Expose legacy interrupts as named GPIOs
>
>  hw/ide/via: Wire up IDE legacy interrupts in host device
>
>  hw/isa/vt82c686: Remove via_isa_set_irq()
>
>  hw/ide: Extract IDEBus assignment into bmdma_init()
>
>  hw/ide: Extract bmdma_status_writeb()
>
>  hw/ide/pci: Replace some magic numbers by constants
>
>  hw/ide/piix: Move registration of VMStateDescription to DeviceClass
>

Ping

AFAICS all patches are reviewed=2E

Best regards,
Bernhard

>
>
> include/hw/ide/pci=2Eh      |  1 +
>
> include/hw/isa/vt82c686=2Eh |  2 --
>
> hw/ide/cmd646=2Ec           |  3 +--
>
> hw/ide/pci=2Ec              | 16 ++++++++++++++++
>
> hw/ide/piix=2Ec             |  8 +++-----
>
> hw/ide/sii3112=2Ec          |  7 ++-----
>
> hw/ide/via=2Ec              |  9 +++++----
>
> hw/isa/vt82c686=2Ec         | 11 +++++------
>
> 8 files changed, 33 insertions(+), 24 deletions(-)
>
>
>
>-- >
>2=2E40=2E1
>
>
>

