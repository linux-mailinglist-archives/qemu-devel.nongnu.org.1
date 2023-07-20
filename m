Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 192D375B587
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 19:22:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMXKP-00088W-NA; Thu, 20 Jul 2023 13:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMXJs-0007kZ-2y
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:20:07 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMXJm-0004af-Tt
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:20:03 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5634d8d1db0so736372eaf.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689873597; x=1690478397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YWQaJgY2QjOrZe7qwwU8VpQcspvhm4afumz9mYtsjkA=;
 b=NM/AE30/ViCSf5b4cdmnUoCe9C4VaYyYqfCViVSqFQhL7QcUEjkmAQfv+/TvaVuY1J
 VXC83lFPssk/G27KPig6tCP1sTlXOfES5p3lrdb7OBarxDbN8YjMx3SmMbR/PWqe6Zin
 cxp9HBc16BqL1tiq5VME5MO5cON7W5PUXMPsNUdUV0ybaojPvhlF+WevfjLznJeNQn/u
 RbTJlyCUnZLJBu14VSTzGeiKrQlSzGom7wwz63ZJk5kkL+5O8HcEHFJX87UvpE2PpbCv
 RlqFGACpI9EcZQvq4Mi5AOnpN7C7zq68yFnJ7XK7u1OGkTwO/pRzQKmQZ1onRZlPyN3B
 cDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689873597; x=1690478397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YWQaJgY2QjOrZe7qwwU8VpQcspvhm4afumz9mYtsjkA=;
 b=SXHXJKNCdIDHCPQfne+CsTUznDsZAoRxYUID1+9XKbkBlOEuPeWq0JHKBB/8rCfx72
 /r2Ua5PimGv+7B7CnjaB7tc28igL0kWjrFTlQbDdRYcaoyfas2Q/2ZiEXhI2zZoCHD13
 Uw4CGWY4wRvvYXCdHlSkmDvFJVVXbPUuTjSvBq9XTdKRlY1+xgFidolIlvFo8OlTD0KA
 aQKO1VGhIbnIJh7Wrj4QSRg9kM3aVKXkO4/VzDmMPNWSWAH1ZZmON3yTzV9P0TKOEvXZ
 QPoE4GwQEuGuMZu8jiz0wgQYXts4sVyC7OPCpuROLN7DkOEhLaQOIzcYi6mxi9slNW/u
 o3gA==
X-Gm-Message-State: ABy/qLa/JwqYO5inGWBBTp9h6xurS5iexdXpopAGqSmvpJoEyUdKv72r
 U7aqzTZX7RH47xPHgODYHWminG4lXnulXI+vXgEqLA==
X-Google-Smtp-Source: APBJJlFZ6kb9ZA/4x+4WnbHz323LD9PriVCULBsGhkMaIEbPo7yr8xbbWbvR/TrvOIbPyebr9Z29cg==
X-Received: by 2002:a4a:4fcd:0:b0:566:fcc8:5b6e with SMTP id
 c196-20020a4a4fcd000000b00566fcc85b6emr2581780oob.6.1689873597635; 
 Thu, 20 Jul 2023 10:19:57 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a4aab02000000b0055975f57993sm582564oon.42.2023.07.20.10.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 10:19:57 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v5 06/11] target/riscv/cpu.c: split non-ratified exts
 from riscv_cpu_extensions[]
Date: Thu, 20 Jul 2023 14:19:28 -0300
Message-ID: <20230720171933.404398-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720171933.404398-1-dbarboza@ventanamicro.com>
References: <20230720171933.404398-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

riscv_cpu_add_user_properties() and riscv_cpu_add_kvm_properties() are
changed to keep adding non-ratified properties to users.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3a20a41dfc..7c6060ffa3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1806,21 +1806,6 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("zcf", RISCVCPU, cfg.ext_zcf, false),
     DEFINE_PROP_BOOL("zcmp", RISCVCPU, cfg.ext_zcmp, false),
     DEFINE_PROP_BOOL("zcmt", RISCVCPU, cfg.ext_zcmt, false),
-
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
 };
 
 static Property riscv_cpu_vendor_exts[] = {
@@ -1838,6 +1823,23 @@ static Property riscv_cpu_vendor_exts[] = {
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
 
@@ -1906,6 +1908,11 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
         riscv_cpu_add_kvm_unavail_prop(obj, riscv_cpu_vendor_exts[i].name);
     }
 
+    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_experimental_exts); i++) {
+        riscv_cpu_add_kvm_unavail_prop(obj,
+                                       riscv_cpu_experimental_exts[i].name);
+    }
+
     for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
         /* Check if KVM created the property already */
         if (object_property_find(obj, riscv_cpu_options[i].name)) {
@@ -1948,6 +1955,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
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


