Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8913C7C63F7
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:20:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn3E-0000za-3S; Thu, 12 Oct 2023 00:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn2z-0000xw-87
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:45 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn2x-0002Aj-GS
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:40 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5855333fbadso393992a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083890; x=1697688690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/oAIUZ1OFrVRSR7jkUOb33tOXPyrjVApDtqtdo/a38=;
 b=B5uIoEeLK+vRhaX/Be3AKlUJ1trBLh3UDN+fsb2Tp0hY6QS/DNQ8BFJAd+TRyNaKgv
 ZTJQbImmQDeP4+E1AF7VGhYhRzp36uXigt67u7boG+eIWuD9v1I08s/vXiwhqL3uKkss
 o6BVdR+q53t6PJCnnlqrf5DdDKgGdLUReM3mfuKOPOHm2Co7kS16WPH3+Ry7m+rUA2en
 q62ujs3QbYgRcDHnktDY86wKVMJvBXijelDYo9o4zTqFapwGFr5gSSlSuU2VIfG6cIQa
 j9S01FzXs8+TbYQ/PArhNxAgDrunqo0TBU5vVWtWRin2t/mRHgMEoE6mx4BAIoJKkJNw
 V4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083890; x=1697688690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a/oAIUZ1OFrVRSR7jkUOb33tOXPyrjVApDtqtdo/a38=;
 b=q9yqWcpVV6PBZG1i3nZtF7HT2e5dIQ4kBDN7vXQ9Vfv7fHp7SRNQKCJdULpTjeTlAZ
 SXg+DVJWcPqSwZD1ag9Ew+3c550BdsZQMptcZk7PHQRypETexxaQzDqh+kCW1HfJA43K
 zBO3gL4b7/CYK+PvJ7UjEq//WS8F8Z/4RylZWJfqcPSuEfhvDx/XkRa6+M+HG5w5Zf5w
 hWelBrCEV+olCm1Yxpi7aP7hOc0GVGd3M/lQSRpI2N4m9ObM1mlvImjwEJ8JmqU67xmW
 jb7mQUp58ZG9R9rNU398RMt4WdTkCzMtvxVoTt3TF5tUNzs0PHz6iHIzY5outLZrbtRz
 AvkA==
X-Gm-Message-State: AOJu0YwY1Of7lVfOTKGweJxGpRBMk6ZR+HDhR9enP1uCfDoTSajqoFvZ
 RsBdbh7zVXktM6Hr8b7FdXKnp3087JhFIw==
X-Google-Smtp-Source: AGHT+IHXsNHnJmBmdlywflMOxtuZdZgNRaGwxEfbeaRwWGW2YV75u01dPEGo3dt+kRVMz6F7M/eBWA==
X-Received: by 2002:a05:6a21:181:b0:15e:dca8:1224 with SMTP id
 le1-20020a056a21018100b0015edca81224mr24694545pzb.55.1697083890282; 
 Wed, 11 Oct 2023 21:11:30 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:11:29 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/54] target/riscv/cpu.c: add riscv_cpu_add_qdev_prop_array()
Date: Thu, 12 Oct 2023 14:10:04 +1000
Message-ID: <20231012041051.2572507-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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

The code inside riscv_cpu_add_user_properties() became quite repetitive
after recent changes. Add a helper to hide the repetition away.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230912132423.268494-8-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6289457514..848b0d1c82 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1928,6 +1928,15 @@ static Property riscv_cpu_options[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void riscv_cpu_add_qdev_prop_array(DeviceState *dev, Property *array)
+{
+    g_assert(array);
+
+    for (Property *prop = array; prop && prop->name; prop++) {
+        qdev_property_add_static(dev, prop);
+    }
+}
+
 #ifdef CONFIG_KVM
 static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
                                     const char *name,
@@ -2001,7 +2010,6 @@ void kvm_riscv_cpu_add_kvm_properties(Object *obj)
  */
 static void riscv_cpu_add_user_properties(Object *obj)
 {
-    Property *prop;
     DeviceState *dev = DEVICE(obj);
 
 #ifndef CONFIG_USER_ONLY
@@ -2015,21 +2023,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
 
     riscv_cpu_add_misa_properties(obj);
 
-    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
-        qdev_property_add_static(dev, prop);
-    }
-
-    for (prop = riscv_cpu_options; prop && prop->name; prop++) {
-        qdev_property_add_static(dev, prop);
-    }
-
-    for (prop = riscv_cpu_vendor_exts; prop && prop->name; prop++) {
-        qdev_property_add_static(dev, prop);
-    }
-
-    for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
-        qdev_property_add_static(dev, prop);
-    }
+    riscv_cpu_add_qdev_prop_array(dev, riscv_cpu_extensions);
+    riscv_cpu_add_qdev_prop_array(dev, riscv_cpu_options);
+    riscv_cpu_add_qdev_prop_array(dev, riscv_cpu_vendor_exts);
+    riscv_cpu_add_qdev_prop_array(dev, riscv_cpu_experimental_exts);
 }
 
 static Property riscv_cpu_properties[] = {
-- 
2.41.0


