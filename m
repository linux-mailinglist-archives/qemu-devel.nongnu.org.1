Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 300597F2A50
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:25:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Nw5-0004L8-6R; Tue, 21 Nov 2023 05:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Nw0-0004Hr-UM
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:24:48 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Nvx-0007EO-Pq
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:24:48 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50aab3bf71fso3209346e87.3
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 02:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700562283; x=1701167083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=G3p12AQx2CLYbRt4rQ1Fouz9SB3dqjhKR/td/Q1qBxk=;
 b=u9G8U2iIUev2xmw6YSM33/XFWopjS/WfpDgoMrhZ1Ltb4l5GBVyTbA9hK86KbPjGLo
 sMYDr9Sh3pYhlnzXY9YMi+kDQQM7KWtKhSdDPisHdkMHolNm9GyEh6voXT3DTtfqLsJ3
 myYRETw/zC/1SLeIPhJhQ3EjBVCfq8iKvEKYoJi5UyPLS2f6eDfP5tnvEKqsy+5qKwAn
 dNdotNtuVIjg59GkqpXrRPPuL++L1xIp2JekvvSf1ygCk37xzss5mCuV90IJWeE7WivS
 c+qRTXDm8yoy9hCn3CrgAlKdUVA23ZBQi5VV70at0c2AY2QuktU7PvfJAnUUp14fNO16
 9ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700562283; x=1701167083;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G3p12AQx2CLYbRt4rQ1Fouz9SB3dqjhKR/td/Q1qBxk=;
 b=dBZVUrm5E0skYh3mMvaftH6x8JIDF9RzNfNsfbNhKIWTS3msKrN9c9fLZV0hsKmEw0
 31FNpvdsDQwsjRMo+5XCXX64EYdMXolmmiEh5K5YNjCNp0S8aUPffF9Qo6fLf1sBvCEY
 PIl0ko1/yQFpy4IUYXwO8je297ilMArjZOI0oQkgJdzHExu0PO95tv9zoRRLou2IhU0P
 HRAIIE6PbDMhYtYSCjuIs1Lr5TTPQn1fRelVB8jxJo9U4vVKbPz+zmlkVrwtS/V4ytWk
 bV/xBR3RFfYyxtOh3kym0nY8NlMLQ29B6Q7MCdqkmU50SxOMTrDhAMmOKuAIP4rd0NeZ
 TaAg==
X-Gm-Message-State: AOJu0YxJ16MerHNld7wH4AV1e/WgVDYE/L2rTS+x1KxWmbsjj7nKyb1i
 VM2Df5JzvH+vZ696Ot1tB8v0DfWxYPt/29nU6i8=
X-Google-Smtp-Source: AGHT+IE+jbxobJ556RQqYFfcmKEBZciF7DD4UeGC0o7/782DqvrQBwmWRW5179ZJQ/3zlpyoFE9r5g==
X-Received: by 2002:a2e:bb86:0:b0:2c8:7176:1735 with SMTP id
 y6-20020a2ebb86000000b002c871761735mr5836528lje.17.1700562283468; 
 Tue, 21 Nov 2023 02:24:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n25-20020a05600c181900b00405442edc69sm20450835wmp.14.2023.11.21.02.24.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 02:24:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] target-arm queue
Date: Tue, 21 Nov 2023 10:24:33 +0000
Message-Id: <20231121102441.3872902-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

Hi; here are some arm patches for rc1; all small bug fixes and cleanups.

thanks
-- PMM

The following changes since commit af9264da80073435fd78944bc5a46e695897d7e5:

  Merge tag '20231119-xtensa-1' of https://github.com/OSLL/qemu-xtensa into staging (2023-11-20 05:25:19 -0500)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20231121

for you to fetch changes up to 0cbb56c236a4a28f5149eed227d74bb737321cfc:

  hw/arm/fsl-imx: Do not ignore Error argument (2023-11-20 15:34:19 +0000)

----------------------------------------------------------------
target-arm queue:
 * enable FEAT_RNG on Neoverse-N2
 * hw/intc/arm_gicv3: ICC_PMR_EL1 high bits should be RAZ
 * Fix SME FMOPA (16-bit), BFMOPA
 * hw/core/machine: Constify MachineClass::valid_cpu_types[]
 * stm32f* machines: Report error when user asks for wrong CPU type
 * hw/arm/fsl-imx: Do not ignore Error argument

----------------------------------------------------------------
Ben Dooks (1):
      hw/intc/arm_gicv3: ICC_PMR_EL1 high bits should be RAZ

Gavin Shan (1):
      hw/core/machine: Constify MachineClass::valid_cpu_types[]

Marcin Juszkiewicz (1):
      target/arm: enable FEAT_RNG on Neoverse-N2

Philippe Mathieu-Daudé (4):
      hw/arm/stm32f405: Report error when incorrect CPU is used
      hw/arm/stm32f205: Report error when incorrect CPU is used
      hw/arm/stm32f100: Report error when incorrect CPU is used
      hw/arm/fsl-imx: Do not ignore Error argument

Richard Henderson (1):
      target/arm: Fix SME FMOPA (16-bit), BFMOPA

 include/hw/arm/stm32f100_soc.h |  4 ----
 include/hw/arm/stm32f205_soc.h |  4 ----
 include/hw/arm/stm32f405_soc.h |  4 ----
 include/hw/boards.h            |  2 +-
 hw/arm/fsl-imx25.c             |  3 ++-
 hw/arm/fsl-imx6.c              |  3 ++-
 hw/arm/netduino2.c             |  7 ++++++-
 hw/arm/netduinoplus2.c         |  7 ++++++-
 hw/arm/olimex-stm32-h405.c     |  8 ++++++--
 hw/arm/stm32f100_soc.c         |  9 ++-------
 hw/arm/stm32f205_soc.c         |  9 ++-------
 hw/arm/stm32f405_soc.c         |  8 +-------
 hw/arm/stm32vldiscovery.c      |  7 ++++++-
 hw/hppa/machine.c              | 22 ++++++++++------------
 hw/intc/arm_gicv3_cpuif.c      |  4 ++--
 hw/m68k/q800.c                 | 11 +++++------
 target/arm/tcg/cpu64.c         |  2 +-
 target/arm/tcg/sme_helper.c    | 10 ++++------
 18 files changed, 56 insertions(+), 68 deletions(-)

