Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D697081908F
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:18:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfXH-00024s-4v; Tue, 19 Dec 2023 14:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfX5-00020r-Ln
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:35 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfX0-0001ss-1n
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:34 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40c3fe6c1b5so53890775e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013208; x=1703618008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fBX5Bcn92Yspk1CoRgrc8XvrSCWWIJ0mbmpizqjvfLY=;
 b=o/AL22yb0h1EZlujE9C0HUaob0nV4nemiYukGgaODdQ74by3WZy5/jWV+2Nv0T9d24
 pSla52UmPLgY4eR+kPw4iOIROvsXVJvOjDmKGmtCFWqPz0wmMpUhv690F1xbkgRLCweP
 sg0tlcqytSzD2HldUNsQMxN+BZbusSPD8sJThwN2/WlbmtBLprO62/cRyR+2+TKU2m9f
 XRWtH8sCuTwchpSIHKsSSv+Y/YVqp066yPIe9XFtmouBgHu0Ss+AKpKOpCQUb3rR9R6G
 Ybn2JYmKH4wYAQvkynHpA1a/ldBhQ1h8HR1at1LrouoU7jwzEtEeMoIsizfpKaHEHBMX
 /9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013208; x=1703618008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fBX5Bcn92Yspk1CoRgrc8XvrSCWWIJ0mbmpizqjvfLY=;
 b=agR2qb5nE8JT4cgK6Z/If+vUAJF0TKsRlj/i8jiBg/GIX7HgHgzdMZtB0UotO0GqsW
 R7XLuPTM6sC/qTrjzQ7hJCJ0f2IVBkFH0wPKqZeoHK1sfUXvCnOOOMgp1g3Q76m09k2I
 2HdgUv5JD0eoAKbH4zTO7+XnfbkKqOcV/BNKbxdKyrOBhHXRGuXGHxlZwp9rtGQqxDgH
 GhGKaLM8Qs9ey3eQWH3hRG+0kknWBrPI9P8RKn2EDygLpYzFSq5mlvx3OPBALtnlYoEc
 Uk5CpV/XbXyCT+GZiuhRY04JZLRsTQOBx5NScwfPokRGMPD6pXO8MIJNUlIhwUoHB7WN
 J+pg==
X-Gm-Message-State: AOJu0Yzl2A0+AVdzYfpZ4/t4/+MqtIF1cRxKJdyFe0rz40xuYPYo0nrk
 pCU5FI7KpmaEA/knvsOULBwcC/TWa4wei1Pji1Y=
X-Google-Smtp-Source: AGHT+IG6i/CYPCMSV0gsU4pjKCPU12SWAOHq7qXYP+fHj8Kk25UMGcqsYsg5kXwgmPA3fRW98IVzNg==
X-Received: by 2002:a05:600c:3581:b0:40d:2853:8204 with SMTP id
 p1-20020a05600c358100b0040d28538204mr721917wmq.166.1703013208584; 
 Tue, 19 Dec 2023 11:13:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/43] target/arm: Restrict DC CVAP & DC CVADP instructions to
 TCG accel
Date: Tue, 19 Dec 2023 19:13:04 +0000
Message-Id: <20231219191307.2895919-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Hardware accelerators handle that in *hardware*.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231130142519.28417-3-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5d4796b99a8..436a43a4b7b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7649,6 +7649,7 @@ static const ARMCPRegInfo rndr_reginfo[] = {
 static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
                           uint64_t value)
 {
+#ifdef CONFIG_TCG
     ARMCPU *cpu = env_archcpu(env);
     /* CTR_EL0 System register -> DminLine, bits [19:16] */
     uint64_t dline_size = 4 << ((cpu->ctr >> 16) & 0xF);
@@ -7673,6 +7674,10 @@ static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
         }
 #endif /*CONFIG_USER_ONLY*/
     }
+#else
+    /* Handled by hardware accelerator. */
+    g_assert_not_reached();
+#endif /* CONFIG_TCG */
 }
 
 static const ARMCPRegInfo dcpop_reg[] = {
-- 
2.34.1


