Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34488816F24
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 14:00:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFD8x-0003Kz-Hs; Mon, 18 Dec 2023 07:54:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD8v-0003Ju-HM
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:54:45 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD8s-0004zJ-NY
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:54:45 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d393e5d325so8597325ad.2
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 04:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702904081; x=1703508881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mza4nxqGhzcwl/EbRFi83n23pLtga+pTP/PgXSmf4E=;
 b=R7rC1EEKB+ANkkKTApB1WXH+vTuoChsnztMn7XSiIC0F2UleFUBpTlPzyMM6uFAJz+
 TwXZHxtHwT8yc5OXdWk8BT6e0puEPw8bUOKAoQYEzuYVMBQUE2oPv9znBMScNpdeyABn
 Qk6EpF6v1PwK+JV6uaV3FUHcYdazSXqqi8in9VkGPDAFFVfnQuvVO8rgh4RlnYLmGLYH
 p2gpTh2mseO8jhK527UfeX1qLNiC3H/jcnrXAUq0cSAFTfQdDi9VTHbZEsHN5yJVShB3
 +bfsFBhwdeWMdEe4yKMc9h+eP7lfCEX40qScYW6HvAyO8/i3gAwwNK0cddOv+oQaOwp6
 bFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702904081; x=1703508881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8mza4nxqGhzcwl/EbRFi83n23pLtga+pTP/PgXSmf4E=;
 b=LcEy6mS7edAaZRG2SXflq0xJfpxMhEOwOQh1Kyl1S6n/2y5dptrw79ff+YRXrjThBt
 Bmtgvb/4JFoPhToopnwC+qyfjvHF8Rqo+r6Z2uTygsZPhLMZWR0eFj7Cgm1HRkHFgzGr
 zYb72SAb42H9pQmGNAAIVqudqXm7rrGFhEHkDJKO4gOAmXmpqtIUNURh8fiDpUklAFFE
 QgN7B3c3nTY9sh2+XCSEBiOF1qnwrlirebI3+7oOoOO8VTmzF61tRYHeyBwmMzK9Co9S
 lxJxRArs6DytGcyyafKhfBp5jsNwhYrgHATLtyZTXaOpNaos+/fwvEfokUpvcy2QddnB
 9rzg==
X-Gm-Message-State: AOJu0YxxoZLk75qafVLJd52tiAmv5t6WHWV4s6bYIzOO6/QyNYEoHpzs
 0b3qNsgcUm1Ynyr0oV2H7OGpOshnqDZJip9RqV4=
X-Google-Smtp-Source: AGHT+IGDT61LUTeLk+yenBrpr7b/imRdGAuiRwpOfWbhcgYefeUSC65gkT/Mb+IZB4dFe/d258ti/Q==
X-Received: by 2002:a17:902:e88a:b0:1d0:6ffd:6e88 with SMTP id
 w10-20020a170902e88a00b001d06ffd6e88mr8200337plg.128.1702904081113; 
 Mon, 18 Dec 2023 04:54:41 -0800 (PST)
Received: from grind.. ([179.93.21.205]) by smtp.gmail.com with ESMTPSA id
 c2-20020a170902848200b001d09c539c96sm7494897plo.229.2023.12.18.04.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 04:54:40 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v13 18/26] target/riscv: add 'rva22u64' CPU
Date: Mon, 18 Dec 2023 09:53:26 -0300
Message-ID: <20231218125334.37184-19-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218125334.37184-1-dbarboza@ventanamicro.com>
References: <20231218125334.37184-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
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

This CPU was suggested by Alistair [1] and others during the profile
design discussions. It consists of the bare 'rv64i' CPU with rva22u64
enabled by default, like an alias of '-cpu rv64i,rva22u64=true'.

Users now have an even easier way of consuming this user-mode profile by
doing '-cpu rva22u64'. Extensions can be enabled/disabled at will on top
of it.

We can boot Linux with this "user-mode" CPU by doing:

-cpu rva22u64,sv39=true,s=true,zifencei=true

[1] https://lore.kernel.org/qemu-riscv/CAKmqyKP7xzZ9Sx=-Lbx2Ob0qCfB7Z+JO944FQ2TQ+49mqo0q_Q@mail.gmail.com/

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu-qom.h     |  1 +
 target/riscv/cpu.c         | 17 +++++++++++++++++
 target/riscv/tcg/tcg-cpu.c |  9 +++++++++
 3 files changed, 27 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 4d1aa54311..12fe78fc52 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -35,6 +35,7 @@
 #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
 #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x-rv128")
 #define TYPE_RISCV_CPU_RV64I            RISCV_CPU_TYPE_NAME("rv64i")
+#define TYPE_RISCV_CPU_RVA22U64         RISCV_CPU_TYPE_NAME("rva22u64")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b9057c8da2..a38d78b2d6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1576,6 +1576,15 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+#if defined(TARGET_RISCV64)
+static void rva22u64_profile_cpu_init(Object *obj)
+{
+    rv64i_bare_cpu_init(obj);
+
+    RVA22U64.enabled = true;
+}
+#endif
+
 static const gchar *riscv_gdb_arch_name(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
@@ -1866,6 +1875,13 @@ void riscv_cpu_list(void)
         .instance_init = initfn            \
     }
 
+#define DEFINE_PROFILE_CPU(type_name, initfn) \
+    {                                         \
+        .name = type_name,                    \
+        .parent = TYPE_RISCV_BARE_CPU,        \
+        .instance_init = initfn               \
+    }
+
 static const TypeInfo riscv_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_CPU,
@@ -1910,6 +1926,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,   rv64_veyron_v1_cpu_init),
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,  rv128_base_cpu_init),
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I, rv64i_bare_cpu_init),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64, rva22u64_profile_cpu_init),
 #endif
 };
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 005d8be26b..04aedf3840 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1095,6 +1095,15 @@ static void riscv_cpu_add_profiles(Object *cpu_obj)
         object_property_add(cpu_obj, profile->name, "bool",
                             cpu_get_profile, cpu_set_profile,
                             NULL, (void *)profile);
+
+        /*
+         * CPUs might enable a profile right from the start.
+         * Enable its mandatory extensions right away in this
+         * case.
+         */
+        if (profile->enabled) {
+            object_property_set_bool(cpu_obj, profile->name, true, NULL);
+        }
     }
 }
 
-- 
2.43.0


