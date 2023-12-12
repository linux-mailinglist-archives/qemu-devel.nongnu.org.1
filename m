Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F74A80F2D5
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:34:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5hk-0004Ld-2g; Tue, 12 Dec 2023 11:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5hW-0003vr-Mf
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:33:42 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5hU-00084G-M5
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:33:42 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40c31f18274so54060365e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398817; x=1703003617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=StICgPk89ZsN/BIJTPTbcQmjR7zrsjp+vJLVxNH++7g=;
 b=wW78ArTjZHWQUFImP32sph0nt4Ov1g0D3Vdo+j8086myT0z5mFKRgfQ8Ryi/smS4Tw
 wQy2ezVYacx5Xi52Z6+w2xMJ3aeD4C5KxtpO0k+zJVvt9ydaJvu1m78DrhZQGMfavBmi
 6/aDKRRZ8D3hpOC0xoI2orghpoiOTf1stOGTv2A1kLWDbARf56ELZPU7+kNNmBuVaFgZ
 x20Pf4AL7Rud8k5SKHxKvYByy2VSUqe7ei4a3PeHVg/+cv0L4vWMVw8onWHqH3wYpvRC
 lbVGFeAoK2LiIh2YhbM/PWqkkdGLjjhjofF6r0fogV7+d7n8zMI7htA35ywv07PMbHnL
 7hDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398817; x=1703003617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=StICgPk89ZsN/BIJTPTbcQmjR7zrsjp+vJLVxNH++7g=;
 b=xJtc5cQUqkdh/8TklL6aS4ym+jMGndIxg+mPiIGjhs9ncidU8Jd6/WrBz3sSAYsnBA
 gGdohfhp1greYLeTaR++PkGFpC929UnLk5UvsbASjl+Cm2pf1bLx3hk5IqRCLRYfuCWe
 fP4jJanZhlnGz8Zppt157DyvcM0L1v++oOj0ZAwUnJzxS5omUS8gembRurg1zgat6id9
 AHsPTXu/8DKF7QTRfAGehw+5fZyTNOwuj9XbXYJszCqKR6ydux/qmHzdQBqlCsgjNITG
 Wl8drq0ZOd+rY4JLzA3XikVddfMacQ0KjMFfQQBPoEd2SeY1APhlsruGj2UCBuzpNFhR
 Ccuw==
X-Gm-Message-State: AOJu0Yx7Id8yYSFPvX72zqXWS3dE5VALn5YcGbMZ08XpcIesv9uZpxbD
 ua7VgmZ2u9vK/Irdpf+QmMEJI9BJ5lFrumxHoDo=
X-Google-Smtp-Source: AGHT+IGNeT48Kv5OY7QRvbn24oJVr916PbbHQ2SV3jm9NH3Q/RLi/FYkalHEG/RHROS8tb+CgG07PQ==
X-Received: by 2002:a05:600c:2146:b0:40c:2b26:970f with SMTP id
 v6-20020a05600c214600b0040c2b26970fmr3255515wml.198.1702398817653; 
 Tue, 12 Dec 2023 08:33:37 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 v13-20020a5d590d000000b003363469490asm1384996wrd.111.2023.12.12.08.33.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:33:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 33/33] hw/cpu/arm: Remove use of qemu_get_cpu() in A7/A15
 realize()
Date: Tue, 12 Dec 2023 17:29:33 +0100
Message-ID: <20231212162935.42910-34-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Previous commits (in particular "Create CPUs once in MPCore parent")
allowed creating the MPCore private container vCPUs within the
container. We don't need to call qemu_get_cpu(), which is unsafe in
hegerogeneous context.
Directly access the CortexMPPrivState::cpu array.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/cpu/a15mpcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 5f28a97adb..8dccf15103 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -44,7 +44,7 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
      * appropriate GIC PPI inputs
      */
     for (i = 0; i < c->num_cores; i++) {
-        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
+        DeviceState *cpudev = DEVICE(c->cpu[i]);
         int ppibase = c->gic_spi_num - 32 + i * 32;
         int irq;
         /* Mapping from the output timer irq lines from the CPU to the
-- 
2.41.0


