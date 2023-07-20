Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 399C675B582
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 19:21:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMXKT-00005G-F7; Thu, 20 Jul 2023 13:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMXJs-0007kk-Hf
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:20:07 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMXJr-0004b5-3y
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:20:04 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-564e4656fecso684390eaf.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689873600; x=1690478400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zX5PXCGV4zGEdiqslCP4Ydail5D6wQ6xUkfarIksAVk=;
 b=bnK9VLIozA0QlHtEFBZ4e3TsqLOapzl2JzeC3wyAgw+moPq7tpfDbVOSqNiXfjUX0w
 GmfyTCHKuKtslBdRqrmXiq3D41COdcU9atgklsE3lDnH6h1eCaf3NnPawza/i7i132/p
 tyYidKJLdqdLJuyXIJ5Vx7PGULMVNrCUsYMAiZn6znWMknTH6BuptwnqL5DxLil+Hx3i
 tQydjy8S9OqHBiMTitd9df06vpIemumxXqhHWFlYTflUVA1GvkBnF1lqaCabHOAZTI+f
 lDNjp4ylkv2+WU6CvZFpUMl9wT7VjFffmNGE1+tJg/+EWLf6PV/Bl2nT+BeoJMTAISNB
 mTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689873600; x=1690478400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zX5PXCGV4zGEdiqslCP4Ydail5D6wQ6xUkfarIksAVk=;
 b=OcU4nLUHMOBiCaZY2Bgjx6z5HeU4np0S1SMOO5rPDaRyOP94WKB/dOx2zi8LOrAqv9
 g7tSiGpmMG62fiOnrBmbq7599vukaMLxtQvLQBVHGighnRx2RlDBY5//szbnSjpsRDdM
 SXSc0Dyg1OYwaDpoSv6l2SyBp8vNkDqBbJ5docVwrP/tcfxRvS3ZRs7BhAHTVlcPn4Rg
 7d7PSWHypm/ANwgUj9Jr5e89BoP/qhpyeYQ5356ALyrLt+a62pOdl3IRIjxUiyhcr9wq
 h33aUrnh5/kCPnhg1V7DinUCI3yf7pOnEkQrT/S8KEuy3zN/JWejjSvVPxPuHpHc/dYH
 uXZA==
X-Gm-Message-State: ABy/qLZgKg5OhREOvjkq2HSQoue9dD8qnwtgytkvS2o3ohOdvTLwfgW5
 nqSBVEgdSjSPzGItffTMaPIT0iiJiCT9u8wI1oxpig==
X-Google-Smtp-Source: APBJJlEURJG6Uv/Zb8vX2YlN3rzS+JQ/zYCwGczJ9CByoMBhJvI9+59itrApPnHF09ilhY3GUBEV6g==
X-Received: by 2002:a4a:5201:0:b0:566:f2b9:eb86 with SMTP id
 d1-20020a4a5201000000b00566f2b9eb86mr2820418oob.4.1689873600404; 
 Thu, 20 Jul 2023 10:20:00 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a4aab02000000b0055975f57993sm582564oon.42.2023.07.20.10.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 10:20:00 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v5 07/11] target/riscv/cpu.c: add
 ADD_CPU_QDEV_PROPERTIES_ARRAY() macro
Date: Thu, 20 Jul 2023 14:19:29 -0300
Message-ID: <20230720171933.404398-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720171933.404398-1-dbarboza@ventanamicro.com>
References: <20230720171933.404398-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc30.google.com
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
index 7c6060ffa3..23169a606f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1875,6 +1875,13 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
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
@@ -1944,21 +1951,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
 
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


