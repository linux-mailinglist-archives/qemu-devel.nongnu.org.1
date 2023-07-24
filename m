Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A8075EE70
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 10:55:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNrJz-000240-D8; Mon, 24 Jul 2023 04:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNrJv-0001zz-DB
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:53:35 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNrJs-0000do-Od
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:53:35 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbc0609cd6so30298925e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 01:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690188811; x=1690793611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YIZ//uqvzyazKLUP5z3YoDBSBVlSC65GXHLWCWeqo2o=;
 b=Y68Q6yBpRe7nFafF/rtozIHScPn/vHIJoAv9oJAINzNRRnrlunbJ3TYW4iKlrcBrEN
 lDPR6Xlj5iGHc13D2/5Kh0RGkk30QV3ZmcL9cQzEZrZTd7gnn5pj7aAIyfb6bwR902qM
 zYIsYRUAbgnbD1kFU4PVIKYRlJWZx6J4+edK3UcBbbjj7FmxBVvQcY1Ifu7w4kKOwTdf
 ApHq8eIVvxBOc+7FaUNTGHUXdNMb/qbWJ6xYDmHjIzSIA2MX2iKNH/JRThi0jXKfhadt
 8tQs9V2lgGW+v8NqM/vAIqcBZLrvJnj3PiNiXL8yE7p/pqGQ1TRc2WUZMvw4EN7X2nys
 In8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690188811; x=1690793611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YIZ//uqvzyazKLUP5z3YoDBSBVlSC65GXHLWCWeqo2o=;
 b=f8v/4myeCXetE7njcIg4w62ZwGHL3Bhqe7ReNaC2zU8rePSgLXVrathVJNjE5pToKU
 WqNP+gZ8xz6CapIZD1zrbFzt4hKrgtTkhgZEO+aJyXAxQ7QDrrWMJFmH8B8TC56YEdHE
 YBAE27HHKVTkI2ixWUKqJ4/LnSMD06kSIlCgrqlKn/Rckxi+a5JyV7Nds8V0Bz+ZCY55
 PcLmgfIJT1q4Ri2nrK0VctHwCKetf69zNXu0W469aZFTeufqYQRTCZ2vOp9i1cg6c/73
 L+BxVO5rgICiKipxB9Wb/PxVDvjSZHjkBoIV76+/zNgtZYaI544r+MRI1zjtdvZKId0D
 xZfQ==
X-Gm-Message-State: ABy/qLZwVhF2YQMOw8aLtYMln+PgDUhHrOwMC1ZCTCfx8j3wQxSStq5I
 CATmJ8UvKXzmXGOvPHADf1CFaLCeXxGoyR+HjykJ4A==
X-Google-Smtp-Source: APBJJlFzkj57ozsaWpw2OqH6P5YqWg4RORHorfs8z15HE97//O+twRHiO3++lxyfRoBBSJJZ2FZQlQ==
X-Received: by 2002:a7b:ce0e:0:b0:3fa:934c:8360 with SMTP id
 m14-20020a7bce0e000000b003fa934c8360mr5658885wmc.8.1690188811407; 
 Mon, 24 Jul 2023 01:53:31 -0700 (PDT)
Received: from stoup.. ([62.252.144.58]) by smtp.gmail.com with ESMTPSA id
 t8-20020a1c7708000000b003fa74bff02asm9570994wmi.26.2023.07.24.01.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 01:53:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 2/7] include/exec: Add WITH_MMAP_LOCK_GUARD
Date: Mon, 24 Jul 2023 09:53:23 +0100
Message-Id: <20230724085328.4936-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724085328.4936-1-richard.henderson@linaro.org>
References: <20230724085328.4936-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 10 ++++++++++
 bsd-user/mmap.c         |  1 +
 linux-user/mmap.c       |  1 +
 3 files changed, 12 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 5fa0687cd2..d02517e95f 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -629,6 +629,15 @@ void TSA_NO_TSA mmap_lock(void);
 void TSA_NO_TSA mmap_unlock(void);
 bool have_mmap_lock(void);
 
+static inline void mmap_unlock_guard(void *unused)
+{
+    mmap_unlock();
+}
+
+#define WITH_MMAP_LOCK_GUARD()                                            \
+    for (int _mmap_lock_iter __attribute__((cleanup(mmap_unlock_guard)))  \
+         = (mmap_lock(), 0); _mmap_lock_iter == 0; _mmap_lock_iter = 1)
+
 /**
  * adjust_signal_pc:
  * @pc: raw pc from the host signal ucontext_t.
@@ -683,6 +692,7 @@ G_NORETURN void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
 #else
 static inline void mmap_lock(void) {}
 static inline void mmap_unlock(void) {}
+#define WITH_MMAP_LOCK_GUARD()
 
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
 void tlb_set_dirty(CPUState *cpu, vaddr addr);
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index aca8764356..74ed00b9fe 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -32,6 +32,7 @@ void mmap_lock(void)
 
 void mmap_unlock(void)
 {
+    assert(mmap_lock_count > 0);
     if (--mmap_lock_count == 0) {
         pthread_mutex_unlock(&mmap_mutex);
     }
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 44b53bd446..a5dfb56545 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -36,6 +36,7 @@ void mmap_lock(void)
 
 void mmap_unlock(void)
 {
+    assert(mmap_lock_count > 0);
     if (--mmap_lock_count == 0) {
         pthread_mutex_unlock(&mmap_mutex);
     }
-- 
2.34.1


