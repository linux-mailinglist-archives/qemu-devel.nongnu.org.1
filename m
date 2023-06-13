Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4984F72E171
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:25:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90UF-0005DH-5V; Tue, 13 Jun 2023 05:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90UC-0005BE-I0
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:38:48 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90U9-0005Vn-BK
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:38:48 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-977cf86aae5so804699066b.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649118; x=1689241118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6qJ7BQ2qR0lwowzhuJJ58u1mhSulIi2t/OhI5+4Ytsc=;
 b=c9Izl1KHKJhcbr5C3nlKdHCh+00vRVp0dpdltvxdil5wL1EC+bTdpLZXT34iiG7VTO
 Uvlzoi0uqngg0nem7b3mMOWqpASbTsbm6wUeq3WLHRvn2G8FXpDmaGc6ZgQ3yH3mVxjK
 Ar72bu+DdY1Ijks+zrx2TfmhZBKBgjCsLAiJ6GSlzGRRNRSwPlnFwpctWOZ+Qh1Xir9F
 AwkL1b8mQXtHyiLBQ8aDHv2LP+g4LfxfvSXDfIbHDwjOfCtW+apq6D3HwTTvv9385+Qd
 ebdw0JyV21T7pSJFvlk15/7ZfJrxT7ILNkZrp3a2ABTrmXGLrvsy+Z8bzuPoYXRvGfv1
 HHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649118; x=1689241118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6qJ7BQ2qR0lwowzhuJJ58u1mhSulIi2t/OhI5+4Ytsc=;
 b=ffpZ5bYLuT5pEE33c0GpBlvDwVegmAs2N+u5N9YRWEgRf8At+obwsdPd7mZsIf+2af
 nu8piND6sOP5+bWaUGEzDM60g3JTGrTk2n321/thfktDL9vEqCVC5BcpyOX3yw5mV3e5
 JeBnc/NeZWQbh19/FyC/fqcWod48U3WIjo9LhvAfe7E1juIQz8eD5EhymH/RljjJH0RL
 v+dSrI5fmhEgnlHWiNneVK3wXXXO0N1cu163dyDOcO3Qc0nBOjQ2RGBYtCIZwgTOk2sF
 aGlQAs0sFwgEWZpDq/+g4Z9ACyKZ4eALIkHgk01/uIcxr5q4spH7hYpz1GnHsxuYvw70
 EOHA==
X-Gm-Message-State: AC+VfDx27P9i7BJRiJlyD0DZywRaCd/LFIf8o7Lttv3NhH48wh0zIhLo
 U/DQHpoZ/qvHQoAgqy6QrghairUSYZVThy4xZWkJQA==
X-Google-Smtp-Source: ACHHUZ7ACg252+NEXKV9vPDD6vTgIovV8Ek6/8nKU1vwwuV2jYxaaDIn49nPmUtteayEGNgZBlYneQ==
X-Received: by 2002:a17:907:9342:b0:973:91f7:508a with SMTP id
 bv2-20020a170907934200b0097391f7508amr10909380ejc.4.1686649117880; 
 Tue, 13 Jun 2023 02:38:37 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a1709062bcb00b00977eec7b7e8sm6395760ejg.68.2023.06.13.02.38.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 02:38:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/17] util/cacheflush: Use declarations from
 <OSCacheControl.h> on Darwin
Date: Tue, 13 Jun 2023 11:38:08 +0200
Message-Id: <20230613093822.63750-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613093822.63750-1-philmd@linaro.org>
References: <20230613093822.63750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

Per the cache(3) man page, sys_icache_invalidate() and
sys_dcache_flush() are declared in <libkern/OSCacheControl.h>.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230605175647.88395-2-philmd@linaro.org>
---
 util/cacheflush.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/cacheflush.c b/util/cacheflush.c
index 06c2333a60..de35616718 100644
--- a/util/cacheflush.c
+++ b/util/cacheflush.c
@@ -237,8 +237,8 @@ static void __attribute__((constructor)) init_cache_info(void)
 
 #ifdef CONFIG_DARWIN
 /* Apple does not expose CTR_EL0, so we must use system interfaces. */
-extern void sys_icache_invalidate(void *start, size_t len);
-extern void sys_dcache_flush(void *start, size_t len);
+#include <libkern/OSCacheControl.h>
+
 void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
     sys_dcache_flush((void *)rw, len);
-- 
2.38.1


