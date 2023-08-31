Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E16978EAF5
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:47:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfBV-0004Ch-8X; Thu, 31 Aug 2023 06:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfBB-0003df-CR
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:37 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB5-00044d-D3
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:35 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31c79850df5so498231f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478728; x=1694083528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1CYb36QZUIZDu4UGmBLcVUVYCmpeU0BzYEZkkE+tCKU=;
 b=o8Xsi2YT9edqqf71FfZ5T9ibh21NaeXFxDQYjDjtz1SYGKIYw0z0aEYt7ziXID3rgW
 nW9UgfD75P2EfNPFogBztu9rII/pE7o5oYDCe9/d2cG2OzveD+nDLkaHxTeXnHrGEcZc
 a7GdeM8cfqU42UF+K6X7KkUaXXVzi3vZ+KA5ncMOWlf5tmi6CCRa+ckhsbcFPJWgUuzp
 wWsVbOCJVwXB+j4adRE8Plg3sPcypyN2ksFlqX96tMt/OYkjP4yTzRo+sczOpllpHTD0
 rpTdV0v8yyD3+hpX7U6w7nEsQq5f6Gz0j1I+X8vrRB2oxzpOKekVcXNqZdqf9v8csCHj
 fJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478728; x=1694083528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1CYb36QZUIZDu4UGmBLcVUVYCmpeU0BzYEZkkE+tCKU=;
 b=M1mTUWZTq5Vq/MQSRKDbiOTF4eg3kIsN+5CsFnz1k2UHQmsutUajo4rNBG/F8e9hck
 Md28im/KXHMJD7b4Zc+8XsTArFTL4ARkcR18UikIdS+BPAwGcGeeDS3kV0O2SU4z5jUf
 SXDYowfywlENTgUPLqndwgiyHGqu3HzcRqsmX5ZOBSy1GkGeQ/hKP6jcHg7+XvsIA4RH
 5OSboZo138b3C0AdPc/NUjLtkQlCU2uno2WD+pbyPdgN0S50cdMxbMuPfb1EOg9zary0
 6X9L1nroPM/6XvNKj6OuVu+KCsvgVglqmeRfZCGDOVH07wSiH+maFRBlt/622uWdXH3P
 Ifgg==
X-Gm-Message-State: AOJu0YzbFKOwi7bKtZsfzxwHqHQnoIWY8RghUWYNOTvAy/kdtJGAiTEd
 NDur59sG10zMLSUfd2stKRmxcnFdhfdk2p3Qgbg=
X-Google-Smtp-Source: AGHT+IHxNNxm5cn2PoCaBlJzugEsHOVonXpQzyayfpeCwLwCeiVtmtXW2O3Eg0cmJp0AfUQl4/kLmA==
X-Received: by 2002:adf:e692:0:b0:319:7abf:d8e2 with SMTP id
 r18-20020adfe692000000b003197abfd8e2mr3892992wrm.24.1693478728686; 
 Thu, 31 Aug 2023 03:45:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/24] hw/rtc/twl92230: Use int64_t for sec_offset and alm_sec
Date: Thu, 31 Aug 2023 11:45:14 +0100
Message-Id: <20230831104519.3520658-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

In the twl92230 device, use int64_t for the two state fields
sec_offset and alm_sec, because we set these to values that
are either time_t or differences between two time_t values.

These fields aren't saved in vmstate anywhere, so we can
safely widen them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/rtc/twl92230.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rtc/twl92230.c b/hw/rtc/twl92230.c
index d8534dad949..64c61c3daeb 100644
--- a/hw/rtc/twl92230.c
+++ b/hw/rtc/twl92230.c
@@ -65,8 +65,8 @@ struct MenelausState {
         struct tm tm;
         struct tm new;
         struct tm alm;
-        int sec_offset;
-        int alm_sec;
+        int64_t sec_offset;
+        int64_t alm_sec;
         int next_comp;
     } rtc;
     uint16_t rtc_next_vmstate;
-- 
2.34.1


