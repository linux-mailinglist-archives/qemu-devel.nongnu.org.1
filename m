Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D396B7C8113
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:57:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDst-0007F9-W3; Fri, 13 Oct 2023 04:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsP-0006Ek-LV
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:34 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsM-0001YJ-Dp
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:33 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40684f53ef3so21325105e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187028; x=1697791828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0q2+pTH8sPqGJ1vK2x6iOCgbhMG+GiWcxF7S/h5W+4Y=;
 b=y1uPPptRB6fleE0H7/vtJDxQg/yoVgAhT+j2pt+3LkebrF+q1qi5Btvvryhs7E5QPY
 zvRMsJai1wo9mc/mWZakNwOAAN7IWpqEfy+PmuLxHl+Sq+SpvqYXzBHTMHtBNBlbOPMX
 qYY3JbxKc6br8MqCz8nv/2qzRLiFnKSFxwC7YI9O8d/It4JZQqMIDBgbaJtDHh+5l9jY
 dI7rRH26CWguHBzzvztptRgaLBiQBKPrFBWty3VZmz5WmzYOXiBuR5uVR0ZbrxMia1u5
 3RIdMUxPPZbHsDvh2acy3+353Q01SBG+loc8rYWLq3htKJhpq3p7BX1ddwIE0AaO0ed0
 1QdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187028; x=1697791828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0q2+pTH8sPqGJ1vK2x6iOCgbhMG+GiWcxF7S/h5W+4Y=;
 b=u1M/AAX12E3Majmbkj64YV+FRT6sAqA3X9kGJ5fmDT9tEE6Gx39s+RramV3RG6ppeS
 xnLgHh5tVYrCUgYsL8ekv5LVgxyKA4MtOIStpKmNq+759GDPEXLdA7n0ZoZFCr2H50cp
 Yy5vutC7tf2USBcR4xZohcJ4QZ0lqFLAaYMcL+VgltY9B4JJJ5r29aTqIwEge2zHdEZi
 7PCxvcVyTkF3ghQyjzKO9/5qCU0cUJhWk0mk5R+83GxOOmsp9ZcElB8w+F4hm5yvmYS8
 E5OpPS9lRsQSyAN60WKHTMkRpx9aqFmRvUOrnHkaBCQf4puxLeb5exAXpTxufheZcjR0
 kMfQ==
X-Gm-Message-State: AOJu0Yx2mqGd8Mz3HkIPC7+5E7/wm3zsHTSV0XnJ8BqN82f5/NZBwGbu
 /zkxi8tq3BGxwsdmVkkIqgG8Ttq08WkCXxBpmQQ=
X-Google-Smtp-Source: AGHT+IFB2Da4NFkBTUFrC0QJfxWpWdZ+pn5sOz3JoIBz9abuzuR94qCRp3lV+prnZGZX4YsF27xY9A==
X-Received: by 2002:a5d:44cc:0:b0:31f:f99c:6009 with SMTP id
 z12-20020a5d44cc000000b0031ff99c6009mr22133607wrr.22.1697187028633; 
 Fri, 13 Oct 2023 01:50:28 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:50:28 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH v3 61/78] semihosting: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:29 +0300
Message-Id: <400fe9b92164a552f135951b0a01c3c26c37d0b1.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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
 semihosting/arm-compat-semi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 329ea11260..c7d32cfca0 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -786,7 +786,7 @@ void do_common_semihosting(CPUState *cs)
             common_semi_set_ret(cs, 0);
             break;
         }
-        /* fall through */
+        fallthrough;
     default:
         fprintf(stderr, "qemu: Unsupported SemiHosting SWI 0x%02x\n", nr);
         cpu_dump_state(cs, stderr, 0);
-- 
2.39.2


