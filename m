Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E8C72E443
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 15:37:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q94CS-0002VL-0B; Tue, 13 Jun 2023 09:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q94C6-0001tZ-JC
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 09:36:24 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q94C2-0002jf-II
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 09:36:22 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-977d0288fd2so914770866b.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 06:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686663377; x=1689255377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTge5Z4b4nMW2vtK7DGlD8HEj0g/6GKKAfDYFgtpth4=;
 b=XH619R4kQi6Lp5yKVpKuHUy/njKxMMAs2zawhmz311JWOOhmIks7onMHi5FK7yoQxB
 qZUKm/CbUdWdxgtuXa7VjKtPOuD32dPDZbZkwXc1EW69fpSn/vq3Um7GNG4w8MAnyjTj
 OUVyMiReFufNPu1q8JYMGrlBCRfB0qJUhYVfdFzx1BE0xPxkee/MTHFuB77GY8cYpSYA
 pRBk4TOg35dzrVeH2PJxxbQB3PJHUjwrEuBezf70NY7UTxEOaOEQeUdmpSV7UlKOSca5
 wwH8ozGiitVAd1gTf/FJir+jWxgZZtnRgy+vLbCQT4skAllNj+h4iFdypDJ7EBG5K9o/
 DD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686663377; x=1689255377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TTge5Z4b4nMW2vtK7DGlD8HEj0g/6GKKAfDYFgtpth4=;
 b=FczCWD4gw4/GmKcVMWb48+cGF5c3uO5P2WrL9AZ8fzFSWPYymokB0h3w+Y24fVq/mz
 jT6TApG+WkcvZICmkIyxGiiKlmgrwjvItsPPueKRT2isNYWKdBV57qRrpozcEzBpBun2
 QI1kKVFZbrF1IK4h/dGvKqAl2qPlKU4/1PjNDD3IfsMDiwTsrmiwHFF3O3qohS+vtc0c
 BY1fnnYgnp4kpI8Glz2Yi0AmW5vUbz4j6om2ko/50nIFhwzOw5xruz+nasUjs4wPSa7Q
 F3Wx5IhH8ncikMudHUmiZP4ame81rMMWXHsgUnpSXL/AmB5eYtQPSF73jh3aCiSPoPZU
 nuLA==
X-Gm-Message-State: AC+VfDz+zQ9k4YO7tZUn1XZIr/BRtw6amctXgwlXvz301t8k4PS756Uz
 iEUcQiEZQj5bJ59pVmFF1xeWwhycDNa4qUw/UHc=
X-Google-Smtp-Source: ACHHUZ6hMVkSHlqaMjppBtKGGgUkagxDy8ZxNeh4aRSSviZEEm+vlH2wy6n/ntGh/gRKGKE/w6MGOw==
X-Received: by 2002:a17:907:9307:b0:974:1ef7:15be with SMTP id
 bu7-20020a170907930700b009741ef715bemr14360731ejc.30.1686663376750; 
 Tue, 13 Jun 2023 06:36:16 -0700 (PDT)
Received: from localhost.localdomain ([213.235.133.109])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a170906710f00b009745bac0567sm6583544ejj.126.2023.06.13.06.36.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 06:36:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 7/9] meson: Alias CONFIG_SOFTMMU -> CONFIG_SYSTEM_ONLY
Date: Tue, 13 Jun 2023 15:33:45 +0200
Message-Id: <20230613133347.82210-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613133347.82210-1-philmd@linaro.org>
References: <20230613133347.82210-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

We use the CONFIG_USER_ONLY key to describe user emulation,
and the CONFIG_SOFTMMU key to describe system emulation. Alias
it as 'CONFIG_SYSTEM_ONLY' for parity with user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 34306a6205..8bfa37afe2 100644
--- a/meson.build
+++ b/meson.build
@@ -2862,6 +2862,7 @@ foreach target : target_dirs
     endif
     config_target += { 'CONFIG_BSD_USER': 'y' }
   elif target.endswith('softmmu')
+    config_target += { 'CONFIG_SYSTEM_ONLY': 'y' }
     config_target += { 'CONFIG_SOFTMMU': 'y' }
   endif
   if target.endswith('-user')
-- 
2.38.1


