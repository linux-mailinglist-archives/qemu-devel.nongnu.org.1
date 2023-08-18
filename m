Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A7678119A
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:21:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX39h-0005D7-OB; Fri, 18 Aug 2023 13:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX39V-0004my-TQ
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:20:52 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX39T-0001q5-KW
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:20:49 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b9cdba1228so18342781fa.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692379246; x=1692984046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYPEbS+9l3jGhhkth1Vm4/5ZlIy93oIVK2+Qb11CVCo=;
 b=YHn+iG5ut+EcpNpnvSv8EWPoknSGsd2LgnDz/v8+Lh8KtaPD0OBZ9vKNI/05S7xfjB
 Q7m19B9b/AiEliuYtkCQ6E8Eq1VrsBs7cjnJ35K+PBZTdikdlF762BC/j3caCSqcz4tr
 hk6XT2il3izVR/2GLtr4oHZOFcNyMDSA0lUOX58X4T6vc8yGYaPe8o0zSaZ5RxZA8vvd
 tHn+4+9GYfcZm0fFZGNIsu3ZmY80mkS9/HuzcWztdF9Nk13Y+Hzq+e35pQKRYjnUJW0G
 tclZtMqr5ksOWcM9jS6YchxPNJjg818lD5BSPLQOQjc1bkf5nDaaW0gxm5s1N+mL0FoB
 c/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692379246; x=1692984046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BYPEbS+9l3jGhhkth1Vm4/5ZlIy93oIVK2+Qb11CVCo=;
 b=fW6zgIgADPl9a7tP/lYqs5SK10x07pOmGAlmiTRvIFaBhiYioeHiaNespfOA+bu1WA
 79pWPe+U1t9LXnsRnoiLM0dxpJc4RLeyEu3oaiyEb058oabNhxXkS2hJZCgOcIbrs5wm
 oM6Z05Ww2KkuOXEH3g4GosCrsjABkfoSPSc2l1obqBgCgrc7ft9FfLrJws8+HlS+E+OV
 ML81qIlaOKyRh6IPwwEArdPGFyK5ERpdTLjt5IAGTN6xjmpzNAJmuRVyChDeY9TPbDDr
 0WM6wFJVc7JWtGU9yU9hVbKmBoXb2ec18dHnHWWZfQqMcjb7sObF2Fhkeb4B0mccPhS2
 wNBA==
X-Gm-Message-State: AOJu0YztkZidY/16gdxT5sJqtlruLMLqF3LQqIpUiJcPbBGYFZ35/+aD
 PW6fZOA4wiLWNHYxseawkXa8Aey8F1t/BH84ubw=
X-Google-Smtp-Source: AGHT+IHvHBRnKre6NCXpa67WjlX3oWC3sf+yXd/wHOe3L8qfeeK2q8ajLYjWhwnDZIaR4hqWrt3cOw==
X-Received: by 2002:a2e:9015:0:b0:2b6:e618:b593 with SMTP id
 h21-20020a2e9015000000b002b6e618b593mr2421782ljg.31.1692379245770; 
 Fri, 18 Aug 2023 10:20:45 -0700 (PDT)
Received: from m1x-phil.lan (cnf78-h01-176-184-27-79.dsl.sta.abo.bbox.fr.
 [176.184.27.79]) by smtp.gmail.com with ESMTPSA id
 gq6-20020a170906e24600b0099c53c44083sm1411375ejb.79.2023.08.18.10.20.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Aug 2023 10:20:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jiajie Chen <c@jia.je>, Song Gao <gaosong@loongson.cn>
Subject: [PATCH v2 4/8] target/loongarch: Introduce abstract
 TYPE_LOONGARCH64_CPU
Date: Fri, 18 Aug 2023 19:20:12 +0200
Message-ID: <20230818172016.24504-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818172016.24504-1-philmd@linaro.org>
References: <20230818172016.24504-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In preparation of introducing TYPE_LOONGARCH32_CPU, introduce
an abstract TYPE_LOONGARCH64_CPU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu.h |  1 +
 target/loongarch/cpu.c | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index fa371ca8ba..c50b3a5ef3 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -377,6 +377,7 @@ struct ArchCPU {
 };
 
 #define TYPE_LOONGARCH_CPU "loongarch-cpu"
+#define TYPE_LOONGARCH64_CPU "loongarch64-cpu"
 
 OBJECT_DECLARE_CPU_TYPE(LoongArchCPU, LoongArchCPUClass,
                         LOONGARCH_CPU)
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index a1ebc20330..34d6c5a31d 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -734,9 +734,9 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
 #endif
 }
 
-#define DEFINE_LOONGARCH_CPU_TYPE(model, initfn) \
+#define DEFINE_LOONGARCH_CPU_TYPE(size, model, initfn) \
     { \
-        .parent = TYPE_LOONGARCH_CPU, \
+        .parent = TYPE_LOONGARCH##size##_CPU, \
         .instance_init = initfn, \
         .name = LOONGARCH_CPU_TYPE_NAME(model), \
     }
@@ -752,7 +752,13 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
         .class_size = sizeof(LoongArchCPUClass),
         .class_init = loongarch_cpu_class_init,
     },
-    DEFINE_LOONGARCH_CPU_TYPE("la464", loongarch_la464_initfn),
+    {
+        .name = TYPE_LOONGARCH64_CPU,
+        .parent = TYPE_LOONGARCH_CPU,
+
+        .abstract = true,
+    },
+    DEFINE_LOONGARCH_CPU_TYPE(64, "la464", loongarch_la464_initfn),
 };
 
 DEFINE_TYPES(loongarch_cpu_type_infos)
-- 
2.41.0


