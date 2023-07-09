Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D07874C47A
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:01:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxg-0000Uz-OC; Sun, 09 Jul 2023 10:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxI-0000OJ-6a
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:05 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxG-0000P7-Do
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:03 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-314172bb818so3864430f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 07:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911201; x=1691503201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9eRhNGGsvyXPq3UhYSn/b3L2GTywYRMcqzsZGePD5qs=;
 b=eMV79sWilJqua5a+Bz2Qdo/99TdCMp6DGijlsLIipFpOgMaW9riMtQmuRUpSiO0i+O
 lykQEA3LcGnTAxezM3CgZg9fQvP7Rx4NhXffw88IOCCJJIVytKN/M1m186sRXkIdKbVP
 bcMMe2NnRV+YeZvl/7fjv/TPRceM/c1cmRAVpPR5T+eiVDRpiDOPLZyOa7+Rsuqne5mj
 iAzoOAAQy1EjmVIxKKuZibw/U4elgRe4SWVehCvRDNSpPnTqd4dk5bNPVdGY9Lv1Ozxl
 rDmSUghofIP00f62m5UC67VM4Qgbo4MssN35coJ43LYQxCUjMWusADSKnqByDA+ZOaTs
 0pSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911201; x=1691503201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9eRhNGGsvyXPq3UhYSn/b3L2GTywYRMcqzsZGePD5qs=;
 b=Q4q7kbcZ3GmD6yD2h/hZrj638ZOB0/2sN8nyYpO2P/pAonJq/UbKRaKl4uym3rpx/R
 bWXo488N7SjQpjsWAO+fw4fLc3CpQBpQDDwclKW1Hk4Pwducd9GTQCR3y2WaXcfLithu
 hwkviWYff5Ct9HlgYglhaHmMRua/g/xgrL6/o+7KnfOuQwR/z2gqSYPHv1vFc9AKmv7i
 yLgH5koZX/a3E8R5RXLoX+fF9+nTTQznEhQXucIiHtSnJKRuP9mJcDzPiEs/GooJ3Kqf
 Cb/Lydzh2JzP5hL1fliVfGIB2WmHYQjZiARUkwCg06BEdh/IMT73aGopgp8VFKLbAJG3
 8Szw==
X-Gm-Message-State: ABy/qLa/QT8AwodXQNwPTnfO13B6yz2+Q3l+bNBVnvp/XZj4udfaS8JX
 0XkNJ8hRBM+1APxwIU3EJ02XzxKTt/dWo87cJ1pXoA==
X-Google-Smtp-Source: APBJJlEaZCgfsPa+Z9CywYM5b7v1pVbAHn89riWCUq+pWnZqMSs4cJHRGq0xgiDTUx3oT4oXdLJHTQ==
X-Received: by 2002:a5d:4305:0:b0:313:df09:ad04 with SMTP id
 h5-20020a5d4305000000b00313df09ad04mr8810952wrq.57.1688911200856; 
 Sun, 09 Jul 2023 07:00:00 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.07.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 07:00:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PULL 16/37] target/ppc: Use aesdec_ISB_ISR_AK
Date: Sun,  9 Jul 2023 14:59:24 +0100
Message-Id: <20230709135945.250311-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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

This implements the VNCIPHERLAST instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 34257e9d76..15f07fca2b 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2973,13 +2973,7 @@ void helper_vncipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 
 void helper_vncipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
-    ppc_avr_t result;
-    int i;
-
-    VECTOR_FOR_INORDER_I(i, u8) {
-        result.VsrB(i) = b->VsrB(i) ^ (AES_isbox[a->VsrB(AES_ishifts[i])]);
-    }
-    *r = result;
+    aesdec_ISB_ISR_AK((AESState *)r, (AESState *)a, (AESState *)b, true);
 }
 
 void helper_vshasigmaw(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
-- 
2.34.1


