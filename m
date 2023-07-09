Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF6D74C721
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:34:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZE2-0003RZ-7k; Sun, 09 Jul 2023 14:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDh-0002pA-D4
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:20 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDe-00049o-Qy
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:17 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31438512cafso4025499f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927593; x=1691519593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ZmDZIvgGB2xxk9tqZEB+B+DCJxeJQyw+1f4RzekeQw=;
 b=FJzvG8XuPhB2RMstkTIOAe+zm5tYULhLxGH/gdKst+DPP80gtRChlTP8Sx5P3ktljn
 BPmr2Kf8V6IsMB7bpAkz3S2KAHGXmi7vMv14YoBqdsFjDf6laVSjOUaV8tJVnJHB7L+a
 2w0PXlof1lUBYwy2YXnkwxPnDaoLcdo5Ccr6NRc3MU/7JYKVR1rdcAHwLIvqOPRra6Xn
 INvGpI72SolJoxleRXOG3qELc6K34kTZBPN0LOyYLBy3Z7qmKR0u+qplkzWoH/2Adovf
 oM16EMkezHhhpbGlymi3rEsnEk+NrOVozLZTiXBgtUHjXBE5irVJJM5vt+gYooa5fKpe
 pl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927593; x=1691519593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ZmDZIvgGB2xxk9tqZEB+B+DCJxeJQyw+1f4RzekeQw=;
 b=bDjRQy8e5zfp2wdi2B7FdQqlIrQXIhp4bwJK1/PZ5nTEwvnIYIUWmmPEMyBLGbK3Vx
 n1B9Q0oYnCkOfaEkY98rs0vGl0pvf8IIepGQ01TG1c4x+XM/QbWDj/pgEhtZbsF0gqlh
 uPFAXHx98/OWn2cRFoi7tnBG2WxOwG6751StOddoqzGUntCVLcwTFU0OyMOfMGgqjpL4
 7lb7HW1d78Br3A78Yq2Chu0QakRFSmexxV86e1Kqn7VTnwnaQwtcbbfNbwAmPpkHCG2Z
 jcEiz4hzqKnh3ddEAWDN9iZBoS2rPYLO9DMhND9AragjMBmMCWrRNG6GgtacOMgma7Ai
 tBOw==
X-Gm-Message-State: ABy/qLbfYdfCRQd23hhqwkhu5zWEoAhEheKwA0RflwFLKCXQgwK+OzCx
 ErKQ5HmGxwArEnbMyTRz1VipE8ZR7PmLY0aLVKktAg==
X-Google-Smtp-Source: APBJJlEDu0i7cVtG/9RWOpyWPNwkshKCp4s5SbGLyanz4l/UfhFBJ7I/SqeoosIzOFLGQX8siGa+6A==
X-Received: by 2002:adf:e403:0:b0:315:8a0f:9b9b with SMTP id
 g3-20020adfe403000000b003158a0f9b9bmr6434234wrm.71.1688927593515; 
 Sun, 09 Jul 2023 11:33:13 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/37] target/i386: Use aesdec_IMC
Date: Sun,  9 Jul 2023 19:28:54 +0100
Message-Id: <20230709182934.309468-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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

This implements the AESIMC instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/ops_sse.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 0a37bde595..893913ebf8 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2215,15 +2215,10 @@ void glue(helper_aesenclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 #if SHIFT == 1
 void glue(helper_aesimc, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 {
-    int i;
-    Reg tmp = *s;
+    AESState *ad = (AESState *)&d->ZMM_X(0);
+    AESState *st = (AESState *)&s->ZMM_X(0);
 
-    for (i = 0 ; i < 4 ; i++) {
-        d->L(i) = bswap32(AES_imc[tmp.B(4 * i + 0)][0] ^
-                          AES_imc[tmp.B(4 * i + 1)][1] ^
-                          AES_imc[tmp.B(4 * i + 2)][2] ^
-                          AES_imc[tmp.B(4 * i + 3)][3]);
-    }
+    aesdec_IMC(ad, st, false);
 }
 
 void glue(helper_aeskeygenassist, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
-- 
2.34.1


