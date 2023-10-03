Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B16387B6FCE
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:33:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjEw-0008LO-Hk; Tue, 03 Oct 2023 13:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEb-0008Et-1t
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:01 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEZ-0007RP-44
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:00 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-694f75deb1aso47211b3a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354257; x=1696959057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fnwo/UJ/b2DvU4lEsblMejcY92eLTEQXQgnmvQnDbXQ=;
 b=msCKjioqkO2E3TE0nCXQpTOJV/J3BK34H4UidnhNKIvtk+NUM5AMZu7VfICUgrb49I
 CjrC4YDGZCydeyQirvQAga6AaCb7LtUneP9mOyQFcOgHktHPfAwZagP1EiLO4w791Xjc
 Sd5VLm5+FRPtXP32WRy20BE6IqowjonIF0ulvUuLhrDfKaYXwlT/jz3YQb1yN7iVFsrI
 q6nartlyLvw0Jl3zZ+9/Q71/tSPkJByRHclhtB95vepLim3PzDg+ayWoChNggJ6EtJeg
 NeJ3vr59MQWYbFooQ3ja8G2tuuNtaeZZxIYM6SeUxrAzYWxffffvE1K+hBWQMVrgCN3u
 kulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354257; x=1696959057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fnwo/UJ/b2DvU4lEsblMejcY92eLTEQXQgnmvQnDbXQ=;
 b=LJbn5W1BohGkuskynccNqUMFy7ZxSOo5ntHjiOZcB4DHOxwZ0Z4rCcAqAJaLfIl+KM
 a7yGzJTyNCNJNJGJTgP3yf8pftQ3wv7PGHbkskMhNQDJkPrnjdpfjxkC1r+JJG8XzwLu
 AIG3Oa7fp6S91xxy90vmR840a1bhTeqhBh0QUbP9sWjoYP4R6xn8rMqSJxviyj6FI+Ll
 pyftCTUnaPs7eZpJGiW2PS8OzvZS5dpmvFUXsi3YImcarg95iJzEjFA22xyutyFo0oZz
 1Kk9XifemJGZynEi0gBvhJY6JBAtV6IJhdcIsl42uyaAFJLXe40wCP1DLxX+a6zAZIz1
 s3uQ==
X-Gm-Message-State: AOJu0YymYiR3mMW0pFPp465Eoc2mQTv9Tij5rlREij/vt8fcHZ3ZXh5m
 u/D4hkUVtcTiEdZwQd91nz1ij0W9El/64Y59kxs=
X-Google-Smtp-Source: AGHT+IEADu6h7s0R9+fNtjgk/aXXnjShV6wi1Jxf4TxvPaFEEb5OW5CyTHHmWBFXZ8bYvO53NUq8qg==
X-Received: by 2002:a05:6a00:1583:b0:68f:b015:ea99 with SMTP id
 u3-20020a056a00158300b0068fb015ea99mr5205318pfk.10.1696354256899; 
 Tue, 03 Oct 2023 10:30:56 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:30:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PULL 02/47] accel: Rename AccelCPUClass::cpu_realizefn() ->
 cpu_target_realize()
Date: Tue,  3 Oct 2023 10:30:07 -0700
Message-Id: <20231003173052.1601813-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The AccelCPUClass::cpu_realizefn handler is meant for target
specific code, rename it using '_target_' to emphasis it.

Suggested-by: Claudio Fontana <cfontana@suse.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231003123026.99229-3-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/accel-cpu.h | 2 +-
 accel/accel-common.c        | 4 ++--
 target/i386/hvf/hvf-cpu.c   | 2 +-
 target/i386/kvm/kvm-cpu.c   | 2 +-
 target/i386/tcg/tcg-cpu.c   | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/core/accel-cpu.h b/include/hw/core/accel-cpu.h
index 5dbfd79955..24dad45ab9 100644
--- a/include/hw/core/accel-cpu.h
+++ b/include/hw/core/accel-cpu.h
@@ -32,7 +32,7 @@ typedef struct AccelCPUClass {
 
     void (*cpu_class_init)(CPUClass *cc);
     void (*cpu_instance_init)(CPUState *cpu);
-    bool (*cpu_realizefn)(CPUState *cpu, Error **errp);
+    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
 } AccelCPUClass;
 
 #endif /* ACCEL_CPU_H */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index b953855e8b..2e30b9d8f0 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -123,8 +123,8 @@ bool accel_cpu_realize(CPUState *cpu, Error **errp)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
-    if (cc->accel_cpu && cc->accel_cpu->cpu_realizefn) {
-        return cc->accel_cpu->cpu_realizefn(cpu, errp);
+    if (cc->accel_cpu && cc->accel_cpu->cpu_target_realize) {
+        return cc->accel_cpu->cpu_target_realize(cpu, errp);
     }
     return true;
 }
diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
index 333db59898..bb0da3947a 100644
--- a/target/i386/hvf/hvf-cpu.c
+++ b/target/i386/hvf/hvf-cpu.c
@@ -77,7 +77,7 @@ static void hvf_cpu_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
-    acc->cpu_realizefn = host_cpu_realizefn;
+    acc->cpu_target_realize = host_cpu_realizefn;
     acc->cpu_instance_init = hvf_cpu_instance_init;
 }
 
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 4474689f81..9a5e105e4e 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -190,7 +190,7 @@ static void kvm_cpu_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
-    acc->cpu_realizefn = kvm_cpu_realizefn;
+    acc->cpu_target_realize = kvm_cpu_realizefn;
     acc->cpu_instance_init = kvm_cpu_instance_init;
 }
 static const TypeInfo kvm_cpu_accel_type_info = {
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index b942c306d6..5c3a508ddc 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -163,7 +163,7 @@ static void tcg_cpu_accel_class_init(ObjectClass *oc, void *data)
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
 #ifndef CONFIG_USER_ONLY
-    acc->cpu_realizefn = tcg_cpu_realizefn;
+    acc->cpu_target_realize = tcg_cpu_realizefn;
 #endif /* CONFIG_USER_ONLY */
 
     acc->cpu_class_init = tcg_cpu_class_init;
-- 
2.34.1


