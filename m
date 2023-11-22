Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 043647F4F96
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 19:32:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5s1D-0004a5-7c; Wed, 22 Nov 2023 13:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s0d-0004ET-Im
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:37 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s0Z-0004dK-HJ
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:34 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c876e44157so969971fa.2
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 10:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700677888; x=1701282688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lb2/44LPlczFh1Mivxhuq3Cei7H/G9D4OqWoSqq23Aw=;
 b=Q5iEMtP4NRXbhRVM1KdnA3wZN2AjjeJRcNbBka2m5UHel/MGhXa1bun04xIPVCEE8+
 574UPft1pnmFMwVNKQYCBk19nw86XSKL+jpEpTYEKEpjFEGxs5ZCttKrlL476qabr5f3
 cdIKVK2mq1EcIh+ocdCz07RSm6WbJQic/FMwQCd2nWfV7XznRWYdC7n8INzVwXCYTEer
 uclf2MO47MZ2JHb2o04nTo1lXXK9TLtd8O15nP2LSDgsyc22TbwD4nrhtVCzAjpIUudA
 bzGOXltFGgAbjp2jRa0vl+iCkwc4YEYMS/313RZu3ic3YH+qlyyvrPSkL1SHY0emz5qX
 hwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700677888; x=1701282688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lb2/44LPlczFh1Mivxhuq3Cei7H/G9D4OqWoSqq23Aw=;
 b=hcaLiICwfOzfTWOJlZJKY0uIAW5xUaPfssTSo7u1el9I7rKPtE/Zcvh5E2g5wrVnhH
 j5RN0wwjGFAXTF+2+iqNY+BL/tEeJ1kzEXktWXjXqsHqfNMgkiqgZFh6OxeafPjZxSaL
 1EmMUywQSQeHK8AbKH7I+x1TMcanS9Li4q+Tb8gxGMmVURbUdUIybX3Bkj5ZWnRRfrRi
 jSr98jVTHKe9fFAGBYjviPROJQqrfk+VDLuTjTKzorIJ86I/kCXgHO/yvsti7cT0GQhc
 1u+QrTsmD3f4ifa+FpVKNhtqn36HGM7Sb31Z34gTpmpY5KIpuDXz0Y2DRn/xZemkY6dG
 OfXg==
X-Gm-Message-State: AOJu0YzEOsGVROf6CK+/1D7l45ye5TUZKvtVC+zOWTH44Ip6u9GB5hew
 VB4DFloVeLP+tQSoM80GynsT4vNKgnOet7Dgr/M=
X-Google-Smtp-Source: AGHT+IFkhrZIsbX/NLV5u7r2FhTAsRQgMEtXNWL5Z5QCEKRjxkWeiCkids1c2PJIQvSmJxDxRtKZcA==
X-Received: by 2002:a2e:b914:0:b0:2c8:744e:dced with SMTP id
 b20-20020a2eb914000000b002c8744edcedmr2287579ljb.35.1700677888455; 
 Wed, 22 Nov 2023 10:31:28 -0800 (PST)
Received: from m1x-phil.lan (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 q19-20020a05600c46d300b004064e3b94afsm280976wmo.4.2023.11.22.10.31.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Nov 2023 10:31:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH-for-9.0 07/11] hw/arm/bcm2836: Simplify access to
 'start-powered-off' property
Date: Wed, 22 Nov 2023 19:30:43 +0100
Message-ID: <20231122183048.17150-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231122183048.17150-1-philmd@linaro.org>
References: <20231122183048.17150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

All ARM CPUs have the 'start-powered-off' property since commit
5de164304a ("arm: Allow secondary KVM CPUs to be booted via PSCI").

Note: since commit c1b701587e ("target/arm: Move start-powered-off
property to generic CPUState"), all CPUs for all targets have it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/bcm2836.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 055c909e95..198f9b5730 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -136,12 +136,8 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
                                 bc->peri_base, &error_abort);
 
         /* start powered off if not enabled */
-        if (!object_property_set_bool(OBJECT(&s->cpu[n].core),
-                                      "start-powered-off",
-                                      n >= s->enabled_cpus,
-                                      errp)) {
-            return;
-        }
+        object_property_set_bool(OBJECT(&s->cpu[n].core), "start-powered-off",
+                                 n >= s->enabled_cpus, &error_abort);
 
         if (!qdev_realize(DEVICE(&s->cpu[n].core), NULL, errp)) {
             return;
-- 
2.41.0


