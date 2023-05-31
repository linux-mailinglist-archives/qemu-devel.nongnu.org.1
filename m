Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5F3718BA0
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 23:12:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4T5x-0006U9-KR; Wed, 31 May 2023 17:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q4T5v-0006SY-Ge; Wed, 31 May 2023 17:10:59 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q4T5s-0001EM-T8; Wed, 31 May 2023 17:10:59 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-96fd3a658eeso895161666b.1; 
 Wed, 31 May 2023 14:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685567453; x=1688159453;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GNNBIawrpJQpPPt94stF5HV/zSTG0DpkACbv7GW2ags=;
 b=ojuB4fm6fkGQ0gnXhuqUpqs0I3SW6DkoomcZglTnJyd0BfThmLCyI3eH1xuZZLa9sH
 ynCDsRgjJLwjQxrpCRyYqw4Ufqdg7w37V2up4R8s+pD6okrfl3UPHySDBymRTU3UTSRh
 UkyPrIb9f+pACGKq3iyXywXMJzGRkaOdG2z/sO29W1+LI1IrtTIKfCBlmVDU2qUdDOkw
 FuHBQyQ7jUeInGzg90JdaHGun1/d2BLIsXG58KYPGT60gEEJxSpXNxLGRzO7OnH9Uah8
 XTdk7vAJdQBmb9VBGWi8wkVOvqqgMa/Zv7sALy2yuPqcE/9zkgBZzd0fG+xEMhgeo2aq
 xN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685567453; x=1688159453;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GNNBIawrpJQpPPt94stF5HV/zSTG0DpkACbv7GW2ags=;
 b=CKgbAfvroUrXYkisjfPHwtje3T+CuFhjXu9jUhPj8zvRwX/b5wQz1+19E99ZComGFx
 BhVl2kJZzx8lu7F/FgVpBaj7XZ1Z0vbfpbkBWctt3cqzuarFRmZZYa7yyigz5FItfcYF
 ECjiEvOsNEaA21EEe/v11di51zWJyxYu5F0J1WS2Xmg0WkuVMNjdtBVqKN+kAlgPDtE4
 sRoVVOo79KfM9igiNJKqFf0unuyprXPRbattNFNLxGacM6sA3ZFx2Q6BSI1M88Llkr8J
 fPjIULP5mrimOTiMWyk5itSWA4sf6L5N0trl2do8jdhtwuQjpmzMkJ6MNuFGS3hQfwzh
 HQ5Q==
X-Gm-Message-State: AC+VfDz2uOH0yYiAcjF1fE2quBjhRs6O3Ucd9V4fter6CkSTWcu/RVSG
 uw9myCp/R2hDDWKu+MJ0LdL4OHWFfew=
X-Google-Smtp-Source: ACHHUZ46lqk3+YDJC7VxlcaLmWe6s/PMdei7a846o8nT0w34hDuVg38ZLKRw+AVRssOpCoJ5NhMi3w==
X-Received: by 2002:a17:907:5c2:b0:960:c5fe:a36a with SMTP id
 wg2-20020a17090705c200b00960c5fea36amr6318659ejb.61.1685567452537; 
 Wed, 31 May 2023 14:10:52 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-054-159-078.78.54.pool.telefonica.de. [78.54.159.78])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a1709064d4800b00965f31ff894sm9463054ejv.137.2023.05.31.14.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 14:10:52 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 0/7] VIA and general PCI IDE cleanup
Date: Wed, 31 May 2023 23:10:36 +0200
Message-Id: <20230531211043.41724-1-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
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
controller and its south bridge. The next three patches resolves redundant =
code=0D
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
v3:=0D
* Fix formatting (Mark) ... and split into two commits (Bernhard)=0D
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
Bernhard Beschow (7):=0D
  hw/ide/pci: Expose legacy interrupts as named GPIOs=0D
  hw/ide/via: Wire up IDE legacy interrupts in host device=0D
  hw/isa/vt82c686: Remove via_isa_set_irq()=0D
  hw/ide: Extract IDEBus assignment into bmdma_init()=0D
  hw/ide: Extract bmdma_status_writeb()=0D
  hw/ide/pci: Replace some magic numbers by constants=0D
  hw/ide/piix: Move registration of VMStateDescription to DeviceClass=0D
=0D
 include/hw/ide/pci.h      |  1 +=0D
 include/hw/isa/vt82c686.h |  2 --=0D
 hw/ide/cmd646.c           |  3 +--=0D
 hw/ide/pci.c              | 16 ++++++++++++++++=0D
 hw/ide/piix.c             |  8 +++-----=0D
 hw/ide/sii3112.c          |  7 ++-----=0D
 hw/ide/via.c              |  9 +++++----=0D
 hw/isa/vt82c686.c         | 11 +++++------=0D
 8 files changed, 33 insertions(+), 24 deletions(-)=0D
=0D
-- =0D
2.40.1=0D
=0D

