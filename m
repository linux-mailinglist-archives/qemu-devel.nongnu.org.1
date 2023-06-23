Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C94E73B852
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:58:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgMK-0000W7-QF; Fri, 23 Jun 2023 08:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCgMI-0000Sn-2M; Fri, 23 Jun 2023 08:57:50 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCgMG-0006Ri-7j; Fri, 23 Jun 2023 08:57:49 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-54290603887so382586a12.1; 
 Fri, 23 Jun 2023 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687525066; x=1690117066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vPVziyxEWerMj/TzPold0Nq7Z0giPqF+Gq4GzlvWGMI=;
 b=eNCHveKUJa24DCz9/Hh2WWkkHwDJ7Lbo0o+i5RVTBnyKI+Uugp2oveX+mBY4Ovk3nr
 S2Lg/PxVYoxkAtJ6WHOhZIC0BiwG827dVz9iRgSGD+vr+Ed+yzPzHcMG98W0cDJJ3bBx
 zqo8sa9+I7L3vf39zUlpJPp7W7jRePbwS7h1opmfNL+yyDBtlqgIw1h66jwnWK5iMZzQ
 z9kvnEWgw7cnjBLw8LKV0WNxMtDWtR0jXrj6veVOoVEm3byuhCvk+9yVMX+06opBiFX/
 99rinYQhceQAI0UQgQhS+JCH0ZRPYjb6WcG/sSLLU3GbNgZ9l3agG8VrWo39eiDQgG/b
 F20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687525066; x=1690117066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vPVziyxEWerMj/TzPold0Nq7Z0giPqF+Gq4GzlvWGMI=;
 b=ce8ynNRkjo90nGML4+5r2BxbbxXJ6Jsa3+bFpoDx45To36g6/f2gvqCCR1Fwlbgf+Q
 wbmlN1j5Up6GZQeO2Ihbh9eFF0FnfL6EterfvDfPOpO0ANJG4AVHzMFnn5KCl6J4lYVQ
 UnH6Pnp1FZ8C2V0bwkccuXMyal8oFvr6Nt03f1g1VHvD0vKufgKAmAS7e7ey2s+jlsfH
 idHLz5QrsVx1pnzKUWN6p3X1WbdRS/GSgEzr8y3Flm3zp9RVpY521CrQhXYPAWCQ720A
 VlhchR0ADYumfpScqTn4HHhL2+tlzlV2xlYGGgnCpx9U8VQ4OnfItZfD17Gx0RDA52oR
 tKTQ==
X-Gm-Message-State: AC+VfDwZvhtReJRxfr4Dj44TYIo0Ks8U13UcpGqvunV7kSoPf2+D6Nue
 t2rdUUouToPvCecQCOQ2xkz43x2usHA=
X-Google-Smtp-Source: ACHHUZ7mQMEIz053ceNHRJFcgcwKn5bCe7D2Xu+HI+Tg/FkxWdYNhNI/HAUrQm455LTmsJ6zWxZcoA==
X-Received: by 2002:a17:902:7c92:b0:1b3:91f7:4883 with SMTP id
 y18-20020a1709027c9200b001b391f74883mr9326153pll.46.1687525066227; 
 Fri, 23 Jun 2023 05:57:46 -0700 (PDT)
Received: from wheely.local0.net (193-116-198-102.tpgi.com.au.
 [193.116.198.102]) by smtp.gmail.com with ESMTPSA id
 b12-20020a170902bd4c00b001a04d27ee92sm7141795plx.241.2023.06.23.05.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:57:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 4/7] spapr: Fix record-replay machine reset consuming too many
 events
Date: Fri, 23 Jun 2023 22:57:04 +1000
Message-Id: <20230623125707.323517-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623125707.323517-1-npiggin@gmail.com>
References: <20230623125707.323517-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52a.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c         | 12 +++++++++---
 include/hw/ppc/spapr.h |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d290acfa95..55948f233f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1017,7 +1017,6 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
 {
     MachineState *machine = MACHINE(spapr);
     SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
-    uint8_t rng_seed[32];
     int chosen;
 
     _FDT(chosen = fdt_add_subnode(fdt, 0, "chosen"));
@@ -1095,8 +1094,7 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
         spapr_dt_ov5_platform_support(spapr, fdt, chosen);
     }
 
-    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
-    _FDT(fdt_setprop(fdt, chosen, "rng-seed", rng_seed, sizeof(rng_seed)));
+    _FDT(fdt_setprop(fdt, chosen, "rng-seed", spapr->fdt_rng_seed, 32));
 
     _FDT(spapr_dt_ovec(fdt, chosen, spapr->ov5_cas, "ibm,architecture-vec-5"));
 }
@@ -1649,6 +1647,14 @@ static void spapr_machine_reset(MachineState *machine, ShutdownCause reason)
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


