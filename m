Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CD47C83FD
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 13:03:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrFvf-0000Lj-Ii; Fri, 13 Oct 2023 07:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qrFvP-0000Ij-Dk
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 07:01:53 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qrFvA-00028Q-5p
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 07:01:47 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so1823957f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 04:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697194888; x=1697799688;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wiq5mYEHEn3DJSzjIjqQH0t31AsiITQ4TuY7AydRTuI=;
 b=woW+taUr7jw52HjELew9KAFAEnC3fK3Afdxdia4ruxwYFF78RUORX1h4bMEmIR1khV
 yfFc8FlwAvB6wUCUodzhsm2/ATPH6NAaTfJum4gR/OlCqpwNnImninJHpcagsxD2Dsy8
 JAUwcuUpGqcNnlyHEl+P1a/eSkFEcH4bz66osjYDwmJjG8gcG7JuMOCYFOXzasIsMGiz
 El7MnvAfQo7SagiacmN1lJuHDg8kkHAqc2ViDsrBOgCZzuzT3u3tBL6pwYCKWd1wRbfZ
 ZrnUa/Vvc2fWQVKoMdl8x3qXz389+JTTKQErOByC9y3SerOubWj/cXuwRGWAacMNEjMa
 0QTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697194888; x=1697799688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wiq5mYEHEn3DJSzjIjqQH0t31AsiITQ4TuY7AydRTuI=;
 b=Ie1OovjaPvQE1r3R/eNe/lwckkzcwVf25xI3WG1zJsFb0QHlcGUBhQFXxO2f60fLbE
 x8AW8vtfVbhJSpjAqIblLmp8Itw6GqgEXd7L4iLXAYFaHZtCTVueDhnARJUUHK12u8Cc
 TPPID1HRM+Hae6N5U7CqOFKsPOkzZuvobqLb71Igj4HXHUAv/d7W6uvGmqxC7/s3DULa
 /RIxEp2k36j4If9o97GDfWFIBqw9jv7+wx5V92ShI8kehf9LKVzva9KoFF+GQD3PE4o/
 Fx3eNA2Far02Xwqbhtl6r6AXfuCD6sFG9Scsn03rkvVFoNkBvb26J5kD2IPg6rowtIGN
 F1AA==
X-Gm-Message-State: AOJu0YysgNaKTrQ3riJmJ+KLjJTIMSa+v8/sV8TfkzrlNhZi0+kgP5dx
 9M6M6BY+x297jYBBwvrOX6A11XqGUkCkA44SwMY=
X-Google-Smtp-Source: AGHT+IFQVguXGtsTC1c6pAmwumLdkeP1nKzBm6PlV6v7YBNOO085m4T7iDXvDE6v2QvddiE4hX1CQQ==
X-Received: by 2002:a05:6000:110b:b0:31f:a259:73c with SMTP id
 z11-20020a056000110b00b0031fa259073cmr22491533wrw.27.1697194887820; 
 Fri, 13 Oct 2023 04:01:27 -0700 (PDT)
Received: from rockhopper.. (214.11.169.217.in-addr.arpa. [217.169.11.214])
 by smtp.gmail.com with ESMTPSA id
 p8-20020adfce08000000b003271be8440csm20455185wrn.101.2023.10.13.04.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 04:01:27 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH v3 2/6] target/riscv: Don't assume PMU counters are continuous
Date: Fri, 13 Oct 2023 11:54:44 +0100
Message-ID: <20231013110111.34619-3-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013110111.34619-1-rbradford@rivosinc.com>
References: <20231013110111.34619-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=rbradford@rivosinc.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Check the PMU available bitmask when checking if a counter is valid
rather than comparing the index against the number of PMUs.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/csr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 85a31dc420..4383805fa3 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -182,7 +182,8 @@ static RISCVException zcmt(CPURISCVState *env, int csrno)
 #if !defined(CONFIG_USER_ONLY)
 static RISCVException mctr(CPURISCVState *env, int csrno)
 {
-    int pmu_num = riscv_cpu_cfg(env)->pmu_num;
+    RISCVCPU *cpu = env_archcpu(env);
+    uint32_t pmu_avail_ctrs = cpu->pmu_avail_ctrs;
     int ctr_index;
     int base_csrno = CSR_MHPMCOUNTER3;
 
@@ -191,7 +192,7 @@ static RISCVException mctr(CPURISCVState *env, int csrno)
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


