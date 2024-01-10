Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6133182A18E
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 20:55:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNeeS-0007H5-DB; Wed, 10 Jan 2024 14:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNeeM-0007CT-LZ
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:54:07 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNeeL-00025F-3W
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:54:06 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e5508ecb9so17784425e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 11:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704916441; x=1705521241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fOLjDR/IKNF0Xh0mudwkf1U6/g8RGHkdFKaUB2oy+80=;
 b=CcLGUL5MS3BHCu1Djy1NDU0zJPL7d8j5QgqdMrg4lfD9c5hIce11HkAjNYvJI8rzI0
 jwO8UeIIha7ykzWm9pq4msetSebuzyx5+ury4mSmDi0/eM89TqTFjK1iqHK0ECYV0Tks
 kiXzrJFIdKrtCkSCPo+95X8r+3ULNowlJYjD/HF1PUMIir1x1r+qPYKoaRt5hDlnJZbp
 gExq6NhudWjRjC3+Lik3P33/HuO8XsHsD0BfuLMd89l8FRu+iWc46wpq3z0yPfaYFmoi
 BKYlz28xPatxq5xMgobstLa8braqDjwXkVLVINHal0c5GfMESgy9nAWetfOQdDt/JrTq
 n+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704916441; x=1705521241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fOLjDR/IKNF0Xh0mudwkf1U6/g8RGHkdFKaUB2oy+80=;
 b=lN2jq1qqzMJG89MJ1xQgVfFp49IUPAs4CicYonH98cIOsPWW1hiksJkz4EzBH+QcPD
 Ve2XmViSDpImZ5D33Muye+r4ZD3pb6k9gwethY3Zf9uitj5Ckz1OcTTwYuJ0Ux9FKDbj
 XfnOll4VCDYLW6v3npkuw8dACvBuhWEDOvKCubKMGX3rr0ritrPl0D+qPsHc2acYwisY
 GqqZ4Gqu4vtynIBGN72uWrwiNTfa7t6sYTzvvMyIG0JH4/uaoMlRE3szZPVl13r6TyRN
 /2R5gKz/dgY/bIW1vZm8sMK5Je6Jffg+VFkNklkCFtSnQwdw13g4zJkWoh6CKRzO2DFO
 o+PA==
X-Gm-Message-State: AOJu0Yw+wOXKSrScii4C2vA74147KwwheV1axkU5SbM7yf52mKrq7lzb
 lWGuLSyCgIKNJaBmqGnzu6ql9+P5goaIne5VAo6Ap8Cp9vY=
X-Google-Smtp-Source: AGHT+IFVcjqlQhh9IFV2hlFnA4ke87gdFQSLw0a78PKhvCLIBAzbhPLNgdGMZHqNjSOYGEZo/ChByQ==
X-Received: by 2002:a05:600c:a019:b0:40e:3fa2:213 with SMTP id
 jg25-20020a05600ca01900b0040e3fa20213mr939693wmb.147.1704916441650; 
 Wed, 10 Jan 2024 11:54:01 -0800 (PST)
Received: from m1x-phil.lan (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 n16-20020a05600c4f9000b0040e53f24ceasm3216630wmq.16.2024.01.10.11.53.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jan 2024 11:54:01 -0800 (PST)
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
Subject: [PATCH v3 04/14] hw/arm/armv7m: Always set 'init-nsvtor' property for
 Cortex-M CPUs
Date: Wed, 10 Jan 2024 20:53:18 +0100
Message-ID: <20240110195329.3995-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110195329.3995-1-philmd@linaro.org>
References: <20240110195329.3995-1-philmd@linaro.org>
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


