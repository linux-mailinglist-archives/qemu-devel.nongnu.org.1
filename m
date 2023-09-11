Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD5979A3C2
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:47:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfagJ-0002km-ED; Mon, 11 Sep 2023 02:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfafa-0002O2-Tl
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:45:16 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfafY-0004sZ-BO
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:45:14 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bf11b1c7d0so35211345ad.0
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414708; x=1695019508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xCsrBGCOStJmv04kLZFtAJ2x5uul1n88A5rBVq3QvKM=;
 b=WcddKje0ZYXF/E5LXR+gYy2RvO9cKroQmku7OmU7WEfcu4WtyMKFJtnTLxv357N/FN
 eoPP0ERc9meNByF+FH6KsEz8Z36vX/KfdUZglHOaQjtSpw9zidjuYp0bbpwCRUoL9K9d
 XXOhvsu3tyniKJNotiXdW+vDXXfGQSmBPx8HiYWPP7807LpReA5oQoEnQSm456pj7j/p
 YRda4KXKwj4pwa+29ppiCPGPpixKNbhoYrmG3lgjN/h0m18DwFhd4IzmEfLKUKNwTOdt
 cFqSjOt+lLdylZok/r5sdTP5QJBJ4M9fBes7ksK/8oHXjrYmvlM030hBHreWXCLk7APg
 sdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414708; x=1695019508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xCsrBGCOStJmv04kLZFtAJ2x5uul1n88A5rBVq3QvKM=;
 b=iGoxD7+j/Q2bckwvli9c41UPIF+el15ymp/OmKywU15SOl1RwBeIc7muywxVMh0zkw
 HbhBVzKMitt10Z9O/aZhtLoxK1RAdJwg4bTQTyDgPkwLD0TTCUAKKxWPd8+Zppd1Q2dH
 r8gCUxtNj6UlctUwWN0NPHPUdwUWnV7z+rYOavDHBdpnBariGQ4/ED6bBeQowE8X/or8
 CIlSPgfMv/i6v2PI0fp/5GulIDHOmTeopvjHB62EI3Q1mqp0tkL5w/fmIQNS2mRg7/ia
 9dgxJ9lGo91HY8CY/5doINmskRoGSTGcxYGhxxmUJqwSD6JbeUlijpmeTxLLCZswsqz1
 aEWw==
X-Gm-Message-State: AOJu0YzOV5TZlK8j/pzCPi0yzsWgmoBxLnIn87i8WGcOW3lmNwGJWA2z
 AssnI34QSJKaUyjeUNsa+7mc0Jb/UeZVjA==
X-Google-Smtp-Source: AGHT+IGahW4wu2D4Cf7+AczCiwuStSzpsRl9DZ3cHxYzPBZiOv+I0xrUN8vc7Q/8ouLgo/nTRyqkUg==
X-Received: by 2002:a17:90b:180a:b0:273:7bf5:b1bf with SMTP id
 lw10-20020a17090b180a00b002737bf5b1bfmr16442727pjb.9.1694414708036; 
 Sun, 10 Sep 2023 23:45:08 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:45:07 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Atish Patra <atishp@rivosinc.com>
Subject: [PULL v2 23/45] target/riscv: Implement WARL behaviour for
 mcountinhibit/mcounteren
Date: Mon, 11 Sep 2023 16:42:58 +1000
Message-ID: <20230911064320.939791-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Rob Bradford <rbradford@rivosinc.com>

These are WARL fields - zero out the bits for unavailable counters and
special case the TM bit in mcountinhibit which is hardwired to zero.
This patch achieves this by modifying the value written so that any use
of the field will see the correctly masked bits.

Tested by modifying OpenSBI to write max value to these CSRs and upon
subsequent read the appropriate number of bits for number of PMUs is
enabled and the TM bit is zero in mcountinhibit.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20230802124906.24197-1-rbradford@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ca95ae1527..661744e6d4 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1833,8 +1833,11 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
 {
     int cidx;
     PMUCTRState *counter;
+    RISCVCPU *cpu = env_archcpu(env);
 
-    env->mcountinhibit = val;
+    /* WARL register - disable unavailable counters; TM bit is always 0 */
+    env->mcountinhibit =
+        val & (cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_IR);
 
     /* Check if any other counter is also monitoring cycles/instructions */
     for (cidx = 0; cidx < RV_MAX_MHPMCOUNTERS; cidx++) {
@@ -1857,7 +1860,11 @@ static RISCVException read_mcounteren(CPURISCVState *env, int csrno,
 static RISCVException write_mcounteren(CPURISCVState *env, int csrno,
                                        target_ulong val)
 {
-    env->mcounteren = val;
+    RISCVCPU *cpu = env_archcpu(env);
+
+    /* WARL register - disable unavailable counters */
+    env->mcounteren = val & (cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_TM |
+                             COUNTEREN_IR);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.41.0


