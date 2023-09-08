Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7C1798200
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:10:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUds-0003Ka-Lk; Fri, 08 Sep 2023 02:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdR-0001Bu-OI
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:31 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdN-0005z9-TB
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:27 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c336f5b1ffso13917475ad.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153184; x=1694757984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kAP/ARZH03sbdLRgzXuPgyQA9kfPXuXGRtSjy51o5fY=;
 b=lMTNYtAR/BOJzulDZpHgOT2XlP5ODSekxUfLlu5MlYxGcQAkfXpO4LdO4jfWK+JQEt
 8wOY6mfZDyHZqJBjXWduRsWtXD5RWRjB02EXnoWYCWc3/Bo5lYIuK26JRs26zq4jGRuL
 MFW2Ef5VvpkRY90fuenkP8rZ1G/Dn7Put/T5EsaNPODJ/7E0/gQJB5K7c1wgo0ou+l1A
 0GdRp1rFCG1QHjDTXYcdVZKr5JPqTrfxcISLnAt7uSXsg5iOFTAkh0x77EGr0AE/PD33
 AwbVilbEPqkAZMZfBDz0psWw/t1RXG5450kc/qOj+bxuuS2sWQvgfeSXRGmO8vvO6xpY
 8YKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153184; x=1694757984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kAP/ARZH03sbdLRgzXuPgyQA9kfPXuXGRtSjy51o5fY=;
 b=NoL7rhEXn1P6akfLM+IoQx8MChbxxDcQKdfKwRhOo690mFT99ATAhVf4fvDTltc5np
 Fs7THwQP03xRFZJeDkB2iUMn76oTQRMh+6OZXDaoUyX0F9S6z1SLL4f5/wj4HBqlFR9I
 CaTCvwGAX1s3/QMSDH9wxM6/Rkp26He2/DU37DIoEPt1vTMn5ISp8RMhvxqewDqhOfHQ
 Q4gDwDWN8jnZ/QweKj7mqEGQgqHvFgAQHkCXdGwVWgiv50aLbrwH6VAh+scXuNBj6Zm5
 AW90r6QZDLRWKRqCwwuyEhGStQNi7Zsbu512FdWOvKlftChYJfZ8rTxcyzJnTKFgTj2h
 fUpw==
X-Gm-Message-State: AOJu0YwDHADZUdA2iJUJUKHFRMUukndaVnAB59X9fI5ASyssuqL3idNI
 IdSOoFAJ3uXW7Pm826DaEyQDyZl2FLrxzU8E
X-Google-Smtp-Source: AGHT+IFy4ZYa2hVVGCl/VZSia6M/DTQsTL19DMaz401s41fyixpY7Cb9t83vlebMnvzOmgv4nwjNIw==
X-Received: by 2002:a17:902:6906:b0:1bb:9c45:130f with SMTP id
 j6-20020a170902690600b001bb9c45130fmr1624479plk.69.1694153184083; 
 Thu, 07 Sep 2023 23:06:24 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:06:23 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Atish Patra <atishp@rivosinc.com>
Subject: [PULL 23/65] target/riscv: Implement WARL behaviour for
 mcountinhibit/mcounteren
Date: Fri,  8 Sep 2023 16:03:49 +1000
Message-ID: <20230908060431.1903919-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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
index de31818daa..e4490d5bed 100644
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


