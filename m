Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC1F7E03F6
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 14:48:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyuW5-0002A9-CX; Fri, 03 Nov 2023 09:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyuW1-00027r-1H
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 09:47:13 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyuVw-0000xG-U0
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 09:47:12 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a92782615dso24966937b3.2
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 06:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699019227; x=1699624027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yALDtqxGJf0HAgqhtMvDGzn0TN3yf5762cFgSkfuvcA=;
 b=IVpKw2O2KN97altZgvso4yI3h14TkmthJALMI202ZPzaftzPV5YpOu4bRrcLeWN/gz
 8WlkpoYDD6M9ZQ4nu2R+SaafCZ4B0m26BHiziYmk+wmI9/Df4e9aa6fBnQZNa0SeuWJv
 gH/Ye8dSZj5k1qWRCRvy3GD/D/zA3Q9hhAduLQLv7XSSzDhxv5ynWOZkeAXaig8Lpt7t
 aWEbvo+yFKrVKp4/+CA/HTR/jCs+A3gZNWwA16MnWYo9j76GC+lwlC7NMDm4I/feaBbg
 QqufXt6/bVfiMPRzdTlOvCe+UH2NXf9dEYafFKx9Sc9ivndnboTIs/CQ3U2Ym2nUq+tF
 IfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699019227; x=1699624027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yALDtqxGJf0HAgqhtMvDGzn0TN3yf5762cFgSkfuvcA=;
 b=XBUa9ApGeNuvXK53XG0Gz4MWQVvpqbJo4wCUAUJccxHj0M17Hos8EJ6RR2gDM6V0W0
 d2iswxcq4gg/KAkhtJpzMWyggTUDTa3zWKCWrhlmzkPYt9JqhphRcZBjr8nVf2nVkMLF
 Mng1TetInRDgsIoozRe25EGnaXuoyqGe5YMAJoYvZ6qpg70jv/N1rPxyxJmtijHAFWhb
 V3bRXZ72ZRIGxM4VoT6HTVHdM59FRoQKBxI+w3lCyPyh343UDKfmMQ5ru9/sU6iiDfI3
 86YEzUTCRxjKJGdtVpfTrskPL6nc0ohUnkI37UVKckB/btXroNUwSu1hJsa1xJpDyOX/
 TOxQ==
X-Gm-Message-State: AOJu0YxwGCko1jUqLH3nhAU56f6Dpxt8YWmd8UW9iX6kcw0vw8kJAfut
 2gU8aeWihxB23j/ff0yta5jTTmNP7J1mY4krzfM=
X-Google-Smtp-Source: AGHT+IHKAtFLAzrghvW/4mk9uInbNsc5P18Ql/QHX1Y7UlOzq9WngbUtYZmXyXQK5b8gHlHSGCeHeg==
X-Received: by 2002:a05:690c:f92:b0:5a8:1844:124d with SMTP id
 df18-20020a05690c0f9200b005a81844124dmr3356818ywb.9.1699019227267; 
 Fri, 03 Nov 2023 06:47:07 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 j68-20020a0df947000000b00582b239674esm935814ywf.129.2023.11.03.06.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 06:47:06 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v10 12/18] target/riscv/tcg: add riscv_cpu_write_misa_bit()
Date: Fri,  3 Nov 2023 10:46:23 -0300
Message-ID: <20231103134629.561732-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231103134629.561732-1-dbarboza@ventanamicro.com>
References: <20231103134629.561732-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1133.google.com
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

We have two instances of the setting/clearing a MISA bit from
env->misa_ext and env->misa_ext_mask pattern. And the next patch will
end up adding one more.

Create a helper to avoid code repetition.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 2fd395db1c..87e39f7d19 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -42,6 +42,20 @@ static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
                                  GUINT_TO_POINTER(ext_offset));
 }
 
+static void riscv_cpu_write_misa_bit(RISCVCPU *cpu, uint32_t bit,
+                                     bool enabled)
+{
+    CPURISCVState *env = &cpu->env;
+
+    if (enabled) {
+        env->misa_ext |= bit;
+        env->misa_ext_mask |= bit;
+    } else {
+        env->misa_ext &= ~bit;
+        env->misa_ext_mask &= ~bit;
+    }
+}
+
 static void riscv_cpu_synchronize_from_tb(CPUState *cs,
                                           const TranslationBlock *tb)
 {
@@ -805,13 +819,9 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
              */
             env->priv_ver = PRIV_VERSION_1_12_0;
         }
-
-        env->misa_ext |= misa_bit;
-        env->misa_ext_mask |= misa_bit;
-    } else {
-        env->misa_ext &= ~misa_bit;
-        env->misa_ext_mask &= ~misa_bit;
     }
+
+    riscv_cpu_write_misa_bit(cpu, misa_bit, value);
 }
 
 static void cpu_get_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
@@ -855,7 +865,6 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
  */
 static void riscv_cpu_add_misa_properties(Object *cpu_obj)
 {
-    CPURISCVState *env = &RISCV_CPU(cpu_obj)->env;
     bool use_def_vals = riscv_cpu_is_generic(cpu_obj);
     int i;
 
@@ -876,13 +885,8 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
                             NULL, (void *)misa_cfg);
         object_property_set_description(cpu_obj, name, desc);
         if (use_def_vals) {
-            if (misa_cfg->enabled) {
-                env->misa_ext |= bit;
-                env->misa_ext_mask |= bit;
-            } else {
-                env->misa_ext &= ~bit;
-                env->misa_ext_mask &= ~bit;
-            }
+            riscv_cpu_write_misa_bit(RISCV_CPU(cpu_obj), bit,
+                                     misa_cfg->enabled);
         }
     }
 }
-- 
2.41.0


