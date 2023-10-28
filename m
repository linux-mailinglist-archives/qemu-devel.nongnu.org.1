Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE6A7DA603
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 10:56:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwf67-0000ia-Er; Sat, 28 Oct 2023 04:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qwf63-0000TF-A5
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 04:55:07 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qwf60-0004MW-Kj
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 04:55:07 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5a86b6391e9so23304907b3.0
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 01:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698483303; x=1699088103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2IAQNk/qEquJ7/g/MtnPuB4ns7RNFa43Mb8hxD4Sx8g=;
 b=CJPppq1Xqorziw+TUkdA9l0z7ZotPlKiEGaW/hSklmbqqdQ+6tvOWmjGi6KpfvGWWb
 L0k1LIDhHDMLcs696QOtbX65QrQHFu8dbDgkt9eVn2Y3nyJEhiK4vBGdd93JJs+gK9Hg
 GmR75AiCIrZbho4Hnzp7qhPhrC27/p3S8oi24ZlnhxmEXNTfbwyyb3Qpe7dYDQRgLeZG
 DYCKWM1k9TzleNiFBSNQXVegJs1LEOJKZsh1QzswKuW8MtMVoOaXdrFNb84ueZROgdYn
 CnQyE3/RmF+zAvCUS/jBOCgBwg5O/VXSlQJGHK/f3e+gsxZeOnEgWb9qBg2zgJECdJqe
 C+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698483303; x=1699088103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2IAQNk/qEquJ7/g/MtnPuB4ns7RNFa43Mb8hxD4Sx8g=;
 b=PhCfUp6gCaQq2IFGitIGxzN85QMHIVL3amtfyFCa8cTWZwVxfSg5ls022mdd1F51Z5
 2xwjlxHOjgAWfHW01xfZDVoDYXtCXykwJq7lCbArxX1Tp1p86UK1/SFHE/9Vwacq45Lz
 ytb/WtkejbyRyo2j0jMwsUi1Cndn11etER6O9gaVXQhJaOw+gfLWeWGIRzmtP1AAFtmi
 jEm7bbXPIjHZGSfSwfWRJZaa2Z8gN6zCRnwra6zxCwbt/zCUBb7JhuFkh7MN7mjio9q+
 DqSjCmJNw6RM/Nyv9p6W+biZ84+8vJ+NPbYN4/uSKhu4zIJLLP9QU6hKgVTWZeu7Hq/i
 Fqxw==
X-Gm-Message-State: AOJu0Yxh+tslGpwtoQ3qPFFBIsQxCimpcOIfXQtlbKmcqSjQUO02quPC
 yPCmHaSRi/fVz8ifVMThgWS0ouwqGuVtvXkFVfo=
X-Google-Smtp-Source: AGHT+IGYxa7K4HDro8kFKdBgfpeg+LlLopfsg6gAQRWgSHDP53ikFJH6Dys2KSMnGsheY583nYy7eQ==
X-Received: by 2002:a0d:eb92:0:b0:59b:fb69:1639 with SMTP id
 u140-20020a0deb92000000b0059bfb691639mr4483783ywe.32.1698483302930; 
 Sat, 28 Oct 2023 01:55:02 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([191.255.2.33])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a81830f000000b00594fff48796sm1604325ywf.75.2023.10.28.01.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 01:55:02 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 10/12] target/riscv/tcg: add hash table insert helpers
Date: Sat, 28 Oct 2023 05:54:25 -0300
Message-ID: <20231028085427.707060-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231028085427.707060-1-dbarboza@ventanamicro.com>
References: <20231028085427.707060-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1129.google.com
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

Latest patches added several g_hash_table_insert() patterns. Add two
helpers, one for each user hash, to make the code cleaner.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 6ba27b824b..3a96b1f476 100644
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
@@ -710,9 +722,7 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    g_hash_table_insert(misa_ext_user_opts,
-                        GUINT_TO_POINTER(misa_bit),
-                        (gpointer)value);
+    cpu_misa_ext_add_user_opt(misa_bit, value);
 
     prev_val = env->misa_ext & misa_bit;
 
@@ -835,18 +845,14 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
             continue;
         }
 
-        g_hash_table_insert(misa_ext_user_opts,
-                            GUINT_TO_POINTER(bit),
-                            (gpointer)value);
+        cpu_misa_ext_add_user_opt(bit, profile->enabled);
         riscv_cpu_write_misa_bit(cpu, bit, profile->enabled);
     }
 
     for (i = 0; profile->ext_offsets[i] != RISCV_PROFILE_EXT_LIST_END; i++) {
         ext_offset = profile->ext_offsets[i];
 
-        g_hash_table_insert(multi_ext_user_opts,
-                            GUINT_TO_POINTER(ext_offset),
-                            (gpointer)profile->enabled);
+        cpu_cfg_ext_add_user_opt(ext_offset, profile->enabled);
         isa_ext_update_enabled(cpu, ext_offset, profile->enabled);
     }
 }
@@ -909,9 +915,7 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
                     multi_ext_cfg->name, lower);
     }
 
-    g_hash_table_insert(multi_ext_user_opts,
-                        GUINT_TO_POINTER(multi_ext_cfg->offset),
-                        (gpointer)value);
+    cpu_cfg_ext_add_user_opt(multi_ext_cfg->offset, value);
 
     prev_val = isa_ext_is_enabled(cpu, multi_ext_cfg->offset);
 
-- 
2.41.0


