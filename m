Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4453A7829CF
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 15:01:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY4XM-00011r-La; Mon, 21 Aug 2023 09:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4WH-0000Mr-8n
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:00:50 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4WE-0001Cf-HB
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:00:32 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31c3726cc45so1192465f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 06:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692622828; x=1693227628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XkFQ/Hg2hO7EU81YeAwAVpwO++/fptKuH4LuzhRKmho=;
 b=tgh568op/VZROyOFlStSZYvij2cw8LzXK5O9jwdOJSOS7g7sXEHVAcEOKBc+Pd8n3w
 7vz/NdQEPHMWUBRV+tUnSEjaROy1F1KEbc7M1MOQvL7u234PViJiEQixOwHroMwrhlJ8
 IHf6Nox3sW2AdPmj7kALFD8+3YGtmRLZFKlxQH6+71Bhofg45QIiSLoS/CuqWOFGbG2Q
 qtEb+6wLhFycPTBL01Hkr4tLo0cuV5t9Sj15oXU29czVrWbjrLfCAg0YrOLcjI127PE1
 AW8CHpsfNFDfvr/iSoQ8EdHvmSqtyxlAuc82LY3iX6kqDs3FjX4WZlipbTaltshzxQum
 RH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692622828; x=1693227628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XkFQ/Hg2hO7EU81YeAwAVpwO++/fptKuH4LuzhRKmho=;
 b=QUs3b1PjD/bDbWDICbkVdmizO9Xhx9fe7wo5UqKe+MUvpUcz23zyLPK27WwF2YgGw8
 LvGnfeMvul8Ss7JaBEnl0mpJjAPsEgMlTWbuXFpHKR2vnNshTv2bgR6dzXqDzKah3c+3
 9jUUGLmI87BrPRxoOeruIKZeYRdHB+b4Sr11pgqC3yyuhnDOkON9GDKwUGDQAfycnIgR
 bbs25vPmhktdIyVeVqwdq+eRYpvbXFDqc+z8ZOWbT2Z6xA9rleWAuFz8LWdWpSKa+dJt
 Dcg1xJqytUKjg8skYdWP+nD7XAX1/nCBzZwSnJ5FNcrPauNqfNXWIixMml3DwocMxjFF
 vMLw==
X-Gm-Message-State: AOJu0YxHCa4GjfFzUSkhF1fQ7e+F1modKSkS7xDFbz9QCcm86tXobQIU
 zqsKKrQcP2NnZJInA9swDXdQge2gKzJ5mo10Fsw=
X-Google-Smtp-Source: AGHT+IGSCdh/opmmxJN1U8pTVB8rjixzHfwXlOdOkJvD0pcY1poV5j9WMcvQsRxHK+NWrowPhmQnCg==
X-Received: by 2002:adf:ce8f:0:b0:31a:ddb3:32da with SMTP id
 r15-20020adfce8f000000b0031addb332damr5520091wrn.22.1692622828027; 
 Mon, 21 Aug 2023 06:00:28 -0700 (PDT)
Received: from m1x-phil.lan (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 n16-20020a5d4850000000b003179b3fd837sm12464009wrs.33.2023.08.21.06.00.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 21 Aug 2023 06:00:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 4/8] target/loongarch: Introduce abstract
 TYPE_LOONGARCH64_CPU
Date: Mon, 21 Aug 2023 14:59:55 +0200
Message-ID: <20230821125959.28666-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821125959.28666-1-philmd@linaro.org>
References: <20230821125959.28666-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


