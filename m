Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EF6828C35
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:12:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGZA-0003d9-C1; Tue, 09 Jan 2024 13:11:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGYX-0002ku-RT
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:10:33 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGYP-0004JF-Qj
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:10:27 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e55094e76so261535e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 10:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704823818; x=1705428618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5n6b/Kfb2q1nuszk7kQnrf8+ZzcUeVpd0islGk5jF8M=;
 b=cE5mV5dXXRAAn4HeoTX//OhJxDzyhNcrl6rSnIHGYR3gHuCH/Qbooa1pZJWBESXND3
 WwDeF4m8oD1jIoFaah9ZiSR5DVyDut6rahwhUCFcBFWinj2mfGEKv12gEyFQwGB9Clko
 1ohtukFCFPBX2rpLWM6iHW+vTsoCxBpSBMPQ60b9knOyWU8cWiuFFa6WO/c2QPQn+Z3b
 zaZfmyIYMPPaLzAwpwaryb36afVJBwsWlO70AZLEZ5vJGDmjl2YccOvwt4xLqwfL9ADi
 GtC0vVFdKj7d/07rt8lxU/ZGLYU7aeRv2E9kmOQUYOR4LGr62duSqenLc3qT/hW/rxCP
 r38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704823818; x=1705428618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5n6b/Kfb2q1nuszk7kQnrf8+ZzcUeVpd0islGk5jF8M=;
 b=HcJN3fl5OgtJtJ9fQ2JNWT6QQBcVsaoHhKx32TgVXfcBTlTma4mb5YE/05Xzg5mYxx
 96Dnw8wYb4eRSeW2Iuet16kxJq9FZ1iDkxGJL4NF7o9CFn30s3LdiXCLll62Yi3hbCpz
 nnH36F0L7MtQevRFZDxlIFnPNuD2Ulm1G0TFufFIgV9hreJ9b112q0E5mH8mDFK9SliH
 KW+8pd5e3CLwGT+0NlkxuGC3wm4y/JmJfoZPTNXHHNt8YAn9UH4K/DDM1Xr2ulPaxi1P
 lTyplu+2DKGDaU88SQRSjDHbhaPYzMCdWl6UjkgsMrm7wmKuLXcAvRcWWqZ/cn0mJNqc
 ftEQ==
X-Gm-Message-State: AOJu0Yxs3+AaTV4lt603ZaTueAwVuPv8ofdKREPWEsY1PUZkxDI19UxW
 ILhuACQFyWk6PVRC+qXxWgynwFP5ISttn9vl62lxwA0Tt8kiIQ==
X-Google-Smtp-Source: AGHT+IE4jXA8U3e7c26iLW2dOY1wGZCd4tmuuH2ptRrYrBk6Wktz0CFYIyrg0TR6TFnaeQVst5SKlg==
X-Received: by 2002:a7b:cd17:0:b0:40e:364d:d526 with SMTP id
 f23-20020a7bcd17000000b0040e364dd526mr735782wmj.87.1704823818320; 
 Tue, 09 Jan 2024 10:10:18 -0800 (PST)
Received: from m1x-phil.lan (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 i1-20020a05600c354100b0040d5a5c523csm15647125wmq.1.2024.01.09.10.10.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jan 2024 10:10:17 -0800 (PST)
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
Subject: [PATCH v2 07/14] hw/arm: Prefer arm_feature(THUMB_DSP) over
 object_property_find(dsp)
Date: Tue,  9 Jan 2024 19:09:22 +0100
Message-ID: <20240109180930.90793-8-philmd@linaro.org>
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

The "dsp" property is added to ARMCPU when the ARM_FEATURE_THUMB_DSP
feature is available. Rather than checking whether the QOM property
is present, directly check the feature.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/armv7m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 8350267d96..0a7ad2b762 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -321,7 +321,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
-    if (object_property_find(OBJECT(s->cpu), "dsp")) {
+    if (arm_feature(&s->cpu->env, ARM_FEATURE_THUMB_DSP)) {
         if (!object_property_set_bool(OBJECT(s->cpu), "dsp", s->dsp, errp)) {
             return;
         }
-- 
2.41.0


