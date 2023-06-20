Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9643573660E
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:27:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWh9-0003rV-Gi; Tue, 20 Jun 2023 04:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWh2-0003oF-Bh
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:28 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWh0-00067z-5U
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:27 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-986d8332f50so517180766b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 01:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687249583; x=1689841583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Eu+o+b/kPOX7bqHOKI9EK0FyfSFZrSyUyQQ0MvpYlw=;
 b=a0ThfYa/SzOSvBKAFQHWKqp6XRTKHSiCAE1SFpblkMG4mm+XHPn+GbI+TegXQrdrdx
 GaFTAQZ5qVJ/l3agcqPFeb6P+t3Xfstxy5/zO8UrxttzL6VvqgZ3pQ4CNjDwsWMQLEaM
 paQ7Iy3ZKZnTgqRku0QSXT0vtVNsnJ5BExgFD9y8OM/0y4a+Oo5SNhE33Kv1TFwU4jj5
 XkyDY6f/6lr1CWLVZyJ0S9WCcxh+8znpvc3GJbkA4Gg0D3C8G56jo9biscwBYb32zxsh
 rNIC8c/pFWKwDSMDWs3+UpW6bwkT+0lrvMsuIxacKr6WLSwL1FetIFg3a55mm0xDl/tB
 Uqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687249583; x=1689841583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Eu+o+b/kPOX7bqHOKI9EK0FyfSFZrSyUyQQ0MvpYlw=;
 b=IBDye1VP+qTUbOe0NzrzGdJLDbV152793mnW/B1p3CUT6ka1gXIv/feQrd+N4zDRZ5
 cIIR797cf+k4ASBU1R/aqRjA5VND5pAa/tDsgv+TmEn+P3ZoEEQVnmxDT4srUcdP3fQN
 8ocM/RbpjeCmJEyLG/s+PzrpckwCxZN3ACqMBHpzOuMhE0c3DjYy2dW9hQa2h/Pfw/s2
 8E0SbtAZJDwcpwuUfPqOKllHuxFK5Ux8in4uZA9iHmPLNnb+CYH5Cc1ZIKC3Mu+BJkUc
 2XCm9UIDCPPvVY9oskKpxD73FK4OyvtIu/bxZ05syKq1NHJL0bVLlX8Fb6CC2Ah6GL3z
 AlYg==
X-Gm-Message-State: AC+VfDy6OrFv+Ca3v+CPSfES0ZJz52bWDAeEd41/tnaU5R6WE7U0NBHY
 oGSLAGZyOIcAAks1xfZqmhFjhfzzHJCr8HbygMzmVM1S
X-Google-Smtp-Source: ACHHUZ5pjbwfN4QSRP/8nmER2mjTz0Ba4yshXHOBOGvaLI0T4HGSSSBx9ZvocaabA5S8AhpijfxfHw==
X-Received: by 2002:a17:906:4793:b0:96f:5747:a0de with SMTP id
 cw19-20020a170906479300b0096f5747a0demr10873353ejc.6.1687249583545; 
 Tue, 20 Jun 2023 01:26:23 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 z19-20020a170906669300b00977c7566ccbsm935901ejo.164.2023.06.20.01.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 01:26:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/16] meson: Alias CONFIG_SOFTMMU -> CONFIG_SYSTEM_ONLY
Date: Tue, 20 Jun 2023 10:26:05 +0200
Message-Id: <20230620082611.770620-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620082611.770620-1-richard.henderson@linaro.org>
References: <20230620082611.770620-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We use the CONFIG_USER_ONLY key to describe user emulation,
and the CONFIG_SOFTMMU key to describe system emulation. Alias
it as 'CONFIG_SYSTEM_ONLY' for parity with user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230613133347.82210-8-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index cfa98e9e25..3276f738ae 100644
--- a/meson.build
+++ b/meson.build
@@ -2864,6 +2864,7 @@ foreach target : target_dirs
     endif
     config_target += { 'CONFIG_BSD_USER': 'y' }
   elif target.endswith('softmmu')
+    config_target += { 'CONFIG_SYSTEM_ONLY': 'y' }
     config_target += { 'CONFIG_SOFTMMU': 'y' }
   endif
   if target.endswith('-user')
-- 
2.34.1


