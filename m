Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBD1790295
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 21:50:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcA6i-0007tI-I0; Fri, 01 Sep 2023 15:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA6g-0007so-J7
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:47:02 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA6e-000369-85
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:47:02 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5717f7b932aso1436464eaf.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 12:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693597619; x=1694202419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l2KbsGlOr8UMgf9yLtUtwDLL3EzfkGCFI4CkT7iJNrA=;
 b=gwY2KuTcvGm8z/GbGLRRgwG84Qu5dLdDJKY1nMEDoSR9Mh3HWEfUmOO4EuvIIQdvNE
 hSURZJ3JIgBz+bhkWxY0Ds/Hz2VzSJQ3yXjDtQ9AkN87kaBgr128dOa/wqPCInpPkzis
 6Zilm7ux1SFHeM+yT6ezX0RWaOYRB5unO9hNgvTyuPKVVZpEIZNFUehwIdfoFHgVxHP8
 9PVtorY3LBfiPGtCYTx5a5dtl3LaPxqTJ0XmLGOyBo5E9T/Yp1vSL9zDM0C9FtCXTBuB
 /OBSDmlONeXzrkYsUqG11waU/s8O5cJIn1E4KqNQ+8WTeGs2x3kEPtMMLCrcBJNnO01O
 qvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693597619; x=1694202419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l2KbsGlOr8UMgf9yLtUtwDLL3EzfkGCFI4CkT7iJNrA=;
 b=hmtmPYdjokjekGhJW0BIRVec8iPYwcT8XS4gaC4M5fYXBrhyeB9yaedta0foercqt8
 x/LBsJ/nPC6YtKP7cD5jA7mvbWY4Fn+LsQsVcSmrATSximRUmZFc2G/JmRspoajUiq9U
 Ndu2kqSsd1ucvdIRVaXc+79mnTCzg+wy9OvB8Gi8STZOh6VH+v+8R7eqpyYeZIuUobPM
 QXamd0Jji68bxp6tCt2iQteD1/dTZtUXcX7aQTwkhHEGe6SpDRjvgQ84y1IDqEtb72VH
 gJtmK2WQ2rum58788HcEY4U3kFiT3MoBkEZGPj/SVIN9zatnkWOUCGIkd1e3rs1sO6oW
 Buzw==
X-Gm-Message-State: AOJu0YwCCVLtMftktx3BqYi5wgZecoYQlxk9pysCesapoh8zKc3EOpMi
 X31ei0wbDKLmVqglcNhbfIpVOMjhx1SWMzQAEco=
X-Google-Smtp-Source: AGHT+IF+BEpytckmqut2nQflWkyG8OGraXzo3acsn8CxtxV7YvnwjDzA4fwW2DfeXWBOzHFTLxcqHA==
X-Received: by 2002:a4a:764d:0:b0:56d:2229:5f94 with SMTP id
 w13-20020a4a764d000000b0056d22295f94mr3588754ooe.6.1693597618999; 
 Fri, 01 Sep 2023 12:46:58 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.194])
 by smtp.gmail.com with ESMTPSA id
 h187-20020a4a5ec4000000b00565d41ba4d0sm2303002oob.35.2023.09.01.12.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 12:46:58 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 08/20] target/riscv/cpu.c: add
 riscv_cpu_add_kvm_unavail_prop_array()
Date: Fri,  1 Sep 2023 16:46:14 -0300
Message-ID: <20230901194627.1214811-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
References: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2a.google.com
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

Use a helper in riscv_cpu_add_kvm_properties() to eliminate some of its
code repetition.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d484d63bcd..8cd19a9b9c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1978,6 +1978,16 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
                         NULL, (void *)prop_name);
 }
 
+static void riscv_cpu_add_kvm_unavail_prop_array(Object *obj,
+                                                 Property *array)
+{
+    g_assert(array);
+
+    for (Property *prop = array; prop && prop->name; prop++) {
+        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
+    }
+}
+
 static void riscv_cpu_add_kvm_properties(Object *obj)
 {
     Property *prop;
@@ -1986,17 +1996,9 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
     kvm_riscv_init_user_properties(obj);
     riscv_cpu_add_misa_properties(obj);
 
-    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
-        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
-    }
-
-    for (prop = riscv_cpu_vendor_exts; prop && prop->name; prop++) {
-        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
-    }
-
-    for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
-        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
-    }
+    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_extensions);
+    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_vendor_exts);
+    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_experimental_exts);
 
     for (prop = riscv_cpu_options; prop && prop->name; prop++) {
         /* Check if KVM created the property already */
-- 
2.41.0


