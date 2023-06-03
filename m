Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF48720D59
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 04:36:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5H7L-0001Iw-Pv; Fri, 02 Jun 2023 22:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6O-0000Ql-6d
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:34:49 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6E-0004kc-68
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:34:46 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2566ed9328eso2313037a91.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 19:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685759676; x=1688351676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=st6PzalavgCIfa1mLbkYdK6syTJLzgLb0TShIkAxcYc=;
 b=eu57VacCrY1/LMwxdklfi1K3qcDmiRRgDW4YLIXYJiTLPMUFmdQk1IEV+iVMLJ6LpH
 g3oI9TwkWdClsmO37RubzYx+xcFgWwXSTx3k3MFTziJbifrvfd9UODr7iOh4mdxcI7aY
 yxYSRsgs8vfQTaULFHKAzpRmVHvJCs6Hw9XWLMpbqh1fLO2P6cfz7PgDULlQ+h+z8RPA
 UrApLgdv905ooZ+4mK9xSu0SDjkaO1MZkxFaQtdLql79IJJ0SfyFoUNDoUqeoDSWlYVi
 e2yRKYKJpHH8VYM32CtZqK2ThU4aJCRwsmfLz2x6/AMHP6em6fFmDfTVco1EUd+RJPIm
 QR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685759676; x=1688351676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=st6PzalavgCIfa1mLbkYdK6syTJLzgLb0TShIkAxcYc=;
 b=M6eH2jY0AOYMBXh2IZWGq6yE0C/wVJems5TR2kS3ClGocWnArsHg4V6jDunUEp6E6G
 +r0NXkRc6PrRJZI9e2V+0ncDnzrcAqknso3EgDAWI6qfjHOZopa9a/L5AF7UNkoyLiwi
 jdbHDUeS4pYYaJXuLU+fT/IFsrbcSPwCCp84nhiwivHdrPQIE/OUCdDha0T13O+06UIB
 BNiX+YRxSD71HWxLvn1SUDRrgsHn0JONiGV8u7H0jJh0nw3TGHBTWd0e9+dz5xipOmGE
 cpBSgpCJiSdtCdLTOS8ZwOrN7jbL3eeqdV5B/RRd8i/OuDzJ41PMHyMpxd9G8uFp3j3h
 0WGw==
X-Gm-Message-State: AC+VfDyUECD0dUUVpi/2zBNbeTAlsPHok+pdrlho+6UHOQge857+ByLE
 t4hNOaN8ykvhYiH//8C5pzOgfyTWNl6kjIS2x60=
X-Google-Smtp-Source: ACHHUZ7hcJEirzvgidInDIkZDs5cKwX5UGwdUmTi2BNB13IGXPpOSgKdj0SrlqExzbCsY1NmO9up4Q==
X-Received: by 2002:a17:90b:b0d:b0:256:8fae:4d50 with SMTP id
 bf13-20020a17090b0b0d00b002568fae4d50mr1644839pjb.21.1685759675928; 
 Fri, 02 Jun 2023 19:34:35 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 e91-20020a17090a6fe400b002508d73f4e8sm3914289pjk.57.2023.06.02.19.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 19:34:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH 09/35] target/riscv: Use aesenc_SB_SR
Date: Fri,  2 Jun 2023 19:34:00 -0700
Message-Id: <20230603023426.1064431-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603023426.1064431-1-richard.henderson@linaro.org>
References: <20230603023426.1064431-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This implements the AES64ES instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/crypto_helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
index 2ef30281b1..82d7f3a060 100644
--- a/target/riscv/crypto_helper.c
+++ b/target/riscv/crypto_helper.c
@@ -22,6 +22,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
+#include "crypto/aes-round.h"
 #include "crypto/sm4.h"
 
 #define AES_XTIME(a) \
@@ -200,7 +201,12 @@ target_ulong HELPER(aes64esm)(target_ulong rs1, target_ulong rs2)
 
 target_ulong HELPER(aes64es)(target_ulong rs1, target_ulong rs2)
 {
-    return aes64_operation(rs1, rs2, true, false);
+    AESState t;
+
+    t.d[HOST_BIG_ENDIAN] = rs1;
+    t.d[!HOST_BIG_ENDIAN] = rs2;
+    aesenc_SB_SR(&t, &t, false);
+    return t.d[HOST_BIG_ENDIAN];
 }
 
 target_ulong HELPER(aes64ds)(target_ulong rs1, target_ulong rs2)
-- 
2.34.1


