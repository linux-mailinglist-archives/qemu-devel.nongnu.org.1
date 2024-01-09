Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B987A828C32
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:12:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGZE-0003pR-4V; Tue, 09 Jan 2024 13:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGYb-0002r4-M5
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:10:37 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGYX-0004Mw-K9
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:10:32 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e5508ecb5so455015e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 10:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704823825; x=1705428625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4lFs+peHffZXBVVkShWxuZ7VjcO+rV+nUwkZ0/LL7Zg=;
 b=GBnNFNk23Yt4nxc0ZZK3NEloLeH18SRXEO4mzrbT1+hJ8NJRzFf1l39eq7FXEqgCU8
 aqg32aztE4MBH88qxG6lEapyuc6g3R6Wr2KNr6LHa/qeA/rIdO6hnQu/QK0uX255fjkc
 ZJQ63Atuu1ogTLQm+22Y3xxmwEMtRd0gVzk45x5vDcpb45X1Ra8pui/JfoTwAxWfHhRN
 KPtX2J2oXomjGGf5knKtesxneRbni5s66dZK9Jd/nbTTXvVvvc0/Nk4SLrY+xx+ENALQ
 3Uxa3WbGIYl/GzY/VbzoEp7s7x0qhK3+JQa9VtQ9fqLmhsuVmtcDNjAy8NWmBuihdtRd
 fIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704823825; x=1705428625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4lFs+peHffZXBVVkShWxuZ7VjcO+rV+nUwkZ0/LL7Zg=;
 b=nGqjBSZh31sZ4e7Th9KcSgFfL4i00nW6ydwoxc+nLDdzBUipKJsXQiDUpRsCx2vCrO
 +o4LOc4JZOqKtlfy+b35EXjC+X6bEJdwOQfFXm2nZjm+oRWZnYwRRVbM77yyVEvxLwTf
 +xsRK+u1TT90GVsnvsM0LiIc7Zk+UALMSEFtR4aNK0JCI0mlu1USGbPNZstgZXG8JgV6
 sdApVxq9X5Tj++0kxfde4SNwIO3fBZ5hxscGPFJDSKbIcEYs2ueXdH2e3iwgSg/17V8D
 DpZEdLwhXVZFD4CXFV1VNdxydu0VDdwF08t1/5Kv+UpI24qf53A/b7buCzW/PRwhZlcv
 r98A==
X-Gm-Message-State: AOJu0YyFv2NaissxXM5IlRVK8EKsxyEydWbrE/zwwpFATCL1iqVIfFYX
 4Mi30B/UsTcWi6WxT3i8Gs3+9iAjbCUqZdOJtXo04/qClkpXaQ==
X-Google-Smtp-Source: AGHT+IEGHFLG0iHvKFqIy/F5s5ED2yVLqMd13FUOQDWy1aiWFAwOslzm5seU52dNFSOuQwbSjsxr9w==
X-Received: by 2002:a05:600c:3143:b0:40d:7247:b00c with SMTP id
 h3-20020a05600c314300b0040d7247b00cmr3411464wmo.163.1704823825185; 
 Tue, 09 Jan 2024 10:10:25 -0800 (PST)
Received: from m1x-phil.lan (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 je4-20020a05600c1f8400b0040e38b7cfdasm15763276wmb.4.2024.01.09.10.10.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jan 2024 10:10:24 -0800 (PST)
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
Subject: [PATCH v2 08/14] hw/arm: Prefer arm_feature(V7) over
 object_property_find(pmsav7-dregion)
Date: Tue,  9 Jan 2024 19:09:23 +0100
Message-ID: <20240109180930.90793-9-philmd@linaro.org>
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

The "pmsav7-dregion" property is added to ARMCPU when the
ARM_FEATURE_V7 feature is available. Rather than checking
whether the QOM property is present, directly check the
feature.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/armv7m.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 0a7ad2b762..7f15318ae3 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -338,8 +338,8 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
                    "mpu-ns-regions and mpu-s-regions properties must have the same value");
         return;
     }
-    if (s->mpu_ns_regions != UINT_MAX &&
-        object_property_find(OBJECT(s->cpu), "pmsav7-dregion")) {
+    if (s->mpu_ns_regions != UINT_MAX && arm_feature(&s->cpu->env,
+                                                     ARM_FEATURE_V7)) {
         if (!object_property_set_uint(OBJECT(s->cpu), "pmsav7-dregion",
                                       s->mpu_ns_regions, errp)) {
             return;
-- 
2.41.0


