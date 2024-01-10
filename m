Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B805C82A193
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 20:55:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNeeP-0007EC-Rf; Wed, 10 Jan 2024 14:54:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNeeI-0007A7-7P
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:54:05 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNeeC-0001sx-8B
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:54:00 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e4f71288bso24150755e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 11:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704916428; x=1705521228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdirajlt6qC945MCVDYIpUTSXSVbweTZjiyf2mppVOc=;
 b=FtrDxUIdss5ih2QFqGCkUlXq15n0ZxZLNY5lfr2jCFUokq0NTr4P5pdZJZg6C0cGBi
 hXN0mCyxiOKppkUfvMKGPP/L4/M5tcacu1SDIDd4FuIBpIg8qhPacjcuu4Pa/LTR//DZ
 SKI3iHVvW8vZdmb5EZiy81qOhteLLgr74JVKpkaopyy7hHPpQP5sjuxmFr1Fj0KzoNLg
 XSINusudfLTwhz2yCAerLOmXxf4oEHBIW/p6D8s0gRnDD41LuDdtSY6tMz2Zj27BxIrW
 AS2CixolMaNad8+t39XFF6Fum3XP7cSEDYcJBM4kd0m5mL/IyY3GuYWH4LK5hko40yjh
 xzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704916428; x=1705521228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mdirajlt6qC945MCVDYIpUTSXSVbweTZjiyf2mppVOc=;
 b=eZO6O/3+Y0dttAwd94EVjBL8hDmZvtixDAKq5Kr8QsQscquIhoM1qR10bhcBzlxnjI
 i4xVtqoozDoZUursvh+YsNM3egMvtUStmYZljhT+ZzxMdT+bqposYkkz3vw6+Hp/ZIE6
 +yTxxkPvjP45jTuuuGDqzsWJoSeg915WmXJt2jcemEH25Ufinbcf48nxbGHzGOBLlTtd
 sK7u58yrA/T37rgtEQgiFzNwkDThHs593+9LChLIFWZGvYX+VbKkfzazEZFdidHWdk2D
 v/RIsxtYfC8V1GTuwg6L6YZQX+odfCOLwg92WtTE+Li26ZPF3wv/xGOvuZkmRoXGylNy
 zPCg==
X-Gm-Message-State: AOJu0Ywtrs2medQV6dAcizXmNZGSMSYeJubdOF7y6NRRT/acSKt0RySe
 MM4SQ90zVKsME6XUY8QPtF7hEDGwRBHdjXacLL86Vkm0Lag=
X-Google-Smtp-Source: AGHT+IEM5mBA0vZDP7an5Du71JWNSy2KsfIX9laU0cGrvyWevak0CP3DGoYOyKFOF1yj1S3cqIiJHw==
X-Received: by 2002:a05:600c:35c9:b0:40e:4557:4d0a with SMTP id
 r9-20020a05600c35c900b0040e45574d0amr515035wmq.252.1704916427834; 
 Wed, 10 Jan 2024 11:53:47 -0800 (PST)
Received: from m1x-phil.lan (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 k20-20020a05600c1c9400b0040e54f15d3dsm3212195wms.31.2024.01.10.11.53.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jan 2024 11:53:47 -0800 (PST)
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
Subject: [PATCH v3 02/14] hw/arm/armv7m: Ensure requested CPU type implements
 ARM_FEATURE_M
Date: Wed, 10 Jan 2024 20:53:16 +0100
Message-ID: <20240110195329.3995-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110195329.3995-1-philmd@linaro.org>
References: <20240110195329.3995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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


