Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FF77B5559
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:40:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnK5B-00049R-F4; Mon, 02 Oct 2023 10:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnK4x-0003y1-2m
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:39:24 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnK4u-0000Vf-A9
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:39:22 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32003aae100so1913781f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696257556; x=1696862356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bx1j9MYngwwS2T/Lm4rU/XnA8qiNHdbfi5q2qO33y8A=;
 b=fvCWN0N/z2+SKzRhh16FAGxaJQ8UlovJZ4JSbqofhHOatLWCCeIIu0uOF9Yg2omL6z
 CjGSjWiTW6B+pg0bTUl+ZWpmzHE5GA6HVkUlspypuuwOz530cxC+JtV6vk5Q2nlgj443
 wGwsYe5zEML4TDVmurhxf1dCS6R2mvimQsJkcx5mou8xbfmIqxOejTZbWqCjHYxK6CzQ
 HbIb3hPowLlqiFIuoEjUa+sH03Vw20xHylHS9L6YLS23r/rPCSSZlkMe5RezkXT9TF7U
 I2SF/kddug/RgLQaqJcDIzo8d4GOO//fRM+eU+tS60KdBfu8zWvMhA98pwC/jebKnVXC
 jGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696257556; x=1696862356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bx1j9MYngwwS2T/Lm4rU/XnA8qiNHdbfi5q2qO33y8A=;
 b=r98mJ17rHRDdhfiKGQyeskf2ZmM+hz2u51UWIwhrmQloGRF2wrJbEX3XEpafFdDPvB
 LgOMNk2tVXUzGRQoScmHRPDJASdxwTCXbb58cfZtQMKpDVoPeAcK5bWkreZ32QvTADKM
 pSGIDpMH06zMZm5Tk2U+euyueY99q+4ag/YiB4W+Qwa+itHnp6nBU7F2tq034wGdQYec
 LpLaHhzWhKLzC8sHzTXVPCX5nDrkjNyWh14Guiy3d2MeTKMlN2KoAt+bt9aLNh+yAcUH
 j9O52ACGAErPNfoFMh7ccc0ef4o0+pRsIliTQTcjZ4QyRyqklYcP5BGxg/NE5SJY7RbC
 KTmg==
X-Gm-Message-State: AOJu0Ywo1nwbC1c+beWDlyb8RmRai0B/ZTY/o3Kox24aSxgrKHbRDjyq
 bkYMDDVdYTMYXkIsmFFViRt8cUY4Zy7x+0Kz8DfxPw==
X-Google-Smtp-Source: AGHT+IFdEzpyeb8PlZwsc17fd5bIBLD19CoURLmFIpmqdxMtQ7tfme7wdP4pyJs0zLgbUJ7hEPqFJg==
X-Received: by 2002:a5d:670a:0:b0:323:1ded:311f with SMTP id
 o10-20020a5d670a000000b003231ded311fmr9102454wru.25.1696257556690; 
 Mon, 02 Oct 2023 07:39:16 -0700 (PDT)
Received: from m1x-phil.lan (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 b16-20020a5d4d90000000b0031fba0a746bsm8439481wru.9.2023.10.02.07.39.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Oct 2023 07:39:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] hw/ppc/spapr_hcall: Rename {softmmu ->
 tcgppc}_resize_hpt_prepare/commit
Date: Mon,  2 Oct 2023 16:38:53 +0200
Message-ID: <20231002143855.50978-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002143855.50978-1-philmd@linaro.org>
References: <20231002143855.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We use the 'kvmppc' prefix for KVM specific functions:

  $ git grep \ kvmppc_ | wc -l
       402

Following the same pattern for TCG specific functions,
use the 'tcgppc' prefix (which is clearer than 'softmmu').

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h | 8 ++++----
 hw/ppc/spapr_hcall.c   | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index e91791a1a9..160a5823fb 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -634,10 +634,10 @@ void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn);
 target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
                              target_ulong *args);
 
-target_ulong softmmu_resize_hpt_prepare(PowerPCCPU *cpu, SpaprMachineState *spapr,
-                                         target_ulong shift);
-target_ulong softmmu_resize_hpt_commit(PowerPCCPU *cpu, SpaprMachineState *spapr,
-                                        target_ulong flags, target_ulong shift);
+target_ulong tcgppc_resize_hpt_prepare(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                                       target_ulong shift);
+target_ulong tcgppc_resize_hpt_commit(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                                      target_ulong flags, target_ulong shift);
 bool is_ram_address(SpaprMachineState *spapr, hwaddr addr);
 void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
 
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index a860c626b7..7b0f2e2e1c 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -125,7 +125,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
     if (kvm_enabled()) {
         return H_HARDWARE;
     } else if (tcg_enabled()) {
-        return softmmu_resize_hpt_prepare(cpu, spapr, shift);
+        return tcgppc_resize_hpt_prepare(cpu, spapr, shift);
     } else {
         g_assert_not_reached();
     }
@@ -195,7 +195,7 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
     if (kvm_enabled()) {
         return H_HARDWARE;
     } else if (tcg_enabled()) {
-        return softmmu_resize_hpt_commit(cpu, spapr, flags, shift);
+        return tcgppc_resize_hpt_commit(cpu, spapr, flags, shift);
     } else {
         g_assert_not_reached();
     }
-- 
2.41.0


