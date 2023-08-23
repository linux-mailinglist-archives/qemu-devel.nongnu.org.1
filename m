Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 858BC784FF1
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 07:19:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYgEE-0004vO-Kv; Wed, 23 Aug 2023 01:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgEC-0004uW-5e
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:24 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgE9-0000sG-Pf
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:23 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bc5acc627dso34761985ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 22:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692767780; x=1693372580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQp++5N0yIEsVmUaGN89LifNvR6oAeooLY4sPs12hmU=;
 b=ltXosM/H8ad61vXFbAD+0NcohOg/gTFW/5O0IP0cXoANWU/vtXX6QjH5h3J1NduAPr
 GBa0ktqUus+wsLggxbcxoIDa45tgsbOs2AAv34W9U3S01SVMkIHIovwhFfuYuAprn5qt
 vNHb24wXKrzJfYou9ApF8DXwxISteViyzhOH/+tWWLlyPutTmTMPtc/nZ43R5xsQ7s45
 zwIw8FEUltYKUpYOlk4Ese8KfAGVb2wWtfkqKTG9vZrYbTlqHpflUHVDdPIMLEvom2ze
 eCVUzSOt7FwvfXK/CpV8iJqzfc2rBNEgOAz0PEuQ1N+9mi/56kZEfTVHDaTm3B61OHV9
 ZuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692767780; x=1693372580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQp++5N0yIEsVmUaGN89LifNvR6oAeooLY4sPs12hmU=;
 b=X6XUNzKJl9/MzFOeIrElrsvmDIRfpLnB28m554habJdvTky6zUZ/5SVmdzHcTu5tOU
 985Sb8Ql28FGQd3Yo86FPDQf4eegJ9GNtQhpJgZbnBeceZR27lri+rqrud4ayEeNBT6d
 khbl5Oo0HCt0/m2WefxbX7GucIsPA01jV7BJ4jEhmD7ugpqSxQTukWekvYQIL4+fUVfC
 XuuUS+47A5O17RqCCDKZa3IYmx56pfQZELF3DK5PHi/y5VmGewPiMhoutevryy+Xb1tk
 Jvxa0Y9itVdn7ujtPWlz90+/wOZ0hx+fn+StXj6Y2T+Vb1/mMHn14+eIOQtILk4NTIdx
 exMA==
X-Gm-Message-State: AOJu0YyUWzW8M/79Md6RrT7rQ5nrClLTRUTLet1Ro+h2x1sMv6irEsHq
 z+Ol6yOB5QXv+WM8o8fIKqyZ12I2zXSFqssdW1U=
X-Google-Smtp-Source: AGHT+IFTauG1nrGMroiXLHi/W89epAXW+ZYWGK7S7nRr9sZOu+s/jInsyJsJpH2ZZKiFeBU3PcVmMA==
X-Received: by 2002:a17:902:d345:b0:1bb:1e69:28be with SMTP id
 l5-20020a170902d34500b001bb1e6928bemr8482759plk.42.1692767780473; 
 Tue, 22 Aug 2023 22:16:20 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 5-20020a170902c24500b001bf044dc1a6sm9969402plg.39.2023.08.22.22.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 22:16:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v4 02/10] linux-user: Exit not abort in die_with_backtrace
Date: Tue, 22 Aug 2023 22:16:07 -0700
Message-Id: <20230823051615.1297706-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823051615.1297706-1-richard.henderson@linaro.org>
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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


