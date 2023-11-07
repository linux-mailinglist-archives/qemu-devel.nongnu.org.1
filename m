Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C317E3311
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:34:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0BtW-0002ll-Kv; Mon, 06 Nov 2023 21:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BtP-0002Zp-Bf
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:40 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BtN-00034P-Hl
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:38 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cc4f777ab9so36643075ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324356; x=1699929156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xCY/8kc52Ot4x8MUVO+pwx/ZKG2HwEofvg9EN4jvs1o=;
 b=jMb2URS/28J6P3PrQsnrxXIpkPBJ53tMPkJrRsR+zHIM/VVdkQ8JKHKHpN2StPTovs
 llIaWa1Cbs4A6sKMYCWeiv8WUTjKLYB3mYy6DVc5boxGXbeOC/la0B9RoLXqGa/Mpjtc
 LcwDhtUEKRbissJh7sOKRpVNuGYjZLuC6y3Q5YGKzXprF093FaFKJXJ2oCmY0jbKo2zu
 5s0xaD3VqwG+iZ9dzYQf9WScG7kk87in1mSY7CAOnXPyIUJbYM9RWKxhdq6zOFlewY7N
 68xzzJra8bbRtfj8LQpn+ncWcIRfmFM27+gR3h2rGBsND09Ub1O4jmOSUqv/ZY/50ceP
 CRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324356; x=1699929156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xCY/8kc52Ot4x8MUVO+pwx/ZKG2HwEofvg9EN4jvs1o=;
 b=qElGkSyCVxCBi/Lwj9vzhEGqX/y6Uin00na+3yIlmCuzNaYu2QXJLNfOZ29Rjv+UrF
 fEpZWms/Q6mot9vCfY0sM60v/89uWitcjlZEgZwkA6lsV1uZI9BYwEkD8r3o3p4P/yFt
 LOWFxEy2EFkpax+itf3XEqkHz9bnHnsEohgqAarPoLTWCXISTlER672b+TnOw3GifOef
 gg0MBtwyugum7GRCLOKDA8/vmVKiPkkITyLgSocMpktHEJXFzdh+YBHD1ULoVTh4PQGi
 p6KL+SQcjg2FcRbgxu9O2HE1kLdXs27V+Eu9GZ12xJpE4ymk8jFjuBJvGBKyBCSOClKV
 WQ9Q==
X-Gm-Message-State: AOJu0Yyr9esgbA1+UVHLpRc3A3l6XWNfzDt5KgpswGywUymC7xotT87y
 60+iqi6qnb+ETD654oo1uGkBx7FTy1BpXQ==
X-Google-Smtp-Source: AGHT+IG1QP+mabgWMJOyq1/3oMzmfH2CI5kIujncKOHv7XlwAcNyTsRq0wfhzqKoD+JJ68VpjPd4WA==
X-Received: by 2002:a17:902:e5cc:b0:1cc:5d06:b38 with SMTP id
 u12-20020a170902e5cc00b001cc5d060b38mr21049052plf.64.1699324355808; 
 Mon, 06 Nov 2023 18:32:35 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:32:35 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Atish Patra <atishp@rivosinc.com>
Subject: [PULL 46/49] target/riscv: Don't assume PMU counters are continuous
Date: Tue,  7 Nov 2023 12:29:42 +1000
Message-ID: <20231107022946.1055027-47-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

From: Rob Bradford <rbradford@rivosinc.com>

Check the PMU available bitmask when checking if a counter is valid
rather than comparing the index against the number of PMUs.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20231031154000.18134-3-rbradford@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index fc26b52c88..fde7ce1a53 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -188,7 +188,8 @@ static RISCVException zcmt(CPURISCVState *env, int csrno)
 #if !defined(CONFIG_USER_ONLY)
 static RISCVException mctr(CPURISCVState *env, int csrno)
 {
-    int pmu_num = riscv_cpu_cfg(env)->pmu_num;
+    RISCVCPU *cpu = env_archcpu(env);
+    uint32_t pmu_avail_ctrs = cpu->pmu_avail_ctrs;
     int ctr_index;
     int base_csrno = CSR_MHPMCOUNTER3;
 
@@ -197,7 +198,7 @@ static RISCVException mctr(CPURISCVState *env, int csrno)
         base_csrno += 0x80;
     }
     ctr_index = csrno - base_csrno;
-    if (!pmu_num || ctr_index >= pmu_num) {
+    if ((BIT(ctr_index) & pmu_avail_ctrs >> 3) == 0) {
         /* The PMU is not enabled or counter is out of range */
         return RISCV_EXCP_ILLEGAL_INST;
     }
-- 
2.41.0


