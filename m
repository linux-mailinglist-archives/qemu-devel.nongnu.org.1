Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDE473D0E5
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 14:21:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDOjJ-0002vx-Uo; Sun, 25 Jun 2023 08:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDOjG-0002vl-KA; Sun, 25 Jun 2023 08:20:30 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDOjA-0002kE-Ti; Sun, 25 Jun 2023 08:20:28 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6686ef86110so904131b3a.2; 
 Sun, 25 Jun 2023 05:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687695622; x=1690287622;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vcxsvdtAbOhrjeibOUwvWD6GK+oKmVwchyjzRr6M73w=;
 b=gejmuONzWWWpNHSFVzBiSmDht51TiBul+PLdmsWtKv2XWWegw/6fNesivhJz+PbTzV
 i910AXAc7OPM/lFkeqe6aNfcSYj7eSSKjSxOKf1jK9Kn6qLLARE4aaIJilKzxlxquM3v
 aG+nH8CKtMJ8FP4/mXk2Lt2hz+jQp/iEmasWmE6Yo3020hGAeViVN28u2zcsSayb8Ot3
 u2vyWQ8L2CGpA54/BKbVHowPVitD64AWfPBcCkCGtJ8tJOSEdo8rZ+khB2Ed8xpVaLH7
 Q6fxHvu4YJ46yBYtHoCiL0oEseW9WJ9g5UQiLMgXueI+jrq7jXsB9QG4dpwk2C5iidrI
 yFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687695622; x=1690287622;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vcxsvdtAbOhrjeibOUwvWD6GK+oKmVwchyjzRr6M73w=;
 b=IfpaEyT4D9qK+CHvG8HV4XoKf+KSLwleYk4Cx1behF2ecKFEqrVYlQ5gK59bvoc+js
 j4y8k5VkUj5QPOSvvRKnVTBdVtS9BBFJQdcHispzqmFWegRzpi9Hc72mQPVIkiKsWyC4
 zKgUpDu6u5WBFXnQ/esHW7ntyXz0p6dDwr4yrXjOAkJq/RTeIh+pX+kGF+0xWcI1AqGL
 9KfIooIwbYC9qsQl0g5xTlz4lWnj3qudrP/TvoB/LIfUxKwj70Ep34cRh/HoVsqJTgY/
 yLEx++El7AKxE5FgNBUDdEZeZ0psF4Lc6cC8C7Az+Pym6EMeDSp3bemh5pm+uyo26JJs
 ImBw==
X-Gm-Message-State: AC+VfDxYPzurrnBILpmvzGplRmw3zVB56NrwrH818ZuBWDvg5fod1BYk
 KcjtQuVmwv/sLh/xSkTDaz3KFxGijmM=
X-Google-Smtp-Source: ACHHUZ43QWXmYUl6II+gcsw0XdkDpLL+yBk916uILcSVWngQwe4QRXqB08GX9ZLFO7aF3q7ekSRy9Q==
X-Received: by 2002:a05:6a00:1a0e:b0:656:8e21:bd37 with SMTP id
 g14-20020a056a001a0e00b006568e21bd37mr19561120pfv.21.1687695621769; 
 Sun, 25 Jun 2023 05:20:21 -0700 (PDT)
Received: from wheely.local0.net (193-116-198-102.tpgi.com.au.
 [193.116.198.102]) by smtp.gmail.com with ESMTPSA id
 q13-20020a62e10d000000b0066882cc4d28sm2274279pfh.96.2023.06.25.05.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 05:20:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH] hw/ppc: Simplify clock update arithmetic
Date: Sun, 25 Jun 2023 22:20:12 +1000
Message-Id: <20230625122012.15503-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The clock update logic reads the clock twice to compute the new clock
value, with a value derived from the later time subtracted from a value
derived from the earlier time. This can lead to an underflow in
subtractions in bits that are intended to cancel exactly. This might
not cause any real problem, but it is more complicated than necessary
to reason about.

Simplify this by reading the clock once.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index f4fe1767d6..5d0a09eb5e 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -536,23 +536,24 @@ static inline void cpu_ppc_store_tb(ppc_tb_t *tb_env, uint64_t vmclk,
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
@@ -585,23 +586,24 @@ uint32_t cpu_ppc_load_atbu (CPUPPCState *env)
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
@@ -623,14 +625,13 @@ void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t value)
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
2.40.1


