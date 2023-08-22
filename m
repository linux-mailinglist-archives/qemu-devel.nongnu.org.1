Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D345784B81
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 22:35:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYY52-0002dk-VK; Tue, 22 Aug 2023 16:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYY50-0002c8-HG
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 16:34:22 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYY4x-0005EH-Pm
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 16:34:22 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68a42d06d02so1933384b3a.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 13:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692736458; x=1693341258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQp++5N0yIEsVmUaGN89LifNvR6oAeooLY4sPs12hmU=;
 b=yVWdYHiN0iMeyApJ2LM+nQ5ob8Nt3TpoIIJkbrHw43x5aXzcKBB21Shw4GowNq5Jif
 6i1gTv13B5vbH0ZUrgiF3L2TZYm6o93cku8O81OKdk26C8P/n3PEOx2EpMQCKSRxlhgb
 SEH6IRb8GfAx0bxkZn0GeKkac8u7vRk9kUx1ntXdNQ+mepfPTO2dz4oN3BdizwO3vbKO
 VEFGgKkbOAeWO7MCqhfdx32ucsltKN91vdBK29GgRlZAxQMeOVyaGqRprCAyMY/K1sYx
 fLDAfF92JszHFh2n6F72lXU/Lh6vYLM+NNu7Otanxuuc41n5sb8BuZxWvcqB+vTAUno4
 KdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692736458; x=1693341258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQp++5N0yIEsVmUaGN89LifNvR6oAeooLY4sPs12hmU=;
 b=SINlxV/N8rid9kN3qS9GSIsDwNSxqlRGaj7Cs0+UHswH9TTJ8zS76Z/gfZAzvvvXrs
 62ae+6+EOsx/anqC27+WSo1mOGG+QmxB7K06XcH+9acSbvu3/29xXgjbF0RAEg+qJylG
 JBrfFYZrQTlbBVBDAJ6PZUgPkWcWO6aMFTXh0BPWN1GDevJuTqeOS2fW99nRmgsgTuzf
 Lq83pg86aD8tJa7o6Wf1cN2MIzxPFvLmvjhzIj9DsVsSSyUCEnJZCxuFXpvIwCg27tsC
 JpfMUmUq7HGOMygk6OrXzcvftQucAyuo/ncVRcT19qI5C8DpuoaHvkwmh05xRgPA2ToE
 YxqQ==
X-Gm-Message-State: AOJu0Yw5bhEaklGCUuEcsdDF1G0h63svHvSSC3R/aKLwsAFJdFsYGB9z
 AmLT8FFE4poM6fTOnPyXCWLNUOc+jYYovd2ElR8=
X-Google-Smtp-Source: AGHT+IGhuNqrNjV8ArTwUbqS20Djdin7FgFsC22hOZrUk7/Qcs4B7AzuBPSrc8JhydcMZ2g+XDQEbg==
X-Received: by 2002:a05:6a20:dc94:b0:140:4563:2243 with SMTP id
 ky20-20020a056a20dc9400b0014045632243mr7025205pzb.50.1692736458230; 
 Tue, 22 Aug 2023 13:34:18 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 i25-20020a633c59000000b00564aee22f33sm8311823pgn.14.2023.08.22.13.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 13:34:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 2/3] linux-user: Exit not abort in die_with_backtrace
Date: Tue, 22 Aug 2023 13:34:14 -0700
Message-Id: <20230822203415.1184491-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822203415.1184491-1-richard.henderson@linaro.org>
References: <20230822203415.1184491-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

This line is supposed to be unreachable, but if we're going to
have it at all, SIGABRT via abort() is subject to the same signal
peril that created this function in the first place.

We can _exit immediately without peril.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index e1cd111a1b..57fbf2f58b 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -718,7 +718,7 @@ void die_with_signal(int sig)
     sigsuspend(&act.sa_mask);
 
     /* unreachable */
-    abort();
+    _exit(EXIT_FAILURE);
 }
 
 static G_NORETURN
-- 
2.34.1


