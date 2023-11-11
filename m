Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 612287E878C
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 02:33:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1crC-00022m-9M; Fri, 10 Nov 2023 20:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1crA-00022Y-RP
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:32:16 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1cr9-0001a7-A5
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:32:16 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6bf03b98b9bso2839472b3a.1
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 17:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699666333; x=1700271133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fb5l/7MPtXVWmzjrSLllnNYFSmujLY1Dpe/f8MAB7EY=;
 b=aisCXH8y0B5vzjYLOkJ9u915TISuuBei/mZZEyTqusGwGwQhZdeLYnd+4RWXODLgW9
 ZOlMG88f2bGWnpmIymeMZ4MvS+ByLWAgUrpXQDuuV9Mf97xpeYQe4GfdltM35bRGHsfp
 URnH64EkSYMQrn5WDQCzimYO9u0AxpqMZJ2acpSu1Rk9Qf5BQDHBtCrXpBnpNAI4eA9A
 vcEneYNfSzIDiLZFu2maMgGEzE82lju1QwqSGQf3rg19B2STRb63onp3KMgglj5GPwfK
 y9li+U+qbwX827lYsXm08EkuVB9i098Y6KYValsz118BQV8riyvUeJD1l1n4SpIOOntQ
 hVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699666333; x=1700271133;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fb5l/7MPtXVWmzjrSLllnNYFSmujLY1Dpe/f8MAB7EY=;
 b=ksddZKGtC0Pt/AaKJd63DLDtMzcpkCWdY4x+YhjEzBwiNMoMtZpwx658oRkhXnKW2e
 L/JFDi1UYA3P+p9vPOwHDvaHIBH6IOo5FBxejDtLdCKcc10qgDeVccSuqkrriRlss7fX
 yTyAqO9W1zT9RsyZL1D/SqKLtXAy2MN0CTDRRs5yyaSJnO9GTsXf00tATZrBHzJzENBv
 t3gwgkt4IznCMZ6h9YYC9gWSFEOHE7hRxTZNaRlMY9SzpBm/Qtkb6W3KtYtoV6I+TZmc
 gBod20L+sqKetUDAr7EeDF4bvJMc65ltUKdJmp3TiGipPA4BlOVoP5xZa6IVBwlgC4tw
 2gVg==
X-Gm-Message-State: AOJu0Yx+f+llFk0YaAws3fLCXRXcpavL0zwHBspThYcXpWiWtSwR94is
 K6eCGgAtZSyc6FTZzSVmFcuc72RAv5NddJGyq0A=
X-Google-Smtp-Source: AGHT+IGoIaWYjhp3UH/jxIckDrAGibGnVsrwOiaSJBIlsR54XqWeOJhYdz97zFtM8LyfdbUlP6Xc7A==
X-Received: by 2002:a05:6a20:da82:b0:15e:b253:269f with SMTP id
 iy2-20020a056a20da8200b0015eb253269fmr1195037pzb.28.1699666333504; 
 Fri, 10 Nov 2023 17:32:13 -0800 (PST)
Received: from stoup.hsd1.or.comcast.net
 ([2601:1c0:5e02:2a20:a99c:45a6:14e9:ea6])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a62f20b000000b006c1221bc58bsm333502pfh.115.2023.11.10.17.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 17:32:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH for-8.2 00/11] target/hppa: PA2.0 fixes
Date: Fri, 10 Nov 2023 17:32:01 -0800
Message-Id: <20231111013212.229673-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Fixes to the recent hppa64 cpu support to enable booting
the 64-bit linux kernel to user-space.


r~


Helge Deller (6):
  target/hppa: Update to SeaBIOS-hppa version 11
  hw/hppa: Require at least SeaBIOS-hppa version 11
  target/hppa: Mask reserved PSW bits in expand_sm_imm
  target/hppa: Fix calculation of CR_IIASQ back register
  target/hppa: Fix possible overflow in TLB size calculation
  hw/pci-host/astro: Fix boot for C3700 machine

Richard Henderson (5):
  target/hppa: Use only low 2 immediate bits for PROBEI
  target/hppa: Use PRIV_P_TO_MMU_IDX in helper_probe
  target/hppa: Introduce MMU_IDX_MMU_DISABLED
  target/hppa: Replace MMU_PHYS_IDX with MMU_ABS_IDX, MMU_ABS_W_IDX
  target/hppa: Reduce TARGET_PHYS_ADDR_SPACE_BITS to 44

 target/hppa/cpu-param.h   |   2 +-
 target/hppa/cpu.h         |  25 +++++-----
 hw/hppa/machine.c         |   2 +-
 hw/pci-host/astro.c       |  73 +++++++++++++---------------
 target/hppa/int_helper.c  |   2 +-
 target/hppa/mem_helper.c  |  97 ++++++++++++++++++++++----------------
 target/hppa/op_helper.c   |   5 +-
 target/hppa/translate.c   |  41 +++++++++-------
 hw/pci-host/meson.build   |   2 +-
 pc-bios/hppa-firmware.img | Bin 755480 -> 681132 bytes
 roms/seabios-hppa         |   2 +-
 11 files changed, 134 insertions(+), 117 deletions(-)

-- 
2.34.1


