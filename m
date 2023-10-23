Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC50C7D3BDC
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:11:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxVs-0002Qi-5n; Mon, 23 Oct 2023 12:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quxVn-0002Hq-CV
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:10:40 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quxVk-0001qo-RA
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:10:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4084095722aso28443385e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698077435; x=1698682235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5hoUi02NxWDs20ifpWCQFnAQBxqhpEhCw6XqoL6TeI0=;
 b=H2IjsxDFZbt3VkZxUwFMpgUbFescPikobcRuf8JlJl72FyUnxSIXa8ZLQlH0Zi6Lct
 YbrjSUxBL30VipBNauKSHHEnxnDRlazpfcWOSC0s9dIjdeZmbVeg6t8GLGqJ/Q3Z2qsb
 q5gyD+gLX4Fct79aiR8HXTZMAboe32HC5yZuO92FJ/k+TS4IauO6gsa+zCXm2HDl4GQF
 IWW0W7qqr1S96RxrHjSECXgoQOb0i3BURG0/BXMjZ8uJLn0WYg1cA7Lv9LaHIFQ29/e0
 GClBE09b1cXSRMhPggcxwpDY1/k7007cJ4RQXSPOhErFo90sFbPFe+t8zTsNNm0kjHsD
 GDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698077435; x=1698682235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5hoUi02NxWDs20ifpWCQFnAQBxqhpEhCw6XqoL6TeI0=;
 b=dQh5z7ifdxsapbS7bw/n8np8zBoyESf+LFDSoU6xqvcO1m3kCW6zB2piiaBARLpXm1
 Q8b26AHhpBV6cRpxOGrC4jbJy4sWNh5oCFmLU+TttCW/Lv6662SXccM2hi0usDtOpXI2
 CuQ4f0JQsKErKSgluHvjvLhflqmnYcmJC5r8bcKXSFA3oiiTqFBGF6rgccWoiqhxqxTW
 VaKp/DAjSw2taRdSCdP4YeZUzh2Swohnz6GWrKW6RW4JS05C8k/iyCVs8u+a3sgYmUSL
 P6lHpoBIklxEQUFB1W3AWeRRx7wTChsKH0mHET8QeHpbT2JGcB6IjBbyAeSPRpgDFC7c
 jinA==
X-Gm-Message-State: AOJu0YzAx/+4hoT2fTma1Pafqusilntv4FRJVUmxeap0gzIlZ6LWd/jX
 iOAe5zMnRa7yFXXNtUUHQeDoN5RDg6wJ8peoD8w=
X-Google-Smtp-Source: AGHT+IH/+PC+TIQdQo/VsH1OSQ5IxvWOWUzhWE+6KoL5qXIPn+sWopbHuZtWnwEY6Wt5BpslwpESoQ==
X-Received: by 2002:a05:600c:310d:b0:405:359e:ee43 with SMTP id
 g13-20020a05600c310d00b00405359eee43mr7808740wmo.1.1698077435158; 
 Mon, 23 Oct 2023 09:10:35 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-216-159.dsl.sta.abo.bbox.fr.
 [176.170.216.159]) by smtp.gmail.com with ESMTPSA id
 bh9-20020a05600c3d0900b003feae747ff2sm14712349wmb.35.2023.10.23.09.10.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Oct 2023 09:10:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [RFC PATCH 8/9] target/cris: Use tcg_gen_sextract_tl
Date: Mon, 23 Oct 2023 18:09:43 +0200
Message-ID: <20231023160944.10692-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023160944.10692-1-philmd@linaro.org>
References: <20231023160944.10692-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Inspired-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: please double-check bits
---
 target/cris/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index 65b07e1d80..3a161f8f73 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -336,8 +336,7 @@ static void t_gen_cris_mstep(TCGv d, TCGv a, TCGv b, TCGv ccs)
      */
     t = tcg_temp_new();
     tcg_gen_shli_tl(d, a, 1);
-    tcg_gen_shli_tl(t, ccs, 31 - 3);
-    tcg_gen_sari_tl(t, t, 31);
+    tcg_gen_sextract_tl(t, ccs, 3, 1);
     tcg_gen_and_tl(t, t, b);
     tcg_gen_add_tl(d, d, t);
 }
-- 
2.41.0


