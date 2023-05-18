Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD2B708753
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 19:52:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzhmZ-0002PE-FF; Thu, 18 May 2023 13:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1pzhmX-0002O3-AB
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:51:17 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1pzhmV-0001gY-6Y
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:51:17 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6abeffced6fso1714059a34.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 10:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1684432274; x=1687024274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yMHA+h7oKPuoXJ8vtGMg6ieshukBlbz7/PDV7/EW4bw=;
 b=kVrsKfsoWjGQmq0+TjXX8JYkbFmQqIeILQiDBReq7cFZS6NUrzAWK0RFFcJExJFLQk
 gMpn4Sy7T96PRXLZ5LuU7FYlEvHXG8H2BesSxFwUcBon4WsyGhHh2mWgTrO5nm424Hxa
 3vYF+M+dSPffp78v/YQT4d36JbTBS41lixnKVIqECWWWrgn5tFK/1ClSs+7PggDcon25
 mdn9CEDAwoB5jDJTStt9QhyH1yL802LqsmjCS6Ikknp+yNls6fI/OK1z+LJAUzR5Iz2m
 qrqm/zWRR16PVOyZA4STppoz/bzKeKeYBgdpMnPXfSIKd74FxKdxOSaZixma/wvaKJHo
 WzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684432274; x=1687024274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yMHA+h7oKPuoXJ8vtGMg6ieshukBlbz7/PDV7/EW4bw=;
 b=McQ4idAzd3k4chFOkIK6UZGo1BWdfEsXVrsr//tBWyY7EydXluHPq73Vk9sOFAyJm+
 +VJ96Y6zBxWoQY6NURboLncAhn9aQZw+AYsJ4o4X6Gy+Ns7X6OJ5jhvLTKMICQSZte8O
 07NFWz3o5Ylb0Fe0anMOVk6o0UUjME4TxxguyrDceAiM8lrwjfei6bUNyAA8i8LieRA1
 6guPnKdKIYwaC1S9ctbei273iMvbSbgQuV5bWSHxJuTSFYC77S9fGzAdQSKfyR5CYdXM
 CCPJuFN9UX6u3lM15R2gzMdJ073y7dwg38xa7opYX4NLQQGXYkHpGO4fEX+NDPfFE5be
 ydWg==
X-Gm-Message-State: AC+VfDw3BTPSMy7NBRnwGZQRoeonj6MZNtVgyml4H/MJ9leLmF1t/Knv
 8xklj1V5szWjGi+TsJ2UDG8ozJMY4oldk9Gu2HNMdw==
X-Google-Smtp-Source: ACHHUZ5upTZavxkkKpQUuEClVndjYTwh7hh1cMwbHO/HuMzZ3Xu22kPWAc/YQz/TQ4I27WfZOur9aA==
X-Received: by 2002:a9d:7314:0:b0:6ac:a7bc:61c4 with SMTP id
 e20-20020a9d7314000000b006aca7bc61c4mr1635485otk.10.1684432273926; 
 Thu, 18 May 2023 10:51:13 -0700 (PDT)
Received: from mchitale-vm.. ([103.97.165.210])
 by smtp.googlemail.com with ESMTPSA id
 t13-20020a05683014cd00b006ab22bb324asm890832otq.10.2023.05.18.10.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 10:51:13 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	alistair.francis@wdc.com
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Barboza <dbarboza@ventanamicro.com>, liweiwei@iscas.ac.cn,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 1/3] target/riscv: smstateen check for fcsr
Date: Thu, 18 May 2023 23:20:56 +0530
Message-Id: <20230518175058.2772506-2-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518175058.2772506-1-mchitale@ventanamicro.com>
References: <20230518175058.2772506-1-mchitale@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=mchitale@ventanamicro.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Implement the s/h/mstateen.fcsr bit as defined in the smstateen spec
and check for it when accessing the fcsr register and its fields.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
---
 target/riscv/csr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4451bd1263..3f6b824bd2 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -82,6 +82,10 @@ static RISCVException fs(CPURISCVState *env, int csrno)
         !riscv_cpu_cfg(env)->ext_zfinx) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
+
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
+        return smstateen_acc_ok(env, 0, SMSTATEEN0_FCSR);
+    }
 #endif
     return RISCV_EXCP_NONE;
 }
@@ -2100,6 +2104,9 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
                                       target_ulong new_val)
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
+    if (!riscv_has_ext(env, RVF)) {
+        wr_mask |= SMSTATEEN0_FCSR;
+    }
 
     return write_mstateen(env, csrno, wr_mask, new_val);
 }
@@ -2173,6 +2180,10 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
+    if (!riscv_has_ext(env, RVF)) {
+        wr_mask |= SMSTATEEN0_FCSR;
+    }
+
     return write_hstateen(env, csrno, wr_mask, new_val);
 }
 
@@ -2259,6 +2270,10 @@ static RISCVException write_sstateen0(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
+    if (!riscv_has_ext(env, RVF)) {
+        wr_mask |= SMSTATEEN0_FCSR;
+    }
+
     return write_sstateen(env, csrno, wr_mask, new_val);
 }
 
-- 
2.34.1


