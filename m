Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 293FC828C1F
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:11:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGZ7-0003Sr-8I; Tue, 09 Jan 2024 13:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGYN-0002c0-Hn
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:10:22 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGYK-0004Fs-4U
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:10:18 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e4d64a431so11589095e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 10:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704823811; x=1705428611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Lqyw2xeJxP0nadk2efU9Sx5aGl4DyqfaFeDtt0siLg=;
 b=EerEEoYuJoDs77MtzYbtgkYEkasA17X5iboAQWbZtW6IFrakn6ZAQeZeOsFPn4Fx7d
 3YFHeVgDtQjwUY0A1nAl+gnyAvZe3Ok8t6WUkgKT0G9rtx8T2UMEyXW75WkiDW8WTmbi
 vMsDFZPMN46mWRbSe2NwFXOIXCiYgQtm4+eGih1YrMx4EPPDW0st7JqYO/I0NDmh5u3J
 TtYdwSTYl6khMbqomSSAydB7IBCFbGf2gVJ+IwmNRsNECRmhsZ4JnU2cR3wyFsCWkKEn
 ZqKMWD5AIIQUMgiTvxVCZKAIO8NMEndr+LJz6iXz0yELLufwbz7O6542YiY+V3cdCPTB
 SZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704823811; x=1705428611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Lqyw2xeJxP0nadk2efU9Sx5aGl4DyqfaFeDtt0siLg=;
 b=hn9FR0pZclqEecxY8cR0pLLxv60trRk45aupvxIZy7rcN2zzePfMWrK0p35W+YiqtL
 cskHZwooposXuFXT4Vm7MHWrauoM+azZnO4qnJMNUhvQa5L/XtkSeinzh9sL/RvbY4LA
 OrneNujVde9v3wLN8xwSOkgxfH4OjuDJ9x4mBXVHvl6LVJiQ7ukvi0OFyeO4o4yRXm2T
 IplFo7C9k+c4fobVRUM3EfpKjGFrdeaE7x9rSEKcweI/SLvKLpfqPJALTztX+h4gjaW5
 z1141Kxz0JP/zSqPm5QMDt22v9nAr5mqTC3+3PLIgj7TBvUjcRl7uYfQ5X8ACj4p/rDA
 woWg==
X-Gm-Message-State: AOJu0YxNBBc3sv9xxYpOBB1x4Uw0A+hGwJUpUlcexo/Rj3J+zq/HG2AK
 kEPuSRx/o5bFGXE5uH1bo6DYvw4Ra2lYNugHHm9ihytx+nFDsg==
X-Google-Smtp-Source: AGHT+IEkV3EqOMZBiyi/x5ctMwIwgQqB9cTJaNXPdfadCTidyHUkVC6QTsodAd4u42EfBemrXHw2rw==
X-Received: by 2002:a05:600c:b97:b0:40e:4985:ba63 with SMTP id
 fl23-20020a05600c0b9700b0040e4985ba63mr1545900wmb.107.1704823811362; 
 Tue, 09 Jan 2024 10:10:11 -0800 (PST)
Received: from m1x-phil.lan (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 gw24-20020a05600c851800b0040d3276ba19sm4549145wmb.25.2024.01.09.10.10.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jan 2024 10:10:11 -0800 (PST)
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
Subject: [PATCH v2 06/14] hw/arm: Prefer arm_feature(M_SECURITY) over
 object_property_find()
Date: Tue,  9 Jan 2024 19:09:21 +0100
Message-ID: <20240109180930.90793-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240109180930.90793-1-philmd@linaro.org>
References: <20240109180930.90793-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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


