Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ADA7F6C69
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 07:41:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Prx-00026Z-AJ; Fri, 24 Nov 2023 01:40:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6Pru-00025v-KW; Fri, 24 Nov 2023 01:40:50 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6Prt-00069Q-1y; Fri, 24 Nov 2023 01:40:50 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1ef36a04931so984694fac.2; 
 Thu, 23 Nov 2023 22:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700808047; x=1701412847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PrARsryEwe7PV0D0kG3CvFJXngoQjko6oazoiSwZIPA=;
 b=hxFCsk+JS4TvODtXWd6oHGAHCpLRt8XHJBU37qQyKrOulhJLsRoUOnm7Sdjn0cx5QT
 pjEnpG7uneEWKZxj3D/LPJvnpon2biyPm9MxDDvTWROfOmnFBVibkH9pmfdnQg0tJcNw
 xiH1YtuA+RKRgs9pP34YojLt93FuT+9ZKPm/fbMPNO8Fvn/g7P8s3PgPSH/hsQZgfoKq
 fJcWcuG2eft0XMPJElZxTuI15JavZj+Oo7YQTjIZcEOoM5f/WHyHN8rxdre12J9SCBGS
 7KS9HOF1d9aSgvYF+8LsLCN8Iyw9RX3PFpY7x6BHmAbgYFN8BO541NXkR29kecbeTq2G
 CLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700808047; x=1701412847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PrARsryEwe7PV0D0kG3CvFJXngoQjko6oazoiSwZIPA=;
 b=KlJr97R52PoW21+2lByGqA0zDuwxIRZl9h6JPWQIoMrbawMD+wkeAWcZE6v6NKbmGk
 epUo8DhnOUpS+rH6197p3//VeI57i3Mj2sfZ9SQho/Buoi8TRywW84x26MJSXwUGNee2
 k7bYJHUz5ayQL4qAQoe0grp3miu31JCclJqbTjfCVpJiN8hsq/BJELw1069xRgqK22NR
 qeyJutbA449oC8YcdvFaAnZf/42gUFzK+rnrqvpx7KnteIW2urKW7FeIQSI9dMUWFEG6
 b1HME2SIQ+9XaVRVKbbZH29amQ5nIY1ztxHyz6jx9K4pKpdcaUv1BKekJ/DW4lHsc3WA
 uF4g==
X-Gm-Message-State: AOJu0Yy70ElURQ2kV7wrsezgQbZi3zrx0NBovgTzcKUQFFuFlRGrnNZR
 ottx3BGTc0eNvJsJs5w4flvGBJ/l2IOx9w==
X-Google-Smtp-Source: AGHT+IGAVnz7uQkcEasnKIlZ8K/QvzuRju3gp0yS+zRWJ3cAmMHHko1Eph7mVrD1kfAHB/ykD0RbNg==
X-Received: by 2002:a05:6871:3a24:b0:1f5:ef10:1c2e with SMTP id
 pu36-20020a0568713a2400b001f5ef101c2emr2317617oac.29.1700808046846; 
 Thu, 23 Nov 2023 22:40:46 -0800 (PST)
Received: from wheely.local0.net ([1.145.239.154])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a62f249000000b006cb8a8a4bbfsm2152013pfl.186.2023.11.23.22.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 22:40:46 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/7] target/ppc: Improve timebase register defines naming
Date: Fri, 24 Nov 2023 16:39:56 +1000
Message-ID: <20231124064001.198572-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124064001.198572-1-npiggin@gmail.com>
References: <20231124064001.198572-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x2c.google.com
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

The timebase in ppc started out with the mftb instruction which is like
mfspr but addressed timebase registers (TBRs) rather than SPRs. These
instructions could be used to read TB and TBU at 268 and 269. Timebase
could be written via the TBL and TBU SPRs at 284 and 285.

The ISA changed around v2.03 to bring TB and TBU reads into the SPR
space at 268 and 269 (access via mftb TBR-space is still supported
but will be phased out). Later, VTB was added which is an entirely
different register.

The SPR number defines in QEMU are understandably inconsistently named.
Change SPR 268, 269, 284, 285 to TBL, TBU, WR_TBL, WR_TBU, respectively.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h         |  8 ++++----
 target/ppc/helper_regs.c | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index f8101ffa29..848e583c2d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1750,8 +1750,8 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_USPRG5            (0x105)
 #define SPR_USPRG6            (0x106)
 #define SPR_USPRG7            (0x107)
-#define SPR_VTBL              (0x10C)
-#define SPR_VTBU              (0x10D)
+#define SPR_TBL               (0x10C)
+#define SPR_TBU               (0x10D)
 #define SPR_SPRG0             (0x110)
 #define SPR_SPRG1             (0x111)
 #define SPR_SPRG2             (0x112)
@@ -1764,8 +1764,8 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_SPRG7             (0x117)
 #define SPR_ASR               (0x118)
 #define SPR_EAR               (0x11A)
-#define SPR_TBL               (0x11C)
-#define SPR_TBU               (0x11D)
+#define SPR_WR_TBL            (0x11C)
+#define SPR_WR_TBU            (0x11D)
 #define SPR_TBU40             (0x11E)
 #define SPR_SVR               (0x11E)
 #define SPR_BOOKE_PIR         (0x11E)
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 8c00ed8c06..6f190ab13b 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -461,22 +461,22 @@ void register_generic_sprs(PowerPCCPU *cpu)
 
     /* Time base */
 #if defined(TARGET_PPC64)
-    spr_register(env, SPR_VTBL,  "TB",
+    spr_register(env, SPR_TBL, "TB",
 #else
-    spr_register(env, SPR_VTBL,  "TBL",
+    spr_register(env, SPR_TBL, "TBL",
 #endif
                  &spr_read_tbl, SPR_NOACCESS,
                  &spr_read_tbl, SPR_NOACCESS,
                  0x00000000);
-    spr_register(env, SPR_TBL,   "TBL",
+    spr_register(env, SPR_WR_TBL, "TBL",
                  &spr_read_tbl, SPR_NOACCESS,
                  &spr_read_tbl, &spr_write_tbl,
                  0x00000000);
-    spr_register(env, SPR_VTBU,  "TBU",
+    spr_register(env, SPR_TBU, "TBU",
                  &spr_read_tbu, SPR_NOACCESS,
                  &spr_read_tbu, SPR_NOACCESS,
                  0x00000000);
-    spr_register(env, SPR_TBU,   "TBU",
+    spr_register(env, SPR_WR_TBU, "TBU",
                  &spr_read_tbu, SPR_NOACCESS,
                  &spr_read_tbu, &spr_write_tbu,
                  0x00000000);
-- 
2.42.0


