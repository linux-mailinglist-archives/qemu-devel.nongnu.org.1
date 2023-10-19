Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 224357CF4CD
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:11:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPzG-0005ie-EN; Thu, 19 Oct 2023 06:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qtPzE-0005hi-4J
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:10:40 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qtPzC-0007Ci-6W
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:10:39 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5a9bc2ec556so4367087a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697710236; x=1698315036;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fJmQ/uXUmiylzp9kqbV6/kvWoPNYRWaGyW2oh607eSU=;
 b=wpLmUQsJiFKbQLM6io3vj735XW15VKmRjIogIjokLInukceI3LrcfRslOGSeAsA7If
 r3308uJRfajPE7119O+OwxksSCOyrbE2FAkFZ7ii4sr4XJqxC4UoHj8EDUAYpoRT1gTv
 iQdms2OKRjlV2ZQloRPnAYJR9qHehk8V9hsw/fBsT18KC9r5YNw+RF+8CExpOVm74x/z
 rgLVS8ApFqkTyLLawOkwbiGqunSIAbl8vfgYIQ4A0R3cK4Q/OvFpx2zVewSbC+q0YIoE
 q5xEMTRNyUMeFBzPxmgcEook/aRgGqO/XmQAiQdxbaPDsvmFfDp5zH2v5YHsACx45C6T
 2azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697710236; x=1698315036;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fJmQ/uXUmiylzp9kqbV6/kvWoPNYRWaGyW2oh607eSU=;
 b=bQS0MQySI6MQLA8nLZ4Tu50d1SgPF0XkCwoFYmFZXd7SpIsW1Xm4ctaaboVVxjb8Pa
 H5n6yEatGQe1uxjTJxbuEqJgHjdga5xV34VzBoBv6lRrck+6kFNppT+DuT0yi0zucvL2
 VGMbKmOjOgG5WBABtkzMLZsrrXSIIeaPwAiNdCc8bxpYBhU7Nt54vrgFeoPdipFCZzsL
 n3eQugbvGgaeJFkEzKscuD54i2aVivR5H6FuI35JD598hYb28aA/sozTLZdBvMIxD8dA
 AaJYkwUMiRUxEbzGaREiWc7mxFSL64DzGOJhnKkq2UIsH5nI7f5wMLFBQc5xCRyyHL25
 QoVQ==
X-Gm-Message-State: AOJu0Yzgo0KTyQML9a4KAZj2PvEU/DqF57jXO8kMTqAzU0xkTXMMi0e5
 0p1vTAK5v6EdEeLeEqtwm4dYCw==
X-Google-Smtp-Source: AGHT+IEUwHrQf5SudLdmU+b0tmr9FlfGQ/UnGSVsCk0HzRk2a30WKkpTZpM7JWftjxUFToKk9Akj7g==
X-Received: by 2002:a05:6a20:4295:b0:17a:fcda:4a6b with SMTP id
 o21-20020a056a20429500b0017afcda4a6bmr1650231pzj.13.1697710236479; 
 Thu, 19 Oct 2023 03:10:36 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 oj3-20020a17090b4d8300b0027d0adf653bsm1243601pjb.7.2023.10.19.03.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 03:10:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 0/6] gdbstub and TCG plugin improvements
Date: Thu, 19 Oct 2023 19:10:22 +0900
Message-ID: <20231019101030.128431-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This series extracts fixes and refactorings that can be applied
independently from "[PATCH v9 00/23] plugins: Allow to read registers".

The patch "target/riscv: Move MISA limits to class" was replaced with
patch "target/riscv: Move misa_mxl_max to class" since I found instances
may have different misa_ext_mask.

V4 -> V5:
  Added patch "hw/riscv: Use misa_mxl instead of misa_mxl_max".

V3 -> V4:
  Added patch "gdbstub: Check if gdb_regs is NULL".

V2 -> V3:
  Restored patch sets from the previous version.
  Rebased to commit 800485762e6564e04e2ab315132d477069562d91.

V1 -> V2:
  Added patch "target/riscv: Do not allow MXL_RV32 for TARGET_RISCV64".
  Added patch "target/riscv: Initialize gdb_core_xml_file only once".
  Dropped patch "target/riscv: Remove misa_mxl validation".
  Dropped patch "target/riscv: Move misa_mxl_max to class".
  Dropped patch "target/riscv: Validate misa_mxl_max only once".

Akihiko Odaki (6):
  gdbstub: Check if gdb_regs is NULL
  hw/riscv: Use misa_mxl instead of misa_mxl_max
  target/riscv: Remove misa_mxl validation
  target/riscv: Move misa_mxl_max to class
  target/riscv: Validate misa_mxl_max only once
  plugins: Remove an extra parameter

 target/riscv/cpu-qom.h     |   1 +
 target/riscv/cpu.h         |   3 +-
 accel/tcg/plugin-gen.c     |   9 +--
 gdbstub/gdbstub.c          |  34 +++++----
 hw/riscv/boot.c            |   2 +-
 target/riscv/cpu.c         | 139 ++++++++++++++++++++++---------------
 target/riscv/gdbstub.c     |  12 ++--
 target/riscv/kvm/kvm-cpu.c |  10 +--
 target/riscv/machine.c     |   7 +-
 target/riscv/tcg/tcg-cpu.c |  42 ++---------
 target/riscv/translate.c   |   3 +-
 11 files changed, 131 insertions(+), 131 deletions(-)

-- 
2.42.0


