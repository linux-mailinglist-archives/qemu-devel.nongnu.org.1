Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD4573B854
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:58:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgMC-0000O3-HZ; Fri, 23 Jun 2023 08:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCgLz-0000Nj-Gq; Fri, 23 Jun 2023 08:57:32 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCgLv-0006Ki-Cu; Fri, 23 Jun 2023 08:57:30 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1b55fc3a71cso3429725ad.2; 
 Fri, 23 Jun 2023 05:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687525045; x=1690117045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZYZtbYx1tTraQPH5pnDjU5hHvHaeoahGbsVG3TIvXMg=;
 b=GsTkBAAeyWw9cvCfjF/KXwyd21YJHoMI9myzSZ3SCBkknxjrfVd9k1Fg9aXimB4tGR
 1BuWkBH++qWsmmh8/UfkNniIGt0nTRRZ2PHoOIqO/+tQGIOExzkBvl+u+a4Fb4znlKOZ
 8kovxhDxav9kJALTalBqbmAl0tD+XcPSOqIvw+KW10ayc4scs3wmF11zRq8W4PKcTHwa
 laYoK2GoA12nJop87L1ZnoBtplScLggNb6Qfxy3FvfiWaLdvJ/TtBpoGfKr2ljD6gMjC
 wicRh7p7DAJorpGWIBOqq8xFm5sJRpeq4xLn/aOX3HCG6vAjDSDUKhN6sxJ/JWGeqv0C
 kxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687525045; x=1690117045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZYZtbYx1tTraQPH5pnDjU5hHvHaeoahGbsVG3TIvXMg=;
 b=BtZcmlcQ9Bn4Pr9z4v8TcFrrRmr0PaU6x7thVfakRLCFnoGoxrs4QgiMxEBvctSE0i
 +InpI0nOcS1NLZog0uM8ZNroOT4L5he8B6aqV7omDALI5iOyDLIckcITr9TfSGNjyF1Z
 N9Er7DBMHhgbK8KXll9rpkctnIku3lueaDqUTQiheQHZJqDn6gKZOvS/P1vsyxaDNqXr
 /Vfu6qPuWjLg04dpfHUEYnjlpliuunl5RfqPj7AYY9lecP5IAN3EtXmIeDu/2ypqQfpz
 Q1MjPHX08g0fIIgtLYsSfFWDsoYLkM1sPcHk7uP3BUbeEDhfT/GI7lu1RKM4DWcEf2UO
 xNUw==
X-Gm-Message-State: AC+VfDxsENbrWeIvOr7HfM1zmUg7R9WPuxtOdQAlRO4xyqSx+Nmw9uSb
 t4mc6rUNpBNP5oiaHagCzJNUFkR5DPs=
X-Google-Smtp-Source: ACHHUZ4vOUaPfPPoZUOa//MC44t0ln7NktuWtQtxC5vIPKMvsfubCmx/OkJD3o+WRr2xdxWTQHPeMA==
X-Received: by 2002:a17:902:778d:b0:1b0:26f0:4c8e with SMTP id
 o13-20020a170902778d00b001b026f04c8emr14235770pll.69.1687525045556; 
 Fri, 23 Jun 2023 05:57:25 -0700 (PDT)
Received: from wheely.local0.net (193-116-198-102.tpgi.com.au.
 [193.116.198.102]) by smtp.gmail.com with ESMTPSA id
 b12-20020a170902bd4c00b001a04d27ee92sm7141795plx.241.2023.06.23.05.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:57:25 -0700 (PDT)
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
Subject: [PATCH 1/7] target/ppc: Fix CPU reservation migration for
 record-replay
Date: Fri, 23 Jun 2023 22:57:01 +1000
Message-Id: <20230623125707.323517-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623125707.323517-1-npiggin@gmail.com>
References: <20230623125707.323517-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

ppc only migrates reserve_addr, so the destination machine can get a
valid reservation with an incorrect reservation value of 0. Prior to
commit 392d328abe753 ("target/ppc: Ensure stcx size matches larx"),
this could permit a stcx. to incorrectly succeed. That commit
inadvertently fixed that bug because the target machine starts with an
impossible reservation size of 0, so any stcx. will fail.

This behaviour is permitted by the ISA because reservation loss may
have implementation-dependent cause. What's more, with KVM machines it
is impossible save or reasonably restore reservation state. However if
the vmstate is being used for record-replay, the reservation must be
saved and restored exactly in order for execution from snapshot to
match the record.

This patch deprecates the existing incomplete reserve_addr vmstate,
and adds a new vmstate subsection with complete reservation state.
The new vmstate is needed only when record-replay mode is active.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h       |  2 ++
 target/ppc/machine.c   | 26 ++++++++++++++++++++++++--
 target/ppc/translate.c |  2 ++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 4138a25801..0087ce66e2 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1119,7 +1119,9 @@ struct CPUArchState {
     target_ulong reserve_addr;   /* Reservation address */
     target_ulong reserve_length; /* Reservation larx op size (bytes) */
     target_ulong reserve_val;    /* Reservation value */
+#if defined(TARGET_PPC64)
     target_ulong reserve_val2;
+#endif
 
     /* These are used in supervisor mode only */
     target_ulong msr;      /* machine state register */
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 134b16c625..a817532e5b 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -10,6 +10,7 @@
 #include "qemu/main-loop.h"
 #include "kvm_ppc.h"
 #include "power8-pmu.h"
+#include "sysemu/replay.h"
 
 static void post_load_update_msr(CPUPPCState *env)
 {
@@ -671,6 +672,27 @@ static const VMStateDescription vmstate_compat = {
     }
 };
 
+static bool reservation_needed(void *opaque)
+{
+    return (replay_mode != REPLAY_MODE_NONE);
+}
+
+static const VMStateDescription vmstate_reservation = {
+    .name = "cpu/reservation",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = reservation_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINTTL(env.reserve_addr, PowerPCCPU),
+        VMSTATE_UINTTL(env.reserve_length, PowerPCCPU),
+        VMSTATE_UINTTL(env.reserve_val, PowerPCCPU),
+#if defined(TARGET_PPC64)
+        VMSTATE_UINTTL(env.reserve_val2, PowerPCCPU),
+#endif
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_ppc_cpu = {
     .name = "cpu",
     .version_id = 5,
@@ -692,8 +714,7 @@ const VMStateDescription vmstate_ppc_cpu = {
         VMSTATE_UINTTL_ARRAY(env.spr, PowerPCCPU, 1024),
         VMSTATE_UINT64(env.spe_acc, PowerPCCPU),
 
-        /* Reservation */
-        VMSTATE_UINTTL(env.reserve_addr, PowerPCCPU),
+        VMSTATE_UNUSED(sizeof(target_ulong)), /* was env.reserve_addr */
 
         /* Supervisor mode architected state */
         VMSTATE_UINTTL(env.msr, PowerPCCPU),
@@ -722,6 +743,7 @@ const VMStateDescription vmstate_ppc_cpu = {
         &vmstate_tlbemb,
         &vmstate_tlbmas,
         &vmstate_compat,
+        &vmstate_reservation,
         NULL
     }
 };
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c9fb7b40a5..eb278c2683 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -77,7 +77,9 @@ static TCGv cpu_xer, cpu_so, cpu_ov, cpu_ca, cpu_ov32, cpu_ca32;
 static TCGv cpu_reserve;
 static TCGv cpu_reserve_length;
 static TCGv cpu_reserve_val;
+#if defined(TARGET_PPC64)
 static TCGv cpu_reserve_val2;
+#endif
 static TCGv cpu_fpscr;
 static TCGv_i32 cpu_access_type;
 
-- 
2.40.1


