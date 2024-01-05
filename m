Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F14EB82572D
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:53:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmR8-0002pI-2V; Fri, 05 Jan 2024 10:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmPx-0005yh-Go
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:47:29 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmPu-00048O-Dc
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:47:29 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e37524fafso8947865e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469645; x=1705074445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIi494ZIPpClTlGLpiqU0qCpof/tLsTarUcBXXHQbq8=;
 b=vF/Df9YLbCjANguPuSTnr5QfBzVSnVUxQLKWNRIi39PkE0VqwfoMXZwtY6i9ev2Y3G
 k1c044BErpcFaMnnVAmS27oU/FYDSUs/07xVVhlVDTcgiZRasF7PxTLhn0nhwQzRYJjF
 P9wnNG/gEJPshWBVVLfQpz3KqP4AQyeL1SUIkhYQ+igni1G5atHybX1NltpzRDGmE5kG
 tXsgdGji5hVH79JHmL9/7/qXTDl6d3Hhy8kVx3KxRmZ52OlbqNGD89B/rVuN3ZFeWJHj
 T2qVhc50YHGebsufMNlPCQzVCGLbFHERMejo+B43BAYGIjLgjXmRM0Oigxac2DKatPhX
 Y0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469645; x=1705074445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QIi494ZIPpClTlGLpiqU0qCpof/tLsTarUcBXXHQbq8=;
 b=KpeGe8Zm2kiv1NDKB5IOduVkuWvvC/izIbntfphkxc8Vqc8zxzIjatQqC6W/XsLSxx
 xR9EMjLECeC0XzflYxa/nIyl6pHK1lTj9NCh7vsNOnbA4K4kb5N/iEuwX+wqnKG8XEhP
 xjxp/0mV1vIzzUR8AaTggs4Dqjbb+WyxlAYfn6wBk+rWmJZnmM6N9QcBHaJIyAgpNioe
 gVxsH86c6XYZy3ABn1AnWvYqyAWb6cpphm+50ULXCJW4FuX+nJt8el3OKBeInW2Ob0yz
 CYKY75JNJJdMY9nBEQvaNAG4Hr+FgctVdy3EOar1OXI7rPsB4qVE0d51xu+C/oiMcqbz
 a0Xw==
X-Gm-Message-State: AOJu0YwrvIrUr8CpLZpbvdQNGvI3hEOr6EVN5XsiOe11dj/CzPC/c2Px
 1e9PVSUbdyRs9KymDmsT1tG6chmr13GKwDEM/3keJz9T59Q=
X-Google-Smtp-Source: AGHT+IE0XlPSZc9tFbMSGblHOADfNL01MnPGMi6FOcPBZRLMhQw7ZmRMlo0tISzqYBwqCFrICq5QzA==
X-Received: by 2002:a05:600c:4f02:b0:40b:5e21:ec3f with SMTP id
 l2-20020a05600c4f0200b0040b5e21ec3fmr1175525wmq.113.1704469644973; 
 Fri, 05 Jan 2024 07:47:24 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 iv20-20020a05600c549400b0040b3d8907fesm1928352wmb.29.2024.01.05.07.47.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:47:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 39/71] hw/arm/bcm2836: Use ARM_CPU 'mp-affinity' property
Date: Fri,  5 Jan 2024 16:42:32 +0100
Message-ID: <20240105154307.21385-40-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The 'mp-affinity' property is present since commit 15a21fe028
("target-arm: Add mp-affinity property for ARM CPU class").
Use it and remove a /* TODO */ comment. Since all ARM CPUs
have this property, use &error_abort, because this call can
not fail.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20231123143813.42632-4-philmd@linaro.org>
---
 hw/arm/bcm2836.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index a1bd1406e1..289c30e6b6 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -127,8 +127,8 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
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


