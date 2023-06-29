Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6EC741DF3
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 04:09:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEh4F-0000HQ-Ta; Wed, 28 Jun 2023 22:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEh4B-0000H0-OX; Wed, 28 Jun 2023 22:07:28 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEh49-0000h9-Sg; Wed, 28 Jun 2023 22:07:27 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2633b669f5fso117624a91.2; 
 Wed, 28 Jun 2023 19:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688004443; x=1690596443;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ktxyyAEKumrUs2olL+uPncSFFMj9xoLK5EnKi63tBvU=;
 b=BMxL39u0jj35J27EVVpfH9nUh/jRXZcKDCdG0RaGyIIqkwPedzq4vfC6Y4i1ORjqaC
 w4+DTC3P4oXAZdYhYDFTeumHiCLSEgUqoR+p8CUKb17bJHzddYJEDNlREYvIY2k2kbA5
 2rF7RERoXTl4PLyjndQtvKn60bmyWh9buuCJSYP4rlmxt9kf3diBO0tPyPS6KKmJk3IR
 TMkrxmwvkeNq+H5pSZbQDiYCA/8I0JTBjxEyp80aCGulXaILnWgiKLJNAdJS4q+jJzpf
 P8YS+I1lDR9QmBYQ7BvUqwrJSGDI2BZa/XfwZXcwolu59dy5rJ392rfeoiPA8t5nbp6t
 EBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688004443; x=1690596443;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ktxyyAEKumrUs2olL+uPncSFFMj9xoLK5EnKi63tBvU=;
 b=PGUKbX0TjN6c9X0fJcYbqAkrFSoFGtriY3HzdyVNFMsx59dwWcNM9bK8zUr9E4mG3w
 iKvLCNYYlznYQzQuT162rb0i2CFBOhqN4E3wPjpNYzYYENds3u51YkUcRvBDekjNOhE6
 ctIq7yPHh3R4rXxhB8nnEKftapQ3Q/jsiL2P/M6SDBVuKf0luc0F3UdmgdIcawSffXe1
 Z2dkpKN5pExPMykPVZj1puZKzlS4GU80gQk2EuQta9sOuC9rgO8THx+9ceOuaAKIgSSC
 3vDlfzWIoWmolPDYk8y/GWLG0Ah30FX9+XxI2bsBKnty+3iVwpLjF2ITciy1CORSK5j9
 JlvQ==
X-Gm-Message-State: AC+VfDxVjl+ImnJpJcwJrRqpI4S777gs+fhW+MiTMq0IUgjacmt/M0/l
 gmetlx0aDsizKVsoNFvrOMHg7GDlUZw=
X-Google-Smtp-Source: ACHHUZ6wDx7QMKmy3Kc4WYVeQRmFaQGhSeQLq6C0Djhtxdix/8aGocJ1VIa+LaRl2KTFrzyoePeb9g==
X-Received: by 2002:a17:90a:7102:b0:262:ded7:63d with SMTP id
 h2-20020a17090a710200b00262ded7063dmr10512801pjk.17.1688004442707; 
 Wed, 28 Jun 2023 19:07:22 -0700 (PDT)
Received: from wheely.local0.net ([125.254.1.121])
 by smtp.gmail.com with ESMTPSA id
 gq7-20020a17090b104700b00263154aab24sm3619240pjb.57.2023.06.28.19.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 19:07:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH] hw/ppc: Fix clock update drift
Date: Thu, 29 Jun 2023 12:07:13 +1000
Message-Id: <20230629020713.327745-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1032.google.com
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
derived from the earlier time. The delta causes time to be lost.

This can ultimately result in time becoming unsynchronized between CPUs
and that can cause OS lockups, timeouts, watchdogs, etc. This can be
seen running a KVM guest (that causes lots of TB updates) on a powernv
SMP machine.

Fix this by reading the clock once.

Cc: qemu-stable@nongnu.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
I also made a test case that can trigger this with kvm-unit-tests, but
it's been taking me a while to get that upstreamed.

Thanks,
Nick

 hw/ppc/ppc.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 82e4408c5c..6233f43c01 100644
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
2.40.1


