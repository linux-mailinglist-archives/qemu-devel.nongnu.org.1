Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 168D276BFAE
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQxL7-0004Xr-LA; Tue, 01 Aug 2023 17:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxL0-0004Ed-6Y
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:55:30 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxKx-00056T-I0
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:55:29 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbea14700bso57927105e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690926926; x=1691531726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+MlPVeFzrXbSa0qfelXJkLgucjf8rAzsUaPyUQvx+Ws=;
 b=KlfSg670yEjxG8mRW+WVGKKKUXv5xDpMVNh93zWanLzzqpMqOj+KvhiCP2YLRzWZY5
 SelbwR0bZ7llcPu4owyWQT7PvrC5k0WlrF6uvwkIRSkXLBXhYK2Cuao6Dj3VVZ75MPjU
 a+hIu5k3ISsx35pzuTDWwpRT3GWMXQnOqwO3Yss2c94t8AMZNhxD9R39ayxMRyJ9HMHO
 6xGqqAqk7eQSaHfh7fTuCYu2iN0G8+XrlCZr8jWwGQ/E27iWhOjPHG/r48k4jaiT5mL8
 zaz0l8LLnZjEzCRwLUoaHyzfSQpKNDMdhmXM6CzwgAQuHO58/uvCoHl6m+QTZmHwsIXX
 wm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690926926; x=1691531726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+MlPVeFzrXbSa0qfelXJkLgucjf8rAzsUaPyUQvx+Ws=;
 b=Sm+zAGB/kWW5mfCoOGNSDncEglTacUWBe55UvPZKDDp2YqiCDqTf44+fac6aamPGfK
 z1FWXRzwG4t/niqHwt6Qf38wxuZ9UC1u5Y3bEjsV+sLNjRzNTtUH5PYXGHLblBtGjzIE
 wpbQ4hUBHOEG53NjZFJuqIenr5X4X07wAG4J6ipaMvkWGzygUNsjemAD1Jyy96ebnCRe
 zgEKMpimK00D+rUZ6hnuAXfOgEy2gP38JF3Ge8Ln0IHYA9Y0FC3IC643MIF/aYaV3KgO
 7BATmC0EpXUzH9MtrZLShSuzCqKKwNKV6gV8FF7wW3qLG1wguY873EebdO13JmoG6XyW
 ++lA==
X-Gm-Message-State: ABy/qLZNeJPb74xxK3X+j2y9MCS2k+vMHwjl1iLhtCzS3UPl4V4V4tsO
 j/MVqhR8B+W5BvlAzS/xRoE6BcdM1EYLCc4vjUo=
X-Google-Smtp-Source: APBJJlFhlnf/2gu234+6XPXBiMGZFshq2MgjTw2bRCZk9ZFeq4/ZClyy5KZy3Ivzs9JA479VnT8CKA==
X-Received: by 2002:a05:600c:ac6:b0:3fb:d1db:5454 with SMTP id
 c6-20020a05600c0ac600b003fbd1db5454mr3360777wmr.35.1690926925992; 
 Tue, 01 Aug 2023 14:55:25 -0700 (PDT)
Received: from localhost.localdomain ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 7-20020a05600c22c700b003fe1a96845bsm33446wmg.2.2023.08.01.14.55.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Aug 2023 14:55:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/10] target/m68k: Fix semihost lseek offset computation
Date: Tue,  1 Aug 2023 23:54:21 +0200
Message-Id: <20230801215421.60133-11-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230801215421.60133-1-philmd@linaro.org>
References: <20230801215421.60133-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

The arguments for deposit64 are (value, start, length, fieldval); this
appears to have thought they were (value, fieldval, start,
length). Reorder the parameters to match the actual function.

Cc: qemu-stable@nongnu.org
Fixes: 950272506d ("target/m68k: Use semihosting/syscalls.h")
Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230801154519.3505531-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/m68k-semi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index 88ad9ba814..239f6e44e9 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -166,7 +166,7 @@ void do_m68k_semihosting(CPUM68KState *env, int nr)
         GET_ARG64(2);
         GET_ARG64(3);
         semihost_sys_lseek(cs, m68k_semi_u64_cb, arg0,
-                           deposit64(arg2, arg1, 32, 32), arg3);
+                           deposit64(arg2, 32, 32, arg1), arg3);
         break;
 
     case HOSTED_RENAME:
-- 
2.38.1


