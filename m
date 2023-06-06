Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EC97249FC
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 19:17:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6aIO-0006aj-33; Tue, 06 Jun 2023 13:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6aIL-0006Vz-Ri
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 13:16:33 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6aIK-0008Dd-90
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 13:16:33 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6537d2a8c20so2997000b3a.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686071791; x=1688663791;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lHEChm4frbPH7coBKbTXY9kQlG4XX744+VMt8p1duic=;
 b=s2HGw3G9qzuCc4B5BTPbYSivNP8WVCmvT+0wLQTN1SUmmAq4UBmOiqUgcXf9us2k9o
 M7aVEXBx64OIFvlfAGZa0GKNyMapJrYWnE+NHeBnUvSc5/i6f/3OUXfvP1MT0liomzMR
 hsbYMxiemAsIdBDN9dV5+swuvdTHBm21X4oggs3aibyKroGZdtMwoKEKm2msc2JJq1DB
 FM5D4a3BdFDFZTQ/aXiWsAVNeygE9tgx4eTmJ8KS+ei+MNZ4D/QepZQZRBORrVvjyA1j
 yt/MrNIqwDzq9ykMP52LxMJ2oWtY9gaFKUqSoPd6IyORGTKRQEpq+ofx9KBHRP6gIS0W
 5+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686071791; x=1688663791;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lHEChm4frbPH7coBKbTXY9kQlG4XX744+VMt8p1duic=;
 b=DWNhu9bpHQ9q3jri4ndXenATae7VmvjAcQ5QbCRWsSz4fbvVzGA7wkxZNNLfc2fM7q
 Q8YJBBF7VKOmDcCM02OkJC9PNkshv2igrcuW6N23mNRn1B0JJfoPnEzNxhIsyuDMtZzE
 /OF/1ODLjMeSyRZ8Xvtoo+WZergAsSTDCWIXcK1+cxyn3lmpOr0arHuq+dl5R3w5BHG7
 PYVoG01qtp2tVo/eccGLEDsawrIVseB8847D2cVRpzC7lnvprgyGV5R1fKAuMDV+dM2X
 eG8mEND998BbgtNfmgEJxu3xUwnQXo3nwVq84TJUam4WYhV6F8k8OStsAu8EyIcb+pW5
 l8FQ==
X-Gm-Message-State: AC+VfDz8cEJ59whCtkky6dcBLRLNDeWCH2jpf75wjhEI8vnAGKGkNHTY
 B9Um330qyJQ1tcYmAlfCmp98NztkNZFRpQKl9es=
X-Google-Smtp-Source: ACHHUZ71GnqKS5NDdJv/WIVn0ozDksUUS9WryEhSX16KWeYkT53nKkhd2xp52yej+2CsphEEQvrVhw==
X-Received: by 2002:a05:6a20:841e:b0:10b:dca4:8a3b with SMTP id
 c30-20020a056a20841e00b0010bdca48a3bmr294820pzd.31.1686071790893; 
 Tue, 06 Jun 2023 10:16:30 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 jk19-20020a170903331300b001b0aec3ed59sm8765704plb.256.2023.06.06.10.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 10:16:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH] accel/tcg: Fix undefined shift in store_whole_le16
Date: Tue,  6 Jun 2023 10:16:29 -0700
Message-Id: <20230606171629.98157-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

The computation is documented as unused in this case,
but triggers an ubsan error:

../accel/tcg/ldst_atomicity.c.inc:837:33: runtime error: shift exponent -32 is negative
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../accel/tcg/ldst_atomicity.c.inc:837:33 in

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Hi Peter.  Found this while merge testing FEAT_LSE.
Clearly my bug, which I ought to have found earlier.


r~

---
 accel/tcg/ldst_atomicity.c.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index 2514899408..de70531a7a 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -833,7 +833,9 @@ static uint64_t store_whole_le16(void *pv, int size, Int128 val_le)
     }
     store_atom_insert_al16(pv - o, v, m);
 
-    /* Unused if sz <= 64. */
+    if (sz <= 64) {
+        return 0;
+    }
     return int128_gethi(val_le) >> (sz - 64);
 }
 
-- 
2.34.1


