Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4159D76CD80
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 14:49:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRBI3-0005y4-6P; Wed, 02 Aug 2023 08:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qRBI0-0005vo-PQ
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 08:49:20 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qRBHy-0001uz-Rk
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 08:49:20 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3179ed1dfbbso3360226f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 05:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690980556; x=1691585356; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rqRK90FQlpUq5FFVIJ9r0kLO6CGSKsy3LdjgO9tyOyE=;
 b=jvNc/hV+EBALMH2Uz8rb2a3YN+IYDFQpQ5hn3hcwCCLopeZBDEnwVpi/lMND1/7hm+
 lylEOjqHXN3SXxBb6CpK18XvpTkHDry5yOnbar3Nz4Ghq8dyLazcA9X+Fe+S3k8K0r+h
 ysw/7mjk0p1Ka6CtUOx22nI/1+WuKVdgyLwEgui1S2OE+OfcPGSTXuLQ/paeEizkAcZm
 p4kpyMl/iHzpUZjfsIHTIPhsbfoTDaHiV/lNdt498Jgej/YE0uL8PBueavKvGmVTyqDN
 qq45wAfEaNSOUazsFR/sGPtbCAgen99Cv2rVB6nn57Cy/FFAvvCJdTfDo4si1/5cp3T5
 JXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690980556; x=1691585356;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rqRK90FQlpUq5FFVIJ9r0kLO6CGSKsy3LdjgO9tyOyE=;
 b=PbJGsD2UqZEV9HgUvrYgHlerjS0DQwZyuuwfmM6p5zn1LcIsypTu5eBsDVlR3F5t4t
 5YJOUrqb6YiO9ZyJpElXFhOUW0G3QrZ2vEzE6EWgkZQFGMtpLo/X4u66W7BDwHSss1dO
 V8c/DmqUM3RnrpvbQ01AHOiA7WF0ikgCCZ2CsxWt3F0iiypD4FvMPC23m6HyhfE2CeZ6
 mMp4mMrd1gvPPqwxd1LDefcJTxFW2MxFOfCavC5ohEW42IzO4vhFdYu/we/fUfNRbY/w
 UuRT/2z97iCs9o3gmzGFxdkCCSREDb7CZqGvVV0IUxSOVfdXymnbQN7klq379FXxNb6Z
 5yHg==
X-Gm-Message-State: ABy/qLakEWemp8oDVtXeI28tSKt0gCUX+vxi3PwksvTTgUlLh5dxmrz/
 SGMFAx1phAUY+fTAcmfAyb1rsfWV+kf214GBw8o=
X-Google-Smtp-Source: APBJJlHcUCn0dPGRvBXhsnpWNgpLL3JdVGN3i34XLM+G1ImV6yQV8iTamKznoIV5l+MUDIFcBgt2Pw==
X-Received: by 2002:a5d:50d0:0:b0:317:3c89:7f03 with SMTP id
 f16-20020a5d50d0000000b003173c897f03mr5194854wrt.5.1690980556449; 
 Wed, 02 Aug 2023 05:49:16 -0700 (PDT)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 x7-20020adff647000000b00317731a6e07sm18944519wrp.62.2023.08.02.05.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 05:49:16 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Rob Bradford <rbradford@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH] target/riscv: Implement WARL behaviour for
 mcountinhibit/mcounteren
Date: Wed,  2 Aug 2023 13:49:06 +0100
Message-ID: <20230802124906.24197-1-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=rbradford@rivosinc.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

These are WARL fields - zero out the bits for unavailable counters and
special case the TM bit in mcountinhibit which is hardwired to zero.
This patch achieves this by modifying the value written so that any use
of the field will see the correctly masked bits.

Tested by modifying OpenSBI to write max value to these CSRs and upon
subsequent read the appropriate number of bits for number of PMUs is
enabled and the TM bit is zero in mcountinhibit.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
---
 target/riscv/csr.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ea7585329e..495ff6a9c2 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1834,8 +1834,11 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
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
@@ -1858,7 +1861,11 @@ static RISCVException read_mcounteren(CPURISCVState *env, int csrno,
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


