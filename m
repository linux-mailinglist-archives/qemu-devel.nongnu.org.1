Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFED970E5FE
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 21:51:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Y15-00016S-Ic; Tue, 23 May 2023 15:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q1Y11-00012t-Cc; Tue, 23 May 2023 15:49:51 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q1Y0w-000479-O6; Tue, 23 May 2023 15:49:51 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-510f525e06cso494352a12.2; 
 Tue, 23 May 2023 12:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684871380; x=1687463380;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sq7yoCatQGYHCdXcNcY+Ff45Ajyyj/4gyrQIJWuuamQ=;
 b=psEU2CyBxFMUwRX9WTdQC/OipgofWeYyYYIvtVdNIIrAStIHVXK0ci9+E1y/2ut9of
 ogWgbgAat2SVqWfQ7uhhqBBqwVYEy1zn7V1sgdfLAcQdGg4ANDQ3UWsZAKQyZOgmRLjS
 t3zwDf5lNL2Aca+jfz/QgGc8PaiyzD5dDQwC79D3KV09hx/dtVawbTxB09QfB0anO2Vk
 U3RNCosWFusWABokGpfLfUizUyDOhX1m8ORp6ZE4JTlm00rQS37yFW0x1DqnDsTEocQT
 /FcShNOkJDZ+7ad88UkfMDoQ+5EPXyMm5mtodLyixhNyM8zrn9T3jpF4/jWy/GysiFHG
 H1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684871380; x=1687463380;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sq7yoCatQGYHCdXcNcY+Ff45Ajyyj/4gyrQIJWuuamQ=;
 b=TlOys0pacUyfMcaw18RLFcSF+GSg2G1+eKNUCnF2jOY0drqtQdNtp3aRS6YnShnkxs
 Fpj6lRKtvH9YilLX+spqXHMOflH0vMVwJIUXOYpXmDAMIUn/V9bYQUdFMEcNzSJPTUWd
 kyg8FS8VVPPL2fVsP6bkshwNhvA8zbw+Z4CJCozP0aIKz5h5lrdAgJftKSv5V1TJYxWE
 S6AgizM2cYbq3S3wHvvmpbC7QbkSb21nqXeqeRKqJriXGgKxoSpOYI3IZUerp5Xe+Msd
 yVsjkQQLrhlHYmhPVNGu2uXPVY4O0Jz1TIY98PPe3OZbUkEjv4cj+nsBbV+Y+qX0JKaD
 d5tg==
X-Gm-Message-State: AC+VfDyMQwnUySAnAyexnmmskF0O978ZRn0tL3dWOfRT88NQVmnWJnUt
 cb0RPJ+GklUWVdEdne0Kqt5G0uqeI5U=
X-Google-Smtp-Source: ACHHUZ6HLSoW9rxHBskooRu9YDKTBO3eFh49a++qfFO/BvgWJJEzVR66XLHIUqgmBmohwJwbdtQSHg==
X-Received: by 2002:a17:906:9745:b0:96a:1ec1:2c9f with SMTP id
 o5-20020a170906974500b0096a1ec12c9fmr17021225ejy.12.1684871379687; 
 Tue, 23 May 2023 12:49:39 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-183-025-113.77.183.pool.telefonica.de. [77.183.25.113])
 by smtp.gmail.com with ESMTPSA id
 k17-20020a1709063e1100b0096f641a4c01sm4800593eji.179.2023.05.23.12.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 12:49:39 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, John Snow <jsnow@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 0/6] VIA and general PCI IDE cleanup
Date: Tue, 23 May 2023 21:49:24 +0200
Message-Id: <20230523194930.124352-1-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x536.google.com
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

This series is split off from a more general PCI IDE refactoring aiming for=
 a=0D
common implementation of the PCI IDE controller specification for all=0D
TYPE_PCI_IDE models [1].=0D
=0D
The first three patches resolve a circular dependency between the VIA IDE=0D
controller and its south bridge. The next two patches resolves redundant co=
de=0D
accross all TYPE_PCI_IDE models. The last patch modernizes VM state setup i=
n=0D
PIIX IDE.=0D
=0D
Testing done:=0D
* `make check`=0D
* `make check-avocado`=0D
* `qemu-system-ppc -machine pegasos2 -rtc base=3Dlocaltime -device \=0D
   ati-vga,guest_hwcursor=3Dtrue,romfile=3D"" -cdrom morphos-3.17.iso \=0D
   -bios pegasos2.rom`=0D
   The machine booted successfully and a startup sound was hearable=0D
* `qemu-system-ppc -machine sam460ex -rtc base=3Dlocaltime -drive \=0D
   if=3Dnone,id=3Dcd,file=3Dmorphos-3.17.iso,format=3Draw -device \=0D
   ide-cd,drive=3Dcd,bus=3Dide.1`=0D
   The machine booted successfully into graphical desktop environment=0D
=0D
v2:=0D
* Add missing Signed-off-by tag to last commit (Zoltan)=0D
=0D
Changes since [1]:=0D
* Turn legacy IRQs into named GPIOs (Mark)=0D
* Don't make VIA IDE legacy IRQs routable; just wire up in host device (Zol=
tan)=0D
* Rename extracted bmdma_clear_status() (Zoltan)=0D
   ... to bmdma_status_writeb() (Mark)=0D
=0D
[1] https://lore.kernel.org/qemu-devel/20230422150728.176512-1-shentey@gmai=
l.com/=0D
=0D
Bernhard Beschow (6):=0D
  hw/ide/pci: Expose legacy interrupts as named GPIOs=0D
  hw/ide/via: Wire up IDE legacy interrupts in host device=0D
  hw/isa/vt82c686: Remove via_isa_set_irq()=0D
  hw/ide: Extract IDEBus assignment into bmdma_init()=0D
  hw/ide: Extract bmdma_status_writeb()=0D
  hw/ide/piix: Move registration of VMStateDescription to DeviceClass=0D
=0D
 include/hw/ide/pci.h      |  1 +=0D
 include/hw/isa/vt82c686.h |  2 --=0D
 hw/ide/cmd646.c           |  3 +--=0D
 hw/ide/pci.c              | 15 +++++++++++++++=0D
 hw/ide/piix.c             |  8 +++-----=0D
 hw/ide/sii3112.c          |  7 ++-----=0D
 hw/ide/via.c              |  9 +++++----=0D
 hw/isa/vt82c686.c         | 11 +++++------=0D
 8 files changed, 32 insertions(+), 24 deletions(-)=0D
=0D
-- =0D
2.40.1=0D
=0D

