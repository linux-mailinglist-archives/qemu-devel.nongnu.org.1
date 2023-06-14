Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CCA72F1E5
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:30:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FFH-0005Ti-Iv; Tue, 13 Jun 2023 21:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FFB-00058T-EW
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:24:17 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FF9-00050S-Sr
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:24:17 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-65131e85be4so6522646b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705854; x=1689297854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ac20LFmXL8HuYi2oBFFDUu/CaFPERY9NXCV3ni6LgxM=;
 b=PMDeaXaO4ASSAoBkzVWCsefma0fL2ud69wEN4YZFGOcQSgmjyGKmLIyO7ngZ8meQAl
 dZDxVSdVfFmfgm9PRI3gJ8TBOqVkUD4TZcCtC/7so8z4lpH3XqsSOP0TzTAoE+1y8Es2
 n7jqJlLOKnusfR4Pt5czYu9GKGqdgY3+GzdaDuf9mHFHphgblxi5Y/VMF04GLUNf2eNf
 BbE0LzLnFtSy/pVGLpOiIoMrZkz0WjfFu0gl06aqfSy+/oVeUN92wUIp4pThVwKKiWqa
 /A6Bty8rVZCtSr50GHt/KTzaB40I3pjP1jOHpqE5RJVrIqvJyYBt3KfOBdlcR9APuYz5
 eMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705854; x=1689297854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ac20LFmXL8HuYi2oBFFDUu/CaFPERY9NXCV3ni6LgxM=;
 b=kiQcyfXKqd3R98kSBp/6duB6jKNT/s+Id8mq9IARlmY9ZDhy7KaCiRk+iOQLTKPZeK
 cWIa9pGyjLnT9E08WKYymsG8rZbBKwJEDyMXP2idzGK3h2q50VSYCgd+YsCxe9SOIu2t
 SAkkjz5hJTsMCdPe6T/7a9F5HTWTa+P33eor15qDWxvzjJuy7eWmyh0rBzt3Dc3Gk0x1
 reQndfk6spM5XBDOaTJIYtYWtrFpCAQ4tzQ9xAvVkRHcuYTzrnQdkfBjfllE+nbbNZEr
 XpfbEf6kwJQA/sEbF5L0pulmIJPWV/vmBlzBO4lpxeObagZao+ZUwZz+n1C0CgrDdqRw
 w9Ug==
X-Gm-Message-State: AC+VfDzai0gc7S5SwD8xlqy+0cEc4aNv6aRSRa3CFsblHKopdA9X29hG
 8bclFzSeLeS/++psygTBaHkSdA9xSks42A==
X-Google-Smtp-Source: ACHHUZ7CDq1VXAswMFnR5zTL3r5sXMgh0bzAN7fFW2y5ZVGaNeYmbRrNP2uxUFlgSwP302UHAeKAGw==
X-Received: by 2002:a05:6a00:238d:b0:663:5fbe:c695 with SMTP id
 f13-20020a056a00238d00b006635fbec695mr636655pfc.16.1686705854022; 
 Tue, 13 Jun 2023 18:24:14 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:24:13 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Ivan Klokov <ivan.klokov@syntacore.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 55/60] util/log: Add vector registers to log
Date: Wed, 14 Jun 2023 11:20:12 +1000
Message-Id: <20230614012017.3100663-56-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Ivan Klokov <ivan.klokov@syntacore.com>

Added QEMU option 'vpu' to log vector extension registers such as gpr\fpu.

Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230410124451.15929-2-ivan.klokov@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/core/cpu.h | 2 ++
 include/qemu/log.h    | 1 +
 accel/tcg/cpu-exec.c  | 3 +++
 util/log.c            | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 383456d1b3..d84fbccaab 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -544,11 +544,13 @@ GuestPanicInformation *cpu_get_crash_info(CPUState *cpu);
  * @CPU_DUMP_CODE:
  * @CPU_DUMP_FPU: dump FPU register state, not just integer
  * @CPU_DUMP_CCOP: dump info about TCG QEMU's condition code optimization state
+ * @CPU_DUMP_VPU: dump VPU registers
  */
 enum CPUDumpFlags {
     CPU_DUMP_CODE = 0x00010000,
     CPU_DUMP_FPU  = 0x00020000,
     CPU_DUMP_CCOP = 0x00040000,
+    CPU_DUMP_VPU  = 0x00080000,
 };
 
 /**
diff --git a/include/qemu/log.h b/include/qemu/log.h
index c5643d8dd5..df59bfabcd 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -35,6 +35,7 @@ bool qemu_log_separate(void);
 /* LOG_STRACE is used for user-mode strace logging. */
 #define LOG_STRACE         (1 << 19)
 #define LOG_PER_THREAD     (1 << 20)
+#define CPU_LOG_TB_VPU     (1 << 21)
 
 /* Lock/unlock output. */
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 42086525d7..ebc1db03d7 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -313,6 +313,9 @@ static void log_cpu_exec(target_ulong pc, CPUState *cpu,
 #if defined(TARGET_I386)
                 flags |= CPU_DUMP_CCOP;
 #endif
+                if (qemu_loglevel_mask(CPU_LOG_TB_VPU)) {
+                    flags |= CPU_DUMP_VPU;
+                }
                 cpu_dump_state(cpu, logfile, flags);
                 qemu_log_unlock(logfile);
             }
diff --git a/util/log.c b/util/log.c
index 53b4f6c58e..def88a9402 100644
--- a/util/log.c
+++ b/util/log.c
@@ -495,6 +495,8 @@ const QEMULogItem qemu_log_items[] = {
       "log every user-mode syscall, its input, and its result" },
     { LOG_PER_THREAD, "tid",
       "open a separate log file per thread; filename must contain '%d'" },
+    { CPU_LOG_TB_VPU, "vpu",
+      "include VPU registers in the 'cpu' logging" },
     { 0, NULL, NULL },
 };
 
-- 
2.40.1


