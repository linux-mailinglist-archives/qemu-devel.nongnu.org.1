Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF7F7B5554
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:40:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnK5A-00044t-QM; Mon, 02 Oct 2023 10:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnK4v-0003w6-R0
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:39:24 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnK4u-0000VU-A3
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:39:21 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3231df054c4so12398882f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 07:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696257550; x=1696862350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=omsG/Ra9+rfhsWhAh93SFQCufEzYS0VuVJVZ9wRmIqE=;
 b=Rxvg6srbW/yoBzlYuGc3JvjWWIwwOcA1ok+QdKg/P68Povy+9whPFNmTl9buZG7Afs
 L1xbaadO7VjtF5iAOsfDhSdAMciBhZKcz5/wNKN0LAW1E0gHmU8hV6OAuhEYEkzMFWM2
 U+MMg77UmtRiCeir3OL+v4g/dILPRU9GZ2kvVGOjL+N50Qev2thhCvw6OU9Ot2u5DhqC
 Qx52XjVZNZPE3YdhU+8rQQb7cFlyeJNvzd7XdXEjDsbnDNJ3qvMebzhaYyRMO81j7HR2
 6ljWnCIuY3nDRR7J3NFCJBDbUuDNtiqIYe/3vIJJvS7jK+s4wulh4hyubjLWY6d9gu70
 RYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696257550; x=1696862350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=omsG/Ra9+rfhsWhAh93SFQCufEzYS0VuVJVZ9wRmIqE=;
 b=S4ius3TanJ0k+6NWxPC9ZS001mpM6TnPAc1AL83y8ovavYCgC3PjiZNQQ6yKpsk/j4
 3wTQ9EEwV4mWGyxJjJ6ZHsnjEYBgnweb56+YfI2qkID7INrGQCWGvfNjFgLbmwQCUmeh
 0wlvj56PvIcfRka2V+y+NVkhagqCkEbFTW8j7gIjqlekJZJLOm7v/vyf4lC9GsbfwxmP
 2A5HxkMU5S+XajDEuIrZAuuSI9IZBIBjJuFWFf+ixEJwbPitBJAL6yB3k/tWgI946vI7
 InVDnT7Qe55fp+0OU/yLMpJGaPJe4H2iGvCDMlHnm6Kw3NPzpUu3cGObKVFeM1CyWvU8
 BilQ==
X-Gm-Message-State: AOJu0YywlFxl4nzZQsTHpA0XApDzu3wjGniqmcYpr+S3OjBStlVYeAAI
 bHzBVEEn+Hq/jAglN8wQx3jPyoLVqrW3Qne3uTCgMQ==
X-Google-Smtp-Source: AGHT+IES/q7QDPWs0R6GoqKoyumzgzJut/Z9cO/MrEz5D9ejLGOrAt9q9QHnPvr6T7lF1p6rvzm0eA==
X-Received: by 2002:a5d:68cf:0:b0:31f:e761:d47c with SMTP id
 p15-20020a5d68cf000000b0031fe761d47cmr9599047wrw.32.1696257550370; 
 Mon, 02 Oct 2023 07:39:10 -0700 (PDT)
Received: from m1x-phil.lan (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 k10-20020adfd22a000000b0032320a9b010sm20411236wrh.28.2023.10.02.07.39.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Oct 2023 07:39:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] hw/ppc/spapr_hcall: Allow elision of
 softmmu_resize_hpt_prepare/commit
Date: Mon,  2 Oct 2023 16:38:52 +0200
Message-ID: <20231002143855.50978-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002143855.50978-1-philmd@linaro.org>
References: <20231002143855.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Check tcg_enabled() before calling softmmu_resize_hpt_prepare()
and softmmu_resize_hpt_commit() to allow the compiler to elide
their calls. The stubs are then unnecessary, remove them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr_hcall.c  | 12 ++++++++----
 target/ppc/tcg-stub.c | 15 ---------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 522a2396c7..a860c626b7 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -124,9 +124,11 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
 
     if (kvm_enabled()) {
         return H_HARDWARE;
+    } else if (tcg_enabled()) {
+        return softmmu_resize_hpt_prepare(cpu, spapr, shift);
+    } else {
+        g_assert_not_reached();
     }
-
-    return softmmu_resize_hpt_prepare(cpu, spapr, shift);
 }
 
 static void do_push_sregs_to_kvm_pr(CPUState *cs, run_on_cpu_data data)
@@ -192,9 +194,11 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
 
     if (kvm_enabled()) {
         return H_HARDWARE;
+    } else if (tcg_enabled()) {
+        return softmmu_resize_hpt_commit(cpu, spapr, flags, shift);
+    } else {
+        g_assert_not_reached();
     }
-
-    return softmmu_resize_hpt_commit(cpu, spapr, flags, shift);
 }
 
 
diff --git a/target/ppc/tcg-stub.c b/target/ppc/tcg-stub.c
index aadcf59d26..740d796b98 100644
--- a/target/ppc/tcg-stub.c
+++ b/target/ppc/tcg-stub.c
@@ -28,18 +28,3 @@ void create_ppc_opcodes(PowerPCCPU *cpu, Error **errp)
 void destroy_ppc_opcodes(PowerPCCPU *cpu)
 {
 }
-
-target_ulong softmmu_resize_hpt_prepare(PowerPCCPU *cpu,
-                                        SpaprMachineState *spapr,
-                                        target_ulong shift)
-{
-    g_assert_not_reached();
-}
-
-target_ulong softmmu_resize_hpt_commit(PowerPCCPU *cpu,
-                                       SpaprMachineState *spapr,
-                                       target_ulong flags,
-                                       target_ulong shift)
-{
-    g_assert_not_reached();
-}
-- 
2.41.0


