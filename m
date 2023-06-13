Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4918472E19E
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:27:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90UL-0005Qf-Qz; Tue, 13 Jun 2023 05:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90UJ-0005Og-Hb
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:38:55 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90U9-0005Vp-2h
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:38:55 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-514953b3aa6so7407178a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649122; x=1689241122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/rEEeIVSi5VMBmvRHFJo6Mhl1pwYu3f8je5JbYKc4lc=;
 b=vN8cYI9jW0YpIeMjga+hw/yspaOnkJJfHu2IbDcuLLQtMDFx3jl6Syn8fBWGVuKxVM
 G0Hsqd4Tc/DXPG8zhL9zc6BNwSbcJWTYXtJBToG2wMhvhUeyFKZoVle8Vm0hXPgwSB/8
 AGQ8KUJRYIYwavVUl8WwunJiFg1nQAo3/J2M3Vs29ZjTefE1aRgY6AweC6vvgIGCWXBj
 LJZF8KERLQVUKw7yubREO3UuSkZwZ+tzB7nZ+idEmlt6NfUgiypkGvOeZ3YNParqBBT5
 lShk8QUE6R6ebYIn04xHEkHqeem5iQ+TVfQ/hDrPlH4XDyCfTn6ETnM7pQdje/VdmB1p
 k1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649122; x=1689241122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/rEEeIVSi5VMBmvRHFJo6Mhl1pwYu3f8je5JbYKc4lc=;
 b=RwHDrWLT4zQLX5Weq6ijMcVmp1SMdX4XZAJrVCPkbo+bF2SVPL2GVAPhLEClEq3vz4
 5a/MKurlZT+NUU56SR4EHgM5C3j+aB70fUdyBM1CgkRR89Uo9Ac0sT9EBgXfx+R5KQ2h
 HEcsM5EbpoRrlDfqqq6qT/0vlN2NtB6gUBqKmTEzsLhgYb+kBp9GEem11kqHBa7ogMj4
 EAH7r/DPXEjJBouZ9aAPEO0a/Nn8UZWBLPh31QIqwz7JOiihFB3r3CnX/QHaSwi0SDPm
 /Rpa1FSi5duZTFTtdeNUXLvSiNFo/cL1tuyn0aLLjxOCeJBGqI6gCumEn8FQA1NFqpQi
 stJA==
X-Gm-Message-State: AC+VfDzR+vVnWRCI50I+Y5uVN/NrlDq9xn3/hypk9EF/Fpnx6G9UX2iv
 qPUdMrmRWcijcVdeNvapo+5R+PuZKINeRyseXTp4fA==
X-Google-Smtp-Source: ACHHUZ6FkGRCnzDRIUsvgZjL7NfqolRlYfGKjrAYx+1qQxWGnu3tRT17ObwrDOODHJ824HEXI3ZwtQ==
X-Received: by 2002:a05:6402:70b:b0:504:b177:3ef3 with SMTP id
 w11-20020a056402070b00b00504b1773ef3mr6738675edx.3.1686649122229; 
 Tue, 13 Jun 2023 02:38:42 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 u11-20020aa7d0cb000000b00514a97b6b80sm6185031edo.78.2023.06.13.02.38.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 02:38:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 04/17] util/cacheflush: Avoid possible redundant dcache flush
 on Darwin
Date: Tue, 13 Jun 2023 11:38:09 +0200
Message-Id: <20230613093822.63750-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613093822.63750-1-philmd@linaro.org>
References: <20230613093822.63750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

<libkern/OSCacheControl.h> describes sys_icache_invalidate() as
"equivalent to sys_cache_control(kCacheFunctionPrepareForExecution)",
having kCacheFunctionPrepareForExecution defined as:

  /* Prepare memory for execution.  This should be called
   * after writing machine instructions to memory, before
   * executing them.  It syncs the dcache and icache. [...]
   */

Since the dcache is also sync'd, we can avoid the sys_dcache_flush()
call when both rx/rw pointers are equal.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230605195911.96033-1-philmd@linaro.org>
---
 util/cacheflush.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/util/cacheflush.c b/util/cacheflush.c
index de35616718..a08906155a 100644
--- a/util/cacheflush.c
+++ b/util/cacheflush.c
@@ -241,7 +241,14 @@ static void __attribute__((constructor)) init_cache_info(void)
 
 void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
-    sys_dcache_flush((void *)rw, len);
+    if (rx == rw) {
+        /*
+         * sys_icache_invalidate() syncs the dcache and icache,
+         * so no need to call sys_dcache_flush().
+         */
+    } else {
+        sys_dcache_flush((void *)rw, len);
+    }
     sys_icache_invalidate((void *)rx, len);
 }
 #else
-- 
2.38.1


