Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA35736A98
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:13:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZDi-00064p-GI; Tue, 20 Jun 2023 07:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDg-00063U-6j
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:20 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDd-0004G0-2z
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:19 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-988a2715b8cso399557966b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 04:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687259295; x=1689851295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqEpHLv387miC8e5l2/HE3hMgLmxzv9wY41InkeK+gI=;
 b=xQ02urybD0UdA7ZrUaaXUhEzGh88jpXvfJ4bqeLFN+cv/AZTfVvFBgAs40ZbNouhtF
 KruIR5F5pGhxd/+X7ELeBIsCnZekbWQIWH+MK6vlRYYd+KFoOY0QWIhwfw9hTI3k3kJX
 CT/u+U2r5++PyO7JnqukFNrJ7txWYNIEjmVtZmaOjYYA3hG8+pb3o18D4O3P9OLSSdTf
 Tip1zEb0v4Ef5f9LjclgwYq6uw3+CLkivVEDIg8bf5UaMvCU3Vrl21TSBd3QomIP83Px
 Fjzf0Q9M5P95/sYOIflYRL8JF4vB8eUeHo4HEED1TWolihUhJzQd52//UEurhOSgViKE
 lVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687259295; x=1689851295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pqEpHLv387miC8e5l2/HE3hMgLmxzv9wY41InkeK+gI=;
 b=EnUi2qJQrog0f/Bgoej1hv14l3iYQLz6fFDxfI3jBLXM0PNV/62SuWfj5ksw7FiVJQ
 jP+MfSEeT6Lmwvf3NmXWqFyWBjFgda3SrpZKgwZYHujukErdJupdA20x95aQEtUdAYY+
 hsZ502Ih23EsLjPH+3pEwfCFIhlwGvvZnfe2HRDP9KPFiCTXy2JEoHAnILBWvc/VipRu
 av4j2/P8B99zxDNNRTuugezeREvGNTmD9k1hgQ9l+vmhl7bvXWSfXQpUP1rraNOClTAg
 14HxyiO66URBcnLHxkB4SmAYdo/4xG46PdjJBE33UXrPYCg6RQ/kVnrhDJmqN3FPObkT
 YPxA==
X-Gm-Message-State: AC+VfDxUZ9xSISf+/St1SqFXUTzhLkQ8SIKa0GkEGTReZvoXj3J7BcwB
 eFOW+wSYLC9RFqgVgstZYEdfOdNxM5b8/jeQZckbwOKj
X-Google-Smtp-Source: ACHHUZ7JXZ7Se3DAEAfVwLoDrYMqRiiSX8aHj2f1GOPM6p/BpaQmvL60wMwuaTj3kltsKO3yTngltA==
X-Received: by 2002:a17:907:6d25:b0:970:28c:f960 with SMTP id
 sa37-20020a1709076d2500b00970028cf960mr16104251ejc.17.1687259295724; 
 Tue, 20 Jun 2023 04:08:15 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 x17-20020a170906711100b009884f015a44sm1170687ejj.49.2023.06.20.04.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 04:08:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 10/37] target/riscv: Use aesenc_SB_SR_AK
Date: Tue, 20 Jun 2023 13:07:31 +0200
Message-Id: <20230620110758.787479-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620110758.787479-1-richard.henderson@linaro.org>
References: <20230620110758.787479-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x634.google.com
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
 target/riscv/crypto_helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
index 2ef30281b1..b072fed3e2 100644
--- a/target/riscv/crypto_helper.c
+++ b/target/riscv/crypto_helper.c
@@ -22,6 +22,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
+#include "crypto/aes-round.h"
 #include "crypto/sm4.h"
 
 #define AES_XTIME(a) \
@@ -136,6 +137,8 @@ target_ulong HELPER(aes32dsi)(target_ulong rs1, target_ulong rs2,
     AES_INVMIXBYTE(COL, 1, 2, 3, 0) << 8 | \
     AES_INVMIXBYTE(COL, 0, 1, 2, 3) << 0)
 
+static const AESState aes_zero = { };
+
 static inline target_ulong aes64_operation(target_ulong rs1, target_ulong rs2,
                                            bool enc, bool mix)
 {
@@ -200,7 +203,12 @@ target_ulong HELPER(aes64esm)(target_ulong rs1, target_ulong rs2)
 
 target_ulong HELPER(aes64es)(target_ulong rs1, target_ulong rs2)
 {
-    return aes64_operation(rs1, rs2, true, false);
+    AESState t;
+
+    t.d[HOST_BIG_ENDIAN] = rs1;
+    t.d[!HOST_BIG_ENDIAN] = rs2;
+    aesenc_SB_SR_AK(&t, &t, &aes_zero, false);
+    return t.d[HOST_BIG_ENDIAN];
 }
 
 target_ulong HELPER(aes64ds)(target_ulong rs1, target_ulong rs2)
-- 
2.34.1


