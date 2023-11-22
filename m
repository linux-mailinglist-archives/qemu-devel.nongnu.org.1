Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA307F4F9D
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 19:33:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5s1e-0004tG-Av; Wed, 22 Nov 2023 13:32:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s0g-0004Fb-Ix
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:39 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s0e-0004dv-In
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:38 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40a4848c6e1so321825e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 10:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700677893; x=1701282693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=auZXV6u0sdeAtdGoHPpNxl3A34os5kR+ZbHub0QBvt4=;
 b=PQQL0H6Rj0Loq3Q6FLGYVKxcQ6jr01fqCK7MSCFM9EZ3uRHoFPkOyfzxgqfI0vWMS8
 4SjisWgAYjZjilYGAuFbBhC41De53GR5szhtBG0jPzJGBjkxVRv6TCHHLN5p2uEjYwi+
 qCWXeUp6yHYeDMFvGZmTDUOtePoiGtu0rQHF0VMfdmZz652Q38tqGI5gOg02j0lEowOC
 IcUgQBFVwBZUmjkalAj8fM8glmQmDEE1/RQItSrrQZLoo7IjUY6qdTBwuZapQQGF/wEE
 5bBscvVXvgCiyXYYMR5hB6/AvXGtUDF0Jl6Wdn3sf2nGxneUvodt4LDHO2QfVkgh01Hd
 S5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700677893; x=1701282693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=auZXV6u0sdeAtdGoHPpNxl3A34os5kR+ZbHub0QBvt4=;
 b=SmR/5dQjSkAKsUDua/uvtP6MQlzSrz3GKapwg6DQQ+HOvdtmJiwAO5gI+quHfbdFhy
 xbUE9UYDOpz2Uw9ZO7ZuG3fS6Fqeahopg4hYCUvLkYaqWG0fPJkqg8WMR+GD9Ex3eKoV
 QdNP6vaviHkMk3UiV2IJ/9BGIdE+B02kmj2iyqM95JjLxgR5T4kuMjkER74qBh1Iw3fz
 RrJnwPwmb4ZnSZd5tVv7bVoG9eI60GbCE8khDo/1HNJsHhHzrfKWbIG2xpnzmOI/Uit1
 0xVXqhJGAOivUvx8Subk31z7vP65O7GL0HQTSZV+FV8qOFMK65t3oCWDIBB91w58ho0I
 GMAg==
X-Gm-Message-State: AOJu0YyaWzE+gx90IOGseL1/7alAn5tEhVnw7Tq31OBPH3MblZuOycGo
 uXI13fKxbdNv1zJqf3XyCOIMGYFSLS26HH/niN4=
X-Google-Smtp-Source: AGHT+IGESb8wYuo18nw+OYgfuR8Z7d/jlZCt9RdbLsLVU/QAQzVuLyz/D2Glld5mzqjPtKZ2eSJoYA==
X-Received: by 2002:a05:600c:3590:b0:405:1c14:9227 with SMTP id
 p16-20020a05600c359000b004051c149227mr2662206wmq.33.1700677893528; 
 Wed, 22 Nov 2023 10:31:33 -0800 (PST)
Received: from m1x-phil.lan (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 u14-20020a05600c138e00b004063ea92492sm187101wmf.22.2023.11.22.10.31.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Nov 2023 10:31:33 -0800 (PST)
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
Subject: [PATCH-for-9.0 08/11] hw/arm/bcm2836: Use ARM_CPU 'mp-affinity'
 property
Date: Wed, 22 Nov 2023 19:30:44 +0100
Message-ID: <20231122183048.17150-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231122183048.17150-1-philmd@linaro.org>
References: <20231122183048.17150-1-philmd@linaro.org>
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

The 'mp-affinity' property is present since commit 15a21fe028
("target-arm: Add mp-affinity property for ARM CPU class").
Use it and remove a /* TODO */ comment. Since all ARM CPUs
have this property, use &error_abort, because this call can
not fail.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/bcm2836.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 198f9b5730..8031a74600 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -128,8 +128,8 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-fiq", 0));
 
     for (n = 0; n < BCM283X_NCPUS; n++) {
-        /* TODO: this should be converted to a property of ARM_CPU */
-        s->cpu[n].core.mp_affinity = (bc->clusterid << 8) | n;
+        object_property_set_int(OBJECT(&s->cpu[n].core), "mp-affinity",
+                                (bc->clusterid << 8) | n, &error_abort);
 
         /* set periphbase/CBAR value for CPU-local registers */
         object_property_set_int(OBJECT(&s->cpu[n].core), "reset-cbar",
-- 
2.41.0


