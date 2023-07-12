Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C4F74FF0D
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 08:09:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJT1p-0000cu-EP; Wed, 12 Jul 2023 02:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJT1W-0000ZM-B7
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 02:08:27 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJT1T-0007UD-46
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 02:08:25 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99364ae9596so828508766b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 23:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689142100; x=1691734100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23kT9O/dEUBttMJdXxI9Sf+c95dROPXelirqaPaxH6I=;
 b=OU4N2bYIe4wYQngzhBzLF7fkqJ68gGY0NLQUTNLija0WDiTqZgL9SUzQ0aiZzJ3riO
 JDbFw07t7mIYE4BTdKCJlsZ6uSAoOiPsxoxBnz4kuejNxedOHJyWwu+fxacncAByRBAr
 PjlzgGRWo9WX1Dl2X9eyxUHWwHppyI/al3Usb6C8oYsh7QX14UoQC/IPacB6az6tXYH/
 YzvfyUDT5DjXHLn7z8qKjLXoGe3Y1+TXMZgAiQD4jQQcvaDnwM+0O+iXluy2yoqeE1pI
 A+iwf2N/dssSlGL3zUa9RaCux79U9Ar71XvT6Pu3rqEH9Lb/qTfc1Gn+3IOk2BxszF0J
 mezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689142100; x=1691734100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=23kT9O/dEUBttMJdXxI9Sf+c95dROPXelirqaPaxH6I=;
 b=SfwM6PmgspUDeZqTh1NHGEEv5lD+jK7HsQ5VkPNsOiX/+LL8pSAGgCiPVbFAziORNL
 8HKFNIRF+I4pubWCG42l2jaqjcf9Bj5TMSfcw6AmtWBJk8d/c/7kPQZK63/A4XA8DsHv
 I9kPc6kB3FvG5Cwlk4Rb13ZoQJ/hQ4ouIfiatMbGpI+vZ9Zs2ixRjG9nJWNVGkwXW/9C
 NGdUYhJIzjwq5y5QDGkbWcsYdt+6StEDDuzI0+B/pnu9YB5qLA2VWLihEVjbcAfHe4sC
 HCqkJHemMhgx55wKxSsdBzUfanT2ZkTAzNpOjw0W44StaGSTauyd9ijIn5Za/jiglqEM
 ZPNA==
X-Gm-Message-State: ABy/qLYHSgul/OMZnd6FGwolbjQ2nJBFCXkMzFfc65gktj0ktU1Zm4ec
 6dftC0UaeQdYw15/5SU51wdd6BoVGzUIX4s/Znw=
X-Google-Smtp-Source: APBJJlFQIHW4A1PQVWM8XeCWKrBbRdkq65ON24WD3EoEzd6VLedB17Q/sRCuXA03Gwam01lxmW//Kg==
X-Received: by 2002:a17:906:1114:b0:988:a578:4d65 with SMTP id
 h20-20020a170906111400b00988a5784d65mr15939574eja.32.1689142100088; 
 Tue, 11 Jul 2023 23:08:20 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 dc21-20020a170906c7d500b00988b86d6c7csm2041132ejb.132.2023.07.11.23.08.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 23:08:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Craig Janeczek <jancraig@amazon.com>
Subject: [PATCH-for-8.1 2/3] target/mips/mxu: Avoid overrun in gen_mxu_S32SLT()
Date: Wed, 12 Jul 2023 08:08:05 +0200
Message-Id: <20230712060806.82323-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230712060806.82323-1-philmd@linaro.org>
References: <20230712060806.82323-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Coverity reports a potential overrun (CID 1517769):

  Overrunning array "mxu_gpr" of 15 8-byte elements at
  element index 4294967295 (byte offset 34359738367)
  using index "XRb - 1U" (which evaluates to 4294967295).

Use gen_load_mxu_gpr() to safely load MXU registers.

Fixes: ff7936f009 ("target/mips/mxu: Add S32SLT ... insns")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index b007948a73..520747a597 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -2434,8 +2434,12 @@ static void gen_mxu_S32SLT(DisasContext *ctx)
         tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
     } else {
         /* the most general case */
-        tcg_gen_setcond_tl(TCG_COND_LT, mxu_gpr[XRa - 1],
-                           mxu_gpr[XRb - 1], mxu_gpr[XRc - 1]);
+        TCGv t0 = tcg_temp_new();
+        TCGv t1 = tcg_temp_new();
+
+        gen_load_mxu_gpr(t0, XRb);
+        gen_load_mxu_gpr(t1, XRc);
+        tcg_gen_setcond_tl(TCG_COND_LT, mxu_gpr[XRa - 1], t0, t1);
     }
 }
 
-- 
2.38.1


