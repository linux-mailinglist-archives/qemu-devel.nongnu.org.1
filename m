Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5957728DEB
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 04:28:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7RpF-0005or-8r; Thu, 08 Jun 2023 22:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7RoE-00034p-Tx
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:25:04 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7Rng-0005kP-7u
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:25:02 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-655d1fc8ad8so1068905b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 19:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686277467; x=1688869467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D0I8unuNO+OjgsLA/5Ao4N4ndudI6wjx6PBNe+Du5WM=;
 b=Ich6EZwRkdpG8fEHOiDbeIHJTpvbXVwajTCODoplBZdnYuGe7aoOhI8ZuRvaYZl6Mq
 xEmZNWdG7jttOLj7+MIzkWQUXs3+3xioqvSy5v9lHYZOVe1fMa/Q650esYtaXHtNgAHC
 z0fZhhJ3IBjofSYLmqrma/gA9PMV6KXunil7lbc/UETmraSwryzhTpIQM7OEAk/or+sR
 n7i8HRuAHeMW2iQAuobdpbrtDQ3IjsqY/4oUPczGgFNo6kB/tWeSKR5VBo5LfCUcUw8Z
 teGi0JtFS1DxtGY844Ry5EQYkO2vhafrm3sI6L/HXWJ/ZdCsF2oKSoGnoq3kB8Z5Zk6I
 oIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686277467; x=1688869467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D0I8unuNO+OjgsLA/5Ao4N4ndudI6wjx6PBNe+Du5WM=;
 b=TMxMW8rrtT3VK1F8MFrxbW+n0fmBBd6lTJGVgpjR8lQc6W+DZSnnNvJj8gd5QOJygh
 FCYtmVOBfiL6aQGX8WLHf43Eqgul0eJRigb7uXe4HFbiANCcqmCeKYpgm6l0G3jo8/5m
 s6LHOwrw0nhjsPAuiVKquRRtUEZI3nQHweKzqyqZ8Jmy0q79EzktNYblRKFrZzjgBGOh
 R4e/0oJe1jXlLslkYS8oWfpCWPYbssiW0DzJfgYpfxY6eTx/VlsJsApJ1Mg1V+hJLR5d
 PRzV4Py8fio8zggob05+QjUjh3mI1agWtEsc+NxkXlTzj3RYzX8K1eIr0mpXQejrx3OI
 qStQ==
X-Gm-Message-State: AC+VfDz5DK6XufTxmYJQoR3YbN3lnnTytkJcW6fRf+a/RZGXN24PngZ4
 FxCriomPYZNZqKuC/cQ8F3MkWXVaTRU+hNdk4Vw=
X-Google-Smtp-Source: ACHHUZ5Ml9JKQ1sjqlY1Bf7IAZBSfQKrPed5TLOxgdybm2zUDcrUJ4szrbZsdl/YutN/QVVHEfjoDA==
X-Received: by 2002:a05:6a00:23c2:b0:647:e45f:1a4c with SMTP id
 g2-20020a056a0023c200b00647e45f1a4cmr36484pfc.11.1686277466951; 
 Thu, 08 Jun 2023 19:24:26 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:b071:df63:5761:f449])
 by smtp.gmail.com with ESMTPSA id
 x25-20020a62fb19000000b0063afb08afeesm1686458pfm.67.2023.06.08.19.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 19:24:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH v2 26/38] target/riscv: Use aesenc_SB_SR_MC_AK
Date: Thu,  8 Jun 2023 19:23:49 -0700
Message-Id: <20230609022401.684157-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609022401.684157-1-richard.henderson@linaro.org>
References: <20230609022401.684157-1-richard.henderson@linaro.org>
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

This implements the AES64ESM instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/crypto_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
index 505166ce5a..c036fe8632 100644
--- a/target/riscv/crypto_helper.c
+++ b/target/riscv/crypto_helper.c
@@ -198,7 +198,12 @@ static inline target_ulong aes64_operation(target_ulong rs1, target_ulong rs2,
 
 target_ulong HELPER(aes64esm)(target_ulong rs1, target_ulong rs2)
 {
-    return aes64_operation(rs1, rs2, true, true);
+    AESState t;
+
+    t.d[HOST_BIG_ENDIAN] = rs1;
+    t.d[!HOST_BIG_ENDIAN] = rs2;
+    aesenc_SB_SR_MC_AK(&t, &t, &aes_zero, false);
+    return t.d[HOST_BIG_ENDIAN];
 }
 
 target_ulong HELPER(aes64es)(target_ulong rs1, target_ulong rs2)
-- 
2.34.1


