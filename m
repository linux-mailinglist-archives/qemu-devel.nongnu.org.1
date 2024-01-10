Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2C882A190
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 20:55:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNeeQ-0007Fm-NP; Wed, 10 Jan 2024 14:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNeeH-0007A4-PV
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:54:05 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNeeD-0001uU-7T
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:54:00 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e549adb7dso17541575e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 11:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704916434; x=1705521234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=znfL4d0kUd7PQLWgd/IbU4xVCADxWCmjPBLUUJRZlJU=;
 b=wF3rX38z1dsmSloN5abxKFipX8YVQJQI1LygNeteVgdfIsrCuw/rxjwbSHoe0eQIPi
 +wERr4+0vh+mNS0cu0nFjCBrwOAQTg3HqusFA9UVP9NkJfNijKnkxe8gX85SdYUMGAAK
 LI8JIoRIHQ0B8JNdQdvlozkMy9nEy+PJULDNILmvgwNO6BfFgcG9ue8hpLnj3RBEu+RN
 dtKwIhOGgBXHMOu/D7tIMGYeNBFTr6AKmm8zF7RWuf3/jW5whzU004vGI8mLREmflVM8
 fhExrvcwK0p4zaCajEyGJBpus9eBVhpQDprAtDbmVDIxjE17+uO42Vmc/Oywp5O2Tknl
 vKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704916434; x=1705521234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=znfL4d0kUd7PQLWgd/IbU4xVCADxWCmjPBLUUJRZlJU=;
 b=KhCP0Rt5kpv5fYLgLolz74UZ8m17f+gsVN+38ZpKHeH6ajw+73UwQ4Ldpj0saumeZp
 J49sdR52R+pu8qMmztpWXPvCVGRcN4y7inNOIqqWF4Q7tP20/f3YOSdDmgBqOFIG4Vn9
 lSADameOKFagNhHmV8+vIblrhDxHkaFcrnR7M9yeXI8GXmSs+VkZHQ2vVHGivgNQPelm
 dx1TEcXiNvPZz28cpIfAlK+0ddmPX3mXpOWv3BrJZNf1QadnOuYX+o5NR5GHZMl1R0yv
 aWekQBVQrruEaij77yaineJKOlM5uvmkSCjJIswB5CyYabOQd+sK7vpJ8DNKinZW5PLb
 W51Q==
X-Gm-Message-State: AOJu0YxfC0QqI0oXVejUkXF6tGtLiAVs99ooBsBKblhfQuJGuUvS6+pw
 5bfz96jU/XbrJ33MXCSK0v2AYoqTjmrX/OPsNOeD/dRbIyQ=
X-Google-Smtp-Source: AGHT+IEwhsl63YMeMHDE72bK7yDwI/VR1JUfr9Ys0DT8f1XK7IAeXYfMYjPWX4eyCLA2pAjZhuLKiA==
X-Received: by 2002:a1c:770b:0:b0:40e:4a5d:67df with SMTP id
 t11-20020a1c770b000000b0040e4a5d67dfmr856723wmi.4.1704916434808; 
 Wed, 10 Jan 2024 11:53:54 -0800 (PST)
Received: from m1x-phil.lan (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 s15-20020a5d424f000000b0033743c2d17dsm5594643wrr.28.2024.01.10.11.53.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jan 2024 11:53:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 03/14] hw/arm/armv7m: Move code setting 'start-powered-off'
 property around
Date: Wed, 10 Jan 2024 20:53:17 +0100
Message-ID: <20240110195329.3995-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110195329.3995-1-philmd@linaro.org>
References: <20240110195329.3995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Reorganize a bit by first setting properties which are not
dependent of CPU features (and can not fail).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/armv7m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 8900730e53..b752049add 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -308,6 +308,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
 
     object_property_set_link(OBJECT(s->cpu), "memory", OBJECT(&s->container),
                              &error_abort);
+    qdev_prop_set_bit(cpudev, "start-powered-off", s->start_powered_off);
     if (object_property_find(OBJECT(s->cpu), "idau")) {
         object_property_set_link(OBJECT(s->cpu), "idau", s->idau,
                                  &error_abort);
@@ -334,7 +335,6 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
-    qdev_prop_set_bit(DEVICE(s->cpu), "start-powered-off", s->start_powered_off);
 
     /*
      * Real M-profile hardware can be configured with a different number of
-- 
2.41.0


