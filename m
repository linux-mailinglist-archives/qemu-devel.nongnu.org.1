Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D36781196
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:21:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX39w-0007LR-Kx; Fri, 18 Aug 2023 13:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX39o-0006dY-Nt
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:21:08 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX39m-0001u6-DL
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:21:08 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-99d90ffed68so479432266b.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692379265; x=1692984065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uEMElgMvR1O3ZuyrTpBd0rfdnbX1M9RkvLN7Ub/Z4Dw=;
 b=MuRNZy5Wj9JU8nMw9ACBoTqf4tCv1Sl/DlN5qy6tgakiWAxwj1ST0ZH6Rgx+oUY4r9
 JlInG3SlRt53sUpL/jFfOptGIiIgdXjbZSJ/WZI485yZjfTs6jeoY4dBuq9XUt60Qyu6
 P4OwEO1EmnPCxlFvBBaNoMUZMnyfmQUScb6+n9BVOzZd9T8QQmN4kD9iUqim8dOtJh9n
 bM6VgPfxzAGfO2ZVM3mxMEq9axPd77kyz3XOd+IBeWKISeVJPARBetDXL2Jl006MND35
 y48GLYskOJNDoF+VLQjp62AJTQWN+vfTkeDng6FhEtw4hhC0u2SRtae0uD9we14UBYda
 1GvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692379265; x=1692984065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uEMElgMvR1O3ZuyrTpBd0rfdnbX1M9RkvLN7Ub/Z4Dw=;
 b=B1ByX1F3Up5FwN3V7PWD+kgWLLIr0DfZqMSw/gtdRCQnBu2M2FBSMQHdirXxy4DQDK
 sU0AUwWzUes5T+zfn+RH3fjEhLLv5GrSy7DEYPZIJtQROE6zW7inHoKzRfGVvFeP60Jg
 x+xgB2s2qHg3c3VC9DKVMRDK+zLf9N+iHPs6JPHUXB9B0sxnJg2411YpO1WshXZlbkmu
 bBfL6KHUVqcLJpgg0Y0Ije4VNl3MzthoTz5W2aPIqz+8xi8aR89lrLCXRa/Hc73K2Qpe
 XNeY3te16XRtUbK/jvO6v+mZN4EGUa+bYKI7fwo/goXmOk3y8+0Nd+Ka/jNN8PvAFeAh
 5MfQ==
X-Gm-Message-State: AOJu0YwsDmharJPbk4n2Dz00DIhw6P0oS3UwCDSe4QUH4No67DRg677d
 9NKxwx1UojUNOx9ZGYj84VSgRA0RiV4miAmuxDs=
X-Google-Smtp-Source: AGHT+IFfivwRxuLAN1HQuB3QQYL0Ca8mPGPEDObH+BVRtXkPgGa40G63gWKQCvJG8k5r3dC/pEBADw==
X-Received: by 2002:a17:906:5195:b0:997:e9a3:9c4f with SMTP id
 y21-20020a170906519500b00997e9a39c4fmr3658167ejk.30.1692379264879; 
 Fri, 18 Aug 2023 10:21:04 -0700 (PDT)
Received: from m1x-phil.lan (cnf78-h01-176-184-27-79.dsl.sta.abo.bbox.fr.
 [176.184.27.79]) by smtp.gmail.com with ESMTPSA id
 yy10-20020a170906dc0a00b0099d02ca4327sm1411861ejb.54.2023.08.18.10.21.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Aug 2023 10:21:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jiajie Chen <c@jia.je>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 7/8] target/loongarch: Add new object class for loongarch32
 cpus
Date: Fri, 18 Aug 2023 19:20:15 +0200
Message-ID: <20230818172016.24504-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818172016.24504-1-philmd@linaro.org>
References: <20230818172016.24504-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

From: Jiajie Chen <c@jia.je>

Add object class stub for future loongarch32 cpus.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20230817093121.1053890-3-gaosong@loongson.cn>
[Rebased on TYPE_LOONGARCH64_CPU introduction]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu.h |  1 +
 target/loongarch/cpu.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 3235ad081f..b8af491041 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -382,6 +382,7 @@ struct ArchCPU {
 };
 
 #define TYPE_LOONGARCH_CPU "loongarch-cpu"
+#define TYPE_LOONGARCH32_CPU "loongarch32-cpu"
 #define TYPE_LOONGARCH64_CPU "loongarch64-cpu"
 
 OBJECT_DECLARE_CPU_TYPE(LoongArchCPU, LoongArchCPUClass,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 356d039560..5082506f10 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -726,6 +726,10 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
 #endif
 }
 
+static void loongarch32_cpu_class_init(ObjectClass *c, void *data)
+{
+}
+
 static gchar *loongarch64_gdb_arch_name(CPUState *cs)
 {
     return g_strdup("loongarch64");
@@ -758,6 +762,13 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
         .class_size = sizeof(LoongArchCPUClass),
         .class_init = loongarch_cpu_class_init,
     },
+    {
+        .name = TYPE_LOONGARCH32_CPU,
+        .parent = TYPE_LOONGARCH_CPU,
+
+        .abstract = true,
+        .class_init = loongarch32_cpu_class_init,
+    },
     {
         .name = TYPE_LOONGARCH64_CPU,
         .parent = TYPE_LOONGARCH_CPU,
-- 
2.41.0


