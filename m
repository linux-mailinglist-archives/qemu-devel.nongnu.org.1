Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 762FB7476DD
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 18:37:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGj1C-0001HN-1I; Tue, 04 Jul 2023 12:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj16-0001FF-5J
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:40 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj13-0001nc-NU
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:39 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbc0981733so57480835e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 09:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688488596; x=1691080596;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ci4IbaJ/1ntkxKqq71OAalsKGMAxUtPWVXyuj8W5Pb8=;
 b=npCL/Dpvxy5sJbRhmWC7dz2Oy5nCvg2wQRrP9e20oNX8llMPyc0oouukJ7DPPiDSL7
 srluH69+/FkxnQc8cgXS9T0E1x4dn7Bnqud6e5xtcNvUDWxjI/6/xmzGEWzD7MlaGN1n
 lS2b5u5FrvsxSpW1o5k76MC1lTGwZLKn2s6EcRt+dJBwZYb8zqCEfG3KPtZrd6YDt/a6
 SfTc0tYcnAXU3XxWkg0ecuHdk7GhztseX3VtF7GWIaC6yF+KOd4kj8n17Y0JpLi44OqM
 ykek/XYLChyAO76MvNWXvJDO26Jg0C34nSkBs+2X0bmN40JPf9JxlUylsRPMtdC+klk/
 xsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688488596; x=1691080596;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ci4IbaJ/1ntkxKqq71OAalsKGMAxUtPWVXyuj8W5Pb8=;
 b=cupzzpPHQEjKtxxtMqjvZ4NvAgYnsW1u4bMoOwU3m+mn6NaRJRSmavLvs6bBLXQHQK
 CmDC2bTVLVuRdgBGmc9Q1z1VFOcKcSBf1uygmaspIvDQ15Ctff8FlVIdpRD0BksIaYgq
 RpW0iWngBLpehFrtt1WZavVVqxOrr5O3mPFrb4a2d9tqps9iLLfwJb/Zulsad5oK/T4Y
 dSuUaQxQDXC7ieOCfvWhWNcuuvN2H8rXix5A48LX+9o61jQR3pMLa86t5tfdSQQxzhqd
 Mi8fsKI6JVe0n2wO4XqMaqRqE0XEB5HbHwlfJHbKPO4LQWhfSugENMQG+nne7T54EG5s
 WCFA==
X-Gm-Message-State: AC+VfDwvXSWGjIOOkZjXWNnErM3l2pQVMhdZxtOjvwSfmN1KD0kO1GQ5
 iV3DcPsF3cbiLEC7yZltQ5WAQjCzd3jdXNNm3wM=
X-Google-Smtp-Source: ACHHUZ7R1itlWycT0A02f+z/giEPdqK8ZVhWjlZIWKllrSPXld9e8a6jEz9SFxNmcZkB9io2W4CoVA==
X-Received: by 2002:a7b:cb86:0:b0:3fb:a62d:1992 with SMTP id
 m6-20020a7bcb86000000b003fba62d1992mr10955857wmi.0.1688488595848; 
 Tue, 04 Jul 2023 09:36:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a056000014800b003143b032b7asm4354258wrx.116.2023.07.04.09.36.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 09:36:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] target-arm queue
Date: Tue,  4 Jul 2023 17:36:23 +0100
Message-Id: <20230704163634.3188465-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Just a collection of bug fixes this time around...

thanks
-- PMM

The following changes since commit 2a6ae69154542caa91dd17c40fd3f5ffbec300de:

  Merge tag 'pull-maintainer-ominbus-030723-1' of https://gitlab.com/stsquad/qemu into staging (2023-07-04 08:36:44 +0200)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20230704

for you to fetch changes up to 86a78272f094857b4eda79d721c116e93942aa9a:

  target/xtensa: Assert that interrupt level is within bounds (2023-07-04 14:27:08 +0100)

----------------------------------------------------------------
target-arm queue:
 * Add raw_writes ops for register whose write induce TLB maintenance
 * hw/arm/sbsa-ref: use XHCI to replace EHCI
 * Avoid splitting Zregs across lines in dump
 * Dump ZA[] when active
 * Fix SME full tile indexing
 * Handle IC IVAU to improve compatibility with JITs
 * xlnx-canfd-test: Fix code coverity issues
 * gdbstub: Guard M-profile code with CONFIG_TCG
 * allwinner-sramc: Set class_size
 * target/xtensa: Assert that interrupt level is within bounds

----------------------------------------------------------------
Akihiko Odaki (1):
      hw: arm: allwinner-sramc: Set class_size

Eric Auger (1):
      target/arm: Add raw_writes ops for register whose write induce TLB maintenance

Fabiano Rosas (1):
      target/arm: gdbstub: Guard M-profile code with CONFIG_TCG

John Högberg (2):
      target/arm: Handle IC IVAU to improve compatibility with JITs
      tests/tcg/aarch64: Add testcases for IC IVAU and dual-mapped code

Peter Maydell (1):
      target/xtensa: Assert that interrupt level is within bounds

Richard Henderson (3):
      target/arm: Avoid splitting Zregs across lines in dump
      target/arm: Dump ZA[] when active
      target/arm: Fix SME full tile indexing

Vikram Garhwal (1):
      tests/qtest: xlnx-canfd-test: Fix code coverity issues

Yuquan Wang (1):
      hw/arm/sbsa-ref: use XHCI to replace EHCI

 docs/system/arm/sbsa.rst          |   5 +-
 hw/arm/sbsa-ref.c                 |  23 +++--
 hw/misc/allwinner-sramc.c         |   1 +
 target/arm/cpu.c                  |  65 ++++++++-----
 target/arm/gdbstub.c              |   4 +
 target/arm/helper.c               |  70 +++++++++++---
 target/arm/tcg/translate-sme.c    |  24 +++--
 target/xtensa/exc_helper.c        |   3 +
 tests/qtest/xlnx-canfd-test.c     |  33 +++----
 tests/tcg/aarch64/icivau.c        | 189 ++++++++++++++++++++++++++++++++++++++
 tests/tcg/aarch64/sme-outprod1.c  |  83 +++++++++++++++++
 hw/arm/Kconfig                    |   2 +-
 tests/tcg/aarch64/Makefile.target |  13 ++-
 13 files changed, 436 insertions(+), 79 deletions(-)
 create mode 100644 tests/tcg/aarch64/icivau.c
 create mode 100644 tests/tcg/aarch64/sme-outprod1.c

