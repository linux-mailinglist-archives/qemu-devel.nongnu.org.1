Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BD4747486
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:52:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhNI-0004df-Rj; Tue, 04 Jul 2023 10:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhMs-0004AL-8v
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:51:11 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhMo-00035j-8z
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:51:01 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3143b70d6easo1844610f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482256; x=1691074256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgWYaksSJaOtaePi8Z6uVzlBPseEZMVW7Vioeltdwwg=;
 b=lkAdqkx653X4o9NMfbfuxXpqzYhzCsDeI2xC9GFs59Ec1kHZggnAe4xQW0aUPyma01
 OrFHMnGFq7Qzm7HjHPmUGU3MhRpc3IssBFA4GyI14PUdKodRoLtLPRTq4sL234fGdxe6
 8NOESHFt8DT9pYTiQFuVpLami0HE+PfHWdbQVQOihe8z5cl60mLG4xKVH5oNWz4b6am9
 ckfKJ/aNlrx7baamol6TweP86vjBw9x9h/3oZ07GZAIYFQT8XjA57qQxJ5WuHFeyBIJN
 AC6BWIKmmIC7BVH+IWO1bVs2GXtrORlJFAes0EyUBMcdcbt0ot7x3Wa9h0w8zyQzjG+q
 F8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482256; x=1691074256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dgWYaksSJaOtaePi8Z6uVzlBPseEZMVW7Vioeltdwwg=;
 b=e6gHQCjApemIqW6H09pNEnf4KcVvGhiV8T7scndBEec3E3Vp1qsYBMGW0MIKAqzPmj
 +xKlR++QvplCdvAWItVqEesoEAVfqWrJvmUmwq8C4IdbTQlmk4riqeBNC0q1/Q0CXMTc
 hvdOYwLf6Nmog/vWFE3lg4FWrifyMzC2RM8qdQlhhw4PCdKUa9XPmvH614twTiYejIG0
 I7dH6qr+v2oUCrbifOL72kF4t8IcY77yrBE3B/T8k0mqSEKTd79YaNVdGOHNyI1slbkm
 WJAB5Qm89aQUojpPDg+K7b2tXvXb7p6Gitv1sTbgvsmM7/q2PrmXqEUEDDeZ7H/MwAll
 1TGg==
X-Gm-Message-State: ABy/qLaJ0EaYHOQclqbKTBxYgkyAMmceqdffToNNkvj0gzl3TJVMHZ8M
 8MKwMPJOnY/JXElR0XH/2gKCJC1of0bIMvnY74M=
X-Google-Smtp-Source: APBJJlE/oKzRCge3Y3LoKcEzj2u0odAs0ZcmuSmfv4lkpO66Hu+sYHxV6jjTJlJqXRdm2alQ2achbg==
X-Received: by 2002:adf:eb8c:0:b0:314:2ba3:15dd with SMTP id
 t12-20020adfeb8c000000b003142ba315ddmr8043553wrn.16.1688482256402; 
 Tue, 04 Jul 2023 07:50:56 -0700 (PDT)
Received: from localhost.localdomain ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a5d4908000000b0031432c2fb95sm7226101wrq.88.2023.07.04.07.50.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jul 2023 07:50:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/19] hw/timer/arm_timer: Extract arm_timer_reset_hold()
Date: Tue,  4 Jul 2023 16:50:01 +0200
Message-Id: <20230704145012.49870-9-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230704145012.49870-1-philmd@linaro.org>
References: <20230704145012.49870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Extract arm_timer_reset_hold() before converting this model to
QOM/QDev in few commits. This will become our ResettableHoldPhase
handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/arm_timer.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 8dae845998..0d7fac4d78 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -172,13 +172,20 @@ static const VMStateDescription vmstate_arm_timer = {
     }
 };
 
+static void arm_timer_reset_hold(ArmTimer *s)
+{
+    s->limit = 0;
+    s->int_level = 0;
+    s->control = TIMER_CTRL_IE;
+}
+
 static ArmTimer *arm_timer_init(uint32_t freq)
 {
     ArmTimer *s;
 
     s = g_new0(ArmTimer, 1);
     s->freq = freq;
-    s->control = TIMER_CTRL_IE;
+    arm_timer_reset_hold(s);
 
     s->timer = ptimer_init(arm_timer_tick, s, PTIMER_POLICY_LEGACY);
     vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_arm_timer, s);
-- 
2.38.1


