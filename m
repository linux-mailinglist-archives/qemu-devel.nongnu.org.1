Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 131D57F66AC
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:52:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EoF-0008SM-57; Thu, 23 Nov 2023 13:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6EoB-0008Hy-IG
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:52:15 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6Eo5-0000Bs-Ad
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:52:13 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5bd33a450fdso819133a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700765526; x=1701370326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IcFmOWMQtTKzILzU8WHNKi0gSvrauioMiSu2DiYuiQY=;
 b=X0c3heZ/G7Lbk8ZLQhdDqFVEexwzggNOBOwPBQaC927XfWA+HUVj6QNlqIu0SaStvt
 8FrXNA3KuOxHRdgqxJTKAGMxmARuySNfDqul9nhyHzyNM5Yl2puJ+1FZYuzi+b4nJyVm
 48K14riX3TthDSY6mv8naGo1GFrBKnXpUGsZuJRJR53WPkZ1t0Qc5y/0H4eRGzArtMVg
 Z1aw+vToFcBSi01FnO1guhR9Yygm8ctcy6VlZ2qGCpZf8HoAIfyJsbegDegmOpmg8X4v
 ZJsci7cdRayMoge20ovNXuoUO++v0MkPRUxsUu9eJdaxbeQnVemFLdnDT8xvMtTTRVcq
 lQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700765526; x=1701370326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IcFmOWMQtTKzILzU8WHNKi0gSvrauioMiSu2DiYuiQY=;
 b=esSjMfVB8WsHMK/c/VvIUJiBH3ZxNppAhEUJNbkjBAZ2/s441NB1E/EYm05OqwJwlu
 A0SH5lSXRP4835BPYM4YQhgrlD32GikHtE1F1xmPmcdLLRLdHtZHc2wVEidBZiWaa0Ej
 XcIDPXzANk3dEBirBZt11HAA8+6v/4BL+PmkXUHdMk8q8RbvRgtC7QOcqtbko7dwc6J+
 opCPPKpLN+CTt5n26vFaN3Ua6Gfnld3GU56m3bfLTu8XBzxd1bshn1RGI8VLlo1Z5kO1
 NYHzd36CJ3Jvb383dYrY1vHNbuwjFNzmFIjXPnCmu3mMn/Nb8sBdZkvYtM6xVhbbHK33
 WXFA==
X-Gm-Message-State: AOJu0YxRTmlNqtKelgIzfskr+nQRC8G0DsMKsWaQADeWqSxJC9YLSM3H
 X5PROfwtdlkTnT6OGmgMgMa+dWzzFLuzbhC4/E0=
X-Google-Smtp-Source: AGHT+IHbDturBk3f43LS/DUN1fGaMxgnhK+sgjlP5ylK9Ijw4NKzgRbPV2ulITWBwXYAWzs2+xszIQ==
X-Received: by 2002:a05:6a21:9997:b0:18b:cc7e:de3 with SMTP id
 ve23-20020a056a21999700b0018bcc7e0de3mr546157pzb.41.1700765525867; 
 Thu, 23 Nov 2023 10:52:05 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a17090282c400b001bb1f0605b2sm1662638plz.214.2023.11.23.10.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 10:52:05 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v11 12/18] target/riscv/tcg: add
 riscv_cpu_write_misa_bit()
Date: Thu, 23 Nov 2023 15:51:16 -0300
Message-ID: <20231123185122.1100436-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123185122.1100436-1-dbarboza@ventanamicro.com>
References: <20231123185122.1100436-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x536.google.com
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
index 930aa7465b..5f770243d0 100644
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
@@ -833,13 +847,9 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
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
@@ -883,7 +893,6 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
  */
 static void riscv_cpu_add_misa_properties(Object *cpu_obj)
 {
-    CPURISCVState *env = &RISCV_CPU(cpu_obj)->env;
     bool use_def_vals = riscv_cpu_is_generic(cpu_obj);
     int i;
 
@@ -904,13 +913,8 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
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


