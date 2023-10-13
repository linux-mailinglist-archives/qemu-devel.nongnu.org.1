Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD427C8102
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:56:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqr-0001v8-7J; Fri, 13 Oct 2023 04:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqh-0001Ks-2K
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:49 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqf-00019a-5l
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:46 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32d849cc152so1770581f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186923; x=1697791723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qc9HpijFQivyOL3AKnXalk2ocx9i8VrTifhkbMOO8A8=;
 b=EPtnt+IXzPWhmhkKMztjqqMSuRrfz7mXW782bXxGZEn7A6nIgtN21mnfLDyCye3mx0
 FJWKDuIPSpLV8u+ZH7AT8kZICUPm1f0edtBOQN7QMqVo23fedmn97CcfeV0vN9K93zVM
 Yzi+8DCISyv55xBLNlpuh808eG0rUbqtJZc2z94r9UWUZ9SDCjk1sh1cgokHH7QkCxG1
 qeHOMYDXdUL49GMYMXUNllcVVsJug6OMRSGIwCgXJ/dY0WHjSMusv3tmBacKpWPzRoOB
 ABWidDxlLYDfMzuACu1JB2y7Az2NJnKbIJ27Fts6C/9yZaTE6Q5NafRvSybeKYnP1Ift
 /vlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186923; x=1697791723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qc9HpijFQivyOL3AKnXalk2ocx9i8VrTifhkbMOO8A8=;
 b=JuKj5Z8hln/f2KxqNxYFlOVSERrenZFrky54BxrmM2KIDneUFJIcu/q7ux0jqiAtG6
 6VN4LUCQ5nPr8i5b+bI+N1NU3PShUspQdmyqIV+UWpnXBmrO8eUF7g6Y8RExPudzbim1
 o2P5gXX6kunp5tuya2gnQYumJwU2g+zjMZ8hmiXBzEKZixNZyqRWCGU2LQDK+4K7kT5L
 qBO0hmy5kjwTN62VnQBcgPp1/MQB843TF8u+aiywZTu/md6BkMhuqPJdaH1c51bOu8PT
 MQP/iHOze+o6r+Wy0Otokv9v/Cwq6j5xTeQUO+QMMnUrJrrXIfAfIs6oTWBA0/mS0Zy2
 RlNg==
X-Gm-Message-State: AOJu0YwekMm0ov0thDC8TEFDHkF3Aqd2dAGSUP7MEbN1eA0VtpZjqw2O
 ugOz9EkXn+10L0Hgu6SC2TdsHQxMuF4UB+yd7Og=
X-Google-Smtp-Source: AGHT+IGn3iE9KG2pD2coCv0hmWEALBeouE2fd4zB7xh//0DfetCPgJDfYC0yvLP3KtSRrtaU6Ybtkw==
X-Received: by 2002:adf:fb0b:0:b0:317:6ea5:ab71 with SMTP id
 c11-20020adffb0b000000b003176ea5ab71mr20565012wrr.30.1697186923427; 
 Fri, 13 Oct 2023 01:48:43 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:42 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC PATCH v3 54/78] hw/core: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:22 +0300
Message-Id: <ab61b72bcf48f69bea15288428c91db253d99b2d.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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
 hw/core/loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 4dd5a71fb7..559d63a1e2 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -672,7 +672,7 @@ static ssize_t load_uboot_image(const char *filename, hwaddr *ep,
 
         hdr->ih_load = *loadaddr + sizeof(*hdr);
         hdr->ih_ep += hdr->ih_load;
-        /* fall through */
+        fallthrough;
     case IH_TYPE_KERNEL:
         address = hdr->ih_load;
         if (translate_fn) {
-- 
2.39.2


