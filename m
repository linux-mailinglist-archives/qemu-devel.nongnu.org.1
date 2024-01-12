Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC05782BEE9
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:07:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFLW-0005fZ-ES; Fri, 12 Jan 2024 06:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLC-0005eL-Aa
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:46 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLA-0008Up-0k
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:45 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e613b6afbso15673255e9.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057482; x=1705662282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4l+3A91Arn7aULpCFNHW+z9h51TEBIRLEOPCe+0dXU=;
 b=v5u1kTKwwTX91IUEncw5zp+UKTjueEtPOovO2f4m+ra96fY+dm8fp6h9S/zJhGGJ2s
 ruHTscA/rFtpGasKlifEb4VfPEQueSkyZ4pzopau321j9lGZpWnuzXQUDZrfGc1MYiRM
 0Iak2bJ4rKw/5eX1He0qSSE5a+L6MqED0lyiXWr0YgLasCDgOdhu8oKPiLaLS8sh7HF6
 EzryiuIXYRfYtl292NtAc1dFDGbxtgig6KRx0okJAQA2/GO4ApreRYNZNuniG0M3wvC7
 U1KCgBeMRyiE2L647rG09jOBWCyWq06zkPKumcAuct08Hq1R8DhXmKLOuxfUH9HrX459
 M0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057482; x=1705662282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H4l+3A91Arn7aULpCFNHW+z9h51TEBIRLEOPCe+0dXU=;
 b=R3AR8cch5aGvmuM8e7QdnTa80rf7Kp7ymncbjaKO3BrV872Vz4nDqRuzMh8QyQgruJ
 1dX1+2T68um1VfDfO9phKFpnr2rEe70Ru7ObexsokXspuV8/SaK6D9ktGFIU2Sy74xwp
 nlK4TDymxDGyXzeSAfDt4lIyiPfDq6l0l1+2+2Qw5tB2XZVX3ft0qPZ7Ei3Q/EWt6xV2
 Rj1I1n4IyeD4/1fmnX6ZNQR0h7uZjHM3LR1AnuiaI138JuxpLRPC5DIhzt0w+PqvzHWj
 37vcbpdXhVqWxiIrqiYjl5lTNEJ9qZH/BRIWi27MKIlaDZNHRX224YrVtY6uK4KIjwLF
 byZQ==
X-Gm-Message-State: AOJu0YyTSaXF+Cd+IOOpr/uiKCah/XDiSKBDGuGS/HY1IyZhOdWDDkev
 jeVWAT7IA2RxbAmjF58h+lvOi4+GsGrvVA==
X-Google-Smtp-Source: AGHT+IHHtwtRTFr4W5xVM73rAmXVX1osOqqZv4Do4ixj3mG6RutXCvt4lvo2zNoBbit/N+9mU7Rgzg==
X-Received: by 2002:a05:600c:198b:b0:40d:7d87:6730 with SMTP id
 t11-20020a05600c198b00b0040d7d876730mr611784wmq.101.1705057482568; 
 Fri, 12 Jan 2024 03:04:42 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d6-20020a056000114600b003366a9cb0d1sm3533045wrx.92.2024.01.12.03.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:04:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BF9D45F94E;
 Fri, 12 Jan 2024 11:04:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 08/22] qtest: bump npcm7xx_pwm-test timeout to 5 minutes
Date: Fri, 12 Jan 2024 11:04:21 +0000
Message-Id: <20240112110435.3801068-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112110435.3801068-1-alex.bennee@linaro.org>
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The npcm7xx_pwm-test takes 3 & 1/2 minutes in a --enable-debug build.
Bumping to 5 minutes will give more headroom.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20230717182859.707658-5-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-5-thuth@redhat.com>
[AJB: s/pwn/pwm]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index bb9d599e4dc..823a8ac38d0 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -1,7 +1,7 @@
 slow_qtests = {
   'bios-tables-test' : 120,
   'migration-test' : 480,
-  'npcm7xx_pwm-test': 150,
+  'npcm7xx_pwm-test': 300,
   'qom-test' : 900,
   'test-hmp' : 120,
 }
-- 
2.39.2


