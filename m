Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E48857C9C5F
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 00:21:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs9Sp-0002XY-8M; Sun, 15 Oct 2023 18:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qs9So-0002X6-8x; Sun, 15 Oct 2023 18:19:58 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qs9Sm-0003qI-LV; Sun, 15 Oct 2023 18:19:58 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9a58dbd5daeso628895466b.2; 
 Sun, 15 Oct 2023 15:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697408393; x=1698013193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnvulNiEiErJQqKT3jXXye/cBnbPQDaPWR77snuCb7w=;
 b=KB9YEZn+wG99nhCrui2xrLBgzzt0AjW4kQ8u34+KJMJjrVz8HMWD7cHjXzhocyziwI
 JKRDLa0QEZIjYx3MGnMeIQokgc2zev9WD/+LPPkUA6iZB7Z62iMbo/7WEKuWV2KeODjt
 NPhVOOQt2vjaVvAk8WiEw8cEH156Sxg3MwIK8K5tCdLzv3phjB8mdPsO+x/3uh8VJB29
 OG4IpR1c0B/eytwBqqWQL3+BlCmfmYdowgNl4nCcffJkLUdY8Qlu/xi0TTbKq+E/v9YZ
 q9vU2bKeTiduOChgLfHizUMQi7rAWJD2rqkoOfQTiyyvoF3grunp9uz+149+HOjSXDPL
 mM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697408393; x=1698013193;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TnvulNiEiErJQqKT3jXXye/cBnbPQDaPWR77snuCb7w=;
 b=F8AFWi8p2sr5L1vZNt5u7rGvbVZMYnHbF43Q82/gJYPJ7uUq8b26zsu4BfQZ8EFpUm
 5VcmCes2UBNw4iwHPA5OuGzWV8q4KgpOClAPO3oTFVjBtKdqWqw3GckWvdAGL3tMD2jl
 hnumEB2Jdeq9B+sYa6iFHMNbqZGYxCVQlSsOCWgQV+Bw8I0Rqm0hn0Ulgn3JQgtIePns
 +vrv66zBk6ZNdIKthtzqUeW+VT3lcQo+WHQyIeaZ/77BOUA31Kz8Tiwb9w75D1THL4ac
 PihghoXLyb0GcVi1WAr7rsUk7rwhkBh2iLF/V7FuHjoZ8TepH13uB3lRv/zY6rXo0MZ7
 THFQ==
X-Gm-Message-State: AOJu0YzRf3pFyWY5b12MklbPatjYF/vR0Is026H04jsrnZHs8FNWQh3P
 TXaGdl4eP4he7xUwrZ17g/U5Iv9KdrQ=
X-Google-Smtp-Source: AGHT+IFr4bkrg7r88Q4wf/A0d72LDs4x5JWAR2Ceul14Okal64gp4aQXfDKPBM2iCOSJ7iwvqzJXoQ==
X-Received: by 2002:a17:907:7ba8:b0:9be:30c2:b8fd with SMTP id
 ne40-20020a1709077ba800b009be30c2b8fdmr6429244ejc.66.1697408393035; 
 Sun, 15 Oct 2023 15:19:53 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-078-055-006-021.78.55.pool.telefonica.de.
 [78.55.6.21]) by smtp.gmail.com with ESMTPSA id
 r15-20020a170906c28f00b009932337747esm2770869ejz.86.2023.10.15.15.19.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 15:19:52 -0700 (PDT)
Date: Sun, 15 Oct 2023 22:19:43 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/4=5D_hw/pci-host/bonito=3A_Access_?=
 =?US-ASCII?Q?memory_regions_via_pci=5Faddress=5Fspace=5B=5Fio=5D=28=29?=
In-Reply-To: <20231011185954.10337-4-philmd@linaro.org>
References: <20231011185954.10337-1-philmd@linaro.org>
 <20231011185954.10337-4-philmd@linaro.org>
Message-ID: <5FD62714-3C33-4A93-B7E3-F3523FCE69C1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
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



Am 11=2E Oktober 2023 18:59:53 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>PCI functions are plugged on a PCI bus=2E They can only access
>external memory regions via the bus=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>---
> hw/pci-host/bonito=2Ec | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/hw/pci-host/bonito=2Ec b/hw/pci-host/bonito=2Ec
>index ee6cb85e97=2E=2E50bde57862 100644
>--- a/hw/pci-host/bonito=2Ec
>+++ b/hw/pci-host/bonito=2Ec
>@@ -700,14 +700,14 @@ static void bonito_pci_realize(PCIDevice *dev, Erro=
r **errp)
>=20
>     /* Map PCI IO Space  0x1fd0 0000 - 0x1fd1 0000 */
>     memory_region_init_alias(&s->bonito_pciio, OBJECT(s), "isa_mmio",
>-                             get_system_io(), 0, BONITO_PCIIO_SIZE);
>+                             pci_address_space_io(dev), 0, BONITO_PCIIO_=
SIZE);
>     sysbus_init_mmio(sysbus, &s->bonito_pciio);
>     sysbus_mmio_map(sysbus, 5, BONITO_PCIIO_BASE);
>=20
>     /* add pci local io mapping */
>=20
>     memory_region_init_alias(&s->bonito_localio, OBJECT(s), "IOCS[0]",
>-                             get_system_io(), 0, 256 * KiB);
>+                             pci_address_space_io(dev), 0, 256 * KiB);
>     sysbus_init_mmio(sysbus, &s->bonito_localio);
>     sysbus_mmio_map(sysbus, 6, BONITO_DEV_BASE);
>     create_unimplemented_device("IOCS[1]", BONITO_DEV_BASE + 1 * 256 * K=
iB,
>@@ -719,7 +719,7 @@ static void bonito_pci_realize(PCIDevice *dev, Error =
**errp)
>=20
>     memory_region_init_alias(pcimem_alias, NULL, "pci=2Emem=2Ealias",
>                              &bs->pci_mem, 0, BONITO_PCIHI_SIZE);
>-    memory_region_add_subregion(get_system_memory(),
>+    memory_region_add_subregion(pci_address_space(dev),

I need to keep `get_system_memory()` here to get the same results for `inf=
o mtree` in the QEMU console before and after this patch when running `qemu=
-system-mips64el -M fuloong2e -S`=2E The other two changes above seem to wo=
rk as expected=2E

Best regards,
Bernhard

>                                 BONITO_PCIHI_BASE, pcimem_alias);
>     create_unimplemented_device("PCI_2",
>                                 (hwaddr)BONITO_PCIHI_BASE + BONITO_PCIHI=
_SIZE,

