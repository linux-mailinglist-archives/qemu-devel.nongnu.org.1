Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2531872313C
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:25:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GgM-0007OS-Db; Mon, 05 Jun 2023 16:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfv-0006uK-0d
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:35 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfr-0005lS-7W
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:32 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1b04949e5baso46261595ad.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996370; x=1688588370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=06J6sEoIXDqd7QsL1obTrgiIStslrSK/3y4osdeVahY=;
 b=xd3xISj0aNwjMnyhWZ2hinG2d9Zal3hHG5huaK3v6lK0fBA+8TJUsknYKROGC6NKMZ
 XIUG5h0msNVdmyzXi0Zzm7vexME4ClJhZtGsH+ISUugvaTELDuaPKTV0aU0yY/VgdQK8
 0MHgdq+/syoryxSOHIsTVlj/uGoIFtQ6HZESoUt6Vk+WBIGViloDcBEN/mEVfG5xUl+I
 YepyqWSGYHs1WM8KWdWVcnWrp2T7ZLmjPNKZwr/vav0ZOd1hDF+VYCNl1HWg7J7TIyLc
 scNaJFVlVS0bU85xps5DKNu9TDaRKAjsbroFNO5cZ0dEOxDjWbI8vVm94s+KzCFuFAa/
 t6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996370; x=1688588370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=06J6sEoIXDqd7QsL1obTrgiIStslrSK/3y4osdeVahY=;
 b=BjtghECWPR5zqQ0ekuvb7ujC3BW0svInNOsWQi7GghEqhmOos0M0E/5nQGAcSjf83t
 dr6tHx8zuXfCpOT6LcET7VNSSg5/8/2v0fq1d9NtNWht78f5ZI3OGwqEzWtL/rbyN0xQ
 INioatBNUCuPERFbQxOgOQK/8ZU+0DVKrTdznJ/QBYcdW+KbfBXyVi3YwoNynWF30qJ9
 2sWIEYicqGsEY7Aiu+PErNpBMM/i64+Ib60J2oiobI/5mmlx9OeT2Zm0SnaACRmrD3xE
 h16K3Qqoyv8yZZBfCtHJg5Qe4EOaoi0zqoDvabYt9anOxPANzQE5AH8e+IAifM+cvhX6
 xnSw==
X-Gm-Message-State: AC+VfDx1GGIHF87SAnjpDRB7wjGVW1U7gAFficZ5/8QBYDwx/0CXwm/R
 WQUqbD5V1l7zourKDnOwlQYMsWta9fw5m9ayuGc=
X-Google-Smtp-Source: ACHHUZ6YjlUxptD6Z5JHASk3xMnajwcRXHh7+iNGl6L2zdtY9YjDSCKml4FDCRRywSabodOptclD6Q==
X-Received: by 2002:a17:903:1208:b0:1ae:6135:a050 with SMTP id
 l8-20020a170903120800b001ae6135a050mr51703plh.19.1685996370028; 
 Mon, 05 Jun 2023 13:19:30 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 w20-20020a170902c79400b001a980a23802sm7018184pla.111.2023.06.05.13.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:19:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 46/52] tcg: Remove target-specific headers from tcg.[ch]
Date: Mon,  5 Jun 2023 13:15:42 -0700
Message-Id: <20230605201548.1596865-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

This finally paves the way for tcg/ to be built once per mode.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h      | 1 -
 accel/tcg/plugin-gen.c | 1 +
 tcg/region.c           | 2 +-
 tcg/tcg-op.c           | 2 +-
 tcg/tcg.c              | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 635fa53fdb..a498f31967 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -25,7 +25,6 @@
 #ifndef TCG_H
 #define TCG_H
 
-#include "cpu.h"
 #include "exec/memop.h"
 #include "exec/memopidx.h"
 #include "qemu/bitops.h"
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 3e528f191d..5c13615112 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -43,6 +43,7 @@
  * CPU's index into a TCG temp, since the first callback did it already.
  */
 #include "qemu/osdep.h"
+#include "cpu.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-temp-internal.h"
 #include "tcg/tcg-op.h"
diff --git a/tcg/region.c b/tcg/region.c
index f8410ba5db..2b28ed3556 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -30,8 +30,8 @@
 #include "qemu/cacheinfo.h"
 #include "qemu/qtree.h"
 #include "qapi/error.h"
-#include "exec/exec-all.h"
 #include "tcg/tcg.h"
+#include "exec/translation-block.h"
 #include "tcg-internal.h"
 
 
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8c1ad49c4e..c07de5d9f8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -23,10 +23,10 @@
  */
 
 #include "qemu/osdep.h"
-#include "exec/exec-all.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-temp-internal.h"
 #include "tcg/tcg-op-common.h"
+#include "exec/translation-block.h"
 #include "exec/plugin-gen.h"
 #include "tcg-internal.h"
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 41186f540f..3fcd0d9f32 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -34,7 +34,7 @@
 #include "qemu/cacheflush.h"
 #include "qemu/cacheinfo.h"
 #include "qemu/timer.h"
-#include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "exec/tlb-common.h"
 #include "tcg/tcg-op-common.h"
 
-- 
2.34.1


