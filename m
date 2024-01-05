Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0177825714
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:49:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmRG-0003re-Uc; Fri, 05 Jan 2024 10:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmQ3-0006db-QB
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:47:36 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmQ1-0004Fv-9S
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:47:35 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d2e56f3a6so4032425e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469650; x=1705074450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QQ/o8R5/vZPDmg4xKxtglyBmLRK3vBkRVa+vx66Ggc=;
 b=gzNgdQPXPyjo0e59+p2+dOCfBNfxyuQQCVoz1hYTsUQgktONxBoVkdqtkzt2RqWLX0
 UphElLe0/bONr7wFZY77YWN/JtT49wtgD3wopOUbKNxq818eaLpq04F28C5XYAyVEEDv
 4KymZ7QFi3RxRWrHaKFSscJ4lGAuUQVfqTz7cajRwr+b3zxWpIaNt5A+H0FpClFs/tlK
 vLlzlloKi87hyq0XFqCBZW65CQNFnJq7Y2blXFKtOcZ1Q8ujbyjZJgazTpGvA7NihO+8
 drOCpcCrZDE8Vs8YiKYiq+dvTYLaDkjkvjtncRRMbmtPF7N/lXgZBcsX8Tuhts15qdCn
 Tgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469650; x=1705074450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3QQ/o8R5/vZPDmg4xKxtglyBmLRK3vBkRVa+vx66Ggc=;
 b=g5Ge2VmNG8Wbs8s9aPIYopu4ZGS4rgGx66DX9Ggmuy/kE4MFOh+mPmXTwvQeEm4AzL
 ipLRxU9pph0QMrGN+bouop0i/Qj3imo8bxLbyNLsbsyZoeoFluLuLLegLrCjgri4WZqb
 tnS7MA0EM0zj1sgMbhc2W+dO9JCNrfv7lGLQHFa8G6MmuiHt09Lqvnc5ww08LOtvJwBy
 DdbMAed8vDqz+mopEJxXvEUJYc4PJbG+ogpKC7BWvebOj7H1sRK2idUcWA2e1EImHmMn
 x+e58JUeb1LFinJPKtBy5+o8c9gIZv/x/iu0du9acvDqVnenXA7+GLvPPO9vvq6MfgxP
 jyiw==
X-Gm-Message-State: AOJu0Yy3aB1ZRRAHAMZrTXTMszQeAJPRBQm1wiW5eM2rlbLrfTLWeqnM
 grmSnSVy11rm/1/NlZCvi6t8cg4av10onOFA9m5TRM+EDZ8=
X-Google-Smtp-Source: AGHT+IE0NVRH1AsKnMTaK60vgA9dgB0tn9TEVo7as9L+MBZ95qRbYdTbsnbpI/cUI4AvDNkqubBNdA==
X-Received: by 2002:a05:600c:3112:b0:40d:62f7:3097 with SMTP id
 g18-20020a05600c311200b0040d62f73097mr1318661wmo.130.1704469650602; 
 Fri, 05 Jan 2024 07:47:30 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 cx12-20020a056000092c00b00336b702af06sm1613139wrb.16.2024.01.05.07.47.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:47:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PULL 40/71] hw/ppc/spapr_cpu_core: Access QDev properties with
 proper API
Date: Fri,  5 Jan 2024 16:42:33 +0100
Message-ID: <20240105154307.21385-41-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

CPUState::start_powered_off field is part of the internal
implementation of a QDev CPU. It is exposed as the QDev
"start-powered-off" property. External components should
use the qdev properties API to access it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-Id: <20231123143813.42632-2-philmd@linaro.org>
---
 hw/ppc/spapr_cpu_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 710078e9f7..5aa1ed474a 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -306,7 +306,7 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
      * All CPUs start halted. CPU0 is unhalted from the machine level reset code
      * and the rest are explicitly started up by the guest using an RTAS call.
      */
-    cs->start_powered_off = true;
+    qdev_prop_set_bit(DEVICE(obj), "start-powered-off", true);
     cs->cpu_index = cc->core_id + i;
     if (!spapr_set_vcpu_id(cpu, cs->cpu_index, errp)) {
         return NULL;
-- 
2.41.0


