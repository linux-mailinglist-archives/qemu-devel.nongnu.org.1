Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3443E79380A
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:24:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdofC-0003PQ-If; Wed, 06 Sep 2023 05:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qdofA-0003Nv-8Y
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:17:28 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qdof7-0005lz-WF
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:17:27 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6c0a42a469dso268583a34.2
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 02:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693991845; x=1694596645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g5E9LLyNurxOieuuNS1GPdHvFJKI2dYtdPNFC2nvFyI=;
 b=R4O3hV5e95MoiAbVvsuiMVN/srlM6xvM+cPRAtZnXbtT/lGwGVf+r/L+gxyCrYYBx8
 NFjo0EdnSgNmoCDNcawAusvfVsBjapi4ZqSCGqtD2TtCRpzhvqRJI6M6wk819URR3nPI
 8zZvespzo4CQONFPcsvi8so74ReTJlhNbiN7Yiz3e+ITnWFXtcxNRTVBQbxQBMeGUgyn
 Fq9DlhyOyCbNzQB9NmES8QfF5Zpf+XdvRxLEIiibjonaadQr8vGZGTdZrjlyGQKbVwhj
 oy9OY2mgtRFoNsscGgkO61eWRrBzOFl1y5Fd1XBiqh9xSwXoLfWPj4dJnXkjJ+y9wNj6
 KfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693991845; x=1694596645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g5E9LLyNurxOieuuNS1GPdHvFJKI2dYtdPNFC2nvFyI=;
 b=HoMdBWt0eYYd4weNytiYKoB+2E5mo/3CZN3HT2CPa7+Z0+60ky7YMK6fP9Z/KsxvHu
 urDIeyT+EoTwQmeQHsMFfjpIgn6KzfDvtx0saEYOkiAEfPq48QPS+Qt3Z/5fvW5f/kVD
 bNgbpeo/lQn8zp3S4HwaAsqQ4bSJzgZNqYYCir0lU3XU3oOaocWw8+5tkXRJjfoTDSez
 mj6PI+aosD8YmG/c/Z0/toW/H/CDi+gtjOBb54VeJYXwjxOZ7RfTv1GmeYa7uyCuyOtp
 dA3NTAjgNVK7asWFMps3wwTdB/ZCJHmqsGytnIGN3duMCjCe2yYXwi5/E2/NJZtHr6ed
 NMAA==
X-Gm-Message-State: AOJu0YzVfC8y/GnTmwsx30c2Tv976IhsJ0/R54b4a6MURmgDYRRn8Ht3
 NI7R30fATIPLeqBxqlhhO/PSze6V8ZFOKdncwXc=
X-Google-Smtp-Source: AGHT+IHVrzotwCtpzjDsNAyJ6JLgNxIpWI6aqaoPIk8jUysidX88bHXc325peq9uvaWtwqeEoPeIJA==
X-Received: by 2002:a9d:6659:0:b0:6bd:7252:9db1 with SMTP id
 q25-20020a9d6659000000b006bd72529db1mr16592617otm.11.1693991844801; 
 Wed, 06 Sep 2023 02:17:24 -0700 (PDT)
Received: from grind.. ([177.94.15.194]) by smtp.gmail.com with ESMTPSA id
 n21-20020a9d6f15000000b006b75242d6c3sm6229228otq.38.2023.09.06.02.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 02:17:24 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 09/19] target/riscv: make riscv_add_satp_mode_properties()
 public
Date: Wed,  6 Sep 2023 06:16:36 -0300
Message-ID: <20230906091647.1667171-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
References: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This function is used for both accelerators. Make it public, and call it
from kvm_riscv_cpu_add_kvm_properties(). This will make it easier to
split KVM specific code for the KVM accelerator class in the next patch.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 5 ++---
 target/riscv/cpu.h | 1 +
 target/riscv/kvm.c | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0dc9b3201d..50be127f36 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1115,7 +1115,7 @@ static void cpu_riscv_set_satp(Object *obj, Visitor *v, const char *name,
     satp_map->init |= 1 << satp;
 }
 
-static void riscv_add_satp_mode_properties(Object *obj)
+void riscv_add_satp_mode_properties(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
 
@@ -1589,12 +1589,11 @@ static void riscv_cpu_add_multiext_prop_array(Object *obj,
 static void riscv_cpu_add_user_properties(Object *obj)
 {
 #ifndef CONFIG_USER_ONLY
-    riscv_add_satp_mode_properties(obj);
-
     if (kvm_enabled()) {
         kvm_riscv_cpu_add_kvm_properties(obj);
         return;
     }
+    riscv_add_satp_mode_properties(obj);
 #endif
 
     riscv_cpu_add_misa_properties(obj);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b9c4bea3f7..950c2301f2 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -726,6 +726,7 @@ extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
 extern Property riscv_cpu_options[];
 
 void riscv_cpu_add_misa_properties(Object *cpu_obj);
+void riscv_add_satp_mode_properties(Object *obj);
 
 /* CSR function table */
 extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 7dac01374f..ef6b2cfffe 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -1279,6 +1279,7 @@ void kvm_riscv_cpu_add_kvm_properties(Object *obj)
     DeviceState *dev = DEVICE(obj);
 
     riscv_init_user_properties(obj);
+    riscv_add_satp_mode_properties(obj);
     riscv_cpu_add_misa_properties(obj);
 
     riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_extensions);
-- 
2.41.0


