Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEDB79D21A
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 15:29:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg3On-0003I4-Ea; Tue, 12 Sep 2023 09:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qg3Od-00038F-HI
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:25:43 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qg3OZ-0003vB-Ci
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:25:38 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-57361de8878so3432154eaf.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 06:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694525133; x=1695129933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6fh7NT1S1YPs5nnVNPwU08i/h6gPC0ST6+6uExkwNm8=;
 b=Sj51NIpQhhDhOEUPeE6UJFxFUI2ECrfry1n5P6G08Eh7QXLvSPutmXumBAo8ljTfIu
 OOzXwyDBuUSW0Q4T9CaJ/maJ8Aweoay6oWauOhlkYjz2OSuV1iv6RZKkp9M33LHUXCQQ
 anBs5ml0rOX9a/zEJWsFWEqX6bjKogTA6yvKGznKrCdGt37rzlNWPj+7WPBcNb3k8qyc
 4ou8D2Nl9jyk3nFlEO61AvnVeGRae6cqzsGeio0o2u/EiskdBcySf08sATpHjkapVsRD
 yrMOcTP5TjoBk6Hzxc3JQ26EGZw/UHyZO+yAdURvfdZEAqCZrG1HjAcuRfIbrX6GS9XA
 23mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694525133; x=1695129933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6fh7NT1S1YPs5nnVNPwU08i/h6gPC0ST6+6uExkwNm8=;
 b=F5SJxzZU7xO46G86WIpw7z/J80gdPKf07ZBBREQcEtE+u4GM8gJ/wM4DRVNQjn1S/n
 jA7LfT//JNaAmdiu6h2iZiGaX+F+f0sRN4wzMLHFLL+T1/uHTEmq9eKuytxuc5Vw/agj
 bHYyweUqwZhXWCeYZ1yJGLsa8gtBGS2v/l/ipnOnEhVnGFk6kVsyVKz8Jg6QW5b+IAxk
 Ne8xsvArLlOmCvYMPZp/3kHhAbBkNOfHJE10GV+HgMImQsodSMHjIqqHL0R1Fq+lz2sr
 QVFUCPMGQRhWyGtcGgrlNcZA5E9FYcL+2nJnYinPswEW896y+Mv7d/V3IQ2/GFgB3vjR
 +QLA==
X-Gm-Message-State: AOJu0YzOkDHgmJwknQkUpxdRrUf19v0ZgJI3rcBukRsaG6B2U4CnVg0H
 fJjQQovZgY1MRrbPCrOa0a3/JEiSkaNpkCZA6Eg=
X-Google-Smtp-Source: AGHT+IGglHNko0Dsh9ZmDx8hoD7zHnnZUqJZJ3mDRG40vM8+fX5TskQNSQKYaP+y1LSqXpL4hmlhsQ==
X-Received: by 2002:a4a:919c:0:b0:571:1a1d:f230 with SMTP id
 d28-20020a4a919c000000b005711a1df230mr11206630ooh.9.1694525133636; 
 Tue, 12 Sep 2023 06:25:33 -0700 (PDT)
Received: from grind.. ([177.9.182.82]) by smtp.gmail.com with ESMTPSA id
 p15-20020a0568301d4f00b006af9d8af435sm3991255oth.50.2023.09.12.06.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 06:25:33 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v10 18/20] target/riscv: use isa_ext_update_enabled() in
 init_max_cpu_extensions()
Date: Tue, 12 Sep 2023 10:24:21 -0300
Message-ID: <20230912132423.268494-19-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912132423.268494-1-dbarboza@ventanamicro.com>
References: <20230912132423.268494-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc36.google.com
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
---
 target/riscv/cpu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e79fe13b26..b041d3c5db 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2170,24 +2170,24 @@ static void riscv_init_max_cpu_extensions(Object *obj)
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


