Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D13A7AF2FD
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 20:32:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlCqC-0002tA-KV; Tue, 26 Sep 2023 14:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qlCqA-0002sU-Q3
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 14:31:22 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qlCq9-0003uv-8a
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 14:31:22 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c5bf7871dcso72817205ad.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 11:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695753079; x=1696357879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wuGegwgck8ZEFasbqFPHbzSlisDssAI2uj1gevUmTVY=;
 b=YLxrDnOw79RLz06wjukSF+k1p1dt1wOE9DP1AGnbYS/3vGfS4zDZYgIrgsrvtjZ/l4
 85Qf2e0V83TJ3VQH+L4JdphyAm0Gna0YIHpH2QCySXQ+rnih83EJTzdi3u1S2i+P5y2R
 E+BUpl1oBAg4mZSKpF+ZLBE7JVliSqwu/w35V6EemLcPfvdsJhifuSUAMrG6tGGua4NR
 x6RvySVyc1lopV7aRXlvVZ2wiWLKaeLRoxz0ADxs6bdowGV54SIs9pjmptI4ziU7e4Zm
 kFXEFGXuXkw5uYiPx/V2hKIohK7S8Nr3iG5nsIK0ntMsxIQpZkgN8HpMfF/eP8OPsolz
 oiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695753079; x=1696357879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wuGegwgck8ZEFasbqFPHbzSlisDssAI2uj1gevUmTVY=;
 b=YdeGotR/R1bWRILxGGXxaS7H5N4UrarFTufbXY+s3g6ahd4PqFyrA8eQxUYtSjW/7t
 pWmAs85yKXslyP++TP3aOB+Le3rlswrJbZUWWE8j8Ft8i6oMp3wlX2T0YnvLTmqDSML6
 RD1zO6xzTlUu8TKF3O0t938DagV8jN+VggMmkjBNosAy4t2bUhe0JpDnq6kcp0Z+YiGU
 NO5RcsmRkJJ4rmp3DmCBfQ8jYu3pbNj2efL+G9ss1cwK8YnjSR06gQ/I5cL2oiZasFs4
 s8ThhTbDPjMlYj/yMOw5XjG0XVsAfmCGZbfT1TkYx/OcgMKctGQL7E/7UTEq5SBvCtAw
 EElw==
X-Gm-Message-State: AOJu0YxS/FRrUlYdl8w4LMMJAJ5mE1KuxLnYKP3e+QhjEaGqldHDkuoU
 D7Po9dJjLv3fD9l3GtBOVRhPGVeBRz2eGLzBfSI=
X-Google-Smtp-Source: AGHT+IH82I/4KYW3kBx42+4k8dhUK04YjL0wAylNQAAac4ZTymBrYqkqe4PfQtTDLiyJfbEEbNjdtQ==
X-Received: by 2002:a17:902:da88:b0:1c6:777:712c with SMTP id
 j8-20020a170902da8800b001c60777712cmr6872406plx.51.1695753078860; 
 Tue, 26 Sep 2023 11:31:18 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 u6-20020a170902b28600b001c61acd5bd2sm4715800plr.112.2023.09.26.11.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 11:31:18 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/2] target/riscv: add riscv_cpu_get_name()
Date: Tue, 26 Sep 2023 15:31:08 -0300
Message-ID: <20230926183109.165878-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926183109.165878-1-dbarboza@ventanamicro.com>
References: <20230926183109.165878-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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

We'll introduce generic errors that will output a CPU type name via its
RISCVCPU pointer. Create a helper for that.

Use the helper in tcg_cpu_realizefn() instead of hardcoding the 'host'
CPU name.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         | 11 +++++++++++
 target/riscv/cpu.h         |  1 +
 target/riscv/tcg/tcg-cpu.c |  4 +++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index eeeb08a35a..521bb88538 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -643,6 +643,17 @@ static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
+char *riscv_cpu_get_name(RISCVCPU *cpu)
+{
+    RISCVCPUClass *rcc = RISCV_CPU_GET_CLASS(cpu);
+    const char *typename = object_class_get_name(OBJECT_CLASS(rcc));
+
+    g_assert(g_str_has_suffix(typename, RISCV_CPU_TYPE_SUFFIX));
+
+    return g_strndup(typename,
+                     strlen(typename) - strlen(RISCV_CPU_TYPE_SUFFIX));
+}
+
 static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 219fe2e9b5..3f11e69223 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -730,6 +730,7 @@ typedef struct isa_ext_data {
     int ext_enable_offset;
 } RISCVIsaExtData;
 extern const RISCVIsaExtData isa_edata_arr[];
+char *riscv_cpu_get_name(RISCVCPU *cpu);
 
 void riscv_add_satp_mode_properties(Object *obj);
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 8c052d6fcd..f31aa9bcc4 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -563,7 +563,9 @@ static bool tcg_cpu_realizefn(CPUState *cs, Error **errp)
     Error *local_err = NULL;
 
     if (object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST)) {
-        error_setg(errp, "'host' CPU is not compatible with TCG acceleration");
+        g_autofree char *name = riscv_cpu_get_name(cpu);
+        error_setg(errp, "'%s' CPU is not compatible with TCG acceleration",
+                   name);
         return false;
     }
 
-- 
2.41.0


