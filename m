Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7320882D434
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 07:32:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPGVf-0000IL-6F; Mon, 15 Jan 2024 01:31:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rPGVd-0000I4-Gx
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:31:45 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rPGVb-0005fG-TW
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:31:45 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5988e55ede0so2787858eaf.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 22:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1705300301; x=1705905101;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KoYDajsBgHfZG/iBiq9tr0m8YQaVp+0yt1Vy1FnPAsw=;
 b=ZmDhIf04SRg3YgvM8c2a78JpUba5Yk4XcGzeOquAWv7ygpZ+mFbF1d7V3Bylh8ZTGp
 MXcLGf2WiJQJn2yvgpF69Tt5Z8aatf96oHYkeF2AhfgZXso8seSqB4G5LHW5pZ415SHg
 LiAbPazWE5jEVjg1NBLnAxI4tsHt9/bEP6AUdVUO40NA014Qzq6eSHRrX3uzybz/DRNV
 1UtzJpDmaQrJVzV49x3ziP1ICtA/v9M/ELZLzX2+59ZpvKfFrbD1MlRvulJGUyTrvaEe
 zX0qc62VjaQRl29f2eYVrRbljFlBlwIOnEpA7lnUtuVxZEW4ez30Gn3J6rkN67Ixgs/4
 hk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705300301; x=1705905101;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KoYDajsBgHfZG/iBiq9tr0m8YQaVp+0yt1Vy1FnPAsw=;
 b=Y0Yv5A5zfrj0oTTnB3M6HlqqYlgkPEdiUQVBt/kkxmZZBR6kQFeSPqUXEBcteJwBzR
 CmRzIdwLUVtarKSPgRsvAQa2nonlAOxp2gNUH8PhK2FNY2y9ymm0HJmF41zNAdeyUKbg
 Z44yMy8zW5mUG+1uznmHyXRGXmzW+mJhOjbYiR2A4+RSwjdTzLRjxOV27GZuUWwyO3gw
 UH0psUYti0mpsop2vreo0QtGjpzVlLgpICGT9yT4Bu4iRAM5FvN++wlPpgomYkENv88N
 O0ceubswEM983vQlMgynF44JkoeDXKyljCAJ5hXdhfpbJWjx+9QTgwvohvraCR9f7Unm
 TfkQ==
X-Gm-Message-State: AOJu0YyI0S4RiU5t3lXdAAjNl2eKpDfL7m/3qx1KZIxlUMzGjUymwWWJ
 aq1nFtTSYwyEQDW7klu0BZxlU8qWdR4qLQ==
X-Google-Smtp-Source: AGHT+IFLtOfvGnZklPl5Av/R1kQmqpEtArqkz2KUKx0vraX6puDaZh9i68FMl2Yz03+/2Kxj/8hOdg==
X-Received: by 2002:a05:6359:28c8:b0:175:d192:946 with SMTP id
 qb8-20020a05635928c800b00175d1920946mr2421795rwb.2.1705300301495; 
 Sun, 14 Jan 2024 22:31:41 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 e16-20020aa78c50000000b006da0372200asm6898823pfd.184.2024.01.14.22.31.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jan 2024 22:31:39 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v9 0/4] gdbstub and TCG plugin improvements
Date: Mon, 15 Jan 2024 15:31:25 +0900
Message-Id: <20240115-riscv-v9-0-ff171e1aedc8@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD3RpGUC/12MywrCMBQFf6VkbSQPm4cr/0NcpLeJvQtbSSS0l
 Py7aUFQl3M4MytJPqJP5NysJPqMCaexgj00BAY33j3FvjIRTEguuKQRE2QaAKw6MWsUBFK/z+g
 Dznvneqs8YHpNcdmzWW/rfyFryqjTivFWOSl1uPRuGXE+wvQgWyKbb818NFM1sF0QHW+N6PWPV
 kp5Azhd5A/SAAAA
To: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Mikhail Tyutin <m.tyutin@yadro.com>, 
 Aleksandr Anenkov <a.anenkov@yadro.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

V6 -> V7:
  Rebased.

V5 -> V6:
  Added patch "default-configs: Add TARGET_XML_FILES definition".
  Rebased.

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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v9:
- Rebased to commit 977542ded7e6b28d2bc077bcda24568c716e393c.
- Link to v8: https://lore.kernel.org/r/20231218-riscv-v8-0-c9bf2b1582d7@daynix.com

Changes in v8:
- Added a more detailed explanation for patch "hw/riscv: Use misa_mxl
  instead of misa_mxl_max". (Alistair Francis)
- Link to v7: https://lore.kernel.org/r/20231213-riscv-v7-0-a760156a337f@daynix.com

---
Akihiko Odaki (4):
      hw/riscv: Use misa_mxl instead of misa_mxl_max
      target/riscv: Remove misa_mxl validation
      target/riscv: Move misa_mxl_max to class
      target/riscv: Validate misa_mxl_max only once

 target/riscv/cpu.h         |   4 +-
 hw/riscv/boot.c            |   2 +-
 target/riscv/cpu.c         | 183 ++++++++++++++++++++++++++-------------------
 target/riscv/gdbstub.c     |  12 ++-
 target/riscv/kvm/kvm-cpu.c |  10 +--
 target/riscv/machine.c     |   7 +-
 target/riscv/tcg/tcg-cpu.c |  44 ++---------
 target/riscv/translate.c   |   3 +-
 8 files changed, 134 insertions(+), 131 deletions(-)
---
base-commit: 977542ded7e6b28d2bc077bcda24568c716e393c
change-id: 20231213-riscv-fcc9640986cf

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


