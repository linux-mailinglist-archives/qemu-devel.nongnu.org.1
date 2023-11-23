Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B54057F5C5C
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 11:33:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r66z5-00064I-GP; Thu, 23 Nov 2023 05:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r66yq-0005wZ-1f; Thu, 23 Nov 2023 05:30:47 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r66yh-0006fu-J3; Thu, 23 Nov 2023 05:30:41 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2857670af8cso57488a91.0; 
 Thu, 23 Nov 2023 02:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700735433; x=1701340233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PrARsryEwe7PV0D0kG3CvFJXngoQjko6oazoiSwZIPA=;
 b=ffGSFQd9LrFjsQedISukglEUubrT1QwkwnKPO0SwkfUbEcJD7C37dEPOtKFL6FY2YE
 /RjKHjEMmXIauEATm4XyqNAZfJMc6Z2IbWS6GDbnZ2mo0Mu/2uj7crg2rUYPG3h0cb6S
 TUmP0pOdC8qBmXu8p6d9/atUDccmJOzvQ2Fb2hesZpSUJBv0+2XYPrB4zxJBRd+OrJgi
 Tmd2bkxFX65KcfbqnhwHux7OcmFosbBiytfXWM8d5iXtuazC6U1IalVDc3SJT3kq4ouc
 i0KU5T4+Wlsno1tdL7RqN584QjjQrKFnF9faDgW0xjlIq9vz3xrDmnjbynHNQO6s5EXQ
 RDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700735433; x=1701340233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PrARsryEwe7PV0D0kG3CvFJXngoQjko6oazoiSwZIPA=;
 b=tyNxADMCXMzVAjO5kkdAfMsZnWQH5M7UeXz0pQI3wkli19rRb3d6JZnqTqkthcmC7h
 KArplTQDDbZ3mJYhpMegqCqeJ85rEbhw7jf+wYZDOS3ch92hRjoL8b9ITS/EXYPqqA70
 cnFHNl7qu5EQvjdRQEXrev/RfLK5KpriPtwzp9gJ1EHvOWPESDdeIndksiK/smGi+0/L
 XYgArmVCi5kpQTpU8+DD/7SZubj0Zx9+4O3m36ibad9yPJzSA9S9QRiEXaZ6WstDnqlB
 D4g4e885A8paTwPEfFL63H/DiyFjWkW3Q/D+RxbEJ1coBozMtHfFpufZ01L2E0xnKmzM
 VuSQ==
X-Gm-Message-State: AOJu0Yxf4SMCGqvRfzB+e1JVnzz0Q3ZIRRtcedXNhLUIEN5lltjvJMMR
 CT9joTowhS7bVmlTq3ZAfOVMBWSYtAc=
X-Google-Smtp-Source: AGHT+IGKRfO7gijeVDZaFP02XFpku2ehU3Il7N7oIelHhJybSDRl69vHDLuFU1L1mYOx6M0Fr4gffg==
X-Received: by 2002:a17:90b:3807:b0:281:3fb:6df2 with SMTP id
 mq7-20020a17090b380700b0028103fb6df2mr4778675pjb.22.1700735433266; 
 Thu, 23 Nov 2023 02:30:33 -0800 (PST)
Received: from wheely.local0.net (60-240-124-93.tpgi.com.au. [60.240.124.93])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a170902d38400b001cc1dff5b86sm1009070pld.244.2023.11.23.02.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 02:30:32 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 2/7] target/ppc: Improve timebase register defines naming
Date: Thu, 23 Nov 2023 20:30:13 +1000
Message-ID: <20231123103018.172383-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123103018.172383-1-npiggin@gmail.com>
References: <20231123103018.172383-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
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


