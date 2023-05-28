Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26017713AB2
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 18:50:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3JaO-0000U7-D6; Sun, 28 May 2023 12:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3JaM-0000Te-3H; Sun, 28 May 2023 12:49:38 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3JaK-0003Xk-Gs; Sun, 28 May 2023 12:49:37 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5556e2bddf9so1318286eaf.1; 
 Sun, 28 May 2023 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685292574; x=1687884574;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7jn8E7w/JpQ57f0uSpaH1bgYwuhF1P/MzpcjRm9ckjM=;
 b=Xl1lZ5/Y6PxEZgc0YgAG+eBp3j4RmAqOu3iiQgu4p0AKMRcRmX4FAi9ytrc563lq8A
 JAI3cvEN+lfJvWXx89sxJlwd6m9ynr+8CUprgAWRScXKCidbWEH6KgpKARQtDHQEAcZ7
 v2buYTuHjDLh2foS01WU2Oe9Xtq6IpXnlpqTe378M4+IBbZrjNyi9P4/QrhNmPBmPKnG
 WQBH/5QclEdOCJTG2LPaSbbBX6L12VMS0y3PtDI0fatbTPq/KmzumSpk66N2kL44Wq/t
 mruvzlFeiUhEQ9FhLF89MbOcP239EOhKWyvbl5JXm7NLy0VroIFBj3PRNA+QRh7FUQ87
 EfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685292574; x=1687884574;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7jn8E7w/JpQ57f0uSpaH1bgYwuhF1P/MzpcjRm9ckjM=;
 b=AE2iFJ7wn3izCjQLC21Bop58Kz2Squ3xAy3T39Dx9zNhS7ZgGUAXtgQgDvJez/kU3h
 RIcBuEhxmJMYKaw2XnA525zkWkUFRjuhv8qjnxKggSwN7JqU2DyqLqRsKRuos35Imi/C
 Zfs/DnmYrcduiAYEWFMlvnlYhwayjyHZkunUKK/xFmsJWTcYy19n81jUG+3AL7+x+QVk
 zkKomM8lPdmQ7u0IlBDLgHe+rL8EHl4EgD47MQVn7TaLesi2Oqy9+TRhPeHnCgPVXzpw
 qvdSSR4eSJSVurKrwkVVZwSGUE9yB8FxdI/qKVBCQqIb25f4a/X489bEP9xDY2pXMJbC
 /zWg==
X-Gm-Message-State: AC+VfDyzNGISfCMAY0BMLIF5hJ3dAx9vMuiBfZmcYoRYMeqR4IEYB4Kn
 CIFx/FPhVoJoyJQh+pN2XRXU3V5CWew=
X-Google-Smtp-Source: ACHHUZ6IpNz0qvGvcjAXh9MJ4dahaPlklcGHHjWbqZuc8ZestuK7V/CtDltgsecAv+cr91OxcvU0og==
X-Received: by 2002:a4a:9886:0:b0:555:33cd:cd76 with SMTP id
 a6-20020a4a9886000000b0055533cdcd76mr1990783ooj.2.1685292574054; 
 Sun, 28 May 2023 09:49:34 -0700 (PDT)
Received: from grind.. (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 w4-20020a4adec4000000b0054f85f67f31sm3378830oou.46.2023.05.28.09.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 May 2023 09:49:33 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: [PULL 00/10] ppc queue
Date: Sun, 28 May 2023 13:49:12 -0300
Message-Id: <20230528164922.20364-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The following changes since commit ac84b57b4d74606f7f83667a0606deef32b2049d:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-05-26 14:40:55 -0700)

are available in the Git repository at:

  https://gitlab.com/danielhb/qemu.git tags/pull-ppc-20230528

for you to fetch changes up to 56b8bfe9bb6b94184b8bbfc4be9196404a81e450:

  ppc/pegasos2: Change default CPU to 7457 (2023-05-28 13:25:45 -0300)

----------------------------------------------------------------
ppc patch queue for 2023-05-28:

This queue includes several assorted fixes for PowerPC SPR
emulation, a change in the default Pegasos2 CPU, the addition
of AIL mode 3 for spapr, a PIC->CPU interrupt fix for prep and
performance enhancements in fpu_helper.c.

----------------------------------------------------------------
Alexander Bulekov (1):
      pnv_lpc: disable reentrancy detection for lpc-hc

BALATON Zoltan (1):
      ppc/pegasos2: Change default CPU to 7457

Bernhard Beschow (1):
      hw/ppc/prep: Fix wiring of PIC -> CPU interrupt

Nicholas Piggin (5):
      target/ppc: Fix width of some 32-bit SPRs
      target/ppc: Alignment faults do not set DSISR in ISA v3.0 onward
      spapr: Add SPAPR_CAP_AIL_MODE_3 for AIL mode 3 support for H_SET_MODE hcall
      target/ppc: Use SMT4 small core chip type in POWER9/10 PVRs
      target/ppc: Add POWER9 DD2.2 model

Richard Henderson (1):
      target/ppc: Merge COMPUTE_CLASS and COMPUTE_FPRF

Richard Purdie (1):
      target/ppc: Fix fallback to MFSS for MFFS* instructions on pre 3.0 ISAs

 hw/ppc/pegasos2.c                  |  2 +-
 hw/ppc/pnv.c                       |  2 +-
 hw/ppc/pnv_core.c                  |  2 +-
 hw/ppc/pnv_lpc.c                   |  3 ++
 hw/ppc/prep.c                      |  4 +-
 hw/ppc/spapr.c                     |  9 ++++-
 hw/ppc/spapr_caps.c                | 37 ++++++++++++++++++
 hw/ppc/spapr_cpu_core.c            |  1 +
 hw/ppc/spapr_hcall.c               | 24 ++++++------
 include/hw/ppc/pnv.h               |  2 +-
 include/hw/ppc/spapr.h             |  4 +-
 target/ppc/cpu-models.c            |  4 +-
 target/ppc/cpu-models.h            |  7 ++--
 target/ppc/cpu_init.c              | 39 +++++++++++++------
 target/ppc/excp_helper.c           | 17 +++++----
 target/ppc/fpu_helper.c            | 78 +++++++++++---------------------------
 target/ppc/helper_regs.c           |  2 +-
 target/ppc/insn32.decode           | 20 ++++++----
 target/ppc/kvm.c                   |  7 ++++
 target/ppc/kvm_ppc.h               |  6 +++
 target/ppc/misc_helper.c           |  4 +-
 target/ppc/power8-pmu.c            |  2 +-
 target/ppc/spr_common.h            |  2 +-
 target/ppc/translate.c             | 26 ++++++-------
 target/ppc/translate/fp-impl.c.inc | 22 ++++++++---
 tests/qtest/device-plug-test.c     |  4 +-
 26 files changed, 201 insertions(+), 129 deletions(-)

