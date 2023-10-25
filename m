Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D95B7D7089
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 17:15:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfa8-00050W-Pu; Wed, 25 Oct 2023 11:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qvfa6-00050M-Sf
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:14:02 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qvfa0-0003WS-4e
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:14:02 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ca74e77aecso7616085ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 08:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1698246833; x=1698851633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rzFLCG1dD0DWc3iy0SenmxGvSX8q6ni48ZXSBYJ5zDw=;
 b=mXvyXZpyuGMq9X6pZk7QJ/s3DzAzBQa5mT8mMouUXAeCMGYpTRNcAwPJkjXD57BS4f
 bYsQu0uuRk/rogH1TcJjkS/ff9MlnhND5r/Ntfa+LepcIVYl558XCMSQNXowNAyAknSy
 ZD94t3vyKNvTxhiYBQSA1p2VNUj3qhoL5WbeVP76nIO3sDsu+AlUfdxEq8CJO4HG3Jtm
 wgDRTxkYFT0b44Vdnd0eGwyDiPXuk8lFi6YVZtDFTWvib9uvOgrsRsEOSVia9+IlKsT4
 bUE0sGUnSNblXwvXlnscrcVf0xl2otGaD1TI2CTeTgAncLTdzNpWJ66yNTPUtsaHTNnT
 hLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698246833; x=1698851633;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rzFLCG1dD0DWc3iy0SenmxGvSX8q6ni48ZXSBYJ5zDw=;
 b=Fjf69KRXH9JOD2l2O7XotIad5V8Ah4ZOyUMxXjVoGj46lUSLF8m6X1S+aUiDvnX53H
 ua7MfjlpRkpEAfJpDzV3mTgw/lP7oO8j72eNpCoJETR8tqx3L+ymSCmjVaB7t9nxDIZt
 L0smXBTh0b4XQBavcehKIJvk9PIwN6kvlLRVq28WuszbNcimsOrpwJX6kCo0bYk0Ca17
 UAZrJW7FgiXHjizBRtY7ZWBNnupglHpF8rJeQZ7C5qXgGA/TE2w9l24p9XplDnDkr373
 rmnfalPlsRnbgetdffdlcNqF8uSS+svpk1suXKeie0XEi3L+QAHBqOcm4t8OK1J+sayL
 kvEQ==
X-Gm-Message-State: AOJu0Yxp7LK9kntfGlVfB0MwALS2ivicTlJeztVjEBeNLAQuZoVs+zQ4
 DH+2fmz+vmfCrJ4MhKZunye8MZ6T8W69uUec8rXK2YEZRNzq4fgiXtSo2ZD7jNVlqAjfTCng0rP
 KbtsTpAvcpGwqKa4uQU16hsRZI0PHHG6csRnopKxyvoNRO0H734ig9rnCBiFyFLSIO+upL1GUdD
 Fi
X-Google-Smtp-Source: AGHT+IFEjX9ROLdZZ5HmOGjEYZy7Bv5nSmcTXZxcrRcugY4fy6jMOVcvIT4/Rz/iV4hR19D91yWrUw==
X-Received: by 2002:a17:902:ce85:b0:1ca:c490:8548 with SMTP id
 f5-20020a170902ce8500b001cac4908548mr23761265plg.19.1698246832465; 
 Wed, 25 Oct 2023 08:13:52 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 w14-20020a63160e000000b005b8ebef9fa0sm2677807pgl.83.2023.10.25.08.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 08:13:51 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>
Subject: [PATCH 00/14] Update RISC-V vector crypto to ratified v1.0.0
Date: Wed, 25 Oct 2023 23:13:24 +0800
Message-Id: <20231025151341.725477-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patchset updates the RISC-V vector cryptography support to the
ratified version v1.0.0 (commit 1769c26, released on 2023/10) with
following items:

- Add Zvkb, Zvkt, and other shorthand extensions(Zvkn, Zvknc, Zvkng,
  Zvks, Zvksc, Zvksg).
- Supports the disassembler for vector crypto extensions.
- Move vector crypto extensions from experimental extensions to ratified
  extensions.
- Replace TAB indentations with spaces in disas/riscv.c.

https://github.com/riscv/riscv-crypto/releases/tag/v1.0.0

Max Chou (14):
  target/riscv: Add cfg property for Zvkt extension
  target/riscv: Expose Zvkt extension property
  target/riscv: Add cfg property for Zvkb extension
  target/riscv: Replace Zvbb checking by Zvkb
  target/riscv: Expose Zvkb extension property
  target/riscv: Add cfg properties for Zvkn[c|g] extensions
  target/riscv: Expose Zvkn[c|g] extnesion properties
  target/riscv: Add cfg properties for Zvks[c|g] extensions
  target/riscv: Expose Zvks[c|g] extnesion properties
  target/riscv: Move vector crypto extensions to riscv_cpu_extensions
  disas/riscv: Add rv_fmt_vd_vs2_uimm format
  disas/riscv: Add rv_codec_vror_vi for vror.vi
  disas/riscv: Add support for vector crypto extensions
  disas/riscv: Replace TABs with space

 disas/riscv.c                            | 154 ++++++++++++++++++++++-
 disas/riscv.h                            |   2 +
 target/riscv/cpu.c                       |  36 ++++--
 target/riscv/cpu_cfg.h                   |   8 ++
 target/riscv/insn_trans/trans_rvvk.c.inc |  37 ++++--
 target/riscv/tcg/tcg-cpu.c               |  48 ++++++-
 6 files changed, 256 insertions(+), 29 deletions(-)

-- 
2.34.1


