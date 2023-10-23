Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA087D3EDF
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:17:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRI-0005tO-2K; Mon, 23 Oct 2023 14:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzRE-0005jr-7x
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:04 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzRC-0008IK-Nn
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:03 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-581f78a0206so2091547eaf.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084840; x=1698689640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T4DZaKL6rPO4eOmJB5sgPBMNx7MhU9e4zPB2kNBWFXU=;
 b=olsCo6+eTtThKj8CnIcjq9KnsnjYyL4kCeUg0aj7hRS8Z2b2aGsacBGjH9HnX0pRQw
 OyOLBXmL/UN6wQmaPOYERRRqi5IbBseAhrsRrVqn4u8MiRi/AdbvZcRFBgejPtRggeCU
 nLcijn18T6hgpafL56PEDHp+1hrfFUxjOBZv4NnunGl3/TBk5bLiYJuR/JLg4bG2XtvY
 viIfqukZkdgTGiRXX4TFsiGnO2ip021JkG3EJmbOay/A3/86zb2Cwp7RWXO5119BmcBX
 A7An5tjB8H6zYUl0UOAD3Rw+/Qk3Hdy2JXx0AGUfrLZt3Gz2Kp9+Q+vHQ1xxOaWFvrje
 vq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084840; x=1698689640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T4DZaKL6rPO4eOmJB5sgPBMNx7MhU9e4zPB2kNBWFXU=;
 b=wEY1AKfS0q6Rgh4i20IdCoA2Vbz0/pWKdXgCN0LS1+lryaITGh4icn3q9fRn3/eEAu
 3B5Wucw99Wvr72PzIDLiL8XKsTtAkG6o0Gq6mkf/CQCbJk+0T8i5A6iHB9ERhImQ3YRZ
 5VSpEAW5CSDw71sEa1SNiDHCz0NaVM7wdNbMl40bLTIyWARQv+FVI19kj1LS4Juh0N9Z
 FXD+RB24RzNInwif34fmZSlHbQvg9ZihzXyE96gOzllg1+YoQ76zEX7iILcNwz88Ja5P
 sBjNqKlgWM7JfozMldnKAH1e0iF1zHIANt/0brbprRcAPYeeCyxaOVg645xJAKWKWgOd
 p65Q==
X-Gm-Message-State: AOJu0YzlIFtTWBbRw5GxwBMom2HehW60bIWj/Ii50L/WBdFP3WRXLxel
 A/WuUBRb6snMmB/392hByrHPIEsh7g4fpq+hhXE=
X-Google-Smtp-Source: AGHT+IEGUN1oPEANmdamX6TRqXIRCQTDNgaGnqIosC3Mv80tl5WGrNHTLxV+ss3PpVeirwMmWcIjiA==
X-Received: by 2002:a05:6359:6c11:b0:168:e697:ce0d with SMTP id
 tc17-20020a0563596c1100b00168e697ce0dmr1980721rwb.31.1698084840509; 
 Mon, 23 Oct 2023 11:14:00 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:14:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 33/38] target/arm: Use tcg_gen_ext_i64
Date: Mon, 23 Oct 2023 11:13:24 -0700
Message-Id: <20231023181329.171490-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

The ext_and_shift_reg helper does this plus a shift.
The non-zero check for shift count is duplicate to
the one done within tcg_gen_shli_i64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 37 ++--------------------------------
 1 file changed, 2 insertions(+), 35 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 10e8dcf743..ad78b8b120 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1324,41 +1324,8 @@ static void ext_and_shift_reg(TCGv_i64 tcg_out, TCGv_i64 tcg_in,
     int extsize = extract32(option, 0, 2);
     bool is_signed = extract32(option, 2, 1);
 
-    if (is_signed) {
-        switch (extsize) {
-        case 0:
-            tcg_gen_ext8s_i64(tcg_out, tcg_in);
-            break;
-        case 1:
-            tcg_gen_ext16s_i64(tcg_out, tcg_in);
-            break;
-        case 2:
-            tcg_gen_ext32s_i64(tcg_out, tcg_in);
-            break;
-        case 3:
-            tcg_gen_mov_i64(tcg_out, tcg_in);
-            break;
-        }
-    } else {
-        switch (extsize) {
-        case 0:
-            tcg_gen_ext8u_i64(tcg_out, tcg_in);
-            break;
-        case 1:
-            tcg_gen_ext16u_i64(tcg_out, tcg_in);
-            break;
-        case 2:
-            tcg_gen_ext32u_i64(tcg_out, tcg_in);
-            break;
-        case 3:
-            tcg_gen_mov_i64(tcg_out, tcg_in);
-            break;
-        }
-    }
-
-    if (shift) {
-        tcg_gen_shli_i64(tcg_out, tcg_out, shift);
-    }
+    tcg_gen_ext_i64(tcg_out, tcg_in, extsize | (is_signed ? MO_SIGN : 0));
+    tcg_gen_shli_i64(tcg_out, tcg_out, shift);
 }
 
 static inline void gen_check_sp_alignment(DisasContext *s)
-- 
2.34.1


