Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ED0800AD6
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 13:26:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r92a6-0004mz-09; Fri, 01 Dec 2023 07:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r92a0-0004mc-Fz; Fri, 01 Dec 2023 07:25:12 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r92Zs-0002m0-Tz; Fri, 01 Dec 2023 07:25:12 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-28654179ec0so785638a91.2; 
 Fri, 01 Dec 2023 04:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701433502; x=1702038302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KzRrajUsbTBsu6a5rO5zs7vsq52pro8UNElMiAbNb/Q=;
 b=NR5bkJ1RptVc5HwMmp03OsTyasWK9lQ4nRq6s/ITmYc3nrwPKrYaHraV4RJ/72E/rY
 D20XC8UQSJZ2JUYbKAYn6zL4cLkZF1IqQ6TXR73N0s4XuM7DYqfQKn5o2Riv+CT0uEfA
 GGmMygVvmaxZ6r9bN5MKaYkdseHxhOB1TRnD+V1mh9bzyOP+7feubjy0sqVMPIY4hjFI
 M1PsEV92l6rlk7TYlm91ApGwmbREOITTZuYziZe5zqIxioXlsECXUtISwmEEqHn/uPVk
 mBIhgihL7OI7gogHsq8WHPjnLE6iuSuu4cjHnoLr3X/p9A/FlaM3PePQQxK4IkgFh2Fj
 /J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701433502; x=1702038302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KzRrajUsbTBsu6a5rO5zs7vsq52pro8UNElMiAbNb/Q=;
 b=KGgEOSmEwiWX+ZndcXRoMAgdAh6Q8PVyIrJJrYwUnf/RcvzpYRa8Z4rcXnkLC2iIXa
 vO9lDnhd5wHIvsSrgz5nLYsUgcHfYN6NSDFsRSeNVr5IKFGWFYvXBJPA7duLN5i3DQ60
 c3NRj6drAZVmStghbJFmrZmY7kmN3EHGxQAsBb0vk4OHd0Z0kSFbGl50PKYP5eQ0HfGJ
 zcr1EUCatYY6cR/f238iN9NovkwN7fQzFpG7fqJYgDDzEceA8QFwY1BM1753HjNN/nlA
 PheI2n11V4VrHqy7FGrzLZpBqWwvsNF/XuIAfYVknJuMVbLiJ97Xv/jbdXlAHV2oNh7B
 3YZQ==
X-Gm-Message-State: AOJu0YxLzekiQrFfdsiCdllISiSLECunC88O/pV5Q9rcDkfO4G8ckj68
 86tJZ9eoJEXHKK+sW2stDvTN4IZAdH0=
X-Google-Smtp-Source: AGHT+IHwRPS8Uxmgee/lD9IfqXio7EP/0K3XcFT1NM1M/CgcFlm8DLIGqKowUR3SEQUP8vaUAiayng==
X-Received: by 2002:a17:90a:354:b0:280:18ba:f016 with SMTP id
 20-20020a17090a035400b0028018baf016mr32234850pjf.47.1701433502211; 
 Fri, 01 Dec 2023 04:25:02 -0800 (PST)
Received: from wheely.local0.net ([124.170.16.164])
 by smtp.gmail.com with ESMTPSA id
 1-20020a17090a19c100b00280070a2613sm5355932pjj.51.2023.12.01.04.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 04:25:01 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Subject: [PATCH] target/ppc: Re-name registers to match ISA
Date: Fri,  1 Dec 2023 22:24:54 +1000
Message-ID: <20231201122455.143936-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
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

Several registers have names that don't match the ISA (or convention
with other QEMU PPC registers), making them unintuitive to use with
GDB.

Fortunately most of these registers are obscure and/or have not been
correctly implemented in the gdb server (e.g., DEC, TB, CFAR), so risk
of breaking users should be low.

QEMU should follow the ISA for register name convention (where there is
no established GDB name).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
There is never a great time to change user interface, but I'd like to
make this change for 9.0.

Thanks,
Nick

 target/ppc/cpu_init.c    | 20 ++++++++++----------
 target/ppc/helper_regs.c |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 40fe14a6c2..15c1f2fdc8 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5062,7 +5062,7 @@ static void register_970_hid_sprs(CPUPPCState *env)
 
 static void register_970_hior_sprs(CPUPPCState *env)
 {
-    spr_register(env, SPR_HIOR, "SPR_HIOR",
+    spr_register(env, SPR_HIOR, "HIOR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_hior, &spr_write_hior,
                  0x00000000);
@@ -5070,11 +5070,11 @@ static void register_970_hior_sprs(CPUPPCState *env)
 
 static void register_book3s_ctrl_sprs(CPUPPCState *env)
 {
-    spr_register(env, SPR_CTRL, "SPR_CTRL",
+    spr_register(env, SPR_CTRL, "CTRL",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, &spr_write_CTRL,
                  0x00000000);
-    spr_register(env, SPR_UCTRL, "SPR_UCTRL",
+    spr_register(env, SPR_UCTRL, "UCTRL",
                  &spr_read_ureg, SPR_NOACCESS,
                  &spr_read_ureg, SPR_NOACCESS,
                  0x00000000);
@@ -5465,7 +5465,7 @@ static void register_book3s_purr_sprs(CPUPPCState *env)
 static void register_power6_dbg_sprs(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
-    spr_register(env, SPR_CFAR, "SPR_CFAR",
+    spr_register(env, SPR_CFAR, "CFAR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_cfar, &spr_write_cfar,
                  0x00000000);
@@ -5483,7 +5483,7 @@ static void register_power5p_common_sprs(CPUPPCState *env)
 static void register_power6_common_sprs(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
-    spr_register_kvm(env, SPR_DSCR, "SPR_DSCR",
+    spr_register_kvm(env, SPR_DSCR, "DSCR",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_DSCR, 0x00000000);
@@ -5695,7 +5695,7 @@ static void register_power8_book4_sprs(CPUPPCState *env)
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_ACOP, 0);
     /* PID is only in BookE in ISA v2.07 */
-    spr_register_kvm(env, SPR_BOOKS_PID, "PID",
+    spr_register_kvm(env, SPR_BOOKS_PID, "PIDR",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_pidr,
                      KVM_REG_PPC_PID, 0);
@@ -5716,7 +5716,7 @@ static void register_power7_book4_sprs(CPUPPCState *env)
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_ACOP, 0);
     /* PID is only in BookE in ISA v2.06 */
-    spr_register_kvm(env, SPR_BOOKS_PID, "PID",
+    spr_register_kvm(env, SPR_BOOKS_PID, "PIDR",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic32,
                      KVM_REG_PPC_PID, 0);
@@ -5750,7 +5750,7 @@ static void register_power9_mmu_sprs(CPUPPCState *env)
                     &spr_read_generic, &spr_write_generic,
                     0x0000000000000000);
     /* PID is part of the BookS ISA from v3.0 */
-    spr_register_kvm(env, SPR_BOOKS_PID, "PID",
+    spr_register_kvm(env, SPR_BOOKS_PID, "PIDR",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_pidr,
                      KVM_REG_PPC_PID, 0);
@@ -5791,7 +5791,7 @@ static void register_power10_dexcr_sprs(CPUPPCState *env)
             &spr_read_generic, &spr_write_generic32,
             0);
 
-    spr_register(env, SPR_UDEXCR, "DEXCR",
+    spr_register(env, SPR_UDEXCR, "UDEXCR",
             &spr_read_dexcr_ureg, SPR_NOACCESS,
             &spr_read_dexcr_ureg, SPR_NOACCESS,
             0);
@@ -5802,7 +5802,7 @@ static void register_power10_dexcr_sprs(CPUPPCState *env)
             &spr_read_generic, &spr_write_generic32,
             0);
 
-    spr_register(env, SPR_UHDEXCR, "HDEXCR",
+    spr_register(env, SPR_UHDEXCR, "UHDEXCR",
             &spr_read_dexcr_ureg, SPR_NOACCESS,
             &spr_read_dexcr_ureg, SPR_NOACCESS,
             0);
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index f1493ddca0..59cf3dfaae 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -509,7 +509,7 @@ void register_non_embedded_sprs(CPUPPCState *env)
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_DAR, 0x00000000);
     /* Timer */
-    spr_register(env, SPR_DECR, "DECR",
+    spr_register(env, SPR_DECR, "DEC",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_decr, &spr_write_decr,
                  0x00000000);
-- 
2.42.0


