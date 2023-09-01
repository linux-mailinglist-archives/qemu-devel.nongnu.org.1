Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E2378F708
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:25:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtpi-000808-5p; Thu, 31 Aug 2023 22:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpZ-0007B5-Mv
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:17 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpJ-0001TK-Vk
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:13 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68a56401b9aso1248220b3a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535039; x=1694139839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UM3G3JW9WxcLT5Dzb3w4vT9giwKkE+uVqc4Wz3d/fxQ=;
 b=FzDh7kdFcl+ICqiOH8saF6XwJwMc1DcChe0vxWHjxEx8s0Xu1OaH+DnNrWMw0je2zD
 K8ho8r9LXLBPDrP4yW9aj9Hnrs4+qKz1CDeSlqrwPGqfROKC0CQVc1tbgCylJ0hBZS0Z
 rNazWYATamlcc1Cfo/A29qR7s+mCtqWmQM6/JRBh1xcCSt3QVvgl96knfAHtVQM+FBGb
 7cNFbE3oMSgrAZ2E8ZX4mDJkeU0PyS5MjKsoJtRQsGPt4XherlwDfUumqFgyfHVCR1Lu
 OuNURzgqUJOM1ripkxTug2KwiVZL2dQJHB/TFsY3WuHj2C8Zyt4ZmKnRGja6XOK+BQiE
 RPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535039; x=1694139839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UM3G3JW9WxcLT5Dzb3w4vT9giwKkE+uVqc4Wz3d/fxQ=;
 b=NXUurHzwqoZ4r3SYpem0jjV0MWNyGiZToKEnUk1mwRcCfcfvBpE81nYfRFkEktmEVq
 3zNEZ3OS0yug+4mFP9A+tGHmgKAbGq5s0QotYm2o8dQPiVEE4AB97QaOsqNkdw0QXUIT
 UWDG3UcTVXSsQnynOmWLpXdcNPzPvb4d5TLJHFTYhlP9sMZSY4swoiXk1hD1xUIeKkQy
 LDwkRMnXepy+KKCzBMcsoNnRztns08tw2GiCNfjvKC9JRky9CfRM0mbkFRD+2McZL/nI
 c7GxdoHGVXQUluKLJMbDnh2C6KdStkxYQvNes1djINnzTqrxb93CFtvws33FHfKNznSm
 7xEA==
X-Gm-Message-State: AOJu0YxnsRfccGFdfoMfL3Aex2OP995+VBHCqU+7BUbAA3o7ZM0L1Cva
 iLrnmdM29CzktBtX2tMjZvFIuAX6PUcvN1qtA3A=
X-Google-Smtp-Source: AGHT+IFeWhEix0PiAx8keqXc00mLa/nUIYMptZ0Rc/yTpfngUDY+40qjoCdatFu/e6QLGnsflL2/wA==
X-Received: by 2002:a05:6a20:157:b0:12f:c61e:7cac with SMTP id
 23-20020a056a20015700b0012fc61e7cacmr1470526pzs.31.1693535039263; 
 Thu, 31 Aug 2023 19:23:59 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 33/33] target/alpha: Enable TARGET_PAGE_BITS_VARY for
 user-only
Date: Thu, 31 Aug 2023 19:23:31 -0700
Message-Id: <20230901022331.115247-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Since alpha binaries are generally built for multiple
page sizes, it is trivial to allow the page size to vary.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu-param.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index 68c46f7998..c969cb016b 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -9,10 +9,22 @@
 #define ALPHA_CPU_PARAM_H
 
 #define TARGET_LONG_BITS 64
-#define TARGET_PAGE_BITS 13
 
 /* ??? EV4 has 34 phys addr bits, EV5 has 40, EV6 has 44.  */
 #define TARGET_PHYS_ADDR_SPACE_BITS  44
-#define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
+
+#ifdef CONFIG_USER_ONLY
+/*
+ * Allow user-only to vary page size.  Real hardware allows only 8k and 64k,
+ * but since any variance means guests cannot assume a fixed value, allow
+ * a 4k minimum to match x86 host, which can minimize emulation issues.
+ */
+# define TARGET_PAGE_BITS_VARY
+# define TARGET_PAGE_BITS_MIN 12
+# define TARGET_VIRT_ADDR_SPACE_BITS  63
+#else
+# define TARGET_PAGE_BITS 13
+# define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
+#endif
 
 #endif
-- 
2.34.1


