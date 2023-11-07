Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3F17E4A19
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 21:50:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Szg-0006QB-Ti; Tue, 07 Nov 2023 15:48:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Sze-0006Pv-KY; Tue, 07 Nov 2023 15:48:14 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Szc-0006Ql-Ra; Tue, 07 Nov 2023 15:48:14 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6cd0963c61cso3251212a34.0; 
 Tue, 07 Nov 2023 12:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699390091; x=1699994891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dd5uQ+1StPym0GB9J4OEAuTH56+RlOVWdfidX+e0R5M=;
 b=Qnr8HgyNk1gA2ierxmKVB5myK9r9dcj3jHUeLkTZWKI2664tsFOt0OcBtFVcrJQweS
 DRz6qt2qtylkYj1rQOtTsSu2Pn0xb9GzzU7aImI7VRWseuAVXGoTBZZ7muWtzzcSb55n
 kQo4WcvCQU7JcvQofbwz76qHldNw7iyhYuvU7JW3QVw/Yq1OArOupGiKNR38aLv5sLUH
 SC8UqFbSdYzC7TOpdjfozI0g5AqecNQfKNVwsDLaRN79CxsJ9iEN3ff4NCZ2/kCQgj93
 +pqN/wAfx6mHLHnr/48685J9xiCEVo9DUnCe900RHpb17HmIc1C1tv31Tfn02W6i1+cm
 MbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699390091; x=1699994891;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dd5uQ+1StPym0GB9J4OEAuTH56+RlOVWdfidX+e0R5M=;
 b=J+aRxqdsbyLORARtVuZuyOEMbjnKfuNTyw0P156WzSR0d+lhPXgH5Ft9Jew54ixc9I
 9LpmwZJmByWrBM/6fxJhQmfxh/3WvJxf2uS5EobFAxgf7kwK1bCxD4bGfZV/15rwAT4E
 8IxL9dgM1E/niF2rJsODCQT2d+Fx/HfDqaIymlMcXnT4oy2AzrOiPpKJsI+6v2K+/a0P
 vVDGWbdgClKafcR3zj8FNbV0DjObW65VRwlyYYaeZynXoccVaN8SMB6s53eRqBvgqKkz
 uConQdEqIXJsz+YrmiBxZRlu8cLsGYGLrHN5LFaqEX6JOM4aQz9JiqpXu5+mnL0oeAgt
 t9dg==
X-Gm-Message-State: AOJu0YxIkU/LOtLrrxUI87lh3P7O04/q6/bOVswt3LnWCztgfJkDPxN2
 RAQ79y0oNjja/d2T7vlh3f3FhfsIAO4=
X-Google-Smtp-Source: AGHT+IHgyLIreTFA4gurcwRSY7k630mYT8cfgeZvDe+zJwa+JvZDVgX+Xv0LcexY9pLoJHSi3z/v4w==
X-Received: by 2002:a05:6830:1402:b0:6d3:2584:b093 with SMTP id
 v2-20020a056830140200b006d32584b093mr15497891otp.11.1699390090887; 
 Tue, 07 Nov 2023 12:48:10 -0800 (PST)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 d13-20020ac8544d000000b0041eb13a8195sm48946qtq.61.2023.11.07.12.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 12:48:10 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	danielhb413@gmail.com,
	peter.maydell@linaro.org
Subject: [PULL 0/9] ppc queue
Date: Tue,  7 Nov 2023 17:47:57 -0300
Message-ID: <20231107204806.8507-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The following changes since commit 462ad017ed76889d46696a3581e1b52343f9b683:

  Merge tag 'pixman-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2023-11-07 19:00:03 +0800)

are available in the Git repository at:

  https://gitlab.com/danielhb/qemu.git tags/pull-ppc-20231107

for you to fetch changes up to 5bf4ceec109289356f50f69bf277c99b045182e7:

  ppc: qtest already exports qtest_rtas_call() (2023-11-07 15:49:41 -0300)

----------------------------------------------------------------
ppc patch queue for 2023-11-07:

This queue, the last one before the 8.2 feature freeze, has miscellanous
changes that includes new PowerNV features and the new AmigaONE XE
board.

----------------------------------------------------------------
BALATON Zoltan (3):
      hw/pci-host: Add emulation of Mai Logic Articia S
      hw/ppc: Add emulation of AmigaOne XE board
      tests/avocado: Add test for amigaone board

Cédric Le Goater (2):
      ppc/pnv: Add an I2C controller model
      ppc/pnv: Connect I2C controller model to powernv9 chip

Glenn Miles (2):
      ppc/pnv: Connect PNV I2C controller to powernv10
      ppc/pnv: Fix number of I2C engines and ports for power9/10

Juan Quintela (1):
      ppc: qtest already exports qtest_rtas_call()

Saif Abrar (1):
      hw/pci-host: Update PHB5 XSCOM registers

 MAINTAINERS                             |   8 +
 configs/devices/ppc-softmmu/default.mak |   1 +
 hw/pci-host/Kconfig                     |   5 +
 hw/pci-host/articia.c                   | 293 ++++++++++++++
 hw/pci-host/meson.build                 |   2 +
 hw/pci-host/pnv_phb4.c                  |  46 ++-
 hw/pci-host/pnv_phb4_pec.c              |  33 +-
 hw/ppc/Kconfig                          |   7 +
 hw/ppc/amigaone.c                       | 166 ++++++++
 hw/ppc/meson.build                      |   3 +
 hw/ppc/pnv.c                            |  61 +++
 hw/ppc/pnv_i2c.c                        | 697 ++++++++++++++++++++++++++++++++
 hw/ppc/spapr_rtas.c                     |   5 +-
 include/hw/pci-host/articia.h           |  17 +
 include/hw/pci-host/pnv_phb4.h          |   2 +-
 include/hw/pci-host/pnv_phb4_regs.h     |   4 +-
 include/hw/ppc/pnv_chip.h               |  10 +
 include/hw/ppc/pnv_i2c.h                |  38 ++
 include/hw/ppc/pnv_xscom.h              |   6 +
 include/hw/ppc/spapr_rtas.h             |  10 -
 tests/avocado/ppc_amiga.py              |  38 ++
 21 files changed, 1414 insertions(+), 38 deletions(-)
 create mode 100644 hw/pci-host/articia.c
 create mode 100644 hw/ppc/amigaone.c
 create mode 100644 hw/ppc/pnv_i2c.c
 create mode 100644 include/hw/pci-host/articia.h
 create mode 100644 include/hw/ppc/pnv_i2c.h
 delete mode 100644 include/hw/ppc/spapr_rtas.h
 create mode 100644 tests/avocado/ppc_amiga.py

