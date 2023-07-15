Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE66754905
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:58:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfj1-0004Wq-SC; Sat, 15 Jul 2023 09:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiX-00047o-QE
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:51 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiR-0001JA-PL
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:48 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4fb7589b187so4758393e87.1
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429221; x=1692021221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZraICE1rSSuyJwFU+r8vOCOFS1v3NI7u5DpDqpVSLj4=;
 b=HYaI6atZuOFWX/lNaR6czwKdnlIwNyXfftQGPYPTeXRgBrO+uCJoalpekxMHGszfqd
 4kRTOmZssF4JQALW+Io1TFHfV0JMaI+r+/nW0KmOnACvnS4zPzSBJQJhaGPdv8RroUcp
 4CH/jZZ4M0bot94PE98thNMfJ4YnHXhSKanfIp/0oQ55lWhgQ+btCaMAd0I1PunaEzsk
 nNINaAQVJpmzFE178OFg7mu1qgbQHijHui+ney+PbiLeFeejdU83k6h4V5+GAl31zxa1
 lVQwPTOaivdJJdyq8/f0BrVwRxC6ExI0zE23UhIMLU7MqEBR4YFvlYp+JgiEDv9TTaOR
 TsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429221; x=1692021221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZraICE1rSSuyJwFU+r8vOCOFS1v3NI7u5DpDqpVSLj4=;
 b=DTWlpSSYnb69HakhUW2TKj4zuvy8u6jQjnLzXQV2mcsWdJKg/CeYpd0Ke5U8ulGju6
 CuPkCPAKcIN/V4yRFxv0wm48ZW1KJUhcpt394DVgi96WUNP1VreRKs+juQJ+azvKb2J3
 Yrir3MjZX/BXjMR7dkG19C+CgwN0ADiewJ52KbNPo1vqGVdR/BxyrnSI3zaCAzsaYRdu
 Y4ZEQF9/LFG8taWX03eL/0BHDmMhBGdf65jAdtCoCDN/fl3g+GWtgn3mM1rWYN7owyF6
 M/H0zI54chk/sKmeUMJz2Tmma5zHG6bUsS/K78Mdwq+OEUpnv7N72IuLUvwH/mSya1CW
 lcCQ==
X-Gm-Message-State: ABy/qLYfeOmvf4l2xGi6fSa5BgIncto0JpQFOrq8AbYzgAPr5E3qFD3k
 foLs+nS8Dl6IMpl4RdpLgXndfFaRX6orrneapwRRTg==
X-Google-Smtp-Source: APBJJlGBOjmPIoPOF7PolnDREFTMqnFdMNLEcCKlgf8NNd8CoSnT2/9TzzZEzyw5QrIYGd6lrTtZow==
X-Received: by 2002:a05:6512:45a:b0:4f8:5696:6bbc with SMTP id
 y26-20020a056512045a00b004f856966bbcmr4467263lfk.29.1689429221141; 
 Sat, 15 Jul 2023 06:53:41 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
	Kyle Evans <kevans@freebsd.org>
Subject: [PULL 27/47] bsd-user: Use page_check_range_empty for MAP_EXCL
Date: Sat, 15 Jul 2023 14:52:57 +0100
Message-Id: <20230715135317.7219-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12b.google.com
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


