Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D757C7D1756
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:46:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLw-0007tw-86; Fri, 20 Oct 2023 16:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLV-0007jQ-TZ
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:52 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLS-0008AL-U4
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:49 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6bd32d1a040so1213420b3a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834624; x=1698439424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T6DEfOhGSAuzHVOiFy6ZRmh1nqeZSzZi7HDKv5g8+j0=;
 b=BsNZ67kc7dWCgOMVsBf0JFCqD79DLaZDrGCUzvsdUCPWwm6gQhnrpuq8SzI/7/7bkf
 VIuV7gu8G1cQPiPUIz4TksdANcT0tQlqRY7GGJ5/dcnaU66DNvtoCNo3JeMT/hku9FCV
 zs+66E+kR1tr6XrTyFqoMw1D7qdPvmOTyYhRdkplyoG0ZAZC4aqrWCyI+sVC0u1bBSy9
 KadQDApw5c//NAl8We7C4yeZpSou3eQ/HUgxYabVe4nFI3dUmoZAB6q7SDR2KOH1CQCJ
 6EuWM/rCDXnpWyhSmZvlVCy3y+Q6SeVofK7PGU1bw8NThnPAbZ0JTbBgOE7DXyrovCGH
 KRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834624; x=1698439424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T6DEfOhGSAuzHVOiFy6ZRmh1nqeZSzZi7HDKv5g8+j0=;
 b=o0OisxBZBumrWwkq5h3KMX6IGsIU+cA0VyW4ayT59jFWQmPU71q1kqiMZuALR3lPsj
 HjeJ6+l8Sp8aMDu1Ma2LkdFs+JyWhyHJKcWG5oUxQAA88B0EWZnFvxrN8moIx+IrwLPg
 uRfdbYq/57UU8CfoaiH6j/AnFANltZoiu5EXAn5qII29ZdLA4XCvahwraIZvHdh8iCkE
 /P/R7tesV31ZNnDxM4lNpIYF9tuKPkIg+nTIrYrbxhumdFgxTUIspPVpBYaDZzsbvXlo
 b1eawsemXRLq1NtvBBJr7vywp77cT8g5JevEwWWRKifnMQb5zLUoTadcBRnHgKtsnfGC
 0YuA==
X-Gm-Message-State: AOJu0YxPkejekG7aynsEghq4L5qz+ffWYTaUWzilguJGxHtGPhMqm+Q9
 /Z+6K9jHMAADpS6ndLHDUnoJT4Gjz0bIohWidow=
X-Google-Smtp-Source: AGHT+IHqB3WJ/vu9PLoRlGuVe5QnRyuvoHJi1cgadBn0jjy5vDe6Xk1F9HxDKAEpBzk+MmWbSvfyNA==
X-Received: by 2002:a05:6a00:84f:b0:6bd:b3b9:649f with SMTP id
 q15-20020a056a00084f00b006bdb3b9649fmr3273030pfk.7.1697834624318; 
 Fri, 20 Oct 2023 13:43:44 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 12/65] target/hppa: Fix extrw and depw with sar for hppa64
Date: Fri, 20 Oct 2023 13:42:38 -0700
Message-Id: <20231020204331.139847-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

These are 32-bit operations regardless of processor.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 119422870c..f86ea9b9ca 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3230,7 +3230,9 @@ static bool trans_extrw_sar(DisasContext *ctx, arg_extrw_sar *a)
     tmp = tcg_temp_new();
 
     /* Recall that SAR is using big-endian bit numbering.  */
-    tcg_gen_xori_reg(tmp, cpu_sar, TARGET_REGISTER_BITS - 1);
+    tcg_gen_andi_reg(tmp, cpu_sar, 31);
+    tcg_gen_xori_reg(tmp, tmp, 31);
+
     if (a->se) {
         tcg_gen_sar_reg(dest, src, tmp);
         tcg_gen_sextract_reg(dest, dest, 0, len);
@@ -3355,7 +3357,8 @@ static bool do_depw_sar(DisasContext *ctx, unsigned rt, unsigned c,
     tmp = tcg_temp_new();
 
     /* Convert big-endian bit numbering in SAR to left-shift.  */
-    tcg_gen_xori_reg(shift, cpu_sar, TARGET_REGISTER_BITS - 1);
+    tcg_gen_andi_reg(shift, cpu_sar, 31);
+    tcg_gen_xori_reg(shift, shift, 31);
 
     mask = tcg_temp_new();
     tcg_gen_movi_reg(mask, msb + (msb - 1));
-- 
2.34.1


