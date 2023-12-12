Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B74E80F289
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:30:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5dk-0000om-C8; Tue, 12 Dec 2023 11:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5dh-0000oC-Sx
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:29:45 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5df-0006vx-Op
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:29:45 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a22f2a28c16so21691966b.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398581; x=1703003381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mn32UhI3GcAekEbpxlWbpPxY01K3QFuN0m3na/SgxOo=;
 b=zyq/5RIBdjdWcddkS4QQceY/1cPJjictJG7iJ6ucI6ZaItSTr8Ofgx9J+jnMUO8Olb
 Dec0tB7SsXP0YQMvcPbzL+BiuMonAhmCyOncwLii9Sx5RxrX8UZpWo4O3E7DRp5c44bn
 a857dEWMndyfBnOtaUvy6t1xSqrNHYTyz20cSTiVI9GE7g3JQbUcH+wT+ygbs689ewoK
 DZgT6YGEZeGHbe8H7+Eqn/bBjXpchHdXmWyIOUdsfVgjLe2FnFiq4odX62KtkCOBu7pP
 KUyS+7duxAVlLSg8qxveag4Usr83R2+Tz/eIrE0ldWG/jfft4CWgk1LeBRc4arOsKsrh
 2WVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398581; x=1703003381;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mn32UhI3GcAekEbpxlWbpPxY01K3QFuN0m3na/SgxOo=;
 b=lTPTRbtJAKCGZ0orchtg/h81c5ToOcH5Bcl2CbSbYFiiCEGKgWEzyYYjm162lrulW+
 bndRo9OTEX7CIsQIQc9zccdSz0+fTVzcWfpBoI4NL/bmMtkXaMW3EDMGcScmoUBnnOS7
 gZjtrFF8wpKc7y9pjfzUiN3qOLQfChB3Pwr2UIiTmzk00Q7J3sA/GBYu8gVPGM6cfGrn
 1TTBWlXj/hIfGNrra9ATDTrGIoUEgxtiTX53d2SL+IBAVxCaAk5M0A9mIXOnFGddpg7R
 uomNhj3522a5VzBqnYV1wd2Gn0wB8Wx/9aPYR0ILNv7ytID/KnKXjpfFnCnrMmEZJHrG
 e20w==
X-Gm-Message-State: AOJu0YzQu40NgAPK6n4pKoZLAEWpWmNubuQ7JPOHEVfXTzxnX4e8BEp3
 OVzkO8oLZ0GVmxY/0uVOpAfU8CuUN8X/y4HGp1I=
X-Google-Smtp-Source: AGHT+IHRk+gIjuiFARCTFPKGQm2celLuQGbNlhDK052m2YGVn9t5AwNYdwsDUm5L6tEhCWSqFvk6lw==
X-Received: by 2002:a17:907:9411:b0:a1d:9697:73a2 with SMTP id
 dk17-20020a170907941100b00a1d969773a2mr2865365ejc.93.1702398580756; 
 Tue, 12 Dec 2023 08:29:40 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 ul5-20020a170907ca8500b00a1f7b445f5dsm5241984ejc.124.2023.12.12.08.29.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:29:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/33] hw/cpu/arm: Remove one use of qemu_get_cpu() in A7/A15
 MPCore priv
Date: Tue, 12 Dec 2023 17:29:00 +0100
Message-ID: <20231212162935.42910-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

When a MPCore cluster is used, the Cortex-A cores belong the the
cluster container, not to the board/soc layer. This series move
the creation of vCPUs to the MPCore private container.

Doing so we consolidate the QOM model, moving common code in a
central place (abstract MPCore parent).

This eventually allow removing one qemu_get_cpu() use, which we
want to remove in heterogeneous machines (machines using MPCore
are candidate for heterogeneous emulation).

Maybe these hw/cpu/arm/ files belong to hw/arm/...

Regards,

Phil.

Philippe Mathieu-Daudé (33):
  hw/arm/boot: Propagate vCPU to arm_load_dtb()
  hw/arm/fsl-imx6: Add a local 'gic' variable
  hw/arm/fsl-imx6ul: Add a local 'gic' variable
  hw/arm/fsl-imx7: Add a local 'gic' variable
  hw/cpu: Remove dead Kconfig
  hw/cpu/arm: Rename 'busdev' -> 'gicsbd' in a15mp_priv_realize()
  hw/cpu/arm: Alias 'num-cpu' property on TYPE_REALVIEW_MPCORE
  hw/cpu/arm: Declare CPU QOM types using DEFINE_TYPES() macro
  hw/cpu/arm: Merge {a9mpcore.h, a15mpcore.h} as cortex_mpcore.h
  hw/cpu/arm: Introduce abstract CORTEX_MPCORE_PRIV QOM type
  hw/cpu/arm: Have A9MPCORE/A15MPCORE inheritate common
    CORTEX_MPCORE_PRIV
  hw/cpu/arm: Create MPCore container in QOM parent
  hw/cpu/arm: Handle 'num_cores' property once in MPCore parent
  hw/cpu/arm: Handle 'has_el2/3' properties once in MPCore parent
  hw/cpu/arm: Handle 'gic-irq' property once in MPCore parent
  hw/cpu/arm: Handle GIC once in MPCore parent
  hw/cpu/arm: Document more properties of CORTEX_MPCORE_PRIV QOM type
  hw/cpu/arm: Replace A15MPPrivState by CortexMPPrivState
  hw/cpu/arm: Introduce TYPE_A7MPCORE_PRIV for Cortex-A7 MPCore
  hw/cpu/arm: Consolidate check on max GIC spi supported
  hw/cpu/arm: Create CPUs once in MPCore parent
  hw/arm/aspeed_ast2600: Let the A7MPcore create/wire the CPU cores
  hw/arm/exynos4210: Let the A9MPcore create/wire the CPU cores
  hw/arm/fsl-imx6: Let the A9MPcore create/wire the CPU cores
  hw/arm/fsl-imx6ul: Let the A7MPcore create/wire the CPU cores
  hw/arm/fsl-imx7: Let the A7MPcore create/wire the CPU cores
  hw/arm/highbank: Let the A9/A15MPcore create/wire the CPU cores
  hw/arm/vexpress: Let the A9/A15MPcore create/wire the CPU cores
  hw/arm/xilinx_zynq: Let the A9MPcore create/wire the CPU cores
  hw/arm/npcm7xx: Let the A9MPcore create/wire the CPU cores
  hw/cpu/a9mpcore: Remove legacy code
  hw/cpu/arm: Remove 'num-cpu' property alias
  hw/cpu/arm: Remove use of qemu_get_cpu() in A7/A15 realize()

 MAINTAINERS                    |   3 +-
 include/hw/arm/aspeed_soc.h    |   5 +-
 include/hw/arm/boot.h          |   4 +-
 include/hw/arm/exynos4210.h    |   6 +-
 include/hw/arm/fsl-imx6.h      |   6 +-
 include/hw/arm/fsl-imx6ul.h    |   8 +-
 include/hw/arm/fsl-imx7.h      |   8 +-
 include/hw/arm/npcm7xx.h       |   3 +-
 include/hw/cpu/a15mpcore.h     |  44 -------
 include/hw/cpu/a9mpcore.h      |  39 -------
 include/hw/cpu/cortex_mpcore.h | 135 ++++++++++++++++++++++
 hw/arm/aspeed_ast2600.c        |  61 ++++------
 hw/arm/boot.c                  |  11 +-
 hw/arm/exynos4210.c            |  60 ++++------
 hw/arm/exynos4_boards.c        |   6 +-
 hw/arm/fsl-imx6.c              |  84 ++++----------
 hw/arm/fsl-imx6ul.c            |  65 ++++-------
 hw/arm/fsl-imx7.c              | 103 +++++------------
 hw/arm/highbank.c              |  56 ++-------
 hw/arm/mcimx6ul-evk.c          |   3 +-
 hw/arm/mcimx7d-sabre.c         |   3 +-
 hw/arm/npcm7xx.c               |  48 ++------
 hw/arm/realview.c              |   4 +-
 hw/arm/sabrelite.c             |   4 +-
 hw/arm/vexpress.c              |  60 +++-------
 hw/arm/virt.c                  |   2 +-
 hw/arm/xilinx_zynq.c           |  30 ++---
 hw/cpu/a15mpcore.c             | 179 +++++++++++++----------------
 hw/cpu/a9mpcore.c              | 138 +++++++++-------------
 hw/cpu/arm11mpcore.c           |  23 ++--
 hw/cpu/cortex_mpcore.c         | 202 +++++++++++++++++++++++++++++++++
 hw/cpu/realview_mpcore.c       |  30 ++---
 hw/arm/Kconfig                 |   8 +-
 hw/cpu/Kconfig                 |   8 --
 hw/cpu/meson.build             |   1 +
 35 files changed, 689 insertions(+), 761 deletions(-)
 delete mode 100644 include/hw/cpu/a15mpcore.h
 delete mode 100644 include/hw/cpu/a9mpcore.h
 create mode 100644 include/hw/cpu/cortex_mpcore.h
 create mode 100644 hw/cpu/cortex_mpcore.c
 delete mode 100644 hw/cpu/Kconfig

-- 
2.41.0


