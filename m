Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D877667FD
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 10:59:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPIn3-00075x-1O; Fri, 28 Jul 2023 04:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1qPImt-00075H-27
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 04:25:27 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1qPImr-0001vR-Fp
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 04:25:26 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bba2318546so15197375ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 01:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1690532724; x=1691137524;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FUEm8usTciSKMJQUzkFqUCxcOyDB4ArOFF/qN+1sEbc=;
 b=S5nbYp3bJ8XsySFOfA84yZc/k1t8hi64uE19K21SQMgqsuIN8fbMdU4uxTiyI/6QhX
 OdsnKIxA/50UfJxQ4iqoBH62EdHwuDX1vrkc/4/UYZDnZ6YaipPfU588PlA/RTh8C55T
 j4Pyc7yKOtHe3uGqjB+OS0o6CGh4Ch7GfgjSPTvOdwO7Xf5dGY8oJuDyA9gAyZ+TPlfx
 pClMS7K9YVf/8a4jD9gJ1g4B90UGhlFmZyqTzDPs9nxSwdQxI70dibaVdRY6z/89q/sB
 KJSu3p3vHHRTqgS0okZNv5L3YEcJdSy+YM2l8E6+VZPzaLWbC7KeZ5YZze3wwH1vW3XR
 sfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690532724; x=1691137524;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FUEm8usTciSKMJQUzkFqUCxcOyDB4ArOFF/qN+1sEbc=;
 b=g2bOhonIRmmycmC5m0Md68mSlMHd33bcfaREp/mWTB5mFF0GJOoe2zHPw2sOqAIm/3
 R5rwGDGgmldWNlbaktQ+5Un3oXvoDEXH0LzKiwRv0RWg+qlTDeIhF4kQ+f698xKO2xNa
 KnB8yE/TPT67Ef8wcV26ZFr7II6pjXe5P+tfEtS1R8jmC7zlUh6gEhdMG88UcXSKIT25
 ROMd/NJeS4Xt1fDxMfijXFWLPYqq5eeZnOEu52kx5xKTONG+YeX8ijJFYA2ON+vt1Mbs
 s4BF2iWyW62q4XGlasdvOszZb5FEDrwlE3cR003HzaMIeLz6tMbvgLVL+s0Lqy2+6k6+
 IMhA==
X-Gm-Message-State: ABy/qLZj8yYYcuUUFLnsTnEyNFsltvGqo/OScSpNPEPvpf4u0Kj/Hd9U
 R/5jYWzGjYQiqI+M5Cwk95WLiXis3sllVtdxOFcWuETazEC9V+3EcniHTGS7xYBImiMi9ZfcW2R
 Wob967tosWYXt5obkc42dicypw2+hRFET5Etd1jMbPR3ZdKRl4R8XVgfSkRHECJpJNNqq4L5957
 0t+A==
X-Google-Smtp-Source: APBJJlGm5pSZPXeaQOQ3DzRP0mAnHkxZZXdPp1pCOLaM5FbxzEd2aoDDSqTXKMHDkirFETh8T++54w==
X-Received: by 2002:a17:903:32c4:b0:1bb:1e69:28c0 with SMTP id
 i4-20020a17090332c400b001bb1e6928c0mr1234677plr.30.1690532723372; 
 Fri, 28 Jul 2023 01:25:23 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 w8-20020a170902e88800b001b53be3d956sm2985213plg.167.2023.07.28.01.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 01:25:23 -0700 (PDT)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jason Chien <jason.chien@sifive.com>, Anup Patel <apatel@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/2] hw/intc: Make rtc variable names consistent
Date: Fri, 28 Jul 2023 08:24:39 +0000
Message-Id: <20230728082502.26439-2-jason.chien@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230728082502.26439-1-jason.chien@sifive.com>
References: <20230728082502.26439-1-jason.chien@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The variables whose values are given by cpu_riscv_read_rtc() should be named
"rtc". The variables whose value are given by cpu_riscv_read_rtc_raw()
should be named "rtc_r".

Signed-off-by: Jason Chien <jason.chien@sifive.com>
---
 hw/intc/riscv_aclint.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index bf77e29a70..25cf7a5d9d 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -64,13 +64,13 @@ static void riscv_aclint_mtimer_write_timecmp(RISCVAclintMTimerState *mtimer,
     uint64_t next;
     uint64_t diff;
 
-    uint64_t rtc_r = cpu_riscv_read_rtc(mtimer);
+    uint64_t rtc = cpu_riscv_read_rtc(mtimer);
 
     /* Compute the relative hartid w.r.t the socket */
     hartid = hartid - mtimer->hartid_base;
 
     mtimer->timecmp[hartid] = value;
-    if (mtimer->timecmp[hartid] <= rtc_r) {
+    if (mtimer->timecmp[hartid] <= rtc) {
         /*
          * If we're setting an MTIMECMP value in the "past",
          * immediately raise the timer interrupt
@@ -81,7 +81,7 @@ static void riscv_aclint_mtimer_write_timecmp(RISCVAclintMTimerState *mtimer,
 
     /* otherwise, set up the future timer interrupt */
     qemu_irq_lower(mtimer->timer_irqs[hartid]);
-    diff = mtimer->timecmp[hartid] - rtc_r;
+    diff = mtimer->timecmp[hartid] - rtc;
     /* back to ns (note args switched in muldiv64) */
     uint64_t ns_diff = muldiv64(diff, NANOSECONDS_PER_SECOND, timebase_freq);
 
-- 
2.17.1


