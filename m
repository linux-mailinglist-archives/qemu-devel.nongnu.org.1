Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CD5816EEB
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 13:57:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFD8k-0002xM-Fd; Mon, 18 Dec 2023 07:54:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD8i-0002wd-D0
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:54:32 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD8g-0004xC-Q5
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:54:32 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d3c21a95e6so2543925ad.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 04:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702904069; x=1703508869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0NoRQmsMm+gnV5bAGramIswAJTZlg/WWrKamnJXxAaQ=;
 b=SaGG8PXkh71Z3zMosMCCNJiQBlVT6b84E6zpv3SOFg2i7Toot+C9rghR64KkQiYa3u
 ACIgzm2L50JkJy6ZCAy+61iiIB5B9NyPMipiiOzWQa0olxkcpHpMkRJlvc0YoETASg52
 j8b7WfcS4N1QYMJ/bpc5oyZ3HiyciydTluRfuuW2UOYlMCLImUDgNNFm308IuCWmMXNz
 Wc43Tv5x7Dho3dOjLmrQcP3olz+Tc2y8tXqlWhsGnCQXhtzQWKjODo/JGZkTfvD5PXjS
 5VIVcXGwiUSI3fbVMaba5vb7juEnLD18CyZD7bl3PUTuD6uRI5FRztzgBmt+5fZt1xNJ
 iTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702904069; x=1703508869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0NoRQmsMm+gnV5bAGramIswAJTZlg/WWrKamnJXxAaQ=;
 b=lW+TS7w15GkyT6kJTXv0dYoBPge/oC+9fo+UODTs3ycNu3/V5hf8pNpenMgUnvYMTf
 grQkt0dlyISCcA8+qLoQrHN/FR3MX5cyzKPipvAwMO2gcybhWzxtZAcE+pLrSObd+jAW
 Sf7VrY9znk+rxbf/KNbtXlTYyWD1eooJ0fHE0/5P4UixP1SWYq4h9cAr4Xe+uLma9fNX
 asjcJgDle6Qo8d2PID5/IIaoafgJ1jfx9oCpVnSsEsgEnPXsbB5LuNCZlN7eg6c7cz1X
 lnKZxtJxUEw/TCnTJRN7hHFnM4odGu4BL/SG7p/tfK6mZ3Z3jwj24SH+/bCGpHv00iLB
 7NJw==
X-Gm-Message-State: AOJu0YyHbcu2DAZEXwBvYpowSNLD3oT81IGCEO0eZjsaJFl6q5X8XZVE
 w6bGSgoXCdScnIcaEej3kfXDMuhXBLi8lYMZIYM=
X-Google-Smtp-Source: AGHT+IFa4duQ//3jKaLklR5ESaxTjp6x4BAXhm3+d72nOOmwfieS4dUCwicJuPHi0ymc2r31TrAs2g==
X-Received: by 2002:a17:902:ea05:b0:1d3:bb5b:c51 with SMTP id
 s5-20020a170902ea0500b001d3bb5b0c51mr750637plg.72.1702904069095; 
 Mon, 18 Dec 2023 04:54:29 -0800 (PST)
Received: from grind.. ([179.93.21.205]) by smtp.gmail.com with ESMTPSA id
 c2-20020a170902848200b001d09c539c96sm7494897plo.229.2023.12.18.04.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 04:54:28 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v13 14/26] target/riscv/tcg: add hash table insert helpers
Date: Mon, 18 Dec 2023 09:53:22 -0300
Message-ID: <20231218125334.37184-15-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218125334.37184-1-dbarboza@ventanamicro.com>
References: <20231218125334.37184-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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
index f2e0ce0f3d..01d2cc9f94 100644
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
@@ -817,9 +829,7 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    g_hash_table_insert(misa_ext_user_opts,
-                        GUINT_TO_POINTER(misa_bit),
-                        (gpointer)value);
+    cpu_misa_ext_add_user_opt(misa_bit, value);
 
     prev_val = env->misa_ext & misa_bit;
 
@@ -956,9 +966,7 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
             continue;
         }
 
-        g_hash_table_insert(misa_ext_user_opts,
-                            GUINT_TO_POINTER(bit),
-                            (gpointer)value);
+        cpu_misa_ext_add_user_opt(bit, profile->enabled);
         riscv_cpu_write_misa_bit(cpu, bit, profile->enabled);
     }
 
@@ -973,9 +981,7 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
             cpu_bump_multi_ext_priv_ver(&cpu->env, ext_offset);
         }
 
-        g_hash_table_insert(multi_ext_user_opts,
-                            GUINT_TO_POINTER(ext_offset),
-                            (gpointer)profile->enabled);
+        cpu_cfg_ext_add_user_opt(ext_offset, profile->enabled);
         isa_ext_update_enabled(cpu, ext_offset, profile->enabled);
     }
 }
@@ -1038,9 +1044,7 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
                     multi_ext_cfg->name, lower);
     }
 
-    g_hash_table_insert(multi_ext_user_opts,
-                        GUINT_TO_POINTER(multi_ext_cfg->offset),
-                        (gpointer)value);
+    cpu_cfg_ext_add_user_opt(multi_ext_cfg->offset, value);
 
     prev_val = isa_ext_is_enabled(cpu, multi_ext_cfg->offset);
 
-- 
2.43.0


