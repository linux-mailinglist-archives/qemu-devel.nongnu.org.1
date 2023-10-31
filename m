Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C7E7DCF8D
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:46:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpyf-0004tS-VS; Tue, 31 Oct 2023 10:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyd-0004sN-Cc
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:19 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyb-0002Cx-O7
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:19 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32f8441dfb5so1691756f8f.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763456; x=1699368256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qbOhazxvRm+dj6LmIpa3iG/xAEISl7lgrvcn9urKP4=;
 b=MKJItzplfXKlre/AAi14zwIUHJWWfDYieklHmTVLk7TEGgU74llGPnGsr7dYAtHkV8
 v0SK+6hPB8MHVAhbTQtMtU5xO3cAEn9+V+pE0+oNjN2zSq+CHjQ3TqOuJG8r3+0MgpKQ
 ARiDRETpFqApPgXeBSmaZ0DxES1m0BYn18qp7KK6uZbAVG+SIieN6iObvmlNJZ0rJTWF
 6LqX6ITudMRrNuE+bI4HSHr+6HMSdUk3jXt/+ZbH7CGT0f10R1oTu+ahrel0Wj450upM
 NRiJqWW+BcuEX57ycKYWpYhJsuIrzYL2eYze1ujheAZPlWa/dZMA+qEUxMxWDnOozust
 yRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763456; x=1699368256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1qbOhazxvRm+dj6LmIpa3iG/xAEISl7lgrvcn9urKP4=;
 b=nx95+v17e4fga53EUKRS7Mwlz2ElmGvHT7hTvE2Mn+oZBVWNOydPgBjpAuntYUHUbe
 RQFMLOGKgJrZPVl1WxnGH7xv6HAvfKPHatXE6+TfY+tvuJdE04jP68RbU0Si3Yj7OuTG
 MHgnHO5831vm00deUR6DIa7zD5SM98H/Uk5N6KsCvR1Fg9Iy4XN9jXwNkMNp4xrkQx1r
 UdGnRc3c+2ppjWK2g/q1RHu9gYIY5uX7JLkjYCbzLWzSKnyANSn59axZ4Dw9pEV5xHXM
 qsjAvQKjTSamiS7SU6DdAGYAqxRdM1o7Olz1qo9W5SsXhE3paLNI+fVNTESHXm41EKwS
 Bmpw==
X-Gm-Message-State: AOJu0Yy+Qmm6aIZzgUnyQrBFtZkzDaUGvcVVFK2fwQv9HX75/3dBUTEt
 niQ8/QPRLOsWPTsRzxtIWbw1dQ==
X-Google-Smtp-Source: AGHT+IFW4FFqehSm9FBQmkD/9dWL84YgQFsfKzWa5wvsDzLdWtyAuVZj3wQW4Op4QotXnB/hRk9dZg==
X-Received: by 2002:a05:6000:2a9:b0:32f:7cea:2ea2 with SMTP id
 l9-20020a05600002a900b0032f7cea2ea2mr9626642wry.17.1698763456291; 
 Tue, 31 Oct 2023 07:44:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g9-20020adffc89000000b0032da8fb0d05sm1649917wrr.110.2023.10.31.07.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:44:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 68AFC65730;
 Tue, 31 Oct 2023 14:44:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 17/19] semihosting: fix memleak at semihosting_arg_fallback
Date: Tue, 31 Oct 2023 14:43:59 +0000
Message-Id: <20231031144401.1238210-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031144401.1238210-1-alex.bennee@linaro.org>
References: <20231031144401.1238210-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>

We duplicate "cmd" as strtok may modify its argument, but we forgot
to free it later. Furthermore, add_semihosting_arg doesn't take
responsibility for this memory either (it strdup's the argument).

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <03d81c56bfc3d08224e4106efca5949d8894cfa5.1697801632.git.quic_mathbern@quicinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231029145033.592566-18-alex.bennee@linaro.org>

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


