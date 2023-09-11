Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2B179A3B4
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:46:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfafT-0001nR-KE; Mon, 11 Sep 2023 02:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfafR-0001kq-3J
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:45:05 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfafO-0004fT-OC
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:45:04 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-57124ee486dso2677788eaf.3
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414701; x=1695019501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sW3nOVBepNUyjAGvpAdig0q954l70YYp+9BKZ+7kzlc=;
 b=UFFhWbY0W5S7EZP5pCtSqkUhapkwuX+rmVFu7IE7z70ujNX8Dtg3VnsUH90Fwgh2vp
 pBKKsiftY2Jebm3ROa0y5kU8isRNQOTW4lzJr5/pu6P0kCsY0fsu7Y4q8x7KKqztw7Bb
 +4LTvcZUEnc9JjXKZsslYZhbqDn6OkGBoZn5WgvCkpFHXPhfqQJSfNGJWDEv9a0TWOrr
 U5LuFNLjMfce0oBMdYpg7L4ow6CO5tKCmQQkHyn3ltgbQWUx8nIvQH9O2yLFIUbfQY4N
 p1BgA+Ay+bKJBD66mAXd8JanOL2gvPRg3nPoSvXcI4ZbLbm/67ijxypmFvX3sg57wtY5
 snXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414701; x=1695019501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sW3nOVBepNUyjAGvpAdig0q954l70YYp+9BKZ+7kzlc=;
 b=h8e5z0usaaXcwFLnV9b3feAKiFrXzxv8GMBh/Tf5m27VJ9/58zc9noLq8R2Wthext+
 Ctjq59u3aDlb/52yObWoWVvK6mfrcsp0T9iYH43BGIMLLB1HJF1MEosECZFuRwPkgr3a
 G7Br1KrEn3rAsXqguoErCCU9gYOrqyZjOxRqWggwkTsfTvstyswAaDybq3M0FmBi+URK
 e6PWtuj9pN88st+y3T9oeoc5on/znfKI08l46UtVjR9pPmIE1kgDTwWOAWvbWNqHPI1e
 1OaU9KF3nZsKGvSQdLmrbVwXGYg704cISDzhsmybubjhFFD2RGpib6Dj5G/Rqtooqn/N
 6l5g==
X-Gm-Message-State: AOJu0YxGpu5c1E0yN2IEsgCPfbGHG2/MFqN8V1sR+GAWUNtamSgR9ydi
 7vF16XdwbBrYBYUElBOXoxDQseG7KT1r/w==
X-Google-Smtp-Source: AGHT+IF0ADbk6IoopBYRh9ysCJo2Y8GUubm1xOWKLc/ehcswANyrWYSTBKUfFzPkW7igDw3CxIOwUw==
X-Received: by 2002:a05:6359:7387:b0:140:f08c:2b55 with SMTP id
 uz7-20020a056359738700b00140f08c2b55mr4713793rwb.9.1694414701134; 
 Sun, 10 Sep 2023 23:45:01 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:44:59 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 21/45] crypto: Add SM4 constant parameter CK
Date: Mon, 11 Sep 2023 16:42:56 +1000
Message-ID: <20230911064320.939791-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Max Chou <max.chou@sifive.com>

Adds sm4_ck constant for use in sm4 cryptography across different targets.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20230711165917.2629866-15-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/crypto/sm4.h |  1 +
 crypto/sm4.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/crypto/sm4.h b/include/crypto/sm4.h
index de8245d8a7..382b26d922 100644
--- a/include/crypto/sm4.h
+++ b/include/crypto/sm4.h
@@ -2,6 +2,7 @@
 #define QEMU_SM4_H
 
 extern const uint8_t sm4_sbox[256];
+extern const uint32_t sm4_ck[32];
 
 static inline uint32_t sm4_subword(uint32_t word)
 {
diff --git a/crypto/sm4.c b/crypto/sm4.c
index 9f0cd452c7..2987306cf7 100644
--- a/crypto/sm4.c
+++ b/crypto/sm4.c
@@ -47,3 +47,13 @@ uint8_t const sm4_sbox[] = {
     0x79, 0xee, 0x5f, 0x3e, 0xd7, 0xcb, 0x39, 0x48,
 };
 
+uint32_t const sm4_ck[] = {
+    0x00070e15, 0x1c232a31, 0x383f464d, 0x545b6269,
+    0x70777e85, 0x8c939aa1, 0xa8afb6bd, 0xc4cbd2d9,
+    0xe0e7eef5, 0xfc030a11, 0x181f262d, 0x343b4249,
+    0x50575e65, 0x6c737a81, 0x888f969d, 0xa4abb2b9,
+    0xc0c7ced5, 0xdce3eaf1, 0xf8ff060d, 0x141b2229,
+    0x30373e45, 0x4c535a61, 0x686f767d, 0x848b9299,
+    0xa0a7aeb5, 0xbcc3cad1, 0xd8dfe6ed, 0xf4fb0209,
+    0x10171e25, 0x2c333a41, 0x484f565d, 0x646b7279
+};
-- 
2.41.0


