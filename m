Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8FF758678
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 23:05:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLrrp-0002bF-AZ; Tue, 18 Jul 2023 17:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLrrT-0002ZO-OS
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 17:04:00 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLrrQ-0007Ma-Pr
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 17:03:59 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6b9c5362a51so2849467a34.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 14:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689714234; x=1692306234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dbp273ZOkJpgm5K6UtoM6GI/5lqcdE/fJAfuEL8uSSA=;
 b=Q8/b9FyMpWGWkccxgI2G9rnQ6hcXaHdhfcy85ZBKAt4qsTnONSsCQipvA412Crn/fL
 hNTblnccnAUZn0zqLIsjt+7SXgUE7lDGTNVdS/ZwmUI0Q8/B7hvihgOLWDpRROpeAobG
 4koiWeUnAWQUrDjayxLXhMFBr671uz7rCPE+RUyLw+kTFGTuGEGzr58VpdudpR12iwxD
 4BMLcYrhWMWOOHWGPvVixJqeN2pHBeQ2dOpVv3GhV9mW6yx3Kn2JnW5myrL86FWyYsb3
 RJAPPpj9QMUBGggVUtEoEHXuE80VoY9StJb7E50oivkAnL22joU6/bxX8bx07xLS+8dB
 UGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689714234; x=1692306234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dbp273ZOkJpgm5K6UtoM6GI/5lqcdE/fJAfuEL8uSSA=;
 b=XJ5skNxFYYBvbnpKFYquXtFwAtvJ7bR7vr4annp7J3fdLiEvaDzxQVdO373AiypKJy
 a7Tudm3XBLU8MGcuBETByCKrOjc+3s95HHjlPrBu50E49yaxq8L0epMKP2XCobDr9sMv
 Nkp0ZRFneNDP2Qey4uovZc7JxP5a3iI6plPqbxQrc/fIJFWAgCf6sFUhmioxEIIlDZBT
 d+8Cco1pemDvYvXOZ7lymTZERXvAFnNczVYEkaDkZ+Eo8sHQa0a1g44xhJ9YW1FoAf6P
 +BlodXvj6CCrs0i9vOwakHa5eCdeNS69CQWUXsAzxPrvSW/Mq1o4hOPxZ26qAz6ubU1F
 1vXw==
X-Gm-Message-State: ABy/qLbqDgOOjsI4W7kinKIEAkCwGOA8hhRydkKXIAcaOC7ZTxiQEwxX
 2tGhen7UnbQI7vFaNcANxjkvknQSBcLslzlMGdYwrg==
X-Google-Smtp-Source: APBJJlH6xmfzrcoWLGfUebeCiskxBailiEbg7XR2dcvOGyJCLUxEp3fzaHiJFm4gfKYdl8y8X2/DSg==
X-Received: by 2002:a05:6830:11d9:b0:6b9:e35e:8dd with SMTP id
 v25-20020a05683011d900b006b9e35e08ddmr730779otq.2.1689714234666; 
 Tue, 18 Jul 2023 14:03:54 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a056830140200b006b96384ba1csm1160657otp.77.2023.07.18.14.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 14:03:54 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v4 07/11] target/riscv/cpu.c: add
 ADD_CPU_QDEV_PROPERTIES_ARRAY() macro
Date: Tue, 18 Jul 2023 18:03:25 -0300
Message-ID: <20230718210329.200404-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718210329.200404-1-dbarboza@ventanamicro.com>
References: <20230718210329.200404-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x335.google.com
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
index 4d78276058..58cbe410e2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1873,6 +1873,13 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
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
@@ -1942,21 +1949,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
 
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


