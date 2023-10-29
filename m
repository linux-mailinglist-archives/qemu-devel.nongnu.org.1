Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B57D37DACE0
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 15:53:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx77s-0007bS-Ec; Sun, 29 Oct 2023 10:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77p-0007Yb-Po
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:49 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77j-00058d-VX
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:49 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4083f61312eso28756635e9.3
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 07:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698591042; x=1699195842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L7mkLliNPzNXB/MT8B2nzmAQfKs62ilya+P57Y1l0Y4=;
 b=X63nzoope1lqBtmKUIradv/fto8GCmQHWr3Ft6jvfemAcJMyFjmQqhvExSQpOwt5W6
 n+529jkrpNLU/mRi28AKIvP+Ck5AQepnb4Ct2/u3FE3HXZ2ePXkbsnPHWz6BmPN8M5nw
 +VJO4Y6GAdsHatgwvzY43IV/FBjBsIXs7QMxUSUuSKs7JjCI2GOJSXgmiDBJFOrhvwAe
 UyIia5V99fn9yMNuiAoa8zY04iBcxqcddrOwqmL8VMhA6pLTYldaK14F9hisaLKZuWPd
 reezKRy5nf5VTpulgOIn8W1WkArm5lnTIarozSi8+ZJBC2Szs3/fe5MZCaH4GMLL/JBa
 6Omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698591042; x=1699195842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L7mkLliNPzNXB/MT8B2nzmAQfKs62ilya+P57Y1l0Y4=;
 b=L1zVfmq/fLww+4Ljm9o/DXKZcr2kQ6/CNJZXgD5NqO2gX15de8sRBnzOk7NDWpbaf1
 6hvS01o7ZmwcVGG+uFjkRs2CTfn4sJRjwXKzIkHwUAXM+cqaH+NN15/JdCL5Y9/3lL4k
 cdmxpV/CYQ3htUApB+VQKDytIDMelwhJTZr4vIVRrhHNGxw7y0I6iLavswFoU53UjZsg
 DQUOdwHHjKGlQXGqxqpBz49HLVKnaM9ePSiAe2m0dANkmc1mO3rU+wNkRlr6HueoJ5iM
 bVgLHKlW3XAfFyo6dA9yM3wXdgtizPNwnWLoo1AsNHMBGvXxG+2VCDZda5+rlW2+3Nq2
 SlYg==
X-Gm-Message-State: AOJu0YxIIKZ8V+It3S12t2bxYDMdAd0a5l1Npw2Yh+R0qtdFDzVXpuXF
 ttiJwc1xlG5bGAsHyvN7dmosmA==
X-Google-Smtp-Source: AGHT+IE33yHYPLNXFtROCifo+mrCmgJ7jsRKmHLIHKjrAnBGcZqGA63eoSdLhz/YNZrIfx9BfBUlAQ==
X-Received: by 2002:a5d:6851:0:b0:321:4c58:7722 with SMTP id
 o17-20020a5d6851000000b003214c587722mr6759021wrw.69.1698591042147; 
 Sun, 29 Oct 2023 07:50:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 w7-20020a5d6807000000b0032008f99216sm6044787wru.96.2023.10.29.07.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:50:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B100865709;
 Sun, 29 Oct 2023 14:50:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Brad Smith <brad@comstyle.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Kyle Evans <kevans@freebsd.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Brian Cain <bcain@quicinc.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Subject: [PATCH v2 17/19] semihosting: fix memleak at semihosting_arg_fallback
Date: Sun, 29 Oct 2023 14:50:31 +0000
Message-Id: <20231029145033.592566-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231029145033.592566-1-alex.bennee@linaro.org>
References: <20231029145033.592566-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>

We duplicate "cmd" as strtok may modify its argument, but we forgot
to free it later. Furthermore, add_semihosting_arg doesn't take
responsibility for this memory either (it strdup's the argument).

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <03d81c56bfc3d08224e4106efca5949d8894cfa5.1697801632.git.quic_mathbern@quicinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231028103311.347104-16-alex.bennee@linaro.org>
---
 semihosting/config.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/semihosting/config.c b/semihosting/config.c
index 249a377ae8..56283b5c3c 100644
--- a/semihosting/config.c
+++ b/semihosting/config.c
@@ -113,12 +113,13 @@ static int add_semihosting_arg(void *opaque,
 void semihosting_arg_fallback(const char *file, const char *cmd)
 {
     char *cmd_token;
+    g_autofree char *cmd_dup = g_strdup(cmd);
 
     /* argv[0] */
     add_semihosting_arg(&semihosting, "arg", file, NULL);
 
     /* split -append and initialize argv[1..n] */
-    cmd_token = strtok(g_strdup(cmd), " ");
+    cmd_token = strtok(cmd_dup, " ");
     while (cmd_token) {
         add_semihosting_arg(&semihosting, "arg", cmd_token, NULL);
         cmd_token = strtok(NULL, " ");
-- 
2.39.2


