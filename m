Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 515C7736621
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:28:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWh8-0003qF-2d; Tue, 20 Jun 2023 04:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWh4-0003pF-Vq
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:31 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWh3-00069l-DC
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:30 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-514ab6cb529so10479467a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 01:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687249588; x=1689841588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/3Bvke1UQz1gaPdVgrmH/fOaEfEBws8JDDNhMEPrlw=;
 b=xd6yFQQiGNobpLO8F8OaHKTs2kNw3sJCAZA7yQ5nS8nKI859Wglc+rUJfoiuKzyB+p
 J5dTWkRxfq9gtfYGHMQrkYixFJjN/j/nPfzTsQ5yQmEKRH4wVtB8dZjvJc03TOjoLNBl
 OCWeH91t5fw1AypK8VQe/N3x66xJ7u0m/ifUB7GTULz7VECt8K/UowF+9YSbSTFQ0gaf
 eQwVCEohJNvmAq15hwXmKfheYHayvgjwJyrOZdsHSexuMntCNkSksAY8Oim7M3K7snwN
 YEeDuCeTsh+AchTfMaseL8Idq09ZecpVoJwaOBMC0oh2ZPKKuGcR4kDZlNQhrd+flS9N
 Rptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687249588; x=1689841588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/3Bvke1UQz1gaPdVgrmH/fOaEfEBws8JDDNhMEPrlw=;
 b=BPtMxB4lv95BbSmX8TlQP3X/3iAiqkVvoTSi5IjgWpBVEpoUPv6LTLlKYu478bVko/
 mtRT3EqNReLaUp60xiwGEnTNBoQUB22RUbYJPeUM0noNg2MzwBsKxe4Epng4HMt0aHKp
 xGyp/SnKUZ1io2Vl5dNRDt9Xq9F0UQVAAExmfkMpRVEKKBLKIu1Rer3f4xNtg0Aqh06n
 p+Rd8Kh4azo30BCOlUcRmSQ5np3GjiaV3j6z6jNsnsY9/I6/t45h8MzTEmDQ0FDH4n8q
 eyD7+i8gLhXWO2x5Y7aYjyI9OeBpjDFBj/3biy8uE3/rZ2QrzhtGJxdJEkXSJl6102ld
 N/Qw==
X-Gm-Message-State: AC+VfDzyQAi3JKwXIUnt2FY43c5g01+kGTG6fnyPsnNEosjaMucjltgT
 5veu3GfWjWHKa0Zz/WLfNN0eAS1X6pkDo9Ej/xZS6xmZ
X-Google-Smtp-Source: ACHHUZ7LgvmmJVKpw0l+QtLNFRfcuzdVsQ0BK56IX1qLMcDA04E+IOppLmxIQ0pxoLxcUrEzhuW+qA==
X-Received: by 2002:a17:906:58cd:b0:989:d9d:d90a with SMTP id
 e13-20020a17090658cd00b009890d9dd90amr2076364ejs.34.1687249588010; 
 Tue, 20 Jun 2023 01:26:28 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 z19-20020a170906669300b00977c7566ccbsm935901ejo.164.2023.06.20.01.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 01:26:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/16] plugins: Remove unused 'exec/helper-proto.h' header
Date: Tue, 20 Jun 2023 10:26:08 +0200
Message-Id: <20230620082611.770620-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620082611.770620-1-richard.henderson@linaro.org>
References: <20230620082611.770620-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x534.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230611085846.21415-2-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 plugins/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/plugins/core.c b/plugins/core.c
index 9912f2cfdb..3c4e26c7ed 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -25,7 +25,6 @@
 
 #include "exec/exec-all.h"
 #include "exec/tb-flush.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-op.h"
 #include "plugin.h"
-- 
2.34.1


