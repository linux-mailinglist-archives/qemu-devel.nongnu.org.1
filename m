Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9927CEB3E
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:28:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzR-00084f-Mw; Wed, 18 Oct 2023 18:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzQ-000849-49
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:08 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzO-0002T5-AU
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:07 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c9e06f058bso1356735ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667965; x=1698272765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O6ypWKYmP3E0vSS+zdR/mRhAnNRJOT7ENlr0UKfEKr4=;
 b=YlGy25UlYtYez2IRe3x6+HTjQESPoKzoZlWXDt6gNHuUUIQFV+rrUe3znLfiscYBO9
 1OdQIvDfhyuha/OfEQvAcBqC+wOq4kms/zGHp/d/psyNdz7dIqYGCDe28MtRAvMG1U1Y
 li7YiJyZkZUGuSvQ1YIr2QmwYuQf2jWK0lr8xw7JNYIdixNtYfcDNIlBVdWN4nhqWJIk
 CkO5nInc7199YCdTiqlKE/ytsBNOPPmoW77WOUWcpAmv0dXhX5/mVn3gSBPiJKurhB5y
 JDhaOQK70/jfCQsUZCgehsbPHb1ufCFthp1qKAOxLK4KUYBUTkccFJ7cNJ0rHY2ivXRK
 IeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667965; x=1698272765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O6ypWKYmP3E0vSS+zdR/mRhAnNRJOT7ENlr0UKfEKr4=;
 b=VMqBMCRQS/Do2ybCXwXEkor8Ax1tWSBDRBSJVCi9SojFXaPNozJdylspAgL2gyIRFR
 2nARVZowN/M1sT8o3NF8yQNDWUH64YLs4afOVRtADLPXDYxkwOBIROjSRHKYuzVi7otk
 r8GShTMbVoIeCxc/aBj69VYzfQ9qqmfzwpPd5lSha+zOsD+HbNQrL7K/mDZA/ZOCMIGC
 SibEwKqdvrAEdrY6aaiAVPDPtoTS9Jf0ZTK7VuW3I7heoo+4ZLNBOdw6t5+dP872OI68
 X3ubbjsGg9mOe/2btAoc3TS7Zy6NZrKNU6V2JBjKm0ZANDeH2G7neTZ138KZ4I8VaYOx
 ZiRw==
X-Gm-Message-State: AOJu0YyMCx6mdjanqSFvueuZ2ofDZsxS7yRI64EJLHMyiAI908OZhucb
 bGdSO184XwXqxm+xQoAlBJLXjMlRey/wtZD8t9I=
X-Google-Smtp-Source: AGHT+IGa8qzwB2aOILS1dXO0ekXEJ0R7qjdG5/MREabN4ToG/Zy/SbLLrQD3HiUKPazTkr+ch8/RqQ==
X-Received: by 2002:a17:903:456:b0:1c9:c3eb:6551 with SMTP id
 iw22-20020a170903045600b001c9c3eb6551mr252442plb.10.1697667964817; 
 Wed, 18 Oct 2023 15:26:04 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/29] tcg/ppc: Use ADDPCIS in tcg_out_goto_tb
Date: Wed, 18 Oct 2023 15:25:35 -0700
Message-Id: <20231018222557.1562065-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
 tcg/ppc/tcg-target.c.inc | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 720f92ff33..6337b1e8be 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2593,6 +2593,7 @@ static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg)
 static void tcg_out_goto_tb(TCGContext *s, int which)
 {
     uintptr_t ptr = get_jmp_target_addr(s, which);
+    int16_t lo;
 
     /* Direct branch will be patched by tb_target_set_jmp_target. */
     set_jmp_insn_offset(s, which);
@@ -2602,9 +2603,15 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     if (USE_REG_TB) {
         ptrdiff_t offset = ppc_tbrel_diff(s, (void *)ptr);
         tcg_out_mem_long(s, LD, LDX, TCG_REG_TMP1, TCG_REG_TB, offset);
+    } else if (have_isa_3_00) {
+        ptrdiff_t offset = tcg_pcrel_diff(s, (void *)ptr) - 4;
+        lo = offset;
+        tcg_out_addpcis(s, TCG_REG_TMP1, offset - lo);
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1, lo);
     } else {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP1, ptr - (int16_t)ptr);
-        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1, (int16_t)ptr);
+        lo = ptr;
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP1, ptr - lo);
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1, lo);
     }
 
     tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
-- 
2.34.1


