Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 897377C80FD
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:55:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDtN-0000jW-7P; Fri, 13 Oct 2023 04:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsT-0006fJ-LR
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:39 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsR-0001Z5-AJ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:37 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-406609df1a6so19633855e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187033; x=1697791833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X54cniTGFOWq1Xmce/3hJhLMp7Sc5Y/WCKJ0ySfD0QI=;
 b=cUVe8H01bsPF6ANErFz8XpkaRdKsthI5QwXWC5atTwWDJtaDNoEECVzZLHwvjlFOQf
 wE+gt03TG3reuCRrPpCcABouRXrf656EJYHVUAFsHAocPJ/DIqu8/V2JyAdgqQPf2CYE
 /pPTwVn4qPPwOMSfIqVrZqNY5meS7qBy+W1CyUaLmeRz323VMqQSS2nQTwNP8ryQK/Eh
 VLMEJoyXkn9t2mDNlRLiUzO1X0e5J94Ki4EYQ3yUpv3rfYuudQFvkWpAqp7iQD5e05pS
 EWw7/Nlr4N09+aINw7HQC1TMS8lvd9Y2D6gPmIJxJYWwliCeDuBiMLFlBhWC4ljH+Cv3
 t9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187033; x=1697791833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X54cniTGFOWq1Xmce/3hJhLMp7Sc5Y/WCKJ0ySfD0QI=;
 b=B/xr6mgvyCNSkT0xTZSypJJzBtZ8yOuNXC00C+Pn8SM0CKIT1YXzIUesFUQr/jxLMU
 VeSYdAJy5agwGqGFVM6BJCiQvSrZ9SRAhjfrekzxsLbvX3/8piAp0/+VvjeVmHuOQ9wG
 XhUK6LbuoUu7ThZmZ7qB4yLXQEhmv5JjjQDWgMS4ylStQ10/1PNK9sAQLojzbk5pmfE6
 wOQmIfqW9JTgj9LMbvMTpQgPsOdHNL+Mj0JVWvqP2e9o9JOgqgX22AIhnAlw+sVHwnZk
 lbBncz3NhPnZScQktAvLp18nN+mlCcpP9lY5D2+U4gGlkLBY1dFxz+LVOw/fZJjAsDEo
 8MGg==
X-Gm-Message-State: AOJu0Yy7ZjN+UUIkUUbu9YfoaVrPYsMxh0qOTWYQ0JD0xu5B9ZdKsj9A
 RSffywOqoZSdMQ20B+RlZUs+r777QF16g1Qemyw=
X-Google-Smtp-Source: AGHT+IGxzoxaUg5kDev6dfa3JyRSJrXA21LTYZXUfGJlhH0ni80LYskAELwFMaPXRJhXKz4/Pz2hXQ==
X-Received: by 2002:a05:600c:220b:b0:406:4242:e7df with SMTP id
 z11-20020a05600c220b00b004064242e7dfmr23950310wml.35.1697187033303; 
 Fri, 13 Oct 2023 01:50:33 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:50:32 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paul Burton <paulburton@kernel.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [RFC PATCH v3 64/78] hw/mips: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:32 +0300
Message-Id: <4e6afd01831a38c59d09f8f0483b304b7329f4aa.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/mips/boston.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 4e11ff6cd6..4ca53b790a 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -173,14 +173,14 @@ static uint64_t boston_lcd_read(void *opaque, hwaddr addr,
         val |= (uint64_t)s->lcd_content[(addr + 6) & 0x7] << 48;
         val |= (uint64_t)s->lcd_content[(addr + 5) & 0x7] << 40;
         val |= (uint64_t)s->lcd_content[(addr + 4) & 0x7] << 32;
-        /* fall through */
+        fallthrough;
     case 4:
         val |= (uint64_t)s->lcd_content[(addr + 3) & 0x7] << 24;
         val |= (uint64_t)s->lcd_content[(addr + 2) & 0x7] << 16;
-        /* fall through */
+        fallthrough;
     case 2:
         val |= (uint64_t)s->lcd_content[(addr + 1) & 0x7] << 8;
-        /* fall through */
+        fallthrough;
     case 1:
         val |= (uint64_t)s->lcd_content[(addr + 0) & 0x7];
         break;
@@ -200,14 +200,14 @@ static void boston_lcd_write(void *opaque, hwaddr addr,
         s->lcd_content[(addr + 6) & 0x7] = val >> 48;
         s->lcd_content[(addr + 5) & 0x7] = val >> 40;
         s->lcd_content[(addr + 4) & 0x7] = val >> 32;
-        /* fall through */
+        fallthrough;
     case 4:
         s->lcd_content[(addr + 3) & 0x7] = val >> 24;
         s->lcd_content[(addr + 2) & 0x7] = val >> 16;
-        /* fall through */
+        fallthrough;
     case 2:
         s->lcd_content[(addr + 1) & 0x7] = val >> 8;
-        /* fall through */
+        fallthrough;
     case 1:
         s->lcd_content[(addr + 0) & 0x7] = val;
         break;
-- 
2.39.2


