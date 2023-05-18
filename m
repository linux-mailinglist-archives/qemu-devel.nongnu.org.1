Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E71C708750
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 19:52:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzhmh-0002i2-J2; Thu, 18 May 2023 13:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1pzhme-0002e8-Ls
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:51:24 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1pzhmZ-0001hm-Ly
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:51:24 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1967cd396a1so1465112fac.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1684432278; x=1687024278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oi2BPBqhwTqWZsbomFMY6RSHe6ZN6RTyyS7h+sX9gec=;
 b=a3qzDFyM5W0en9rjuLL8rxgkwe/d/SbD7IP9CjHAtqR+Clx+gMHdtryva863DcBW6c
 ICjwlWKfOJkamstHDgsuyiV5COMPGBdCji1Jq6hwo9bmE80TqWu7DgjzFmNBJv/9sFpA
 LCi/VABDfLqLWkBADx7eG3ND3p8egwkWB4bURNh0GFNs9lcPavgdtle/7Oef5uLw7+kV
 i4FXHi7OlFrgeiNrXcSaMwD4p38Dk6awnVKoc7vvhjORItY5vNcprZ2AX3dzKAXdlQOA
 CpuQTOmTlApwrP67kPzIALgP9bWazp9AmHvNnMFjT3btQgby7IQuYVM2kyqu61+M+UUj
 R9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684432278; x=1687024278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oi2BPBqhwTqWZsbomFMY6RSHe6ZN6RTyyS7h+sX9gec=;
 b=FPPMV9OfOMDsz3t57SDkji5KjbOY9p9DdUVZQSpT0VfKkiDpTvumgPqRqVRgr1PV8E
 vSIP3iN9HuWruMl5A7KquR6FPUDppm1eW+3yjoIu1gxrvbNsEmr64zAOi0O0D0rEtGhF
 3pa7owQ4Y9NSs3DlTo9/GWEtWZaEU9NOwgqNjAsRY96ZZ2vR6P3KO6xorA2nc4aP2d18
 TK1TGOym+wMm/u/jYirElvIl2oKKblErvGiwZQpN/I5g6KSMnwy6HmsuQzAbqfPMXT/h
 M2JorfptkBpwW12KbvsCLwwG8HQ5lL3IRc2AFAY9/4E82R33Pkt/eDCfLuJ0TGxXKHcd
 aG7w==
X-Gm-Message-State: AC+VfDx2E173Zn8Z3VgDomQIZDdd/SfvMFV9Q22uNXBqscitUJZuWO9i
 /KYRUrj/se29vklrHSSndIWqmV4V26xIPNmLO4WiWA==
X-Google-Smtp-Source: ACHHUZ5VKSnZKXh0cN0v+4e/MdZ8yumLieFJ27GcD9M9m2/bpttIk7lsrxO4s7bSNYUL20IHVfUrEw==
X-Received: by 2002:a05:6870:9514:b0:183:fab4:efb1 with SMTP id
 u20-20020a056870951400b00183fab4efb1mr1260184oal.13.1684432277860; 
 Thu, 18 May 2023 10:51:17 -0700 (PDT)
Received: from mchitale-vm.. ([103.97.165.210])
 by smtp.googlemail.com with ESMTPSA id
 t13-20020a05683014cd00b006ab22bb324asm890832otq.10.2023.05.18.10.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 10:51:17 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	alistair.francis@wdc.com
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Barboza <dbarboza@ventanamicro.com>, liweiwei@iscas.ac.cn,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 2/3] target/riscv: Reuse tb->flags.FS
Date: Thu, 18 May 2023 23:20:57 +0530
Message-Id: <20230518175058.2772506-3-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518175058.2772506-1-mchitale@ventanamicro.com>
References: <20230518175058.2772506-1-mchitale@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=mchitale@ventanamicro.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

When misa.F is 0 tb->flags.FS field is unused and can be used to save
the current state of smstateen0.FCSR check which is needed by the
floating point translation routines.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
---
 target/riscv/cpu_helper.c               | 6 ++++++
 target/riscv/insn_trans/trans_rvf.c.inc | 7 ++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index b68dcfe7b6..695c189f96 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -119,6 +119,12 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
         vs = MIN(vs, get_field(env->mstatus_hs, MSTATUS_VS));
     }
 
+    /* With Zfinx, floating point is enabled/disabled by Smstateen. */
+    if (!riscv_has_ext(env, RVF)) {
+        fs = (smstateen_acc_ok(env, 0, SMSTATEEN0_FCSR) == RISCV_EXCP_NONE)
+             ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
+    }
+
     if (cpu->cfg.debug && !icount_enabled()) {
         flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
     }
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
index b2de4fcf3f..509a6acffe 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -19,9 +19,10 @@
  */
 
 #define REQUIRE_FPU do {\
-    if (ctx->mstatus_fs == EXT_STATUS_DISABLED) \
-        if (!ctx->cfg_ptr->ext_zfinx) \
-            return false; \
+    if (ctx->mstatus_fs == EXT_STATUS_DISABLED) {                           \
+        ctx->virt_inst_excp = ctx->virt_enabled && ctx->cfg_ptr->ext_zfinx; \
+        return false;                                                       \
+    }                                                                       \
 } while (0)
 
 #define REQUIRE_ZFINX_OR_F(ctx) do {\
-- 
2.34.1


