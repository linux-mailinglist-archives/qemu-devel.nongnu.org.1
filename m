Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE967D3BE7
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:12:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxVX-0001eT-7h; Mon, 23 Oct 2023 12:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quxVV-0001YE-HB
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:10:21 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quxVT-0001jv-RA
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:10:21 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c5056059e0so52852331fa.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698077417; x=1698682217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4jeYU2eBThHCBIgCveuE9hS0ohpcPJOThHJUYhTifyQ=;
 b=uQCCgTyPu082B/ZR6WJiUayNIuOSkqAGp1TpfMcI4yzoyXldu+yPt0zWj9+6qymAPV
 cyUfP2iJDe/+CDHfC4OrKHaQPHy/PWkE+5eKo53+gjuCirWpjh9UyabnrLyWzC4a8Icc
 EOJKapnfbgiSxgyZfkInpBbQrl9YpuQqE35C+TT5OYyiTgSZkH/wkpwy8w3GkcngAmqH
 6d+9chaaXnwO1bJdjneTGVe+45bunSvW/BQwTgVF/tKSL+kdMfQcvyxS+znFFoacN664
 +Ez27pIkZLCADi3FZYhUgRIIwEAYB9C3z+9Xqix0GZoRrVTBUuGfuWy/ivxpvWzsZD5H
 FysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698077417; x=1698682217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4jeYU2eBThHCBIgCveuE9hS0ohpcPJOThHJUYhTifyQ=;
 b=PKLDhxHp4Dfm5bNBtUJ/UTOwWDiRlgMJPBy1K1+KKPg/Hc+kXqa0Taf+4oBmtoiBKB
 QpH5udKR+zVRIFjq21b5ktexLOS95D6uwwGOoqSud0BPuH70WC9mTOilZzpEdMfXHe+G
 Euf7V58/t0l8m4/7wXiTGOOSsfWUjwV0EF7Z5schb+YMDfCZ7hK5lwUoVIT8r9+73a2h
 zOP/gBirxAlGnrZ3yKooD2RDY7sScPbiOtKxryrGU5bR5rot9TsrpJ9gRLSW7CIXinrN
 icE+3PlAcvwd5SDYDVcLAPL4XbBXTkL2491YKCGTEY7/ZtCGU7I8Skr9jNro4P2d2kZK
 zENQ==
X-Gm-Message-State: AOJu0YyMeGMNdL0/HfVGG0byEbVFPwtkYkcxuEMs8E/gEJM3pHqAB35e
 bHeU05YhGoURp4IO2iLvwIlaoB6jdEv4Kb0K6SQ=
X-Google-Smtp-Source: AGHT+IHTQb9CnFmYtgxKPXea72YtdKkB7VhzOlJNLjzWsDYo6RbMUbr4l2YiwMQ/dskHLIAkjyz5/Q==
X-Received: by 2002:a2e:9396:0:b0:2bc:d634:2210 with SMTP id
 g22-20020a2e9396000000b002bcd6342210mr6100008ljh.16.1698077417688; 
 Mon, 23 Oct 2023 09:10:17 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-216-159.dsl.sta.abo.bbox.fr.
 [176.170.216.159]) by smtp.gmail.com with ESMTPSA id
 x10-20020a05600c21ca00b003feea62440bsm9586039wmj.43.2023.10.23.09.10.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Oct 2023 09:10:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 5/9] target/sparc: Use tcg_gen_extract_tl
Date: Mon, 23 Oct 2023 18:09:40 +0200
Message-ID: <20231023160944.10692-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023160944.10692-1-philmd@linaro.org>
References: <20231023160944.10692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

Inspired-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f92ff80ac8..16d9151b90 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -740,14 +740,12 @@ static void gen_op_eval_bvc(TCGv dst, TCGv_i32 src)
 static void gen_mov_reg_FCC0(TCGv reg, TCGv src,
                                     unsigned int fcc_offset)
 {
-    tcg_gen_shri_tl(reg, src, FSR_FCC0_SHIFT + fcc_offset);
-    tcg_gen_andi_tl(reg, reg, 0x1);
+    tcg_gen_extract_tl(reg, src, FSR_FCC0_SHIFT + fcc_offset, 1);
 }
 
 static void gen_mov_reg_FCC1(TCGv reg, TCGv src, unsigned int fcc_offset)
 {
-    tcg_gen_shri_tl(reg, src, FSR_FCC1_SHIFT + fcc_offset);
-    tcg_gen_andi_tl(reg, reg, 0x1);
+    tcg_gen_extract_tl(reg, src, FSR_FCC1_SHIFT + fcc_offset, 1);
 }
 
 // !0: FCC0 | FCC1
-- 
2.41.0


