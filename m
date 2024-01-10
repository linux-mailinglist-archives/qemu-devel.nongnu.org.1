Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 948808295C2
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:07:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNURq-0006n5-PR; Wed, 10 Jan 2024 04:00:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUR9-0005IX-Cy
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:51 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUR5-0004Nt-Sk
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:46 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6d9a795cffbso2803237b3a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877182; x=1705481982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YseZjKT6UGh5rCpwBXSTurbsrdaCV7Ypvqgj2xOMRpE=;
 b=GckwaZaqUNDKoSnWvaTuQWERsMla6BmWXseQtnn1aPth2SH1dC7sDnP/JqnuM+Rsxj
 YxOS5HoKOqQT1cpjOe0sKJlkmXOF6Dkw9sLTm1zR14LSGGEZRhmV52Aa2+4aX8V7BWbD
 qXfn8rQf/aVwU3zOXpRA0I0nxbsMURTL8GJlKOhobqsHVquHWofg01lN8cXIBGoGSwi/
 fhIiRl6N5oiko8cXNxusNqy8Z5n96pbnFoHYjzOnjk0NYK18GNrph6uOFVc/mQaR4ScY
 BzztuHPlhHSvm0PFYGj0Ds/gZ67W8ozeJnZKyA0VXtfjKFRlHQAbbgmHKGLgicaki4qp
 SNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877182; x=1705481982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YseZjKT6UGh5rCpwBXSTurbsrdaCV7Ypvqgj2xOMRpE=;
 b=vJXm/Oti4j+D5WGgnk/6s4+E5fiDzz7HsLXXrWd6uT1thqoob2+soADPPpGEefP5Bc
 Ow1oKLMWy0lQ4w9ixavgZW8KlMqHnV2c46JPzdrQnq/l/WnTUl9YD8T7g2D+xUa6vbm0
 cUYpHDN33nHhiRu7yfp7OlEhW15yFVP2zIYqp07Q/5LKc0pH4WFtBBkPSeR6fWA/K482
 EmTZQhS8WskwgNukD6RAdjnnZHscb8RB6yaw+bJAijzT4MFH7F1xRpsBISM1qTP0srrU
 +NOPhv25WDhCNjcA95O/uiNpbRkjN4IVxhIqSGFW4YGDkWKg6GPh8yEd3sIqvKcWRpKx
 8nJA==
X-Gm-Message-State: AOJu0YyRDw/NoNJQZDn+8y49TSbj9+3w4IaoVfyV5EhZWHekSCYAx3P0
 eK5Jny/x0Fh6ecsrXhItOARF5eBpJp+WQR5O
X-Google-Smtp-Source: AGHT+IG4lN9RageaYucaoWD/2gA1T888L+KJ/GaQMiWCyeYAzpMrAJqoAS9D/yFWhmfCHBJPy6yusQ==
X-Received: by 2002:a05:6a00:1d1c:b0:6d9:aad2:46c with SMTP id
 a28-20020a056a001d1c00b006d9aad2046cmr1187783pfx.7.1704877182396; 
 Wed, 10 Jan 2024 00:59:42 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:59:41 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 31/65] target/riscv/tcg: update priv_ver on user_set extensions
Date: Wed, 10 Jan 2024 18:56:59 +1000
Message-ID: <20240110085733.1607526-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

We'll add a new bare CPU type that won't have any default priv_ver. This
means that the CPU will default to priv_ver = 0, i.e. 1.10.0.

At the same we'll allow these CPUs to enable extensions at will, but
then, if the extension has a priv_ver newer than 1.10, we'll end up
disabling it. Users will then need to manually set priv_ver to something
other than 1.10 to enable the extensions they want, which is not ideal.

Change the setter() of extensions to allow user enabled extensions to
bump the priv_ver of the CPU. This will make it convenient for users to
enable extensions for CPUs that doesn't set a default priv_ver.

This change does not affect any existing CPU: vendor CPUs does not allow
extensions to be enabled, and generic CPUs are already set to priv_ver
LATEST.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231218125334.37184-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 7174abb7f5..e9f980805e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -114,6 +114,26 @@ static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
     g_assert_not_reached();
 }
 
+static void cpu_bump_multi_ext_priv_ver(CPURISCVState *env,
+                                        uint32_t ext_offset)
+{
+    int ext_priv_ver;
+
+    if (env->priv_ver == PRIV_VERSION_LATEST) {
+        return;
+    }
+
+    ext_priv_ver = cpu_cfg_ext_get_min_version(ext_offset);
+
+    if (env->priv_ver < ext_priv_ver) {
+        /*
+         * Note: the 'priv_spec' command line option, if present,
+         * will take precedence over this priv_ver bump.
+         */
+        env->priv_ver = ext_priv_ver;
+    }
+}
+
 static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
                                     bool value)
 {
@@ -762,6 +782,14 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
             return;
         }
 
+        if (misa_bit == RVH && env->priv_ver < PRIV_VERSION_1_12_0) {
+            /*
+             * Note: the 'priv_spec' command line option, if present,
+             * will take precedence over this priv_ver bump.
+             */
+            env->priv_ver = PRIV_VERSION_1_12_0;
+        }
+
         env->misa_ext |= misa_bit;
         env->misa_ext_mask |= misa_bit;
     } else {
@@ -891,6 +919,10 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
+    if (value) {
+        cpu_bump_multi_ext_priv_ver(&cpu->env, multi_ext_cfg->offset);
+    }
+
     isa_ext_update_enabled(cpu, multi_ext_cfg->offset, value);
 }
 
-- 
2.43.0


