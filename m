Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9AF7B690A
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:32:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qneYL-0000EQ-Ia; Tue, 03 Oct 2023 08:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qneYF-0000B8-OW
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:30:59 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qneY8-0007jt-5p
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:30:59 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32487efc319so896377f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696336249; x=1696941049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+r9kD/biBFamNwbYJdkWZ0i3n7hbuMnWH0aEsGJ6SFw=;
 b=U6W/nhEJ8nFZJP6mbvqYq4rXK+KXQKCoZ90l3M82qX8G4jE0dST4PanB6lWoFCSGk5
 XrJIoYSAc1QpjFQDxuIhAJk+4rnC6vxiJItm31Pi9/Q0dbIuODWP21RTCkhozDDwmy0R
 iv2KNMHf6wwVirQbuo5IismITclJsM//+oN3VjCfY/P6aVnGtJ+ULyKjct8pVjVJ7hKN
 EpRheYpXJevPEfL0CYhex9QhJecKyAawkya9uKD150dh1GtuoIuRB++c1L5OElRPv40K
 Pw5+1GnI88lpkHs0vz8CbiXh1vzX8qT2Sw+q3GkZT3vmOdhOYxTwAVppozgB3QeHYPpe
 6vfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696336249; x=1696941049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+r9kD/biBFamNwbYJdkWZ0i3n7hbuMnWH0aEsGJ6SFw=;
 b=FWzdmN1U6RsJ5ojRcrf+f5RXKyb1l8ZeI5z8BBsB52K/wy2uNc3qGd+ScxoQDQO4Iz
 ne0A3F0timwm8eNASYROXl6DKn5/dk8stcQ9nrZCg/ggZlVJCwWD/UgqFXnK6u2sA/2o
 PiUr2WOcyBu5LKp/cgy+FCFJlYSZVEyzKle8i+rtTc1ft5ehbHesuufEf3h7S/EwzfbR
 VtM/6DbY2TKdIh2y7VJtB2+TOtIb3WKrL0tXN2YqBv1/lomxnlbKSJBcoY6z1ur03B9T
 2a69O5eSzn7DUSwYAhCCYZq5GGBOMjua0dyytjxtX/SWgS1YkAE3CWPr9oGNYcXgYTWw
 zKaA==
X-Gm-Message-State: AOJu0YwRc2LDXOYmn/4U4jiyZ8XQEgtO6iqCQpEYDZMMoi1DgPmOR3b9
 j6QTVoTyytUlb7BqRB5Kcx1n7XLdmetfPzBIs+Ic2A==
X-Google-Smtp-Source: AGHT+IHhblTpAoVK9JdeAoL6m9m3WTb9pwO1Prdgl3RZZc3YHqkdykddbrQQUTc7erRRAv19P/MBzw==
X-Received: by 2002:a05:6000:186c:b0:327:d08a:1fa2 with SMTP id
 d12-20020a056000186c00b00327d08a1fa2mr4920150wri.36.1696336248049; 
 Tue, 03 Oct 2023 05:30:48 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-246.abo.bbox.fr. [176.131.222.246])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a7bc850000000b0040303a9965asm9309683wml.40.2023.10.03.05.30.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Oct 2023 05:30:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 3/7] accel: Rename accel_cpu_realize() ->
 accel_cpu_common_realize()
Date: Tue,  3 Oct 2023 14:30:21 +0200
Message-ID: <20231003123026.99229-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003123026.99229-1-philmd@linaro.org>
References: <20231003123026.99229-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

accel_cpu_realize() is a generic function working with CPUs
from any target. Rename it using '_common_' to emphasis it is
not target specific.

Suggested-by: Claudio Fontana <cfontana@suse.de>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/accel.h      | 4 ++--
 accel/accel-common.c      | 2 +-
 cpu.c                     | 2 +-
 target/i386/kvm/kvm-cpu.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index cb64a07b84..898159c001 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -90,11 +90,11 @@ void accel_setup_post(MachineState *ms);
 void accel_cpu_instance_init(CPUState *cpu);
 
 /**
- * accel_cpu_realize:
+ * accel_cpu_common_realize:
  * @cpu: The CPU that needs to call accel-specific cpu realization.
  * @errp: currently unused.
  */
-bool accel_cpu_realize(CPUState *cpu, Error **errp);
+bool accel_cpu_common_realize(CPUState *cpu, Error **errp);
 
 /**
  * accel_supported_gdbstub_sstep_flags:
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 2e30b9d8f0..53cf08a89a 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -119,7 +119,7 @@ void accel_cpu_instance_init(CPUState *cpu)
     }
 }
 
-bool accel_cpu_realize(CPUState *cpu, Error **errp)
+bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
diff --git a/cpu.c b/cpu.c
index 61c9760e62..1e2649a706 100644
--- a/cpu.c
+++ b/cpu.c
@@ -136,7 +136,7 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
     /* cache the cpu class for the hotpath */
     cpu->cc = CPU_GET_CLASS(cpu);
 
-    if (!accel_cpu_realize(cpu, errp)) {
+    if (!accel_cpu_common_realize(cpu, errp)) {
         return;
     }
 
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 9a5e105e4e..56c72f3c45 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -35,7 +35,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      * x86_cpu_realize():
      *  -> x86_cpu_expand_features()
      *  -> cpu_exec_realizefn():
-     *            -> accel_cpu_realize()
+     *            -> accel_cpu_common_realize()
      *               kvm_cpu_realizefn() -> host_cpu_realizefn()
      *  -> check/update ucode_rev, phys_bits, mwait
      */
-- 
2.41.0


