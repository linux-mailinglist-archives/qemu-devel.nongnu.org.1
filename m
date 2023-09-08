Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8DF79820A
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:11:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUfM-0003ql-64; Fri, 08 Sep 2023 02:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUfI-0003Zu-Rg
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:08:24 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUfG-0008Cu-DL
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:08:24 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c1ff5b741cso15464515ad.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153300; x=1694758100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcJw2YBF9hVi4EZvjhVffggHOCp+kHpLSU8s1S63DzU=;
 b=WBWupjwTFP+3t48AmGcNtNhrhsAC+g6S6m4DV2sm7Kv3vZCSq2g1qsoni69KhhR8qZ
 MCs1br9OK9yG+DfXIg/pF73vTSlXKOvX4ClckTcqNqfaqGIBHMMNSMYFsXhkfOgqOcqc
 Uu+qFmy8L48nxbNkqZcYXzsGuxpFRMxypGJwZzT8uEiD4WcBxThsIxQQBsnJUQ1wMAbj
 bXr5lcTxCUGUKLa8oz+Ck25MoHnwxc2sA7j3yL/1YLNGEfcWMgJ31h8kUx+zdmB4msx/
 P8SU4wlHT55OT7lg9RZPB3zOYiftlqdaA3kgT6oQbZ7FBso3lmnLPjsBWOAWU2Xauz+D
 s0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153300; x=1694758100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bcJw2YBF9hVi4EZvjhVffggHOCp+kHpLSU8s1S63DzU=;
 b=VQYMuw5pHOJGxAjCyJBEsxcRpmMeHtKIOdV3/HyA81brzcLRM73rHSzjQ1uNA18N3Z
 y0pzRplPjOKYp8ZPEcPdusgDbnzdcL3cB9e8FYl4nPdQ2KjZZctyQNfOaowuULX7TfSq
 e0iQS+82YtkQeHL9wTTUHaJz7ABB9PorKUDJXE+puF/A+f1J2w0VR0MmyOpFw5yt3dvV
 nZOemJKiRXkx5osXjvlvWF9FKgGjhsolfwPXd1OHuo9RD3HpJefofXAkhbOBH13vWON9
 yG3/H0BoZL+OYRVX+tmUF0/76HsnAAhB9FWKxfH4+rzyPifFPbs8qqHnX1rNDN+NbVPP
 m5lQ==
X-Gm-Message-State: AOJu0YwOfsczULL2vz3Y+rNScJLs4RkVVRx0fkEztqmaFIDAGKhmiBzR
 6uj88E3WPeHAo6x720j9lCg/m3NqaJsCIkpe
X-Google-Smtp-Source: AGHT+IH1zeV7dICDYvsFwTh91IApneyetFYXwkikD6zlHZ+bxS5FGIgRE1xhrwMmGzCMqlcHB8/nRw==
X-Received: by 2002:a17:902:d484:b0:1bb:77a2:edda with SMTP id
 c4-20020a170902d48400b001bb77a2eddamr1834642plg.36.1694153300117; 
 Thu, 07 Sep 2023 23:08:20 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:08:18 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>
Subject: [PULL 54/65] target/riscv/cpu.c: limit cfg->vext_spec log message
Date: Fri,  8 Sep 2023 16:04:20 +1000
Message-ID: <20230908060431.1903919-55-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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
Message-ID: <20230901194627.1214811-10-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8cd19a9b9c..3ba92c806b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -959,8 +959,6 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
                                  Error **errp)
 {
-    int vext_version = VEXT_VERSION_1_00_0;
-
     if (!is_power_of_2(cfg->vlen)) {
         error_setg(errp, "Vector extension VLEN must be power of 2");
         return;
@@ -983,17 +981,18 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
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


