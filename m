Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66300740975
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 08:34:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEOje-0002gc-Es; Wed, 28 Jun 2023 02:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEOjb-0002gI-V3
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:33:00 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEOja-0002wV-81
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:32:59 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fa99b57a38so29997755e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 23:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687933976; x=1690525976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9sCTggNurZWXESMN+if2ZIuv9/6vPN9d2Ktd0eVqSU=;
 b=gtVJdoC0cncKhmmHWybUb/1rphAKZXI8pMfRNpI6R00p14vCl554G8lSpin+j5E1+N
 mzVTnxWtv6aynUELLt1kYHfjzJla+627dDkUWX0I49Hhbi+pdI7RzE1lvtaQzIp4A/vj
 f4QU5634OJXonZ4DRZMI/zam6WZqNdCbgnbPzmLQSYBmIgJotNHI/k1TstfbRDTQIGd9
 uw5j7AEWWHgsdSuXZ52D4b32M8y8rw+Uh0j8gFOJtcEQ0v39lnNiMH54to3g5NIjrr59
 ZJQz82tU7atfg2kXQBWOQMS40b2XzKABBzkh4i4Dx3c0/22ceXXb1KqiDgk5/lOCOA5d
 Xy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687933976; x=1690525976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9sCTggNurZWXESMN+if2ZIuv9/6vPN9d2Ktd0eVqSU=;
 b=CAdYLVaX7I5BHF101Gy1l+T/HDfjh6YXHkv5hcYAdJmJggTZLo3QFn7TX7i63MHvmJ
 AMI9DtAOojk0E2k7tXG/NwQuWBJ+7urh1iCGVMFnJJSzJKemKO1ys4ZYgZK+iaay+ylu
 I+JNjJ6aMETTTQHNNk4BaC6u8yME/gYHKycFjBtzjcB0AQGjwK8lpWGVtJPzRwU1OUhR
 xq/tFUFjVZUsfrT9aEuoQQLFNJNv8iZckFv10stlL6rrrQRxnRwNwVjPtP1s089uFgQV
 PZ6vk6Ag0cjt5I+6axHkgTuTSv2lWYLHmAMww4emt/r0Oa2rD4HnQ1Sf2CAn+2JQPold
 tQHg==
X-Gm-Message-State: AC+VfDzw151AruUJf3qxgb/geEgQgGXtlW+B/lPLWL/3Pwnn4jgELEKB
 11V6acD/zzDhjy8VD+dFRuE3emClOxGZI4mlPRk=
X-Google-Smtp-Source: ACHHUZ7S9li2rjvS5ciAHa6hYOfippk29zGrLSVjCb+Q6QGiqepK36bb/2f5w//LgN85QD4Fbsr/EQ==
X-Received: by 2002:a05:600c:2184:b0:3fa:770c:5918 with SMTP id
 e4-20020a05600c218400b003fa770c5918mr11954741wme.9.1687933976509; 
 Tue, 27 Jun 2023 23:32:56 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a056000194a00b0031134bcdacdsm12446215wry.42.2023.06.27.23.32.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Jun 2023 23:32:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/4] target/riscv: Restrict 'rv128' machine to TCG
 accelerator
Date: Wed, 28 Jun 2023 08:32:33 +0200
Message-Id: <20230628063234.32544-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628063234.32544-1-philmd@linaro.org>
References: <20230628063234.32544-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

We only build for 32/64-bit hosts, so TCG is required for
128-bit targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d9a3684b3e..5762ff68b4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -476,6 +476,7 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
 #endif
 }
 
+#ifdef CONFIG_TCG
 static void rv128_base_cpu_init(Object *obj)
 {
     if (qemu_tcg_mttcg_enabled()) {
@@ -494,7 +495,10 @@ static void rv128_base_cpu_init(Object *obj)
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
 #endif
 }
-#else
+#endif
+
+#else /* !TARGET_RISCV64 */
+
 static void rv32_base_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -576,7 +580,7 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
     cpu->cfg.ext_icsr = true;
     cpu->cfg.pmp = true;
 }
-#endif
+#endif /* !TARGET_RISCV64 */
 
 #if defined(CONFIG_KVM)
 static void riscv_host_cpu_init(Object *obj)
@@ -1951,8 +1955,10 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_CPU(TYPE_RISCV_CPU_SHAKTI_C,         rv64_sifive_u_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_THEAD_C906,       rv64_thead_c906_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_VEYRON_V1,        rv64_veyron_v1_cpu_init),
+#ifdef CONFIG_TCG
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,  rv128_base_cpu_init),
-#endif
+#endif /* CONFIG_TCG */
+#endif /* TARGET_RISCV64 */
 };
 
 DEFINE_TYPES(riscv_cpu_type_infos)
-- 
2.38.1


