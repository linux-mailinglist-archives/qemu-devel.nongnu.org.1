Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE82D72E169
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:25:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90U9-00055Z-6Z; Tue, 13 Jun 2023 05:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90U5-00054a-PF
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:38:43 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90Tw-0005Uy-EB
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:38:41 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-977d4a1cf0eso757518966b.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649108; x=1689241108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sITmXYQVztiFV0Fz7LLqlyOlCvRo8CYW3jqFEkjFY7A=;
 b=T1InBtrB0winLJ23Quu7ivDlnmZDNGABI/CrerU2/H5RfXdeuvS6Nx0+hQTxqNfjQz
 cQ2G0PXKXegcXDvF0YlROhBqQ9Q4xwQ1JZhA5vKeqVXhE2kONcgc4ETXU8tE+zBr2JN2
 op5muaNnR+FhjhrqIaPSpA+QFkDHp5TC3amNwfBijCB2d4vxENCLB0SGM3TA2y6+BhOC
 t6Ce8ZiZbgnPAYcnVWMaPDuIj5ly7HfWQT0zBn8sMYue6grEbSVVWK9PQJVmxXgL0Zrw
 UiAwJsIQa8oarjA/ypaEQmUljTQXYJA08HdDHc8Ck40oxV9gkTXG3j0z4iKixnSQXLKT
 hLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649108; x=1689241108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sITmXYQVztiFV0Fz7LLqlyOlCvRo8CYW3jqFEkjFY7A=;
 b=TSHid7VS2UIwaSh21OWVIrjwv8kh19ffXTHto4dpGqZNx8GIVxrzgcABDM78oyhnw6
 agQ9cyjzrPRKhe8ib2ngudUGRMXqCErJaloly/ZhhPdlpKUerMI3OYWXy0X4GZMwixVZ
 lQLrZ5h590LIg4ohAFwO9tEordWssh73tWD25Vgj5IjbEdRR+7D2d9axImohaZ5xutz2
 5w5p1tTXjc4PbTLupRu8BFHr975rF6HUrkAh62RmnYxsghZn/T13hX5KPpgBdFr9Fih0
 9kITcOvG9sBrU4UrWHyyWJCBnXqlCKFNfON8ftdTUDfoe9dwNfBe7v1Cp+F0Wl73Hyfi
 pEaQ==
X-Gm-Message-State: AC+VfDxorRxbLFyo0BQELaQpAtWQPAmYMeC++Q+7NYux/i+uDUAdQMB7
 gDhuXvbxvO3Y/abn7YCd2A6Xx6hnwxUKbUmjLGjjQw==
X-Google-Smtp-Source: ACHHUZ5xxyqb0lQOG8wwaE5B4zqaD/CusWuONyls3BpkaLYvPGThkZTyQa/5y+e/tl/L6GPvXKKfiQ==
X-Received: by 2002:a17:907:9617:b0:974:1f03:fcd1 with SMTP id
 gb23-20020a170907961700b009741f03fcd1mr11708489ejc.3.1686649108675; 
 Tue, 13 Jun 2023 02:38:28 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 s24-20020a1709060c1800b00969f25b96basm6363606ejf.204.2023.06.13.02.38.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 02:38:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Andreas Schwab <schwab@suse.de>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/17] linux-user,
 bsd-user: Preserve incoming order of environment variables in the
 target
Date: Tue, 13 Jun 2023 11:38:06 +0200
Message-Id: <20230613093822.63750-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613093822.63750-1-philmd@linaro.org>
References: <20230613093822.63750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

From: Andreas Schwab <schwab@suse.de>

Do not reverse the order of environment variables in the target environ
array relative to the incoming environ order.  Some testsuites depend on a
specific order, even though it is not defined by any standard.

Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <mvmlejfsivd.fsf@suse.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 bsd-user/main.c   | 10 +++++++++-
 linux-user/main.c | 10 +++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index cd8b2a670f..b597328118 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -295,8 +295,16 @@ int main(int argc, char **argv)
 
     envlist = envlist_create();
 
-    /* add current environment into the list */
+    /*
+     * add current environment into the list
+     * envlist_setenv adds to the front of the list; to preserve environ
+     * order add from back to front
+     */
     for (wrk = environ; *wrk != NULL; wrk++) {
+        continue;
+    }
+    while (wrk != environ) {
+        wrk--;
         (void) envlist_setenv(envlist, *wrk);
     }
 
diff --git a/linux-user/main.c b/linux-user/main.c
index 5e6b2e1714..dba67ffa36 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -692,8 +692,16 @@ int main(int argc, char **argv, char **envp)
 
     envlist = envlist_create();
 
-    /* add current environment into the list */
+    /*
+     * add current environment into the list
+     * envlist_setenv adds to the front of the list; to preserve environ
+     * order add from back to front
+     */
     for (wrk = environ; *wrk != NULL; wrk++) {
+        continue;
+    }
+    while (wrk != environ) {
+        wrk--;
         (void) envlist_setenv(envlist, *wrk);
     }
 
-- 
2.38.1


