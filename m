Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FB0706A54
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 15:59:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzHf7-0001F7-B1; Wed, 17 May 2023 09:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1pzHf3-00014x-2n
 for qemu-devel@nongnu.org; Wed, 17 May 2023 09:57:49 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1pzHf1-0000XE-8G
 for qemu-devel@nongnu.org; Wed, 17 May 2023 09:57:48 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-39431e2b2cdso624436b6e.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 06:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1684331866; x=1686923866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vtUwD5uLnT/SSQASOF4X8pyHibJ8G3gdoTuEx0wIxyE=;
 b=oYxt3NN/HTSHQU+YbD2F4D1Dhl2tF+IQvAGBZr1Ck2CT6RoTA+OD279BlfyN5wVSmV
 tco3HUZSBDfJShhh894sQzxUn/dW14tUhqGNMnx/4xAfIPNysSTkjxpYw6gJ7r77dAhc
 DilmAkUSCpeHOlfAfrgi6IdNXkY1RPwirDWPnIQco5ikzoFR4nq1vLh+xotFKq8Y7Eb7
 i1/u9A3RQJx8EOWqoXV3rVy1Zd77SeHkUBaYwYoPCyTbquH9HGOdBwcjBt2/JsL0hn1V
 KA6xNHP7UgF0eIVaPK/ujZEVMx6unH76MlCLqQ5GLt8K3aRiJEOzANMRKypHT6Ty8ePl
 mRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684331866; x=1686923866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vtUwD5uLnT/SSQASOF4X8pyHibJ8G3gdoTuEx0wIxyE=;
 b=KJ8UVba4aDCz/w1qKu24AfiS86aWJwYTUaqORH9scJqNu3NbGgTKii+3utmDR31Ybk
 CMr0NFqXxd0WOsDRx00Z+vVLbR5Qh8KHlULVL33q2teiXBppmzhswoB9Q2CCrmqHOvXL
 JQMy2Dj2yICNjLCK/oolpeALts3iVmWmqSxZMbUy3suRgxCeuqWHdvLXrss2IuD/lG7Q
 MY96o0YFfbacJ5dUBKFh2R/qyDgzGfgXPvdVqD0zZXD2nxsJq9xs50X6cakqHThvJyP6
 J6QiFvV+DsRbNU3bghKn8Ugwg1PNgx8ad4a6EtPbW6wrPEvwrNufE87wcXyQQG5lHCoJ
 bcag==
X-Gm-Message-State: AC+VfDwS1hBjoyeQMOHZmvJmWVvCJEINH6ufnS+wWd9cV3PKtYVj/UEL
 8oVjAQHDZfsZvKLlLA8URvZBt1t7cIDO11LLst8=
X-Google-Smtp-Source: ACHHUZ5VoKqNqbHLkmJzis+0h2tFNXiVOPwVAosw55x2UAFX2sezXCTaI5J2RvRPgLLT8/im9I4jEA==
X-Received: by 2002:aca:f02:0:b0:394:2478:4966 with SMTP id
 2-20020aca0f02000000b0039424784966mr12342306oip.10.1684331866066; 
 Wed, 17 May 2023 06:57:46 -0700 (PDT)
Received: from grind.. (189-46-207-53.dsl.telesp.net.br. [189.46.207.53])
 by smtp.gmail.com with ESMTPSA id
 j21-20020a544815000000b00383d9700294sm9409562oij.40.2023.05.17.06.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 06:57:45 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 08/11] target/riscv/cpu.c: add riscv_cpu_validate_misa_mxl()
Date: Wed, 17 May 2023 10:57:11 -0300
Message-Id: <20230517135714.211809-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517135714.211809-1-dbarboza@ventanamicro.com>
References: <20230517135714.211809-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x229.google.com
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

Let's remove more code that is open coded in riscv_cpu_realize() and put
it into a helper. Let's also add an error message instead of just
asserting out if env->misa_mxl_max != env->misa_mlx.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 50 ++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 58a38bc62f..32240a0b10 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -910,6 +910,33 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
     }
 }
 
+static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
+{
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
+    CPUClass *cc = CPU_CLASS(mcc);
+    CPURISCVState *env = &cpu->env;
+
+    /* Validate that MISA_MXL is set properly. */
+    switch (env->misa_mxl_max) {
+#ifdef TARGET_RISCV64
+    case MXL_RV64:
+    case MXL_RV128:
+        cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
+        break;
+#endif
+    case MXL_RV32:
+        cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (env->misa_mxl_max != env->misa_mxl) {
+        error_setg(errp, "misa_mxl_max must be equal to misa_mxl");
+        return;
+    }
+}
+
 /*
  * Check consistency between chosen extensions while setting
  * cpu->cfg accordingly.
@@ -1232,7 +1259,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     RISCVCPU *cpu = RISCV_CPU(dev);
     CPURISCVState *env = &cpu->env;
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
-    CPUClass *cc = CPU_CLASS(mcc);
     Error *local_err = NULL;
 
     cpu_exec_realizefn(cs, &local_err);
@@ -1241,6 +1267,12 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    riscv_cpu_validate_misa_mxl(cpu, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     riscv_cpu_validate_priv_spec(cpu, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -1269,22 +1301,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     }
 #endif /* CONFIG_USER_ONLY */
 
-    /* Validate that MISA_MXL is set properly. */
-    switch (env->misa_mxl_max) {
-#ifdef TARGET_RISCV64
-    case MXL_RV64:
-    case MXL_RV128:
-        cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
-        break;
-#endif
-    case MXL_RV32:
-        cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
-        break;
-    default:
-        g_assert_not_reached();
-    }
-    assert(env->misa_mxl_max == env->misa_mxl);
-
     riscv_cpu_validate_set_extensions(cpu, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
-- 
2.40.1


