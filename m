Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6D07DFC9C
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 23:48:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qygRe-0006rs-Je; Thu, 02 Nov 2023 18:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qygRP-0006a9-Ru
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 18:45:36 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qygRM-0003SQ-52
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 18:45:30 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a8ee23f043so17839127b3.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 15:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698965126; x=1699569926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hh8K8kfptl15Yy23R4V5JcSuazCTpKP+KpFDsC90ckM=;
 b=LACZvZykeJaRcKH4RB3sRrnUOF+7EdMeeZB8M0LYp0rHkY1UGbxPXg34JKwkhIeOeq
 +7eOJEvkPSvdx7B2h+svJPReAFsFOhlBEF2qdr0ox0+ncbsEs+cLf4nq9O+WmYv+NdSn
 Gx1wggrk9nDNajda6WML6Ggjhhd3oV6dOuPD57i2iVWP9kE+vKBVLu4KeIH89I4/dSxp
 U9KIoFiFIR4LkqNHnsME+PN2fx7YG9JzTtRQ2GW1HsEozjAuoOsv1slK6v5oFLrbjQ5h
 wTwRLvQmR5Kgx1No5dm464AstOPo0Aq3uc2qpbfN6GwXUAy7GRvo7m0K0FBpio22vgTG
 5bAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965126; x=1699569926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hh8K8kfptl15Yy23R4V5JcSuazCTpKP+KpFDsC90ckM=;
 b=GOsDMzrgj/Kp16QendTxVEH7ZezpJYv2Z2TyOpBZD/ZVO3z4wzB2HXvdsKbc+5BHxf
 dHKRsIpPzyz9kZFMCqUsS4mlLAcs5eratRP+udxPctGEkFWwwbsmlP05X2qGcQ9Sf2OX
 XDPEyDMIaUxOidrlVzw5UYewR9FAzVzxl8AMMbmHovD1V8R56PkGo3A3Ii1EEEzadrU5
 zGxtsXMW7t5xT4BYhK2QLWTEFKzHe7qsxzPZeVChdVMg67KE1C5poyeRHXPYqLFl0dir
 wP6m6rvwUXhAeM+INYT2hkCplpmZdkxu26d0za6sg4kUmj03ugaFdq4ETEk84IW4b40r
 nIHw==
X-Gm-Message-State: AOJu0Yy58eLBAQlaZYNeSxFi9o2WfyLVGyJh6d1z+pEZLLMRK6QUqGjJ
 ypxcvN4W9T2wov1bPiZwwCDLKfbPc1ezVd5Sh+A=
X-Google-Smtp-Source: AGHT+IFdGavupD37hP4FYyXD6xrhVEbnvkvxXWD/lB5ZM09qy/E3hbGzwtHWg9ykNyWQYT3tBGhFrw==
X-Received: by 2002:a81:7b85:0:b0:59f:687c:fb36 with SMTP id
 w127-20020a817b85000000b0059f687cfb36mr1271510ywc.45.1698965126521; 
 Thu, 02 Nov 2023 15:45:26 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 ce10-20020a05690c098a00b0059b24bd4f2asm259523ywb.57.2023.11.02.15.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 15:45:26 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 14/19] target/riscv/tcg: add hash table insert helpers
Date: Thu,  2 Nov 2023 19:44:40 -0300
Message-ID: <20231102224445.527355-15-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102224445.527355-1-dbarboza@ventanamicro.com>
References: <20231102224445.527355-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1134.google.com
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

Previous patches added several g_hash_table_insert() patterns. Add two
helpers, one for each user hash, to make the code cleaner.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f5a71b38f6..fd9d4e9845 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -42,6 +42,18 @@ static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
                                  GUINT_TO_POINTER(ext_offset));
 }
 
+static void cpu_cfg_ext_add_user_opt(uint32_t ext_offset, bool value)
+{
+    g_hash_table_insert(multi_ext_user_opts, GUINT_TO_POINTER(ext_offset),
+                        (gpointer)value);
+}
+
+static void cpu_misa_ext_add_user_opt(uint32_t bit, bool value)
+{
+    g_hash_table_insert(misa_ext_user_opts, GUINT_TO_POINTER(bit),
+                        (gpointer)value);
+}
+
 static void riscv_cpu_write_misa_bit(RISCVCPU *cpu, uint32_t bit,
                                      bool enabled)
 {
@@ -790,9 +802,7 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    g_hash_table_insert(misa_ext_user_opts,
-                        GUINT_TO_POINTER(misa_bit),
-                        (gpointer)value);
+    cpu_misa_ext_add_user_opt(misa_bit, value);
 
     prev_val = env->misa_ext & misa_bit;
 
@@ -929,9 +939,7 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
             continue;
         }
 
-        g_hash_table_insert(misa_ext_user_opts,
-                            GUINT_TO_POINTER(bit),
-                            (gpointer)value);
+        cpu_misa_ext_add_user_opt(bit, profile->enabled);
         riscv_cpu_write_misa_bit(cpu, bit, profile->enabled);
     }
 
@@ -946,9 +954,7 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
             cpu_validate_multi_ext_priv_ver(&cpu->env, ext_offset);
         }
 
-        g_hash_table_insert(multi_ext_user_opts,
-                            GUINT_TO_POINTER(ext_offset),
-                            (gpointer)profile->enabled);
+        cpu_cfg_ext_add_user_opt(ext_offset, profile->enabled);
         isa_ext_update_enabled(cpu, ext_offset, profile->enabled);
     }
 }
@@ -1011,9 +1017,7 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
                     multi_ext_cfg->name, lower);
     }
 
-    g_hash_table_insert(multi_ext_user_opts,
-                        GUINT_TO_POINTER(multi_ext_cfg->offset),
-                        (gpointer)value);
+    cpu_cfg_ext_add_user_opt(multi_ext_cfg->offset, value);
 
     prev_val = isa_ext_is_enabled(cpu, multi_ext_cfg->offset);
 
-- 
2.41.0


