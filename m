Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC35E763F7A
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 21:25:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOjMn-0000ih-4w; Wed, 26 Jul 2023 14:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjMi-0000g9-LY; Wed, 26 Jul 2023 14:36:04 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjMg-0008Im-FX; Wed, 26 Jul 2023 14:36:04 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bb7b8390e8so507845ad.2; 
 Wed, 26 Jul 2023 11:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690396561; x=1691001361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lhgb5AXx1P4s219Mrw/Q8V+vpVdydwuZ2XT+9le2vYo=;
 b=KwzKR2aWXz/BoNZH0Sv8zfVDQ94QjFg0d+Z/O6/xnwxr9josQBnpaFt8nTCnIrlmdc
 JXaM2gC2SZp87CYhTe30sF87dS0Vr9Jw2ljSaCHV0vQxtKALbYfVxDQw3p5y0jzzN20Y
 KktQ1Jzr6Nnoj0LyBNJpnj+F3Q0Q999/N4PtrLABfugMdkxmKzEw4PUxPTnHqP829LiA
 vEkkFXcBNlyD9s/OtnRImzBuYVNDNaAr55EofvqBpZDjhQjOCySv7mS6Ia9mmcysMQVp
 TO6i+wZ28jyxl7ltXCgkVhuWvuCRZbew/Fl+Xn2x0b1/AfLb1UyOI06yi5qTFt3cDP/Q
 qaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690396561; x=1691001361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lhgb5AXx1P4s219Mrw/Q8V+vpVdydwuZ2XT+9le2vYo=;
 b=dKUOWppAF8RGC1Hs7Nun9u4WY7DJ403y0eBqgu8wztr8lh/oZX+OmQ1V5x8qlqW642
 IMyE8UNMIdfOQv6VQ85MOa7By7Iw2n4dmkvZx8LPIq9jykkRgln+iZmu1jtMlkYRbP36
 6f7mWFNQnzyV/ymoF16ZLHspgqvcuWgPdoeqooLSIeht0yhKCGjA35zHhtD7QxGcHwPo
 GGLp6wYKxICTCMB2kUCeEBfkz7QkA1V/sGlqJQ2eTPa0SLGkeEgwcMcJ6hOuv9wwqqpL
 UmU3OwwxxxGE6yYz+prgrnwEZxq0vCU3DI3/RmiY1EhA3CYy4phY6viABPQNsM2hzrJ1
 tQTw==
X-Gm-Message-State: ABy/qLavkWv4LbdJbtECbnwYTrlYTzGhg1E9EvjEEMyD34wVjjGkYdGu
 BxBD6/oF3ZyWhRC8mwkjXso=
X-Google-Smtp-Source: APBJJlGc7HuiA+LZvUMMk956MQm8xWy8PAs8hjQCLgNYWvrXm9SIf2kdaytv6NWYgtsck0qhitmI+Q==
X-Received: by 2002:a17:903:284:b0:1bb:876a:abe with SMTP id
 j4-20020a170903028400b001bb876a0abemr2566618plr.0.1690396560887; 
 Wed, 26 Jul 2023 11:36:00 -0700 (PDT)
Received: from wheely.local0.net ([118.102.104.45])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a17090301cd00b001b83dc8649dsm13485670plh.250.2023.07.26.11.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 11:36:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH 4/7] spapr: Fix record-replay machine reset consuming too many
 events
Date: Thu, 27 Jul 2023 04:35:29 +1000
Message-Id: <20230726183532.434380-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230726183532.434380-1-npiggin@gmail.com>
References: <20230726183532.434380-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

spapr_machine_reset gets a random number to populate the device-tree
rng seed with. When loading a snapshot for record-replay, the machine
is reset again, and that tries to consume the random event record
again, crashing due to inconsistent record

Fix this by saving the seed to populate the device tree with, and
skipping the rng on snapshot load.

Cc: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c         | 12 +++++++++---
 include/hw/ppc/spapr.h |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7d84244f03..ecfbdb0030 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1022,7 +1022,6 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
 {
     MachineState *machine = MACHINE(spapr);
     SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
-    uint8_t rng_seed[32];
     int chosen;
 
     _FDT(chosen = fdt_add_subnode(fdt, 0, "chosen"));
@@ -1100,8 +1099,7 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
         spapr_dt_ov5_platform_support(spapr, fdt, chosen);
     }
 
-    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
-    _FDT(fdt_setprop(fdt, chosen, "rng-seed", rng_seed, sizeof(rng_seed)));
+    _FDT(fdt_setprop(fdt, chosen, "rng-seed", spapr->fdt_rng_seed, 32));
 
     _FDT(spapr_dt_ovec(fdt, chosen, spapr->ov5_cas, "ibm,architecture-vec-5"));
 }
@@ -1654,6 +1652,14 @@ static void spapr_machine_reset(MachineState *machine, ShutdownCause reason)
     void *fdt;
     int rc;
 
+    if (reason != SHUTDOWN_CAUSE_SNAPSHOT_LOAD) {
+        /*
+         * Record-replay snapshot load must not consume random, this was
+         * already replayed from initial machine reset.
+         */
+        qemu_guest_getrandom_nofail(spapr->fdt_rng_seed, 32);
+    }
+
     pef_kvm_reset(machine->cgs, &error_fatal);
     spapr_caps_apply(spapr);
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index f47e8419a5..f4bd204d86 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -204,6 +204,7 @@ struct SpaprMachineState {
     uint32_t fdt_size;
     uint32_t fdt_initial_size;
     void *fdt_blob;
+    uint8_t fdt_rng_seed[32];
     long kernel_size;
     bool kernel_le;
     uint64_t kernel_addr;
-- 
2.40.1


