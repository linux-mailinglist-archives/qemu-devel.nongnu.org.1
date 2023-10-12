Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6E77C63E8
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:19:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn3Z-0001tm-3p; Thu, 12 Oct 2023 00:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn3T-0001lY-Qq
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:11 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn3S-0002Nm-1V
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:11 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5859a7d6556so425733a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083927; x=1697688727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PDh5ReaBbU6a9x1izKoB/KaTVJo11IzAODWdbc8earg=;
 b=USxfc1YHjJCG5UGzB5QJnEsTiP8W66Wq3lkCGHjMesf0UX4YVuA+uIZ9lNaMBjIdy6
 YTnpj/1jyqvioge+Tnos4tacBiLDXBQY8drM5+gJIBafhSPQ7D3lN+1PntS/HTg5XDyg
 tFT1VFLVKTWrAZ2tlSLlzH79eHDFFbzbiWt8J7Toic/9x51TtlWD351UVHShDyuKwx49
 EQgJxtIljgz1P7rmkfBgBCcq/6R8nYcqAMBn0IRDZbZD56NZdidIVm4YIlXu8SLeQE8m
 TXQLbzHh9KWgsXhhZHOpXoaKo6lCwWMGdE9mfsnkWTfGY4o+xLZT3HIBnshc9m/N3ZZ/
 cGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083927; x=1697688727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PDh5ReaBbU6a9x1izKoB/KaTVJo11IzAODWdbc8earg=;
 b=D5QA+2zjj2MUddkp9zK5x/L+68i9M4MmN2KGSf5dT1snWYKIbiV8UAeVr/6Ed70Xlr
 WKI5iOa2aGIoVkJfsGq9/CVaCNhm/vtLcXV4dXA3txtFsa0qsl0lyL8FqllFZ6p8CXXb
 uR/6gsivTrnLoNZJOV8nJ407b3LH85UV7rq6Yl5c3fnsMwCWAhkVHMfiExpGmIs+wJh+
 sOpTjstyvpgl05xR1ZzJ00FYHWk37Z0dtiUPF+Q3sDIBSHSIqo3aOjEEeCoS1Xd37/Ul
 LmMIkw2PjCRay56i4SoO4K3Ql/OeX+2a8s4niQkWzvC50Q94gs0N+CfwLuvkGR12Sz0V
 Jnzg==
X-Gm-Message-State: AOJu0Yxa5Jl51QGcFIRnBYbjFUt0Bn5CrGvTyV+jh2VYiNVVeJEh+s77
 lAbPkl2zFAhD2LslcK4pmmpO+zUpTxgj7A==
X-Google-Smtp-Source: AGHT+IGyk0Bf0GZNzEHkkIzz/n+PopbZtR/NpjETW49WxX7GizZIA6RrH5VvCSbuuLXQ32Q1JQ40LQ==
X-Received: by 2002:a05:6a20:12c6:b0:131:a21:9f96 with SMTP id
 v6-20020a056a2012c600b001310a219f96mr28913474pzg.6.1697083927592; 
 Wed, 11 Oct 2023 21:12:07 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:12:06 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 18/54] target/riscv: use isa_ext_update_enabled() in
 init_max_cpu_extensions()
Date: Thu, 12 Oct 2023 14:10:15 +1000
Message-ID: <20231012041051.2572507-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
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

Before adding support to detect if an extension was user set we need to
handle how we're enabling extensions in riscv_init_max_cpu_extensions().
object_property_set_bool() calls the set() callback for the property,
and we're going to use this callback to set the 'multi_ext_user_opts'
hash.

This means that, as is today, all extensions we're setting for the 'max'
CPU will be seen as user set in the future. Let's change set_bool() to
isa_ext_update_enabled() that will just enable/disable the flag on a
certain offset.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20230912132423.268494-19-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fba5ce7118..821006f42a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2166,24 +2166,24 @@ static void riscv_init_max_cpu_extensions(Object *obj)
     set_misa(env, env->misa_mxl, env->misa_ext | RVG | RVJ | RVV);
 
     for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
-        object_property_set_bool(obj, prop->name, true, NULL);
+        isa_ext_update_enabled(cpu, prop->offset, true);
     }
 
     /* set vector version */
     env->vext_ver = VEXT_VERSION_1_00_0;
 
     /* Zfinx is not compatible with F. Disable it */
-    object_property_set_bool(obj, "zfinx", false, NULL);
-    object_property_set_bool(obj, "zdinx", false, NULL);
-    object_property_set_bool(obj, "zhinx", false, NULL);
-    object_property_set_bool(obj, "zhinxmin", false, NULL);
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zfinx), false);
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zdinx), false);
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zhinx), false);
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zhinxmin), false);
 
-    object_property_set_bool(obj, "zce", false, NULL);
-    object_property_set_bool(obj, "zcmp", false, NULL);
-    object_property_set_bool(obj, "zcmt", false, NULL);
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zce), false);
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcmp), false);
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcmt), false);
 
     if (env->misa_mxl != MXL_RV32) {
-        object_property_set_bool(obj, "zcf", false, NULL);
+        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
     }
 }
 
-- 
2.41.0


