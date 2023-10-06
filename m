Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD10C7BB8F9
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 15:23:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qokma-00067O-RO; Fri, 06 Oct 2023 09:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qokmY-000672-Hy
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 09:22:18 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qokmR-0003Fy-Mx
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 09:22:16 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c724577e1fso16884245ad.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 06:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1696598530; x=1697203330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hEKxFBV3S1LkNsoZYztGI8sqhw9WeeKCrlL2/nre/QY=;
 b=DsfSk1yQfNyR6JrVRv6isqNo3bVzkUJSbrMng3xdj44yA+MWnpEXGlVyxZ5zRlV6ch
 3tIcB70vZ0HDK6CKM761upDvJFOzmrC0ww2LBrCyYTNCxO01v9LoVB8nqhixJwqw88UH
 KQVymTkXrbqJzeAjFI/K7ukGkNv8boToGz/jI+/t0YpXk9+Tr6pfl9D5REBBxwLwrATA
 P447P5PKdOx6CQKcwNPQjkwSrBoNnKZqtlfi24lxBaPnUhK/e8hkM0+w3SL6VuBke7Tx
 tVebhS2tmuMsCZG9F502ye6fuhDJDEP+kye2ygaIMqRHr4FPhSB/9YgVXFYVaXmf2qYH
 qJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696598530; x=1697203330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hEKxFBV3S1LkNsoZYztGI8sqhw9WeeKCrlL2/nre/QY=;
 b=bRqLABdJzUjLDquSubCs1X3n72mccacRx3qUHdXOXbj0t8DSRHbfLEtSNOart+Ullv
 z9qsWY9SewR/XA0HE1oL4+4IgCuZPOTjsxbDnN7XpbTWlSSORgxM9vnhSfmi+rK0U/V4
 UtkqLpVE/Yi/JlLB9UFiFWCTiFZ0tQR/CS+XBL4nr0i8kEofI+duJh/W/xhYTd+WYvHJ
 ga7XHSyXJVUf9JjhydTWbUvLo+rjpgln7kjqhUQ6WVSbx6qBp+N380AQHzpexnl8P0SQ
 KGZkOwJ1pM5UYgD+EVMBz1+vo1DHi1ytSbhNEMJAMPwPaIpFnw7fwJUQ+QvOKHB3NXVH
 Xk5Q==
X-Gm-Message-State: AOJu0Yytb5BlX74cZTr1QAObEntWDIRqDAqoTYWKXJa7vdq/d7sObGcl
 d/ft+qeCGuioKeAyOAEIznf99IdE+/GAa4m/g7Q=
X-Google-Smtp-Source: AGHT+IE6UaiuR1mO4+CJRpKhir9aZgcIAdKA27V92jRfB9Iprt05UlBfkOQ1Dr8kmDiQ19pKfggnzA==
X-Received: by 2002:a17:903:41c1:b0:1c3:c687:478c with SMTP id
 u1-20020a17090341c100b001c3c687478cmr9934905ple.8.1696598530069; 
 Fri, 06 Oct 2023 06:22:10 -0700 (PDT)
Received: from grind.. ([177.94.42.196]) by smtp.gmail.com with ESMTPSA id
 c12-20020a170902c1cc00b001c60a548331sm3796669plc.304.2023.10.06.06.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 06:22:09 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 10/10] target/riscv/tcg: add hash table insert helpers
Date: Fri,  6 Oct 2023 10:21:34 -0300
Message-ID: <20231006132134.1135297-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006132134.1135297-1-dbarboza@ventanamicro.com>
References: <20231006132134.1135297-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 target/riscv/tcg/tcg-cpu.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index d7540274f4..d4ad1c09b3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -42,12 +42,24 @@ static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
                                  GUINT_TO_POINTER(ext_offset));
 }
 
+static void cpu_cfg_ext_add_user_opt(uint32_t ext_offset, bool value)
+{
+    g_hash_table_insert(multi_ext_user_opts, GUINT_TO_POINTER(ext_offset),
+                        (gpointer)value);
+}
+
 static bool cpu_misa_ext_is_user_set(uint32_t misa_bit)
 {
     return g_hash_table_contains(misa_ext_user_opts,
                                  GUINT_TO_POINTER(misa_bit));
 }
 
+static void cpu_misa_ext_add_user_opt(uint32_t bit, bool value)
+{
+    g_hash_table_insert(misa_ext_user_opts, GUINT_TO_POINTER(bit),
+                        (gpointer)value);
+}
+
 static void riscv_cpu_write_misa_bit(RISCVCPU *cpu, uint32_t bit,
                                      bool enabled)
 {
@@ -296,9 +308,7 @@ static void riscv_cpu_commit_profile(RISCVCPU *cpu, RISCVCPUProfile *profile)
             continue;
         }
 
-        g_hash_table_insert(misa_ext_user_opts,
-                            GUINT_TO_POINTER(bit),
-                            (gpointer)profile->enabled);
+        cpu_misa_ext_add_user_opt(bit, profile->enabled);
 
         riscv_cpu_write_misa_bit(cpu, bit, profile->enabled);
     }
@@ -314,9 +324,8 @@ static void riscv_cpu_commit_profile(RISCVCPU *cpu, RISCVCPUProfile *profile)
             continue;
         }
 
-        g_hash_table_insert(multi_ext_user_opts,
-                            GUINT_TO_POINTER(ext_offset),
-                            (gpointer)profile->enabled);
+        cpu_cfg_ext_add_user_opt(ext_offset, profile->enabled);
+
         isa_ext_update_enabled(cpu, ext_offset, profile->enabled);
     }
 }
@@ -724,9 +733,7 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    g_hash_table_insert(misa_ext_user_opts,
-                        GUINT_TO_POINTER(misa_bit),
-                        (gpointer)value);
+    cpu_misa_ext_add_user_opt(misa_bit, value);
 
     prev_val = env->misa_ext & misa_bit;
 
@@ -867,9 +874,7 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    g_hash_table_insert(multi_ext_user_opts,
-                        GUINT_TO_POINTER(multi_ext_cfg->offset),
-                        (gpointer)value);
+    cpu_cfg_ext_add_user_opt(multi_ext_cfg->offset, value);
 
     prev_val = isa_ext_is_enabled(cpu, multi_ext_cfg->offset);
 
-- 
2.41.0


