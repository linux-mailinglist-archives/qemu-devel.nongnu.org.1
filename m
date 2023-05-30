Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9AB716526
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:53:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40iM-0000q8-9F; Tue, 30 May 2023 10:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q40iJ-0000pm-J3
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:52:43 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q40iH-0000UC-Nd
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:52:43 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f6d7abe9a4so31838865e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 07:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685458359; x=1688050359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=hWbOf1sEhPHHDph7Q4e3Ht+hYnLT3EvcLQTe8GOkQ7E=;
 b=SJFg5YsGBy0O3kiv77rS/3jgrO+Lk9LdRmJqwBxABEibEJjZUP0dZ1yd/LPuBr3pjL
 dI7HeKis4ig8xGQcj+aulq9DPH5u5yjoZ2VFUN3QSgxpCtJcLRAfty0VtLXYjvocsCy6
 mCfdSW2oLzKSDjSsVkZD0IYIktLz+XYP9sMfBLpyVNlU9a2mYzEjT1QBCw/5/B48Le5t
 kUUXVKrDtJa9FvbTyX/nsnABa+6Y2NGifMSWZSlunA8jG0GahOgCnJ8q4BUILPQeuW+b
 /8z7Gc3fWn/ZZp0k0cFmzIZXSv+Os54gD4lcJl29bxdDLL2EGvZ3zP/Vxr0byhKhfUa8
 zuuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685458359; x=1688050359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hWbOf1sEhPHHDph7Q4e3Ht+hYnLT3EvcLQTe8GOkQ7E=;
 b=MXuhdEZPhqc2QGmhIJaf+0CSsAEPvSHOkEmt/I7o7g1FWBe5+j06KmzRgcrjmAdtcz
 kTgSasFN/GpNtqPSo+WpZX2h39S1vK+g2139jmtwwKQczoo/+n9FMyZJkUlIPibcgolX
 kf3Wj8Vu1+I2TeQ65KS/p2nUEZyJX8Bywb8zj2rrY2aAok8fEx/+R5hc6TceTkusNDES
 O30aemX77I0e9SOinMFLBCoa4U+zTwTYlz5AFdAYary++18iUEcmicqYc3JxAJZjVd+E
 ljzJvdBFh2h/PHPNBJMgvd7nFmHn6tUhwPvBh8mkkhBWoKtmTGK5rAvTRW/ZCJZ6j7vP
 AlpQ==
X-Gm-Message-State: AC+VfDwupzIUoBOqi0kDC/pBOX3BCd4g99S9FmS+zG5At/7VKk7Y7Kgd
 wm8OiTRm8weNoKUBgbxRE9UQdYuk5gm64W2huak=
X-Google-Smtp-Source: ACHHUZ4Fe9+968ZGJ92w7y945BDsZjJpgdD6YFm/9AzAj3gzcK0tjrDHj1Vg2loWYLGH7lz8ebihkg==
X-Received: by 2002:a05:600c:3783:b0:3f6:675:3219 with SMTP id
 o3-20020a05600c378300b003f606753219mr1777782wmr.40.1685458358939; 
 Tue, 30 May 2023 07:52:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n26-20020a7bc5da000000b003f42894ebe2sm21406102wmk.23.2023.05.30.07.52.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 07:52:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/21] target-arm queue
Date: Tue, 30 May 2023 15:52:37 +0100
Message-Id: <20230530145237.1589144-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

v2: fix format string error

thanks
-- PMM

The following changes since commit aa9bbd865502ed517624ab6fe7d4b5d89ca95e43:

  Merge tag 'pull-ppc-20230528' of https://gitlab.com/danielhb/qemu into staging (2023-05-29 14:31:52 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20230530-1

for you to fetch changes up to ec683110def96b16be3931ec87baba65a3dc5ad0:

  docs: sbsa: correct graphics card name (2023-05-30 15:50:17 +0100)

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
 hw/arm/smmuv3.c                             | 358 ++++++++++++++++++++++++----
 hw/arm/xlnx-zynqmp.c                        |   2 +-
 hw/dma/xilinx_axidma.c                      |  11 +-
 target/arm/tcg/tlb_helper.c                 |  13 +-
 hw/arm/Kconfig                              | 123 ++++++----
 hw/arm/trace-events                         |  14 +-
 target/arm/Kconfig                          |   3 +
 tests/qtest/meson.build                     |   7 +-
 21 files changed, 774 insertions(+), 145 deletions(-)

