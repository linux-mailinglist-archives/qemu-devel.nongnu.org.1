Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A2E7452EB
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 00:20:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qG5PI-0005sq-Hk; Sun, 02 Jul 2023 18:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qG5PH-0005sY-2M; Sun, 02 Jul 2023 18:18:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qG5PF-0005pH-9f; Sun, 02 Jul 2023 18:18:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbc587febfso28901215e9.2; 
 Sun, 02 Jul 2023 15:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688336334; x=1690928334;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Byf1QIvnLqs4ImnE4xPG/UN5uHfe7uyZziuSgPKkROI=;
 b=p7/M26mEBOxDXzJIwmuVdzdFSrgSVBRYuT0lKyYAR4xuge5hmgj1xPFxoWld3fv9iS
 PxBOTTI6CWCmISMABaDeJP+YxmoT3y9kfmSNnmTROFq9nshb2tVgoTObCm1pcwKIAsIK
 fUHTlc6MsJgax/ZwmGmOA5YGiz3USAIKS3uTC3tQ7Do6/HjmXTFLKGIp/KYV4a8pNZs1
 BVMQXiKWRbNRIukY/M62LzS5jzViTj3FKLRPUzZRViercBEqnjNswBA84mIZoGqq0WsS
 VcpKb/MdYgXpuwylA+72Nfh9YmNU7g4hh1o/OAmM/epJ/bHNxrY+h6r+MJvTuPxHdfvw
 qEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688336334; x=1690928334;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Byf1QIvnLqs4ImnE4xPG/UN5uHfe7uyZziuSgPKkROI=;
 b=I/Tcxln1nf8K6xIWPBLgArQ9gu0bybmZbhyasOz6Xzl4UFDUwjkbOt8CCs4N9fGe0+
 hentOy4KNUv6aO4h0a+tspXmDYjNhw8kOurAPWm2hWKeN7rmjMDgPiHYYpxAaJQAVkik
 u9Sar9EQpoEuBKySdAnauEDSyQEgntNFmBRYXumhAuAXeOGwfOzMsKkfVn04iS6BKAG+
 3PUadx3LIieRRqbuguzepfUDRA+s5KukUB8+IG2Q7wdq22ns0YvsZQ4/gP4i/ZO2a8WX
 RM9Bu8Zc3PeE6mYqPu8//PBsyRezPSSAn+omjFeu1965nV6uAHOlYbX2drQPsUK9utYk
 Qhcg==
X-Gm-Message-State: AC+VfDyUMkMnTgooLaJ0fqtg6RC909FpUqDh0Z6On0aOvGcMwoMMlqN+
 qLe3Z82jntEK8Gq7WcQ5uUPWlM7BSIw=
X-Google-Smtp-Source: ACHHUZ4jOg1kAnyQYzPuRaCDqnADrsS0iNDZxsBVeN/wMQq1cx3B8Jwox+NSir9mmWXTZCy6Kbl3VA==
X-Received: by 2002:a1c:4c10:0:b0:3fa:991c:2af9 with SMTP id
 z16-20020a1c4c10000000b003fa991c2af9mr6177831wmf.16.1688336334190; 
 Sun, 02 Jul 2023 15:18:54 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-014-031-053.89.14.pool.telefonica.de.
 [89.14.31.53]) by smtp.gmail.com with ESMTPSA id
 l21-20020a7bc455000000b003fbd09d1d9fsm4748646wmi.10.2023.07.02.15.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Jul 2023 15:18:53 -0700 (PDT)
Date: Sun, 02 Jul 2023 22:18:50 +0000
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
Message-ID: <62EDA748-11A3-473F-913D-F9464335A382@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
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
>
>This bug went unnoticed until commit ee358e919e38 ("hw/ide/piix: Convert
>reset handler to DeviceReset")=2E After this change, piix_ide_reset is
>exercised after the "unplug" command from a Xen HVM domU,=20

Do you know if that command calls pci_device_reset() (which would eventual=
ly call piix_ide_reset())? Or does it call the DeviceReset handler directly=
? I'm asking because pci_device_reset() would take care of resetting the BM=
IBA register as well as disabling the BAR=2E IOW I'm wondering if the Xen c=
ommand does the right thing=2E

Best regards,
Bernhard

>which was not
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
>
>Fixes: e6a71ae327 ("Add support for 82371FB (Step A1) and Improved suppor=
t for 82371SB (Function 1)")
>
>Signed-off-by: Olaf Hering <olaf@aepfle=2Ede>
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

