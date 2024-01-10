Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 754B882A195
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 20:55:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNeec-0007Jf-Qu; Wed, 10 Jan 2024 14:54:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNeeS-0007IV-AF
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:54:12 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNeeQ-00028e-Ax
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:54:11 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3375a236525so3781994f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 11:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704916448; x=1705521248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Lqyw2xeJxP0nadk2efU9Sx5aGl4DyqfaFeDtt0siLg=;
 b=vfKUCj0xZ78IizDc83HDtt9eOmGXDS/yHioQ4akHNWANy3e+Eh3K8iA6M5LwSURmVp
 wIvc/MiZrv95scEKQbLmr2T95CRRyigvvPymBHV44EnnGIjrqIg7VqBIg5zsZdOm+Stg
 sM1t6O7c3hU5voTrRphzR4PHF7f7KXQHvjTe1hVk6qx+fNr15QlnoL0UzV08IWzPuqTc
 7wDJeGEj4Rh4AAidu9SZywd0WHTnMM1SfZSuqIDly0dK3U237cl9eIacQ/4073alwRbC
 SoVsr+9EOyXFypb1xTo0f0ucmYQfOvnCgiZZvAFCM0kFih/Np7NOCrlhhKnRxfZ0ZJ4V
 LYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704916448; x=1705521248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Lqyw2xeJxP0nadk2efU9Sx5aGl4DyqfaFeDtt0siLg=;
 b=HohM/GZoWhIO5eFltpU/9EGmuhGH5ra2XfN8LyNHzCuX45rnM+q0+jypSy8uM7kvWv
 jyqaO4yp5Ug7DIFR/ULwEPrQe2tQe8u7VqGmYtsGbINyegzldfitHjuNkSriDKdIUs3Y
 IPVDPvWgWhy3fXG1EtzmHY11tNFlZMFEtNI3O0A6f/JkyrhL52pV7WtIjkr8tyVDWii7
 GtZcjOwRZwlOSVu9YlG9HZPBdLTRbsk76kwUNtUgQX/+/ialqDj1Qw23BJ9NkPKW4fBk
 6gnF672tH9Is2u+KkEyT5j7HoWnDUa5Gv1snD9bKdf2DYrNtFqzUYUgN8hyGv9oLbh6j
 4wXA==
X-Gm-Message-State: AOJu0YyfJbVRGdfzygBLiwGdp+SefL2WzCWyro/7/ajz6eUcL+ygt/6l
 jqwpsqDkDjN2VwHZzwnGtB91sz02lc4kSBVURONiomO9SGg=
X-Google-Smtp-Source: AGHT+IH7Le0gG0qCcI+8M09SN9A/YfAepwlqDkxfVaho46g9uVvNTxP1ta35tm/cvlgibSAWK/Yc9g==
X-Received: by 2002:adf:f102:0:b0:337:6566:f9cf with SMTP id
 r2-20020adff102000000b003376566f9cfmr2200wro.98.1704916448613; 
 Wed, 10 Jan 2024 11:54:08 -0800 (PST)
Received: from m1x-phil.lan (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 r4-20020adff104000000b00336a0c083easm5602722wro.53.2024.01.10.11.54.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jan 2024 11:54:08 -0800 (PST)
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
Subject: [PATCH v3 05/14] hw/arm: Prefer arm_feature(M_SECURITY) over
 object_property_find()
Date: Wed, 10 Jan 2024 20:53:19 +0100
Message-ID: <20240110195329.3995-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110195329.3995-1-philmd@linaro.org>
References: <20240110195329.3995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Both "idau" and "init-svtor" properties are added to ARMCPU
when the ARM_FEATURE_M_SECURITY feature is available. Rather
than checking whether the QOM properties are present, directly
check the feature.

Since we are sure the "init-svtor" is present, the
object_property_set_uint() can't fail.
Instead of using &error_abort, replace:

  object_property_set_uint(OBJECT(s->cpu), "init-svtor",
                           s->init_svtor, &error_abort);
by:

  qdev_prop_set_uint32(cpudev, "init-svtor", s->init_svtor);

which is a one-to-one replacement.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/armv7m.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 530729f42e..8350267d96 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -311,16 +311,11 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
     qdev_prop_set_bit(cpudev, "start-powered-off", s->start_powered_off);
     qdev_prop_set_uint32(cpudev, "init-nsvtor", s->init_nsvtor);
 
-    if (object_property_find(OBJECT(s->cpu), "idau")) {
+    if (arm_feature(&s->cpu->env, ARM_FEATURE_M_SECURITY)) {
+        qdev_prop_set_uint32(cpudev, "init-svtor", s->init_svtor);
         object_property_set_link(OBJECT(s->cpu), "idau", s->idau,
                                  &error_abort);
     }
-    if (object_property_find(OBJECT(s->cpu), "init-svtor")) {
-        if (!object_property_set_uint(OBJECT(s->cpu), "init-svtor",
-                                      s->init_svtor, errp)) {
-            return;
-        }
-    }
     if (object_property_find(OBJECT(s->cpu), "vfp")) {
         if (!object_property_set_bool(OBJECT(s->cpu), "vfp", s->vfp, errp)) {
             return;
-- 
2.41.0


