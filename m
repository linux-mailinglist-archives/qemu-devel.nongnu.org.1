Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AEF7E2073
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:53:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzy2r-0002EN-RG; Mon, 06 Nov 2023 06:45:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy2i-00028b-8R
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:45:26 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy2g-00056H-HX
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:45:20 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4084de32db5so38525485e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699271117; x=1699875917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQYHw6k/VszA0YDIuQME8N6TDwm343Fq2i1eGs6ZHqM=;
 b=NB7lmMhO6jLP5SC1OI42zvrjro/VbM33tncHEY2i76bIrJis4z+kKRJ5FZ9DfY3Mnz
 H8BmA4a6DgsLILzKXAPQvbVj0Zyupbyo2bU9du0bbJTyfaUCac4etmICSuoljostYQ9T
 NEA/f0goXH9ArioCHeF090O3myVXlolk2DdDgZDL4ekTzjWf9HC8LJWZIzP7y575hLmG
 B8jx9d1CQaMrfblIrhuh0qdxzTzqw168OS0PTGRvX1iIPdnPDvnDVOEqxztXN5l4YJ+2
 rh+f6g9rk6IzTWlhIH9bA8lrW8j0FMKcwbvi2ZDwzN9e+wmTw4lsfmB75AaPz6oWqlf0
 /1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699271117; x=1699875917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQYHw6k/VszA0YDIuQME8N6TDwm343Fq2i1eGs6ZHqM=;
 b=WQEysMOCoLdGxVq8TP1VcPnIGRS+bDWeZp7FgqFgQt564HREnqZOEIdDGPLgNKw0YN
 ORlGu7pzixaUjPFsa+TtZt7fQc/0zSM43jMIIf9jR5hkSZAhAh0vqT3oVANFyBrr0ZqJ
 lAHYRym+X33z3nKptY33daBBiX+TcZ0wKDL5U/rgJscXHBBK+m7bBsKfFSo7XozvNmCC
 4RioTY5arckwDzqOnSlooIMny4WSMnt0pU+ilB1DJgo4HJG7jG29sDoFw1x0Ybk4iBUW
 /bNoHgGoT5RsnvQkmOpuYgNfk1lQQ5NqrvFFvKQ3DiuJVwPP3QA33Yy+XazF+Ka/tI0t
 V0ug==
X-Gm-Message-State: AOJu0YwjVaozCpiOvPAGDP0Hbw7/Ld2fIctnxm6zQ0UWNKXsORtHNK72
 f4ynGUIXEDsaZundN5cDLURveLUGGDdhhKSGmzk=
X-Google-Smtp-Source: AGHT+IF3Wb4GFoFFyR+kHUAmBXNCHeDbfwb485B/LlLMS6LnZ+SQ2AxDLSqZ2SfmsSotO7OaslRyHg==
X-Received: by 2002:a05:600c:c0f:b0:409:5d7d:b26d with SMTP id
 fm15-20020a05600c0c0f00b004095d7db26dmr12085647wmb.15.1699271116243; 
 Mon, 06 Nov 2023 03:45:16 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a05600010cf00b00318147fd2d3sm9172759wrx.41.2023.11.06.03.45.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:45:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] hw/s390x/sclp: Have sclp_service_call[_protected]() take
 S390CPU*
Date: Mon,  6 Nov 2023 12:44:57 +0100
Message-ID: <20231106114500.5269-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106114500.5269-1-philmd@linaro.org>
References: <20231106114500.5269-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
---
 include/hw/s390x/sclp.h        | 5 ++---
 hw/s390x/sclp.c                | 7 ++++---
 target/s390x/kvm/kvm.c         | 2 +-
 target/s390x/tcg/misc_helper.c | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

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
index 1ddad0bec1..a12fbfc026 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1174,7 +1174,7 @@ static void kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
         break;
     case ICPT_PV_INSTR:
         g_assert(s390_is_pv());
-        sclp_service_call_protected(env, sccb, code);
+        sclp_service_call_protected(cpu, sccb, code);
         /* Setting the CC is done by the Ultravisor. */
         break;
     case ICPT_INSTRUCTION:
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


