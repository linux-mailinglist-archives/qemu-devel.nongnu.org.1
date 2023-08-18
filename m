Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 941F47814E0
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 23:44:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7FX-0007Y6-VP; Fri, 18 Aug 2023 17:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7FM-0007Xy-I1
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 17:43:08 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7FK-0004Rz-78
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 17:43:08 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bdf98a6086so11624005ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 14:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692394976; x=1692999776;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tf9Jzo6/6lt0bMLI+m86t2rXgiczmZf9K4SenvBJf6A=;
 b=dPNPzo3/sGSPgNxdHgM50skhTAd7/sFnejnLhntAUvbDsekzYZ/Al8/+ocJ6FM1otl
 Suoq0FEr+8sKYb5PAgamt85pLGayv/oIfIvTJ3wZyyPcj6sQ4KOHblW3vATl6pJm2kKk
 tH21NM/XBpzr48fadFg271HEQpHXgRK4fGHnED4wXTKXBw1ODF4WckDJ/sMHeKBu7TA3
 2D5nEf6ZZ6UtBkdPTz9rb/TfB0V2YmwgvIzitMQzB10QQs6YSZgPCuyVaZi2otWKgqLx
 wi0MxFDQgdNriuvKpJxK2XD1Hg6l3uT7cUPKBIGM2CGSNO4EeNL48OGbCAtqbNaroO+K
 NABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692394976; x=1692999776;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tf9Jzo6/6lt0bMLI+m86t2rXgiczmZf9K4SenvBJf6A=;
 b=faqQNM6nVRaTnbiPiQPv0NOkPQlZNasursp6WmXiQuApCoe8tkkCvwItA8BZ8Bnyv/
 Iq5wkNr4ies3mUWg244x8VFJSBoFNIdQCv6bREGzKLcVXAuDHcWpqtHFlvpzmnmWXJTJ
 vksxU+BfyapkiNNvNR29UnB+KSm7G8mQJHkmmhornf9VOBXrnvQXEFLqeOcdR3o3a8y7
 Km8LIIN+pYVV0EGjpB/wnlrIsrKUCZnX1AstGM2Itw0f+iBi+ALLaqxcBVVVPsBSPAip
 nmSZzMwbOhrV+Em2LSegnjI+CJfVWqIz0jvNk5tDGhoCc2pSWFzFdnpzNEtBqVRAEW9m
 m47w==
X-Gm-Message-State: AOJu0YypK/NdQgXHS0mgqHGe7SMhQPLZnMFeWjfHzFnuRN6K5EUFycHw
 Qgom69fzh0SkL0s3/cvMY/uuEVmMAhR4AbrqFog=
X-Google-Smtp-Source: AGHT+IGb/L9in9SzvIzk9SAdgLPJpvWKatE9oZBcCH9j2T/sNLow1P+m6EH4zVC+6TM24TUbUUzU/A==
X-Received: by 2002:a17:902:ced1:b0:1b8:33d4:77f8 with SMTP id
 d17-20020a170902ced100b001b833d477f8mr550351plg.23.1692394976353; 
 Fri, 18 Aug 2023 14:42:56 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 g19-20020a170902869300b001b896d0eb3dsm2209856plo.8.2023.08.18.14.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 14:42:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH] target/arm: Fix SME ST1Q
Date: Fri, 18 Aug 2023 14:42:55 -0700
Message-Id: <20230818214255.146905-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

A typo, noted in the bug report, resulting in an
incorrect write offset.

Cc: qemu-stable@nongnu.org
Fixes: 7390e0e9ab8 ("target/arm: Implement SME LD1, ST1")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1833
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sme_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 1e67fcac30..296826ffe6 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -379,7 +379,7 @@ static inline void HNAME##_host(void *za, intptr_t off, void *host)         \
 {                                                                           \
     uint64_t *ptr = za + off;                                               \
     HOST(host, ptr[BE]);                                                    \
-    HOST(host + 1, ptr[!BE]);                                               \
+    HOST(host + 8, ptr[!BE]);                                               \
 }                                                                           \
 static inline void VNAME##_v_host(void *za, intptr_t off, void *host)       \
 {                                                                           \
-- 
2.34.1


