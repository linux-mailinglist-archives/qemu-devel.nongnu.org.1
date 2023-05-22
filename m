Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B944070BF57
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 15:12:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q15K1-0005Zk-Qv; Mon, 22 May 2023 09:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q15Jy-0005TZ-6m
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:11:30 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q15Jw-0007Ye-EE
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:11:29 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-19a27f1cd6dso2341453fac.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 06:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1684761086; x=1687353086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oGkMtc7Eok3L3pv0QICT7EOJENDrwnzSr24aOofvCMo=;
 b=PTSuFX0moRZ4BWHL4h5v2a/RAlqPoYISWvtulRmaJyodovhyD57kuHtwWDSa0lCV7N
 URG7aznibjEjZoLriS2gZuDMejbqTYOWt/8Gn+/M/ga4zR5Kzpa1HS8lRpDqXp6p1cYZ
 ilLurqn42aiK7YHpXGwkIbxKiH1HSFfeT3i/bMI4Mw/lJoot1MnZcO31VPJUfJlL3i3A
 REjrMAtxuBNoOOuL/DngsUAKkiYMjq4HU4W/mgKc/xyIe6B7e+eadhs8n+hStsYy+N06
 XAp9WabWixNbqpS9miSS18twGL1za+NVOvuYYggosMEb31EGtDY5ZX3jnVSyv5kOElAk
 ECQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684761086; x=1687353086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oGkMtc7Eok3L3pv0QICT7EOJENDrwnzSr24aOofvCMo=;
 b=HXKiXl/oKYRN7cVbOZghpnie7F3lhJqrMX1oy8C+AErrz+jCr8+jUeEwRAitz5AaWU
 9I9NTiFrGC+82TiFtMSLQRtAdP6trYmm/ZXw14A6CeJaDf0mVkIL/JU0zGTj/UbRi0Tz
 3hu17NkcZinPgE41L6F/iqCcBnAvefnpzCh0T0pccRu4s1nz69mnDJCsbPSJ8X00zifG
 U55El3RCuXUP9lSP27krpvnSfNCszbnUxLxTMFWNN7eGSMNpvf7bAzXu3WqQQ6bvAOHo
 5jZctomT9WMtDtyJLjtez1MkmB2wpiVuAvu+ApRIVDVdDGl13e0/EiXX6Eq8BwfhQhZL
 dMZg==
X-Gm-Message-State: AC+VfDxV6YnwHXBA7IfzknBDMg3RoZlMbpLXV3WvSJlzf1Ait1JyARXl
 b51zUKwmQoMAhhoODtlJ2q3TZQVAxwJ8R20qUWGE/H85iRgPwy6ayNr/tm4kQh9JzZx4lxqU8Bx
 mnfHmKXoWF+5hnz5oYH7WYWutjzTggTAs81ty3p987p0Ev5TRROsbF5jNXRjxa87rxFDBPQyWTq
 Jb
X-Google-Smtp-Source: ACHHUZ5yWMvvDZ+snZQNcwQ1dCO7Uao8H30yMBtGIXCgmG42V4WwX5vGB2g2V+pUJoaCfgT5LrCwfw==
X-Received: by 2002:a05:6870:168f:b0:195:e6e9:b74a with SMTP id
 j15-20020a056870168f00b00195e6e9b74amr7469791oae.29.1684761086368; 
 Mon, 22 May 2023 06:11:26 -0700 (PDT)
Received: from sw05.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a9d6c83000000b006af731d100fsm1369182otr.75.2023.05.22.06.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 06:11:26 -0700 (PDT)
From: Tommy Wu <tommy.wu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: frank.chang@sifive.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 Tommy Wu <tommy.wu@sifive.com>
Subject: [PATCH v3 0/4] target/riscv: Add Smrnmi support.
Date: Mon, 22 May 2023 06:11:19 -0700
Message-Id: <20230522131123.3498539-1-tommy.wu@sifive.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=tommy.wu@sifive.com; helo=mail-oa1-x33.google.com
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

This patchset added support for Smrnmi Extension in RISC-V.

There are four new CSRs and one new instruction added to allow NMI to be
resumable in RISC-V, which are:

=============================================================
  * mnscratch (0x740)
  * mnepc     (0x741)
  * mncause   (0x742)
  * mnstatus  (0x744)
=============================================================
  * mnret: To return from RNMI interrupt/exception handler.
=============================================================

RNMI also has higher priority than any other interrupts or exceptions
and cannot be disabled by software.

RNMI may be used to route to other devices such as Bus Error Unit or
Watchdog Timer in the future.

The interrupt/exception trap handler addresses of RNMI are
implementation defined.

Changelog:

v3
  * Update to the newest version of Smrnmi extension specification.

v2
  * split up the series into more commits for convenience of review.
  * add missing rnmi_irqvec and rnmi_excpvec properties to riscv_harts.

Tommy Wu (4):
  target/riscv: Add Smrnmi cpu extension.
  target/riscv: Add Smrnmi CSRs.
  target/riscv: Handle Smrnmi interrupt and exception.
  target/riscv: Add Smrnmi mnret instruction.

 hw/riscv/riscv_hart.c                         | 21 +++++
 include/hw/riscv/riscv_hart.h                 |  4 +
 target/riscv/cpu.c                            | 19 +++++
 target/riscv/cpu.h                            | 11 +++
 target/riscv/cpu_bits.h                       | 23 +++++
 target/riscv/cpu_helper.c                     | 84 +++++++++++++++++--
 target/riscv/csr.c                            | 82 ++++++++++++++++++
 target/riscv/helper.h                         |  1 +
 target/riscv/insn32.decode                    |  3 +
 .../riscv/insn_trans/trans_privileged.c.inc   | 12 +++
 target/riscv/op_helper.c                      | 51 +++++++++++
 11 files changed, 306 insertions(+), 5 deletions(-)

-- 
2.31.1


