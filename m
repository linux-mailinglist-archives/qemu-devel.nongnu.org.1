Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7213682AE4C
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 13:05:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNtmy-0003Kp-KY; Thu, 11 Jan 2024 07:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNtm9-0002uC-Go
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 07:03:10 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNtlz-0007KH-D4
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 07:03:08 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3368b9bbeb4so4933022f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 04:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704974559; x=1705579359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kbCxYAXnaPA+cdBawT/EluO8Fm76t17YXM33Yu5GMIw=;
 b=b+SRBAOgNj8xyn4b4laAHQnbANkNxH6ajSdjXflVW5inpprEpmJlFtPMEt17/oY2s0
 K6bbNa5U8OpKA17OPVWm7t1nGq9mMd4JN3DfZwpOE6GdPocnLMPB+jtGy4ew18W+2Weh
 1VZ0h2dS4hFcAOED0vzcOFGs2TEp9WOobpfzDfzG4Ng4f2APPwskCaGzwmxoQZOGhI+e
 2ZSiIcxHy2162QVIouhMFScIce2OIgViEFlG3teTeKnHZmxHL/R8cVK39Ppbb5F6X7eh
 tbhSM8ccIAhrgNG2qK1Y6ZUL1gKRTm1gLr55lYTnB/r4CrXuZYqxR5P60ECtjsm8AJoE
 DcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704974559; x=1705579359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kbCxYAXnaPA+cdBawT/EluO8Fm76t17YXM33Yu5GMIw=;
 b=KJ6z3TUMZIlQ7NXxxZETV4t2dxpvLt8vdxdhYwR6cuql4yU2ZySNTMXLrNvbpFfKbh
 AzSaM94Bdi/Dt+izOfFGW41OvUTZlvuHZA5ehgttEML/6cGgFWQQfeuNnoorMrG6uSw0
 O1nulq0wJkvIUFt3evTa23Rde93R2eqvb5oHWw2cv8vTZl0QL9wFAgxpcgNLW1QuPouW
 wVWsyruRIqxoLOX8WmQmXskD67Ulu8W64Sv3eGuMxbK+UVgL8Q7WAsGK9hk2sygEp9GZ
 ewb1qNWunkmIFuzRw87xN6SS2YCb46IYaC7B6YYXTUGUpKQtpTL4gQ3YNNNHdH/y6bmg
 jyCg==
X-Gm-Message-State: AOJu0YzS1O9N9ZDF/5dUtxwxlEa01sT1trZY650i85WFqC8S/Z5JDoaf
 7WexVcU4Y62hRgtenjMDFFZqNHHkd9PGn3Q7kHQ7yX786Xj1yw==
X-Google-Smtp-Source: AGHT+IFi8ZAqXwBB+XquvDhK61hjPKAOzIdwxhqJUxp6aXpwxrV48/CZzjIuV9adAouObPtk84HeUA==
X-Received: by 2002:adf:f5cc:0:b0:336:62f7:720f with SMTP id
 k12-20020adff5cc000000b0033662f7720fmr297987wrp.160.1704974558996; 
 Thu, 11 Jan 2024 04:02:38 -0800 (PST)
Received: from m1x-phil.lan (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 e16-20020a5d65d0000000b003365951cef9sm1061169wrw.55.2024.01.11.04.02.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jan 2024 04:02:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-s390x@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bin.meng@windriver.com>,
 qemu-trivial@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <laurent@vivier.eu>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/5] hw/core/cpu: Rename cpu_class_init() to include 'common'
Date: Thu, 11 Jan 2024 13:02:18 +0100
Message-ID: <20240111120221.35072-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240111120221.35072-1-philmd@linaro.org>
References: <20240111120221.35072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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


