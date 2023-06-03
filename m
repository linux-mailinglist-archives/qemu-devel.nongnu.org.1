Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 111E57213C7
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 01:37:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5anS-0005Lb-Rm; Sat, 03 Jun 2023 19:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q5anM-0005LD-2H; Sat, 03 Jun 2023 19:36:28 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q5anK-0003RF-At; Sat, 03 Jun 2023 19:36:27 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1b04706c85fso32992085ad.0; 
 Sat, 03 Jun 2023 16:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685835384; x=1688427384;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ncrfeY3IOUhN2LYU7rU9Q8rvXcl8LA4fNR6g5cp39Sw=;
 b=KHWFIebJXNm8JNSkg4ABdW/tNASF8t4U/T6ipEBt4is44dGPBzt5uWNOz+n/8/Unyd
 8VdgTz/m7JnQDiQH9vIct1KrI0hXXHCGEzgM0BkTAeZultN8YvS1iXLzkmbA1flimJAO
 dNmnbQazeQgs8yRME3mXMVSkDxPZN9/vm7WQphqEfCJcLEBfc/qKdNUiLm1GAZ5ZPlgS
 Xhk/dyQGekvjYSQSvGSA/FrbCv5QPvM77UGp/BWQkqs8ux34dM6EsSlHRt+MGmTjc3bJ
 +fAPJ8QlRHpuaykJhMjTCcRWFJAgqxT9NBY1UNc51MGTdo/XVS+AbNqkdzdD7SMkqC1i
 +UHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685835384; x=1688427384;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ncrfeY3IOUhN2LYU7rU9Q8rvXcl8LA4fNR6g5cp39Sw=;
 b=fxxZ8eyukdM3uSZPuXXG++YPHkhgLFUXGX7LkGlpb23lXjK3DZd6LSdA+yUcya/6Gr
 8B4FjfjGcidzfYd1QjBMry3lHpk3i2AhSAW4K2EF+nOWGhVzUZwLXnp0XToGM5dEfY9H
 4f7j7bFLxo4/AEO2R5WUtsi5LEB7ogsJEQcOSMPbD+G18slsWJc6fZenHe9jNdE101R2
 kIbKd9XpO42+rYFzXEYBcdz+wzXMtiYixp/enh1Rbm8/4Yyd7y3LQ+zpTU6+c1yHLWV1
 7otb78HJFufV0S0s7q9hVIdHI5Xr5XQsQnf67ZVJWcc5S1l+zFs+PWi/vakawqiTcYx0
 l8vQ==
X-Gm-Message-State: AC+VfDyt99D6gKGMLSBhwsX1A1UcvSF3CgrAY7/R0wv2gW8Lar8QlT43
 i6VUKkOymO/V/dw8ZetLwxXE+ac0P6g=
X-Google-Smtp-Source: ACHHUZ5hSRMyiDAYuFDH0viC5J79scqWUSfbwotNns/Pn7pU4XetVaL5ipPDnrgE8pCm0gaV3VId8Q==
X-Received: by 2002:a17:902:f7c5:b0:1af:d812:d16 with SMTP id
 h5-20020a170902f7c500b001afd8120d16mr3408894plw.21.1685835383761; 
 Sat, 03 Jun 2023 16:36:23 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 io23-20020a17090312d700b001aface7bdd8sm3743533plb.31.2023.06.03.16.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 16:36:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 0/4] ppc/pnv: Add chiptod and core timebase state machine
 models
Date: Sun,  4 Jun 2023 09:36:08 +1000
Message-Id: <20230603233612.125879-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This adds support for chiptod and core timebase state machine models in
the powernv POWER9 and POWER10 models.

This does not actually change the time or the value in TB registers
(because they are alrady synced in QEMU), but it does go through the
motions. It is enough to be able to run skiboot's chiptod initialisation
code that synchronises core timebases (after a patch to prevent skiboot
skipping chiptod for QEMU, posted to skiboot mailing list).

Sorry there was some delay since the last posting. There is a bit more
interest in this recently but feedback and comments from RFC was not
forgotten and is much appreciated.

https://lists.gnu.org/archive/html/qemu-ppc/2022-08/msg00324.html

I think I accounted for everything except moving register defines to the
.h file. I'm on the fence about that but if they are only used in the .c
file I think it's okay to keep them there for now. I cut out a lot of
unused ones so it's not so cluttered now.

Lots of other changes and fixes since that RFC. Notably:
- Register names changed to match the workbook names instead of skiboot.
- TFMR moved to timebase_helper.c from misc_helper.c
- More comprehensive model and error checking, particularly of TFMR.
- POWER10 with multi-chip support.
- chiptod and core timebase linked via specific state instead of TFMR.

There is still a vast amount that is not modeled, but most of it related
to error handling, injection, failover, etc that is very complicated and
not required for normal operation.

Thanks,
Nick

Nicholas Piggin (4):
  pnv/chiptod: Add POWER9/10 chiptod model
  target/ppc: Tidy POWER book4 SPR registration
  target/ppc: add TFMR SPR implementation with read and write helpers
  target/ppc: Implement core timebase state machine and TFMR

 hw/ppc/meson.build           |   1 +
 hw/ppc/pnv.c                 |  38 +++
 hw/ppc/pnv_chiptod.c         | 488 +++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_xscom.c           |   2 +
 hw/ppc/trace-events          |   4 +
 include/hw/ppc/pnv_chip.h    |   3 +
 include/hw/ppc/pnv_chiptod.h |  64 +++++
 include/hw/ppc/pnv_core.h    |   3 +
 include/hw/ppc/pnv_xscom.h   |   9 +
 target/ppc/cpu.h             |  40 +++
 target/ppc/cpu_init.c        |  92 ++++---
 target/ppc/helper.h          |   2 +
 target/ppc/spr_common.h      |   2 +
 target/ppc/timebase_helper.c | 156 +++++++++++
 target/ppc/translate.c       |  10 +
 15 files changed, 882 insertions(+), 32 deletions(-)
 create mode 100644 hw/ppc/pnv_chiptod.c
 create mode 100644 include/hw/ppc/pnv_chiptod.h

-- 
2.40.1


