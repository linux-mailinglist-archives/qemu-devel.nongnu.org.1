Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3233E743CA3
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:23:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4r-0007lX-Kr; Fri, 30 Jun 2023 09:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4q-0007lP-JI
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:20 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4o-0003T4-UC
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:20 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-313df030ccaso2105397f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131337; x=1690723337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gT4NK9p8wEYJPmQQBQUhLbzesb3JroSJqWwYF2RqsEw=;
 b=IwSGEYbYQtOu5yoCQo8Hgw4LQe/7+WK5hEzKTgXgC5Wtoc92rRvnIDJcFNs4PP26P4
 bOqtRmJsFoUt60YLD8rVqhL2mBl2qJRvy2Sh9dPgvPFWuffJ1sirsTYaFQFnceSwH3g3
 eUbGvLWV3EQmjDU4+YZG+GnOm90dp5PxXpJmeGGpRG+gPfgDLfbajYVNz9KzOHHpoD8e
 Cq/ksRjpAN2GKbReIpVuOxvszh5EdCPmgrvt0SgUkfUSXy82wOeoGowl3dUOIqo+p95i
 VfPSaDYpgsTkoX2xF+VKGyyeVeXQNj7aZqN+AMjd+Qm3RdWAHr64b2uwMldwlMWP1anl
 XzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131337; x=1690723337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gT4NK9p8wEYJPmQQBQUhLbzesb3JroSJqWwYF2RqsEw=;
 b=BgPOwZNLZr10lHeIj3P6jkgY2NuSQSjKmet8pDZFS8JIvNMDU533UXPokcR9Gpa7y0
 1I/VFkZ/HoiaZlHHokNAu42xLOl09dFjw6zrXS2nXs2VmqAYeS8GgCyUqnqoh0DBZZgt
 OHDx5/YmefBJfNRFG8mgU9AiVJN+TRILkJMjZQPnRS9Pl5+hT2Lu9Q17C2MixJq3m6VM
 IrBnGSIN8lm3P7L879xHDR5hK/Wq5iYUUKGp4qOvuX1vsi5wcz2rbo7qeg/Trm/eBeJv
 9zsiPQz78w+NCIbuNi21PCegTOjacgikdw3d3RLsGRV97AeIzuNR4rmouzjCTOnC0pp6
 sayg==
X-Gm-Message-State: ABy/qLYoEgZZQpOSxpJyggknrDUeL9tjXXaK764P9XO2LgN4GUl/99H5
 8WkrVodcT1bYsd4S29DzilFUlUnbplmxE+X+y6UPBQ==
X-Google-Smtp-Source: APBJJlFC2RuFcO9cS/MfP9O4nnurw9QmBLeLYA6Pr7pwLf1RAoxd8BY9WihGTSE4jBBqTz0wCoRQWQ==
X-Received: by 2002:a5d:45d0:0:b0:314:276e:30ce with SMTP id
 b16-20020a5d45d0000000b00314276e30cemr402000wrs.51.1688131337246; 
 Fri, 30 Jun 2023 06:22:17 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 21/24] accel/tcg: Accept more page flags in page_check_range
Date: Fri, 30 Jun 2023 15:21:56 +0200
Message-Id: <20230630132159.376995-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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

Only PAGE_WRITE needs special attention, all others can be
handled as we do for PAGE_READ.  Adjust the mask.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index dee4931f86..7a36f95bbc 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -561,8 +561,8 @@ int page_check_range(target_ulong start, target_ulong len, int flags)
         }
 
         missing = flags & ~p->flags;
-        if (missing & PAGE_READ) {
-            ret = -1; /* page not readable */
+        if (missing & ~PAGE_WRITE) {
+            ret = -1; /* page doesn't match */
             break;
         }
         if (missing & PAGE_WRITE) {
-- 
2.34.1


