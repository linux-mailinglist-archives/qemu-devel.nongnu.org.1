Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2D27C8106
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:56:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDu0-0002w6-31; Fri, 13 Oct 2023 04:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsq-0007Bc-9Z
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:51:01 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsm-0001cq-Qp
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:51:00 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40684f53bfcso18891535e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187055; x=1697791855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24WDS5kL/kles8isSBNhIvBqbktppJbOkL1mvu/iP8g=;
 b=h7LmFUKBREnkpylfYjEpN49nzFVCnqSEZuQa5NFtZCOA/K2FvYB1xZ/CXWGHf6GJpk
 ZliiPQInsSdTxJTJUkRZLsAWjDIuiVqCOG4PJ+da+Xi8mdX/FQ7LX/M8MINuEXpmRuut
 /J0ukwac0q+zBmF8YyYR2j/5wQbjMd1vZ6U+hk/09lbKOtbS3fkLPj+7dDOwbo+6VOok
 5qyclNp7hxGy1bIJWfnyWf6HMeLBbdlAvE7CBl6tVG1cMVKs8SrqTz29O2qw21EvDQKt
 3h+DopZLE6nJP4+hGvzWJviYq2TmYD0idxOCIMjhnPKV4uclzOqMIMZE+ScbYc1l2uyr
 UqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187055; x=1697791855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24WDS5kL/kles8isSBNhIvBqbktppJbOkL1mvu/iP8g=;
 b=f51PSxe/ncPmyPdTVsCh+pmG+t7OgI5uKRmW/rpTVw7zR+8SU1Ud5GC3PXy7Obpchp
 AXNJgElP//r39X5Ji2KYD6ed46oSWT6ECE9L2ZxzgpIsE/4MvQ+poNIk9fxSlTFZZBk5
 juBHWeJo23DwvPDLwXDb7uSffrUG2YaLZxDVRcaklaZCbcxkjJOZhQd0N88DidLWwd7d
 Nl0SrfyKLi5YdATBEKlI7IHBLz05bGodwclzrX0l/+QGbOP/EW7OOOoU051SX41IG0l6
 qPukjpxvi7poWc9Gi99e41n+sNV5zXezhgCCUODYSeZlk0eC65GYBFpWhviOTWvqBKMr
 bBYw==
X-Gm-Message-State: AOJu0Ywz3qUywWBlcywh8XSjXqe5ARSqdkuiNNMXsNuRL1vqrDMULmTO
 l7Oq7bcJF1VflX2KL9tljUdS27hawtDINhkw76g=
X-Google-Smtp-Source: AGHT+IGcg1PBtr/W6hQpgQ2ZIju0gV3R3Bs4h9EA8eO99NttlZaHQphFkgU2MICovIHzHixqSN4y3A==
X-Received: by 2002:a05:6000:38b:b0:329:6bd7:470c with SMTP id
 u11-20020a056000038b00b003296bd7470cmr22245666wrf.58.1697187055286; 
 Fri, 13 Oct 2023 01:50:55 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:50:54 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [RFC PATCH v3 76/78] qemu-img.c: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:44 +0300
Message-Id: <02acae3c479ea0b45ce2c8886e64e7b7292f915f.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 qemu-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 6068ab0d27..df2457a6fe 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1906,7 +1906,7 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
                 }
                 break;
             }
-            /* fall-through */
+            fallthrough;
 
         case BLK_ZERO:
             if (s->has_zero_init) {
-- 
2.39.2


