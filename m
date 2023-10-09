Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F4B7BD928
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 13:03:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpo2q-0006bV-H3; Mon, 09 Oct 2023 07:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpo2e-0006Ol-97
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:03:16 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpo2b-0003PR-PT
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:03:16 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9a645e54806so748323966b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 04:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696849389; x=1697454189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V78g9jhuJwuu3XH3up4N6OXq/ULujlSA7fdJ/xZ8gEw=;
 b=RQ+OULPH/jae5EyalmRTnYY2y1PiomgrGPnqS9QRDVRwhNGbHHVNLNO9zXYjqKi+JU
 iGgzNmxuB1AzEgVTORIrJEpi1nrp4xBbETy+ayZ86ps1ahUpBsAOOPtniDcy6i7Gqk7F
 xUZkOw74yUFLOZ5CGiwccuQFKzBSs9r6dnn/r5a8T2wpk9zD5c4xVuIZaCQiU/r3tm2/
 J1ODZVBudu3nkq0um1gBtN8CeCEskWBpxpoCqsOsFgnTAeQkNKJy7ZtpivrT9rIEe1Of
 aK6/gU62yuNeRWOGX+KQnVlsdcBt1YDgK4InnM3f0FRSh4akkBK0NqVZCMMr7drPjomD
 /tYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696849389; x=1697454189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V78g9jhuJwuu3XH3up4N6OXq/ULujlSA7fdJ/xZ8gEw=;
 b=SJMZQpUZO6DJdqOXZGfOByqcaQcVEpMmm3YubkdMlC8m1DammS5uh96hv16pD+Cd7D
 doIJs9/LD8AptlafzcRltO0dGc+VqsBtD9q//w7FiX8Aw/T6odGpDk0ZfykwbbLN76El
 GulaX+FNdkI+WUa0UqJs3jnZtJiM9JzWk3zemT7inZ0He2QOdnOT+ZNJtyViowLej23D
 a8buvcMkwSZe4aQ7IJbi2sweu6dQJhdeKVjTo+P4Nse+hYRyYdZunE5mToU+kzzvIx2/
 dd3a5oSkDqlyl5rqECT6QuuLY5TD8bYLJ7vckBhzS45VEiThCI/FRZ4yOHkRa1YfYSNS
 tkfw==
X-Gm-Message-State: AOJu0Yxx4bBDw9S3CAC/aKW7iw8nwamNw5SduW+Gidl6xJ0Zs1YVp9rQ
 Ex8BUGEQvEsvTwh3sGE4XMsDOBRN+R0oIA+DJd8=
X-Google-Smtp-Source: AGHT+IEcNwxVZqRuOS5msdhnG1M0Nje61e749+OicUXZAaRVWxzCHpr70xl3BdSEcOOgS8SbhCgXWA==
X-Received: by 2002:a17:907:763b:b0:9ad:c132:b93b with SMTP id
 jy27-20020a170907763b00b009adc132b93bmr12534458ejc.5.1696849388833; 
 Mon, 09 Oct 2023 04:03:08 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 u16-20020a1709064ad000b009ae54585aebsm6489905ejt.89.2023.10.09.04.03.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 04:03:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Cameron Esfahani <dirty@apple.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/6] target/xtensa: Use env_archcpu() in
 update_c[compare|count]()
Date: Mon,  9 Oct 2023 13:02:37 +0200
Message-ID: <20231009110239.66778-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009110239.66778-1-philmd@linaro.org>
References: <20231009110239.66778-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When CPUArchState* is available (here CPUXtensaState*), we
can use the fast env_archcpu() macro to get ArchCPU* (here
XtensaCPU*). The QOM cast XTENSA_CPU() macro will be slower
when building with --enable-qom-cast-debug.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/op_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 7bb8cd6726..496754ba57 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -37,7 +37,7 @@
 
 void HELPER(update_ccount)(CPUXtensaState *env)
 {
-    XtensaCPU *cpu = XTENSA_CPU(env_cpu(env));
+    XtensaCPU *cpu = env_archcpu(env);
     uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
     env->ccount_time = now;
@@ -58,7 +58,7 @@ void HELPER(wsr_ccount)(CPUXtensaState *env, uint32_t v)
 
 void HELPER(update_ccompare)(CPUXtensaState *env, uint32_t i)
 {
-    XtensaCPU *cpu = XTENSA_CPU(env_cpu(env));
+    XtensaCPU *cpu = env_archcpu(env);
     uint64_t dcc;
 
     qatomic_and(&env->sregs[INTSET],
-- 
2.41.0


