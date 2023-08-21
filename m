Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D7A7829D5
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 15:02:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY4XO-0001LN-0P; Mon, 21 Aug 2023 09:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4Wd-0000Za-4r
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:01:00 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY4WY-0001GG-PM
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:00:53 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3179ed1dfbbso3097326f8f.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692622840; x=1693227640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/is4OP2bMjv02N4bH1oF/ePbIH9KS0BSaVmzaTcaDA=;
 b=Fi/aUUe0yJ+8Kz820NI0EVTc2lHG513QGv3fvmaBi/I+W/MpQwucdllJk4egrdS6AL
 j5C8mH+2391ZOcIqlgD+JiMimZA2RJW7F3A0AEpJAaQYE0xToRqv0HXZsXc3MX59ER2H
 Yr7Ns/iXCXnAQRDd7uPlTcmBbx2RH+9te435VbFzVCjliSfdGSJQ8J/+PCzsalR7ZN64
 IWU872qwdkTBpXSdmDKH9lpsrrCoybcTP3RTsdikp6SG1F3HOoJHd0p7NCa5lHGbor9q
 lvG0M4DlUEs6mPh8E9qAzuY8eM8MmQaog1X+Do4ceY97tMFWj+gMVWXFqW/oc2zfAcbZ
 1qcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692622840; x=1693227640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/is4OP2bMjv02N4bH1oF/ePbIH9KS0BSaVmzaTcaDA=;
 b=Vwlqt53iMkw+KzqqMpQrU3Y0XJqxgov0Qinsn/WkavCUbtorR0hQzO8nIEbLRYGpEF
 9eXqECVgJoAqlhSlwTO3uW3g48JkiqjOAw5kPKqBsD5GZ6eqMaLD+lR7SHoGXJxp1pb1
 kJhRVOM9o6HkViV00BVOzsOroi8BZf/95ZU/RbMiELP4csJraampIdUUaQKF0W4dk4Wu
 V9Eg3rhiL8NXANmD2DRKPtcKhjj5Hxu7NUbuOBtT/V8fTMI4wMHZsSG4kXAJR/Xf0S3I
 EFGGBaht4PRpP9rm23Btn11mY6RNvDIVHp0Q4kiuPHcNH8u9HgU9CgQq/R7WLYi1vv24
 FwqQ==
X-Gm-Message-State: AOJu0YwhqulBE9gBVWHv7gMert7yHraBBmYvytzLIxcOyYER4KKXB/Ai
 CSw2gw3pXtBohEv/Ps/5xoeLETKMr9AiZCKO2pk=
X-Google-Smtp-Source: AGHT+IGjCTrGBfcAK+gJ+CTjVpqilN3xy2j8qUospLjGCQjIzFWrmO4r0WNr10B/dhjaEoGV0LvQGw==
X-Received: by 2002:adf:ea10:0:b0:31a:ed75:75e9 with SMTP id
 q16-20020adfea10000000b0031aed7575e9mr4620224wrm.13.1692622839591; 
 Mon, 21 Aug 2023 06:00:39 -0700 (PDT)
Received: from m1x-phil.lan (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 z7-20020a5d4d07000000b00317afc7949csm12403170wrt.50.2023.08.21.06.00.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 21 Aug 2023 06:00:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 6/8] target/loongarch: Add function to check current arch
Date: Mon, 21 Aug 2023 14:59:57 +0200
Message-ID: <20230821125959.28666-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821125959.28666-1-philmd@linaro.org>
References: <20230821125959.28666-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Add is_la64 function to check if the current cpucfg[1].arch equals to
2(LA64).

Signed-off-by: Jiajie Chen <c@jia.je>
Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20230817093121.1053890-2-gaosong@loongson.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index c50b3a5ef3..3235ad081f 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -132,6 +132,11 @@ FIELD(CPUCFG1, HP, 24, 1)
 FIELD(CPUCFG1, IOCSR_BRD, 25, 1)
 FIELD(CPUCFG1, MSG_INT, 26, 1)
 
+/* cpucfg[1].arch */
+#define CPUCFG1_ARCH_LA32R       0
+#define CPUCFG1_ARCH_LA32        1
+#define CPUCFG1_ARCH_LA64        2
+
 /* cpucfg[2] bits */
 FIELD(CPUCFG2, FP, 0, 1)
 FIELD(CPUCFG2, FP_SP, 1, 1)
@@ -421,6 +426,11 @@ static inline int cpu_mmu_index(CPULoongArchState *env, bool ifetch)
 #endif
 }
 
+static inline bool is_la64(CPULoongArchState *env)
+{
+    return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
+}
+
 /*
  * LoongArch CPUs hardware flags.
  */
-- 
2.41.0


