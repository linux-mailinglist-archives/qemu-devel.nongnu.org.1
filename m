Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE7382B2AB
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 17:18:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNxlG-0001Bo-RX; Thu, 11 Jan 2024 11:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNxlD-0001A7-Js
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 11:18:27 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNxlA-0006GD-FC
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 11:18:27 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e60e1373bso7320825e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 08:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704989901; x=1705594701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iBaC+OwHzKvcn1f2u1m/q9TkGb6ArrXjBtpZSrOCvGc=;
 b=UaabjqALGnCxiydqokHvGc46tLVJweFRv7q1JZGx+mWrsymOMhYUrQkbR5Ocw1ermr
 fYEeKvrQTOkG/9YjAkUv5m2QnlhBZIlPJL0iuDcZk3YH99OgP5OXacOyjo/QWtpwE07n
 jsGpeQIw111zrx1QZyTpU/tDWxIByS5LrZ/wlfbYtNkqk/bmkyQrZX3HHUoRClIj+9oI
 gDQOvZnh4JYZq8jNOss4UZNtnUrIsG4WFBAENYB4nMv41KJ6F1JWVmtGprTc78FZb80Y
 4smvN5ZlbKkY/3BYRYjwaN6r97GnoYa18eGFpYd2B8r+HoghILAvPFeeeFrZKS7b7w9J
 yo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704989901; x=1705594701;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iBaC+OwHzKvcn1f2u1m/q9TkGb6ArrXjBtpZSrOCvGc=;
 b=GDWTZ5X3LuM+c8h3Q3b8v8HsYiqdDkRG4kL33O8j75ZJ7HVvNmAWgmip9BbdDk7lVX
 ZedZr8JdXU3UBi31HAcN3tXblElu3LkgAXoiWlKdssiT/af0a7DbOE7NTk8b4hPuPN//
 Y7rbyouFlwxC4xDG8Fhlse1JhlTx4FPdvGJ2xakaZUv+KG5Ovc3qz0h4Z/iqg/zoY2Os
 F78WSzffckuBo8TSAzWT1v5ATrQBYiixvzMUoXikDGYlDVos/uZLIR2LZVtBvPj3o2yO
 giNJFgCEFYZgUSskwujT7JXBrwAtdQNO1pJYU4C1sqT2Mj4TCWCLygCeGuUb1Af99wA5
 SKlQ==
X-Gm-Message-State: AOJu0Yx+3IbMPokEJUjt+9/LDq4LS52wdWynzI4dx0JO7kKUs+OY633/
 EOPhNBXO82jB8DwFr6Mm5CDUcb/GEF6ysG9GXOh3r+VUVwng3A==
X-Google-Smtp-Source: AGHT+IEUGelgGpTDcnEwLH8wu8/f/qKA0NEeySaYNc2ouj+5YCpr+CB3sFqnLqY3KCxaNUPIKIRRmQ==
X-Received: by 2002:a7b:c8c3:0:b0:40e:43b1:8d9 with SMTP id
 f3-20020a7bc8c3000000b0040e43b108d9mr44281wml.58.1704989900899; 
 Thu, 11 Jan 2024 08:18:20 -0800 (PST)
Received: from m1x-phil.lan ([176.187.202.145])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b0040e47dc2e8fsm2445400wmq.6.2024.01.11.08.18.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jan 2024 08:18:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] cpus: Restrict 'start-powered-off' property to system
 emulation
Date: Thu, 11 Jan 2024 17:18:17 +0100
Message-ID: <20240111161817.43150-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since the CPUState::start-powered-off property is irrelevant
to user emulation, restrict it to system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 cpu-target.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/cpu-target.c b/cpu-target.c
index c4ea795bdd..7e4241c33d 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -206,6 +206,7 @@ static Property cpu_common_props[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+#ifndef CONFIG_USER_ONLY
 static bool cpu_get_start_powered_off(Object *obj, Error **errp)
 {
     CPUState *cpu = CPU(obj);
@@ -217,12 +218,13 @@ static void cpu_set_start_powered_off(Object *obj, bool value, Error **errp)
     CPUState *cpu = CPU(obj);
     cpu->start_powered_off = value;
 }
+#endif
 
 void cpu_class_init_props(DeviceClass *dc)
 {
+#ifndef CONFIG_USER_ONLY
     ObjectClass *oc = OBJECT_CLASS(dc);
 
-    device_class_set_props(dc, cpu_common_props);
     /*
      * We can't use DEFINE_PROP_BOOL in the Property array for this
      * property, because we want this to be settable after realize.
@@ -230,6 +232,9 @@ void cpu_class_init_props(DeviceClass *dc)
     object_class_property_add_bool(oc, "start-powered-off",
                                    cpu_get_start_powered_off,
                                    cpu_set_start_powered_off);
+#endif
+
+    device_class_set_props(dc, cpu_common_props);
 }
 
 void cpu_exec_initfn(CPUState *cpu)
-- 
2.41.0


