Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A09FC74F83C
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 21:06:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJIf2-0003pT-IN; Tue, 11 Jul 2023 15:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qJIer-0003oX-E7; Tue, 11 Jul 2023 15:04:24 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qJIep-0004G3-PJ; Tue, 11 Jul 2023 15:04:21 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3094910b150so6657193f8f.0; 
 Tue, 11 Jul 2023 12:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689102257; x=1691694257;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KcBlim7/rHIHA+sriYjBeQZC/USVo9EUaR6qmWUn6kw=;
 b=NZOorcZlrMNAqfgcqYy2AvKOgJKyAWL6r7zIaACNJYDIS2eo/Equc8z89VUeyVkJmr
 vDeD3ZXhRAVhjAQO9WhZ/Nhyx/s1Ke26WPT2qX7twfEhCSs8VQ4uuydal0k2ijewMFo4
 F67IJZYzokeMXyd3nKlYiIbhEqdONhrQ6HHWO1kdkN3H07pQtukJwVryOf4VQIKWFrN+
 cEw4CG0HM0P8d+t51yNg2uPp4JzW9bx+0rft470wmUv/yuPqsOl9FIOdjIzQYimHpQeA
 tj2jS/v6Gd2y+MXm+i7aUzgKst/r9s5rIFKd6eJiK2au3GgAoqt6NOLsTQmmqHv0IVq7
 9HIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689102257; x=1691694257;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KcBlim7/rHIHA+sriYjBeQZC/USVo9EUaR6qmWUn6kw=;
 b=AePeymwOu+txsEOiQdYPTcdlALyZfRETQ1MbA0CuoVJsTvEXnj+tC+emti+rmXF6yI
 ruYM9isk2MzrF7vT4c7l8cirG0izM58JlcdSD8U/Fjut69ylWrfrbQQFJ3VeMwdXhm7I
 jlE1o/HC06Q54gsXzTSItj5h9vWACjcpKynDV6Yi68Vf4zMNAkKMES8yjNbYDHxZY57h
 EfXVesIWuTOlsyhJ/KiaLLmcfULheMUlKbkatsydeG9lu3RDelr7ANTPMxChueqyRU8E
 bjef3E50dBO4B9Yo37IV2f/coFAmravM4jhfd73gK/mjujs8ZK9MBtG/yWDrnTjLcTsK
 JgBg==
X-Gm-Message-State: ABy/qLYkzlExpVF9QZFg9vy9oVQTJE2gxk50FCC9JJzOaNuzp/AsV3AW
 X3VStD8/Kd1gflWVPmtCpRTmW507LTM=
X-Google-Smtp-Source: APBJJlHv7Fsb8SA13pLYFv6Pq7Q9BCL/s45a96FO8I2nQ6XUsm0EMAU1Y0cs9mj978EUHGXrKqoLdA==
X-Received: by 2002:a5d:4d8e:0:b0:314:3e77:f210 with SMTP id
 b14-20020a5d4d8e000000b003143e77f210mr15619308wru.59.1689102257095; 
 Tue, 11 Jul 2023 12:04:17 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-077-090.77.11.pool.telefonica.de.
 [77.11.77.90]) by smtp.gmail.com with ESMTPSA id
 a15-20020a5d508f000000b0031437299fafsm3014440wrt.34.2023.07.11.12.04.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 12:04:16 -0700 (PDT)
Date: Tue, 11 Jul 2023 19:04:06 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Olaf Hering <olaf@aepfle.de>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Lev Kujawski <lkujaw@member.fsf.org>,
 qemu-block@nongnu.org
CC: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2] hw/ide/piix: properly initialize the BMIBA register
In-Reply-To: <20230701174659.10246-1-olaf@aepfle.de>
References: <20230701174659.10246-1-olaf@aepfle.de>
Message-ID: <4C8D2CE7-89BE-4BF5-9551-E1684573A61A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42b.google.com
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



Am 1=2E Juli 2023 17:46:59 UTC schrieb Olaf Hering <olaf@aepfle=2Ede>:
>According to the 82371FB documentation (82371FB=2Epdf, 2=2E3=2E9=2E BMIBA=
=E2=80=94BUS
>MASTER INTERFACE BASE ADDRESS REGISTER, April 1997), the register is
>32bit wide=2E To properly reset it to default values, all 32bit need to b=
e
>cleared=2E Bit #0 "Resource Type Indicator (RTE)" needs to be enabled=2E
>
>The initial change wrote just the lower 8 bit, leaving parts of the "Bus
>Master Interface Base Address" address at bit 15:4 unchanged=2E

For v3 you could cut the following paragraphs from this commit message =2E=
=2E=2E

>
>This bug went unnoticed until commit ee358e919e38 ("hw/ide/piix: Convert
>reset handler to DeviceReset")=2E After this change, piix_ide_reset is
>exercised after the "unplug" command from a Xen HVM domU, which was not
>the case prior that commit=2E This function resets the command register=
=2E
>As a result the ata_piix driver inside the domU will see a disabled PCI
>device=2E The generic PCI code will reenable the PCI device=2E On the qem=
u
>side, this runs pci_default_write_config/pci_update_mappings=2E Here a
>changed address is returned by pci_bar_address, this is the address
>which was truncated in piix_ide_reset=2E In case of a Xen HVM domU, the
>address changes from 0xc120 to 0xc100=2E
>
>While the unplug is supposed to hide the IDE disks, the changed BMIBA
>address breaks the UHCI device=2E In case the domU has an USB tablet
>configured, to recive absolute pointer coordinates for the GUI, it will
>cause a hang during device discovery of the partly discovered USB hid
>device=2E Reading the USBSTS word size register will fail=2E The access e=
nds
>up in the QEMU piix-bmdma device, instead of the expected uhci device=2E
>Here a byte size request is expected, and a value of ~0 is returned=2E As
>a result the UCHI driver sees an error state in the register, and turns
>off the UHCI controller=2E

=2E=2E=2E until here and paste them into the patch with the Xen fix=2E

>
>Fixes: e6a71ae327 ("Add support for 82371FB (Step A1) and Improved suppor=
t for 82371SB (Function 1)")
>
>Signed-off-by: Olaf Hering <olaf@aepfle=2Ede>

With the changed commit message:

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>---
> hw/ide/piix=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/ide/piix=2Ec b/hw/ide/piix=2Ec
>index 41d60921e3=2E=2E1e346b1b1d 100644
>--- a/hw/ide/piix=2Ec
>+++ b/hw/ide/piix=2Ec
>@@ -118,7 +118,7 @@ static void piix_ide_reset(DeviceState *dev)
>     pci_set_word(pci_conf + PCI_COMMAND, 0x0000);
>     pci_set_word(pci_conf + PCI_STATUS,
>                  PCI_STATUS_DEVSEL_MEDIUM | PCI_STATUS_FAST_BACK);
>-    pci_set_byte(pci_conf + 0x20, 0x01);  /* BMIBA: 20-23h */
>+    pci_set_long(pci_conf + 0x20, 0x01);  /* BMIBA: 20-23h */
> }
>=20
> static bool pci_piix_init_bus(PCIIDEState *d, unsigned i, Error **errp)
>
>base-commit: d145c0da22cde391d8c6672d33146ce306e8bf75
>

