Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE2E800AB6
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 13:18:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r92Sg-0005dg-GL; Fri, 01 Dec 2023 07:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r92S0-0005XA-Vz; Fri, 01 Dec 2023 07:16:58 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r92Ry-0006Ka-EH; Fri, 01 Dec 2023 07:16:56 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6cdde2aeb64so1947002b3a.2; 
 Fri, 01 Dec 2023 04:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701433012; x=1702037812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6qL3e2JNWPt6jmOYzh7bH11qo1VaaEllPBpgKTuMG8=;
 b=YqkrxlpBWX4lBZrwF3uDWfJB7hLTRT85XCrfGo6dhsxBSYxsZUeZFlUJQ+pbHZ4IR5
 oS7lQEGpOKr/Kk5/vvQeLlF5qHWXsGeNfzxzrYjouo40qLvAzLQIvD7nYLuHL1Meow4v
 D5nUmQan95y0h+BLIhD/ZTMTRHVr9K/rXmIxCyP6AIdBEkmLY5uW5ZRX9npnFavw6W31
 vXswi2sMh1P/H8T+Xt/hrsIsvNh2DM7qd2USVZJmaRQ8Vb6QhQTYwR/vOBLWP4PTXCf8
 M1+ne4WcuF3k3twOxro5cBVHqKUwrwyk3AcJnzzapSaaYPy5QZkzVqtxMIg6x9gAgrur
 HJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701433012; x=1702037812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H6qL3e2JNWPt6jmOYzh7bH11qo1VaaEllPBpgKTuMG8=;
 b=ctF3EEcujKCt1gxKyXPDgu4QW6pISMlmW6Eug5RL60t+Vj4VDy0Auhe++iCkNWsjuk
 n721EFuAqrIE88bHSuC8jUT+fEHFoXRSkg+vZ/90xEhFPccQkzr2nXvRE5Beu5LoNxEc
 WbrYSw7dq5QQpI3Lop1b5qRG7f//vIQR1s9Fy6O5S1ozwDM15WTIzXYs4r4KGG51Bvfz
 OEHukL3GYG15ASPkFelXldGU5c4p7wiCkG02qx3agtzTxw262wFqDaV68npxq7dgJphx
 ect4m3XwCYaWii/YzyWrtFNuhTSLKKiCLhxQShruPPu0WE/mHSivjjTpuTdqpFVzZDWt
 MoIw==
X-Gm-Message-State: AOJu0Yx6OoYhH8kDUfJo+3ApypZmy3v4GSgCRrgl+zn/olsnV5XXaQIA
 YiV8NlVex4DPayLMnPm99Sq5eSh+o/I=
X-Google-Smtp-Source: AGHT+IHJqtLmYVIPl5s7Z5YaVW7h1U1YyHI9mltDPcf/r/wsFCEOW89nU4yzyGgxK8krtvjpflwOkA==
X-Received: by 2002:a05:6a20:5483:b0:187:604a:3add with SMTP id
 i3-20020a056a20548300b00187604a3addmr32192655pzk.24.1701433012343; 
 Fri, 01 Dec 2023 04:16:52 -0800 (PST)
Received: from wheely.local0.net ([124.170.16.164])
 by smtp.gmail.com with ESMTPSA id
 r19-20020aa78b93000000b006cdd39faaaesm2830782pfd.20.2023.12.01.04.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 04:16:52 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 2/8] target/ppc: Improve timebase register defines naming
Date: Fri,  1 Dec 2023 22:16:30 +1000
Message-ID: <20231201121636.142694-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201121636.142694-1-npiggin@gmail.com>
References: <20231201121636.142694-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Cédric Le Goater <clg@kaod.org>
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


