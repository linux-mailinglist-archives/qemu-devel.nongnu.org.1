Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A6570AD8E
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 13:16:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0h2S-0000WO-OE; Sun, 21 May 2023 07:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0h2Q-0000VN-GD; Sun, 21 May 2023 07:15:46 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0h2O-0004jR-NV; Sun, 21 May 2023 07:15:46 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-510f525e06cso4923246a12.2; 
 Sun, 21 May 2023 04:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684667742; x=1687259742;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MV+iuENOUYweizG4m2f0iUWA/6WAQ9Xj4f7dtsvrJXs=;
 b=PRZEP55DiHWg5XtWRXaYNeHZ8AXAMqt/k3eCozl9hW37Z1IjfKED6ia+ExjHJtqoMY
 YNkTMlcc5VL0gvxswNgkjNpKwbgO7X0hx6/IaFTFylenYiDMXcHI7joLcLR6a4NnHc4s
 n9zh04enlSeOPCi9e0oMoAksG1fgvD33W0Z2X6b5HNkFciqobyBKdKT+I1zjpU7xW64S
 fMwiqppeAh83rzcn7GieJTwpK91NuHEPBVu1ynLD0TFDHzawWZ1zSj/ozQVCirHZfJjL
 ehDQySAiro7fvTFZgNGYY92kT03I8gHBc1ZEbHzHgVAuu0k33x2Uf09FW2B6MvfQYara
 1Wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684667742; x=1687259742;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MV+iuENOUYweizG4m2f0iUWA/6WAQ9Xj4f7dtsvrJXs=;
 b=JWdRIOMPAoclbfgD1ZImdhnWRqFCGbI6m5ykfRz4Wo7tF1Y6Jc8YOAkjB53Gay+4yn
 HtnuzsbNIw3VrbaF8czqs99Qs/BKdfrha/RDSBwMS+F3jOXfKQc6kEb21gF8JErRvdJ8
 UBcPsJOVevB54im9ZJbM2hIKin7SfIuq/L7GO9cSe2gXrE07pyvNURzobDKFiffKWQQT
 RewtohGTGOwny/1aKOOfXNDDX42jqlBTl/hyfoy/kL8++KpOjVgkjOXT1h6Gho+dBkg4
 32HC1m9SDRDUWApTWi8gSjGrWEkjV/UBKqY2GQUFPDJorfk98VOxsIe1O/koFZObp842
 BdtQ==
X-Gm-Message-State: AC+VfDy7jdrq1IZCOPpPQL0BHHt27VUQh0qWBRC5ykEUwZ5noSFsnNOu
 Gp799cQK1fe4D1zMt9GRVwnvkmDArSs=
X-Google-Smtp-Source: ACHHUZ6WS7hXpQZnBpNAygOgC01rUZodBlf9H86P/m6R5vjO3SIF29wh9UyzT4yDhVtQeZIOLGBiAg==
X-Received: by 2002:aa7:c6c8:0:b0:50b:c46a:13be with SMTP id
 b8-20020aa7c6c8000000b0050bc46a13bemr6116859eds.22.1684667742018; 
 Sun, 21 May 2023 04:15:42 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-191-145-122.77.191.pool.telefonica.de. [77.191.145.122])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a056402124500b0050dfb9fc499sm1757123edw.39.2023.05.21.04.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 May 2023 04:15:41 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-ppc@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/6] VIA and general PCI IDE cleanup
Date: Sun, 21 May 2023 13:15:28 +0200
Message-Id: <20230521111534.207973-1-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
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

