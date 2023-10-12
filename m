Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 647727C63D3
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:15:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn3D-0000zZ-Le; Thu, 12 Oct 2023 00:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn31-0000y0-2J
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:45 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn2y-0002BN-2n
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:42 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c9daca2b85so3971835ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083894; x=1697688694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=44SzQ0f4qPz9qi5ZdZe9oZ8qxz+GF/V/1JQwsy+mjkA=;
 b=egfr3Mv8vD/PfsGdiOgIhfq0AsB7cXyjNyFOF+frTaa5eT9O5a3ZgxDw7i/JHwR1uB
 nx9AyA6/1F6f/W9slgJqAROLKMmZpAS0nZ6kQbYR3ZjSObDFoz3Vdg3ZOiT0/Cm0mj0k
 4E9xnNC0oXsU7rd7t6ivuiOA5SV+FOrQ4W7uzZFpC4+ue8EbkJv/ic//IPZXxZDX14l6
 149XwN76z5y0kACWpqokfzterF57mcc55UmREoi7UOC6AkF7BazkQbV09oRf47iH4o8R
 I6IpqlzLFMj6mX4CPSU60TqJ0rMLhk8brsgfkI2QAi/ubqMJSmfa1D/OGzPfm7u5xeF7
 XgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083894; x=1697688694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=44SzQ0f4qPz9qi5ZdZe9oZ8qxz+GF/V/1JQwsy+mjkA=;
 b=ZFm5qrdH1XZER2lWyifp1QlKcwRIgIp2UVBydiA0/M4dhVddy4modAgeqquLC+hG9g
 YNNe9PavOUhTj6CIoRFds+mhEC86oRueU1bBoQepNqCglc7uKqMPkNBK5mgasoBXryPq
 8XZy1EAoWQOT5IBfPFDFpqN2hEy42ezjtDbMqqVnPaoUThbOWDH72jukdUQLx9rvvWjT
 p82dv/JY4d6LGR+NVEJR+m43Mr6eka7dwkxpyPoxSjGQpqkBopoKlnr204tDL4uXATSI
 gBDBlx2Cu8LlL+aLtxniKytgTE6c44HWW3p843mBTi7BFnaCRE0Y6g9JxBJ1cJXpJ/kG
 61Rg==
X-Gm-Message-State: AOJu0YwxYBhwBbaydkK62kw7g8SLy0e/6FwJuUf3WicOfCP5hlXV0RhT
 NkyYwAJbPQlJtKFcTiBFrQBydQtrecl7qA==
X-Google-Smtp-Source: AGHT+IGDuPKgPBODL1tPIWsMd+P8M3PLoLbLJIIHXTXnY2GZ8bf58oISagjbgOxZpUGjn9XLc2uCrQ==
X-Received: by 2002:a17:903:228c:b0:1b7:f64b:379b with SMTP id
 b12-20020a170903228c00b001b7f64b379bmr35029430plh.17.1697083893712; 
 Wed, 11 Oct 2023 21:11:33 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:11:32 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/54] target/riscv/cpu.c: add
 riscv_cpu_add_kvm_unavail_prop_array()
Date: Thu, 12 Oct 2023 14:10:05 +1000
Message-ID: <20231012041051.2572507-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

Use a helper in riscv_cpu_add_kvm_properties() to eliminate some of its
code repetition.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230912132423.268494-9-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 848b0d1c82..3cc7cfd7ef 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1972,6 +1972,16 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
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
 void kvm_riscv_cpu_add_kvm_properties(Object *obj)
 {
     Property *prop;
@@ -1980,17 +1990,9 @@ void kvm_riscv_cpu_add_kvm_properties(Object *obj)
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


