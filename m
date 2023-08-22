Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F99783AC5
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:21:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLgx-0007MG-0K; Tue, 22 Aug 2023 03:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLgv-0007HT-F0
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:20:41 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLgt-0004nN-00
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:20:41 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fed6c2a5cfso35448695e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688837; x=1693293637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+BP3z9xxPaXPgNtP8/KZyJCiuXObaSTzuF1iDUtHzjk=;
 b=i6VJ3pfpx3d2eWYzgpTJqI6oujgCns3KiMAtVdxqmDedsyuQ2K7OUeslf8WBp7caAV
 yQ0Ps0yvBW+iRUT/kTf3VZXkXYD1IVYcbX9ZbbmGnJl+RmELD/ObD3RhMtYqz07frl0p
 W4PhCZDP0fT1344UQrbC31E9whNeNmriachTW1HkLr7FO/5EJo01r6FKKMFfmvMssrhW
 YFl2K1m3k8qNeiO8EFfnd7+c6tlAUi9H1Sa1Ax2BOD4MFf4umakZdznsreVEsFc21/8/
 G0SHVY/jz9OfuRqmRbtmmckxRSkjUoajnSdU7ZEvI+Akuf7Hp3BBEpyjQJLdxx72IGw1
 Qlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688837; x=1693293637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+BP3z9xxPaXPgNtP8/KZyJCiuXObaSTzuF1iDUtHzjk=;
 b=jZc4MN1qCT8+r0wvH+yDVvtLYWebFdQkIp1UMkgHiTToUaXT0B86EQo1r/3GnCzTHU
 enQ/tOG2Wh28bPs1DwrHng8CHzK3FCZeCBPuJs8K3dHpBOmzsP5rNT6cQXl2Pq5OYEz4
 Eiv+AWqEHjFHS2f4Njjf9l/carsxLvTQ+s0jRqxap7ub7f92D4pbhXwBQtQgwj7M/lTn
 U42bkwKi5FIKD+QYwKYjnNDWzJMqnIcOgOH2f8rXwX1iy2LZICgWYXuqaM9t2KT9qYwV
 cSDNCLALIeBY9x7Jaky2mx+5BQWF/wG9p9KtaIk0+ymmAdSiqboYaBriL1MCZz319JHZ
 4SDA==
X-Gm-Message-State: AOJu0YzPsGPUHtaeV3pIO1Gy81OUVzQ2vwDTdRLailHNGrScKv+MgKKz
 OME27vSOqGOspOFMnkQMu9MY0HAPWhmvpdyUYCMI1w==
X-Google-Smtp-Source: AGHT+IFK2RkOeuw6g59wiP80ix4MFYhZFlO1yLyS6EcvtDNRFOgNpPK2ukxhrnUcla1IxYU2KB+vmA==
X-Received: by 2002:a1c:7205:0:b0:3fc:5606:c243 with SMTP id
 n5-20020a1c7205000000b003fc5606c243mr6625296wmc.13.1692688837186; 
 Tue, 22 Aug 2023 00:20:37 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 m25-20020a7bcb99000000b003fee7b67f67sm9792873wmi.31.2023.08.22.00.20.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:20:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Jiajie Chen <c@jia.je>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH RESEND v5 13/19] target/loongarch: Add LoongArch32 cpu la132
Date: Tue, 22 Aug 2023 09:19:53 +0200
Message-ID: <20230822071959.35620-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071405.35386-1-philmd@linaro.org>
References: <20230822071405.35386-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Add LoongArch32 cpu la132.

Due to lack of public documentation of la132, it is currently a
synthetic LoongArch32 cpu model. Details need to be added in the future.

Signed-off-by: Jiajie Chen <c@jia.je>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230822032724.1353391-10-gaosong@loongson.cn>
---
 target/loongarch/cpu.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 67eb6c3135..d3c3e0d8a1 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -440,6 +440,35 @@ static void loongarch_la464_initfn(Object *obj)
     env->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
 }
 
+static void loongarch_la132_initfn(Object *obj)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    CPULoongArchState *env = &cpu->env;
+
+    int i;
+
+    for (i = 0; i < 21; i++) {
+        env->cpucfg[i] = 0x0;
+    }
+
+    cpu->dtb_compatible = "loongarch,Loongson-1C103";
+    env->cpucfg[0] = 0x148042;  /* PRID */
+
+    uint32_t data = 0;
+    data = FIELD_DP32(data, CPUCFG1, ARCH, 1); /* LA32 */
+    data = FIELD_DP32(data, CPUCFG1, PGMMU, 1);
+    data = FIELD_DP32(data, CPUCFG1, IOCSR, 1);
+    data = FIELD_DP32(data, CPUCFG1, PALEN, 0x1f); /* 32 bits */
+    data = FIELD_DP32(data, CPUCFG1, VALEN, 0x1f); /* 32 bits */
+    data = FIELD_DP32(data, CPUCFG1, UAL, 1);
+    data = FIELD_DP32(data, CPUCFG1, RI, 0);
+    data = FIELD_DP32(data, CPUCFG1, EP, 0);
+    data = FIELD_DP32(data, CPUCFG1, RPLV, 0);
+    data = FIELD_DP32(data, CPUCFG1, HP, 1);
+    data = FIELD_DP32(data, CPUCFG1, IOCSR_BRD, 1);
+    env->cpucfg[1] = data;
+}
+
 static void loongarch_cpu_list_entry(gpointer data, gpointer user_data)
 {
     const char *typename = object_class_get_name(OBJECT_CLASS(data));
@@ -787,6 +816,7 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
         .class_init = loongarch64_cpu_class_init,
     },
     DEFINE_LOONGARCH_CPU_TYPE(64, "la464", loongarch_la464_initfn),
+    DEFINE_LOONGARCH_CPU_TYPE(32, "la132", loongarch_la132_initfn),
 };
 
 DEFINE_TYPES(loongarch_cpu_type_infos)
-- 
2.41.0


