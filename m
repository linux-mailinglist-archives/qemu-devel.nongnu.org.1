Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C578828C34
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:12:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGZ5-0003Ku-Pg; Tue, 09 Jan 2024 13:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGY0-0002RY-7X
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:09:57 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGXy-00041S-Kb
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:09:55 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3368ac0f74dso2517224f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 10:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704823793; x=1705428593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdirajlt6qC945MCVDYIpUTSXSVbweTZjiyf2mppVOc=;
 b=n03HaZy8dpwhV2t9I+FFWwD07mgb9tZCRvrVXgc/16pUTxILRYRnYLcqsHlme9Cg1V
 9R9xeI79EZvS/OLxMAuLIVKytWVtFEK98eWOG3DzLZ9Lyzpx2yZxlOWNzPmz5pKivide
 t2E1NDuOXTvujE/jw/Mf9E76XEdkgh44zVYpukyttJxFetBlWgRbALHgRcpLkinvLjHa
 szAIImkIAwXp9qUPUnes5fOQ48aZGDo64nBW81ddrKoZaKC1Mh05157sYdhHEpODZC5V
 9LRdtdu/7Kbw6hGAo7VlsFTtWltlTgRW8+iLn2hTJF2YiWrW4+ObPxElIk4nBBYLX2KK
 SZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704823793; x=1705428593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mdirajlt6qC945MCVDYIpUTSXSVbweTZjiyf2mppVOc=;
 b=ZNXgV5SkTd23AYxpdW5utWJH5SdDgV+7HkJrTzo7XY2CMLrqe8mD7zc7UC+lqxg1qi
 p3JRBzaAo5IMa/Suiy6ZCWyyTch5/Ra4kN/iDCKZugQA1CuqwtdhKk22pY/B8zNruIW2
 NESNEx00e6j65LH6PIZe0WhqZWdGOqAzy/X70kUohTZSV4Z0W3xg2qj4Xr9JfSN1MSgb
 1t2FMBB+wWg92k1sIRjr2udqRLGYcOQaLR44kMNyuxP5vxTVo2dGr6NQEvdqkTSGhqtJ
 OdCtBgOYdIlPYJ/zH+jr1qPnuwzxMGaq2B4TduD83Ui8g8Lc/6TuB58c8RDCubNtFq4l
 zYLw==
X-Gm-Message-State: AOJu0YwAaDOBXGlsYMrYMqI+EupTE2HLVrgbw9FNbRmIrYyeREd7TMqy
 TYGXzPdaiiTkju5uMawOIylN/J4AXl4vyLPINVxPyHQrd/tGPw==
X-Google-Smtp-Source: AGHT+IGSlfD/AASYnIgmejOk0iHyGJgsd+FqsvLLK6i9yqyWGoarP2azSOwVLiLLMDO0R2QtEouk/w==
X-Received: by 2002:a5d:4569:0:b0:337:509c:f1c0 with SMTP id
 a9-20020a5d4569000000b00337509cf1c0mr933765wrc.46.1704823792796; 
 Tue, 09 Jan 2024 10:09:52 -0800 (PST)
Received: from m1x-phil.lan (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 c2-20020a056000104200b0033642a9a1eesm2995571wrx.21.2024.01.09.10.09.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jan 2024 10:09:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/14] hw/arm/armv7m: Ensure requested CPU type implements
 ARM_FEATURE_M
Date: Tue,  9 Jan 2024 19:09:18 +0100
Message-ID: <20240109180930.90793-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240109180930.90793-1-philmd@linaro.org>
References: <20240109180930.90793-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

ARMV7M container can only accept M-profile CPU types.
Check requested type is valid once to allow further simplifications.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/armv7m.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index d239468558..8900730e53 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -300,6 +300,10 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
+    if (!arm_feature(&s->cpu->env, ARM_FEATURE_M)) {
+        error_setg(errp, "armv7m: CPU must be of Cortex-M family");
+        return;
+    }
     cpudev = DEVICE(s->cpu);
 
     object_property_set_link(OBJECT(s->cpu), "memory", OBJECT(&s->container),
-- 
2.41.0


