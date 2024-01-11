Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C749D82AD08
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:11:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssU-0001Rh-P7; Thu, 11 Jan 2024 06:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss8-0001M0-VR
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:17 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss6-0004Q1-Lu
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:16 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-336c9acec03so4519277f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971113; x=1705575913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H2twb/r8sx0w6+zjm6Opwu2RcD6Eydz3aISuZWYaH3g=;
 b=D7MtU716tFInI84HEdAxtdbTgM6gYEurt7lzh9pbY8t3ULctBtg//U3oqvpPIYE7Pc
 OLH5cNghkjzNbihKsb8bOU3eGUNJo9Qiq+aGWtIXpGYFN2b6ppAXAG6Tukn8G6kEuscS
 bNxNWZKm2TQ5ORwzK1dAdB+qArZAN6Y/XKmA2K/k3JPB4nwkdaJjhhyzc4xslh7yeZXt
 DW9o60MqtodYimr+jEXraW4rvkY/kb7R15hWbnK25GnEktlA/XpgPSBv2T7WRcOD7wJq
 hCz5wFa80yhnTOLtmuqjpjmd/FWJASEicyGIt5rSoUI3RHYuby0cmpCyJFiP1rTjFi5K
 Lh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971113; x=1705575913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H2twb/r8sx0w6+zjm6Opwu2RcD6Eydz3aISuZWYaH3g=;
 b=CyMGJpzlBZPM7GA4CoQteygZ0psaKfQJiSX4B6uA6p0hUbFdLq9El5nQPVH38UIE1n
 iXovQbEdFEJ+lBcaW/rzmfZ9n01x5t06AhAszWomxGePasdeWESZuq0GstU2ZHgBxao6
 BISLDxYy8XGYdeuRVvnMLagv1EKsoeTjOdWdfP2LComzNGTE7imeZF0jnK7LbLjRDimD
 iMvITfWaxqirPARLP7Hry1cW+FZuxeZs5rLCOayffBezjOm8cZgLF6zThOsR9v0Xav7F
 QhyX9PtRY4zoY8MYnBI5JBM+T0W6oWQo4FyOu89HbHoS8ZqW6BSQYdGq3r9flRNVGOv+
 +76g==
X-Gm-Message-State: AOJu0Yw5ZpeAAtcVYeM1mvPh/H4MifZU5HDGI3s/M2RcmBRTr6bC99C0
 +Wm2zFO/VX7kJxmHFua4T5yTaTcNmn0Y4DQ3PKMeOGON39k=
X-Google-Smtp-Source: AGHT+IFKd72UjlpGOCsGlU8ilmyif90aca6m0G3AhrLlv3m68TAtt5O+Xoh/uFouhbTupr8Gmta52Q==
X-Received: by 2002:a5d:690f:0:b0:337:62c6:cd1c with SMTP id
 t15-20020a5d690f000000b0033762c6cd1cmr635279wru.80.1704971112946; 
 Thu, 11 Jan 2024 03:05:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/41] target/arm: Allow use of upper 32 bits of TBFLAG_A64
Date: Thu, 11 Jan 2024 11:04:38 +0000
Message-Id: <20240111110505.1563291-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

The TBFLAG_A64 TB flag bits go in flags2, which for AArch64 guests
we know is 64 bits. However at the moment we use FIELD_EX32() and
FIELD_DP32() to read and write these bits, which only works for
bits 0 to 31. Since we're about to add a flag that uses bit 32,
switch to FIELD_EX64() and FIELD_DP64() so that this will work.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/cpu.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8da6bfda228..6dd0f642581 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3237,12 +3237,14 @@ FIELD(TBFLAG_A64, NAA, 30, 1)
 FIELD(TBFLAG_A64, ATA0, 31, 1)
 
 /*
- * Helpers for using the above.
+ * Helpers for using the above. Note that only the A64 accessors use
+ * FIELD_DP64() and FIELD_EX64(), because in the other cases the flags
+ * word either is or might be 32 bits only.
  */
 #define DP_TBFLAG_ANY(DST, WHICH, VAL) \
     (DST.flags = FIELD_DP32(DST.flags, TBFLAG_ANY, WHICH, VAL))
 #define DP_TBFLAG_A64(DST, WHICH, VAL) \
-    (DST.flags2 = FIELD_DP32(DST.flags2, TBFLAG_A64, WHICH, VAL))
+    (DST.flags2 = FIELD_DP64(DST.flags2, TBFLAG_A64, WHICH, VAL))
 #define DP_TBFLAG_A32(DST, WHICH, VAL) \
     (DST.flags2 = FIELD_DP32(DST.flags2, TBFLAG_A32, WHICH, VAL))
 #define DP_TBFLAG_M32(DST, WHICH, VAL) \
@@ -3251,7 +3253,7 @@ FIELD(TBFLAG_A64, ATA0, 31, 1)
     (DST.flags2 = FIELD_DP32(DST.flags2, TBFLAG_AM32, WHICH, VAL))
 
 #define EX_TBFLAG_ANY(IN, WHICH)   FIELD_EX32(IN.flags, TBFLAG_ANY, WHICH)
-#define EX_TBFLAG_A64(IN, WHICH)   FIELD_EX32(IN.flags2, TBFLAG_A64, WHICH)
+#define EX_TBFLAG_A64(IN, WHICH)   FIELD_EX64(IN.flags2, TBFLAG_A64, WHICH)
 #define EX_TBFLAG_A32(IN, WHICH)   FIELD_EX32(IN.flags2, TBFLAG_A32, WHICH)
 #define EX_TBFLAG_M32(IN, WHICH)   FIELD_EX32(IN.flags2, TBFLAG_M32, WHICH)
 #define EX_TBFLAG_AM32(IN, WHICH)  FIELD_EX32(IN.flags2, TBFLAG_AM32, WHICH)
-- 
2.34.1


