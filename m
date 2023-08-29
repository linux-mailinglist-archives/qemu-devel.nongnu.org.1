Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C18078D070
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:24:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb83y-0004dj-Dt; Tue, 29 Aug 2023 19:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb83t-0004A3-F0
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:23:53 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb83o-0001Om-C9
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:23:53 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68a42d06d02so3481421b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 16:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693351427; x=1693956227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1kQdNiCM9Zqst6RWSQxeqs+p1o22wGyR4sXs05ml1eo=;
 b=M1zBRhaFJLKf4SKXp8KDIBr9Mw2/K1tBixAa0tOmVz4poIzyXwIM+23+EfA7xlrpBY
 59VC1SEr62ngm4Rv9qrCdGA7W1yimBvRWrAUygQZU/JoFkWdV/EWeme1Go5q+buQ45in
 NnZau6GedSO61cWYed8LrjJLzujjqJ3aboXVWDXeB7G+u56qUb6OfBVGOjOd7WH59Bbz
 1NSNMl4EzIm3MbMOFfsN/9f2PCYbIf68nqg13bxKKoOyQrlqdhL6YD+thn2+pvExpIwp
 ov+TeuXd5DEvQfuZ+ZkkHsEvklMOMFxHDaBB2+RCatgswSHfIZ+IIE0q7trlBJYgZnpK
 VudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693351427; x=1693956227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1kQdNiCM9Zqst6RWSQxeqs+p1o22wGyR4sXs05ml1eo=;
 b=e9UZ1isCiUa7eDMVx0r5IrILbr17IIihZuq6tAgwFIZ+YuWkbzwEDfAo9pOL9Kz4pC
 REsoC8xbWPjHcLrHuAhPwIyBa4mK3ds4OHj3oldrLw7FUVfAXDEvv6e+3h1Zh+p4gZSE
 J6pHIUougkbIuI/CZp8gkHcYWPzti0b2TkCo7yaNCIu+R4ZUSSZjrOOxCXG5fZ/K0Z6Q
 a+7dX6rRqyxlH73ttEx2DZRjJaj9fTF7Ekd/jL72imflI0DccILwYBmCeSzbBeGH+QMB
 47PnOBJY0h5hb5ZjAKATvKkOpcpybLiZ2xtZRtOAsCvvvnjd6XjKeRcNsFRm9/Su0GWO
 eDUA==
X-Gm-Message-State: AOJu0YwIKpn7cap8BAB9ufBWWVNJ32XyAX27zB680SF4aTFzzhcyQ+sq
 +IKLFVGWkLq9PLgl5IxllUYvOSW9ce8tH2Gqqmc=
X-Google-Smtp-Source: AGHT+IGUQj3CwRk5PbS9IohWNK7e9cweW68RLWPA2NJPYlotAmZGotRsslxyCAj2Bj0hpyDPZ0kkeg==
X-Received: by 2002:a05:6a20:138b:b0:14e:3ac2:e10d with SMTP id
 hn11-20020a056a20138b00b0014e3ac2e10dmr627463pzc.47.1693351426989; 
 Tue, 29 Aug 2023 16:23:46 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 t9-20020a170902e84900b001b9dadf8bd2sm9829970plg.190.2023.08.29.16.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 16:23:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: aaron@os.amperecomputing.com, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 11/12] linux-user/aarch64: Fix normal SIGILL si_code
Date: Tue, 29 Aug 2023 16:23:34 -0700
Message-Id: <20230829232335.965414-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829232335.965414-1-richard.henderson@linaro.org>
References: <20230829232335.965414-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Most illegal instructions use ILL_ILLOPC.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/cpu_loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 2e2f7cf218..22c9789326 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -110,7 +110,7 @@ void cpu_loop(CPUARMState *env)
             /* just indicate that signals should be handled asap */
             break;
         case EXCP_UDEF:
-            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPN, env->pc);
+            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC, env->pc);
             break;
         case EXCP_PREFETCH_ABORT:
         case EXCP_DATA_ABORT:
-- 
2.34.1


