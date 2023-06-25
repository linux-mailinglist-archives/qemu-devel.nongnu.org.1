Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4AA73D0C0
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 14:04:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDOSt-0007R8-3E; Sun, 25 Jun 2023 08:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDOSq-0007Qd-Nq; Sun, 25 Jun 2023 08:03:32 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDOSp-0006aS-1f; Sun, 25 Jun 2023 08:03:32 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-51452556acdso903713a12.2; 
 Sun, 25 Jun 2023 05:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687694609; x=1690286609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9IXsJOnnoFQAyyVJocLgPD0KEUNaBW2bvze4531Dd4=;
 b=L4VqDeh3364Iydke7P+v5YA2i5ACdwz0cOhzTzvAcxjTMr6nuH51FkpHy+b1z+UhJr
 FyM7PP0O0SzeF1eKZMcH9ixcGlTULHsCtvS6ygjUuhlzrnnqwYKG9iVrUKa5FpOpYspZ
 KtewN4t79kcSxgBsVnL36ZuGWc4/thJ9rMmEDP6b4Deie8JQsw/TdNtbbohpnULtqdTu
 IDq0p2/Vg2+5s1hrpHdali+Q5G5WDsOLw86kGZvxNg3Vj1Nc+eAIG+8JW8vC9gjeQeLe
 HYGHGHyTGrXJr9aOUtaeR4V9ycpliK79zHFciPJgBl+cnm6I5bWp9psZYq3/BKPsCBIO
 d3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687694609; x=1690286609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F9IXsJOnnoFQAyyVJocLgPD0KEUNaBW2bvze4531Dd4=;
 b=iEfjORBn85rY6olUl97m7y/NfD9iXSURl1c93PY1Ombj5spgmYSa8o0FSRHhczWXL4
 sGNosMDOP8zKoteApQTWoHIepti1uTYGe8CJVosBR0Xwl41YbDBJoFMGLcWGaGCjEwM2
 /HVn0w0oLWXOlJKWHeYU66+kC3uDkVUto5oXhivl4LMmoD55CVAtYRKQ1le3oF+Q69/X
 D1mz+AlJscZk4JIsP8K1myNxIGFolZyw0ErMOp2fgt1hkD6Z4o4lG+eDGlZS7In6fmpC
 TNPocnQUPlZEJu36Ovi89rQ2gsf5MSBOMl/kLLiV3lJ2ujdJQAaR23We6SX92vymlvlB
 4sLw==
X-Gm-Message-State: AC+VfDywmuoSg4VTnCT3f37BNs6p3bQFIORBog1wdaZp81e10iGngguU
 76oP5OwnfXujpyiorU7j8vp4QvSgw30=
X-Google-Smtp-Source: ACHHUZ72LG5Km4G34wF7+IY6Ymy6iKikyt3i/8JeV6CTUvQsHTRnbh8bSwhf8qHuBrG+3nL4lldjGw==
X-Received: by 2002:a05:6a20:1446:b0:126:1059:42b4 with SMTP id
 a6-20020a056a20144600b00126105942b4mr2944257pzi.44.1687694609046; 
 Sun, 25 Jun 2023 05:03:29 -0700 (PDT)
Received: from wheely.local0.net (193-116-198-102.tpgi.com.au.
 [193.116.198.102]) by smtp.gmail.com with ESMTPSA id
 c4-20020aa78804000000b0064f51ee5b90sm2190772pfo.62.2023.06.25.05.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 05:03:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 1/2] target/ppc: Tidy POWER book4 SPR registration
Date: Sun, 25 Jun 2023 22:03:16 +1000
Message-Id: <20230625120317.13877-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230625120317.13877-1-npiggin@gmail.com>
References: <20230625120317.13877-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
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

POWER book4 (implementation-specific) SPRs are sometimes in their own
functions, but in other cases are mixed with architected SPRs. Do some
spring cleaning on these.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 82 +++++++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 27 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index a97fb7fe10..21ff4861c3 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5370,31 +5370,6 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
                  &spr_read_generic, SPR_NOACCESS,
                  &spr_read_generic, NULL,
                  0x00000000);
-    spr_register_hv(env, SPR_HID0, "HID0",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    spr_register_hv(env, SPR_TSCR, "TSCR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic32,
-                 0x00000000);
-    spr_register_hv(env, SPR_HMER, "HMER",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_hmer,
-                 0x00000000);
-    spr_register_hv(env, SPR_HMEER, "HMEER",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    spr_register_hv(env, SPR_TFMR, "TFMR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
     spr_register_hv(env, SPR_LPIDR, "LPIDR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -5656,14 +5631,60 @@ static void register_power8_ic_sprs(CPUPPCState *env)
 #endif
 }
 
+/* SPRs specific to IBM POWER CPUs */
+static void register_power_common_book4_sprs(CPUPPCState *env)
+{
+#if !defined(CONFIG_USER_ONLY)
+    spr_register_hv(env, SPR_HID0, "HID0",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
+    spr_register_hv(env, SPR_TSCR, "TSCR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic32,
+                 0x00000000);
+    spr_register_hv(env, SPR_HMER, "HMER",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_hmer,
+                 0x00000000);
+    spr_register_hv(env, SPR_HMEER, "HMEER",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
+    spr_register_hv(env, SPR_TFMR, "TFMR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
+#endif
+}
+
+static void register_power9_book4_sprs(CPUPPCState *env)
+{
+    /* Add a number of P9 book4 registers */
+    register_power_common_book4_sprs(env);
+#if !defined(CONFIG_USER_ONLY)
+    spr_register_kvm(env, SPR_WORT, "WORT",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic,
+                     KVM_REG_PPC_WORT, 0);
+#endif
+}
+
 static void register_power8_book4_sprs(CPUPPCState *env)
 {
     /* Add a number of P8 book4 registers */
+    register_power_common_book4_sprs(env);
 #if !defined(CONFIG_USER_ONLY)
     spr_register_kvm(env, SPR_ACOP, "ACOP",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_ACOP, 0);
+    /* PID is only in BookE in ISA v2.07 */
     spr_register_kvm(env, SPR_BOOKS_PID, "PID",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_pidr,
@@ -5679,10 +5700,12 @@ static void register_power7_book4_sprs(CPUPPCState *env)
 {
     /* Add a number of P7 book4 registers */
 #if !defined(CONFIG_USER_ONLY)
+    register_power_common_book4_sprs(env);
     spr_register_kvm(env, SPR_ACOP, "ACOP",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_ACOP, 0);
+    /* PID is only in BookE in ISA v2.06 */
     spr_register_kvm(env, SPR_BOOKS_PID, "PID",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic32,
@@ -5716,6 +5739,11 @@ static void register_power9_mmu_sprs(CPUPPCState *env)
                     SPR_NOACCESS, SPR_NOACCESS,
                     &spr_read_generic, &spr_write_generic,
                     0x0000000000000000);
+    /* PID is part of the BookS ISA from v3.0 */
+    spr_register_kvm(env, SPR_BOOKS_PID, "PID",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_pidr,
+                     KVM_REG_PPC_PID, 0);
 #endif
 }
 
@@ -6269,7 +6297,7 @@ static void init_proc_POWER9(CPUPPCState *env)
     register_power8_dpdes_sprs(env);
     register_vtb_sprs(env);
     register_power8_ic_sprs(env);
-    register_power8_book4_sprs(env);
+    register_power9_book4_sprs(env);
     register_power8_rpr_sprs(env);
     register_power9_mmu_sprs(env);
 
@@ -6462,7 +6490,7 @@ static void init_proc_POWER10(CPUPPCState *env)
     register_power8_dpdes_sprs(env);
     register_vtb_sprs(env);
     register_power8_ic_sprs(env);
-    register_power8_book4_sprs(env);
+    register_power9_book4_sprs(env);
     register_power8_rpr_sprs(env);
     register_power9_mmu_sprs(env);
     register_power10_hash_sprs(env);
-- 
2.40.1


