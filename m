Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 079068272B3
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:15:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrKK-0004GK-VE; Mon, 08 Jan 2024 10:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKI-0004Er-6f
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:06 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKF-0001aY-8Y
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:05 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33765009941so1594206f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704726839; x=1705331639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9MwYzVVCpi8aRF113OyWJJfAJmZSssygUp+Otb9ZUM=;
 b=YXS7hglEEUflE7sy6TJB7AtaVu2eupXd7DiMSywJV2moysIrqrvHckOprwfa7L8SJ7
 3EcyMV4vgF5yHHUZktmzLdds510bu+1rDNf3Q3eCTzBpoJ9j7YAtMbRf8ILF6ZIQEtYk
 qiwvTX19Z/UGlO7XCE5DFw9dCWqomh/NgWQa0JUT7pV8lZAIPCqs2t/Qae2QTMxOQDra
 1GSCsoXtzye5ZVnPzMytHzVQhXkxtnOgS1o4i79RDPBUYm1CUVdoFQqvhVNrhZGEkdw7
 KjD5Zr5uZu56+rTS7pJ1DF7O0lFb/OZm3acH8SRI4m+OtcTQz/Oi5L0O/BCITNYFvQ1B
 /dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704726839; x=1705331639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k9MwYzVVCpi8aRF113OyWJJfAJmZSssygUp+Otb9ZUM=;
 b=UkQ2WhWz8PogixZjfW//rWUjI+GMGDmUiWQtqYITie8Giw/4H3+KiFEqKKYwyfb/T6
 +VIcSR6p1NQUhf0BQRQuvnXU1i4aTM9KR0RqCdEywurJqmr0NKXUUe8/wyRybonBNR0/
 g86kpi6+T9IPDF2EShNQYLtX14+Vjll205N8MTnu3RtETjQpCNgE6k6rreGI/9UAq1YF
 rzBrGpx0GpoetIsVhBJFAFh/nL9x/AyflAMvAtdbZtJ2D2Kg/YSoHiSIrhjFK6yrRTrp
 q9+P/wNKbqJJgQlyA4+sQ2I80mH1W1B1c3EFeygtR2mo/GRKZHJUf3nPRhS2/3gkCw7q
 GVaQ==
X-Gm-Message-State: AOJu0Yx0h2dxZ7L+uYiAH4fuwCG1zU+94t/vYFTihyKcvBXlPlPXcutH
 QEegspdGCXen7lDfyXAqK3bdrHFu//fE4w==
X-Google-Smtp-Source: AGHT+IHKmX/FvThUqBxxDftDSSU17HQvFVl1DOmlQDWNwgVN7Hhuoz5OdoCV9/0PuE8QaZ4P/pmu5g==
X-Received: by 2002:a05:6000:1204:b0:337:5ba9:3435 with SMTP id
 e4-20020a056000120400b003375ba93435mr2090385wrx.124.1704726839640; 
 Mon, 08 Jan 2024 07:13:59 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h13-20020a5d6e0d000000b0033677a4e0d6sm8039039wrz.13.2024.01.08.07.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 07:13:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B75D85F94E;
 Mon,  8 Jan 2024 15:13:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 10/13] replay/replay-char: use report_sync_error
Date: Mon,  8 Jan 2024 15:13:49 +0000
Message-Id: <20240108151352.2199097-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108151352.2199097-1-alex.bennee@linaro.org>
References: <20240108151352.2199097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

Now we have a centralised report function use it for missing character
events.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231211091346.14616-11-alex.bennee@linaro.org>

diff --git a/replay/replay-char.c b/replay/replay-char.c
index a31aded032e..72b1f832dde 100644
--- a/replay/replay-char.c
+++ b/replay/replay-char.c
@@ -113,8 +113,7 @@ void replay_char_write_event_load(int *res, int *offset)
         *offset = replay_get_dword();
         replay_finish_event();
     } else {
-        error_report("Missing character write event in the replay log");
-        exit(1);
+        replay_sync_error("Missing character write event in the replay log");
     }
 }
 
@@ -135,8 +134,7 @@ int replay_char_read_all_load(uint8_t *buf)
         replay_finish_event();
         return res;
     } else {
-        error_report("Missing character read all event in the replay log");
-        exit(1);
+        replay_sync_error("Missing character read all event in the replay log");
     }
 }
 
-- 
2.39.2


