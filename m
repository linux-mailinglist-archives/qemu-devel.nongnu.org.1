Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE7075EE6F
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 10:55:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNrK0-00026e-V4; Mon, 24 Jul 2023 04:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNrJz-00024g-3n
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:53:39 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNrJx-0000fh-J9
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:53:38 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4fb761efa7aso6133489e87.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 01:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690188816; x=1690793616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T1Y8T/xVALsYcshJKAiwyXKIcg4f5npWahbPLhzxr0I=;
 b=LeSKyAQ1cY7wirUMvIv4NpuHYWyZ6wZ7HC6HZ6ZQAGyBwC/GqN0Iedp8sB74P/z8d7
 nPe12tORKncsgJ/xlByaKUIOERzUD0ALCcHSNDsw6qEg5EkuBw1/KnpU9R6fsmyidg5m
 vK78FnqyEKtF8M94ipXYaP8EVg4fBqr/mZh9W5aTLz9U/enADkaUtgTIP7CrRKSRZSgM
 +6hUuS31pEJ63Hr8yYJFbHQWUhLYUWar2Rgn1u3n0FTQPqfNcH2hn6xq0tHaZeh0xtNZ
 ENmhDZhvgaWP18E3k/oHaLgQGZwmb4Of/ZOokMvRF25+Gw5zQd5nVaPyfGKYYgPvHO8v
 ywxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690188816; x=1690793616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T1Y8T/xVALsYcshJKAiwyXKIcg4f5npWahbPLhzxr0I=;
 b=QDbe/RCwwZt8lI8OU7R+gv8UGeXuB3Dp3Q5e6yMtIA85xgOBeyODlZr5cP1ntDl5bZ
 RNP5mk1X/T17b5pAl7YXKfhhQz6z1mt2N8RofRIbBopO9PuEsAo+/UqnJleGqV5egAdk
 LyeAMihIc+axtHbxVOaCAoj0nC3sKptHoZ9hzJZ61vsBB45+s3zGPlTYI3IxOMlZyn1m
 EV1f09UXsfQU366awfGeLK80+3brrKTs8DlAu6XA70AOZepMJ49TRsUngX9J1U9ir5Kf
 WPntIkfSmfYJ25+Fmt/mPympYruWhkvUMuIlyKeQVkbWHosj0dW5Y6QYG8uJxQoJyBnJ
 7Gww==
X-Gm-Message-State: ABy/qLZDw0OJS7IvKPgsuvidYo9krVYBgbep4GIfOcZBP7CW8cyKChpk
 TzgbJqYm88fR09rwlQ4eqYaNH8Ktyl3TNU3PveaY3w==
X-Google-Smtp-Source: APBJJlHLNIV/aNYs0N/0vz1Fm0H1dk4BlfuHuyww41rifiV5EevbsSg+ehaXtGWSedw+cmLRi3VNEg==
X-Received: by 2002:ac2:58e4:0:b0:4f8:7503:2041 with SMTP id
 v4-20020ac258e4000000b004f875032041mr4207696lfo.37.1690188815869; 
 Mon, 24 Jul 2023 01:53:35 -0700 (PDT)
Received: from stoup.. ([62.252.144.58]) by smtp.gmail.com with ESMTPSA id
 t8-20020a1c7708000000b003fa74bff02asm9570994wmi.26.2023.07.24.01.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 01:53:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Luca Bonissi <qemu@bonslack.org>
Subject: [PULL 7/7] accel/tcg: Fix type of 'last' for pageflags_{find,next}
Date: Mon, 24 Jul 2023 09:53:28 +0100
Message-Id: <20230724085328.4936-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724085328.4936-1-richard.henderson@linaro.org>
References: <20230724085328.4936-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Luca Bonissi <qemu@bonslack.org>

These should match 'start' as target_ulong, not target_long.

On 32bit targets, the parameter was sign-extended to uint64_t,
so only the first mmap within the upper 2GB memory can succeed.

Signed-off-by: Luca Bonissi <qemu@bonslack.org>
Message-Id: <327460e2-0ebd-9edb-426b-1df80d16c32a@bonslack.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index ac38c2bf96..ab48cb41e4 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -144,7 +144,7 @@ typedef struct PageFlagsNode {
 
 static IntervalTreeRoot pageflags_root;
 
-static PageFlagsNode *pageflags_find(target_ulong start, target_long last)
+static PageFlagsNode *pageflags_find(target_ulong start, target_ulong last)
 {
     IntervalTreeNode *n;
 
@@ -153,7 +153,7 @@ static PageFlagsNode *pageflags_find(target_ulong start, target_long last)
 }
 
 static PageFlagsNode *pageflags_next(PageFlagsNode *p, target_ulong start,
-                                     target_long last)
+                                     target_ulong last)
 {
     IntervalTreeNode *n;
 
-- 
2.34.1


