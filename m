Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C33A787B5D
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 00:18:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZIc8-0008Cq-Qn; Thu, 24 Aug 2023 18:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIc5-00088S-GF
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:15:37 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIc3-0006Nk-5a
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:15:37 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5731fe1d2bfso229108eaf.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 15:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692915334; x=1693520134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pC1HU180dM2eFisZjmPw27yExyf42n/GWB/GzIojS8o=;
 b=fZWtu11amxqgEK2Ileqx9raJs5kVPjQflPKYYUDxu/hfBck2HQYWufUu0oJyMYKeZ+
 VCYTcPYkqTx6UtM7U7vb8vvUrcuNhZC/sVdaH1k1LwipHCbMI5aZIlw8z1X9GdBJy/6u
 DMcrVmKHF/4cI5PyLGezS4eShHlxeKaYX2bfhy6GlOHaD4uGaV15MWhMsboHT7xzwEqz
 qx4w3mEKWXVEgTDAO1YWHjMJMeBzLBAEl+7tENcyFRta5H/iBcCZdxvOfDGxxUMwEy36
 j+u5bPa9lQAvumbFpiZci7eH1O3oO+hZ5xeLamM8kCq05wztvx5cKagbCFl29QNMEfeO
 jW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692915334; x=1693520134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pC1HU180dM2eFisZjmPw27yExyf42n/GWB/GzIojS8o=;
 b=VJaygoh2YcG8BLoUIFyrkqpUvWJGrkG99pXFx9HyH3OnNVyTqCH1nOLpyjrY6ighle
 Sl8u1PnHUYdA4cgBHcTPIVbohOJ61CdEyl4lDKkfsegZTxBlcZDCEvgKpMeJWrRR0UZl
 RDF5X1YQieQSdLOsb2apxXqH7pCAS0/X0mZCvced11dtfpEEGjUMrr7B89CFhq2UIvOK
 0SNz6o6dZzR9J70fyAKIQAh9Y57OPkXNdEy+qLZIcUrHpunnKowOQajOAHwKe4ng4fe5
 6NnDg4G3r9H1Rkaj3NfvsWvkyKCTpSRgPF2S9UACxRAgGn4+YDXlx44a4HCMUAS2akwn
 toBg==
X-Gm-Message-State: AOJu0YwjVTwskexMP5FVYLnMT/TRZ+huUiL9V/M0WbU6GxtA0AKfw7KR
 LkVvOORnX5ugIMkSzI/afna9ybOAN8Nk710fchY=
X-Google-Smtp-Source: AGHT+IGcsOo5gnfn4Jr+oGuOiMsYm3RwgOd6wO25sjMM4zsdAXrCrvCcTxcP6NRhfQmg5oyQ79029g==
X-Received: by 2002:a4a:919c:0:b0:572:b659:a236 with SMTP id
 d28-20020a4a919c000000b00572b659a236mr3252332ooh.6.1692915333781; 
 Thu, 24 Aug 2023 15:15:33 -0700 (PDT)
Received: from grind.. ([179.93.21.19]) by smtp.gmail.com with ESMTPSA id
 o129-20020a4a4487000000b00565fcfabab8sm256338ooa.21.2023.08.24.15.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 15:15:33 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH RESEND v8 18/20] target/riscv: use isa_ext_update_enabled() in
 init_max_cpu_extensions()
Date: Thu, 24 Aug 2023 19:14:38 -0300
Message-ID: <20230824221440.484675-19-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824221440.484675-1-dbarboza@ventanamicro.com>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc30.google.com
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
---
 target/riscv/cpu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index adfe671bd4..ae8c35402f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2163,24 +2163,24 @@ static void riscv_init_max_cpu_extensions(Object *obj)
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


