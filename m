Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A31382D43B
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 07:33:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPGW0-0000TK-UF; Mon, 15 Jan 2024 01:32:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rPGVy-0000QC-HU
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:32:06 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rPGVw-0005iY-Ul
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:32:06 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d3e05abcaeso54272345ad.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 22:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1705300324; x=1705905124;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OSaYglwzeOCnqtXdeYAE5QlmXuvdakxdKkKIO+iGRFE=;
 b=lz63bqhdzxQzHQRGOH07UCe4izrrMSaaKTMzlhWV/UeNE5TjQ1lf8F1yc6nBR5QMu5
 Fy/NVBCnjtK0pUugydswUkeaFEgDOUFGbqHRxFKyg1+MRLAMj8QW4qOsjyde1Gv/AAcx
 ui3i5756vbpjpRnCkTVWmDE0DOBLmau/gEvHKp20Sd+GaUTW5jIP/HrCFAU6546/DjLw
 leNTK3AJv4o/sa+33rPhtie6dQ58UCA3v7tCwaJl+6O8HPVNyTQ2ttnXkyyd/7Pk9IMy
 VHvlFmpjddNsx4b/rnUA0VINWs8cEyGGhjYKjn0MogdiJ7P4VnvMLpA+KQsMbl4k9mAY
 zVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705300324; x=1705905124;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OSaYglwzeOCnqtXdeYAE5QlmXuvdakxdKkKIO+iGRFE=;
 b=CiBwF40G59Hn7TpT2R61rrkBUyyvw4D9HFThvhyOcCksuyJr/TLhZzsAXYLv/u0/81
 NCMnHsOJiaUkTS0FzK3KDBR8Q2j9BAZPmL3HLmGiiAbdJnTYlTGbEMGl/4/6c2cFXR1/
 VBV46mFvCfxYQ48nAXZAEXeM+c+z5viPe9VGF2G6gKozyRk4E69Bejf1x10tY/OkgokT
 VSS17iKPa7AOq4VGtJEl0D1Vm8SnCuyVyfcBWHOXL7UxPXQbRe72T0cumNX9+CpgV99Q
 TVZD/LV5TZSkJKy+S7BiKlSDvz6okYpTNd2IhAtVFIqblbXuRAxZzJdH0TQYAgfK0QMR
 +DqQ==
X-Gm-Message-State: AOJu0Yx7q9D4nGV3/Rv3NT/2+TJgKoE+/4F82g+Tz7Me4VaG43iH2+us
 Q0O6LLNH/MJWru02+Rflqh56G6WZ1LeI1Q==
X-Google-Smtp-Source: AGHT+IEz/m3FymaJsmuua9TDDRDRT6/RgdcJ86Y7h/GJ9mQHjtYczzOF9VvmHeRgRyM2UMF0WBJUkg==
X-Received: by 2002:a17:902:654f:b0:1d3:3357:22b9 with SMTP id
 d15-20020a170902654f00b001d3335722b9mr2370306pln.139.1705300323774; 
 Sun, 14 Jan 2024 22:32:03 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 l2-20020a170902e2c200b001d09c539c96sm6980265plc.229.2024.01.14.22.32.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jan 2024 22:32:03 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 15 Jan 2024 15:31:29 +0900
Subject: [PATCH v9 4/4] target/riscv: Validate misa_mxl_max only once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240115-riscv-v9-4-ff171e1aedc8@daynix.com>
References: <20240115-riscv-v9-0-ff171e1aedc8@daynix.com>
In-Reply-To: <20240115-riscv-v9-0-ff171e1aedc8@daynix.com>
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
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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
index 4b742901e76e..4425bee1275e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1292,6 +1292,26 @@ static const MISAExtInfo misa_ext_info_arr[] = {
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
@@ -1833,6 +1853,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
 
     mcc->misa_mxl_max = (uint32_t)(uintptr_t)data;
+    riscv_cpu_validate_misa_mxl(mcc);
 }
 
 static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 20062acd0f0b..df198ee3a312 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -268,27 +268,6 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
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
@@ -935,8 +914,6 @@ static bool tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
-    riscv_cpu_validate_misa_mxl(cpu);
-
 #ifndef CONFIG_USER_ONLY
     CPURISCVState *env = &cpu->env;
     Error *local_err = NULL;

-- 
2.43.0


