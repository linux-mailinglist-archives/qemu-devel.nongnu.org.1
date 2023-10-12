Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4B27C63F3
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:19:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn4H-0003tE-9h; Thu, 12 Oct 2023 00:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4D-0003X6-Sq
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:57 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4B-0002aG-V1
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:57 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-692eed30152so438184b3a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083974; x=1697688774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3OUwJXNZbMQ920VEgETRrjOhi/kCgCUs6BdrH1amLSM=;
 b=CRz0fXwmVu6osk20Qu4u+WSWbOQdlWvKBgCgGVpKH71apEL0yt5LoS13NVa2sNPLt3
 bOoTMnOxmK1kKX1xC3lf8FHgBbrqd2maEhGtTUj03qQQOcV8awyVl9+EwHGxTa80qA/3
 1ibo1ci4963sfryQ8UuGl7YbW2HpXYzzFV5vWRTJNLqTMviCf9icjFPRb64idhhD0Isa
 vMGBpNZKUD4ykvolO/8vmSOMFQMBJ51XtkVQrO8RxbP0jtEfYeVBLtXiYm0whT51a4yO
 3BnUe1KIXYr6TzObGAiYSZ8vsBnky0g1mlcKsIqz2GeNrnpc5bIAv/q2AcLWnOO9/pK9
 u6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083974; x=1697688774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3OUwJXNZbMQ920VEgETRrjOhi/kCgCUs6BdrH1amLSM=;
 b=M67n7XlfyU0MvGgwwVYylyjQvRYxIcijnGZIo2hiL//tYx/czj17l5NLu0hme9mMnb
 /MI03rWMzVC3noUUtvtJUoCBubMTXrMVL835FIr1gFnhwHcKhqwfSphNywsBidSgZzpv
 KA8N3zlWdi2W9MWhCA3761WaG4j2jRinQibHnMWKxiRwNoObj/zorfQ9BgnF42WtMJsY
 pEN0pI9EKXdxYcp5JQ8UMSmBLDOIG62Jp8PHNhR6dEhfQEFnxcxicu1X8CJOmHAg0CWx
 hA5BupVm1ZrB5dlD/2yTU3MyqWvloxH3Obm4L+qjlcuixJpOnN/MlhhwT+hynWtoLM4x
 Hdeg==
X-Gm-Message-State: AOJu0YyEP79L4YIeH/chQoRorCQ8zyTlpg15L3JCX1BCxNjoeWNOhg5u
 gCPSb9BW3C8DvX2LXtJsqREVHf3ZXHhVMg==
X-Google-Smtp-Source: AGHT+IHmYJEYvh+y2h4KSygPcDY7cO1JJoUForDq7FXjUusgkuHaIR/l9CKjgcxXgkZeLYimHKek3Q==
X-Received: by 2002:a05:6a20:bb23:b0:174:d189:2f8f with SMTP id
 fc35-20020a056a20bb2300b00174d1892f8fmr853957pzb.51.1697083973960; 
 Wed, 11 Oct 2023 21:12:53 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:12:53 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 31/54] target/riscv: make riscv_add_satp_mode_properties()
 public
Date: Thu, 12 Oct 2023 14:10:28 +1000
Message-ID: <20231012041051.2572507-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

This function is used for both accelerators. Make it public, and call it
from kvm_riscv_cpu_add_kvm_properties(). This will make it easier to
split KVM specific code for the KVM accelerator class in the next patch.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230925175709.35696-10-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 1 +
 target/riscv/cpu.c | 5 ++---
 target/riscv/kvm.c | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0afa45aad1..d4b4ac3481 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -726,6 +726,7 @@ extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
 extern Property riscv_cpu_options[];
 
 void riscv_cpu_add_misa_properties(Object *cpu_obj);
+void riscv_add_satp_mode_properties(Object *obj);
 
 /* CSR function table */
 extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c73500151f..143fbc1fbc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1115,7 +1115,7 @@ static void cpu_riscv_set_satp(Object *obj, Visitor *v, const char *name,
     satp_map->init |= 1 << satp;
 }
 
-static void riscv_add_satp_mode_properties(Object *obj)
+void riscv_add_satp_mode_properties(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
 
@@ -1585,12 +1585,11 @@ static void riscv_cpu_add_multiext_prop_array(Object *obj,
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
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index e682a70311..e5e957121f 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -1323,6 +1323,7 @@ void kvm_riscv_cpu_add_kvm_properties(Object *obj)
     DeviceState *dev = DEVICE(obj);
 
     riscv_init_user_properties(obj);
+    riscv_add_satp_mode_properties(obj);
     riscv_cpu_add_misa_properties(obj);
 
     riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_extensions);
-- 
2.41.0


