Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9DD8D1232
	for <lists+qemu-devel@lfdr.de>; Tue, 28 May 2024 04:45:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmoz-00020G-Kr; Mon, 27 May 2024 22:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmou-0001wC-Oo
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:44:12 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmos-0003iK-Ql
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:44:12 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-681907aebebso247651a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 19:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864249; x=1717469049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQJJohChSJ2PfThq4oGFFdMUA1uJJ98Ep3im4MVkieI=;
 b=IBEh5O9h3pp1PPHmu86grEaYKOWAOXNm1AvuyeurZhELG8RQSpX7BRQZXQiEQyT/Cl
 BRl6TI2AflSmsaoC46slBHbKXlglej0h2cKzlZRaOy6tMUZTkTMod6xZglPUjgDN24aj
 HqkPdWBJz+YgOUIwl2X8gmIHzrNNTQ/fGScYJjxmQ+RRMjmMg+giSCrLbLrlG4wIkKXt
 LBWuxDtb4JemCeY/4KZP7u+sL9A1EsJ0CsIig2vrn/rAX6LVst1KMqZ74idlF4pHM+U9
 W4jRH9APko9uk2JCO7S/ndGeoJFaJrn94u0dkgPrU/UG095HKzxosMyaIwF/xJvMpHDt
 1e0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864249; x=1717469049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IQJJohChSJ2PfThq4oGFFdMUA1uJJ98Ep3im4MVkieI=;
 b=ggktnJcVfUo0BCv2nTOktxP3E1ItWGzLlyVLX0BlIp5LPV0/g6NGxnT7NGX1T7jUAL
 C7skjGJEk5cApqzK0BVzAyoW+Pb1ndOsxE9sd0+cIK4j+2tJ2zvmtMEMdB1u/jyyrlbg
 ES2IaNdzOKVtQ6Esu3KwIfp/FEYB8c1YA+/x3xGVB0iI3JodLNqt9zEvUFRLwdQZmTaC
 oTOf8DVeyNenDAuxsJ3yXZNlz+XA4nYZPpHyku5pJcTu9GKSc4Nu0YOfMtrlriMyZYMc
 Y4c/BBjRI6v0qr2pOeDRaCCHwI2bM/9FVrFRkNPksryTHumngLPdD0t2KxZWw7i8lUSv
 Qcig==
X-Gm-Message-State: AOJu0YxV6i7saZK06QzK7weB0RFuHiA5tof8lnkkewGSK23wB9v0Z79j
 5iWBzgY21FFnTpD9D3yyfyixk6cJdCa8u5+XrOM8YBwoObZ1/c/oX5qE0g==
X-Google-Smtp-Source: AGHT+IGMCSVaCWDxxuxMZ/DUxHaptWtvEumWXbMgRzB0n8Ojykvfj3vGGZV0Z0gv3a30RePVZh70jA==
X-Received: by 2002:a17:902:684c:b0:1f3:3265:2fb0 with SMTP id
 d9443c01a7336-1f448716b3fmr92730805ad.22.1716864249033; 
 Mon, 27 May 2024 19:44:09 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:44:07 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/28] target/riscv: Raise exceptions on wrs.nto
Date: Tue, 28 May 2024 12:43:03 +1000
Message-ID: <20240528024328.246965-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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

From: Andrew Jones <ajones@ventanamicro.com>

Implementing wrs.nto to always just return is consistent with the
specification, as the instruction is permitted to terminate the
stall for any reason, but it's not useful for virtualization, where
we'd like the guest to trap to the hypervisor in order to allow
scheduling of the lock holding VCPU. Change to always immediately
raise exceptions when the appropriate conditions are present,
otherwise continue to just return. Note, immediately raising
exceptions is also consistent with the specification since the
time limit that should expire prior to the exception is
implementation-specific.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Christoph Müllner <christoph.muellner@vrull.eu>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240424142808.62936-2-ajones@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                       |  1 +
 target/riscv/op_helper.c                    | 11 ++++++++
 target/riscv/insn_trans/trans_rvzawrs.c.inc | 29 ++++++++++++++-------
 3 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 8a63523851..451261ce5a 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -132,6 +132,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 DEF_HELPER_1(sret, tl, env)
 DEF_HELPER_1(mret, tl, env)
 DEF_HELPER_1(wfi, void, env)
+DEF_HELPER_1(wrs_nto, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
 DEF_HELPER_1(tlb_flush_all, void, env)
 /* Native Debug */
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index f414aaebdb..2baf5bc3ca 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -380,6 +380,17 @@ void helper_wfi(CPURISCVState *env)
     }
 }
 
+void helper_wrs_nto(CPURISCVState *env)
+{
+    if (env->virt_enabled && (env->priv == PRV_S || env->priv == PRV_U) &&
+        get_field(env->hstatus, HSTATUS_VTW) &&
+        !get_field(env->mstatus, MSTATUS_TW)) {
+        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
+    } else if (env->priv != PRV_M && get_field(env->mstatus, MSTATUS_TW)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
+}
+
 void helper_tlb_flush(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
diff --git a/target/riscv/insn_trans/trans_rvzawrs.c.inc b/target/riscv/insn_trans/trans_rvzawrs.c.inc
index 32efbff4d5..0eef033838 100644
--- a/target/riscv/insn_trans/trans_rvzawrs.c.inc
+++ b/target/riscv/insn_trans/trans_rvzawrs.c.inc
@@ -16,7 +16,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-static bool trans_wrs(DisasContext *ctx)
+static bool trans_wrs_sto(DisasContext *ctx, arg_wrs_sto *a)
 {
     if (!ctx->cfg_ptr->ext_zawrs) {
         return false;
@@ -40,12 +40,23 @@ static bool trans_wrs(DisasContext *ctx)
     return true;
 }
 
-#define GEN_TRANS_WRS(insn)                                     \
-static bool trans_ ## insn(DisasContext *ctx, arg_ ## insn *a)  \
-{                                                               \
-    (void)a;                                                    \
-    return trans_wrs(ctx);                                      \
-}
+static bool trans_wrs_nto(DisasContext *ctx, arg_wrs_nto *a)
+{
+    if (!ctx->cfg_ptr->ext_zawrs) {
+        return false;
+    }
 
-GEN_TRANS_WRS(wrs_nto)
-GEN_TRANS_WRS(wrs_sto)
+    /*
+     * Depending on the mode of execution, mstatus.TW and hstatus.VTW, wrs.nto
+     * should raise an exception when the implementation-specific bounded time
+     * limit has expired. Our time limit is zero, so we either return
+     * immediately, as does our implementation of wrs.sto, or raise an
+     * exception, as handled by the wrs.nto helper.
+     */
+#ifndef CONFIG_USER_ONLY
+    gen_helper_wrs_nto(tcg_env);
+#endif
+
+    /* We only get here when helper_wrs_nto() doesn't raise an exception. */
+    return trans_wrs_sto(ctx, NULL);
+}
-- 
2.45.1


