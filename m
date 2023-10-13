Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 768CC7C8112
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:57:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqa-0000nA-DG; Fri, 13 Oct 2023 04:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqT-0000Cv-WA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:34 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqQ-00015m-Vi
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:33 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32d80ae19f8so1513318f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186907; x=1697791707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+SWvWRe/WXorMXfdn3xcOe0TvOIYlqiKPQ2dh6kG+s=;
 b=lox7G2xplsP43RSzX+5hWdXrTRJQSprnlJJ2/H3+o8asRRhQQUGG5VqxrqAGLFU4lc
 MwkDrZEQxKphilRwa3+OGKxYFU1LEimdUg+0HOiDpCugE+TCCo6zPsFCG2M5Adbcr6Am
 A2uSfuO3JACRgHRk+hDakTsSnHqMFf60VXaBT9lW43gjQoKNvDl/12lSjAQbdeqGBm+o
 HyYFy4qTWpSTKohCsJS8e1g35yxipFZBvE6quztHeOQVVtL93MDD2F73j1ibaYzrJkNW
 lAZuWIQMInsSfaNOO2DVUafZtcVaZQrvgApxJTVA3swG+gV9XPn1Eo83q9qpUUn6EFNv
 V5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186907; x=1697791707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a+SWvWRe/WXorMXfdn3xcOe0TvOIYlqiKPQ2dh6kG+s=;
 b=g/HJSrG4wyTzXlg6fkFlNtxy0/azh9mI8XtMzZOYZBpyYhMuuh/3TwHFOrrT0gmJUa
 8kC/92vf6167SmkWncz1RNfF7s6OKjegLQ4kCRr82vtbE/vSJ+1WtKbRvtjMxdvqX4Cd
 CLPodScnnAGq9vxNUHkgvD8qLV/qdofeq5+N8gj0YxDwQrWLnU11OObTdw1bVnCsaXeB
 JRyQgS84YG8U+rLHqvtZvsVLJiOiDhKEaIIrj9BPLBgPPju2bykyt5LOnWatUC4kGH2V
 +MgkVJkkwdbTvagB87d+YijIQDHZZ4T0Xh+63u9Houk7Lg1TvDWBl5PzADmQ88cxx0hJ
 BEww==
X-Gm-Message-State: AOJu0Yytrjku9WmPBdEyGUceucgfqGPIpGGPgM7xfOQAkzmu9Sik3kVG
 rhrtPtHgvKJ7BByDTfPdZBDLU19H5IvLDJ0/wfs=
X-Google-Smtp-Source: AGHT+IHLbxiYS51jNRpWOYASrZqBD5MD4wZSS9eIPxtCvdqipfOqwOQ1OzTn/DMqSa1uMJg7CUj5cw==
X-Received: by 2002:adf:f3c6:0:b0:32d:9fdc:a136 with SMTP id
 g6-20020adff3c6000000b0032d9fdca136mr391942wrp.11.1697186907427; 
 Fri, 13 Oct 2023 01:48:27 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:26 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
Subject: [RFC PATCH v3 44/78] hw/m68k/mcf_intc.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:12 +0300
Message-Id: <a274206b376649f3482e469725de284879985331.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
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
 hw/m68k/mcf_intc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index 4cd30188c0..9556a0ccb7 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -84,7 +84,7 @@ static uint64_t mcf_intc_read(void *opaque, hwaddr addr,
         /* LnIACK */
         qemu_log_mask(LOG_UNIMP, "%s: LnIACK not implemented (offset 0x%02x)\n",
                       __func__, offset);
-        /* fallthru */
+        fallthrough;
     default:
         return 0;
     }
-- 
2.39.2


