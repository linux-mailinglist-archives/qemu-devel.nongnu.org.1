Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D34E7829D4
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 15:02:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY4XN-0001L1-O4; Mon, 21 Aug 2023 09:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4Wd-0000ZZ-4r
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:01:00 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4WY-0001GQ-Pm
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:00:53 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e587eso31614445e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 06:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692622845; x=1693227645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6tzLHYJyVkaJuRC3rPNGOZvBxbKGeACB/E2Y8xkmh8s=;
 b=YSn2swvaty+fsZRWMiXbShhj/FNdV3PgKfpu5mDmZTB28kC7ZxJn3cx2nQMnGTdHIF
 9IQ1IzbAd7X78GzbMaKTx4nfTi1p9YepB9qO/43ryPi+5UpnfNaLzgGe9XSt1GDP2kYA
 IQGRwl0brFgs+OaIIQK9Swqn05kKYqfxvBMe+i9ZlR9HMti0fXxBZINxNjhZ4VmtL2KO
 N3kDJSNIjv5AUrq6jV0VclNPnFokr5oo71qOM1eNm1nWjvDe5fbNtp4N0JJTnHuYobVY
 +B+FDiDDeeXQm3lvUHPrO9jfkHW69CtrS/tQXuy1k7l55v8n2lpi9EGwg18vjJ1WlZ0z
 3ZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692622845; x=1693227645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6tzLHYJyVkaJuRC3rPNGOZvBxbKGeACB/E2Y8xkmh8s=;
 b=En1APpvdA/1R01xbfgqoorrsP/mgab7k9UB6BRmTLjf2BvN/0cOkxVeidY0OYmsVk2
 pUvEnIttV88mO4w8ELaZICyOIHA5jKQ1Bu8Sh659MQZlOpQuLZ4KO4GppzCqsdC/V+nd
 PZV6qsKMrfRgGG77m6J9Ul2Qknqfz8ZqoRvWm1G7f0Ji/YjZ2+1MFCuwZqZNh1TAhK4t
 QZMuLrOlojaFnYd1qBCjh4uwYh0Gjhnp9rP+4yEYyVZlrBO3ySJOJfOU59r89Jy1r8cN
 nTq1FhuWaJrsBj9eog0m+vXlPCE8neiZxDjSsgJkRovKZnVbttc8tYv/3koyL5PsXdgk
 EqMg==
X-Gm-Message-State: AOJu0YzFe/jQFowcbsd7g05/cXw524+C68GDPRxk7yYN7oOKcJybExCm
 WhuEpJBRxS6l3/RhBPk8LJ+XjUW6wmpR8ZGSBCo=
X-Google-Smtp-Source: AGHT+IHK6PiPJ6XomhF5uSBywe7UQTWjfDpe2FIOqJnhAgiSZ/+rjZsnlwp4II96u1AMiMzBjGAQIA==
X-Received: by 2002:adf:e242:0:b0:317:60fc:d3c8 with SMTP id
 bl2-20020adfe242000000b0031760fcd3c8mr4734678wrb.71.1692622845597; 
 Mon, 21 Aug 2023 06:00:45 -0700 (PDT)
Received: from m1x-phil.lan (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 i14-20020a5d630e000000b0031980783d78sm12415396wru.54.2023.08.21.06.00.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 21 Aug 2023 06:00:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 7/8] target/loongarch: Add new object class for loongarch32
 cpus
Date: Mon, 21 Aug 2023 14:59:58 +0200
Message-ID: <20230821125959.28666-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821125959.28666-1-philmd@linaro.org>
References: <20230821125959.28666-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
index 6384bda1bd..556419f159 100644
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


