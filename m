Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7B2786163
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:26:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOe-0008TV-1F; Wed, 23 Aug 2023 16:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOV-0008L9-AZ
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:00 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOK-0005U2-Tx
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:54 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bc0d39b52cso41167065ad.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822217; x=1693427017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sx0epkogYDT5CuB/Oub20dQ94By4bi1YJwfsT53fmL8=;
 b=qVXGHT32KGoNLNcX+9X/4IPhjGqiluSnvf8NBdexwJv4AtHQkO17tRfbMd1wqaCLC/
 cePOu+xjbVa8SvQLYZFm4X5X+puXBRKxM2lcNpVZDEIMM8JXAUFlH9KbnmAsaVVz6GmQ
 68DMUd8jZqGolEGLUp/FHEsKqS3Ym+1EYf0uOmUlOFP+dg3iVjNATIXb7QyFzHSI/yBw
 AECpNCFv6gwIILzE1kl/kWD6QRM5t1m47VjWhNm3nFGMk3Tc1DrXd2IHNa+t8RUv5AHp
 4hcd230GcLHh04dwshlbx5DbNDCaJEEL5rcSh2+v0hRKx6oQGisVdKK4RZ/+oPQoNTE+
 aYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822217; x=1693427017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sx0epkogYDT5CuB/Oub20dQ94By4bi1YJwfsT53fmL8=;
 b=RlxNcj4+37JRITUnXeNf7pxkbiSETyb6HHgmdaHeswfozG/A/t6lRXb+RO7rDSHOND
 GSHQFU8jK36XHfR+49dIKTNPrzOxJHtoyUw4fQEis3kF/aVDJjo5KTxAaBB+y9l0kPJz
 uVER8wdoZ0wU11XZCvQwYI70iJSVAQfd05YWovph83/gbcnRin60nEIOaJnlpA3T+1sE
 3B8egnVrYmHkesDbiY+iewzf0fGCAFF/qCk5PSPt1GtSht5SoJ6XdrwRGWP10jmskeu/
 xztUD1xopD0bgV2YQVr0445eiZScAcXHcpBp3oKE/79y2r53Jn6HyIGB1/iOWVaYZnK/
 B8Dg==
X-Gm-Message-State: AOJu0YxiZPO3TDXE4GXkFJfKxpJxkTGD019XeqeUFTNWz9p9x3CEcRTl
 Z1FPUx2lRsC9XSEbr/arEUpiH9BwVMZ4VubJzv0=
X-Google-Smtp-Source: AGHT+IFYgGbEnphxRv4I3/E5TlBTeTrfLyH3nOb4YP714Ko+YtCjxmoE/eSZq5OmGG8EkoKpfmLI3A==
X-Received: by 2002:a17:903:234a:b0:1c0:8a05:f356 with SMTP id
 c10-20020a170903234a00b001c08a05f356mr7771903plh.54.1692822217532; 
 Wed, 23 Aug 2023 13:23:37 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/48] target/m68k: Use tcg_gen_deposit_i32 in gen_partset_reg
Date: Wed, 23 Aug 2023 13:22:48 -0700
Message-Id: <20230823202326.1353645-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index e07161d76f..d08e823b6c 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -697,19 +697,12 @@ static inline int ext_opsize(int ext, int pos)
  */
 static void gen_partset_reg(int opsize, TCGv reg, TCGv val)
 {
-    TCGv tmp;
     switch (opsize) {
     case OS_BYTE:
-        tcg_gen_andi_i32(reg, reg, 0xffffff00);
-        tmp = tcg_temp_new();
-        tcg_gen_ext8u_i32(tmp, val);
-        tcg_gen_or_i32(reg, reg, tmp);
+        tcg_gen_deposit_i32(reg, reg, val, 0, 8);
         break;
     case OS_WORD:
-        tcg_gen_andi_i32(reg, reg, 0xffff0000);
-        tmp = tcg_temp_new();
-        tcg_gen_ext16u_i32(tmp, val);
-        tcg_gen_or_i32(reg, reg, tmp);
+        tcg_gen_deposit_i32(reg, reg, val, 0, 16);
         break;
     case OS_LONG:
     case OS_SINGLE:
-- 
2.34.1


