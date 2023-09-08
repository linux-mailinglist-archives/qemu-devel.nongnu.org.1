Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3954798229
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:14:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUeh-0000TV-Tb; Fri, 08 Sep 2023 02:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUee-0008UF-Hw
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:44 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUec-0007zg-4X
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:44 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c0c6d4d650so14149045ad.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153260; x=1694758060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0AugPxvR0Xk9MuYdUUIr4+5lfDeBI452w5K1Z6wU4Oo=;
 b=Ydql29YjQnld/p7nog9v6agpIzrFmygCrSZ5M+h2C6znlOiPrh7aJ/ENzAsYKTIUqL
 YhmLEj5hstc7h2EbW9TNqGHIMVIghSfRx4I56xXb5iLPaJROS0TVVdwmExckXlpMjS0f
 D5v4nvKDuUBMy3cM762iprC/AMQ4iwhaVpgBrIK/T5Ho4sQGNTqcOd6+B4ae5i8XhuEO
 bJKA/Gz5Lk2lZuVFVsJc103JHDQuM51TMhEHBP8bp+70sFSX/NDPF9VxaZMlp+EB8gQu
 uocJo+DqiW/KpRhMo3y+5hFXf/QbIfGniJ3bP7dHNznIkwHNnDHNMuya+1VRhPH5A7f+
 rRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153260; x=1694758060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0AugPxvR0Xk9MuYdUUIr4+5lfDeBI452w5K1Z6wU4Oo=;
 b=ibxwgO8TtJ70iESes7jdbKuqpTdYT3xeSyKEqn25gIHvqp6M/TpEF0bpsa3hXs6E8j
 +ke7/zocYT6kJ9SJnN7g/IO+YObViUFbTW+6PH9twWs+xZD8LNy3Ktwo/BRmN9FbQNZx
 3BVvvBDiDv3nVeSLPeuuOvC+X+IoEyvneO8JGqB5cu6w6z1colKPeg71W97ZUX75n8m9
 d+c/LfKLKTZRDN3atN2YcX547G0TVnMX90j+k76cFte6guVfZwTnCvmtypgQjd0gBTMe
 opqBe7Dui3sdO+LCyDyBbH90uIyyHR7KeiXn2xmE7LJc5oRFyMKKrR8tzuknprITche6
 2U3w==
X-Gm-Message-State: AOJu0YzRsgXJq/NBlZ8ygrABtsZMR4ADTKHQmSC9M5Udnu1RmVmTjjxo
 53nfAfRR5EoFyI63NG3G0ZIfOww7i86+0bwW
X-Google-Smtp-Source: AGHT+IGSO7zM7c1BH1Gmz9Rs7orb9gWeMyXJkjIauz96NMUNDqmJMcLpAcKRXSYdt3pNNV/VTBbGvA==
X-Received: by 2002:a17:902:be16:b0:1bb:9f07:5e0 with SMTP id
 r22-20020a170902be1600b001bb9f0705e0mr1570284pls.60.1694153260474; 
 Thu, 07 Sep 2023 23:07:40 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:07:39 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Leon Schuermann <leons@opentitan.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 43/65] target/riscv/pmp.c: respect mseccfg.RLB for pmpaddrX
 changes
Date: Fri,  8 Sep 2023 16:04:09 +1000
Message-ID: <20230908060431.1903919-44-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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

From: Leon Schuermann <leons@opentitan.org>

When the rule-lock bypass (RLB) bit is set in the mseccfg CSR, the PMP
configuration lock bits must not apply. While this behavior is
implemented for the pmpcfgX CSRs, this bit is not respected for
changes to the pmpaddrX CSRs. This patch ensures that pmpaddrX CSR
writes work even on locked regions when the global rule-lock bypass is
enabled.

Signed-off-by: Leon Schuermann <leons@opentitan.org>
Reviewed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230829215046.1430463-1-leon@is.currently.online>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 9d8db493e6..5e60c26031 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -44,6 +44,10 @@ static inline uint8_t pmp_get_a_field(uint8_t cfg)
  */
 static inline int pmp_is_locked(CPURISCVState *env, uint32_t pmp_index)
 {
+    /* mseccfg.RLB is set */
+    if (MSECCFG_RLB_ISSET(env)) {
+        return 0;
+    }
 
     if (env->pmp_state.pmp[pmp_index].cfg_reg & PMP_LOCK) {
         return 1;
-- 
2.41.0


