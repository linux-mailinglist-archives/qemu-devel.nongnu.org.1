Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C35AE7FA78A
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 18:09:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7f5z-0007QI-JI; Mon, 27 Nov 2023 12:08:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f5x-0007PW-3I
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:29 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f5v-0004cU-Ay
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:28 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-332ff20ec45so811244f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 09:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701104906; x=1701709706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y6cHW1IneSiA8eDOeW6os0K62AReA36sgXd05D8ZzLE=;
 b=ILSfAtrJHEDfCQu4hPdXRnhX18047YkSaFuD5tv7uhVQLFHsOdF7yIlkiuUf6183VU
 i1DehOAorVXFClN0GHQioJajuAeTDwMy0Djy0SbR2txZG/fC5nonpNgXL1h44P4z5dng
 GlGbAV3pI6DvWKG/POOjqVfoBAoIxWub7eAh1D8CgPKDaIDG5WO0fnRNPSB8wHsWzVMw
 mkF9QCV0bT4889Td3Sb6z7AmDnOfts3dRvTSlWoDltdIL96brTZsGsG0sJuwM/xdeppa
 wt1PLf68RgKrEx5AMNwYhKpGyZNCSRxrJuUTy+/b7rczWQ0XE5yyiVLGCZeAjj+pClqh
 rCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701104906; x=1701709706;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y6cHW1IneSiA8eDOeW6os0K62AReA36sgXd05D8ZzLE=;
 b=oWt2g3P8cPqNHlI2ikQRAcPfkUYm7X7yG1q/8S64+Eo6Ful4wJZDoDI+1y5ZhH+IrB
 srmy/J4CqsCi7dzERmQY58bYvWX++F7Hy6dojrpRNsGwXKPVkJR5A4hq4FctX3bZFY1W
 /uaMtFvWGtCz6Gh2Ytb+mOF2UqzERmz3Qwvhes4weibLiBorRee4J6mVCkKbKwAxVDgH
 9ckOzj2J9GwC3b68xe2CYSOKJH56OyxuR/slDrFMNtDdyEeAWbsuP3rl5uh1pUlVMSZ6
 nwcP8J8/ihxybxrLvr3NBYbr4BSYFPNHmWXcAjY0G6SYO2X1jMJpp9OILNvcCpnfWXnL
 aZuA==
X-Gm-Message-State: AOJu0YwpNpL0a+j+9edrFlYvGV9/EkT/p7zaizlgOh84d9uiIO6IisQl
 HBdCI3I7wuLeZHhdq+QsiKPqXkheaCKAAhQyLnY=
X-Google-Smtp-Source: AGHT+IFvCA1MsPi7s1Ul9jdrxth+H1PmSdnM96XFcVo+rjdaZdY4AVUIxLh14jzzjNS1HDEGvW3OfA==
X-Received: by 2002:adf:f1c3:0:b0:332:f6c0:1da8 with SMTP id
 z3-20020adff1c3000000b00332f6c01da8mr5913380wro.7.1701104905595; 
 Mon, 27 Nov 2023 09:08:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 fl8-20020a05600c0b8800b004030e8ff964sm15353216wmb.34.2023.11.27.09.08.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 09:08:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/13] target-arm queue
Date: Mon, 27 Nov 2023 17:08:10 +0000
Message-Id: <20231127170823.589863-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Hi; here are some more arm bug fixes for rc2. Nothing
earth-shakingly important here, I think.

thanks
-- PMM

The following changes since commit 4705fc0c8511d073bee4751c3c974aab2b10a970:

  Merge tag 'pull-for-8.2-fixes-231123-1' of https://gitlab.com/stsquad/qemu into staging (2023-11-24 08:00:18 -0500)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20231127

for you to fetch changes up to 1ee80592bf24eabef77e2260a86d9358b54c08fd:

  hw/dma/xlnx_csu_dma: don't throw guest errors when stopping the SRC DMA (2023-11-27 17:02:04 +0000)

----------------------------------------------------------------
target-arm queue:
 * Set IL bit for pauth, SVE access, BTI trap syndromes
 * Handle overflow in calculation of next timer tick
 * hw/net/can/xlnx-zynqmp: Avoid underflow when popping FIFOs
 * Various devices: Free array property memory on device finalize
 * hw/ssi/xilinx_spips: fix an out of bound access
 * hw/misc, hw/ssi: Fix some URLs for AMD / Xilinx models
 * hw/dma/xlnx_csu_dma: don't throw guest errors when stopping the SRC DMA

----------------------------------------------------------------
Frederic Konrad (3):
      hw/ssi/xilinx_spips: fix an out of bound access
      hw/misc, hw/ssi: Fix some URLs for AMD / Xilinx models
      hw/dma/xlnx_csu_dma: don't throw guest errors when stopping the SRC DMA

Peter Maydell (2):
      target/arm: Set IL bit for pauth, SVE access, BTI trap syndromes
      target/arm: Handle overflow in calculation of next timer tick

Philippe Mathieu-Daudé (8):
      hw/net/can/xlnx-zynqmp: Avoid underflow while popping TX FIFOs
      hw/net/can/xlnx-zynqmp: Avoid underflow while popping RX FIFO
      hw/virtio: Add VirtioPCIDeviceTypeInfo::instance_finalize field
      hw/virtio: Free VirtIOIOMMUPCI::vdev.reserved_regions[] on finalize()
      hw/misc/mps2-scc: Free MPS2SCC::oscclk[] array on finalize()
      hw/nvram/xlnx-efuse: Free XlnxEFuse::ro_bits[] array on finalize()
      hw/nvram/xlnx-efuse-ctrl: Free XlnxVersalEFuseCtrl[] "pg0-lock" array
      hw/input/stellaris_gamepad: Free StellarisGamepad::keycodes[] array

 include/hw/misc/xlnx-versal-cframe-reg.h   |  2 +-
 include/hw/misc/xlnx-versal-cfu.h          |  2 +-
 include/hw/misc/xlnx-versal-pmc-iou-slcr.h |  2 +-
 include/hw/ssi/xilinx_spips.h              |  3 ++
 include/hw/ssi/xlnx-versal-ospi.h          |  2 +-
 include/hw/virtio/virtio-pci.h             |  1 +
 target/arm/syndrome.h                      |  6 +--
 hw/dma/xlnx_csu_dma.c                      | 14 ++++---
 hw/input/stellaris_gamepad.c               |  8 ++++
 hw/misc/mps2-scc.c                         |  8 ++++
 hw/net/can/xlnx-zynqmp-can.c               | 67 +++++++++++++++++++++++++-----
 hw/nvram/xlnx-efuse.c                      |  8 ++++
 hw/nvram/xlnx-versal-efuse-ctrl.c          |  8 ++++
 hw/ssi/xilinx_spips.c                      |  7 +++-
 hw/virtio/virtio-iommu-pci.c               |  8 ++++
 hw/virtio/virtio-pci.c                     |  1 +
 target/arm/helper.c                        | 25 +++++++++--
 tests/tcg/aarch64/system/vtimer.c          | 48 +++++++++++++++++++++
 tests/tcg/aarch64/Makefile.softmmu-target  |  7 +++-
 19 files changed, 198 insertions(+), 29 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/vtimer.c

