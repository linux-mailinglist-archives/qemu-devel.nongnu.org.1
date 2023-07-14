Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B93947540CD
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 19:45:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKMpO-0004aS-Pe; Fri, 14 Jul 2023 13:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qKMpK-0004Wt-TN
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:43:34 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qKMpJ-0003sU-FY
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:43:34 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6b8b8de2c6bso1740307a34.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 10:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689356612; x=1691948612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dPVVJfGCYr54DMQh33GpPrRrymsNLjq2oQBg9L1UZeI=;
 b=ikT97e6A//Lf0QfhEcKqGTeaL1SLFm5SNdjM5oUtsPRbs42+y2Yx1Nyk2sBb6ZQs9g
 rpA9RHkPGntwEmwr++OZdNonMF92RZpOWbnxPD1xxgey6Aq8UwBnk2qqC+SekB8JwHlp
 qR4KggxEvov9JrE9h777o5RbrQnoFCkkoO3hvWzdveiBpxshFmoRQ9Dm+6gIqoBvTcsk
 0u6h8DhmeE5P3MlaczAK7JwJ5FuSi/7cFFL70lea4bSaKH386Dm8iKyq/f1iwaXoZ+TQ
 a63cLc/glQFaY03PmiIqQQtWvTzd+7gUrl7531pqmjC6WPsRkcWQTH7BWpv5wpdE2b4c
 T8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689356612; x=1691948612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dPVVJfGCYr54DMQh33GpPrRrymsNLjq2oQBg9L1UZeI=;
 b=Tc5R86SnV84soBmqd6egipWC4BLyRNtZzBTQjfv6WQKXMmGRkvU5PeNj25N69mrBXS
 R6shaKnmYQgJSli6dIySxjqFJXpBu6ru6B1bfIChG3OWJUlYZzMpucCGW+Uexy/F/wfu
 64VIKl7/tH5LzL+PgPnPJSSxJcvMtXv/76qdyMCme86dZKJNAtVoqpYA+3jeWG9k98/U
 q7N+5V7pYB7O0NsglrKS7R4kGnvcMwArSIxij7K0hfaxjUqpA+TxVpfCdgdRFQozkhxc
 3yNsMya0nMB1ttBn40odBwyg5n6aDz4iQhE3Z2O2kLqLVamMc4LNPgA7pk4dlNVCqIti
 sSWQ==
X-Gm-Message-State: ABy/qLYybGtS07215ykpHUKxarsDx8bHaNJGylIlf5tFjtnRQdFGp+8y
 UvwmXIPs+VOZRjYO7omxlw5gLiFYJIsRFjGj8E4=
X-Google-Smtp-Source: APBJJlESW07IE2QHWQMwEHT+OIcQb7jVL8YaVcaeYAJhHSbkiFiWjXpKEYBVrpaDERIPf/9P3Ux/Mg==
X-Received: by 2002:a05:6870:c38a:b0:1b4:7191:6d62 with SMTP id
 g10-20020a056870c38a00b001b471916d62mr6752692oao.35.1689356612178; 
 Fri, 14 Jul 2023 10:43:32 -0700 (PDT)
Received: from grind.. (201-69-66-19.dial-up.telesp.net.br. [201.69.66.19])
 by smtp.gmail.com with ESMTPSA id
 dw18-20020a056870771200b001b05c4b3b3dsm4240968oab.31.2023.07.14.10.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 10:43:31 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v3 5/8] target/riscv/cpu.c: add a
 ADD_CPU_PROPERTIES_ARRAY() macro
Date: Fri, 14 Jul 2023 14:43:08 -0300
Message-ID: <20230714174311.672359-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714174311.672359-1-dbarboza@ventanamicro.com>
References: <20230714174311.672359-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x336.google.com
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
---
 target/riscv/cpu.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5689368f02..f7083b2d5c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1875,6 +1875,13 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
 }
 #endif
 
+#define ADD_CPU_PROPERTIES_ARRAY(_dev, _array) \
+    do { \
+        for (int i = 0; i < ARRAY_SIZE(_array); i++) { \
+            qdev_property_add_static(_dev, &_array[i]); \
+        } \
+    } while (0)
+
 /*
  * Add CPU properties with user-facing flags.
  *
@@ -1918,17 +1925,9 @@ static void riscv_cpu_add_user_properties(Object *obj)
         qdev_property_add_static(dev, prop);
     }
 
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
+    ADD_CPU_PROPERTIES_ARRAY(dev, riscv_cpu_options);
+    ADD_CPU_PROPERTIES_ARRAY(dev, riscv_cpu_vendor_exts);
+    ADD_CPU_PROPERTIES_ARRAY(dev, riscv_cpu_experimental_exts);
 }
 
 static Property riscv_cpu_properties[] = {
-- 
2.41.0


