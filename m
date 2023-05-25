Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F42271134B
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:12:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQA-0008KM-VD; Thu, 25 May 2023 14:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQ9-0008Jt-IY
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:41 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQ7-0005qQ-Ki
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:41 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d577071a6so52318b3a.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038237; x=1687630237;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=GxJHOoQNtuW2GBLhr39GmqXx79tIU7ZtrnBz6ePI+1c=;
 b=fToUoziSUXgONL/fxtXtpGGVo+yGn4Wl2EjTpZCen3DHzh/cMyhEXO6ANCLhY7ACY+
 3oHU9EijLtGKNEBcC2jr0HjLqupd90CPbBYtUU7Gu+yDfZAeFvdc8uwxroy0moeHip9t
 SauKygz4PJfCc4cV+PVY220+Ee5n1SnlIHTAe/pBx06hIsM7pLaJDZO4Sb/mAZdXxRF0
 ZT+alK0e9iJCtzk747pjDYGKtUG1aYjX/i0OeS59s71Je+Qe0yooJT3o3LsblSGvS357
 1IK+XaeQwAsNz7hEW7ilyUbcL1VQ+pg7k6d2qPWAO9gLpxiIiCCbwhpKldpulnblWdKj
 B+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038237; x=1687630237;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GxJHOoQNtuW2GBLhr39GmqXx79tIU7ZtrnBz6ePI+1c=;
 b=PBgE7wRUR1BklcylagWzz9Rf26aZvW3HbZf6Zy5sXTl/9y8YCHwavDhW4RRoyAsljk
 Cbqpy74kMH2huCdoGce+qa0tdgf7ydLCVdRaLe6w+1G/N3HcJQoRkk84s766jcEpdHqd
 2rzcX2AjIGvc44iyFgAlLb8gd5A9IWGLs55cPFWgBrbZdifHWC8bRy8Ag5cTPRkC6oRz
 MTQ6sVHHwuoKb/Ln/oKv4CSZDhw2QDyuKfj65L1pt7Rx0thoruYZt+TI9B0VqKdEauJJ
 226vmfyQnjp9yMXFOWEvT2DucSND2+a6bA+aRuCyQqkATTyr8lb6xvAip9eAJI5PO4AZ
 Wg2A==
X-Gm-Message-State: AC+VfDx/4T0v+OVCEeiiZ1ePAvLGI4zWehkNDSMFzAjhBQNvYnIA4YMZ
 XtTW2rPvuzZik0h/tUAYQ4ozEHGABZoaNJHQFJc=
X-Google-Smtp-Source: ACHHUZ6VB5n2ov4QN8l/rbztSbC0gFV3JoWVtp6ZbSl4NvNz5Om3noHxe3/+BfZZNmJ8H/5+lyYZkg==
X-Received: by 2002:a05:6a21:6d9f:b0:10a:e388:fcb5 with SMTP id
 wl31-20020a056a216d9f00b0010ae388fcb5mr23568900pzb.13.1685038237635; 
 Thu, 25 May 2023 11:10:37 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/23] tcg patch queue
Date: Thu, 25 May 2023 11:10:13 -0700
Message-Id: <20230525181036.1559435-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

The following changes since commit b300c134465465385045ab705b68a42699688332:

  Merge tag 'pull-vfio-20230524' of https://github.com/legoater/qemu into staging (2023-05-24 14:23:41 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230525

for you to fetch changes up to a30498fcea5a8b9c544324ccfb0186090104b229:

  tcg/riscv: Support CTZ, CLZ from Zbb (2023-05-25 15:29:36 +0000)

----------------------------------------------------------------
tcg/mips:
  - Constant formation improvements
  - Replace MIPS_BE with HOST_BIG_ENDIAN
  - General cleanups
tcg/riscv:
  - Improve setcond
  - Support movcond
  - Support Zbb, Zba

----------------------------------------------------------------
Richard Henderson (23):
      tcg/mips: Move TCG_AREG0 to S8
      tcg/mips: Move TCG_GUEST_BASE_REG to S7
      tcg/mips: Unify TCG_GUEST_BASE_REG tests
      tcg/mips: Create and use TCG_REG_TB
      tcg/mips: Split out tcg_out_movi_one
      tcg/mips: Split out tcg_out_movi_two
      tcg/mips: Use the constant pool for 64-bit constants
      tcg/mips: Aggressively use the constant pool for n64 calls
      tcg/mips: Try tb-relative addresses in tcg_out_movi
      tcg/mips: Try three insns with shift and add in tcg_out_movi
      tcg/mips: Use qemu_build_not_reached for LO/HI_OFF
      tcg/mips: Replace MIPS_BE with HOST_BIG_ENDIAN
      disas/riscv: Decode czero.{eqz,nez}
      tcg/riscv: Probe for Zba, Zbb, Zicond extensions
      tcg/riscv: Support ANDN, ORN, XNOR from Zbb
      tcg/riscv: Support ADD.UW, SEXT.B, SEXT.H, ZEXT.H from Zba+Zbb
      tcg/riscv: Use ADD.UW for guest address generation
      tcg/riscv: Support rotates from Zbb
      tcg/riscv: Support REV8 from Zbb
      tcg/riscv: Support CPOP from Zbb
      tcg/riscv: Improve setcond expansion
      tcg/riscv: Implement movcond
      tcg/riscv: Support CTZ, CLZ from Zbb

 tcg/mips/tcg-target.h          |   3 +-
 tcg/riscv/tcg-target-con-set.h |   3 +
 tcg/riscv/tcg-target-con-str.h |   1 +
 tcg/riscv/tcg-target.h         |  48 ++--
 disas/riscv.c                  |   6 +
 tcg/mips/tcg-target.c.inc      | 308 ++++++++++++++++-----
 tcg/riscv/tcg-target.c.inc     | 612 ++++++++++++++++++++++++++++++++++++-----
 7 files changed, 825 insertions(+), 156 deletions(-)

