Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 069D977D403
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 22:18:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0T8-0001iE-Di; Tue, 15 Aug 2023 16:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW0T0-0001e6-Rx
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 16:16:43 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW0Sw-00056Z-RY
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 16:16:38 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6bc9c01e154so4005784a34.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 13:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692130593; x=1692735393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMO9L7h6GcuPUuObNtRQb+2ZZDJJDdxAjypEQ+5BnIE=;
 b=F6HuHQiroNIU4+0ksdZ8JR3r1SatOlIR+70Z/BuFAEhlRxNh1ZXd2EOhdmcAvTiU8f
 GBzZShLETXq3Av/c2oPMPxhrwgdOHMrYper3QGNbaZe5RSVpdjTNdzkjvOKdlxd0uzfO
 Y7N/S0hy8aYWu80w8A/5H43DUhSq/tXDNdb8XuxiUGpEKRrf52rj5dYspMuR9k3uBBak
 Q+dMj5/Rx1Ap8+HIRvgn5GrkRC8SzVVdzmvTuabHSnpWdl/4heuN2pmA5CySVEzhxhmr
 XyE2iTNEQ54dPE4fzKOEpoKweppUp9aoSf5fIbZeBdYPdPSgIu0zeTo0nypJfXi287uI
 0ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692130593; x=1692735393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMO9L7h6GcuPUuObNtRQb+2ZZDJJDdxAjypEQ+5BnIE=;
 b=i/pwScxD00FG+qoknBRtSiHHigEEQWy1F0r/4k0k22g+p/XtDjRcUUnS77kbqEI5No
 QG2iazlQMtHlpb9HS6w8GFrUHpR5F1BuppwGPQzSDXuv/2CFj3Gh6OPyLuUDyOL2PkNF
 iYLXAWcrXiOu0imL+3O+O4p8c3T+U4R6gwcO9YCocFmpvhpvW6BGrZZqUR3VqzLf2f1n
 QVmM4kmGq0IpoJIW0Hqkt20sq4M1xntVqst17NZ/gp6xfheBI4ksKLrPf5z8xBMkFdO0
 N10J3hGzdypAOjCyNsCmOjSYydJQn3T1T37PAWI10vWxVH98TfNye5MFXVvGNq31tnb0
 JosA==
X-Gm-Message-State: AOJu0YyzV0aNHyXCsxNzpLDKF6EHg1H+2DSQKgqqU9R/M56dUxojRw8E
 lIvjt8lnWOtLSYy4x1PuZ0ADVwwXLVCiLGiqqxA=
X-Google-Smtp-Source: AGHT+IHFJRJETPz0PtJQfdN/fZftU58PGZPbMs1G3MRiXCs8jekNqFsnlGy+yc4m5Teg5wajt2toVA==
X-Received: by 2002:a05:6870:3929:b0:1c1:e6da:f890 with SMTP id
 b41-20020a056870392900b001c1e6daf890mr886oap.9.1692130593326; 
 Tue, 15 Aug 2023 13:16:33 -0700 (PDT)
Received: from grind.. (189-69-160-189.dial-up.telesp.net.br. [189.69.160.189])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a056870e80e00b001bb5b2a958csm6658203oan.23.2023.08.15.13.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 13:16:33 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 09/12] target/riscv/cpu.c: limit cfg->vext_spec log message
Date: Tue, 15 Aug 2023 17:15:56 -0300
Message-ID: <20230815201559.398643-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815201559.398643-1-dbarboza@ventanamicro.com>
References: <20230815201559.398643-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Inside riscv_cpu_validate_v() we're always throwing a log message if the
user didn't set a vector version via 'vext_spec'.

We're going to include one case with the 'max' CPU where env->vext_ver
will be set in the cpu_init(). But that alone will not stop the "vector
version is not specified" message from appearing. The usefulness of this
log message is debatable for the generic CPUs, but for a 'max' CPU type,
where we are supposed to deliver a CPU model with all features possible,
it's strange to force users to set 'vext_spec' to get rid of this
message.

Change riscv_cpu_validate_v() to not throw this log message if
env->vext_ver is already set.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
---
 target/riscv/cpu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 42f209cd17..33d7fa41d8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -937,8 +937,6 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
                                  Error **errp)
 {
-    int vext_version = VEXT_VERSION_1_00_0;
-
     if (!is_power_of_2(cfg->vlen)) {
         error_setg(errp, "Vector extension VLEN must be power of 2");
         return;
@@ -961,17 +959,18 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
     }
     if (cfg->vext_spec) {
         if (!g_strcmp0(cfg->vext_spec, "v1.0")) {
-            vext_version = VEXT_VERSION_1_00_0;
+            env->vext_ver = VEXT_VERSION_1_00_0;
         } else {
             error_setg(errp, "Unsupported vector spec version '%s'",
                        cfg->vext_spec);
             return;
         }
-    } else {
+    } else if (env->vext_ver == 0) {
         qemu_log("vector version is not specified, "
                  "use the default value v1.0\n");
+
+        env->vext_ver = VEXT_VERSION_1_00_0;
     }
-    env->vext_ver = vext_version;
 }
 
 static void riscv_cpu_validate_priv_spec(RISCVCPU *cpu, Error **errp)
-- 
2.41.0


