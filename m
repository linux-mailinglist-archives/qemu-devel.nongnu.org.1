Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F26D77D6DAA
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 15:51:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveHh-0001sY-7Z; Wed, 25 Oct 2023 09:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qveHJ-0001Vw-MK
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:50:33 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qveHH-00031q-Vr
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:50:33 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c9e06f058bso7020135ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 06:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698241830; x=1698846630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qagDO5Sc9j5AfzK+QXjTSsdq1EcZLr1j0bu5EIhjJyU=;
 b=o4uOm1+p1Xu49jDmj7J9ZRmgnI/ClOBBsImoyVa6CzPsVzZW6NI/rHQ2OeAdCcgyOK
 UpOJu02qkk5I9nKM1P0MgJor0zAzz4toegkM1ICXzOyCqhTvqR4/7I+kvemXtMrAtFBS
 EKcNywWIvgZYsTWpv7UON4CXlVgSlVV/UnBIbyJkG1Z4nTLKkMqNmzgP8GnswnTmkZre
 sA9CN9HqdfzYg9kQ+Gn8qY/hewgRe38ScczRVCwhfxNmM2XD7wjKGsdXopJSErCiN8kP
 2JLjPnXgmbcwkbaEYy3/NAnZgu3Tkl4ZNu9pbo5tcHeW2nZ772dspeLXDZWL+BFQRn2C
 d+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698241830; x=1698846630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qagDO5Sc9j5AfzK+QXjTSsdq1EcZLr1j0bu5EIhjJyU=;
 b=CvZXUsyFD318C/yYIV2aTTimVNdCZghgRKxWDXQ1PA2mothrWEHsK7jjRrLXD6rhVF
 D+6xcKdC3ga2VDRvy1gzBI+c5fGBlJl6XjviDJhWXZW3YiJZdsa+P7RcHt8Qs/0n7dpq
 PkDECHSi1aXzmoFX7RCoKggX+oCc4zxCHTIZrTzHRS/SZ0GDe7UEMidfKkoXOwSAHZnf
 Vnm5J+ZmfCyQEM83hoQDrLzIl04ILX2ti31CfJ7JZlbDLkZ9CT1PPCoXb2wQ+cEe2w5W
 1hGk+YqznAqvgEwxRFeKyexQthqDGCogaXPCta32Ir84rT53FbEXoUzbaGk+RLRY9zdd
 0VXQ==
X-Gm-Message-State: AOJu0Yzl6NdjJCpfEAH22RwVwqkESsKOBOZ1mMG4Gwu/r54lSptJ51hG
 hPb69LAbjGhb67cYJvqyFAPwPn4J5mI8iddh6dk=
X-Google-Smtp-Source: AGHT+IHtqNyiTku+e3GEnD/k8yLFf944QWVwUlhZEmypKps23vdtiZHrrXPSWWm3QpAleUhsi7P6vg==
X-Received: by 2002:a17:902:d502:b0:1ca:15ad:1c5 with SMTP id
 b2-20020a170902d50200b001ca15ad01c5mr19128685plg.6.1698241830041; 
 Wed, 25 Oct 2023 06:50:30 -0700 (PDT)
Received: from grind.. ([191.255.2.33]) by smtp.gmail.com with ESMTPSA id
 jw4-20020a170903278400b001ca485b8515sm9252548plb.91.2023.10.25.06.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 06:50:29 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 7/9] target/riscv/tcg: add hash table insert helpers
Date: Wed, 25 Oct 2023 10:49:59 -0300
Message-ID: <20231025135001.531224-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025135001.531224-1-dbarboza@ventanamicro.com>
References: <20231025135001.531224-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/riscv/tcg/tcg-cpu.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 57026cfcca..cc7266b903 100644
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
@@ -696,9 +708,7 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    g_hash_table_insert(misa_ext_user_opts,
-                        GUINT_TO_POINTER(misa_bit),
-                        (gpointer)value);
+    cpu_misa_ext_add_user_opt(misa_bit, value);
 
     prev_val = env->misa_ext & misa_bit;
 
@@ -811,18 +821,14 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
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
@@ -885,9 +891,7 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
                     multi_ext_cfg->name, lower);
     }
 
-    g_hash_table_insert(multi_ext_user_opts,
-                        GUINT_TO_POINTER(multi_ext_cfg->offset),
-                        (gpointer)value);
+    cpu_cfg_ext_add_user_opt(multi_ext_cfg->offset, value);
 
     prev_val = isa_ext_is_enabled(cpu, multi_ext_cfg->offset);
 
-- 
2.41.0


