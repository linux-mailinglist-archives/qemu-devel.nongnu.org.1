Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBA8816F12
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 13:59:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFD8E-0002b8-OA; Mon, 18 Dec 2023 07:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD8C-0002aQ-CV
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:54:00 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD89-0004pX-7Q
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:53:59 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d3b81d9719so3828275ad.2
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 04:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702904035; x=1703508835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydruLMfiESG3aSFT2NTZZn+okESydVOkFbgi5DTMOpA=;
 b=TJsYccLctZXtYBh6Az2Z7ZGlABiFUYquSoHdNdtlofxLCOCgyzbBlHlFUKvXJcFJlS
 pmwbsvpL+GYmdrLjEDwTTf1kgqEQNZ3I7Te8DufgvoQj0+OVQ1qQJuPRCrHk+beYoiCb
 bp7gYjj0vNBw4xMsFR4gdB8zSyxluH/56tHHP5ThdtVK2BwIPWKvk4jNwVbfs8vDWmsq
 QnnWkfuOeYDbv/3CAICqYthtTgYpej1eDcr2BCHf0CJmLhtDh9fFjbZe1lRJ78WM/H14
 sMh8s1zjHNhRTe1XMxaaJ7ZdmP8wPEEkmQEIaJusdxb1k+wGiasqviwZHxHJopo8kA0H
 OUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702904035; x=1703508835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ydruLMfiESG3aSFT2NTZZn+okESydVOkFbgi5DTMOpA=;
 b=UlqioBZ28CPLuL06UTDiKwO0O+2p/aRl1Kub8h7kaezasLKkxhWiQS6H2LUGs7F3b+
 PPU4gmDi5fsc2uzkTp+sG1u6J0pBVODYRxOio2ByRZdYp/axU3YGENzV4rz09u+TaYlx
 BO9oPrbPSe/6bke2B/VCFr+XjjXu5EIJ+jghQyT7OvmobX9SwMNEq+rjZfR+62OahmBw
 BhdeEFws0oHBbj+WBBHVZ9w9JeL5OPDgabDom9hlvS44L0YgaXfc9ob48+FVoG+trv9J
 S0xImE7QyBKnx9sH/x6ghs3MU7WXbgXGaHxqQfh0p5KUq4lQ161roaYqpl2r+JrZ9fEu
 rS5g==
X-Gm-Message-State: AOJu0YzjTS+5a4+GeKLWC77YJ0QvUfBj9mj6/Xc8pbDzjOUch5UWY/S5
 kgi987zf3xwu2DSMfZUwUkCV1XU0y4EniwkYjBI=
X-Google-Smtp-Source: AGHT+IGcUnGgUxU1CZ15kPLmoYiocILXzQIOve/APWmydK8gPaz7vqe/NXpKoUSJqpZ+rpiVg0yoUg==
X-Received: by 2002:a17:903:22d1:b0:1d3:8ed4:de01 with SMTP id
 y17-20020a17090322d100b001d38ed4de01mr1941430plg.4.1702904035567; 
 Mon, 18 Dec 2023 04:53:55 -0800 (PST)
Received: from grind.. ([179.93.21.205]) by smtp.gmail.com with ESMTPSA id
 c2-20020a170902848200b001d09c539c96sm7494897plo.229.2023.12.18.04.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 04:53:55 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v13 03/26] target/riscv/tcg: update priv_ver on user_set
 extensions
Date: Mon, 18 Dec 2023 09:53:11 -0300
Message-ID: <20231218125334.37184-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218125334.37184-1-dbarboza@ventanamicro.com>
References: <20231218125334.37184-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
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
---
 target/riscv/tcg/tcg-cpu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 7670120673..aee98db6f8 100644
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
@@ -757,6 +777,14 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
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
@@ -886,6 +914,10 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
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


