Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 851DC7A23A4
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:33:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBkc-0008FO-LM; Fri, 15 Sep 2023 12:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBka-0008Ee-Sc
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:33:00 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBkZ-00037L-7W
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:33:00 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68fb79ef55eso2137444b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694795578; x=1695400378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJ6Oywpvjr1xG7Guou9tEnbUmyP3OUnn4VhCnCRzKJY=;
 b=BoHXb9ezG57eYc6uny9thtZ+GyAvtvLAWsvuG7K3IA6JdWWE8iYKOcpa3pwq5uBKKU
 xTRtw9WvIQlADM1orag8E9Gd18zaPELz5PJ/vm7qYzat/ZqkxV5Wy2dWF7Fkpls/YN69
 eQIGbbWTBQCPKOWGB+XNKW4k6XYgMIU+dxIjgOKHrIcYxq2JMy18jbL7xTscPfoOQD0N
 C5FvXKdkXQZLes3a3hg6C9wHtVHUsc74UGJLatmcToDl1CVCgiV2mWS8M322t/YXK7T8
 89Uj22CyPNgETbdrwT3qhn2jYgH32Dx3jId9TSFMlCNOT88Q+MnehVGSTWI5w1qPRKV+
 RA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694795578; x=1695400378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iJ6Oywpvjr1xG7Guou9tEnbUmyP3OUnn4VhCnCRzKJY=;
 b=gb4vYcHghb+K3wppA3VaK4RR4241nCam3uJm99q6yV+4aGxqJRjeTz17N05rDQjPcu
 AH0hJnRd2hHN7zkhCEYyIb+nRyRrpeFIR11VJRhv3SswcIzt2WxwA1fqCQngvl57S1Tm
 F875PsUObkAxRk3YC6TVAPtG3FqwXInFT3wPn2Df+IUfoPBpqYgt/Wstv8MnXjO4Tb+Z
 +G1Rjf54x3VDhgUx2pKkB4KbkTOgtN3pTT2VfncQC35EJAU6z2pxUnL6PwKb4vSdN7It
 RWQBgsY56XZgyZACJxFmPgzly4ox4ZRM0Te5IvyvpCGEPm7+RMYULalZ/XxlwAeMvMma
 YbVw==
X-Gm-Message-State: AOJu0YxX28T++bMEPxNf7t4UEwa2gT9fTqd19dMRo05ARAfO5p94hFjg
 0/bCi7pqI+ekJoGw2kjVI+uLnpoA0rBZBi0Cz+E=
X-Google-Smtp-Source: AGHT+IHmBWeoqa475C9Bo6s5X6vPH5xf3QnpRGzSFb+/ImQCwZ/mfNMX1sfgbdg61SmgMpulVGHWjA==
X-Received: by 2002:a05:6a21:18d:b0:129:d944:2e65 with SMTP id
 le13-20020a056a21018d00b00129d9442e65mr3105614pzb.13.1694795577935; 
 Fri, 15 Sep 2023 09:32:57 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 z3-20020a637e03000000b0057754ae4eb7sm2958497pgc.39.2023.09.15.09.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:32:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 2/3] softmmu: Introduce AddressSpaceDispatch generation
 numbers
Date: Fri, 15 Sep 2023 09:32:53 -0700
Message-Id: <20230915163254.123338-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915163254.123338-1-richard.henderson@linaro.org>
References: <20230915163254.123338-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Allow the cpu to easily check if an address space update
is required.  The acquire/release semantics will be used
by a subsequent patch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 softmmu/physmem.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 88fafec1da..e1c535380a 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -163,6 +163,8 @@ struct CPUAddressSpace {
     AddressSpace *as;
     struct AddressSpaceDispatch *memory_dispatch;
     MemoryListener tcg_as_listener;
+    uint32_t commit_gen;
+    uint32_t layout_gen;
 };
 
 struct DirtyBitmapSnapshot {
@@ -2486,14 +2488,23 @@ static void tcg_log_global_after_sync(MemoryListener *listener)
     }
 }
 
-static void tcg_commit_cpu(CPUState *cpu, run_on_cpu_data data)
+static void tcg_commit_cpu_0(CPUState *cpu, CPUAddressSpace *cpuas)
 {
-    CPUAddressSpace *cpuas = data.host_ptr;
-
     cpuas->memory_dispatch = address_space_to_dispatch(cpuas->as);
     tlb_flush(cpu);
 }
 
+static void tcg_commit_cpu_1(CPUState *cpu, run_on_cpu_data data)
+{
+    CPUAddressSpace *cpuas = data.host_ptr;
+    uint32_t gen = qatomic_load_acquire(&cpuas->layout_gen);
+
+    if (cpuas->commit_gen != gen) {
+        cpuas->commit_gen = gen;
+        tcg_commit_cpu_0(cpu, cpuas);
+    }
+}
+
 static void tcg_commit(MemoryListener *listener)
 {
     CPUAddressSpace *cpuas;
@@ -2518,9 +2529,10 @@ static void tcg_commit(MemoryListener *listener)
      * all of the tcg machinery for run-on is initialized: thus created.
      */
     if (cpu->created) {
-        async_run_on_cpu(cpu, tcg_commit_cpu, RUN_ON_CPU_HOST_PTR(cpuas));
+        qatomic_store_release(&cpuas->layout_gen, cpuas->layout_gen + 1);
+        async_run_on_cpu(cpu, tcg_commit_cpu_1, RUN_ON_CPU_HOST_PTR(cpuas));
     } else {
-        tcg_commit_cpu(cpu, RUN_ON_CPU_HOST_PTR(cpuas));
+        tcg_commit_cpu_0(cpu, cpuas);
     }
 }
 
-- 
2.34.1


