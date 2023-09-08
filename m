Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8815979820B
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:11:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUfH-000351-QW; Fri, 08 Sep 2023 02:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUfB-0002lw-Of
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:08:19 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUf8-0008Bi-Vy
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:08:17 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68e2ffd51f2so1457338b3a.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153293; x=1694758093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+dNGiidBvez8oj7Oxa12VP8Kmof+HgNG4C5YkfEeGZ8=;
 b=ARPHV15S8cU2OFjDXhWrUVBw8zBWCMSYjDitPsKnX+9DlFodl6bE/H/LHtNNt/RfpQ
 9o9CSc+RfmxJZAodYcIz/CboOwIfQLUNvh/pXitms81M6l4DJ5sAx4Vkf7CsVnZktYSs
 6Y004NYNlpE2t0rrU3cCCjBxXmWPW1dw0VoWbZxP/XP/DUjkHsV6o8+Z1Kh9vgqLiTSR
 aVtPVZe1YFsIabNeeflG/EEp95xfmV3z8Gg0FPyN+vhA22+jqnqJVFLs/r0XJEunryvN
 nfwXL8fXqK6Vcj7MrzvAdy34rjr7mwOIZuZBJ/IOsNZ3WU/yfvdaNzOuCdKZ/fXLOdh3
 qoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153293; x=1694758093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+dNGiidBvez8oj7Oxa12VP8Kmof+HgNG4C5YkfEeGZ8=;
 b=V232bGo50sUozzOdhzbS/iPf8sM83BWfpmpun2YfO9gMBS/9mxWKQ7Dw3Gkl2U5K7K
 VoPHonBZvqcj4/228/5imlsdI6rmyDqLyLsHo7Tg05DSmfu0P+gsv8La+3bVsBjuVKr0
 VqOcmqfhW6JGARUYBI52mFiF7RFN/0RqFxTpCMCg7o/vpCWWy0BU1MNW8qPIbr1KnVn7
 +jo9IHRU7NC7Rso4/IwnFi3C3MWkaLUrp/8kdIITD/i6f53wbHQZPWVDTeN78zrznTRN
 jFPTrg8gOHLh8/dH7CgPxdWT1j8zydsO4L+97/UTJyE/hkhOrtpKacaszbslTLlq5Tn+
 3nLg==
X-Gm-Message-State: AOJu0YxDcpqRzp+BYtlYsrljpjDltD1aSFRBevmbBwuipG+5booJzsg7
 0gtqCr0085gVLErc0/EBcwNE1MsEomqDsD7q
X-Google-Smtp-Source: AGHT+IEWXV5X/SaawBcSFPLb5ZA4dHM3uVCQvG9Y+3SAomlAG1HOUIWzNFGzJRcPo3F39zAiD66bKQ==
X-Received: by 2002:a05:6a20:840d:b0:14e:3daf:bef9 with SMTP id
 c13-20020a056a20840d00b0014e3dafbef9mr2305240pzd.16.1694153292936; 
 Thu, 07 Sep 2023 23:08:12 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:08:12 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 52/65] target/riscv/cpu.c: add riscv_cpu_add_qdev_prop_array()
Date: Fri,  8 Sep 2023 16:04:18 +1000
Message-ID: <20230908060431.1903919-53-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
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
Message-ID: <20230901194627.1214811-8-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 86d536f242..d484d63bcd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1951,6 +1951,15 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
 }
 #endif
 
+static void riscv_cpu_add_qdev_prop_array(DeviceState *dev, Property *array)
+{
+    g_assert(array);
+
+    for (Property *prop = array; prop && prop->name; prop++) {
+        qdev_property_add_static(dev, prop);
+    }
+}
+
 #ifndef CONFIG_USER_ONLY
 static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
 {
@@ -2007,7 +2016,6 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
  */
 static void riscv_cpu_add_user_properties(Object *obj)
 {
-    Property *prop;
     DeviceState *dev = DEVICE(obj);
 
 #ifndef CONFIG_USER_ONLY
@@ -2021,21 +2029,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
 
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


