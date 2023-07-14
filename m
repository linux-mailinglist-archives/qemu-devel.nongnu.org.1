Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BE37540C5
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 19:44:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKMpK-0004WG-Od; Fri, 14 Jul 2023 13:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qKMpI-0004V0-AH
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:43:32 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qKMpG-0003mf-N9
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:43:32 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1b3f722fdafso1773156fac.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 10:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689356609; x=1691948609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5/8BkfjA+rsSfV0TARmY00mQE9i3hAzSahCuFc0hWvo=;
 b=UIzhNyr7nWsJ4g37zABSYhIbs4FkhlCRQ4M7TOW284XFJ+POvXA+ySdcMN7wyMvIya
 wVNz9rpLU/lpNbkTSidu/3z/PPirq+iYBk+nzXCYipjjdnNFXM+XNq4RA3/HPqcV3j5w
 ul4WstYJM23hJz3T0FcWJxKat+fR3bkiBDsLaEJmuJFm0bIxfCrAMRHWYaw0Z4PPs8VX
 /5WLHxJJJquO5Ojk4DmCej4TtPS1wisSeDTmLWTScpWJjoI07Fx2cG05kHaaySzOBZ4N
 DWcQzDLTaT4agrZi9F586w6Xx4b3h8iVpaGmQuWh7cvUPcKeO/YgJwZn8V22VlkoTkGa
 NJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689356609; x=1691948609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5/8BkfjA+rsSfV0TARmY00mQE9i3hAzSahCuFc0hWvo=;
 b=TBt5ItRAZotjbQVObv/DwqPXAND7sh975a/QI8FHEe9bTIIEEKDCiXzTj1itAya8Yk
 0gdumSA5K++ldc4kpM3YbaCMRqYN7cLmNJUQrB6VPl9j7Vt/XWrDcpWEqXiZDOPwi8rj
 8bOb5Gj38d+Jd8MF7OZs2i5BLxc5cSOmGd0Lg7VrjgJMY0ZbFAk/H6ONh52vsQ9ZkSjF
 uTd+VmTaCyiwCCviH0dZxc388wEljKvU6+HxQo5RHMMNJt3Dub8XkP2NU8S+MkHndTdU
 gAM93OmiBSnQ8YlJLqx8J4hYzYb1jxde1czttIwtAg82myWI/0aogDG99fY1o/1Cg0Hf
 m2Lg==
X-Gm-Message-State: ABy/qLYs3p/0lFuWSbbJAgjwOYQbLX38AQGlq0wyWq9BCRO2S92xxaBs
 Tam5fpN1TcKQYJJnNapla9Tz77Rdql++BKDLM0o=
X-Google-Smtp-Source: APBJJlEI0N9RVNRJuBIkXZMbEdD8YEq7WXhw+Z1cqXu9TR3RdcH6hxZMYZOYXka7AxB13a0DT8ZByQ==
X-Received: by 2002:a05:6871:68b:b0:1b7:71ee:c4ea with SMTP id
 l11-20020a056871068b00b001b771eec4eamr6921371oao.53.1689356609288; 
 Fri, 14 Jul 2023 10:43:29 -0700 (PDT)
Received: from grind.. (201-69-66-19.dial-up.telesp.net.br. [201.69.66.19])
 by smtp.gmail.com with ESMTPSA id
 dw18-20020a056870771200b001b05c4b3b3dsm4240968oab.31.2023.07.14.10.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 10:43:29 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v3 4/8] target/riscv/cpu.c: split non-ratified exts
 from riscv_cpu_extensions[]
Date: Fri, 14 Jul 2023 14:43:07 -0300
Message-ID: <20230714174311.672359-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714174311.672359-1-dbarboza@ventanamicro.com>
References: <20230714174311.672359-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Create a new riscv_cpu_experimental_exts[] to store the non-ratified
extensions properties. Once they are ratified we'll move them back to
riscv_cpu_extensions[].

Change riscv_cpu_add_user_properties to keep adding them to users.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d9c097f602..5689368f02 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1808,21 +1808,6 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("zcmp", RISCVCPU, cfg.ext_zcmp, false),
     DEFINE_PROP_BOOL("zcmt", RISCVCPU, cfg.ext_zcmt, false),
 
-    /* These are experimental so mark with 'x-' */
-    DEFINE_PROP_BOOL("x-zicond", RISCVCPU, cfg.ext_zicond, false),
-
-    /* ePMP 0.9.3 */
-    DEFINE_PROP_BOOL("x-epmp", RISCVCPU, cfg.epmp, false),
-    DEFINE_PROP_BOOL("x-smaia", RISCVCPU, cfg.ext_smaia, false),
-    DEFINE_PROP_BOOL("x-ssaia", RISCVCPU, cfg.ext_ssaia, false),
-
-    DEFINE_PROP_BOOL("x-zvfh", RISCVCPU, cfg.ext_zvfh, false),
-    DEFINE_PROP_BOOL("x-zvfhmin", RISCVCPU, cfg.ext_zvfhmin, false),
-
-    DEFINE_PROP_BOOL("x-zfbfmin", RISCVCPU, cfg.ext_zfbfmin, false),
-    DEFINE_PROP_BOOL("x-zvfbfmin", RISCVCPU, cfg.ext_zvfbfmin, false),
-    DEFINE_PROP_BOOL("x-zvfbfwma", RISCVCPU, cfg.ext_zvfbfwma, false),
-
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1841,6 +1826,23 @@ static Property riscv_cpu_vendor_exts[] = {
     DEFINE_PROP_BOOL("xventanacondops", RISCVCPU, cfg.ext_XVentanaCondOps, false),
 };
 
+/* These are experimental so mark with 'x-' */
+static Property riscv_cpu_experimental_exts[] = {
+    DEFINE_PROP_BOOL("x-zicond", RISCVCPU, cfg.ext_zicond, false),
+
+    /* ePMP 0.9.3 */
+    DEFINE_PROP_BOOL("x-epmp", RISCVCPU, cfg.epmp, false),
+    DEFINE_PROP_BOOL("x-smaia", RISCVCPU, cfg.ext_smaia, false),
+    DEFINE_PROP_BOOL("x-ssaia", RISCVCPU, cfg.ext_ssaia, false),
+
+    DEFINE_PROP_BOOL("x-zvfh", RISCVCPU, cfg.ext_zvfh, false),
+    DEFINE_PROP_BOOL("x-zvfhmin", RISCVCPU, cfg.ext_zvfhmin, false),
+
+    DEFINE_PROP_BOOL("x-zfbfmin", RISCVCPU, cfg.ext_zfbfmin, false),
+    DEFINE_PROP_BOOL("x-zvfbfmin", RISCVCPU, cfg.ext_zvfbfmin, false),
+    DEFINE_PROP_BOOL("x-zvfbfwma", RISCVCPU, cfg.ext_zvfbfwma, false),
+};
+
 static Property riscv_cpu_options[] = {
     DEFINE_PROP_UINT8("pmu-num", RISCVCPU, cfg.pmu_num, 16),
 
@@ -1923,6 +1925,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
     for (int i = 0; i < ARRAY_SIZE(riscv_cpu_vendor_exts); i++) {
         qdev_property_add_static(dev, &riscv_cpu_vendor_exts[i]);
     }
+
+    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_experimental_exts); i++) {
+        qdev_property_add_static(dev, &riscv_cpu_experimental_exts[i]);
+    }
 }
 
 static Property riscv_cpu_properties[] = {
-- 
2.41.0


