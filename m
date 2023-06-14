Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A6272F1B6
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:24:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FED-0002Qs-EY; Tue, 13 Jun 2023 21:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDr-0001uO-Bh
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:04 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDp-0004ps-JQ
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:54 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-662f0feafb2so4529387b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705772; x=1689297772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Uj5rMVngMT9Ikb/lrl9dLXEmd5cmQmcW6vsFI0Pm/s=;
 b=Kz3Rqxelg03Ve7uSlXNhd2iKNxq5LuQjtQhHzo2BBNtZJ65qLUWcv8FYJE8PZQbWtz
 XoV7y7eQvVWox0+k0HbJTAVTpLFVFYaMk5uGstmxm/xhZgOt/tUOt+RwB2W+fLB56k7h
 vbYQA52V3na0GIaadzZc2ziBZv7VRy6qvorbeC2Oc002aIsbdTc7vpc1/uLKd6aL3rts
 EzM1cgllkMmP2LfXWiSctfx9Un7dh7sCyg3YCZMBOukts6WsTPDxkHsLAoodSlXz3tIO
 d6DsRmMLgiHOoBkNWii9EFIn/0FflvHd0iUMGhwLKXNkXgYmb1UHWigA1YMuw5QjzMRn
 T4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705772; x=1689297772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Uj5rMVngMT9Ikb/lrl9dLXEmd5cmQmcW6vsFI0Pm/s=;
 b=XCaWAXzzjrextqU42/q5ovZBTvi4VJYUsj9vgUHH4aX8CIXsAxgjrrLCQflH+qQRvz
 CzUsUmqVYUJp7eTp4I3WyDtPkic1TrXyhwUmQ1J1RdMMRwW/LMxpIK7+zX2FaIeiSKuI
 IsT31ncDON3dskIdWQLvtJg+UMBEcFWbZoc4OfCzJ6/ibrO/gd1PEGEKU22qoyXuWUl6
 yGufIo04fmw9wh4oOKJXPjYQ0bQaPjqTnbA+HtzSqM7bCtl4SdDHF0Ebc+s0yYWJAL+1
 wK0rzynDkLpmj1p2G+YucQylh7F+h0JK3Qp9TVwE4f7aOO0G8/yNToVlH1ODcvL+lH1d
 t8lg==
X-Gm-Message-State: AC+VfDyAadcbQPfK84l2vJkwMkn8f2TXiJw/cDl38uzmIfHuDBNJuorC
 3Y5i6bei7QtErskHw3k9rGBwZEmzqfV7ww==
X-Google-Smtp-Source: ACHHUZ6HLiVZSSVjIhLRyO/ag9G5cIcO8fEHz/y4ZL9UdkJsaAyJL0Que/Y5vjqW/Mh6yodKgIQITQ==
X-Received: by 2002:a05:6a00:2d04:b0:662:3edb:4376 with SMTP id
 fa4-20020a056a002d0400b006623edb4376mr348695pfb.6.1686705772165; 
 Tue, 13 Jun 2023 18:22:52 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:22:51 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 35/60] target/riscv: Reuse tb->flags.FS
Date: Wed, 14 Jun 2023 11:19:52 +1000
Message-Id: <20230614012017.3100663-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
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

From: Mayuresh Chitale <mchitale@ventanamicro.com>

When misa.F is 0 tb->flags.FS field is unused and can be used to save
the current state of smstateen0.FCSR check which is needed by the
floating point translation routines.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Message-Id: <20230518175058.2772506-3-mchitale@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c               | 6 ++++++
 target/riscv/insn_trans/trans_rvf.c.inc | 7 ++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 35ddd0caac..523311b184 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -120,6 +120,12 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
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
index c47138575a..a0da7391c7 100644
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
2.40.1


