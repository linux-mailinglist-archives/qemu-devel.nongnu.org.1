Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF3A765FCD
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 00:36:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP9BD-0001MR-Ms; Thu, 27 Jul 2023 18:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP9BB-0001LZ-Ff
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 18:09:53 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP9B9-0004uZ-RJ
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 18:09:53 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1bbb9fcac6bso905609fac.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 15:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690495790; x=1691100590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oF5CeMRc1qhvGJ6s6NeTiIJwq3Ap4HqQ5wxvWLCfVCo=;
 b=lrgT0uwHdRvKybCBv3GmxnJoi3hIHXhFJ7Cr9Wap6VuYU2/PocH74CJjQCxm159WKJ
 Ly5d7YSKRCaZCd+oHpTz72L/8qMn28PXJ+R+/wWANiy1qOwDJjrSbSaqTn+g6MqM5sEW
 nSJBX0yCRusNtIhynBSoHJEWR7Zdyxu/cqZ3yDr6qsaTldaVC2si/ZNX66Iz4cm45G1W
 yUDv371lz5Zznz4Bxz5RxJFce/LlFfLWdlvBu2Y7h3a/OLl6s09YEzyNWwkEnIaWHmvq
 zLg5FtFM5IbCzYDX6w0ycZSE6TzxZXNS8/DpIvwl37VVTgi6kZwzIDQo8j6Mnh04TehX
 sgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690495790; x=1691100590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oF5CeMRc1qhvGJ6s6NeTiIJwq3Ap4HqQ5wxvWLCfVCo=;
 b=lxCV1fjRId++qkTukPP3eSdeV0W/RqW229mshoLHsL2SER9+dggCvOvpCWxWrTgkPP
 1cjpk64fHYw4d3eU/CCuSxDPzTiN+/JnQ/Ci51kR/nwsYgbge2Es5v7YrJ/JDKqDi2tu
 dyCDBdxc7kxVFfos2+RLCbhAYca634923hpwJCwRO9naDgpL9M0owy5Qtb8Q68phLpPu
 H1g0zpY7G5HQODCb0hIBWa44WziiN/25M6Q3RA4vXUrqUtmAQHIS8/yjgnfcoq5TipBs
 LOgY1ZEm2e95cvAVh+UEh2W4iqDLXcvaS9LPF7vBzGLs5JyHlH3PhUb7PYfbm5NJWPrB
 6SWw==
X-Gm-Message-State: ABy/qLZkYGHEwDhoMrIw6feVoRvDfv8oNit0TQNcXNrTWHWBPK4YNJCw
 nOklmPAacn2nlvtB2njiFHFS1SJYGqcdxsXcnjzf9w==
X-Google-Smtp-Source: APBJJlHjNi6YL/4AEgs7jPr3V2XZ5+wh7kRVoC0845o2ygbQUarL87dDYCJBhKVKJl+C9f681Y+r8g==
X-Received: by 2002:a05:6871:b0d:b0:1ba:dabb:d5da with SMTP id
 fq13-20020a0568710b0d00b001badabbd5damr3188735oab.15.1690495790603; 
 Thu, 27 Jul 2023 15:09:50 -0700 (PDT)
Received: from grind.. (201-69-66-36.dial-up.telesp.net.br. [201.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 y136-20020a4a458e000000b0051134f333d3sm1070471ooa.16.2023.07.27.15.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 15:09:50 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 07/12] target/riscv/cpu.c: add
 ADD_CPU_QDEV_PROPERTIES_ARRAY() macro
Date: Thu, 27 Jul 2023 19:09:22 -0300
Message-ID: <20230727220927.62950-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727220927.62950-1-dbarboza@ventanamicro.com>
References: <20230727220927.62950-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x30.google.com
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

The code inside riscv_cpu_add_user_properties() became quite repetitive
after recent changes. Add a macro to hide the repetition away.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
---
 target/riscv/cpu.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d829517f40..971dcb2aec 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1882,6 +1882,13 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
 }
 #endif
 
+#define ADD_CPU_QDEV_PROPERTIES_ARRAY(_dev, _array) \
+    do { \
+        for (int i = 0; i < ARRAY_SIZE(_array); i++) { \
+            qdev_property_add_static(_dev, &_array[i]); \
+        } \
+    } while (0)
+
 #ifndef CONFIG_USER_ONLY
 static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
 {
@@ -1951,21 +1958,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
 
     riscv_cpu_add_misa_properties(obj);
 
-    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_extensions); i++) {
-        qdev_property_add_static(dev, &riscv_cpu_extensions[i]);
-    }
-
-    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
-        qdev_property_add_static(dev, &riscv_cpu_options[i]);
-    }
-
-    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_vendor_exts); i++) {
-        qdev_property_add_static(dev, &riscv_cpu_vendor_exts[i]);
-    }
-
-    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_experimental_exts); i++) {
-        qdev_property_add_static(dev, &riscv_cpu_experimental_exts[i]);
-    }
+    ADD_CPU_QDEV_PROPERTIES_ARRAY(dev, riscv_cpu_extensions);
+    ADD_CPU_QDEV_PROPERTIES_ARRAY(dev, riscv_cpu_options);
+    ADD_CPU_QDEV_PROPERTIES_ARRAY(dev, riscv_cpu_vendor_exts);
+    ADD_CPU_QDEV_PROPERTIES_ARRAY(dev, riscv_cpu_experimental_exts);
 }
 
 static Property riscv_cpu_properties[] = {
-- 
2.41.0


