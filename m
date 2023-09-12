Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C51579D219
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 15:29:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg3OB-0002oK-Gb; Tue, 12 Sep 2023 09:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qg3Nx-0002fS-GM
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:25:00 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qg3Nq-0003XR-QO
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:24:54 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6c07e122a78so3898305a34.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 06:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694525088; x=1695129888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QaCaFXk3n/oGC56SB04wOyUmvqISdJZ1At/AtPnxTwI=;
 b=LzA/jlT3oxBa2wDvgLL4iAj86+2OYT5waQvD0MTuLTeDS4DfJbBeRAN+hKKporg+56
 SYtpzRH3qxqUVLx6AgxMETGWGiUjBOKzxAwdyrPD5NpZm3eGM8qGAMW3fqaBz0gxlv6m
 hRpW8C0syQmJzrLvOAU5obGFILECSDF4lndU5EZqh0MFmYwnOzu/d/y/XArauEaCPBxP
 uHZTrLG5aNw6+FzOE35BQPuR3wpcmZ5HFPUKCDGBEfRN9+d2rQ6m1gAKU92a6PQ3WGwN
 LHQSOdClZWa/v+6hMKmM2DSdPtEYyEoxT8CwjquSCz5Cp5ZKP7MoiEio8b40H1Cx9WX+
 0RBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694525088; x=1695129888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QaCaFXk3n/oGC56SB04wOyUmvqISdJZ1At/AtPnxTwI=;
 b=n/HEJITUDHPBNjjQO406TQjK84/Mg+PfIObqY2PzKRIZHWM8obUJiY92tpVBZW8FLB
 lEkRh7KqETIpz7LSKBinFS6MVj0IfQBQaOGZMCllLG3qmhIxFoZCUwDQwTJbmXpFoZc2
 Q7CW70wadAC5mrTILpCNuJoexryoztl4UNGqGuXMc1zC819m4qfD+2znnFkNSVRd2y/8
 tPWLk6gRdnJueerjXzmSfk2k82rKgBVVbZR1F3SL+mY5P2m5+JkseBxU6JugUSHIVIp1
 zRNg/7Bp2MduZhCgcVUJw/u/IFNowAO1z1oPJ2uYInjg14mCtA9GKI+vpbvFeH2hjhjI
 Rulg==
X-Gm-Message-State: AOJu0Yx/ycRukv3l8JY+nvTrEnhThtV6EQQmZqa+ZvFSIi0OO8bc6s9e
 i3IxuJkO1XgvZWiIjdnNxiAjq2EYyvkTBEtPl3g=
X-Google-Smtp-Source: AGHT+IHBGoGxIOSkUcF80+mHKflRSMIeRjUVju+eevyApYFSJHIspX5TLnAreckBL5UWEbeOYC8LWA==
X-Received: by 2002:a9d:6653:0:b0:6b9:b1a7:1f92 with SMTP id
 q19-20020a9d6653000000b006b9b1a71f92mr14010786otm.8.1694525087740; 
 Tue, 12 Sep 2023 06:24:47 -0700 (PDT)
Received: from grind.. ([177.9.182.82]) by smtp.gmail.com with ESMTPSA id
 p15-20020a0568301d4f00b006af9d8af435sm3991255oth.50.2023.09.12.06.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 06:24:47 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v10 05/20] target/riscv/cpu.c: split non-ratified exts from
 riscv_cpu_extensions[]
Date: Tue, 12 Sep 2023 10:24:08 -0300
Message-ID: <20230912132423.268494-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912132423.268494-1-dbarboza@ventanamicro.com>
References: <20230912132423.268494-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32e.google.com
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

Create a new riscv_cpu_experimental_exts[] to store the non-ratified
extensions properties. Once they are ratified we'll move them back to
riscv_cpu_extensions[].

riscv_cpu_add_user_properties() and riscv_cpu_add_kvm_properties() are
changed to keep adding non-ratified properties to users.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ad6ce2c2dc..83b44900a5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1881,8 +1881,11 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("xtheadsync", RISCVCPU, cfg.ext_xtheadsync, false),
     DEFINE_PROP_BOOL("xventanacondops", RISCVCPU, cfg.ext_XVentanaCondOps, false),
 
-    /* These are experimental so mark with 'x-' */
+    DEFINE_PROP_END_OF_LIST(),
+};
 
+/* These are experimental so mark with 'x-' */
+static Property riscv_cpu_experimental_exts[] = {
     /* ePMP 0.9.3 */
     DEFINE_PROP_BOOL("x-epmp", RISCVCPU, cfg.epmp, false),
     DEFINE_PROP_BOOL("x-smaia", RISCVCPU, cfg.ext_smaia, false),
@@ -1973,6 +1976,10 @@ void kvm_riscv_cpu_add_kvm_properties(Object *obj)
         riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
     }
 
+    for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
+        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
+    }
+
     for (prop = riscv_cpu_options; prop && prop->name; prop++) {
         /* Check if KVM created the property already */
         if (object_property_find(obj, prop->name)) {
@@ -2012,6 +2019,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
     for (prop = riscv_cpu_options; prop && prop->name; prop++) {
         qdev_property_add_static(dev, prop);
     }
+
+    for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
+        qdev_property_add_static(dev, prop);
+    }
 }
 
 static Property riscv_cpu_properties[] = {
-- 
2.41.0


