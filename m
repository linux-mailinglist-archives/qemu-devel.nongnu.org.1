Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 003B27DB2F3
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 06:50:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxL9M-0002f1-QL; Mon, 30 Oct 2023 01:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxL9C-0002e3-7r
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:49:11 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxL9A-0006yn-NS
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:49:10 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6be0277c05bso3448512b3a.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 22:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698644946; x=1699249746;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1vPLdUWkEk40yEOF5gq0S///XvdLUlYQ5AFFo+4KYK0=;
 b=qebRkuUnNCNRdHMiEnOt6oQruCbUUR4x3OW1f4ck1G5rW3hhI8by5lkQG0UEPw/1k8
 LwjtBuBS2qRKDr8h6U+5v1LZw9ext87kWnviHLYnGJ4FPIpgRUQKyiu44kKcvmVy5O9S
 bZOEJbVNdMCiLOhZWPdPJ+amTBxwBV6woa/gQDtFeW7PufSmt33dKx4XaOmRmRIrIETM
 4jJtjBsNX/k6+/4thNqEE7kiMb5dv+pr1wqjwmKRgO1sByuYp0b5zfJDewJQYIbgaLyB
 mArX5JFzz4q4LmBqKStgCoL0DYsGdJcc7Ehln8Bq53hZtwWlapEa8/vkQgY6CZ36VEZ9
 LCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698644946; x=1699249746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1vPLdUWkEk40yEOF5gq0S///XvdLUlYQ5AFFo+4KYK0=;
 b=A6XHWrrk+PCHPYIRziYUzuUzchFmVKlUC0dgq/sLkQc6wXLFdiZpOCC5EDMWXY42+g
 qtYNAmzTck4rt+nBNzBRzNU5RWOlGs18+lowNIQgxkijw+vD0m18cCw1wB/TnXiqcimA
 0PA6yBh1cy61aUCskYVDmsIhwJzR0DVB8a4pZhvKU1LoMB8KryM12xtGbzaFhdgofqek
 7pp/1sGTUYF5Q9wAttUf48SvM8nutkp56TVv6q3B5UGmmBXrqYBif0X4LjoI8cY0sikI
 F0yTT/A0xW8upcHxjZLe9ILExDmJy+DIuXcZr0C6K07dQRiDi63gwtZ3GI1urwEvbCUw
 Wgjg==
X-Gm-Message-State: AOJu0YzbPvWCfJi7Iy8dfBjMjcexCOCvwoD3fpUqzQffiagA54U2+Fae
 0T0dt13ar5Bw2E99V5Gi/j8sSw==
X-Google-Smtp-Source: AGHT+IFIk4uSVvqhxppPs58+JEtRE+s/LsUKN9ORnnvTR/mPbbdaNCHSAuFRxu/10+ZZFChVfmueQA==
X-Received: by 2002:a05:6a00:1803:b0:693:42d2:cde0 with SMTP id
 y3-20020a056a00180300b0069342d2cde0mr7097089pfa.22.1698644946495; 
 Sun, 29 Oct 2023 22:49:06 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 v1-20020aa78501000000b006c031c6c200sm5086779pfn.88.2023.10.29.22.49.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 22:49:06 -0700 (PDT)
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
Subject: [PATCH v6 4/5] target/riscv: Validate misa_mxl_max only once
Date: Mon, 30 Oct 2023 14:46:38 +0900
Message-ID: <20231030054834.39145-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030054834.39145-1-akihiko.odaki@daynix.com>
References: <20231030054834.39145-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
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


