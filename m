Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0113282958C
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:00:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNURz-0007tA-6f; Wed, 10 Jan 2024 04:00:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNURp-0006pG-Lj
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:29 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNURn-0004zZ-MO
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:29 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6da9c834646so3295321b3a.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877226; x=1705482026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L3EixIIYy+tl4hTES59oO6jSAVXmat5L/QEv3a2WN6s=;
 b=WSCeg+ousJrPml++pXbahgRkKUFB/HEIHzOgKPBwU+p15XwJNSxbsmzwlklaeku80O
 hqKdaI8Sul2Db+OkMwfnqEZ2Wzn0wnZ1xWZG/qJ/jcZowI3nSozxcTWRXNMEUMk1UacQ
 jSStPaw2FsiJu4PQxaEWevyb7eZ9qKs0qpd5+oUgtIAdLkZzKJU/gWXM6GlzHFm+JB3o
 evaUQ8RAulugWhoa/kyzPKknP97QKq1Es+cwzKuUgHT82ZQfQ8DjX12kE7jvsgGV5fiE
 8TFeYRtrXmgYxiRrqQVgguxQHTEaP9GS2Eo0Wi+S+ZFeCWf6RPx6tCoWMpqJ6dlu6dyE
 /P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877226; x=1705482026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L3EixIIYy+tl4hTES59oO6jSAVXmat5L/QEv3a2WN6s=;
 b=Jj3E/Il1yjeV/OKU0F5n8TNHUFkI/p9rkO7cZu72wNZ8ACNGv9bgqCHcR4VEXPXAAf
 xknAkKmO7fXnpUMgRdLaExPUcsRdS5WAJrvH6yd1F9fwiNV/n78+dA9xYvsnDKMewk0u
 IGjy8ABeqzwwFSd2ponzebGnq0vPw4EG9zcv7kdSJKtT1BKp1Nn3h3/sVCYhZlQUHXIx
 IvYTipFnKZ57N9IxiksEydhDudRf7dzF7ig7H9rpUK7UpNkmQuYk48iIuAnKsulRXMMx
 cBf5A3+1ClD7OTc+5tE71P13hlGCKcDhSmr8uL9fQlkL42Bo4hAE6I/S1yaS7TSPpNaj
 eJ7g==
X-Gm-Message-State: AOJu0YzhJtjrlgUuUhlzxHbTZpJkcp11sC0tYMw2h3IolVYg0IQum3HU
 Z3fYjzFjlyiNmYDeo5nbyhQfqA8YUhG2Ttf6
X-Google-Smtp-Source: AGHT+IFh7aPc6Of8tRBKv3GSfgh2F3tNZc3zjByB1KeHgPggtzarqP0i/0StdTlq8QPaXnuuUEPPpQ==
X-Received: by 2002:a05:6a20:7b2f:b0:190:fca:72d8 with SMTP id
 s47-20020a056a207b2f00b001900fca72d8mr584917pzh.109.1704877225975; 
 Wed, 10 Jan 2024 01:00:25 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:00:25 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 42/65] target/riscv/tcg: add hash table insert helpers
Date: Wed, 10 Jan 2024 18:57:10 +1000
Message-ID: <20240110085733.1607526-43-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
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

Previous patches added several g_hash_table_insert() patterns. Add two
helpers, one for each user hash, to make the code cleaner.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231218125334.37184-15-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 9fba3e8143..f1eeaa12b9 100644
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
@@ -822,9 +834,7 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    g_hash_table_insert(misa_ext_user_opts,
-                        GUINT_TO_POINTER(misa_bit),
-                        (gpointer)value);
+    cpu_misa_ext_add_user_opt(misa_bit, value);
 
     prev_val = env->misa_ext & misa_bit;
 
@@ -961,9 +971,7 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
             continue;
         }
 
-        g_hash_table_insert(misa_ext_user_opts,
-                            GUINT_TO_POINTER(bit),
-                            (gpointer)value);
+        cpu_misa_ext_add_user_opt(bit, profile->enabled);
         riscv_cpu_write_misa_bit(cpu, bit, profile->enabled);
     }
 
@@ -978,9 +986,7 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
             cpu_bump_multi_ext_priv_ver(&cpu->env, ext_offset);
         }
 
-        g_hash_table_insert(multi_ext_user_opts,
-                            GUINT_TO_POINTER(ext_offset),
-                            (gpointer)profile->enabled);
+        cpu_cfg_ext_add_user_opt(ext_offset, profile->enabled);
         isa_ext_update_enabled(cpu, ext_offset, profile->enabled);
     }
 }
@@ -1043,9 +1049,7 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
                     multi_ext_cfg->name, lower);
     }
 
-    g_hash_table_insert(multi_ext_user_opts,
-                        GUINT_TO_POINTER(multi_ext_cfg->offset),
-                        (gpointer)value);
+    cpu_cfg_ext_add_user_opt(multi_ext_cfg->offset, value);
 
     prev_val = isa_ext_is_enabled(cpu, multi_ext_cfg->offset);
 
-- 
2.43.0


