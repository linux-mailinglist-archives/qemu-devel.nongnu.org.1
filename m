Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D10387E33A4
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:12:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CV9-0006qF-8n; Mon, 06 Nov 2023 22:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CUx-0006gG-RO
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:11:29 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CUi-00025J-2v
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:11:26 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5b980391d70so3941093a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326671; x=1699931471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ExjsDSAVXPHl9Xgq+QdlGUyx4ksBZYfOfahGxiLtgN0=;
 b=Ap2hmfpMBT6PTLYjpOAuZ0A8qBDjB4+T79hH9KKpGHbS8a6VLS3DWKSPt2jlL9u5Hz
 BggMsW0byngjgEoiwUgEBuOY0rymfRKir6hGJ59XzGpUDpjaOwjYU4CsEqovb5/JVZrU
 Y8ztXbKu4ruLsYv/X4gkeLwGuhtKE6zbEO/5Y1UHeP+rDL0SesY5u5ZQZjUckszF5AbZ
 HWOK1vV56IzGo0Rcq4dYMMsju8hEp0SyWlPv2RVZDov03pTgEQy9HsJgOs6gUC2LWyDT
 FeorEhYLyqByeRNGL/6BfHqw2V0oWVVW7oOeeEFdCvMp4kE48v7Cv1xaYrQjvpCfi7Eq
 xx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326671; x=1699931471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ExjsDSAVXPHl9Xgq+QdlGUyx4ksBZYfOfahGxiLtgN0=;
 b=bHmeHBJlr6Xg3dLZUJow0AiWeflxsKt1eZ1AYE0QSoF+f5R2M88vQ6+7d6AuABM6Yu
 75HS2SBRIxqNskRIPJptswk/0qO12TxONY85/pfBY15pz7lTFBtyO03yKsp0g9EYSZiw
 hSdROZFZVBGxurAkRv/SwEkQVY2BxTIcA5Zzmr9menu6AV+94z+2y4tjbDt5iQwOTmbZ
 WnXr+rveKYJR2gNw/0rg/ECMptxAUecUyR+zB2qWoi33OT2P1NpZlQdfaBdcjB5kHtYQ
 R75LEC3/i4/TQhkNAwr5Rzphf3FxHBfouk+gX5ASvTYfbAK/vaIMZUkp7kZJ44qIFJRE
 /dXA==
X-Gm-Message-State: AOJu0YzMSgY6o9OPO6MtAnoqne2ZXWn5v3EuQxRzlwZ/zkl+7YWMm5qF
 uM2h6z5FdINwMgwxZ1PDQDKhImVJcx1VBRaOSCQ=
X-Google-Smtp-Source: AGHT+IGYWxJfswnnqs8cW/pAmCAem7Ec2XD2tb3bWww1+tHS49WbF81apakCroU/OdoAXxkyxxbEbQ==
X-Received: by 2002:a17:90b:4004:b0:280:94e8:99f4 with SMTP id
 ie4-20020a17090b400400b0028094e899f4mr19691876pjb.46.1699326670742; 
 Mon, 06 Nov 2023 19:11:10 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 gw13-20020a17090b0a4d00b0026f4bb8b2casm6246253pjb.6.2023.11.06.19.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:11:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 83/85] hw/pci-host/astro: Trigger CPU irq on CPU HPA in high
 memory
Date: Mon,  6 Nov 2023 19:04:05 -0800
Message-Id: <20231107030407.8979-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Helge Deller <deller@gmx.de>

The CPU HPA is in the high F-region on PA2.0 CPUs, so use F_EXTEND()
to trigger interrupt request at the right CPU HPA address.
Note that the cpu_hpa value comes out of the IRT, which doesn't store the
higher addresss bits.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/pci-host/astro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index df61386bd9..b19f0917c5 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -384,7 +384,7 @@ static void elroy_set_irq(void *opaque, int irq, int level)
         uint32_t ena = bit & ~old_ilr;
         s->ilr = old_ilr | bit;
         if (ena != 0) {
-            stl_be_phys(&address_space_memory, cpu_hpa, val & 63);
+            stl_be_phys(&address_space_memory, F_EXTEND(cpu_hpa), val & 63);
         }
     } else {
         s->ilr = old_ilr & ~bit;
-- 
2.34.1


