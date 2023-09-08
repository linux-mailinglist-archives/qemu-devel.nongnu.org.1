Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83055798210
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:12:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUfq-0006j5-NQ; Fri, 08 Sep 2023 02:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUfo-0006Wt-Ep
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:08:56 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUfm-0008GP-3H
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:08:56 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bee82fad0fso14679565ad.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153332; x=1694758132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bzaVsEALV8Dw/FV9PqHI7cUMw8HNiCbwtOvDkljywu0=;
 b=h8GKG6rF2tDSzxydMKJHP/hsirYSnpdUoArcC6azst1MdamBOq/N1Zaw4CYs76rLWV
 zqC1KS54O5i+qapNWmBvCRI0CgTn7Laa5mD4iDzvgKzWqMFL2eABWVTxX6AKkYDbZUd5
 3Xam5v1nvbMPA4lxyyA62tO+0rlOAPn8iKFeqM0fQ87vccPZ2BW7cHZfOTa5aLsGEdo+
 IgC6DDw2MW4wBXZwv8LkoXg0mW8LIDSd/CiWXx4/cPybdcKCjFf86rNl+bFXlagAJSQv
 juUcZWLV+SQHNHpUwQC60W4AyUwZhbsYSOW5r0NqPYtfJ18yHz/3fcvlKI1hsQExgn1r
 JOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153332; x=1694758132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bzaVsEALV8Dw/FV9PqHI7cUMw8HNiCbwtOvDkljywu0=;
 b=v5UDhlJsCi0lpkBlYkX4KngcRgfwKlz0SkbsDtX9B2744UGm9Kl3Pgzi7yHXWPe2zh
 9oT9OPWExkWE7tysv3WUdCkU/vsXqBgIPbAlnOmUKpjklb8/FWT/R1O34Ha7b1N0XoFN
 294RmQuofhFtHKma0vlH3/5MaokhtnnsoUyLCQpQYORXRjqjOoYi0+mCjSf+aKmXOuVs
 opD7ZTbAGjgB5CnGK4WNcU0S0jeuWBE2PH1JPciXI4ynG/GPIsi0KxdwxElSBLvyiycE
 dRhKSKsuQnkaoPCYKtGiUy6cXVBaoILMD/0hvg+6z819uupUHXwMM/Qv4tho/333JaiP
 MAPg==
X-Gm-Message-State: AOJu0Yxd1NjxkMRtaw3CnANLRtsINwwtWj6DvAxpaHul0/t4Jn3EGUR5
 j5Ex3SvkIaVC5EtioIlEHkRmwiQ9MoBWhDB2
X-Google-Smtp-Source: AGHT+IG3d5HxUSzY6kmdw7AV5cuZ2nuxQMhCrqJ1q5QM0ibom8HS2WECIUjjaMcn+SvMRToOS4DlSg==
X-Received: by 2002:a17:902:8202:b0:1bf:6ad7:2286 with SMTP id
 x2-20020a170902820200b001bf6ad72286mr1506035pln.43.1694153332456; 
 Thu, 07 Sep 2023 23:08:52 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:08:51 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 63/65] target/riscv: use isa_ext_update_enabled() in
 init_max_cpu_extensions()
Date: Fri,  8 Sep 2023 16:04:29 +1000
Message-ID: <20230908060431.1903919-64-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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
Message-ID: <20230901194627.1214811-19-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1ca034e6da..617b861258 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2172,24 +2172,24 @@ static void riscv_init_max_cpu_extensions(Object *obj)
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


