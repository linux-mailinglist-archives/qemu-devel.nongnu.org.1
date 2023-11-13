Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF267EA1E3
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:33:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ant-0001TB-E8; Mon, 13 Nov 2023 12:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2ano-0001SN-4p
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:48 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2anj-0000uz-1G
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:47 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc0e78ec92so28207495ad.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699896760; x=1700501560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ktCL4PpnmmSV22dLFMTmZEamP8gFRvTBZK+z2uNvKg=;
 b=SoGIBSiQoIoS/pc3uM3XvN4zdf7RnY1ETvlKNLN5QSEZq6oEbnh1QuU7uOM5b8LTEV
 eKklX6/9VmwRKAKbQHhLFqC93oBqA8i2iww9SQRk7BDMoNILADz0ZkFbXZ3hAT3oeEA2
 saCc3JWTalkXf5RCD5kj4InTiLwJ8dqO7El2RnKWDH7wyc6nEfmXUK4dWoGSyLz8Z0PO
 5XK/txz6FtwtOeLeD5iLo2KaWLEr5ejGN7MnO8YZ97MlJuIOA1qXoR6Sj9rLyIX0ArzM
 lWxNX6dgYgIXO092vpEUzPPlNBSqPXBzGJ5G5Skm8u6ewBnD8tMAJE8ZwdsxAzJaFjze
 84rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699896760; x=1700501560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ktCL4PpnmmSV22dLFMTmZEamP8gFRvTBZK+z2uNvKg=;
 b=xF5AfvF4MQojAexJH6J2SD1rPtXmC6EtUD0Pq0px+c9vGrk/eps+SGBGLSWATMRJOk
 FU+WSewl3tbCobNuOAlrM4WFj8IgsAcclUuYtUGC1IV90cL1SvZS1/NJ3pQqrwjhJEwq
 neUNsPqss43MbWerqG/2+xqEREGEfBZeCzKP50unTuiO8UWpHiYjPJkh4wC2lIw67V1s
 yHf45c2+BUKoJ4G8zOaGfoxkxUdkEc5Pw9SkHgKpgA5SFM+cHhKb3wVg583uBKb0mIPq
 Wza3PJJ6o4GGTNsN2MMYnuVuBiyqQiCy2+XBzCHByWR323uhSIS5lyKbfOXOHVh2Qn+E
 CuNQ==
X-Gm-Message-State: AOJu0YzoZf5WeqHgYnzggdKqoXXxvzfXQshzQ1y21plZqzBq3wceAfeT
 lucMu6VAY2B4hUwxeqp2Af7f4BM6uyQSOKM2k2k=
X-Google-Smtp-Source: AGHT+IG2TLkijwVCqpAWq9rUKB3tytE+K1Be2W1DdqIauiKGtcZv1CzYvS2UWSaZSvCpXb7ZkzvF9g==
X-Received: by 2002:a17:902:8f83:b0:1bd:ca80:6fe6 with SMTP id
 z3-20020a1709028f8300b001bdca806fe6mr168929plo.41.1699896760485; 
 Mon, 13 Nov 2023 09:32:40 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 e6-20020a170902d38600b001c731b62403sm4271910pld.218.2023.11.13.09.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:32:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/12] target/hppa: Use only low 2 immediate bits for PROBEI
Date: Mon, 13 Nov 2023 09:32:27 -0800
Message-Id: <20231113173237.48233-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113173237.48233-1-richard.henderson@linaro.org>
References: <20231113173237.48233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

During the conversion to decodetree, the 2-bit mask was lost.

Fixes: deee69a19fd ("target/hppa: Convert memory management insns")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index f3b17ba16d..bb1b65fef0 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2297,7 +2297,7 @@ static bool trans_probe(DisasContext *ctx, arg_probe *a)
     form_gva(ctx, &addr, &ofs, a->b, 0, 0, 0, a->sp, 0, false);
 
     if (a->imm) {
-        level = tcg_constant_i32(a->ri);
+        level = tcg_constant_i32(a->ri & 3);
     } else {
         level = tcg_temp_new_i32();
         tcg_gen_extrl_i64_i32(level, load_gpr(ctx, a->ri));
-- 
2.34.1


