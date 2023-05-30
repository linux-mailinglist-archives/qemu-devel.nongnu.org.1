Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CADEF7161BA
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:27:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zNM-0006cl-AI; Tue, 30 May 2023 09:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMq-0005cD-Hm
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMo-0001Nt-1R
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f60dfc6028so46587525e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453182; x=1688045182;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TclIhye/wZJNtsgGG5Szlu+i/oS5v/vZCReK2fB+ZZ8=;
 b=xauBe/p9ng6uoRcSTVKDOIsgayW1aC+H1ZZul7KpOrXESaUara7XmnlU/EzNy1mZ1K
 nG2C6L3wwzGAo5R8tU7eRp5bZCsMmpi8pIfiG96p+Nrf41NEfeAgKVS7dL9ZWRPPG1gU
 rujJpQzvcTtrnQNyW2RAQsaqLvww1wKUwm46zTZ3LcHgYFJVVPpZC7S3FZ5wHk8IJY9w
 jP6skm20axLL2g7zZTQAQZZtV7nKcLiqnrYrZm3IsPp8o7FCiRJP3nx+Ddeqky8xPuxv
 JND3v3f3oi8m82t1DUI+xPyutdIkZYkjNT7Pltgsn5Hd+HrXpLWKZnyR9qdfJbxXXViF
 68FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453182; x=1688045182;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TclIhye/wZJNtsgGG5Szlu+i/oS5v/vZCReK2fB+ZZ8=;
 b=lEr7blXVrSHBK9Fqr8N72KCRgINIpoJS50Z3qcBm5ZP2wuoSKc/bqm8HhnpTa+vUYj
 7+lEiHO+Mo5MQxnvJbqpaL6yyLCj4wncGbqdcmgG2x0I5xtTPdOvfd0ymwsplKEGsMaS
 1jr0UaOvLOSe3hbeQ0xxZ7r9MjPD+9k2KSWXWXx18v5P6a7JwDFFhDm7++RYNflyhJWm
 SEikMUsoDpPC+g8GrNq+tbw0glhqpZ4482+qo2pAtbGHprJni+PP+gRTsq0NaD944Cff
 gDgEBpbwN3Ey8SbKR2WKoJn8tyyw87VRvehRGUqhXEySiu47avmQItuBbP62iFyKtwS6
 c1rQ==
X-Gm-Message-State: AC+VfDy9mhvMVmQFFwMfMJ/0eaafHA5Ar9NuPOQHe2ZSBuGomeqg5e4N
 EsiyJy7VPsUtqJFpoDKyWJmDr8qwZjBff492qKM=
X-Google-Smtp-Source: ACHHUZ7yikD22iK9b6BXA+abToSpfDaW0A6evVvhqFhoG/FwkjJlDg/juukuwZDZnK8DLoJhGUalpA==
X-Received: by 2002:a05:600c:215:b0:3f6:3bd:77dc with SMTP id
 21-20020a05600c021500b003f603bd77dcmr1830179wmi.23.1685453182071; 
 Tue, 30 May 2023 06:26:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1c7413000000b003f60e143d38sm17463615wmc.11.2023.05.30.06.26.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/21] target-arm queue
Date: Tue, 30 May 2023 14:25:59 +0100
Message-Id: <20230530132620.1583658-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi; here's the latest batch of arm changes. The big thing
in here is the SMMUv3 changes to add stage-2 translation support.

thanks
-- PMM

The following changes since commit aa9bbd865502ed517624ab6fe7d4b5d89ca95e43:

  Merge tag 'pull-ppc-20230528' of https://gitlab.com/danielhb/qemu into staging (2023-05-29 14:31:52 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20230530

for you to fetch changes up to b03d0d4f531a8b867e0aac1fab0b876903015680:

  docs: sbsa: correct graphics card name (2023-05-30 13:32:46 +0100)

----------------------------------------------------------------
target-arm queue:
 * fsl-imx6: Add SNVS support for i.MX6 boards
 * smmuv3: Add support for stage 2 translations
 * hw/dma/xilinx_axidma: Check DMASR.HALTED to prevent infinite loop
 * hw/arm/xlnx-zynqmp: fix unsigned error when checking the RPUs number
 * cleanups for recent Kconfig changes
 * target/arm: Explicitly select short-format FSR for M-profile
 * tests/qtest: Run arm-specific tests only if the required machine is available
 * hw/arm/sbsa-ref: add GIC node into DT
 * docs: sbsa: correct graphics card name
 * Update copyright dates to 2023

----------------------------------------------------------------
Clément Chigot (1):
      hw/arm/xlnx-zynqmp: fix unsigned error when checking the RPUs number

Enze Li (1):
      Update copyright dates to 2023

Fabiano Rosas (3):
      target/arm: Explain why we need to select ARM_V7M
      arm/Kconfig: Keep Kconfig default entries in default.mak as documentation
      arm/Kconfig: Make TCG dependence explicit

Marcin Juszkiewicz (2):
      hw/arm/sbsa-ref: add GIC node into DT
      docs: sbsa: correct graphics card name

Mostafa Saleh (10):
      hw/arm/smmuv3: Add missing fields for IDR0
      hw/arm/smmuv3: Update translation config to hold stage-2
      hw/arm/smmuv3: Refactor stage-1 PTW
      hw/arm/smmuv3: Add page table walk for stage-2
      hw/arm/smmuv3: Parse STE config for stage-2
      hw/arm/smmuv3: Make TLB lookup work for stage-2
      hw/arm/smmuv3: Add VMID to TLB tagging
      hw/arm/smmuv3: Add CMDs related to stage-2
      hw/arm/smmuv3: Add stage-2 support in iova notifier
      hw/arm/smmuv3: Add knob to choose translation stage and enable stage-2

Peter Maydell (1):
      target/arm: Explicitly select short-format FSR for M-profile

Thomas Huth (1):
      tests/qtest: Run arm-specific tests only if the required machine is available

Tommy Wu (1):
      hw/dma/xilinx_axidma: Check DMASR.HALTED to prevent infinite loop.

Vitaly Cheptsov (1):
      fsl-imx6: Add SNVS support for i.MX6 boards

 docs/conf.py                                |   2 +-
 docs/system/arm/sbsa.rst                    |   2 +-
 configs/devices/aarch64-softmmu/default.mak |   6 +
 configs/devices/arm-softmmu/default.mak     |  40 ++++
 hw/arm/smmu-internal.h                      |  37 +++
 hw/arm/smmuv3-internal.h                    |  12 +-
 include/hw/arm/fsl-imx6.h                   |   2 +
 include/hw/arm/smmu-common.h                |  45 +++-
 include/hw/arm/smmuv3.h                     |   4 +
 include/qemu/help-texts.h                   |   2 +-
 hw/arm/fsl-imx6.c                           |   8 +
 hw/arm/sbsa-ref.c                           |  19 +-
 hw/arm/smmu-common.c                        | 209 ++++++++++++++--
 hw/arm/smmuv3.c                             | 357 ++++++++++++++++++++++++----
 hw/arm/xlnx-zynqmp.c                        |   2 +-
 hw/dma/xilinx_axidma.c                      |  11 +-
 target/arm/tcg/tlb_helper.c                 |  13 +-
 hw/arm/Kconfig                              | 123 ++++++----
 hw/arm/trace-events                         |  14 +-
 target/arm/Kconfig                          |   3 +
 tests/qtest/meson.build                     |   7 +-
 21 files changed, 773 insertions(+), 145 deletions(-)

