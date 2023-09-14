Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2F27A0DA0
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:59:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgrXK-0007tr-3f; Thu, 14 Sep 2023 14:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrXH-0007tO-8r
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:57:55 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrXF-0007eB-OF
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:57:55 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31fa666000dso1164438f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 11:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694717872; x=1695322672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMn38YaRL7n1ZrYU6enGHYkM4IPLYAQFbb/wgKNFsZs=;
 b=Ngm65eBnmiHgPbVZqDaNQ9i1iuI5/FqXHvwYxFDoEc7G+xOHfpQkgTf3vhw3dmNgIp
 hZT7ezioSFeEUgap7GxvWkvEGBYmFkCPOzVT9s6Q+1uFlhTzSUIuDEDJ+hNmNj/ZOutf
 LGj83M4euoVh1/nJYKwXOlKEm5toqc0Ouww+mZVy597v9zeYgoQKuIHdvDu+yGuwNI9h
 kFwpCnl4z2Zu2uNaXl4++Z1OQAe3eT1lT3MqHBL0OXgepXnEAi3Tq3IfDFR/j4CLv5XG
 j9jNR0lSA7wyRY9gfT9HwaJbCVyaRoNFDowzcVCT5QilQa+2BP1U/zfYvdm4NIGEUo2S
 j5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694717872; x=1695322672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DMn38YaRL7n1ZrYU6enGHYkM4IPLYAQFbb/wgKNFsZs=;
 b=WM/KxlXk5fvZk+QEEI6FB74Cn9TG0N63d1Zr8EbCj8ztGFcEzV4duUkvyY401GGm4E
 4x6mv6/NkA20SjUrVMqWq5CpJD5Ut3AEXLwflFiZClXXb+6aTOJkN/TkqvcDEnAT/8n3
 Xp2acuLP3hnb/13p5oThskAI7rfgkWx8zIHD0ohzefxTCXIyRwx6JQhprPNyaD5IWAW1
 MZmxOUCjixme2gaNkpoPyDyduOZvv4Gn9p9WN8lK1uevOOr/3vTuCUBjRnBydmNsJLMS
 CJfX3aaw/Phirzwq1uVlqT64nOMKl1OEddupDckgPf6ArJc7OqaVdWplKsNin5jAjkVu
 BBrg==
X-Gm-Message-State: AOJu0YxiX2vNJsOI7H8LZ1f4cddrqjTqO2fO0gaQ1yk/dRh0xfxziCW/
 TMSOmlR+t1qBiDR/RL1W1qDe/3sBH8sLvcCVbrk=
X-Google-Smtp-Source: AGHT+IGTT96e/Ayp6To+jfGLrVaLcHYvpRhziH0s7AkzerW8QC3la5axOhrxs7z1xe44B5VI9Z8HOA==
X-Received: by 2002:a5d:67c5:0:b0:319:775f:d553 with SMTP id
 n5-20020a5d67c5000000b00319775fd553mr5521834wrw.9.1694717872003; 
 Thu, 14 Sep 2023 11:57:52 -0700 (PDT)
Received: from m1x-phil.lan (176-131-223-129.abo.bbox.fr. [176.131.223.129])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a056402074d00b005224d960e66sm1243411edy.96.2023.09.14.11.57.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Sep 2023 11:57:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/11] accel: Rename accel-common.c -> accel-target.c
Date: Thu, 14 Sep 2023 20:57:11 +0200
Message-ID: <20230914185718.76241-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914185718.76241-1-philmd@linaro.org>
References: <20230914185718.76241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We use the '-common.c' suffix for target agnostic units.
This file is target specific, rename it using the '-target'
suffix.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/{accel-common.c => accel-target.c} | 0
 accel/meson.build                        | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename accel/{accel-common.c => accel-target.c} (100%)

diff --git a/accel/accel-common.c b/accel/accel-target.c
similarity index 100%
rename from accel/accel-common.c
rename to accel/accel-target.c
diff --git a/accel/meson.build b/accel/meson.build
index 76f3cbc530..fda3157a6e 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -1,4 +1,4 @@
-specific_ss.add(files('accel-common.c'))
+specific_ss.add(files('accel-target.c'))
 system_ss.add(files('accel-softmmu.c', 'accel-blocker.c'))
 user_ss.add(files('accel-user.c'))
 
-- 
2.41.0


