Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE4D7CCB5B
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:55:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qspDG-0001Iu-EG; Tue, 17 Oct 2023 14:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspDD-0001I9-6B
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:54:39 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspDB-00072Y-NL
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:54:38 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6c63588b554so3955881a34.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 11:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697568876; x=1698173676;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1vPLdUWkEk40yEOF5gq0S///XvdLUlYQ5AFFo+4KYK0=;
 b=aRxtUtSpV8Htq9V+uwrswr1l61rYj8eUyt7R0uMfSUnOdEXnQYUu9h3Ty1Z7fBXqHu
 wSOiHAhkW1/cGvm48+ElWvvrICprNDEJy3b73Mdr6IOvqZTkmE3uIsThmi9GNNxj4Keg
 pKYuuqffn5KrO/SSnEPpWmj99jiEUvX4/E7u1G1wV6oiEDFRgS536gzPM8S8IzwmzDBE
 XGWJPm5eIhZqri3LGJkiCrwNfkSWoeQPCdwcYzsacX1YaTD46cOn0G2vq7Fhwc9dFG4S
 3HfVRXgl2Ikz+RKJHh89BExJEAuXwIGAKezdpgIza/C1QimQrWWsz9ztnATvzSkcOMo5
 +j0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697568876; x=1698173676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1vPLdUWkEk40yEOF5gq0S///XvdLUlYQ5AFFo+4KYK0=;
 b=nTi4g1Rmbamz0f9RkCu+A9LRd5MQRD80Dd5e6Yg22aQecPzHswYnqKm8E7RpZcGnYm
 1lHQX7kGtt+ZF+GY63gWJ9AnJhl5zIRDm7U616Q72kLqiVL7XILUcSHjK4XR8fOh/vPe
 QVMcmF63EucTMRNParPk1Svj1bqYWC0oBbTYkoWf1Kioxd8IU94gdpK5kDx9yY0cWzOr
 oziS2j5+4aUzykgGJ1XMEwH2z16vWPshEBbAweoATzrdKwX6I45JlMDwiXQDZeMjETMl
 zoU44ky94LJdNk7/8f8mHWL+d61gnr3tf4mjmyDpuFjrFrU3zMvceycXj2Oq9Q4YcARP
 2cIw==
X-Gm-Message-State: AOJu0YyZ0ZoqUKN9sW8AFfdJqxE+QP5NILbzBpeEHp/MNC90Izrg1BdS
 Dkn6mLLt3Tow4b0cnZH7GPyL5A==
X-Google-Smtp-Source: AGHT+IEpUr4lRoglbO9cYwxa1J0OwpA6Ma6jnU2B74nqogvrOldr2yKziSsujd1khtDBSkLkWgM4vw==
X-Received: by 2002:a05:6830:348b:b0:6b9:b1a7:1f92 with SMTP id
 c11-20020a056830348b00b006b9b1a71f92mr4361818otu.8.1697568876672; 
 Tue, 17 Oct 2023 11:54:36 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 w14-20020aa7954e000000b006b287c0ed63sm1813122pfq.137.2023.10.17.11.54.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 11:54:36 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: [PATCH v4 4/5] target/riscv: Validate misa_mxl_max only once
Date: Wed, 18 Oct 2023 03:53:59 +0900
Message-ID: <20231017185406.13381-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017185406.13381-1-akihiko.odaki@daynix.com>
References: <20231017185406.13381-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
index 1fb5747f00..72124e57fd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1193,6 +1193,26 @@ static const MISAExtInfo misa_ext_info_arr[] = {
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
@@ -1593,6 +1613,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
 
     mcc->misa_mxl_max = (uint32_t)(uintptr_t)data;
+    riscv_cpu_validate_misa_mxl(mcc);
 }
 
 static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5bf9d31f7c..a82c49ef67 100644
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
@@ -568,8 +547,6 @@ static bool tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
-    riscv_cpu_validate_misa_mxl(cpu);
-
     riscv_cpu_validate_priv_spec(cpu, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
-- 
2.42.0


