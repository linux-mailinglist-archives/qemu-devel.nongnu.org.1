Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED21718E91
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 00:34:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4UO6-0001zI-BW; Wed, 31 May 2023 18:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UO4-0001vP-I0
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:33:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UO2-00050J-39
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:33:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f6d3f83d0cso1949875e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 15:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685572424; x=1688164424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=knDkPGiUsAKV4vjHj0yXucrmS51UBie64TABOaedj0Y=;
 b=O1yPop8fla84DddZQv5Kg+XTx1UYMGH3Sj/io/AgqjCI8syfnyjYbdJoVg7mre/1Ir
 qpoSnBtEqbVbtXdC4kisQmxxJ+ZXyTugBrbu+ihYMFrw0uyj1K8qImwRwhtCQq/d79vs
 cTTjvUDMnCt1/QijknQyT7bbwylogPT+AGaAre7kL3mwoNcZMykOldP+LsohUIk8SoOa
 afSq6Sva1EpiHrBO/x6E7hgeq/S0f08LWozS4SUal5gx9oeZhZneA2yqDV2nY7NIRnQN
 kFYcP5MSlJVHdQfn78rdSFN4Bof+6bZvtdBuWRHI3YmerMMb8OsF/Wm628nydxOaEr0l
 vuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685572424; x=1688164424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=knDkPGiUsAKV4vjHj0yXucrmS51UBie64TABOaedj0Y=;
 b=lJDx+RVx2159ccBA2fRIlmqX8mTM0F/u2QgJo0n0nzBFXMYS6P0vbAJFDg3uDQQwLf
 MrMTcmzW0vC7F7JceH7RYe7Oql3CZ3i2DnxVbJupjuuWmzj4H/euNmBCXMERiyHKXFNx
 uR4wAwFvmHG7QQ5IezzRiWA2LrhtbQFJ9TNffo609GItC2U9bSsVUBYwgVIUqFrHq733
 mhAHjDDG2/Byfl1C+HC2SpkpOwfMAXMJACeQJ1VUV/xKRE4fipOsCS2AqDEa43UJ+LSM
 oUQGPgJ5/HdZ4EGmVjTdDSfET7kAllhEnOx7qp7JmMK29aNLJK6eURT5iKmL7q6b3OXW
 jSoQ==
X-Gm-Message-State: AC+VfDw1Hr15SGnKQhGKc8CwxmKLwpD+214IbSlc8eMekfHSFR8v6+6r
 piN2z0yTYPyVQqqh3cLOYQr0ARFIlKgz7kztTe8=
X-Google-Smtp-Source: ACHHUZ6Jcu/dtsd9UotYpjlcQbVa41KaOStOIQ5uAWoJ9mURu7InnmesjhzK6HhF+8534q00+LezuA==
X-Received: by 2002:a1c:7206:0:b0:3f5:ce2:9c82 with SMTP id
 n6-20020a1c7206000000b003f50ce29c82mr625426wmc.32.1685572424231; 
 Wed, 31 May 2023 15:33:44 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 9-20020a05600c028900b003f60482024fsm88700wmk.30.2023.05.31.15.33.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 15:33:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/7] hw/sysbus: Add sysbus_init_irqs and reduce
 SYSBUS_DEVICE_GPIO_IRQ scope
Date: Thu,  1 Jun 2023 00:33:34 +0200
Message-Id: <20230531223341.34827-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This series:

- Remove uses (out of sysbus.c) to the SYSBUS_DEVICE_GPIO_IRQ
  definition, using proper SysBus API methods,
- Reduce SYSBUS_DEVICE_GPIO_IRQ scope, making it SysBus API
  internal,
- Convert various for() loops iterating over sysbus_init_irq()
  by calling a single sysbus_init_irqs() instead. Mostly an
  automatic convertion except 4 files.

The resulting code looks nicer IMHO, and is possibly less
bug prone.

Philippe Mathieu-Daudé (7):
  hw/arm/xlnx-versal: Do not open-code sysbus_connect_irq()
  hw/usb/xlnx: Do not open-code sysbus_pass_irq()
  hw/sysbus: Introduce sysbus_init_irqs()
  hw/usb/hcd-xhci: Use sysbus_init_irqs()
  hw/sysbus: Make SYSBUS_DEVICE_GPIO_IRQ API internal
  hw: Simplify using sysbus_init_irqs() [automatic]
  hw: Simplify using sysbus_init_irqs() [manual]

 include/hw/sysbus.h           |  3 +--
 hw/arm/smmuv3.c               |  6 +-----
 hw/arm/stellaris.c            |  5 +----
 hw/arm/strongarm.c            |  5 +----
 hw/arm/versatilepb.c          |  5 +----
 hw/arm/xlnx-versal.c          |  4 +---
 hw/char/pl011.c               |  5 +----
 hw/char/renesas_sci.c         |  5 +----
 hw/core/platform-bus.c        |  5 +----
 hw/core/sysbus.c              |  9 ++++++++-
 hw/dma/pl330.c                |  4 +---
 hw/dma/sifive_pdma.c          |  5 +----
 hw/gpio/sifive_gpio.c         |  5 +----
 hw/i386/kvm/xen_evtchn.c      |  5 +----
 hw/intc/arm_gic_common.c      | 20 +++++---------------
 hw/intc/arm_gicv2m.c          |  5 +----
 hw/intc/exynos4210_combiner.c |  5 +----
 hw/intc/loongarch_extioi.c    |  7 ++-----
 hw/intc/loongson_liointc.c    |  5 +----
 hw/intc/omap_intc.c           |  3 +--
 hw/intc/openpic.c             |  6 ++----
 hw/intc/slavio_intctl.c       |  6 ++----
 hw/misc/avr_power.c           |  4 +---
 hw/misc/macio/gpio.c          |  5 +----
 hw/misc/stm32f4xx_exti.c      |  5 +----
 hw/net/cadence_gem.c          |  5 +----
 hw/net/mcf_fec.c              |  5 +----
 hw/pci-host/designware.c      |  5 +----
 hw/pci-host/gpex.c            |  2 +-
 hw/pci-host/ppce500.c         |  4 +---
 hw/pci-host/raven.c           |  4 +---
 hw/pci-host/sh_pci.c          |  5 +----
 hw/pci-host/versatile.c       |  4 +---
 hw/ppc/ppc405_uc.c            | 10 ++--------
 hw/ppc/ppc440_uc.c            |  6 ++----
 hw/ppc/ppc4xx_devs.c          |  4 +---
 hw/ppc/ppc4xx_pci.c           |  5 +----
 hw/ssi/ibex_spi_host.c        |  5 +----
 hw/ssi/imx_spi.c              |  5 +----
 hw/ssi/sifive_spi.c           |  5 +----
 hw/ssi/xilinx_spi.c           |  5 +----
 hw/ssi/xilinx_spips.c         |  4 +---
 hw/ssi/xlnx-versal-ospi.c     |  4 +---
 hw/timer/allwinner-a10-pit.c  |  4 +---
 hw/timer/exynos4210_mct.c     |  4 +---
 hw/timer/hpet.c               |  4 +---
 hw/timer/renesas_cmt.c        |  5 +----
 hw/timer/renesas_tmr.c        |  9 +++------
 hw/timer/sifive_pwm.c         |  5 +----
 hw/usb/hcd-xhci-sysbus.c      |  5 ++---
 hw/usb/xlnx-usb-subsystem.c   |  2 +-
 51 files changed, 70 insertions(+), 197 deletions(-)

-- 
2.38.1


