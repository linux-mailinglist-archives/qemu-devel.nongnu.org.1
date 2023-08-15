Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8714677D3FB
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 22:17:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0Sz-0001dK-1G; Tue, 15 Aug 2023 16:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW0Sw-0001aQ-Ah
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 16:16:34 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW0St-000562-RK
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 16:16:33 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6bca66e6c44so5014550a34.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 13:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692130590; x=1692735390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DzconJ7fLnpBfc1vkSCW+1DNOKMIUmiFwiaSTlBrr+U=;
 b=hBGq9oHbm/TV2ZR8G8aUT7k8gg8tUgxyl9bEA+mYHMi2udlWVPMAnxdrNX+x/q+nkV
 KkY6YkSzMzHrtkHGW8UlDMzYhoYlSpDUevWltl9yIV8ye9SLOBQ/HZnlBCIPkJVLooT9
 n2+Qdtd1gUiZXOV0ytG4yK6/r5CSeA5M+kVdgyCLc4dYGM3/GJanPk9nVn05lqcth7U6
 0vGCj+uhiju6fRR5Xof/sLfHweAR/9t56jNyArA6+Fr4SQd3VGN+j2F7112hFn/th0yh
 0vVAsZI8hAsvwehBRqE+YFSeNQ2NFtSNG75YvAVLzxJlWOm2V1y+A6x4nvndvZKxuTLG
 8KVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692130590; x=1692735390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DzconJ7fLnpBfc1vkSCW+1DNOKMIUmiFwiaSTlBrr+U=;
 b=Ryhgkny38NUdu1K6YnvQO6CsYcbcmEnzz0TGjPsjtLdv8GK6auhyTtyAAaZKqiD2B4
 1snEuQ3PnGrxeS2LA5pdaSxyIBxgzryCyagMEdo3adivMnvZj1Xxq5Yy3iqkt0D2rqw8
 1qUYTf5jeoCRQ09hmMYltvquPDMME+xKJssoQ0LuQftEdnw/lCp4JOl+UbIJb4LE0hSb
 HucOGememmAGs6mr2d3Vn0qwMBSri+iDclNI9wPSrOuPXtAduQIbikp8Itd5Jl5EjV8Y
 F9UEuZ5IFIjcbxIXDTAA2rJlnYMKt6cBe5SVaG4XdlJwmNaaJA/Bu3MflvNW7dbJTS2i
 InTg==
X-Gm-Message-State: AOJu0YzG/Fj5gB8wtOy9ehRUAcWane3xE7acPTJnxzr2zB10cjpJUihh
 W89a7niapljYNNDQEJ863bH7Vax5or/g8Sm+iTs=
X-Google-Smtp-Source: AGHT+IHIpN2wWSyD1KlorqSlt57K20e/Yb9/prNZjIZybMhTGA5Q27FnKr91JSJmeepuQytFbnS3Wg==
X-Received: by 2002:a05:6871:821:b0:1bd:f87e:6ad3 with SMTP id
 q33-20020a056871082100b001bdf87e6ad3mr15044879oap.30.1692130590550; 
 Tue, 15 Aug 2023 13:16:30 -0700 (PDT)
Received: from grind.. (189-69-160-189.dial-up.telesp.net.br. [189.69.160.189])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a056870e80e00b001bb5b2a958csm6658203oan.23.2023.08.15.13.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 13:16:30 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 08/12] target/riscv/cpu.c: add ADD_UNAVAIL_KVM_PROP_ARRAY()
 macro
Date: Tue, 15 Aug 2023 17:15:55 -0300
Message-ID: <20230815201559.398643-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815201559.398643-1-dbarboza@ventanamicro.com>
References: <20230815201559.398643-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32a.google.com
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

Use a macro in riscv_cpu_add_kvm_properties() to eliminate some of its
code repetition, similar to what we're already doing with
ADD_CPU_QDEV_PROPERTIES_ARRAY().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
---
 target/riscv/cpu.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8e1d944957..42f209cd17 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1908,6 +1908,13 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
                         NULL, (void *)prop_name);
 }
 
+#define ADD_UNAVAIL_KVM_PROP_ARRAY(_obj, _array) \
+    do { \
+        for (Property *prop = _array; prop && prop->name; prop++) { \
+            riscv_cpu_add_kvm_unavail_prop(_obj, prop->name); \
+        } \
+    } while (0)
+
 static void riscv_cpu_add_kvm_properties(Object *obj)
 {
     Property *prop;
@@ -1916,17 +1923,9 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
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
+    ADD_UNAVAIL_KVM_PROP_ARRAY(obj, riscv_cpu_extensions);
+    ADD_UNAVAIL_KVM_PROP_ARRAY(obj, riscv_cpu_vendor_exts);
+    ADD_UNAVAIL_KVM_PROP_ARRAY(obj, riscv_cpu_experimental_exts);
 
     for (prop = riscv_cpu_options; prop && prop->name; prop++) {
         /* Check if KVM created the property already */
-- 
2.41.0


