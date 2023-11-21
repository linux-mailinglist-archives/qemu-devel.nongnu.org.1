Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1AB7F377E
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 21:33:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5XPG-0006eH-OJ; Tue, 21 Nov 2023 15:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5XPE-0006e2-OL
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 15:31:36 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5XPD-0006D1-6H
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 15:31:36 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507a62d4788so8508933e87.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 12:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700598693; x=1701203493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rsesv6ccF45i265QxU35NmRNTCsAvdSIajrhhzMX1hY=;
 b=jawfo+3V7svojDgphDNLTwPu8KwqLDECngdO1cYeOtRMdjDLofjPf7MZToD/s4XGkL
 OgN0mT7qegHlO5oz8Azsa7Z9l4QlEodGj87pjbArxeovw1bPZwjwjCMqqABrd6AWwYMs
 my9d2e2Ew3UIl2RgsVGyd+y+lk4Z6pZC4rEota7L9gqFuSXRa5eG6OqkY9Pj2osYDII1
 +bEaxlH+h49J5J2Rawn8+dhHsKF2hxlxUzR9sKE9cSoIoTI9AZSkyo6Xf+ooIJ94xAnd
 VwZgjVHwrlKtt306rhdkWasA90a1gJgrWJTByU0DnM25h6akN4SBEQe9VmAJ9XlNrHRQ
 dSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700598693; x=1701203493;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rsesv6ccF45i265QxU35NmRNTCsAvdSIajrhhzMX1hY=;
 b=T5Y0fNqD36tQ1Fb+VQakJmqwbj4ciL1RNufMGXu2acnunbGR/rYplt8dmrWUd8Xkio
 wbKPBxtYFYNO7PBR/9zGiC9MXe04dkA4YQUEnqydTI9ihcnGa3WPw7VyWH2x2XSgc6P5
 qhANjPlPUm5vqQLS8y00zrkEVr7zv/j48f0ItgSZ5JWbGl81MRxcNPM6pB454PzwxYVR
 x+5Y6Pp1pZFmxQ0YDUWpM3WWtq/dszJlx0h4iJ0a+qA3fKUQsVPNpIEgvPyWUqmvFExE
 4Lqua1t55xluwOMs9UWlHTlZGawyoowk9BNBM8LX3KAPa30dmfgGbUxPZOrSf75I4GlW
 4FYw==
X-Gm-Message-State: AOJu0YzaAN1WWRgOL0NezmiYKj3UvxHWuEcmVJ2RQRnuCIXEHqGfp8K9
 D3gq30KpooMOKtS4mSmaDK78KGMcOVsuMpQ7LH4=
X-Google-Smtp-Source: AGHT+IGpG7DI29IHH49JMZy/1UR3embj6fCD6j07Mvma89VZYxBQrw73u2heWg47y4qVPDUE42/atA==
X-Received: by 2002:a05:6512:e94:b0:50a:a6e2:ae73 with SMTP id
 bi20-20020a0565120e9400b0050aa6e2ae73mr274061lfb.44.1700598692737; 
 Tue, 21 Nov 2023 12:31:32 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-219.dsl.sta.abo.bbox.fr.
 [176.184.8.219]) by smtp.gmail.com with ESMTPSA id
 u27-20020a50c05b000000b00548d649f638sm2246808edd.96.2023.11.21.12.31.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Nov 2023 12:31:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH-for-9.0] meson: Allow building binary with no target-specific
 files in hw/
Date: Tue, 21 Nov 2023 21:31:29 +0100
Message-ID: <20231121203129.67999-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

Allow  building a qemu-system-foo binary with target-agnostic
only HW models.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Although this is for 9.0, I wanted to post it today to celebrate :)

Once reviewed I plan to queue it via my heterogenenous-cpus tree.
---
 meson.build | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index ec01f8b138..9ccfb091e7 100644
--- a/meson.build
+++ b/meson.build
@@ -3772,9 +3772,11 @@ foreach target : target_dirs
     arch_deps += t.dependencies()
 
     hw_dir = target_name == 'sparc64' ? 'sparc64' : target_base_arch
-    hw = hw_arch[hw_dir].apply(config_target, strict: false)
-    arch_srcs += hw.sources()
-    arch_deps += hw.dependencies()
+    if hw_arch.has_key(hw_dir)
+      hw = hw_arch[hw_dir].apply(config_target, strict: false)
+      arch_srcs += hw.sources()
+      arch_deps += hw.dependencies()
+    endif
 
     arch_srcs += config_devices_h[target]
     link_args += ['@block.syms', '@qemu.syms']
-- 
2.41.0


