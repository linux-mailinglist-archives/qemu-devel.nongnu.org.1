Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4463829EB9
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 17:41:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNbcj-0001EH-6E; Wed, 10 Jan 2024 11:40:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rNbcg-0001DZ-Lu
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 11:40:10 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rNbca-0007l9-DT
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 11:40:05 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e586a62f7so7300415e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 08:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704904802; x=1705509602;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fjRyselwmJTU8eOOdownlztREoNuiWTCNW2P76UG0N8=;
 b=CTUQTq5Nybn1iGDukOpqRruDJybDEalt7dcks4h6vZVqZFpTRO458Ct0c+9nARmUTx
 JZGY3VXvOU+92iomA3CigXnxU4I5icMvbsPRklCUFcwxfns7YWpkIr2NbebqQFKxHuER
 Ji8/Z2x6va1J0j9noJXS/hkomtSYlFiaNcuD06ZxSOFQYUX7Gpk/CAAjKubf1nIFInGn
 wEqT6ypdQSD9lVT+8wVylYPewVfxZWZ6hl6T3lPuDLtygIgL+CqUBCfWem0VXhhBiMvS
 e0SKfH7DOk+eBbAtOBzI+aDqaZB9zWkibyT0KeGnVQHKAi76WJTU1nreLhaPS8xVyzeJ
 zATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704904802; x=1705509602;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fjRyselwmJTU8eOOdownlztREoNuiWTCNW2P76UG0N8=;
 b=Ek669e9yhZhB8a0U84Ajk/3A+AuRck8mhj+sUQZSN8zW4GmhIX/9Wn2SLxV3PiHpZU
 acar4KMaaHxSVD2nbF0HKOSfJaDtZzsOrUEJyclSgHGQLOsDrM1IDCgZlTktqW1cazpG
 pGzupWZeJO/IdtZ5+s87i/bsUyhd869hiREOads4/edpn+yATHpuY453xDYB1K+qECaz
 FkDDTluh5aHG9FRwaE4RQjz+D1s8MtodVPcidZ3R9t0MdvegTPL9IYxpYx0bD/3IRzOg
 jhUZSEC4W3xwscLPq4+/Gqw1hFAS8ER0j8CtGMYhj9hYltUAHRB9shmr9a/dBg+Kpe6t
 d8tg==
X-Gm-Message-State: AOJu0Yz0dyAyGfpn/SuM0BqyA9O9PvGB2MFpf5XyjLt/DP8OJ+w+WlQ+
 hpWyJkuV3mREW4z++viWu8gbC3j9LHBT35DQFRLbZ1ibWriw1Q==
X-Google-Smtp-Source: AGHT+IEZMM7kB3WUkx5dx2iz/SbbyEYpmTA6DvEDufkvbiPSUCJiS1/eKN8GfgYyV89jVfif41JKgA==
X-Received: by 2002:a05:600c:4e86:b0:40e:55b0:64df with SMTP id
 f6-20020a05600c4e8600b0040e55b064dfmr808239wmq.101.1704904802376; 
 Wed, 10 Jan 2024 08:40:02 -0800 (PST)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 fs23-20020a05600c3f9700b0040c11fbe581sm2805970wmb.27.2024.01.10.08.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 08:40:02 -0800 (PST)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH] target/riscv: Check for 'A' extension on all atomic
 instructions
Date: Wed, 10 Jan 2024 16:39:59 +0000
Message-ID: <20240110163959.31291-1-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=rbradford@rivosinc.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add requirement that 'A' is enabled for all atomic instructions that
lack the check. This makes the 64-bit versions consistent with the
32-bit versions in the same file.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
---
 target/riscv/insn_trans/trans_rva.c.inc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index 5f194a447b..f0368de3e4 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -163,65 +163,76 @@ static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
 static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_lr(ctx, a, MO_ALIGN | MO_TEUQ);
 }
 
 static bool trans_sc_d(DisasContext *ctx, arg_sc_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_sc(ctx, a, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amomaxu_d(DisasContext *ctx, arg_amomaxu_d *a)
 {
     REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVA);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TEUQ));
 }
-- 
2.43.0


