Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4867A7D3EC9
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:15:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzR4-0005as-8q; Mon, 23 Oct 2023 14:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzR0-0005aU-Mi
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:50 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQt-00088l-M4
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:49 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ba172c5f3dso2921250b3a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084822; x=1698689622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wgo3sS5iUyrU0Dzdzk24htDnmRxHdeX5tUMGq3kg/oc=;
 b=nuCWpYmXQ0Xa0byrZ6nhUREJCWoA3pbyLyP9W5uAVK8HcxTa4t5hE6NV8Ysqc4DHnB
 C0PkTisvoLSAnzAGq/37S8Q2hqcP3Dx7KRD+Y3y0OYfPbiJPwtode7n+cxTGYbctB9T0
 4O+cxC/EZVei6swC/b70WNXlAGao0lweicPcgi831S/pVOnFdXq0qvLwBk/08ZYiHZ37
 C4znF6mPRYErPeJoPNtPKuXDJZsOiORzLUX7kOQ1/K5/d7VC1WqGTF3HSs7+i4aqyUKj
 mWJ0ypPqQWYBsgMvqPmX0bLm6QWgm9IcSSEDORSjytBFx0CtMFYNd7kCfZFhlKhCow2s
 s7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084822; x=1698689622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgo3sS5iUyrU0Dzdzk24htDnmRxHdeX5tUMGq3kg/oc=;
 b=A0lZpWptNEkhESgx0LVGaKUM6/SuhmpGfIgrqy1AtWS/kovsqE55eMP43X5nXnXOWn
 r96AP2j4hLKd0PY29b4QuZFni2LVPlEmGXPDBxnrGa2Arbsfw6Y9xrRQj0j68vWsT9cB
 2ZFJzEQbc0mCyDrlnab4Ef/o5Ffco6TwIrc0ulG1CNsLZoe8wkmDhWJkXs+cZhNcI8jT
 GN4jPGy6f5cCQQ21e4ovkY+5hVwPGB48jsyt2Ozneq4Nt9wS4CQ68VSx6UhZ7LMYZN0/
 Y1A1n1ypTCNvOm0egLwoVapc/yNNNay6dlRKor530I806npHDk52uOBTy3WVQUnuAUmt
 0Xsg==
X-Gm-Message-State: AOJu0Yw6HELxzxNPpGZouuWFf2m9sOH1xc7LnPprJ8SBOt1512yO97d1
 S/RvOzeq37kE4vzwrnoYB34QohFYoRpZt6wurr4=
X-Google-Smtp-Source: AGHT+IEWpNd9jRsLUhRv5A52lO3DkfgBSjKRGVHFBErwxlbp16BsLRJM5KLvl+RNvejN+MdyP+AztA==
X-Received: by 2002:a05:6a00:1a09:b0:6be:2dce:cf5a with SMTP id
 g9-20020a056a001a0900b006be2dcecf5amr7563022pfv.26.1698084822051; 
 Mon, 23 Oct 2023 11:13:42 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 13/38] tcg/ppc: Disable TCG_REG_TB for Power9/Power10
Date: Mon, 23 Oct 2023 11:13:04 -0700
Message-Id: <20231023181329.171490-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

This appears to slightly improve performance on power9/10.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 6496f76e41..c31da4da9d 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -83,7 +83,7 @@
 #define TCG_VEC_TMP2    TCG_REG_V1
 
 #define TCG_REG_TB     TCG_REG_R31
-#define USE_REG_TB     (TCG_TARGET_REG_BITS == 64)
+#define USE_REG_TB     (TCG_TARGET_REG_BITS == 64 && !have_isa_3_00)
 
 /* Shorthand for size of a pointer.  Avoid promotion to unsigned.  */
 #define SZP  ((int)sizeof(void *))
-- 
2.34.1


