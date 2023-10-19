Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C357CFB54
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:39:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCU-0002Wf-Kz; Thu, 19 Oct 2023 09:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBf-0001pM-O6
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBc-0001C1-EK
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:43 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40572aeb6d0so72528095e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722538; x=1698327338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zHljr8MeCugL9Y3epBzjttXePVHDKLNOQ6qYTDa/X1U=;
 b=viln9pqleExnkQe2TgujZwl1mVydwvV3HDxkkf+zs6AP5G2BCus6jXM2BqiW24PWQo
 tk7AeWW7hc3ERRtL0jG6dPcaO6b5j2pz56t/cGs98XkNogYgMOU3Tg1TvRyUhq/M64It
 J1/MnsjJ0tipFmPwtosWV03IFvPCYzJRSVaiZRWgMNxKOHJ05hlr/hXf0uImhiVFhSPR
 e/ge+xwLWrxuJwFnrBxyfSV5T0sUSAROZPyWg4JGPHPgF8WqXlzPNCfnpCeCw+ufhKoj
 g1byiNcxUU/ou1TDR+UPypfstxMPBKXdhTbPJ2d0QzYBxI8Aw8W7alKoFc0ZqTWu/r3S
 fTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722538; x=1698327338;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zHljr8MeCugL9Y3epBzjttXePVHDKLNOQ6qYTDa/X1U=;
 b=Pi1XLZNgpZnX905vue34tqUAPXHu17gbI5Hvr1aYjcIBLgls7Ze2CdP9LRIiaNS2LA
 VxlrKczSvZFrzebdW+ByjrAESzRzW97yxrFMSfAH+9h/ykI5sse9ygFhLdYTjGPHwgS4
 S15ECkaD4eB8MmkEB+GAb1OlY/l6DipJQJf7dPkZhj6B4PlmR4MNj/BFKRJH67WdJUxH
 usp2M5+QWRNw/oQSKzbo/aDD4AB+Mt28pGDoLH/8w5TlUWl16colon6TdLohPZdOttxp
 BU+I07WdKqSLS0o3EzxGmcU0tJ2jjdzFi7r7D5eZoYTl/ZEL1qy5EhD+IG/1qm9/ziEV
 5OjQ==
X-Gm-Message-State: AOJu0YwWHYRRBT3CuHJDfSpPA0zacuaGlnpOTV0VTAiw5so91uvKpNKv
 +A9ITCsf2Oa7yRnPynNYqDLPcKVqaanppX5Jq+I=
X-Google-Smtp-Source: AGHT+IGg1QJXpWzyfojzWMnegyOGM9jmGWdskUg+3TcqfeO8P+FwYv3jUSpSydOotCuVBUEmXW564g==
X-Received: by 2002:a05:600c:3b0f:b0:406:5b73:b6f9 with SMTP id
 m15-20020a05600c3b0f00b004065b73b6f9mr1800370wms.35.1697722538515; 
 Thu, 19 Oct 2023 06:35:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/24] target-arm queue
Date: Thu, 19 Oct 2023 14:35:13 +0100
Message-Id: <20231019133537.2114929-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi; here's a queue of arm patches (plus a few elf2dmp changes);
mostly these are minor cleanups and bugfixes.

thanks
-- PMM

The following changes since commit deaca3fd30d3a8829160f8d3705d65ad83176800:

  Merge tag 'pull-vfio-20231018' of https://github.com/legoater/qemu into staging (2023-10-18 06:21:15 -0400)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20231019

for you to fetch changes up to 2a052b4ee01b3c413cef2ef49cb780cde17d4ba1:

  contrib/elf2dmp: Use g_malloc(), g_new() and g_free() (2023-10-19 14:32:13 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/arm: Move raspberrypi-fw-defs.h to the include/hw/arm/ folder
 * hw/arm/exynos4210: Get arm_boot_info declaration from 'hw/arm/boot'
 * xlnx devices: remove deprecated device reset
 * xlnx-bbram: hw/nvram: Use dot in device type name
 * elf2dmp: fix coverity issues
 * elf2dmp: convert to g_malloc, g_new and g_free
 * target/arm: Fix CNTPCT_EL0 trapping from EL0 when HCR_EL2.E2H is 0
 * hw/arm: refactor virt PPI logic
 * arm/kvm: convert to kvm_set_one_reg, kvm_get_one_reg
 * target/arm: Permit T32 LDM with single register
 * smmuv3: Advertise SMMUv3.1-XNX
 * target/arm: Implement FEAT_HPMN0
 * Remove some unnecessary include lines
 * target/arm/arm-powerctl: Correctly init CPUs when powered on to lower EL
 * hw/timer/npcm7xx_timer: Prevent timer from counting down past zero

----------------------------------------------------------------
Chris Rauer (1):
      hw/timer/npcm7xx_timer: Prevent timer from counting down past zero

Cornelia Huck (2):
      arm/kvm: convert to kvm_set_one_reg
      arm/kvm: convert to kvm_get_one_reg

Leif Lindholm (3):
      {include/}hw/arm: refactor virt PPI logic
      include/hw/arm: move BSA definitions to bsa.h
      hw/arm/sbsa-ref: use bsa.h for PPI definitions

Michal Orzel (1):
      target/arm: Fix CNTPCT_EL0 trapping from EL0 when HCR_EL2.E2H is 0

Peter Maydell (8):
      target/arm: Permit T32 LDM with single register
      hw/arm/smmuv3: Update ID register bit field definitions
      hw/arm/smmuv3: Sort ID register setting into field order
      hw/arm/smmuv3: Advertise SMMUv3.1-XNX feature
      target/arm: Implement FEAT_HPMN0
      target/arm/kvm64.c: Remove unused include
      target/arm/common-semi-target.h: Remove unnecessary boot.h include
      target/arm/arm-powerctl: Correctly init CPUs when powered on to lower EL

Philippe Mathieu-Daudé (1):
      hw/arm/exynos4210: Get arm_boot_info declaration from 'hw/arm/boot.h'

Suraj Shirvankar (1):
      contrib/elf2dmp: Use g_malloc(), g_new() and g_free()

Thomas Huth (1):
      hw/arm: Move raspberrypi-fw-defs.h to the include/hw/arm/ folder

Tong Ho (4):
      xlnx-bbram: hw/nvram: Remove deprecated device reset
      xlnx-zynqmp-efuse: hw/nvram: Remove deprecated device reset
      xlnx-versal-efuse: hw/nvram: Remove deprecated device reset
      xlnx-bbram: hw/nvram: Use dot in device type name

Viktor Prutyanov (2):
      elf2dmp: limit print length for sign_rsds
      elf2dmp: check array bounds in pdb_get_file_size

 MAINTAINERS                                    |   2 +-
 docs/system/arm/emulation.rst                  |   1 +
 hw/arm/smmuv3-internal.h                       |  38 ++++++++
 include/hw/arm/bsa.h                           |  35 +++++++
 include/hw/arm/exynos4210.h                    |   2 +-
 include/hw/{misc => arm}/raspberrypi-fw-defs.h |   0
 include/hw/arm/virt.h                          |  12 +--
 include/hw/nvram/xlnx-bbram.h                  |   2 +-
 target/arm/common-semi-target.h                |   4 +-
 target/arm/cpu-qom.h                           |   2 -
 target/arm/cpu.h                               |  22 +++++
 contrib/elf2dmp/addrspace.c                    |   7 +-
 contrib/elf2dmp/main.c                         |  11 +--
 contrib/elf2dmp/pdb.c                          |  32 ++++---
 contrib/elf2dmp/qemu_elf.c                     |   7 +-
 hw/arm/boot.c                                  |  95 +++++--------------
 hw/arm/sbsa-ref.c                              |  21 ++---
 hw/arm/smmuv3.c                                |   8 +-
 hw/arm/virt-acpi-build.c                       |  12 +--
 hw/arm/virt.c                                  |  24 +++--
 hw/misc/bcm2835_property.c                     |   2 +-
 hw/nvram/xlnx-bbram.c                          |   8 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c              |   8 +-
 hw/nvram/xlnx-zynqmp-efuse.c                   |   8 +-
 hw/timer/npcm7xx_timer.c                       |   3 +
 target/arm/arm-powerctl.c                      |  53 +----------
 target/arm/cpu.c                               |  95 +++++++++++++++++++
 target/arm/helper.c                            |  19 +---
 target/arm/kvm.c                               |  28 ++----
 target/arm/kvm64.c                             | 124 +++++++------------------
 target/arm/tcg/cpu32.c                         |   4 +
 target/arm/tcg/cpu64.c                         |   1 +
 target/arm/tcg/translate.c                     |  37 +++++---
 33 files changed, 368 insertions(+), 359 deletions(-)
 create mode 100644 include/hw/arm/bsa.h
 rename include/hw/{misc => arm}/raspberrypi-fw-defs.h (100%)

