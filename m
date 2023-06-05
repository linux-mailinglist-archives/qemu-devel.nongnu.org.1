Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C79CE722E0E
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 19:58:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ERx-00062i-BD; Mon, 05 Jun 2023 13:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6ERv-00061H-8m
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:56:59 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6ERt-0001UC-OH
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:56:59 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f61530506aso52256205e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685987816; x=1688579816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+Iw/1QCn4gWIQqU6bYdv/xs2QcFa6+Ox3iNu9xY0wY=;
 b=EYcvUE2qaOy/LJ5rv8Urz0q81DiVWO+ZCG4mfAsG95HaBAnrbWenxPtDjy421pFkRo
 27f7ipDxYr8e2f6rNqtbF5YSmF66Fm2lVlebDOw06K2j+cOWnDoE5hdg4WzjRRrXhI47
 S8SBXi/uWg9wWLzjWm4n6Eo/JH92d4sO0uDEXQUSQW7EDCE63uNo7q13gApCwVLSTSZG
 qNCv/GkBmXISWj3QUYegi1FGe42B8lUQbj0NEzMfbeeCxp5ZwkRy8Mhyp34mMoqeL4bY
 rOpEuHmt2CpwAu1BYYl1DUh9a1fdsFJ8GMZzAKpYmax8NzbUa/rkGPms94ZbV8ni7Hrr
 WfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685987816; x=1688579816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p+Iw/1QCn4gWIQqU6bYdv/xs2QcFa6+Ox3iNu9xY0wY=;
 b=DySXHrd16UZo7hWNtytZWfZm0xyhQ/XhNhhMzycgVOGnEzZG+LNE473qDKoIkyrekh
 HN/LXqyDI6vDEkXwyvmGQqOX2I1aovq58UF7W2vmEni2S2RmCjRYMVljqzJFrdv8WDhe
 neY0SKne0WjovugBG5qEwkq6DE1niQeAkksC8Eu5lwZ2y1XQnHA5ypPtesbWCgCOu2/N
 HFtKDs9LVUzEsl9m6o09svVVDHG+TD6MbMPLq3vHF/yyTOeko9dIxjmXRUHIVVF5WRw6
 BY1UexqMDKOvdebFCNlIaPHPI2eT86Gg3vM6gmHMPWXdiYcBJ9qnhPZyEQpw6v78LoO6
 OlpA==
X-Gm-Message-State: AC+VfDxqs9RFdnr3mSoqQkvGBXAxu8qEgOla8U6Gu47tlQo5Aihs+1/Q
 A49GaoO9fDL4y9pP7otxDTsbNoMD+YkFSwRlnpI=
X-Google-Smtp-Source: ACHHUZ4DQLDh99srxt42yIT7bcewLluBuX9/HJDZXHSntRFLVuwAmKvO+KD4DdKv4iRXooC6rL+RdA==
X-Received: by 2002:a1c:f711:0:b0:3f6:53a:6665 with SMTP id
 v17-20020a1cf711000000b003f6053a6665mr8873070wmh.19.1685987816071; 
 Mon, 05 Jun 2023 10:56:56 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 q25-20020a7bce99000000b003f182a10106sm11524598wmj.8.2023.06.05.10.56.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Jun 2023 10:56:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/5] util/cacheflush: Use declarations from
 <OSCacheControl.h> on Darwin
Date: Mon,  5 Jun 2023 19:56:43 +0200
Message-Id: <20230605175647.88395-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230605175647.88395-1-philmd@linaro.org>
References: <20230605175647.88395-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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


