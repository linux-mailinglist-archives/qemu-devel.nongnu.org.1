Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAF97DA675
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 12:35:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwgdN-0006LF-PK; Sat, 28 Oct 2023 06:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgdI-0006JJ-3l
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:32 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgd7-0003AT-3q
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:31 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-408382da7f0so21510025e9.0
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 03:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698489199; x=1699093999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LNGgzff5IUOW67edmSf6WpHil0/J68PsVdXi1+Q8NU=;
 b=cAhvlHv8/XGGz5FAR1Wy+U57JoGYYtFB00dBvgdbNY1WV3E+gLJmDBho08JW2Gbo3M
 JP6CrwBzMTp53ZEYNZAC3JPB5Lfsl/YXGeWntumMHVvq0DJq5imyk6ADctCpsn0UGyPJ
 GE+AewbVxrRo/Bkjypud80JD1DQst+s7HG1cWOE6wQu78rnhP0uRY7dT7tAYKo5gxKIS
 B6NeISMIaFE++iDNErGaDn4FZ50nKRya+OXWjF+fj7iYffJWYaj+JSomSoEWVKbzVaxG
 EM8gqD8QRF6SNFXj83EUVNae00rdCnxO5J9tjAVDXxEq7DQaldiUQesGW7hgTQ2j4BzY
 gTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698489199; x=1699093999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6LNGgzff5IUOW67edmSf6WpHil0/J68PsVdXi1+Q8NU=;
 b=A8QOtEfuUzEIOYq+ZCR4hIR3ThumFfSVqcgcb791nKLhKqCxhGTpVsqQiQKeXP4bwj
 KoaBl5MAHeXk9XgDb61MY9fie+REce1MjQe/clrbJ/3atEDeyApfBsEsKSmaPYFGtjHn
 HTRjhb+MoW/pdRP5juFSNnR8xGGKh4to+v0tkhHsW6gYTEnd0YWO+3TEFN3cVtCrM81z
 Rpx0RqimG+bA6N8g7EwivMCK84XzOOCHJEVbBfsw/BfGn07Kv/1fr62+wI8fcrFAh0kT
 SjvV29q+sI3kj8heowucpfSWXxq5gGnRL/Ko7URe0F+dXgia5HE0nti2QgCGio4vxo7l
 XS5g==
X-Gm-Message-State: AOJu0Yz7klUzG0Nwv6aNAd1MB5F4JZpPqavzGJPXMpWbH3rwfiqzwyUp
 ZAYJGwYgTha8VcXGBJge77dWxQ==
X-Google-Smtp-Source: AGHT+IEdTjOK7YMdz53T3gNzElKCRm+kFK6/aW3jjyCvApr7PUWxuXqXNqCv5QlXYPDzW0+Gl01kuA==
X-Received: by 2002:a05:600c:1c23:b0:402:f501:447c with SMTP id
 j35-20020a05600c1c2300b00402f501447cmr4295481wms.0.1698489199592; 
 Sat, 28 Oct 2023 03:33:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 iv8-20020a05600c548800b003fefaf299b6sm3769631wmb.38.2023.10.28.03.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 03:33:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 799495F7A4;
 Sat, 28 Oct 2023 11:33:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alexandre Iooss <erdnaxe@crans.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Subject: [PATCH 15/17] semihosting: fix memleak at semihosting_arg_fallback
Date: Sat, 28 Oct 2023 11:33:09 +0100
Message-Id: <20231028103311.347104-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231028103311.347104-1-alex.bennee@linaro.org>
References: <20231028103311.347104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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


