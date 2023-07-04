Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A236747482
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:52:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhNJ-0004qQ-U4; Tue, 04 Jul 2023 10:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhN7-0004Ga-0s
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:51:20 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhN4-00039M-Sh
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:51:16 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3141fa31c2bso5550938f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482272; x=1691074272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XqL6wbsoBKcWRQEkNfzmSMwKA1cCT5j0UC3IEqUISV4=;
 b=FQZ+59a8s3fLXBux9rcwdzHsa/HQWeASBJLIRjGIQB21cjKiVuleUhShtM+yRaVodA
 i20u2SqR6j1ZHtFeR+1JzzXt07b1gAUQLl1v1Gfc2Z1Q/pkDn3uIq7+Z0CFNPpafUY57
 j5rrjg+WZdneduS62OoeiLHplR1c7y8tK/LfJzmtd1HQlEKfHrzHhxB7AzJf5aPzzf7A
 MhylTQ6ig1e4Iw6RBRCWgp8aO5ZhwWN1xfN3lWsaXGru2dq+ocTrZnMl+2EsphPMsSO/
 WE/vaFiZ97ZY8qC90vmHI5TY5P3l9EMwhwwmCI/9H1xlPaAoM1Al6tqaIbsoN6cXCh4o
 nfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482272; x=1691074272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XqL6wbsoBKcWRQEkNfzmSMwKA1cCT5j0UC3IEqUISV4=;
 b=hxitxY5v7zoIzPW1P3ZpPZKgWFg7HVTrqWZ4KtwpDcWlIoJ2/bwzZAfUBCnweCPA2P
 9/XkM0woSG7D4tGpdFraknyQHqNynX0lK6IIh+5p9OlOybUuO8aSh8/CPQi885eGEE39
 PofjXvv3CEG9UzNPVc6mq1gHUne0F9UW6u4BrcjzFXp6MGzMXIsiq8pF5jhkN06J2Hmf
 nuruoBxKiyTfnwdxR0eW+FdYcuo4EGwZPKJRbSNwRdPpdJsTyjUjfRavEme6etaggV9m
 7AOPTNtDe2c8zwPSxLziOPhU8548RSMlKa4//YA+9qbbhjVngeuTSR9jLtzJ9HLVcmwh
 prfg==
X-Gm-Message-State: ABy/qLb53euOO2FYLXSY1pcNyGx6Y3ajJM9f9sOINtL3slXngVmBtYOk
 bOLefEzw3UJr9toj0pn3NHHNr0bg9845lIGr8QI=
X-Google-Smtp-Source: APBJJlHqIWKZlxuRlbhvpGLLxJ6zbSWAgoCwiCbF414g4sJBoAVDwYYACDcVN2XEyLM2hYasBnIxmA==
X-Received: by 2002:adf:f049:0:b0:313:f708:5d4 with SMTP id
 t9-20020adff049000000b00313f70805d4mr12107156wro.24.1688482271995; 
 Tue, 04 Jul 2023 07:51:11 -0700 (PDT)
Received: from localhost.localdomain ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a5d68c5000000b00314283a525bsm10137803wrw.93.2023.07.04.07.51.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jul 2023 07:51:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/19] hw/timer/arm_timer: Convert ArmTimer::freq to
 uint32_t type
Date: Tue,  4 Jul 2023 16:50:04 +0200
Message-Id: <20230704145012.49870-12-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230704145012.49870-1-philmd@linaro.org>
References: <20230704145012.49870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

In preparation of accessing ArmTimer::freq as a QOM property,
convert it to uint32_t (so we'll be able to use DEFINE_PROP_UINT32).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/arm_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 4ef34b0f60..2b5fb75577 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -33,7 +33,7 @@ typedef struct {
     ptimer_state *timer;
     uint32_t control;
     uint32_t limit;
-    int freq;
+    uint32_t freq;
     int int_level;
     qemu_irq irq;
 } ArmTimer;
-- 
2.38.1


