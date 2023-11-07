Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D79587E3400
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:14:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0COb-00077f-G3; Mon, 06 Nov 2023 22:04:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO8-0006OS-9Q
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:28 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO6-0000fD-4b
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:23 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cc131e52f1so48056585ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326261; x=1699931061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bq1ZlMGsY4e8Iwr9tgGW/hU3fTtznVC7sHTWJluQEek=;
 b=wCMPQSDOpwBoaBJ1QqjSdRdnkWY32kRv0cR6b7wWoGIMHrxOdZkTg+QRcy/IWFlr8Z
 ybGw9kEx/r1dQtADLd03bZBk0+joYE4Xu3yH2M7jVinT/HQp8pAHDyMvoARHOXrstKvf
 E0ImMlCk4QgYsG0pmy6812LghM2GD62vQD6Py8VCkslvCnwQVO58DT7hZHuCIsD9n0DR
 xryqtEmknmbX++Dj7h03KlJJf0yMkMHLo/aXT99tA2nsnIBFxBw+Ge++tSUY9oWQbgwO
 HT1LDhsj8t559HfZFTDDBUWOTDTiO1mCn6lScJXoX1Ehuc2wcTs2ZScuqUUjk0YR8lRp
 SbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326261; x=1699931061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bq1ZlMGsY4e8Iwr9tgGW/hU3fTtznVC7sHTWJluQEek=;
 b=vpMpBR5U09S27ayLJJDF6yO/wJInAqipM291pGk6XRNfiYCVdNh5iSCNPJyjMblGAL
 f5RxNQ7TiofllvrbwFMv47Smy6Fi4GcRFQ9M7AmpImZIZUps/+GIO6MWgl3DtbsSXUms
 RkqgWokpc6l1AaUffb7AChYLUjVDsRDtIt6HTMGZ9EsPHlpD/8jECcMtc6KJBc/am2Jf
 jVs0eyJQBTaVztDClt8SE8Ntsay9ysJuURhUSkOualssbi9LgID2VjHahQ3DdtFZF/+V
 qL9k5BlvSlFyp/KE/wFA1A7ml+yTkqbwcHCCLr8kvbYcAXTaIiXssrGXOiQeHuvk1Yqx
 SQtA==
X-Gm-Message-State: AOJu0Yz/D9Jf/+8UrJGtsU3wX+ri2AlF0SPpTWQ/CIRrYFHz0fZUX9d5
 WQTG1RzBCttEz31D9dxHzQ9Hw8FMc84hFDnApQU=
X-Google-Smtp-Source: AGHT+IHfbT+zBokqcowZjw4qCA8FP9CQ6Cm9wYR2m1LTGrwYEE0eNb6kVl78uKD5ND/M9x7UUujhXw==
X-Received: by 2002:a17:903:44b:b0:1cc:419e:cb4b with SMTP id
 iw11-20020a170903044b00b001cc419ecb4bmr1637743plb.19.1699326260836; 
 Mon, 06 Nov 2023 19:04:20 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/85] target/hppa: Fix extrw and depw with sar for hppa64
Date: Mon,  6 Nov 2023 19:02:58 -0800
Message-Id: <20231107030407.8979-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

These are 32-bit operations regardless of processor.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ffa367b91f..ed88f724ce 100644
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


