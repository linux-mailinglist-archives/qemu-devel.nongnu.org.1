Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 779507B71AC
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 21:22:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkxK-0004xs-Gs; Tue, 03 Oct 2023 15:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkwk-0004r6-Gx
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:20:42 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkwT-0004dU-RS
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:20:42 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c62d61dc96so9651395ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 12:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696360815; x=1696965615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H1WLp4iET98k15VXyaSQDw2efQeM3lo5zs7sjnpm5FA=;
 b=bSvjW6Tvwxksg7jvbD2IvrfMHyKJ/dpjCHxFIbF+MfxncUSjpxlDMlhMNNFVfxKPVE
 iTrhGQoZj13DCyiss0v7FzkQ2eLDkZMkIHXAni0imbU47bYheit9LbFzlhM5OdkiY1oN
 2Cs0wde6D9rfVv7WZr13+8/SUUx8FYlcDb2gZehTsLO+3A3sa7AatyqVP/UXJi8EWIzS
 guIfJ4W3WanTRnHsaJnxlj6kZ5bcZcXuSLe4tsw46Zlji9XQSvamNY6l0Og+bxaSUxni
 xaZtfKUT2iKKGiO1R3hGWcS+SZwxcPC5Yq/OnlMa6VHPTU7IZsn7F3PdldFyryY+soWM
 11Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696360815; x=1696965615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H1WLp4iET98k15VXyaSQDw2efQeM3lo5zs7sjnpm5FA=;
 b=BUKpo4ske9G/h/c6i60UAiP9TblHTwiX4YEfofY8XUlgIzq3OC6LDoxzDrhoONKMeN
 z+TWoqV9OT5EV57higVogQVHgsL8ye2+uZRznzirixthk3TYTI9G4NbbmswBMlk3FRqO
 7zbtclzqIaDZZOMxS6ufZM9abR5L12Q8tNJJ91NfLGL2VhraGV2hSwj8h8gawq2TJQGc
 m70AJKJYQv2BaAvjsceMj7hbY9on4UyzrV0y2z05WrDOuhhy/m84DUR4yo7gBdhEU03A
 asl3UMYHCAjfQ1sxk8E/Fp02wQb0ux2MqXpYse9AU78MfLMH5EqhBLYmIwdtuO70Jtz2
 7S+g==
X-Gm-Message-State: AOJu0Ywn7sDsFKOLOoV/GtWi6/X4G0GAvfcv/ths1qeeITkXwdUkM0dd
 dXiwTizmUvXjQHKtpPlKDONfaADPl4rxV7ysGNw=
X-Google-Smtp-Source: AGHT+IENiLJkzQBCXJDUnc6zOlESU126TTYR0iWxJzJKMLju25UfN1DOLpBPXt4Y6utRPJ4oaHLnAg==
X-Received: by 2002:a17:902:7207:b0:1bd:ca80:6fe6 with SMTP id
 ba7-20020a170902720700b001bdca806fe6mr470637plb.41.1696360815299; 
 Tue, 03 Oct 2023 12:20:15 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w5-20020a170902d3c500b001c5fd2a28d3sm1978497plb.28.2023.10.03.12.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 12:20:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 2/9] linux-user: Exit not abort in die_with_backtrace
Date: Tue,  3 Oct 2023 12:20:05 -0700
Message-Id: <20231003192012.1674888-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003192012.1674888-1-richard.henderson@linaro.org>
References: <20231003192012.1674888-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This line is supposed to be unreachable, but if we're going to
have it at all, SIGABRT via abort() is subject to the same signal
peril that created this function in the first place.

We can _exit immediately without peril.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index b7a2c47837..84a56b76cc 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -713,7 +713,7 @@ void die_with_signal(int host_sig)
     sigsuspend(&act.sa_mask);
 
     /* unreachable */
-    abort();
+    _exit(EXIT_FAILURE);
 }
 
 static G_NORETURN
-- 
2.34.1


