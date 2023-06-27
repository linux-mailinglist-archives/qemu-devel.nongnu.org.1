Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA45173FD26
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:48:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE92T-0005b1-9E; Tue, 27 Jun 2023 09:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qE92Q-0005Yp-UG; Tue, 27 Jun 2023 09:47:22 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qE92P-0001LD-BP; Tue, 27 Jun 2023 09:47:22 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-39ecf031271so4003370b6e.1; 
 Tue, 27 Jun 2023 06:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687873638; x=1690465638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFElMOYREqTjCYiW7N54+HmzpRYUMsS3Lh2vU/TLQWM=;
 b=T5uTDWEpoh/7bxjNniZaL9slXJdo2uLd7+AszawwGimTv7BzGVR/4SYTbUB9SgjFAL
 HqyGt/57Np9A00SMsDyPyHVE89Kup9bMv6ty3dh6J8pogeykoC6Dx/pbXELEOlWgTBUO
 h7l8riA1RmRbWpUPAwEqR8qd+oIA3VT/5uA2dbMzR/CRbmjR4b0DZV/Hz9m4w+tdM1Hk
 IuxpDZHl5G6Rx00esqIHHPJvoaD/Yf/ZqV9YSzN2zDaqrIeyynmK4+n448lCAAknQvjc
 7h64haYTjvwury+VQs+6w0jllJjsSg0lHNvFBD5Vmds2cjure3ZICPhb+cez7hcmXWlc
 1NLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687873638; x=1690465638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DFElMOYREqTjCYiW7N54+HmzpRYUMsS3Lh2vU/TLQWM=;
 b=b693gBzvx0j+3Mo8vxRbBVwz0BxFCpBuleFTyBsmVGheTCuqLXNFW67KYw/wcVWci1
 btVB5Q9RJk0MBwdrCpdna4wTuLvhXkNQta2IJ0ynKNOvkXqH9W2uQ2WQm6yJPEiyTMso
 Ew5XjAkTtSv+G0fWBx0Tj1RVNwr3IHlCLSw3XzOpQoC4viwbvi3brXoIlHCMe56S8Xkq
 Vv1gcnezXP2wRqes6UPzAi9YbrKzk37PScnT320MHY0fkfnYbpn4w1hYlb/QB3hWH9vz
 wT/PTbLA2I3AMvHhk1gGPcSQ93HLxxJII4WFuOIZMzgr/Q9t3v6nyzNNm3RybDEhInF5
 6ALw==
X-Gm-Message-State: AC+VfDxBSHsqlgh9NXricV7gy9MJnC3jgXniwFlju95S0ufa6HpGhwiu
 haARN56KQm3VaMAJSOdBThalhkTiQ5Q=
X-Google-Smtp-Source: ACHHUZ4clIocSlcdRHKrZPBV1N9Rvov8RycMwGv23o0rtdjlzJW4dv+ht/appfpaiq6dM2TD2b/WOg==
X-Received: by 2002:a05:6359:baa:b0:130:e60f:6b1d with SMTP id
 gf42-20020a0563590baa00b00130e60f6b1dmr19427179rwb.24.1687873638552; 
 Tue, 27 Jun 2023 06:47:18 -0700 (PDT)
Received: from wheely.local0.net (193-116-109-121.tpgi.com.au.
 [193.116.109.121]) by smtp.gmail.com with ESMTPSA id
 d9-20020a63f249000000b0051eff0a70d7sm5741384pgk.94.2023.06.27.06.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 06:47:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 4/4] target/ppc: Implement attn instruction on BookS 64-bit
 processors
Date: Tue, 27 Jun 2023 23:46:44 +1000
Message-Id: <20230627134644.260663-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627134644.260663-1-npiggin@gmail.com>
References: <20230627134644.260663-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x231.google.com
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

attn is an implementation-specific instruction that on POWER (and G5/
970) can be enabled with a HID bit (disabled = illegal), and executing
it causes the host processor to stop and the service processor to be
notified. Generally used for debugging.

Implement attn and make it checkstop the system, which should be good
enough for QEMU debugging.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Since v1:
- New patch that also uses checkstop function. Works with skiboot.

 target/ppc/cpu.h         |  2 ++
 target/ppc/excp_helper.c | 28 ++++++++++++++++++++++++++++
 target/ppc/helper.h      |  2 ++
 target/ppc/translate.c   |  7 +++++++
 4 files changed, 39 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 94497aa115..f6e93dec5f 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2116,6 +2116,8 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define HID0_NAP            (1 << 22)           /* pre-2.06 */
 #define HID0_HILE           PPC_BIT(19) /* POWER8 */
 #define HID0_POWER9_HILE    PPC_BIT(4)
+#define HID0_ENABLE_ATTN    PPC_BIT(31) /* POWER8 */
+#define HID0_POWER9_ENABLE_ATTN PPC_BIT(3)
 
 /*****************************************************************************/
 /* PowerPC Instructions types definitions                                    */
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 28d8a9b212..f46fdd2ee6 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -208,6 +208,34 @@ static void powerpc_checkstop(CPUPPCState *env, const char *reason)
 }
 
 #if defined(TARGET_PPC64)
+void helper_attn(CPUPPCState *env)
+{
+    CPUState *cs = env_cpu(env);
+    target_ulong hid0_attn = 0;
+
+    switch (env->excp_model) {
+    case POWERPC_EXCP_970:
+    case POWERPC_EXCP_POWER7:
+    case POWERPC_EXCP_POWER8:
+        hid0_attn = HID0_ENABLE_ATTN;
+        break;
+    case POWERPC_EXCP_POWER9:
+    case POWERPC_EXCP_POWER10:
+        hid0_attn = HID0_POWER9_ENABLE_ATTN;
+        break;
+    default:
+        break;
+    }
+
+    if (env->spr[SPR_HID0] & hid0_attn) {
+        powerpc_checkstop(env, "host executed attn");
+        cpu_loop_exit_noexc(cs);
+    } else {
+        raise_exception_err(env, POWERPC_EXCP_HV_EMU,
+                            POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL);
+    }
+}
+
 static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp,
                                 target_ulong *msr)
 {
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index fda40b8a60..50bb105c08 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -812,3 +812,5 @@ DEF_HELPER_4(DSCLIQ, void, env, fprp, fprp, i32)
 
 DEF_HELPER_1(tbegin, void, env)
 DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
+
+DEF_HELPER_1(attn, void, env)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 372ee600b2..4e9e606d77 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6382,6 +6382,12 @@ static void gen_dform3D(DisasContext *ctx)
 }
 
 #if defined(TARGET_PPC64)
+/* attn */
+static void gen_attn(DisasContext *ctx)
+{
+    gen_helper_attn(cpu_env);
+}
+
 /* brd */
 static void gen_brd(DisasContext *ctx)
 {
@@ -6413,6 +6419,7 @@ static void gen_brh(DisasContext *ctx)
 
 static opcode_t opcodes[] = {
 #if defined(TARGET_PPC64)
+GEN_HANDLER_E(attn, 0x00, 0x00, 0x08, 0xFFFFFDFF, PPC_NONE, PPC2_ISA207S),
 GEN_HANDLER_E(brd, 0x1F, 0x1B, 0x05, 0x0000F801, PPC_NONE, PPC2_ISA310),
 GEN_HANDLER_E(brw, 0x1F, 0x1B, 0x04, 0x0000F801, PPC_NONE, PPC2_ISA310),
 GEN_HANDLER_E(brh, 0x1F, 0x1B, 0x06, 0x0000F801, PPC_NONE, PPC2_ISA310),
-- 
2.40.1


