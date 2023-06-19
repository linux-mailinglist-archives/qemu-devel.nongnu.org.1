Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE2A73599C
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:33:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFsj-0000Zx-28; Mon, 19 Jun 2023 10:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFse-0000Xw-7I
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsc-0002AF-1i
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:19 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f8fcaa31c7so37620745e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184956; x=1689776956;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=MXbckQhPpP6v7rrVU3Nz0y2nsUydwnGn4a7YqIjazME=;
 b=k4HMMDgOaoijGBdSn9Uie9HwVgRUjr/EUatbFQUXTUMZo0rnGnyYSGrAF2lNF3A6NR
 HjxJhazwVg0Qvp3X9yoalRuhP9/EHGPuxHe2DNZxISO4u28rqkvS7Ldg+oZMIfLQf+2g
 4qtLJ+Zko04JDxDtT83yQI2UtPegEKboOBWRgk6YStpdqpksfgZp9WqTCiA/5aXaGhVd
 X35qboIaYZGhcebe65XD1BqpNO9YFbp4qNq+vilO30tOhZQOQogKrcCzXOgcaQsJ+H+p
 r+klHdRT6KB+AhJMkyD/oC8we+zo05Qzj20N/wtG36PnEkoc5ua880v/Mi4xLcL3qIWx
 7Imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184956; x=1689776956;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MXbckQhPpP6v7rrVU3Nz0y2nsUydwnGn4a7YqIjazME=;
 b=EK57Edpk/65eWyxXIBK36+m/sBghPPNw2dt9VU2lkvJ1PrQOBYWRhxPfIhSUcXkq6Q
 83DYzs71Cuo6G+HWZfkoYDbujHLvcg3C9f3wTPo611sXRME6t20acGmY/X6/m6YCTQOw
 rmw3Vn5UOzjnY6qVIKsQnyTeJrXrRryvbPKS3WLMgnuR7ZOOnc0osTtxNKU/6A55dOzX
 hFdt2vkeLdvOOEa0wJvvmbD0hz1xUUID+xJxakplkZJ68tXGLdVddkwGh5SaB955hsE2
 aoORfPyrZsJ2NEEp+R1L/dBgzWzUYwCVW7QsaA+Rza7rr0yk1m7IO7LmWgFmyfMuT++K
 8nnw==
X-Gm-Message-State: AC+VfDwlREo6QAy0nyZ1x035BzV6skm7+8bYAvtyAdlXvkFmPcm0f1QV
 0iw3HfJRzSvkkFmj9eFmo5I8gg7PN+7ZTQeDHN0=
X-Google-Smtp-Source: ACHHUZ6JO6WpwArwH4tinxnOLD3Yn2zg91+nsVIpZzku0hicVSb2quaOlNe6bOzoVwH+S2LsKPzwRQ==
X-Received: by 2002:a7b:c8c2:0:b0:3f7:5d:49ff with SMTP id
 f2-20020a7bc8c2000000b003f7005d49ffmr9932180wml.1.1687184956241; 
 Mon, 19 Jun 2023 07:29:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/33] target-arm queue
Date: Mon, 19 Jun 2023 15:28:41 +0100
Message-Id: <20230619142914.963184-1-peter.maydell@linaro.org>
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

Hi; here's a target-arm pullreq. Mostly this is some decodetree
conversion patches from me, plus a scattering of other bug fixes.

thanks
-- PMM

The following changes since commit e3660cc1e3cb136af50c0eaaeac27943c2438d1d:

  Merge tag 'pull-loongarch-20230616' of https://gitlab.com/gaosong/qemu into staging (2023-06-16 12:30:16 +0200)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20230619

for you to fetch changes up to 074259c0f2ac40042dce766d870318cc22f388eb:

  hw/misc/bcm2835_property: Handle CORE_CLK_ID firmware property (2023-06-19 15:27:21 +0100)

----------------------------------------------------------------
target-arm queue:
 * Fix return value from LDSMIN/LDSMAX 8/16 bit atomics
 * Return correct result for LDG when ATA=0
 * Conversion of system insns, loads and stores to decodetree
 * hw/intc/allwinner-a10-pic: Handle IRQ levels other than 0 or 1
 * hw/sd/allwinner-sdhost: Don't send non-boolean IRQ line levels
 * hw/timer/nrf51_timer: Don't lose time when timer is queried in tight loop
 * hw/arm/Kconfig: sbsa-ref uses Bochs display
 * imx_serial: set wake bit when we receive a data byte
 * docs: sbsa: document board to firmware interface
 * hw/misc/bcm2835_property: avoid hard-coded constants

----------------------------------------------------------------
Marcin Juszkiewicz (2):
      hw/arm/Kconfig: sbsa-ref uses Bochs display
      docs: sbsa: document board to firmware interface

Martin Kaiser (1):
      imx_serial: set wake bit when we receive a data byte

Peter Maydell (26):
      target/arm: Fix return value from LDSMIN/LDSMAX 8/16 bit atomics
      target/arm: Return correct result for LDG when ATA=0
      target/arm: Pass memop to gen_mte_check1_mmuidx() in reg_imm9 decode
      target/arm: Consistently use finalize_memop_asimd() for ASIMD loads/stores
      target/arm: Convert hint instruction space to decodetree
      target/arm: Convert barrier insns to decodetree
      target/arm: Convert CFINV, XAFLAG and AXFLAG to decodetree
      target/arm: Convert MSR (immediate) to decodetree
      target/arm: Convert MSR (reg), MRS, SYS, SYSL to decodetree
      target/arm: Convert exception generation instructions to decodetree
      target/arm: Convert load/store exclusive and ordered to decodetree
      target/arm: Convert LDXP, STXP, CASP, CAS to decodetree
      target/arm: Convert load reg (literal) group to decodetree
      target/arm: Convert load/store-pair to decodetree
      target/arm: Convert ld/st reg+imm9 insns to decodetree
      target/arm: Convert LDR/STR with 12-bit immediate to decodetree
      target/arm: Convert LDR/STR reg+reg to decodetree
      target/arm: Convert atomic memory ops to decodetree
      target/arm: Convert load (pointer auth) insns to decodetree
      target/arm: Convert LDAPR/STLR (imm) to decodetree
      target/arm: Convert load/store (multiple structures) to decodetree
      target/arm: Convert load/store single structure to decodetree
      target/arm: Convert load/store tags insns to decodetree
      hw/intc/allwinner-a10-pic: Handle IRQ levels other than 0 or 1
      hw/sd/allwinner-sdhost: Don't send non-boolean IRQ line levels
      hw/timer/nrf51_timer: Don't lose time when timer is queried in tight loop

Sergey Kambalin (4):
      hw/arm/raspi: Import Linux raspi definitions as 'raspberrypi-fw-defs.h'
      hw/misc/bcm2835_property: Use 'raspberrypi-fw-defs.h' definitions
      hw/misc/bcm2835_property: Replace magic frequency values by definitions
      hw/misc/bcm2835_property: Handle CORE_CLK_ID firmware property

 docs/system/arm/sbsa.rst              |   38 +-
 include/hw/arm/raspi_platform.h       |   10 +
 include/hw/char/imx_serial.h          |    1 +
 include/hw/misc/raspberrypi-fw-defs.h |  163 ++
 target/arm/tcg/a64.decode             |  403 ++++
 hw/char/imx_serial.c                  |    5 +-
 hw/intc/allwinner-a10-pic.c           |    2 +-
 hw/misc/bcm2835_property.c            |  112 +-
 hw/sd/allwinner-sdhost.c              |    2 +-
 hw/timer/nrf51_timer.c                |    7 +-
 target/arm/tcg/translate-a64.c        | 3319 +++++++++++++++------------------
 hw/arm/Kconfig                        |    1 +
 12 files changed, 2157 insertions(+), 1906 deletions(-)
 create mode 100644 include/hw/misc/raspberrypi-fw-defs.h

