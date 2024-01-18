Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEE0831AA8
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 14:33:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQSVT-0004wm-VK; Thu, 18 Jan 2024 08:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQSVP-0004ui-Jt; Thu, 18 Jan 2024 08:32:27 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQSVO-00021u-08; Thu, 18 Jan 2024 08:32:27 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5cfaf7ef393so27029a12.3; 
 Thu, 18 Jan 2024 05:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705584744; x=1706189544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=18FTOOuT/UCqVddP9iv7m0yXr2Iq7DkLdl484P+3gU4=;
 b=BWgQu8bCpu/cab5dZfr0KSo+BKsAqcgxNbN8olwOfGwaPoMlirqjJSBbRyZfdoPcz8
 3B7Ji1BNf6ioe1Ddn6JVi5z39sOU0avsPd0QmCvI7aqkrN1vpO0+1ABkSv6af68Z8ohR
 OndV9XYZ5Fi5zM7O74YKgzdhNpO0+HCCAvXPOqV3yQtjkuSrl2hPe9c5RvLIuM2WYVYY
 tGEEZhvAshPgDqlo9XX43Di0eI3JbxObW1dcYrVrGpseBeCfygbk0HwBEmqyZSrUlk2B
 EZSTA4Sd3vtC6xZyWzKF+s9AAeGv3t8lJ2OORRdqFiyBKPb5asehplgeuG8Gk3ME/SAl
 UXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705584744; x=1706189544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=18FTOOuT/UCqVddP9iv7m0yXr2Iq7DkLdl484P+3gU4=;
 b=vrGrleZu0DgzYvQYFECpa+BGvb7gmgGlBzR47KnfBQMsON6RCPkSDATDrojDEFqg/B
 qJfmdqPgejP8BUJEQrmRtphO9RNTAKVyqz8DL4Xqj1GgBNBXEX0fYEDp+5IG+Xq2QZYG
 2a9fmW31mgtGluxb45HQ39q/l/xCoIHrtIk/xCiuDrmZxLWfTXf8qg8JB21ZDPiesBJW
 wlJ62PtkdpJ63H0b6DCaHBsWmSutm0QfCV2oycHW10fMlMAR+HYMjqEdTXaZVTnCVkIl
 6s8b1VnC4awdmF4cOCQfte/Ly2NFfTXAVsf0dSOZ444xxy/XHUuccEaJEG405igif+dA
 F43w==
X-Gm-Message-State: AOJu0YxB2R0ltrgMxsyv0tOO/hLtdLnrJZ/yBVLuPsd9FTRThFLYFFNy
 Krm8t3Atot/yXF7eQI2jEm30rNAZfLSSupRVSmoDJze6r1M9zRKyHzumS8+U
X-Google-Smtp-Source: AGHT+IFgMMNigPLr1LvhHfY0YHY6OkeylsVRkWncMy6MOmpxq7YZRfgQJVVsz8OtBXyVFEd0x16MoA==
X-Received: by 2002:a05:6a20:a9c:b0:19a:536e:64f5 with SMTP id
 b28-20020a056a200a9c00b0019a536e64f5mr536679pzf.67.1705584743913; 
 Thu, 18 Jan 2024 05:32:23 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 a19-20020aa780d3000000b006daf1ded817sm3282551pfn.209.2024.01.18.05.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 05:32:23 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] hw/ppc/spapr_hcall: Allow elision of
 softmmu_resize_hpt_prep
Date: Thu, 18 Jan 2024 23:32:04 +1000
Message-ID: <20240118133206.158453-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118133206.158453-1-npiggin@gmail.com>
References: <20240118133206.158453-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Check tcg_enabled() before calling softmmu_resize_hpt_prepare()
and softmmu_resize_hpt_commit() to allow the compiler to elide
their calls. The stubs are then unnecessary, remove them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_hcall.c  | 12 ++++++++----
 target/ppc/tcg-stub.c | 15 ---------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index fcefd1d1c7..0d7d523e6d 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -123,9 +123,11 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
 
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
@@ -191,9 +193,11 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
 
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
2.42.0


