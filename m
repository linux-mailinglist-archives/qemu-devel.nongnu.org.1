Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 567287EA1EC
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:34:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ao3-0001WL-DS; Mon, 13 Nov 2023 12:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2anx-0001U7-9e
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:57 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2anh-0000un-90
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:57 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ce28faa92dso9125975ad.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699896759; x=1700501559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6DYj7AzYYqqqCSBjsrWmMZnzmpKWZEquydcBnmi0hEE=;
 b=TY1oTPPtfigpwg8Oi9piF8aaTyMq2cbVliFiUFGLlGg3aSLN5xfz1XKN9MPdhoCIBY
 Ux6P4r7oCk6XdZrBHNhlEiBK+WtB9OBeSB2yue5TakVEOQnsuUZXb3/bFxCO771fiR9q
 p3jy4In6bYuLg4pHQlS7rpmizcr3OEOKQ1q0sc/dlnSrAjEkPnc1m7JocCAkQd3ow2T3
 m1pObUP66zcjAd3jlka6fL+ztfQzI2aLXddhSEDIOjKCb+quhXsW2U/bZ53Fv8v/EwT/
 qPjoR2o7ppPwt9JA6O28ElZo0+7cMDwFCOf/NLEstmfF1RaQhBAAhYy52bHjJ5mCJvsk
 ptmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699896759; x=1700501559;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6DYj7AzYYqqqCSBjsrWmMZnzmpKWZEquydcBnmi0hEE=;
 b=LffDSVqxK0yykhNvREXEUchQOXAVFSCt48qhKf+3F2i37Zg8zvHRdGMac+GkQq0qN1
 Cmkp/ZMHK0s5AgHyjdHVIgJzUBH+qMrWCQoa5siPO7Cv7HXVXxxqKiIK+x7sreSQHz1K
 jTX+3dlngIwg8aJfnzPvpZOlfX8EamJRv9hhlWseQ0D0ZnPMblEDQ67+wr03pDbIxhKM
 +DZYKCKkyh65PVL6399HZtJvImIHj+P60bbYcaaKHFc0hWOj3JLn+RKgkPIl/9IARBxa
 T16YT3wNW23fqJ6UJQa0E25UFNPwcgDCOVSrASJaxChir8fE7QzcE0dRhFfFU7UC3bXB
 YiLw==
X-Gm-Message-State: AOJu0YwW2aFxTQywpuidw/A930Ff/4YHI1ZFQP17MZ36z9h4UU2iADEu
 bWYtQ3iqbCHlKeUFcr5aUFKeMXkrBdOJE2osNnU=
X-Google-Smtp-Source: AGHT+IEuKGBjzPFt6DQuGpKZTbo+S1MZaDpeSxmwKnu+zdIk7LABcQdrJjHR4ZIhdxgWE4aW7Zev+A==
X-Received: by 2002:a17:903:22c3:b0:1c8:9d32:339e with SMTP id
 y3-20020a17090322c300b001c89d32339emr266175plg.50.1699896758747; 
 Mon, 13 Nov 2023 09:32:38 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 e6-20020a170902d38600b001c731b62403sm4271910pld.218.2023.11.13.09.32.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:32:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] target/hppa: last minute hppa64 fixes
Date: Mon, 13 Nov 2023 09:32:25 -0800
Message-Id: <20231113173237.48233-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The following changes since commit 69680740eafa1838527c90155a7432d51b8ff203:

  Merge tag 'qdev-array-prop' of https://repo.or.cz/qemu/kevin into staging (2023-11-11 11:23:25 +0800)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-pa-20231113

for you to fetch changes up to f88131d931219bf76bb1bbf3bd8d6ca941a91ae3:

  hw/hppa: Require at least SeaBIOS-hppa version 12 (2023-11-13 09:21:32 -0800)

----------------------------------------------------------------
target/hppa: Mask reserved PSW bits in expand_sm_imm
target/hppa: Fix calculation of CR_IIASQ back register
target/hppa: Fix possible overflow in TLB size calculation
target/hppa: Fix probe instruction
target/hppa: Split MMU_PHYS_IDX to MMU_ABS_IDX, MMU_ABS_W_IDX
target/hppa: Reduce TARGET_PHYS_ADDR_SPACE_BITS to 40
hw/pci-host/astro: Translate 32-bit pci onto 40-bit runway bus
hw/hppa: Update SeaBIOS-hppa to version 12

----------------------------------------------------------------
Helge Deller (7):
      target/hppa: Mask reserved PSW bits in expand_sm_imm
      target/hppa: Fix calculation of CR_IIASQ back register
      target/hppa: Fix possible overflow in TLB size calculation
      hw/pci-host/astro: Fix boot for C3700 machine
      hw/hppa: Move software power button address to page zero
      target/hppa: Update to SeaBIOS-hppa from version 10 to 12
      hw/hppa: Require at least SeaBIOS-hppa version 12

Richard Henderson (5):
      target/hppa: Use only low 2 immediate bits for PROBEI
      target/hppa: Use PRIV_P_TO_MMU_IDX in helper_probe
      target/hppa: Introduce MMU_IDX_MMU_DISABLED
      target/hppa: Replace MMU_PHYS_IDX with MMU_ABS_IDX, MMU_ABS_W_IDX
      target/hppa: Reduce TARGET_PHYS_ADDR_SPACE_BITS to 40

 target/hppa/cpu-param.h   |   3 +-
 target/hppa/cpu.h         |  25 ++++++------
 hw/hppa/machine.c         |   5 ++-
 hw/pci-host/astro.c       |  73 +++++++++++++++-------------------
 target/hppa/int_helper.c  |   2 +-
 target/hppa/mem_helper.c  |  97 +++++++++++++++++++++++++++-------------------
 target/hppa/op_helper.c   |   5 ++-
 target/hppa/translate.c   |  41 +++++++++++---------
 hw/pci-host/meson.build   |   2 +-
 pc-bios/hppa-firmware.img | Bin 755480 -> 681332 bytes
 roms/seabios-hppa         |   2 +-
 11 files changed, 137 insertions(+), 118 deletions(-)

