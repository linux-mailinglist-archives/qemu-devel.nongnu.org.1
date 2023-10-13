Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A4F7C813A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:59:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqX-0000UP-8v; Fri, 13 Oct 2023 04:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqC-00086Y-4y
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:16 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqA-00011D-Gs
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:15 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2b95d5ee18dso23394141fa.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186892; x=1697791692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvAmWYbTauMaadxC+SKeC0iie0WLKRh1BgGHvpAoULc=;
 b=Mv7u46PtTXaAED7ox3KlydQqIQul7LlW8kidffkNfVJb8jJcHLZ3BvUl2nUWSVAd8S
 rnbDP5N+p20FtuESswwdRTrV7xC6S2N08y9nLH99hx85T+O6iP/wBmiqDtogYrACyXBg
 cTtKgD6LUSbHNjeEl0MrO1nitKwX3lhAlRE2jno2HF9gVyYc+Ns1zQEbUZhB6pqoyz0N
 /F5apLRCXfxPWzVbUGs0wgijHuU2TvKFvSLRQu8Glf29XU/SKRkihHuinxQVbqSTH/MR
 zZL+gDbBXrhC3tItmPYQgsn//1OFxwT3L+qRjSc2T911d6Ho2gn/Fl3jnX3ld/msMAWl
 l7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186892; x=1697791692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HvAmWYbTauMaadxC+SKeC0iie0WLKRh1BgGHvpAoULc=;
 b=g/06qwLYwNvrEhbFD2D/DCyg49S9oCWGia/F5cugHSH8RmWIyKEsE+94cxIhbwy29M
 UVWsSavnS1MIzXzG7iOV1afZtDCtGVqbIhL6vwPlPQcvWozUDumpsLftWnkWJJqZPpEz
 gX6nZdZ6DjV5rWtMGoTEzbDz1uFAVHb1PcAIABPCHLdfYImiFekzd/cjoVP62bBDgitK
 qfL5mb2Kuihs94Xwq2Pm42WDmPp4JIF/1LouRazF+47wVgs9WVv30gDsHTBeDXRF/eR9
 grhvwjrpZXQSRi34YgEf7iaMy7TwUaRtjC/bFa1HH1RGdTiYbW92FiGerrmvlJc6x0TO
 OD+w==
X-Gm-Message-State: AOJu0YxY6iTcbdnQoIkI14agVFj+8g4VPvFw3+xTT4am0dhgeYg4Z5XR
 D6KQmnS8Ur8zIIj0LZ5A68VBADzpaVunAc43NGw=
X-Google-Smtp-Source: AGHT+IH9pYbXLwjGDXfVxWe1bPzz+wahLlrf1b1Ae5xVjFY/qMP0eAZhSSTlAd0iE2YL8GAjBoa7Kw==
X-Received: by 2002:a2e:be93:0:b0:2c5:8a2:cef with SMTP id
 a19-20020a2ebe93000000b002c508a20cefmr833441ljr.11.1697186892602; 
 Fri, 13 Oct 2023 01:48:12 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:12 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [RFC PATCH v3 35/78] target/sh4: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:03 +0300
Message-Id: <30a3cef257bdaa42d8866d766a82f85cfc4b568e.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x235.google.com
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
 target/sh4/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index e02e7af607..c1cc5e82f4 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -170,7 +170,7 @@ void superh_cpu_do_interrupt(CPUState *cs)
             break;
         case 0x160:
             env->spc += 2; /* special case for TRAPA */
-            /* fall through */
+            fallthrough;
         default:
             env->pc = env->vbr + 0x100;
             break;
-- 
2.39.2


