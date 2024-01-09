Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D68B8828C3C
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:13:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGZ4-00035g-VC; Tue, 09 Jan 2024 13:11:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGYN-0002bz-Gz
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:10:22 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGYJ-0004FV-Cz
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:10:18 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e4d515c9aso15933385e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 10:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704823805; x=1705428605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fOLjDR/IKNF0Xh0mudwkf1U6/g8RGHkdFKaUB2oy+80=;
 b=BaTqlScVm/d2Misn5oZ7mUmZkFRg8xLneK/0lxvy+xQQ2xozN9v5lKoaw7Tp2LdPaz
 7ZetiS9W3StqIwPugogvtWhYZBvVNmGlDopicTDdiegOSVeVCB6CW67ym41HOYt/RsuQ
 H1uyra9dScprGFMJCKWb58OWtVj5HV19qxegyYbrep21+mvV0xhDSBXgemfe0/C3qtDJ
 +aP5tyyxk2JbYbdVaFNPpln8bLYso9De5YPhR4HBQyKpjpcF/bzqr0Xn1EUX2wNdSAdv
 fd0q6g0SsVRmGC+UKW6KKHQQc4AnoTaQvIrAk9pbz3AkPNyqAFzhMsARPrZ9yarDrOgF
 whtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704823805; x=1705428605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fOLjDR/IKNF0Xh0mudwkf1U6/g8RGHkdFKaUB2oy+80=;
 b=Cy28JIEdkq0IeCmGV8sUZi71f5knc/mVMAhFd/wXEj+zfCfW2gTlKL2uU4AyAx/vor
 bkBvEyNfYNnCwCw0tXqXnoBrZWbEyntZPDVrv8UJ7ZEcu2PRV3pMcHtxDoFDox6DzoOg
 RJCpeQahYs4ygYsY8iBY7FdEWwVNssN7X7TR7gGci72CvE2OzrnKJXR6nhbw0ZUJblGN
 59uBZjSry4pWur5rYq2pq7dkmzi1ZsiuFvW9jz/NHg//UVdYktxaSGEe0oZT/zUbKaIY
 QMHjDkHYoSU6Ce2gvU+lR7mQRuG2SLDchSwfowdWWEPM8euyOoSDHHTXUiKiVqMOVnXL
 sVvA==
X-Gm-Message-State: AOJu0YzkZIWCyBKlFJXJgVTRtdqMZtEhdkS20UM6bmemQhWUpABk+Oh8
 eKNF9H7l4QhIXwNq1Bqa+D5fGgU58d42agiJ4fZ9y4zw9dLhTQ==
X-Google-Smtp-Source: AGHT+IGYsbR/oWsWSjZllwttr2q5gs35AJP/ee8A1m9jKhWKPikHGd3pVejueiIhNEFR5CInfw74IA==
X-Received: by 2002:a05:600c:500d:b0:40e:4a7b:f53d with SMTP id
 n13-20020a05600c500d00b0040e4a7bf53dmr1293492wmr.168.1704823805372; 
 Tue, 09 Jan 2024 10:10:05 -0800 (PST)
Received: from m1x-phil.lan (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 n25-20020a05600c3b9900b0040e527602c8sm2101803wms.9.2024.01.09.10.10.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jan 2024 10:10:05 -0800 (PST)
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
Subject: [PATCH v2 05/14] hw/arm/armv7m: Always set 'init-nsvtor' property for
 Cortex-M CPUs
Date: Tue,  9 Jan 2024 19:09:20 +0100
Message-ID: <20240109180930.90793-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240109180930.90793-1-philmd@linaro.org>
References: <20240109180930.90793-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

All CPUs implementing ARM_FEATURE_M have the 'init-nsvtor' property.
Since setting the property can not fail, replace

   object_property_set_uint(..., "init-nsvtor", ..., &error_abort);

by:
   qdev_prop_set_uint32(..., "init-nsvtor", ...).

which is a one-to-one replacement.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/armv7m.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index b752049add..530729f42e 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -309,6 +309,8 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
     object_property_set_link(OBJECT(s->cpu), "memory", OBJECT(&s->container),
                              &error_abort);
     qdev_prop_set_bit(cpudev, "start-powered-off", s->start_powered_off);
+    qdev_prop_set_uint32(cpudev, "init-nsvtor", s->init_nsvtor);
+
     if (object_property_find(OBJECT(s->cpu), "idau")) {
         object_property_set_link(OBJECT(s->cpu), "idau", s->idau,
                                  &error_abort);
@@ -319,12 +321,6 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
-    if (object_property_find(OBJECT(s->cpu), "init-nsvtor")) {
-        if (!object_property_set_uint(OBJECT(s->cpu), "init-nsvtor",
-                                      s->init_nsvtor, errp)) {
-            return;
-        }
-    }
     if (object_property_find(OBJECT(s->cpu), "vfp")) {
         if (!object_property_set_bool(OBJECT(s->cpu), "vfp", s->vfp, errp)) {
             return;
-- 
2.41.0


