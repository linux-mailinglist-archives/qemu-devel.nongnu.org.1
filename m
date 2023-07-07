Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2D074B016
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:44:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjgc-0001r3-Gw; Fri, 07 Jul 2023 07:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgZ-0001pr-6j; Fri, 07 Jul 2023 07:31:39 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgU-0006Ub-6o; Fri, 07 Jul 2023 07:31:38 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1b06ea7e7beso1760661fac.0; 
 Fri, 07 Jul 2023 04:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729491; x=1691321491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FgKKBWxZMCJRKCaR8JiHD05/gWc9p7lXQhJ7yvY3HXE=;
 b=B6MX/I3RHcbFLvPvsarUYSSQ9KjcAsJzfd8ZGfNaYfvIWCdOIiU5+1KEYx1xczj5OY
 8vJrvThycAIbYKacf5VxtKswxWxUrAqA6zPIZxEe+KqB12yKBpB5aKosSHkseIvnhREu
 wIWtuG7RV/h+o02/nAsV7sEqruUp/F2T26b0tOAsX0fOY1fazCctEO3xut/8sytgkm4i
 hv2RyEcP92WUxUxEkaL6iKSndWoiEiWl3NcJbWrnkUC2Q+BkvNYVkH0pGlM8iEAgvo2c
 +GgATnqgDQwOb19vu2Jd81ET2NWq3jMmEJTdQ8XTqPnebWW3aWO6bTSHdqFhXWRhsC3f
 /ZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729491; x=1691321491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FgKKBWxZMCJRKCaR8JiHD05/gWc9p7lXQhJ7yvY3HXE=;
 b=A65foVWR6eaRXuqEBwLteOrWeJFZhw2q36frLweR5I01rcvfOn8RwrLqPKU6SJWe1x
 SaY1dBQ2V3C5tfxSGoH3u3f+A/vuutFG2qrgzQuuj5Nq3nSlq9OTKsiLxUIu4qRwSvDQ
 MUAKLlvbH1Gc74R59mP5x/BxZau+JzLcK/8/BHIXtV/RECZASpsan1T44ByHLK1q2z1i
 e9ekY/CrVTrJ/Ozr/57UHMG88FPimS3PPkR/hTJKFCpynrOxpJWvdSrjEn+oNCOktArW
 sGVpSELniJetUV5LTQsvlmj0ZrLQ6cHHqRehWvurTgfywXljv8DYE39CLSGTWVFde1OV
 ZTew==
X-Gm-Message-State: ABy/qLZx6UFindwx2zeD9Q3iMu4Ox0HRwVRye9gachdUWfVbupcwPR2y
 TotPCBRQrKf2d9rwiR6iDhmwv2alppg=
X-Google-Smtp-Source: APBJJlGJEAiLoV+NJ/eNhMCBHHZJhXrvH645LNfSaVONd9uY5nvyKBXx0z564kXB3asKp8zj7Ivltg==
X-Received: by 2002:a05:6870:63a9:b0:1ad:3204:1d4b with SMTP id
 t41-20020a05687063a900b001ad32041d4bmr6517772oap.22.1688729491263; 
 Fri, 07 Jul 2023 04:31:31 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:31:31 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>
Subject: [PULL 03/60] hw/ppc: Fix clock update drift
Date: Fri,  7 Jul 2023 08:30:11 -0300
Message-ID: <20230707113108.7145-4-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

The clock update logic reads the clock twice to compute the new clock
value, with a value derived from the later time subtracted from a value
derived from the earlier time. The delta causes time to be lost.

This can ultimately result in time becoming unsynchronized between CPUs
and that can cause OS lockups, timeouts, watchdogs, etc. This can be
seen running a KVM guest (that causes lots of TB updates) on a powernv
SMP machine.

Fix this by reading the clock once.

Cc: qemu-stable@nongnu.org
Fixes: dbdd25065e90 ("Implement time-base start/stop helpers.")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
Message-ID: <20230629020713.327745-1-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/ppc.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 0fc82bb175..0e0a3d93c3 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -535,23 +535,24 @@ static inline void cpu_ppc_store_tb(ppc_tb_t *tb_env, uint64_t vmclk,
 void cpu_ppc_store_tbl (CPUPPCState *env, uint32_t value)
 {
     ppc_tb_t *tb_env = env->tb_env;
+    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     uint64_t tb;
 
-    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->tb_offset);
+    tb = cpu_ppc_get_tb(tb_env, clock, tb_env->tb_offset);
     tb &= 0xFFFFFFFF00000000ULL;
-    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                     &tb_env->tb_offset, tb | (uint64_t)value);
+    cpu_ppc_store_tb(tb_env, clock, &tb_env->tb_offset, tb | (uint64_t)value);
 }
 
 static inline void _cpu_ppc_store_tbu(CPUPPCState *env, uint32_t value)
 {
     ppc_tb_t *tb_env = env->tb_env;
+    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     uint64_t tb;
 
-    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->tb_offset);
+    tb = cpu_ppc_get_tb(tb_env, clock, tb_env->tb_offset);
     tb &= 0x00000000FFFFFFFFULL;
-    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                     &tb_env->tb_offset, ((uint64_t)value << 32) | tb);
+    cpu_ppc_store_tb(tb_env, clock, &tb_env->tb_offset,
+                     ((uint64_t)value << 32) | tb);
 }
 
 void cpu_ppc_store_tbu (CPUPPCState *env, uint32_t value)
@@ -584,23 +585,24 @@ uint32_t cpu_ppc_load_atbu (CPUPPCState *env)
 void cpu_ppc_store_atbl (CPUPPCState *env, uint32_t value)
 {
     ppc_tb_t *tb_env = env->tb_env;
+    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     uint64_t tb;
 
-    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->atb_offset);
+    tb = cpu_ppc_get_tb(tb_env, clock, tb_env->atb_offset);
     tb &= 0xFFFFFFFF00000000ULL;
-    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                     &tb_env->atb_offset, tb | (uint64_t)value);
+    cpu_ppc_store_tb(tb_env, clock, &tb_env->atb_offset, tb | (uint64_t)value);
 }
 
 void cpu_ppc_store_atbu (CPUPPCState *env, uint32_t value)
 {
     ppc_tb_t *tb_env = env->tb_env;
+    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     uint64_t tb;
 
-    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->atb_offset);
+    tb = cpu_ppc_get_tb(tb_env, clock, tb_env->atb_offset);
     tb &= 0x00000000FFFFFFFFULL;
-    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                     &tb_env->atb_offset, ((uint64_t)value << 32) | tb);
+    cpu_ppc_store_tb(tb_env, clock, &tb_env->atb_offset,
+                     ((uint64_t)value << 32) | tb);
 }
 
 uint64_t cpu_ppc_load_vtb(CPUPPCState *env)
@@ -622,14 +624,13 @@ void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t value)
 void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value)
 {
     ppc_tb_t *tb_env = env->tb_env;
+    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     uint64_t tb;
 
-    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                        tb_env->tb_offset);
+    tb = cpu_ppc_get_tb(tb_env, clock, tb_env->tb_offset);
     tb &= 0xFFFFFFUL;
     tb |= (value & ~0xFFFFFFUL);
-    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                     &tb_env->tb_offset, tb);
+    cpu_ppc_store_tb(tb_env, clock, &tb_env->tb_offset, tb);
 }
 
 static void cpu_ppc_tb_stop (CPUPPCState *env)
-- 
2.41.0


