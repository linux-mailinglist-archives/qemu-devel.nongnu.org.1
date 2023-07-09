Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A968A74C731
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:37:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEG-0005Nl-41; Sun, 09 Jul 2023 14:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDp-0003Ru-8j
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDn-0004DR-L8
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:24 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbc6ab5ff5so39279625e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927602; x=1691519602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZraICE1rSSuyJwFU+r8vOCOFS1v3NI7u5DpDqpVSLj4=;
 b=RpCPrxDPWDuIDYJcsr0IynwmWGxTCXXvAqP6bOQs6IcfErSvvPixiPsTgTKDOrycm7
 huQCrrfYVoqZv/P8R9DqjTPMFkdf/OUj6NCAMXbZ3JMlI8hSsFuzLpr36fWIAU2cX1XG
 OoIQ6UN5KAK44oqFQpqE1Ma4SoMDJcD/mylZ1XjxNSkR5MSkbHRLSMkSfdeha4lggbVM
 bCwm8rMtgsR6+WdwqGqLkyutawiwn7YmH2IgXeaZQA3FmqZRm6tGLWMjnQ+wZF+VFmRb
 HXlIqvWMC+e5K4BWyW0ltwbU9yjVmoXYp3PKNsYdtYbYo8WHO26zj5Hip5MOCZnN18sG
 dBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927602; x=1691519602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZraICE1rSSuyJwFU+r8vOCOFS1v3NI7u5DpDqpVSLj4=;
 b=FFO9E/NYd1M5q9Da2RCVeNwweYasbKMlBdpiYHTp9ELmllIEncCS3jBGBDXA9rd7M0
 0OG4FtgwSyfDtLIykdbSl/z4w56HuTsEB+Ycq4vgZ++1Mz3j/UgsgO6eqPtAw9rv05Oj
 QhM1/gM4rsMKHTLq0/ffmhQDmG3j8tyVwu0Wgv5DR10/uc8QI7G+apxVAPbMt7At18KJ
 +p9L+oZ5g0jtIZOi7zm85yS0e6nUYJx451wclNpYvo9UkF1dXLD8OVHHwfgiqA3nFMtl
 8nuP5U6sBb3dQSBl1r/Jzc7x4lPRURoziPBSSXvBSIRi93YeWVWGA/CJ3qItGUsdqbim
 /yMw==
X-Gm-Message-State: ABy/qLZUnknHF72QJdgYL25ndCOHvyVq04HDepuRYXGD/xAirG7Vu7mC
 sQfk3jgf8VWLfX0ekZv3zC+wiWhupDPtjGGTufGPEQ==
X-Google-Smtp-Source: APBJJlFuvB0ptxMjgmW9WBpaZGYBg+xxAcuHty8gwN4plwVM8VlzjivVxeVJD/W38KFkcEUl13Azaw==
X-Received: by 2002:a1c:7318:0:b0:3fb:b61f:c719 with SMTP id
 d24-20020a1c7318000000b003fbb61fc719mr9062778wmb.33.1688927602411; 
 Sun, 09 Jul 2023 11:33:22 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>
Subject: [PATCH 27/45] bsd-user: Use page_check_range_empty for MAP_EXCL
Date: Sun,  9 Jul 2023 19:29:05 +0100
Message-Id: <20230709182934.309468-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

The previous check returned -1 when any page within
[start, start+len) is unmapped, not when all are unmapped.

Cc: Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230707204054.8792-11-richard.henderson@linaro.org>
---
 bsd-user/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 565b9f97ed..07b5b8055e 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -609,7 +609,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
         }
 
         /* Reject the mapping if any page within the range is mapped */
-        if ((flags & MAP_EXCL) && page_check_range(start, len, 0) < 0) {
+        if ((flags & MAP_EXCL) && !page_check_range_empty(start, end - 1)) {
             errno = EINVAL;
             goto fail;
         }
-- 
2.34.1


