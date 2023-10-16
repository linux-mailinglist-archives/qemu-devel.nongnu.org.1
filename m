Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D47457CA945
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 15:21:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsNVW-0006fX-BJ; Mon, 16 Oct 2023 09:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qsNVR-0006ew-Au; Mon, 16 Oct 2023 09:19:40 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qsNVO-0006qG-G2; Mon, 16 Oct 2023 09:19:36 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9b2f73e3af3so690808466b.3; 
 Mon, 16 Oct 2023 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697462370; x=1698067170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1NtygoMGShG03+7F+vNNvcY4BNPD4eJf9sQgvEQvuxQ=;
 b=am9Xbl7Jmjdv59/szJ+o1jXGopZvJnOIY9+M8Rgnls2OHDNFk3lAJ7QmQ/w3miXiaz
 nlkvJpyq9A5WqMoC86hArfZ7FVNMCk1opgN+vpQ+Udp0RVsVoMMmlt87ao/7ssH/18Ml
 7szQxcrVLrh1hy5RSL3uBmR2nE5khL7VQVH6mGv1zUcnE50TDMmdKnJCVfw9Dj1g6wn+
 BVi5W7qaPHZwmLuqwehkBuYlriZkiQiCajCU0waa1TP28T+1o5rqExfJjNPF94gcmZ0A
 Ow+xmyGPamG9/fMzLrufgkl89dvMhmcLZONo0BEaPo6n8l2n8NmFfDrQxcWybMvABg9s
 tpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697462370; x=1698067170;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1NtygoMGShG03+7F+vNNvcY4BNPD4eJf9sQgvEQvuxQ=;
 b=D1VEgpeWDenMfzM4IYLV7mYLjwLa86rUiC+CEX9qnqv6BWZSdjLY/r7w6N4nZ3N8VX
 PNVuE2+1BefpLsAsaLWzzGc6dpoQykYjVTXNO41Op0eF9u0vj4sdxDAU9Wn/MbHNMp4d
 HCEOs2n2tOABas3Toe9wXJjeudZECujKcuNyG0omMh5Nhq1YUKoFZIDgtSc4dsnVtL9K
 PTyukLZe5F5H3rH2oeA9AW1RL1bfuzV3eCSzhoj9Zjn+OUPodu4oXgu01PxZTC1joWmm
 qJ8VdILpmM/PNi4kiuC/pOkF/G6IJXRQBasB1Lr+ZtHIzKGTwos9PiWcG+28Gzg65+NT
 h7dg==
X-Gm-Message-State: AOJu0YxyNvKsA1UAAtHJ0jsEEcdfZd6k2vLmezYihyQio4bIsayjBKOb
 wIDVaPEwikW4r0kz2t90pOutL0GV1ME=
X-Google-Smtp-Source: AGHT+IHRoofer0DfJ6niFG+oOH5ymrJpOc25bpcT8NxsRbiK7XKsDu4p138Io33JRpEvYeUlWAngXg==
X-Received: by 2002:a17:907:9726:b0:9be:6050:7f1b with SMTP id
 jg38-20020a170907972600b009be60507f1bmr5997170ejc.0.1697462370360; 
 Mon, 16 Oct 2023 06:19:30 -0700 (PDT)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 ks13-20020a170906f84d00b009b8a4f9f20esm4034589ejb.102.2023.10.16.06.19.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 06:19:29 -0700 (PDT)
Date: Mon, 16 Oct 2023 10:27:07 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/4=5D_hw/isa/lpc=5Fich9=3A_Access_m?=
 =?US-ASCII?Q?emory_regions_via_pci=5Faddress=5Fspace=5B=5Fio=5D=28=29?=
In-Reply-To: <20231011185954.10337-3-philmd@linaro.org>
References: <20231011185954.10337-1-philmd@linaro.org>
 <20231011185954.10337-3-philmd@linaro.org>
Message-ID: <01932207-10B6-4061-AB32-711BF1DD2D57@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
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



Am 11=2E Oktober 2023 18:59:52 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>PCI functions are plugged on a PCI bus=2E They can only access
>external memory regions via the bus=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>

With `info mtree` and `info mtree -f` in the QEMU console before and after=
 this patch I get the same results for `qemu-system-x86_64 -M q35 -S`=2E So=
:

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>---
> hw/isa/lpc_ich9=2Ec | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/hw/isa/lpc_ich9=2Ec b/hw/isa/lpc_ich9=2Ec
>index 3f59980aa0=2E=2E213b667f9b 100644
>--- a/hw/isa/lpc_ich9=2Ec
>+++ b/hw/isa/lpc_ich9=2Ec
>@@ -707,8 +707,8 @@ static void ich9_lpc_realize(PCIDevice *d, Error **er=
rp)
>         return;
>     }
>=20
>-    isa_bus =3D isa_bus_new(DEVICE(d), get_system_memory(), get_system_i=
o(),
>-                          errp);
>+    isa_bus =3D isa_bus_new(DEVICE(d), pci_address_space(d),
>+                          pci_address_space_io(d), errp);
>     if (!isa_bus) {
>         return;
>     }

