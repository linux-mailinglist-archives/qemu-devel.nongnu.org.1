Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 720EE803E99
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 20:42:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAEoI-0005RD-7k; Mon, 04 Dec 2023 14:40:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAEoA-0005M0-G7
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 14:40:49 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAEo8-0000SI-Di
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 14:40:46 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40c032962c5so30423325e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 11:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701718842; x=1702323642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=14EOn/NO7w4OooejbiwleYHqjjs9Ad124VSgwVmol90=;
 b=JbI76pvOSg7lkOprQeJzhzwdmasPqLpNd0B8bQ9KOXsYH3KuZzeEInF/reFMB3BqV2
 wXDcePSB1L6kWp+3zKyfhPq1sceJXSlgcG1l6eqH1oWRFuEFVX2NBKjL+wRoYGQNCuat
 FJ9ne8Sjxi33KWsAzv29v+mZuaHYejHppyME4tbyIjJenB1cI+SVSu3SXn27pU8mqt9l
 vZ5TRNU6Vu/wYbZ/d8i4WTtMu03yNVlu/K9zDlcz8yup//NAkEY57ZQcxMYKSi9sjbxU
 M06ll2SmXPh0cGrNUg3a0+8CW+bcOCVLBj0c7CEVF4X/EVKjVXjogFworciSUCKo0nl1
 PycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701718842; x=1702323642;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=14EOn/NO7w4OooejbiwleYHqjjs9Ad124VSgwVmol90=;
 b=eiTCG8qNzdscFEgwq58t83TkTuO/cV2QDqH+MIEU+QfAf5wSCQK6a3gpaGw+VHteNP
 wLwIA8rS7wfrVIp3nFTJULOf2rGW3yTtfczuX/X6VCU41Cqz9Lz5i/7c1Vaiq/M67SDM
 JrSIMoyAgs/2ik2MqKDX89O9J6LC7gJ5vhxWKuF2p6U2PtDTdN28pfTOeKrcJCCq9bDV
 zKr5fbumSIjwx+ptRihnPMoP+qcA7y6sVWDpDUH34Y7pCuT7r/Au2c1rW9LTKTdoP6+l
 UjfmOlKI9y6pA5Ng1IjaogTxz8C66Jbi8rQzS/8cVwyV4vGzby83W+RXVCb8BA2HLN3c
 jrrw==
X-Gm-Message-State: AOJu0YzUX5b/DQ6zcpxrvEu9BM3GcHhn4UqpCHgOYPLUeo9asIKBFHT5
 Iz70Z8IASJUeUatfro79bEy326BHTrAvAuBQ2lM=
X-Google-Smtp-Source: AGHT+IEsRUSPBOoDNP8Mp9FdsvA6sZOjl24+mQrm6Zpqg/jD+0e0X9AsjK8HDCvYyU56KJEJcQJw+A==
X-Received: by 2002:a5d:480f:0:b0:333:2fd2:3c02 with SMTP id
 l15-20020a5d480f000000b003332fd23c02mr2588460wrq.187.1701718842455; 
 Mon, 04 Dec 2023 11:40:42 -0800 (PST)
Received: from m1x-phil.lan ([176.176.140.35])
 by smtp.gmail.com with ESMTPSA id
 w12-20020a5d680c000000b003333e09990dsm6688458wru.8.2023.12.04.11.40.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Dec 2023 11:40:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Stefan Hajnoczi <stefanha@gmail.com>
Subject: [RFC PATCH-for-8.2?] accel/tcg: Implement tcg_unregister_thread()
Date: Mon,  4 Dec 2023 20:40:39 +0100
Message-ID: <20231204194039.56169-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Unplugging vCPU triggers the following assertion in
tcg_register_thread():

 796 void tcg_register_thread(void)
 797 {
 ...
 812     /* Claim an entry in tcg_ctxs */
 813     n = qatomic_fetch_inc(&tcg_cur_ctxs);
 814     g_assert(n < tcg_max_ctxs);

Implement and use tcg_unregister_thread() so when a
vCPU is unplugged, the tcg_cur_ctxs refcount is
decremented.

Reported-by: Michal Suchánek <msuchanek@suse.de>
Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: untested
Report: https://lore.kernel.org/qemu-devel/20231204183638.GZ9696@kitsune.suse.cz/
---
 include/tcg/startup.h           |  5 +++++
 accel/tcg/tcg-accel-ops-mttcg.c |  1 +
 accel/tcg/tcg-accel-ops-rr.c    |  1 +
 tcg/tcg.c                       | 17 +++++++++++++++++
 4 files changed, 24 insertions(+)

diff --git a/include/tcg/startup.h b/include/tcg/startup.h
index f71305765c..520942a4a1 100644
--- a/include/tcg/startup.h
+++ b/include/tcg/startup.h
@@ -45,6 +45,11 @@ void tcg_init(size_t tb_size, int splitwx, unsigned max_cpus);
  */
 void tcg_register_thread(void);
 
+/**
+ * tcg_unregister_thread: Unregister this thread with the TCG runtime
+ */
+void tcg_unregister_thread(void);
+
 /**
  * tcg_prologue_init(): Generate the code for the TCG prologue
  *
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index fac80095bb..88d7427aad 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -120,6 +120,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
 
     tcg_cpus_destroy(cpu);
     qemu_mutex_unlock_iothread();
+    tcg_unregister_thread();
     rcu_remove_force_rcu_notifier(&force_rcu.notifier);
     rcu_unregister_thread();
     return NULL;
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 611932f3c3..c2af3aad21 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -302,6 +302,7 @@ static void *rr_cpu_thread_fn(void *arg)
         rr_deal_with_unplugged_cpus();
     }
 
+    tcg_unregister_thread();
     rcu_remove_force_rcu_notifier(&force_rcu);
     rcu_unregister_thread();
     return NULL;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d2ea22b397..5125342d70 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -781,11 +781,18 @@ static void alloc_tcg_plugin_context(TCGContext *s)
  * modes.
  */
 #ifdef CONFIG_USER_ONLY
+
 void tcg_register_thread(void)
 {
     tcg_ctx = &tcg_init_ctx;
 }
+
+void tcg_unregister_thread(void)
+{
+}
+
 #else
+
 void tcg_register_thread(void)
 {
     TCGContext *s = g_malloc(sizeof(*s));
@@ -814,6 +821,16 @@ void tcg_register_thread(void)
 
     tcg_ctx = s;
 }
+
+void tcg_unregister_thread(void)
+{
+    unsigned int n;
+
+    n = qatomic_fetch_dec(&tcg_cur_ctxs);
+    g_free(tcg_ctxs[n]);
+    qatomic_set(&tcg_ctxs[n], NULL);
+}
+
 #endif /* !CONFIG_USER_ONLY */
 
 /* pool based memory allocation */
-- 
2.41.0


