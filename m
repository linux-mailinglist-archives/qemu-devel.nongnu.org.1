Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43842758680
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 23:06:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLrrr-0002lf-ET; Tue, 18 Jul 2023 17:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLrrP-0002Yd-Pm
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 17:03:57 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLrrO-0007M0-7m
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 17:03:55 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6b9cf7e6ab2so2512513a34.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 14:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689714232; x=1692306232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPExC6Abz5gVCetcii+VgQLiEUD045B3lNlM0ih6Ij4=;
 b=WQ/zx9430NwXaIJyINmdSY7BPElTVTd8FZ9fIB+oLJarT67M8OfYp8bnGAwjr0WDRP
 foLTopJ7ZWI3i2EGvOgvQVKhwPwdQMkcwF3kPu/zJA/FYZVZlrS8uih6Y1E6MQJSrdV6
 Gyi0l7RtAUOW29DWWwb3Cvt6ncN2r6EndJ6a5eWmLLJwvyr9eBtcdzz9ICE45iQEBwtD
 lwrNt9s1Tza6fh14h1CiB8cG3ktbwhLoUlDu5j0AuwQOmtxZPmzTI3pZK9U1w3YNKqWW
 XSp4S34f8JD/FEACstOtYIt+3r74PZf//R+A8hTxXhIfqYNSyhlzqgJSLUgSvBFh1VXN
 i27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689714232; x=1692306232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPExC6Abz5gVCetcii+VgQLiEUD045B3lNlM0ih6Ij4=;
 b=Pmn0UMSNAZgNVowP1ETEpBT/iHY/DENk70wPgKSCgu5BwgkP9CPsFC3vKqQoUsmwJg
 ERf5PfahlzDX2pQ+aFf1qXSFIzUo44sQstvOSMNGro7yncqiSgniOxCLbLXDD/uy+Blg
 JWQ1mNdF8wvb5c4fHwmcYHrSgL1+HS1xpKk83bWehmu7FsSpzbwvWcTCeK1HkjRTRjFH
 nF908woC9Y4KEX6971TUztp1yphedBm88Nbup2It92pEo277t6td4xY7GEuXRrGr6kB0
 FgqZNszH/n6pQfQ7hHGmbsebNjzObgPdfs1aAVBE9Qj0s87qZG6UGJaglEmxZ+yzIP75
 hkTw==
X-Gm-Message-State: ABy/qLYqAPRQSfD9VzFkarSqMNKn907306D9v21qpI6+Zg4a1YXe4W9E
 GXEJSbj9cM+r5OMSdT+SYNUu/GY+pSztB0CW16lXBg==
X-Google-Smtp-Source: APBJJlG9ncYyRnz8qGMOHb3hIsjXs6s7b5isKk/fOa4Y6/OgRIwCustDj6XNR4j3eFIgsVG0pzknTQ==
X-Received: by 2002:a05:6830:1208:b0:6b2:dc79:5870 with SMTP id
 r8-20020a056830120800b006b2dc795870mr3692466otp.36.1689714231942; 
 Tue, 18 Jul 2023 14:03:51 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a056830140200b006b96384ba1csm1160657otp.77.2023.07.18.14.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 14:03:51 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v4 06/11] target/riscv/cpu.c: split non-ratified exts
 from riscv_cpu_extensions[]
Date: Tue, 18 Jul 2023 18:03:24 -0300
Message-ID: <20230718210329.200404-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718210329.200404-1-dbarboza@ventanamicro.com>
References: <20230718210329.200404-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index b59b06cddd..4d78276058 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1807,21 +1807,6 @@ static Property riscv_cpu_extensions[] = {
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
@@ -1839,6 +1824,23 @@ static Property riscv_cpu_vendor_exts[] = {
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
 
@@ -1904,6 +1906,11 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
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
@@ -1946,6 +1953,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
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


