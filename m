Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0CD83291F
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:44:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQnBW-0005Lr-Jz; Fri, 19 Jan 2024 06:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnBJ-0004ys-Ey
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:37:05 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnBG-0002vd-W8
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:37:05 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e8801221cso5971255e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705664221; x=1706269021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZOOriEuiBAbNMMhhXm8QlidphHeh3aLspyqOz5Ajks=;
 b=wR+AkuG9qq/deD5sVWV25v+ofxzaTlM1ZAJ+OMqxn5eMF6GuvJpP7q38RDz0C8Gsdx
 MHVLFc/OQIs3aOwEXvwXgcZ3g3ewi4R0zF07OJfNsKjpMTel5XlcIpFu0Ew9/m0D/SpA
 YQisW3LdZWDByoQhPmgCsTS+3bsyG94O4pqyFcMrCKioMVoSXmVLpD0SPdPuhR5BT/wb
 oihLyzwOmBUkMae7AlglRuu9Jx9mhfRxy8COgvXhKGsDQbFwz2FK0gDpUkjyAPWfKCA0
 z3AKT9Kw0MU9fh4t2pnZuTRT9RdXJZEp2SWhUhtTomPD7znEklSiHlNeFjNSuop+lCJn
 +CXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705664221; x=1706269021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CZOOriEuiBAbNMMhhXm8QlidphHeh3aLspyqOz5Ajks=;
 b=I0pQX1huCvloJHCMvlZfUmxlbXG464uklojcUNwjbzHgUDgSxl26ANQsHpegEj3bSr
 2opc42yw+nH0V7ll9zZQTQ2WtDYxZD2LkqVuivM5jvqb2o48ESrVE8zYrIwbAIWJbS4B
 VH2S0IA0Pxfglt8Q5PjXtTwtwp1KU/bn8UyXQYlP1jdSJBk/0O8uQz3vwu9OcVxLaQCA
 jzP/W2wcUtB9cNSV82P6P7vmgFJPDSw1QPSXtlJ/2jTwINFHDpguaHJ84GxYhNLv1Zv4
 MYJ23OfLfLMvluhWwVnUQuh3YeJswhYg36aR2bIP7vWIrAw/XUZTZtmNh/BzMddeBoyk
 hSmw==
X-Gm-Message-State: AOJu0YysIVU9bcpunWEAsUzwRah02TwYhEw6M+dQJecHbTbw1R4lykqD
 u+OhvBIPxd+fnxa68/b4h9xcvlEIO8A+s28bKXt6tLwAHgdDL3l1aBR13fxMcvQ0Bz/FEVTf5xp
 GBq+ilQ==
X-Google-Smtp-Source: AGHT+IFPF3UNRq7EgXJo91GmEHKkWUp6AJYbQAyWvtkr+hkKZEOlatPzTGjBB9Ou6/BuIrFcX6H3BQ==
X-Received: by 2002:a05:600c:654a:b0:40e:427d:4b02 with SMTP id
 dn10-20020a05600c654a00b0040e427d4b02mr1636546wmb.67.1705664221241; 
 Fri, 19 Jan 2024 03:37:01 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 jg1-20020a05600ca00100b0040d4e1393dcsm32251084wmb.20.2024.01.19.03.37.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 03:37:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 25/36] hw/core/cpu: Rename cpu_class_init() to include 'common'
Date: Fri, 19 Jan 2024 12:34:54 +0100
Message-ID: <20240119113507.31951-26-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119113507.31951-1-philmd@linaro.org>
References: <20240119113507.31951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

cpu_class_init() is common, so rename it as cpu_common_class_init()
to ease navigating the code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240111120221.35072-3-philmd@linaro.org>
---
 hw/core/cpu-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 3ccfe882e2..67db07741d 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -273,7 +273,7 @@ static int64_t cpu_common_get_arch_id(CPUState *cpu)
     return cpu->cpu_index;
 }
 
-static void cpu_class_init(ObjectClass *klass, void *data)
+static void cpu_common_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
@@ -304,7 +304,7 @@ static const TypeInfo cpu_type_info = {
     .instance_finalize = cpu_common_finalize,
     .abstract = true,
     .class_size = sizeof(CPUClass),
-    .class_init = cpu_class_init,
+    .class_init = cpu_common_class_init,
 };
 
 static void cpu_register_types(void)
-- 
2.41.0


