Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5CA810967
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 06:21:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDHfI-0003Os-5V; Wed, 13 Dec 2023 00:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rDHfD-0003Ny-5O
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 00:20:07 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rDHf9-0002ii-So
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 00:20:06 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6d9f8578932so3637478a34.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 21:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702444803; x=1703049603;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8zoH19mO8pbkDnKzvHQ2ehC/OCWndxtGdXdLTzarwOw=;
 b=DPbU/sloRb5DQ8TiKwrddLnMAIibAP/JcqoKqdlPpA18gX2UBcp3028RjPA6+eA2XF
 TgtTRu7zRBJMwaiZf8X2QRH1fmr2+grGRuYh5YYgECDzK/XOI2+vHrJNrixgmMsEkDtE
 QM/wYM4BsW6VQNE6o9E3cUWRCFDNWMQ1muehbRYUi/NEwf9o5bM6wfLlFa93VhN9L1lg
 oR6nic0eUvk1p3sw26EtOzwGlpK0ZPqBnb7eNPr6Yx4k4liP1Y43KVMARn+OND+TEju2
 UnNWuDhMvdRZREgJ46jdhiaeHExUAVhk9REpMR9gLbeQgaT7iLh7yAe1rTNKhfcU+Lpz
 Ifjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702444803; x=1703049603;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8zoH19mO8pbkDnKzvHQ2ehC/OCWndxtGdXdLTzarwOw=;
 b=J8FRCo8cftLZYb000l6XYfubJDSzgQIltIvh3N1/CKx9fdskhJ0eOJQyLNWsgemjRc
 UjOEdbDgwyRf6ujh/WxTiDLA/hfUm0YuRUZ53PGnlD1sBQgerC2upZCYb8hy0xemwWUw
 igDCYl1iyfJoNeWe/0ogtMwMQ6XxvvXwA8RgTvn17wyo/WNsrc9Wf1y5BxfVunNXWCM0
 RchqgzeX456ZKuvrqId4VFUbIhtEeKN18UI8pJ+kfeh74oK7mElpb3ozCS2GTu8isVBk
 +hSDUjDJ67GZj99NqeL+P1pV2VTLkhi8L3Er7FzfffXy/6Ft8l1dEQdX6fZMtYvyL3lP
 TZQw==
X-Gm-Message-State: AOJu0YyH0j4d0+GWqCPACtBvKznir65ZScn7sArOXwNOAmcZypOAMEDQ
 0Z0B9zUB614ZNonQX1QtR53+Iw==
X-Google-Smtp-Source: AGHT+IFurhu7XZ+yUUQZWDj3+sLPkcSyihDJme9gp9z4W+qZOlyw9EAKq+VVsnrcUTldkZvjLslAwg==
X-Received: by 2002:a05:6358:9d94:b0:170:3684:315d with SMTP id
 d20-20020a0563589d9400b001703684315dmr8755570rwo.45.1702444802727; 
 Tue, 12 Dec 2023 21:20:02 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 ch23-20020a17090af41700b0028ae287e869sm484332pjb.26.2023.12.12.21.19.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 21:20:02 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 13 Dec 2023 14:19:32 +0900
Subject: [PATCH v7 4/4] target/riscv: Validate misa_mxl_max only once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-riscv-v7-4-a760156a337f@daynix.com>
References: <20231213-riscv-v7-0-a760156a337f@daynix.com>
In-Reply-To: <20231213-riscv-v7-0-a760156a337f@daynix.com>
To: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Mikhail Tyutin <m.tyutin@yadro.com>, 
 Aleksandr Anenkov <a.anenkov@yadro.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

misa_mxl_max is now a class member and initialized only once for each
class. This also moves the initialization of gdb_core_xml_file which
will be referenced before realization in the future.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/riscv/cpu.c         | 21 +++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c | 23 -----------------------
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2ab61df2217e..b799f1336041 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1247,6 +1247,26 @@ static const MISAExtInfo misa_ext_info_arr[] = {
     MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
 };
 
+static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
+{
+    CPUClass *cc = CPU_CLASS(mcc);
+
+    /* Validate that MISA_MXL is set properly. */
+    switch (mcc->misa_mxl_max) {
+#ifdef TARGET_RISCV64
+    case MXL_RV64:
+    case MXL_RV128:
+        cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
+        break;
+#endif
+    case MXL_RV32:
+        cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static int riscv_validate_misa_info_idx(uint32_t bit)
 {
     int idx;
@@ -1695,6 +1715,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
 
     mcc->misa_mxl_max = (uint32_t)(uintptr_t)data;
+    riscv_cpu_validate_misa_mxl(mcc);
 }
 
 static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 7f6712c81a49..eb243e011ca3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -148,27 +148,6 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
     }
 }
 
-static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu)
-{
-    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
-    CPUClass *cc = CPU_CLASS(mcc);
-
-    /* Validate that MISA_MXL is set properly. */
-    switch (mcc->misa_mxl_max) {
-#ifdef TARGET_RISCV64
-    case MXL_RV64:
-    case MXL_RV128:
-        cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
-        break;
-#endif
-    case MXL_RV32:
-        cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 static void riscv_cpu_validate_priv_spec(RISCVCPU *cpu, Error **errp)
 {
     CPURISCVState *env = &cpu->env;
@@ -676,8 +655,6 @@ static bool tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
-    riscv_cpu_validate_misa_mxl(cpu);
-
 #ifndef CONFIG_USER_ONLY
     CPURISCVState *env = &cpu->env;
     Error *local_err = NULL;

-- 
2.43.0


