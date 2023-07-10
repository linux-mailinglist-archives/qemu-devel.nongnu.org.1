Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2126F74D582
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:33:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq49-0007fM-C8; Mon, 10 Jul 2023 08:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq46-0007f3-IG
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:32:30 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq44-0002aH-PC
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:32:30 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-263253063f9so3257984a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992347; x=1691584347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YY/UKLqXOLg3s3o22AgNHt3sBhRKC3HPZ9FZbyLtZ48=;
 b=Xs9kNPw4RzWwXYSLEYhq5e45yVc8UQk0TXVC7YUVFl0Hy7m1rhXDkIo7chhyBeaRyB
 SVK0VPBsmiXH5cGN0Lxj3edrA3XgRwxd++MOtjSCemXtD+pO+Xo6e0828E9yEGLKjBxy
 07EXer0cv8oYUi6HKT/azOIG4KqSvn3u3CRWOYebz4iNgF3rKrax1Sxo/nTEjL2yNDbj
 02DP+IQT+hDKRMnOpbW+C8AIkhQ+RNaYYbWpA+CHMVANMQrsJyASTk9GlNWANkijMS6s
 4M4dTn/MRlwYCYWv1ONabXuoBxy73rtG9PeakHmBXeRuUSYmk8P+dHK5EPenCzDYZYVj
 UpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992347; x=1691584347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YY/UKLqXOLg3s3o22AgNHt3sBhRKC3HPZ9FZbyLtZ48=;
 b=cpVOgpX0EjQMoObKBGgbIWzGN6Z+rO6S7qCsjiEjbMEDCmU+no3kErECU5zw9Xuaot
 wsrsuk4e5xWGTR3ObEcUFpxJCGXm1olDxnxYj3+tqOLUAj3TypAW1mXmRT+v1ge46RaV
 MJLQKRZNoxu7J1666US+10oVBLLnhwI520WNGpqj/pV8J/yhW/+gsq/g1/9g4wGUGx/H
 kRDJ6ebBDTeLAvdRPN5mnWvouGXbubZ7F40ZKZVZyniXsNkhPyS6e5pTzS6j3dOMZlFe
 nHutVDaBsoorPeaxwAJeosljObnffSfRIZGE9neMOxZnZHcUM+TcXfl0WtugoR+eM8ey
 4YlQ==
X-Gm-Message-State: ABy/qLZB2ECEiuP/gDz/ROehucuC38mdmcE9aXuy8R1kZBQJNZo4vUv3
 lxVRwmBrL8678s4VoRg8Tpc7dYdc81mXnQ==
X-Google-Smtp-Source: APBJJlGAaO1yUJd7ME2tpezLuKKw1VlGjY1KPxp9yyqUZmn9lVHEPp3TiRQwO3we8ydjKrxAwNgdvg==
X-Received: by 2002:a17:90b:4a92:b0:263:5d42:79f7 with SMTP id
 lp18-20020a17090b4a9200b002635d4279f7mr14051296pjb.23.1688992346776; 
 Mon, 10 Jul 2023 05:32:26 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:32:26 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/54] target/riscv: Factor out extension tests to cpu_cfg.h
Date: Mon, 10 Jul 2023 22:31:13 +1000
Message-Id: <20230710123205.2441106-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1032.google.com
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

From: Christoph Müllner <christoph.muellner@vrull.eu>

This patch moves the extension test functions that are used
to gate vendor extension decoders, into cpu_cfg.h.
This allows to reuse them in the disassembler.

This patch does not introduce new functionality.
However, the patch includes a small change:
The parameter for the extension test functions has been changed
from 'DisasContext*' to 'const RISCVCPUConfig*' to keep
the code in cpu_cfg.h self-contained.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Message-Id: <20230612111034.3955227-3-christoph.muellner@vrull.eu>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h   | 26 ++++++++++++++++++++++++++
 target/riscv/translate.c | 27 ++-------------------------
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index c4a627d335..0b4fe4b540 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -133,4 +133,30 @@ struct RISCVCPUConfig {
 };
 
 typedef struct RISCVCPUConfig RISCVCPUConfig;
+
+/* Helper functions to test for extensions.  */
+
+static inline bool always_true_p(const RISCVCPUConfig *cfg __attribute__((__unused__)))
+{
+    return true;
+}
+
+static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
+{
+    return cfg->ext_xtheadba || cfg->ext_xtheadbb ||
+           cfg->ext_xtheadbs || cfg->ext_xtheadcmo ||
+           cfg->ext_xtheadcondmov ||
+           cfg->ext_xtheadfmemidx || cfg->ext_xtheadfmv ||
+           cfg->ext_xtheadmac || cfg->ext_xtheadmemidx ||
+           cfg->ext_xtheadmempair || cfg->ext_xtheadsync;
+}
+
+#define MATERIALISE_EXT_PREDICATE(ext) \
+    static inline bool has_ ## ext ## _p(const RISCVCPUConfig *cfg) \
+    { \
+        return cfg->ext_ ## ext ; \
+    }
+
+MATERIALISE_EXT_PREDICATE(XVentanaCondOps)
+
 #endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 8a33da811e..0a5ab89c43 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -121,29 +121,6 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
     return ctx->misa_ext & ext;
 }
 
-static bool always_true_p(DisasContext *ctx  __attribute__((__unused__)))
-{
-    return true;
-}
-
-static bool has_xthead_p(DisasContext *ctx  __attribute__((__unused__)))
-{
-    return ctx->cfg_ptr->ext_xtheadba || ctx->cfg_ptr->ext_xtheadbb ||
-           ctx->cfg_ptr->ext_xtheadbs || ctx->cfg_ptr->ext_xtheadcmo ||
-           ctx->cfg_ptr->ext_xtheadcondmov ||
-           ctx->cfg_ptr->ext_xtheadfmemidx || ctx->cfg_ptr->ext_xtheadfmv ||
-           ctx->cfg_ptr->ext_xtheadmac || ctx->cfg_ptr->ext_xtheadmemidx ||
-           ctx->cfg_ptr->ext_xtheadmempair || ctx->cfg_ptr->ext_xtheadsync;
-}
-
-#define MATERIALISE_EXT_PREDICATE(ext)  \
-    static bool has_ ## ext ## _p(DisasContext *ctx)    \
-    { \
-        return ctx->cfg_ptr->ext_ ## ext ; \
-    }
-
-MATERIALISE_EXT_PREDICATE(XVentanaCondOps);
-
 #ifdef TARGET_RISCV32
 #define get_xl(ctx)    MXL_RV32
 #elif defined(CONFIG_USER_ONLY)
@@ -1134,7 +1111,7 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
      * that are tested in-order until a decoder matches onto the opcode.
      */
     static const struct {
-        bool (*guard_func)(DisasContext *);
+        bool (*guard_func)(const RISCVCPUConfig *);
         bool (*decode_func)(DisasContext *, uint32_t);
     } decoders[] = {
         { always_true_p,  decode_insn32 },
@@ -1163,7 +1140,7 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
         ctx->opcode = opcode32;
 
         for (size_t i = 0; i < ARRAY_SIZE(decoders); ++i) {
-            if (decoders[i].guard_func(ctx) &&
+            if (decoders[i].guard_func(ctx->cfg_ptr) &&
                 decoders[i].decode_func(ctx, opcode32)) {
                 return;
             }
-- 
2.40.1


