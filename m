Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E357E3D90
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 13:29:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0LAQ-0007mi-7y; Tue, 07 Nov 2023 07:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0L9d-0006Fs-CN
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:26:05 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0L9F-000569-Il
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:25:58 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507be298d2aso7219217e87.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 04:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699359933; x=1699964733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8o7ytDCjKPudtYHMOoHYjJ8HM4/zixXAYrUBK2BQdgM=;
 b=nc0BarosaU0NSxT4zMtZjHrYtSGaQ4zzCHt8yg2ph+BryxA+M+vH9eYyDbAoubWcau
 6wIU1S149pXAOAFeWY9Cd47TwicCXMAYxnGE26K2TOCDs8X/TdVxHRxT31lhl77V0FHE
 A+h+8wz9zSlztWW2V7p2ZtIZXQ09OUa/Q82Q66fxkEkXEeIzfnSyKGS8cbDyG32UywZU
 27Gbf2mlFntL6gIXRxHEMxRAiNJ1Kw+G+gL27+Q0vFuFCNSk6IBYQigi6S1+FFg5LYSn
 D0fXwa1maX5sfrRlu5EUe8RlSYnto0IJe381Mp4X5h5Gnu3cw9wTHcfAjQ6HTv8cqc51
 Zr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699359933; x=1699964733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8o7ytDCjKPudtYHMOoHYjJ8HM4/zixXAYrUBK2BQdgM=;
 b=oeHC+pM2zymUAKQsK2dnRdj37kqZLPofCqD55mI9vRfDIPyNqTZy1B6ZNZfS0uHK+X
 3NvtZ/FUSGtPhdHKCPQ+L9Oz085hJkx4aacw61OucSW6lOZQQhnxJ5AxoCdNU7bwyzUH
 wjMabsPKOagsJgofeHj+BIKemYAiSOl0pccPclesg9PDJIPzN/3jDxHQ8i8jfE1eC9aI
 Jpkk8l8REl4cNH6S3AFXqLPOrzHFSozPrzXiEi8NrFweWhLiXKp9/MCyLNaxBkikL5bw
 AMYos5ZA571pN/jk3P35/NLyIfqNElVBZ7FyllEmX6+OoMtexPawEfmBRZvMA5oNHdzU
 Q+9g==
X-Gm-Message-State: AOJu0YyC4S3Lgk/CuZfzmybJoK95wor3PfOqoDQWB5qBDTgTwvva1HAV
 Z9MBHBYmeHG2+6RjrMfkzLTrzIT0BLqKbViS7D0=
X-Google-Smtp-Source: AGHT+IFWK6Tiib/6nhHwdK6AXlabtxBardlSDnfGQHnH6M47ZWo2aHc2dbBQmwAKkCO3w2qJpJdjzA==
X-Received: by 2002:ac2:43c9:0:b0:508:e4b1:a785 with SMTP id
 u9-20020ac243c9000000b00508e4b1a785mr21695079lfl.62.1699359933183; 
 Tue, 07 Nov 2023 04:25:33 -0800 (PST)
Received: from m1x-phil.lan ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 r22-20020a05600c35d600b003fee567235bsm15654110wmq.1.2023.11.07.04.25.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Nov 2023 04:25:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 43/75] hw/s390x/sclp: Have sclp_service_call[_protected]() take
 S390CPU*
Date: Tue,  7 Nov 2023 13:24:33 +0100
Message-ID: <20231107122442.58674-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107122442.58674-1-philmd@linaro.org>
References: <20231107122442.58674-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

"hw/s390x/sclp.h" is a header used by target-agnostic objects
(such hw/char/sclpconsole[-lm].c), thus can not use target-specific
types, such CPUS390XState.

Have sclp_service_call[_protected]() take a S390CPU pointer, which
is target-agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231106114500.5269-3-philmd@linaro.org>
---
 include/hw/s390x/sclp.h        | 5 ++---
 hw/s390x/sclp.c                | 7 ++++---
 target/s390x/kvm/kvm.c         | 4 ++--
 target/s390x/tcg/misc_helper.c | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index 9aef6d9370..e229b81a67 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -227,8 +227,7 @@ static inline int sccb_data_len(SCCB *sccb)
 void s390_sclp_init(void);
 void sclp_service_interrupt(uint32_t sccb);
 void raise_irq_cpu_hotplug(void);
-int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
-int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
-                                uint32_t code);
+int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code);
+int sclp_service_call_protected(S390CPU *cpu, uint64_t sccb, uint32_t code);
 
 #endif
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index d339cbb7e4..893e71a41b 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -269,9 +269,9 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
  * service_interrupt call.
  */
 #define SCLP_PV_DUMMY_ADDR 0x4000
-int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
-                                uint32_t code)
+int sclp_service_call_protected(S390CPU *cpu, uint64_t sccb, uint32_t code)
 {
+    CPUS390XState *env = &cpu->env;
     SCLPDevice *sclp = get_sclp_device();
     SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
     SCCBHeader header;
@@ -296,8 +296,9 @@ out_write:
     return 0;
 }
 
-int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
+int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
 {
+    CPUS390XState *env = &cpu->env;
     SCLPDevice *sclp = get_sclp_device();
     SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
     SCCBHeader header;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 1ddad0bec1..33ab3551f4 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1174,12 +1174,12 @@ static void kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
         break;
     case ICPT_PV_INSTR:
         g_assert(s390_is_pv());
-        sclp_service_call_protected(env, sccb, code);
+        sclp_service_call_protected(cpu, sccb, code);
         /* Setting the CC is done by the Ultravisor. */
         break;
     case ICPT_INSTRUCTION:
         g_assert(!s390_is_pv());
-        r = sclp_service_call(env, sccb, code);
+        r = sclp_service_call(cpu, sccb, code);
         if (r < 0) {
             kvm_s390_program_interrupt(cpu, -r);
             return;
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 56c7f00cf9..6aa7907438 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -102,7 +102,7 @@ uint64_t HELPER(stck)(CPUS390XState *env)
 uint32_t HELPER(servc)(CPUS390XState *env, uint64_t r1, uint64_t r2)
 {
     qemu_mutex_lock_iothread();
-    int r = sclp_service_call(env, r1, r2);
+    int r = sclp_service_call(env_archcpu(env), r1, r2);
     qemu_mutex_unlock_iothread();
     if (r < 0) {
         tcg_s390_program_interrupt(env, -r, GETPC());
-- 
2.41.0


