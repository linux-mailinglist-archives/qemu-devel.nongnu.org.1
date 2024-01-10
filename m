Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D226382958E
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:01:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNURy-0007ol-Bb; Wed, 10 Jan 2024 04:00:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNURe-0005of-D8
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:19 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNURc-0004q8-7F
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:17 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6dde1f23060so979779a34.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877214; x=1705482014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cdi5M6ylQNDMVlJYcPTASmNB5WRXtMrOHptCcDw0A70=;
 b=ekJYg1cbQNAtN4cyPyFQy+HzanM0KjQG6xEgxZB31lHpaDJUJ8sCW61zhTlB4RVffr
 k937AiAbZvniRe4rNIVUq96Tl1VqC/JiNpJgEVFhfSuappZkUSX7H1veUPzWK7MIs5fG
 RSrVVOat9D8lKH23ZZQI0AD6YUJIDBujI/MkXl291OX0qWlUJcGap0VbfKZh0+x6r2sG
 DdPxqZ/EYxpZbLiCh9YpVxdZSsF3iqGeA0u/ly0aNy89PnUHfOjfH4CTUESBeYmRkm3s
 cUlpuDUg4EkoGnTKkGqf34GYQIvRjR/dj/VYGEi6lW711216SnEEJcSLJS/n/UkRFWwN
 Xspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877214; x=1705482014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cdi5M6ylQNDMVlJYcPTASmNB5WRXtMrOHptCcDw0A70=;
 b=GdJDYb2FoZDnK7P9swqlFrWTerTkl8xkEPGYEWSZlvbHsBZVT9pHjufEIDGreUjh6f
 pZYiWZZuOFe7fsdElQdi0i3KqFZPTtbOKsEO2+xvpgGSecQTciZkhyK8Qv9EOtOKzH/5
 +ShJrBoV+MGEjIPicE4yDru55uIQgjKigh9qTJvyBHPdBdQt8Sr/VAjQM1pwGDCBGbGt
 ituqWHX/XEn/1BMEfHhtZMtNy2HDR+Jc8Q9EBMYkKt0SArWex5pywMPF3hfezbc5KaA/
 RruGTlQyzUWYur/yYzFmJya1Z2+K6PjLOm73iGYV/GicwAf45qoqK2K/lqLs1PUBI7yS
 MtfQ==
X-Gm-Message-State: AOJu0Yxo7DvwKYLV2Oy0vFRaiDxHhpLvx042ntR1j4P1/aUF4CCUeizB
 hCtfFGlNjF/xemrcOc4CFhuas965QFaadjWl
X-Google-Smtp-Source: AGHT+IGHtlwqMUGnBglsL2uS1f1flLkDKcrQosnIEWEsLi5t758dYXhYkyL30uDshFH13j5zYoelBQ==
X-Received: by 2002:a05:6358:340b:b0:174:f06b:333d with SMTP id
 h11-20020a056358340b00b00174f06b333dmr750820rwd.41.1704877214326; 
 Wed, 10 Jan 2024 01:00:14 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:00:13 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 39/65] target/riscv/tcg: add MISA user options hash
Date: Wed, 10 Jan 2024 18:57:07 +1000
Message-ID: <20240110085733.1607526-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x32d.google.com
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

We already track user choice for multi-letter extensions because we
needed to honor user choice when enabling/disabling extensions during
realize(). We refrained from adding the same mechanism for MISA
extensions since we didn't need it.

Profile support requires tne need to check for user choice for MISA
extensions, so let's add the corresponding hash now. It works like the
existing multi-letter hash (multi_ext_user_opts) but tracking MISA bits
options in the cpu_set_misa_ext_cfg() callback.

Note that we can't re-use the same hash from multi-letter extensions
because that hash uses cpu->cfg offsets as keys, while for MISA
extensions we're using MISA bits as keys.

After adding the user hash in cpu_set_misa_ext_cfg(), setting default
values with object_property_set_bool() in add_misa_properties() will end
up marking the user choice hash with them. Set the default value
manually to avoid it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20231218125334.37184-12-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 9234254772..731ec2279e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -34,6 +34,7 @@
 
 /* Hash that stores user set extensions */
 static GHashTable *multi_ext_user_opts;
+static GHashTable *misa_ext_user_opts;
 
 static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
 {
@@ -807,6 +808,10 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
+    g_hash_table_insert(misa_ext_user_opts,
+                        GUINT_TO_POINTER(misa_bit),
+                        (gpointer)value);
+
     prev_val = env->misa_ext & misa_bit;
 
     if (value == prev_val) {
@@ -878,6 +883,7 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
  */
 static void riscv_cpu_add_misa_properties(Object *cpu_obj)
 {
+    CPURISCVState *env = &RISCV_CPU(cpu_obj)->env;
     bool use_def_vals = riscv_cpu_is_generic(cpu_obj);
     int i;
 
@@ -898,7 +904,13 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
                             NULL, (void *)misa_cfg);
         object_property_set_description(cpu_obj, name, desc);
         if (use_def_vals) {
-            object_property_set_bool(cpu_obj, name, misa_cfg->enabled, NULL);
+            if (misa_cfg->enabled) {
+                env->misa_ext |= bit;
+                env->misa_ext_mask |= bit;
+            } else {
+                env->misa_ext &= ~bit;
+                env->misa_ext_mask &= ~bit;
+            }
         }
     }
 }
@@ -1147,6 +1159,7 @@ static void tcg_cpu_instance_init(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     Object *obj = OBJECT(cpu);
 
+    misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     riscv_cpu_add_user_properties(obj);
 
-- 
2.43.0


