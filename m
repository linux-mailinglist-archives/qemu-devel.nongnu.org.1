Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 481D379D208
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 15:26:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg3OB-0002oW-LL; Tue, 12 Sep 2023 09:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qg3O8-0002jz-B0
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:25:08 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qg3O5-0003cQ-Ug
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:25:08 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6bdacc5ed66so2973660a34.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 06:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694525102; x=1695129902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iD4s02t8d5otzJTCsin7G8rQN10He0HED5VhIpHbSts=;
 b=ZmoQsCutuDOoqPeQKZuxGc7V8k3CVWNLWSR7I22wxRa0n/zHgQTshdjsQ3EOmuytGH
 ErEIJAmZGlI0ey7evLDOsg2LIioLqCG2Xs2lE8qwXZ3U8jLXMcSJ3aLFipPP3Da+l6AQ
 r9SiSqBTn2ikdksSXCL6m+f3XSBu0bfj4cugU24D/ppUjqMBHxkmrUBhht8MiZkJOwWw
 i2umg7WJwNy6moCjrzfHuqaWybVPwSdGShIYl32tpTPsRCM3rovW59oi1Xjn66Ojs/bN
 pk296NratWAs3AzfZh3yQah4gdB8nYUys9ylTZpLsKISJiZqxocbUQ0dkQBXZDG+nvWx
 LtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694525102; x=1695129902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iD4s02t8d5otzJTCsin7G8rQN10He0HED5VhIpHbSts=;
 b=jf680pnIb34yMc9UpLtmZLveT63DYOCVnOG+p5trF0VU9kn1A3FhOfLPV58IUr2rP3
 XGvOfLCyOj1k4YsO0jIBkWngTHQpBVzaUTAURFeRDcAVcRyxBL+bsfg1OKw4wC2rHwBG
 ENdCnoaEhEpcwUe47qz6TLD2tYxEmN77QOxeb6Z36DhPo/P8ZoaOLlB30UHE5Bv1Tzwt
 CiMmQuaUe5rvJQMAkP+/671wcjBwvWK4agxj5bH5pb0vNbcppcTvvGXFkRQjyZGGC3GE
 c7Z4GH9mYfpKOHBubklOt8b3XCMVbKUQM/ILeu767BGIXgUkOh7TZMtkW2ytgSAKU9ik
 w6NA==
X-Gm-Message-State: AOJu0Yxb0q84I8+iG1qwN9mHIiaFR//2DuEIRSD6PRy28+kCl0ucL11j
 9jyi4n8egBd4BxDuQs5KEeem19sO/2Zg4imdhn4=
X-Google-Smtp-Source: AGHT+IEwFxaZEewhkzowvQQRdqmyyHD2wtzDhTntYHydXDiHG4q9NkNQfH1RpUO5/HDwKd2jcZOVfg==
X-Received: by 2002:a05:6830:1347:b0:6bc:cde2:3038 with SMTP id
 r7-20020a056830134700b006bccde23038mr1559471otq.11.1694525102298; 
 Tue, 12 Sep 2023 06:25:02 -0700 (PDT)
Received: from grind.. ([177.9.182.82]) by smtp.gmail.com with ESMTPSA id
 p15-20020a0568301d4f00b006af9d8af435sm3991255oth.50.2023.09.12.06.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 06:25:02 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v10 09/20] target/riscv/cpu.c: limit cfg->vext_spec log message
Date: Tue, 12 Sep 2023 10:24:12 -0300
Message-ID: <20230912132423.268494-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912132423.268494-1-dbarboza@ventanamicro.com>
References: <20230912132423.268494-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
index 15df29580c..292928fcef 100644
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


