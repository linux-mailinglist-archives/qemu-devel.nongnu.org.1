Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8F474C715
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:33:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAe-0008QF-NU; Sun, 09 Jul 2023 14:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAb-0008Nk-Cy
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:05 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAZ-0000Kn-1G
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:04 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbf7fbe722so43506305e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927400; x=1691519400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWNck64Rdzbsq9/3XcWJpVmBPzEh5+xH4mb3RyYLiec=;
 b=w0YSN3NvRCkvWqSIxhuUQxkgN+rpwfsbNf3p4icrfUwbdqRYIDIJqTcGGaLO45t5Er
 b/Mlfi9Dn34MLo2ogXBCA0gJsP7n+MiFNWIjRzE4EUT8o0Rsr3VjhEPBs4sa3lBOGj6h
 kCuc8aLxeygxIF2PJSr1wPy10rt5k8FKHVhR5eX8VtdXUYrXi5SWEHHxjDORAEmDxEr+
 E++f7XENSD+iAL8Ld4Dv/QGgCg/zSX3GP9iozBEyqUc0wn12FfWwKEO1xJ9XNurmzxhd
 w6874jpMlQyTlfxCQNNICYb9KG4nUNak71xNcRo38lVeaPPjCXAhyJAN0OPNrw5lzmsH
 Q38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927400; x=1691519400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWNck64Rdzbsq9/3XcWJpVmBPzEh5+xH4mb3RyYLiec=;
 b=IDD190NMRP1ftY7qHui7dYewKfm+5nWF1ggdvE1t1tesFYv8CTtJyquOefy/faQBhV
 QThyVcf/XerodgcbRvAEPH7r+Q3fQrk/X1hLUd5/vfGfXP+0hE6Io6ux1g2VOMXjU5F3
 bjXbYCC3DcMG1gJ6vpeRWwcTUBf8kUkO4KwcU4ejfrcG/fTsKs2oB2NnwNw70k4YoMha
 slSUUix0S9H81v2R+ZQbpNHc2llfSCA99GvXv0MRvwouUDGDiWgOl7oLsQm0w/Ltrvbm
 XXzAPHKTwm7AusZEmwBH5ag269XvovuPQMDiJQCyFdVtwx/OpRDOzi11Dc33Ti2nLmgD
 UpdQ==
X-Gm-Message-State: ABy/qLax7aaEFTUlWj4LilPcaqwB9nlJNjm5yV9gWYhJ15D51bFi1pew
 +nRxtjAAnmsUxSjvY6aMSb3rqy7MS3FRJM7EFwpSLw==
X-Google-Smtp-Source: APBJJlFyRnXxgviMMZ4zs5/ejbhMMA2qEgmO6TzGHblCfSKxoDzcm4yZR8Pz2Q6Mb5Iz5bmsMbWZcQ==
X-Received: by 2002:a1c:e908:0:b0:3fa:97ad:2b9f with SMTP id
 q8-20020a1ce908000000b003fa97ad2b9fmr13757282wmc.16.1688927400809; 
 Sun, 09 Jul 2023 11:30:00 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:30:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 15/45] include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for
 nios2
Date: Sun,  9 Jul 2023 19:28:41 +0100
Message-Id: <20230709182934.309468-30-richard.henderson@linaro.org>
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

Based on gcc's nios2.h setting BIGGEST_ALIGNMENT to 32 bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/user/abitypes.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
index beba0a48c7..6191ce9f74 100644
--- a/include/exec/user/abitypes.h
+++ b/include/exec/user/abitypes.h
@@ -17,7 +17,8 @@
 
 #if (defined(TARGET_I386) && !defined(TARGET_X86_64)) \
     || defined(TARGET_SH4) \
-    || defined(TARGET_MICROBLAZE)
+    || defined(TARGET_MICROBLAZE) \
+    || defined(TARGET_NIOS2)
 #define ABI_LLONG_ALIGNMENT 4
 #endif
 
-- 
2.34.1


