Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EA6A14980
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Jan 2025 07:08:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfOH-0002a9-1W; Fri, 17 Jan 2025 00:59:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfNK-0008So-Hh
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:36 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfNI-0006BG-Be
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:33 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21661be2c2dso32197025ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093511; x=1737698311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BW72OZaZ/D+Q71Y9FYOkne6ayz9kvCtmou7oCpmup5w=;
 b=AhbSc0jCVhR1/kpjVmqE6KckFRjahCXfAUTe8TNA5rT6iVbjb2oN3sY45r3aTOtlWZ
 H8UNTypCzTZRI7F6/wz5uak0eVjYTax/ooWObOko3cAHzgxAzdkS27whz04tLeCtGAek
 HV84vkeIoAG7oQ3Z9CLzgkPONZrwlbmeJ3tfenqsVScaq/UPrFTqSoFDE9eZHx98qTrK
 Un8Vc35tpXu3/w2pLS6FaUmaSs0hdUJKwJ5P6kzEh2P7AHCe+WNZw4vRA0U9mSMFERMA
 R3476ZuXeRv0EJ7HIJHvw2nZs8wOULPmDfJ1mvU7djaj+sOZW965PoRoYQp0SlGiopdi
 XV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093511; x=1737698311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BW72OZaZ/D+Q71Y9FYOkne6ayz9kvCtmou7oCpmup5w=;
 b=t85Zf2tRZY8XbRnLNuNd4d+STCc1e7dU2N/XWX2+Wfh6GHLx9qU6bjvmyw4hn+3KzP
 aJFrk3C+geA6QQtpuy2QzVNYTSyr+Yw/BVZfeWdcWgovfByiSwxYaKnaWKJn4iqFyGdH
 FTmubIVlOCwsJFB2AHn1S7uYBLVaaCZf5C07XdOddx9DbG7r083Cn/PuxdNKgrNRIOin
 L7P9GNDzd5MDIYvPmjIN5BhT/+zovS74NvuFFiYdv96VYUlo3i8w5ESEjpzDoFuDCxNX
 XdItqtOxBGLOGvm9PnIy8iJZPHsRLA5b2pcLN5aN7SkRQogyh6eeXCphRtWsHU4u3QGu
 cW7g==
X-Gm-Message-State: AOJu0YxX2Lcw19tw2mPRn/ivBubpfPpPbLa2nBYAQp/1r7ovANIDbT27
 lTtcskvpId4KzeyhlA5w5dmbAX+CcqzDCtPDjV84KLyp9MDtq1fLMfRyOw==
X-Gm-Gg: ASbGncsLO+gTl0NhEmK7FzCP0LqqZyuZzIpqkmPx3OJXACC9ej3kjyV8fpRh/9LPTQi
 I0XWr984K4Ncu41KIT1FoVBwNCSVQcyZUtqwyMt6TiwDaK9JCtpFLaZ2QTkx8weIqxi5aJujJX+
 tHlLf6ui8ZNmIkfcHdkrMU5/tcwJ7qbW0mmiZPg1HtFEfz7iQuwxTeRgjgNN3lQcmTbbKEsoUs5
 vFsL01RU9jFUp9hXjLQYVqNjkN+MC4YmadqtlyXRE8bdFRND6j1Cn7Ri9rGpNKp3tb2RKnXj6nk
 ouq7VWLtWAX9fqR5o86su1QRrcAqS2t2iPH5vKCFfxnxtiC4K3iwKmljzt0w
X-Google-Smtp-Source: AGHT+IFTcioo5fqZNJN6oAHy06gU+uGUBdNsspGDabuK7J8TADIfGvm+bFarBuKIPpPF2r9T5Tx3jA==
X-Received: by 2002:a17:902:e5ce:b0:216:6590:d472 with SMTP id
 d9443c01a7336-21c3551ae48mr24905045ad.21.1737093510789; 
 Thu, 16 Jan 2025 21:58:30 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:58:30 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 44/50] target/riscv: Add Smdbltrp CSRs handling
Date: Fri, 17 Jan 2025 15:55:46 +1000
Message-ID: <20250117055552.108376-45-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Clément Léger <cleger@rivosinc.com>

Add `ext_smdbltrp`in RISCVCPUConfig and implement MSTATUS.MDT behavior.
Also set MDT to 1 at reset according to the specification.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250110125441.3208676-7-cleger@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h |  1 +
 target/riscv/cpu_cfg.h  |  1 +
 target/riscv/cpu.c      |  3 +++
 target/riscv/csr.c      | 13 +++++++++++++
 4 files changed, 18 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index a3acda4bc8..f97c48a394 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -559,6 +559,7 @@
 #define MSTATUS_MPELP       0x020000000000 /* zicfilp */
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
+#define MSTATUS_MDT         0x40000000000ULL /* Smdbltrp extension */
 
 #define MSTATUS64_UXL       0x0000000300000000ULL
 #define MSTATUS64_SXL       0x0000000C00000000ULL
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 20e11a5bdd..aef896ba00 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -84,6 +84,7 @@ struct RISCVCPUConfig {
     bool ext_smcsrind;
     bool ext_sscsrind;
     bool ext_ssdbltrp;
+    bool ext_smdbltrp;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9e1ce0e1f1..e3ed11b0fd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1064,6 +1064,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
             env->mstatus_hs = set_field(env->mstatus_hs,
                                         MSTATUS64_UXL, env->misa_mxl);
         }
+        if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_MDT, 1);
+        }
     }
     env->mcause = 0;
     env->miclaim = MIP_SGEIP;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4aded3f00c..afb7544f07 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1954,6 +1954,13 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
         }
     }
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mask |= MSTATUS_MDT;
+        if ((val & MSTATUS_MDT) != 0) {
+            val &= ~MSTATUS_MIE;
+        }
+    }
+
     if (xl != MXL_RV32 || env->debugger) {
         if (riscv_has_ext(env, RVH)) {
             mask |= MSTATUS_MPV | MSTATUS_GVA;
@@ -1996,6 +2003,12 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
     uint64_t valh = (uint64_t)val << 32;
     uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mask |= MSTATUS_MDT;
+        if ((valh & MSTATUS_MDT) != 0) {
+            mask |= MSTATUS_MIE;
+        }
+    }
     env->mstatus = (env->mstatus & ~mask) | (valh & mask);
 
     return RISCV_EXCP_NONE;
-- 
2.47.1


