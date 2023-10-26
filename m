Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1478C7D7998
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:38:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6c-0001yL-Qw; Wed, 25 Oct 2023 20:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6A-0000wZ-O8
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:44 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo5y-0006ci-KC
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:42 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c9e95aa02dso2342595ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279569; x=1698884369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EHAeumhj/k6eiqLtdrKjjL6mwObgsX5DY/BFSjKBF5I=;
 b=mgt5qT0DBNwI4mrDNeTLnRe01XVQC7ohviSstpeIz5KWPmyNSlvI9t19YASv2pKm2i
 k3e7p1qM3XolTsVgZicNUhxV8ZJt8SbK6UUbN/1vkAXcW8rK2JBU6Lj42xqQcAl9T0YB
 bLZK2OuB6e5khUZ9oTZM9h6mANkoqVwXBJbYtbRWRX/0OBOA02TK5/dJanziAxfGKdvX
 v3nCDDD6k/eCZw3d+0Fn7q5WUtj+1I8jcE3YCG9EtMJGa21ztmzomY6IHBAcqU32sN6q
 EXpf5Yf9eN/bGJNFse1hCZTWjR0tVsA7yXGD8RFbybbbC065F2+OTLLkq6/2CcjYbr4g
 7HDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279569; x=1698884369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EHAeumhj/k6eiqLtdrKjjL6mwObgsX5DY/BFSjKBF5I=;
 b=lHsJjQeyMtjxT7loZbAQaUNFHZbzKKGPyefHlpbE5wSgaYeIOZRrrzpNLixs5elOWl
 lM4KrULFfS30ypGWtdg9giDUjlxCcvETtHTmTxFTUPz1X0aFtV7QPM8XRsqh7QT2Q7TD
 o6zueZdwX3MqkST5R/9+82yAWjTfN3CJfPA5ogZnqKyTTlA2KtHm+I79S5k87cjqwOvt
 +OEYpbIL6HbMiRUYcz0bhK1vBfZR6SivLqOmX71dQ8wuFTCnMvhFIIW8IBvp8b3el9Xq
 RP9PkhqDQIZBkrcb6ofJ3gilHEGbstfaKvHP5q2BAywcqf5VZ1p/xFmh6fxF2GJR6fHT
 pmbg==
X-Gm-Message-State: AOJu0YzKUDpGPbPmx3amOCfuqWohmFI/m/MtLjgcGiik/hlz4ct+N1mw
 lhFsBH0wd8lI2WjwIkbJhWGBVt+4HKqGe3y9GnU=
X-Google-Smtp-Source: AGHT+IHyL0lA7gkflLskPJIlYemEZS0pQhd8Ryw7eClDYH85WfnpTQ7SGHKhAeVMAJJQ/LW4YGRtsQ==
X-Received: by 2002:a17:902:e883:b0:1c5:c546:fece with SMTP id
 w3-20020a170902e88300b001c5c546fecemr1530817plg.34.1698279569435; 
 Wed, 25 Oct 2023 17:19:29 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 28/29] target/alpha: Use TCG_COND_TST{EQ,NE} for CMOVLB{C,S}
Date: Wed, 25 Oct 2023 17:14:34 -0700
Message-Id: <20231026001542.1141412-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 49e6a7b62d..c7daf46de7 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1676,16 +1676,12 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x14:
             /* CMOVLBS */
-            tmp = tcg_temp_new();
-            tcg_gen_andi_i64(tmp, va, 1);
-            tcg_gen_movcond_i64(TCG_COND_NE, vc, tmp, load_zero(ctx),
+            tcg_gen_movcond_i64(TCG_COND_TSTNE, vc, va, tcg_constant_i64(1),
                                 vb, load_gpr(ctx, rc));
             break;
         case 0x16:
             /* CMOVLBC */
-            tmp = tcg_temp_new();
-            tcg_gen_andi_i64(tmp, va, 1);
-            tcg_gen_movcond_i64(TCG_COND_EQ, vc, tmp, load_zero(ctx),
+            tcg_gen_movcond_i64(TCG_COND_TSTEQ, vc, va, tcg_constant_i64(1),
                                 vb, load_gpr(ctx, rc));
             break;
         case 0x20:
-- 
2.34.1


