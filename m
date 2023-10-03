Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7533D7B6FF4
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:37:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjEx-0008Lp-I4; Tue, 03 Oct 2023 13:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEc-0008FI-Hb
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:03 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEa-0007RV-P7
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:02 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-692d2e8c003so28205b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354258; x=1696959058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MiKqpxzWJlU8GamjHXrloGQvl3H+1lN59n29xY6vQ3w=;
 b=CnnUnzsy9id/FO4rw6O8JtoxqBZZCNTC+44poby0ms1RksISrYeYZSIrSHxiHcZ0Io
 SiJrwTxRAerbhjZxRJAAW7iD6y0A53DJeLDGrTTXCfREh2bUCb+GCy5gCXfJzs28mLwv
 JN2tqJpetnuf9T61hdn+yNdfiXZfyWChgxQKW4LUY/uYWCs/u7ylc2me/SWX9jJdWp9G
 eOqJQV1PN5+JeL/AAvmFN7aP/bkSE8HoJUuiIOCA/fJcvHOLMyaDmAW278HIquXNyTLb
 4a9s0q0vGa5nNMq+IDRFNRqxKbfN/FtDEpyj+CzPLKxH3YKpR/ViPvYYvQLWjAcDyJGy
 WQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354258; x=1696959058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MiKqpxzWJlU8GamjHXrloGQvl3H+1lN59n29xY6vQ3w=;
 b=hSEwO5t56TLwVYk5xrKzLUbCK9wysFZFoxrpRetFDxEEx5lQsRuNin1WMwVq1UXzjC
 YOXScvIzmMev/WxmayRyw3psM5owEVhZk5pfvRd7EfM+3UtyhvWNDDphhe9hho6LBbXO
 aBuSp19hqxMkwTya5Bo1FwSlP4T87k/6wAk6X7V8iBJ1ABM3cryHV5FdLy7N/zJ0pbfI
 F+poKuupLz6B2FKhf+RyObuLi+FIm7T4TKCpn10xFbdKJp2Tx1jBGMgHlgDPbwemz4nJ
 HWfqXorUDPKCcS6TTcl0fmWe9AWqeK3BICF5V0FEWWZgEeWLlk76RxzcqAK4UiJCDpqi
 0/qQ==
X-Gm-Message-State: AOJu0Yx0ZrWMHauJVUnp0h1bsNGKSDdsVytYhQGPDtQ7vd/hmx4Pstxr
 ArwbMVXwY+xISiBzXInoDZzAWLUolUFXlzlSMMo=
X-Google-Smtp-Source: AGHT+IGnMzum20IXGkfGP5Zf3iTcuaQgEP6n+1OEKUyzDl+rfAYaDieRXgAK5suPX+Yi8hB411s/Iw==
X-Received: by 2002:a05:6a21:78aa:b0:160:dacc:8ac with SMTP id
 bf42-20020a056a2178aa00b00160dacc08acmr4886885pzc.8.1696354257813; 
 Tue, 03 Oct 2023 10:30:57 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:30:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PULL 03/47] accel: Rename accel_cpu_realize() ->
 accel_cpu_common_realize()
Date: Tue,  3 Oct 2023 10:30:08 -0700
Message-Id: <20231003173052.1601813-4-richard.henderson@linaro.org>
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

accel_cpu_realize() is a generic function working with CPUs
from any target. Rename it using '_common_' to emphasis it is
not target specific.

Suggested-by: Claudio Fontana <cfontana@suse.de>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231003123026.99229-4-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.34.1


