Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C86682BEF1
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:09:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFLh-0005jU-FP; Fri, 12 Jan 2024 06:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLA-0005Yb-RA
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:45 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFL7-0008U7-Qw
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:44 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-336c9acec03so5232010f8f.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057480; x=1705662280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LzskRUyoYnBvwMfCN9qIN9xwaOdwBQtdIEbLtTFu8Ys=;
 b=EHsm1d5v428iufN0NBDzuvkiu2tYk5uMB8RieLClgrKxhxWxL8Vxy3fyIiRhSBNwTG
 tt8Cr2Lju1cL6ojUXeLwOLMT2ILDm7Okpy0uh5aEJg15SY7lKrpkuu0kYRJpCmlMqFPZ
 qzLKK/tFo/GnKoQCBgwVXYI8lHhXUKRpW8VfJ7H0TzcqJO1ZiJmNYsQO5AGSA8C5186O
 UFogcZrWBt8NXAZqe6vcdi57Sqbn0IPg8lydSNKVgyaDUbJa6cEYdjQCCUd3beXJgus1
 Fc7HsdXuSqiGu1OStv8qoxq4IWq1FDkXCKpH7LCMxFHw2BqvDqYlZc/KyZf6xuTLY1Gi
 4tQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057480; x=1705662280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LzskRUyoYnBvwMfCN9qIN9xwaOdwBQtdIEbLtTFu8Ys=;
 b=mC3kl27pNoi05xs8wtalfnTCOg2poqH1YYd/Qhu+Rv/EQmh++rfWoSe1zUficwzPNv
 N9Uqx9NfKCLprM3gXJrxCfmKtl0At8JjxSR8ivj7uMLdOVjFRjP8Cyfae0sm/5Lzf1DK
 tIGgQjXFEpf9SbnxZvlmAXwd+8hK8wFCFXSGO05VNZjmoN7OvXSi05pHeaaLAs+nVRXx
 wHbFZLPUgaH/LKCkBJLjCqZxuoZZqlQyFm6c21UY1PWoLxTUVxcAk2AccPWBvZQbnT6Q
 AvBLpamuaNdQoDF8WNYwlUyhtrzwcCaPvZd+z755Fp5b8+I/qm2ALtOymZNqaw8xRLNn
 SiuA==
X-Gm-Message-State: AOJu0YyCQEwQyjaxMQD/4A2lOqI5d0mjvATHs+2cKFYH5iJsNVeBfQKp
 iKczCQSE2yn/txIKbOe4EoUuZXRZ1FXpqA==
X-Google-Smtp-Source: AGHT+IHtMZxGzSXLRZMOD3P/HxVgTiJdtoZBlYYU2RBjEeIup4NVPnKcXf+ETbHwKgWFFeDy/vAAHw==
X-Received: by 2002:a5d:43d1:0:b0:336:9c9b:a9f7 with SMTP id
 v17-20020a5d43d1000000b003369c9ba9f7mr598940wrr.4.1705057480312; 
 Fri, 12 Jan 2024 03:04:40 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o14-20020adfe80e000000b0033674734a58sm3578564wrm.79.2024.01.12.03.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:04:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7C4DD5F948;
 Fri, 12 Jan 2024 11:04:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 05/22] qtest: bump min meson timeout to 60 seconds
Date: Fri, 12 Jan 2024 11:04:18 +0000
Message-Id: <20240112110435.3801068-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112110435.3801068-1-alex.bennee@linaro.org>
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

Even some of the relatively fast qtests can sometimes hit the 30 second
timeout in GitLab CI under high parallelism/load conditions. Bump the
min to 60 seconds to give a higher margin for reliability.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20230717182859.707658-2-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-2-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index f25bffcc20a..df013a36b32 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -1,12 +1,7 @@
 slow_qtests = {
-  'ahci-test' : 60,
   'bios-tables-test' : 120,
-  'boot-serial-test' : 60,
   'migration-test' : 150,
   'npcm7xx_pwm-test': 150,
-  'prom-env-test' : 60,
-  'pxe-test' : 60,
-  'qos-test' : 60,
   'qom-test' : 300,
   'test-hmp' : 120,
 }
@@ -383,8 +378,8 @@ foreach dir : target_dirs
          env: qtest_env,
          args: ['--tap', '-k'],
          protocol: 'tap',
-         timeout: slow_qtests.get(test, 30),
-         priority: slow_qtests.get(test, 30),
+         timeout: slow_qtests.get(test, 60),
+         priority: slow_qtests.get(test, 60),
          suite: ['qtest', 'qtest-' + target_base])
   endforeach
 endforeach
-- 
2.39.2


