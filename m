Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 069E7831C0E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:11:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQU2u-0004sR-Jl; Thu, 18 Jan 2024 10:11:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU0Z-0000lI-UE; Thu, 18 Jan 2024 10:08:44 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU0Y-0008BA-Dv; Thu, 18 Jan 2024 10:08:43 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d5cdb4a444so38971965ad.1; 
 Thu, 18 Jan 2024 07:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590520; x=1706195320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RGAerpKRGk2C4dVMvisx4cAfj+SiYpk9Hj4bX7sW76k=;
 b=DZfxcNUhsGpI0tieWFRiGJFMQyvYGud01QBUe9IH+IeWmEQRoOt1ior2GsuOcaHbNe
 Xr39jmzoXNaoNA0/AItyXoSF9uVD45BrzinIZ4Mp1sT+HkHvWOkP2b7r/rkWiNSUZhMr
 X1zpy9WrIuCeCKGIqTyBxmECbCJpYxIUfTVVPto+gn10U53wa9kiwWa6bf59d24Mrbom
 6yjYGAD8DUFIOZggYHbSSlyuIFhzQoXvZTRanjBGKhG6oMtExbqGTCeExHGFowu+FAqm
 aDm0uIvF17MAbztuFY/7pBxcMqG+i9Rr2jFl+o6QF2FlgIoE30O9gbU+Z2wqiCKv5iv6
 3qFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590520; x=1706195320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RGAerpKRGk2C4dVMvisx4cAfj+SiYpk9Hj4bX7sW76k=;
 b=B+2jlI6D4nG7bXXE4DxFCUgSdcVsa+nEwIfvw4BRYe8i1mgXntwVfBD85KGgWgMb+e
 4RrD8t1kzrghLsyp6yaJJFYsZ0MGOK8zqYbQtua0RO8rNeJ+JBfL377abgOYlpxxCU5y
 dKCDLvh/2AXn3hITwOjJJ473bvqKvsDtbEAixP8oJIT5nzcSVYJeiZqyTmJusqHi8irC
 BNHWvrJPHge0aGFclMsIn5rl0mfYTrg8iVsRTl18oYJboRrYv4x9+t2r/IoLve5lQFaF
 CIevzYUaIkwKqd0dg7WR8IJGkh4qPLhJhHOXLcElGo56nQv1CZIyMGT7DrL+/HB/LlSU
 wDUQ==
X-Gm-Message-State: AOJu0Yx2CiEg3b55i4DKGcCazjbLneLK6gEcAvN7YbsgE6zN5zA7VjEa
 5cYNiXtdByjhwaeCAIR3s8BKvZ29xoo1KukxxrS5x2XpFIP87SKWSkUHW+/y
X-Google-Smtp-Source: AGHT+IHkRZdfzJp8vxDgId2ggwSBIoRw0oOsQW0wi46UxIcxtkuD/UyW/yQhpqZP7a9BGNc4tRKKHw==
X-Received: by 2002:a17:903:1c5:b0:1d5:efcb:3cd1 with SMTP id
 e5-20020a17090301c500b001d5efcb3cd1mr1197276plh.81.1705590520697; 
 Thu, 18 Jan 2024 07:08:40 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:08:40 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 23/26] target/ppc: Add SMT support to PTCR SPR
Date: Fri, 19 Jan 2024 01:06:41 +1000
Message-ID: <20240118150644.177371-24-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

PTCR is a per-core register.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/misc_helper.c | 16 ++++++++++++++--
 target/ppc/translate.c   |  4 ++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index e3b20a8935..5317713fc3 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -176,6 +176,7 @@ void helper_store_sdr1(CPUPPCState *env, target_ulong val)
 void helper_store_ptcr(CPUPPCState *env, target_ulong val)
 {
     if (env->spr[SPR_PTCR] != val) {
+        CPUState *cs = env_cpu(env);
         PowerPCCPU *cpu = env_archcpu(env);
         target_ulong ptcr_mask = PTCR_PATB | PTCR_PATS;
         target_ulong patbsize = val & PTCR_PATS;
@@ -197,8 +198,19 @@ void helper_store_ptcr(CPUPPCState *env, target_ulong val)
             return;
         }
 
-        env->spr[SPR_PTCR] = val;
-        tlb_flush(env_cpu(env));
+        if (cs->nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+            env->spr[SPR_PTCR] = val;
+            tlb_flush(cs);
+        } else {
+            CPUState *ccs;
+
+            THREAD_SIBLING_FOREACH(cs, ccs) {
+                PowerPCCPU *ccpu = POWERPC_CPU(ccs);
+                CPUPPCState *cenv = &ccpu->env;
+                cenv->spr[SPR_PTCR] = val;
+                tlb_flush(ccs);
+            }
+        }
     }
 }
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index e7749d9b32..41aeb2d06e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -906,6 +906,10 @@ void spr_write_hior(DisasContext *ctx, int sprn, int gprn)
 }
 void spr_write_ptcr(DisasContext *ctx, int sprn, int gprn)
 {
+    if (!gen_serialize_core(ctx)) {
+        return;
+    }
+
     gen_helper_store_ptcr(tcg_env, cpu_gpr[gprn]);
 }
 
-- 
2.42.0


