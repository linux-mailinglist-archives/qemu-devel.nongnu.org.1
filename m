Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6334B7DE6CA
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 21:45:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyI3G-0002sS-U0; Wed, 01 Nov 2023 16:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyI3F-0002sH-Pq
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:42:57 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyI3E-0000nU-CE
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:42:57 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d9fe0a598d8so187217276.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 13:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698871373; x=1699476173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mWO+9Z7Zky8teICfCxCS0aM7RNTTSpKadlq/tPtIWB4=;
 b=TvVjzYi2KEp5cVjZOazqc1nUBwkpwpHlNNIdYIvPe4m3grS97Ss5suZBN9tcv3qFWe
 FjRTp0XqEUGNR/6s+I2b2DTB/5K6xqHi1bg6RyHh8fcmqCRi/Jmk8ks8abvNtllE+LqC
 69YEXdnT/qV7XOMSQfUkmDaNx/8dmqjPtFn8WzxkoWipAk+jb1V++s5+RD4SIQT2UNvq
 KaiAeUIGhqHLrCWU7gZWPNtqYL/Pj4XAZXVxeojFt+g/RRF4ls1J5eeSMWN1uRLrikMg
 e/mfzE/+OZ/ZU1EenefcYg08wu/3W8/taxrPAzxdvHw/RvDTNhtTx9iun6S6DI1t4aaW
 0fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698871373; x=1699476173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mWO+9Z7Zky8teICfCxCS0aM7RNTTSpKadlq/tPtIWB4=;
 b=HG1Mz0XcpVLp+DwOuJ7Jlm/ngkfFDwr8ZstsIM7e22jaJabcfixKH5pzxz/qUBc7C+
 mFZqg2nvt3p+73J/RRnyufgeBeqTuAYx1pVBwCHv5qrrJOdh+hYr/tpbzJwECoFWo3A9
 UkTVYRqQAP7sVCZt9X+z7pbozYHrD0FvujqQBxc0H4YkMC3a+8ATAQxM8IwrqXqjTmnD
 bJD17I7Kc5s7hbp5NK3gFpAzvtQzHpbfZLcskH9IEnE+4Xi6mriTTbTpQ/Op0CVai4IO
 s+CPN73TNSMfJFyj6hqeKyGPFLJ+JKEJMm0ccVCbWdZzqQiL3F+Jb+Wlb1DT6cTZpsHY
 qa3g==
X-Gm-Message-State: AOJu0YzKQKyCzCi2fgifC8rJxJsfMWRMHZw3lGhesH3ph1JkZPkj3CpA
 pw5kRbo6OmTKZk9ZLn941h93jo2rRa4p6Mxk36k=
X-Google-Smtp-Source: AGHT+IF1OltIDPwrrLMdnvpkWOUAwF1OR1zBnAfm7cVIwaFctqoN0rGkSTjwbrP4VZyKixLos5ViOw==
X-Received: by 2002:a25:244:0:b0:da3:b555:6474 with SMTP id
 65-20020a250244000000b00da3b5556474mr3008444ybc.49.1698871373083; 
 Wed, 01 Nov 2023 13:42:53 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 z187-20020a2533c4000000b00d9cc49edae9sm329724ybz.63.2023.11.01.13.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 13:42:52 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 16/19] target/riscv/tcg: add hash table insert helpers
Date: Wed,  1 Nov 2023 17:42:01 -0300
Message-ID: <20231101204204.345470-17-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101204204.345470-1-dbarboza@ventanamicro.com>
References: <20231101204204.345470-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yb1-xb31.google.com
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
index 4b3e20545a..042f28a093 100644
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
@@ -748,9 +760,7 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    g_hash_table_insert(misa_ext_user_opts,
-                        GUINT_TO_POINTER(misa_bit),
-                        (gpointer)value);
+    cpu_misa_ext_add_user_opt(misa_bit, value);
 
     prev_val = env->misa_ext & misa_bit;
 
@@ -877,9 +887,7 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
             continue;
         }
 
-        g_hash_table_insert(misa_ext_user_opts,
-                            GUINT_TO_POINTER(bit),
-                            (gpointer)value);
+        cpu_misa_ext_add_user_opt(bit, profile->enabled);
         riscv_cpu_write_misa_bit(cpu, bit, profile->enabled);
     }
 
@@ -890,9 +898,7 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
             cpu_validate_multi_ext_priv_ver(&cpu->env, ext_offset);
         }
 
-        g_hash_table_insert(multi_ext_user_opts,
-                            GUINT_TO_POINTER(ext_offset),
-                            (gpointer)profile->enabled);
+        cpu_cfg_ext_add_user_opt(ext_offset, profile->enabled);
         isa_ext_update_enabled(cpu, ext_offset, profile->enabled);
     }
 }
@@ -955,9 +961,7 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
                     multi_ext_cfg->name, lower);
     }
 
-    g_hash_table_insert(multi_ext_user_opts,
-                        GUINT_TO_POINTER(multi_ext_cfg->offset),
-                        (gpointer)value);
+    cpu_cfg_ext_add_user_opt(multi_ext_cfg->offset, value);
 
     prev_val = isa_ext_is_enabled(cpu, multi_ext_cfg->offset);
 
-- 
2.41.0


