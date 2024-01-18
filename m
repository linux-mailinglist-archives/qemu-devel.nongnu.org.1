Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75828832035
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:08:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYf6-0003OB-GB; Thu, 18 Jan 2024 15:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYf4-0003Nl-MW
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:06:50 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYf1-0006rb-Iw
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:06:50 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e87d07c07so307485e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705608406; x=1706213206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MnxwcG9x8U6GyBQH17lIVMOVUV+dD9v6DloaKxqOUuQ=;
 b=g2Mp53VtaGdw2RGzfID1lrKdV5GvkLYgh1xTRk/HzdXMfxgszrqidst6/sjPg3ng88
 gRCq60V31ZxG66lVdmbGkd5I1oHNvZ3XUgxtwfYVms/Hz4GUFAOD0/BN0pxQCdaSIG93
 DdKpCrlkDbe/8JRuHDQpzKtaIqUOI/iMrrPtqfSw1Ee/Q1u/M1itKuhznoDfrooF+85e
 xv3Z27axcVmvzKvz0YfUCzPVGQErgdsk1fihSHw3qO7oBLZSBDODe2yhiMoZ7q5BsHYI
 gIOWSCtlLZY7k3halVCVoUoG+7XRbsoFdmg3MftRh3k0HubcZRmeJ45Adg6WSGquuPjs
 J7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705608406; x=1706213206;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MnxwcG9x8U6GyBQH17lIVMOVUV+dD9v6DloaKxqOUuQ=;
 b=dzpkOTz4Dyat442YxOWM8IW9baxAU5cDmArT7AlH+JTLXu7h1QJ+/XkgTCwmoQM+tm
 gNIUWIavR0kGq21vjjdHY99CzEy6l342zUbsA2XU21hyLq2W0wQAoXhUU17FSMV5AWIJ
 y0qg3sx7KnMFj3lgv+ekRWFTr+909K780QHFi7ydwq60g+1W4F6En7bcbrIXPfIsn9Zh
 mZ/QwLhdgRG0r0Niw3RPgWZQjX2qqj0qYShl1JDcTjvgnMKy996kLp+IDcQQAaa61KQt
 R/7TbvkdkiS0utLThv75gRHPZSomOhlDocQMcYDxQcVq4Vp0wIPXkYyzVmhpRXDcbCVl
 pAgw==
X-Gm-Message-State: AOJu0YyulY6KBz3o1b/VaWjRbZ/9s8HdSqCNz6GPdA5U7KWWzzET7fdl
 zIjF5NG1EnNNOiyY1dCFBAOU/0GJINPb7r0MHVTIVwVr9IB2zu4nQwiGXACyQCmM7iidLECmIsr
 RXL1EAQ==
X-Google-Smtp-Source: AGHT+IFIHxxDoaumKRcg6P/3bJAWZtBjZ9XR5976CC7aYAWayW2rGZ5ty+9P35o60gnyESbKKBWgvA==
X-Received: by 2002:adf:e2c6:0:b0:337:c54d:c3ca with SMTP id
 d6-20020adfe2c6000000b00337c54dc3camr987049wrj.132.1705608405815; 
 Thu, 18 Jan 2024 12:06:45 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 f11-20020adff98b000000b00337d5cd0d8asm1667439wrr.90.2024.01.18.12.06.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 12:06:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Auger <eric.auger@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Rob Herring <robh@kernel.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Joel Stanley <joel@jms.id.au>, Hao Wu <wuhaotsh@google.com>,
 kvm@vger.kernel.org
Subject: [PATCH 00/20] arm: Rework target/ headers to build various hw/ files
 once
Date: Thu, 18 Jan 2024 21:06:21 +0100
Message-ID: <20240118200643.29037-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi,

In order to fix a bug noticed [*] by Cédric and Fabiano in my
"Remove one use of qemu_get_cpu() in A7/A15 MPCore priv" series,
I ended reusing commits from other branches and it grew quite
a lot. This is the first "cleanup" part, unrelated on MPCorePriv.

Please review,

Phil.

Philippe Mathieu-Daudé (18):
  hw/arm/exynos4210: Include missing 'exec/tswap.h' header
  hw/arm/xilinx_zynq: Include missing 'exec/tswap.h' header
  hw/arm/smmuv3: Include missing 'hw/registerfields.h' header
  hw/arm/xlnx-versal: Include missing 'cpu.h' header
  target/arm/cpu-features: Include missing 'hw/registerfields.h' header
  target/arm/cpregs: Include missing 'hw/registerfields.h' header
  target/arm/cpregs: Include missing 'kvm-consts.h' header
  target/arm: Expose arm_cpu_mp_affinity() in 'multiprocessing.h' header
  target/arm: Declare ARM_CPU_TYPE_NAME/SUFFIX in 'cpu-qom.h'
  hw/cpu/a9mpcore: Build it only once
  hw/misc/xlnx-versal-crl: Include generic 'cpu-qom.h' instead of
    'cpu.h'
  hw/misc/xlnx-versal-crl: Build it only once
  target/arm: Expose M-profile register bank index definitions
  hw/arm/armv7m: Make 'hw/intc/armv7m_nvic.h' a target agnostic header
  target/arm: Move ARM_CPU_IRQ/FIQ definitions to 'cpu-qom.h' header
  target/arm: Move e2h_access() helper around
  target/arm: Move GTimer definitions to new 'gtimer.h' header
  hw/arm: Build various units only once

Richard Henderson (2):
  target/arm: Rename arm_cpu_mp_affinity
  target/arm: Create arm_cpu_mp_affinity

 hw/arm/smmuv3-internal.h          |  1 +
 include/hw/arm/xlnx-versal.h      |  1 +
 include/hw/intc/armv7m_nvic.h     |  2 +-
 include/hw/misc/xlnx-versal-crl.h |  2 +-
 target/arm/cpregs.h               |  3 +++
 target/arm/cpu-features.h         |  2 ++
 target/arm/cpu-qom.h              | 24 ++++++++++++++++++++++
 target/arm/cpu.h                  | 34 +++----------------------------
 target/arm/gtimer.h               | 21 +++++++++++++++++++
 target/arm/multiprocessing.h      | 16 +++++++++++++++
 hw/arm/allwinner-a10.c            |  1 +
 hw/arm/allwinner-h3.c             |  2 ++
 hw/arm/allwinner-r40.c            |  2 ++
 hw/arm/armv7m.c                   |  2 ++
 hw/arm/aspeed_ast2400.c           |  1 +
 hw/arm/aspeed_ast2600.c           |  1 +
 hw/arm/bcm2836.c                  |  2 ++
 hw/arm/collie.c                   |  1 -
 hw/arm/exynos4210.c               |  2 ++
 hw/arm/fsl-imx25.c                |  1 +
 hw/arm/fsl-imx31.c                |  1 +
 hw/arm/fsl-imx6.c                 |  1 +
 hw/arm/fsl-imx6ul.c               |  1 +
 hw/arm/fsl-imx7.c                 |  1 +
 hw/arm/gumstix.c                  |  1 -
 hw/arm/highbank.c                 |  1 +
 hw/arm/integratorcp.c             |  2 +-
 hw/arm/mainstone.c                |  1 -
 hw/arm/musicpal.c                 |  2 +-
 hw/arm/npcm7xx.c                  |  3 ++-
 hw/arm/omap1.c                    |  1 +
 hw/arm/omap2.c                    |  2 +-
 hw/arm/omap_sx1.c                 |  1 -
 hw/arm/palm.c                     |  1 -
 hw/arm/realview.c                 |  1 +
 hw/arm/sbsa-ref.c                 |  4 +++-
 hw/arm/spitz.c                    |  1 -
 hw/arm/strongarm.c                |  2 +-
 hw/arm/versatilepb.c              |  2 +-
 hw/arm/vexpress.c                 |  2 +-
 hw/arm/virt-acpi-build.c          |  4 ++--
 hw/arm/virt.c                     | 11 ++++++----
 hw/arm/xilinx_zynq.c              |  3 ++-
 hw/arm/xlnx-versal-virt.c         |  5 +++--
 hw/arm/xlnx-versal.c              |  2 ++
 hw/arm/xlnx-zynqmp.c              |  2 ++
 hw/arm/z2.c                       |  1 -
 hw/cpu/a15mpcore.c                |  1 +
 hw/cpu/a9mpcore.c                 |  2 +-
 hw/misc/xlnx-versal-crl.c         |  5 +++--
 target/arm/arm-powerctl.c         |  3 ++-
 target/arm/cpu.c                  | 13 +++++++++---
 target/arm/helper.c               | 30 ++++++++++++++-------------
 target/arm/hvf/hvf.c              |  6 ++++--
 target/arm/kvm.c                  |  1 +
 target/arm/machine.c              |  1 +
 target/arm/tcg/psci.c             |  3 ++-
 hw/arm/meson.build                | 23 +++++++++++----------
 hw/cpu/meson.build                |  2 +-
 hw/misc/meson.build               |  2 +-
 60 files changed, 178 insertions(+), 94 deletions(-)
 create mode 100644 target/arm/gtimer.h
 create mode 100644 target/arm/multiprocessing.h

-- 
2.41.0


