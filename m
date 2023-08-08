Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 091687737D5
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 06:21:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTECs-0006TA-P2; Tue, 08 Aug 2023 00:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTECp-0006LQ-B4; Tue, 08 Aug 2023 00:20:27 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTECn-0007ck-LY; Tue, 08 Aug 2023 00:20:27 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3a37909a64eso3643823b6e.1; 
 Mon, 07 Aug 2023 21:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691468424; x=1692073224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMSPw1YJzvyEAaF+rCTAxiMhu0TUhZrG1Yi0ZviLL+w=;
 b=bwvMhkoYYB+xWB4twPpgGGAff2eP3cAP7bB8zhWv26M7BHmBmwtkXCFy+VEXkzpdDq
 ttRatqxhnT29I/DFCz9SLi09//AsQVT0de8/wAuJlgTC4LAFQ0vcL0C6ysnuMGnpixcR
 xd4c8BBe8zg2UWanw7rWD+htAoITclSol40PKwk7LwzeFLpI2I7f5mI2V2Qhx4+WK9Ta
 kwx87jGE/fYEl2PcRzxw9QTmwRX1CBHZi7PmSADpi3iJ9PaBYVVvMxdsQH+pSQM4CAAd
 bmnGZFxVMwFHVXCbU7KPaT9EWc4ufd67gFdL9QdEqp+OGAbH/gzRx6zghXENl7wxjB5x
 CzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691468424; x=1692073224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GMSPw1YJzvyEAaF+rCTAxiMhu0TUhZrG1Yi0ZviLL+w=;
 b=XOocV5teynB74X7qisnDSVFrZFxMmYq+tQCUpMIURoOfU67kM7yUM/L3ttCtfdzL3V
 nTYbkOvXf6b9jNjKVTG0/ONfrWSM3p5lhBrtpFEe9Adxrdit/JHUpJ4ZcVdwt/1hbuyt
 laP+4hLv+6MUZReOhSiMogm8imuHUaIep0M8XBwSgPyGY9NAx4lEnsNjF0uJkucdrnyH
 ez3QqRDvzHmq5XparJ6i1ZLFB5eN5FimVBiN0WYFiCcmWmrYnHemZT/pyRwGJ1u3zMTx
 va+IdwExDfZJckA3iOFCk50Lz4bqKG6yd/QLb/KXzYSQY8/tg736wtbeqc0Z3/CrMo/V
 Zzhg==
X-Gm-Message-State: AOJu0YxUN7QBMKtT4S++UYFW3i2ALN9CM4AEyxtvIxkTt08o05mZ7GG5
 DCt2GlZQR/a9/y9+VV7DH58=
X-Google-Smtp-Source: AGHT+IH24Iv1u29suC0RjAdzpxIBr8U8FJdOK5z5gmnC3Qxyd7H6pGf9xs9+G3JtH8liSa49TuUY0g==
X-Received: by 2002:a05:6808:3090:b0:3a7:3100:f8b9 with SMTP id
 bl16-20020a056808309000b003a73100f8b9mr13914274oib.31.1691468423940; 
 Mon, 07 Aug 2023 21:20:23 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6979207pfb.33.2023.08.07.21.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 21:20:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 03/19] hw/ppc/ppc.c: Tidy over-long lines
Date: Tue,  8 Aug 2023 14:19:45 +1000
Message-Id: <20230808042001.411094-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808042001.411094-1-npiggin@gmail.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 0e0a3d93c3..09b82f68a8 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -497,7 +497,8 @@ uint64_t cpu_ppc_load_tbl (CPUPPCState *env)
         return env->spr[SPR_TBL];
     }
 
-    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->tb_offset);
+    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        tb_env->tb_offset);
     trace_ppc_tb_load(tb);
 
     return tb;
@@ -508,7 +509,8 @@ static inline uint32_t _cpu_ppc_load_tbu(CPUPPCState *env)
     ppc_tb_t *tb_env = env->tb_env;
     uint64_t tb;
 
-    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->tb_offset);
+    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        tb_env->tb_offset);
     trace_ppc_tb_load(tb);
 
     return tb >> 32;
@@ -565,7 +567,8 @@ uint64_t cpu_ppc_load_atbl (CPUPPCState *env)
     ppc_tb_t *tb_env = env->tb_env;
     uint64_t tb;
 
-    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->atb_offset);
+    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        tb_env->atb_offset);
     trace_ppc_tb_load(tb);
 
     return tb;
@@ -576,7 +579,8 @@ uint32_t cpu_ppc_load_atbu (CPUPPCState *env)
     ppc_tb_t *tb_env = env->tb_env;
     uint64_t tb;
 
-    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->atb_offset);
+    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        tb_env->atb_offset);
     trace_ppc_tb_load(tb);
 
     return tb >> 32;
@@ -1040,10 +1044,11 @@ clk_setup_cb cpu_ppc_tb_init (CPUPPCState *env, uint32_t freq)
         tb_env->flags |= PPC_DECR_UNDERFLOW_LEVEL;
     }
     /* Create new timer */
-    tb_env->decr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &cpu_ppc_decr_cb, cpu);
+    tb_env->decr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                      &cpu_ppc_decr_cb, cpu);
     if (env->has_hv_mode && !cpu->vhyp) {
-        tb_env->hdecr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &cpu_ppc_hdecr_cb,
-                                                cpu);
+        tb_env->hdecr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                           &cpu_ppc_hdecr_cb, cpu);
     } else {
         tb_env->hdecr_timer = NULL;
     }
-- 
2.40.1


