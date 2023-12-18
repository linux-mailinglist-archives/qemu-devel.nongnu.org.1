Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 608528165F7
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 06:16:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF5zU-0007Yx-MA; Mon, 18 Dec 2023 00:16:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rF5zK-0007PW-Th
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 00:16:26 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rF5zJ-0003Q1-9k
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 00:16:22 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6d39132d6baso311171b3a.0
 for <qemu-devel@nongnu.org>; Sun, 17 Dec 2023 21:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702876579; x=1703481379;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SwxfFMSgvKiRy8OjwaFFAy3PG9uGoAZjuKDU8iZg5Oo=;
 b=JlXFv9KAhQukESbeT/TMN89tgUbwal7MF3ZSY3OSIKLedj1wRA6cbJP++zUBXeYq6p
 yAkXyZmvHSaBAv3M+i+JPvN4Tw14cq6XOOfBjsri4FOAhKOAN1pQkzgmEynh1EpOXYGP
 rgJbt+D/O4pUhMCOuP+Ns2P9nfogRfybYcVVhZJndIAIl7jMoM296ONiJrshN0Ui6A7Z
 lC19Z7AhaXmgH7NbawF4Jea/Qo3izml5onAUkeEm9gw5p/NxZJPrm+RD9LpsI2Xm0jcb
 6JKRXJvn4yw8DKL6PTU+yT1x3/uYq05fzmQQfhqdzTN+EckZPIyHhyQ0tqQ9QPxu/o45
 liTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702876579; x=1703481379;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SwxfFMSgvKiRy8OjwaFFAy3PG9uGoAZjuKDU8iZg5Oo=;
 b=wcQbaDEBdRnTp5cjm4tKijBtnaDZ0TGg1Lk0QwF2SXWsAdDz52fMVbe9nRclPJhUpL
 tNJ/G/9GpuKwTD0oXKkVxroVsvaLgU/DAXRihfc/aeKvzCRo83MgxvMoXf2K/AJoyMRa
 55r8iq0E/xR7dZxeb3oZXQ1YsCEdnrAQHSQHwks4fv/Y6eenoHMJLNFbIZcw+SaCGVOQ
 UOwfoK+nzLP2e0K+LdDym816TAnQcYJkqS0CwVk42raWSC4or4Lsaf11MRdVRCrPPBi1
 gByjEsoNcViEg6TfmWRYPg3HihW6zsOh7ndMRk2YNEmvgkt2j7sO5fNzsQa0bT5HTYBU
 zVbA==
X-Gm-Message-State: AOJu0Yw+iDRNVallj0qmb9gHJE1GZHG0/XdRzPw5IKkps+a1ws/e9app
 Kdx2te3PlAaRTjTValerELNSdw==
X-Google-Smtp-Source: AGHT+IG3nwNWa+ck0JX9asokLzJs8ejmGlO5QfUv9SO0nwnMuEwBDxx3PSo+WY6BPBc02vF485fXEg==
X-Received: by 2002:a05:6a20:29a5:b0:190:61a1:3be8 with SMTP id
 f37-20020a056a2029a500b0019061a13be8mr5865096pzh.20.1702876579491; 
 Sun, 17 Dec 2023 21:16:19 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 11-20020a170902c20b00b001ce664c05b0sm18075194pll.33.2023.12.17.21.16.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Dec 2023 21:16:19 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 18 Dec 2023 14:15:50 +0900
Subject: [PATCH v8 4/4] target/riscv: Validate misa_mxl_max only once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-riscv-v8-4-c9bf2b1582d7@daynix.com>
References: <20231218-riscv-v8-0-c9bf2b1582d7@daynix.com>
In-Reply-To: <20231218-riscv-v8-0-c9bf2b1582d7@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

misa_mxl_max is now a class member and initialized only once for each
class. This also moves the initialization of gdb_core_xml_file which
will be referenced before realization in the future.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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


