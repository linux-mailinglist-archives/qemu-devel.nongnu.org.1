Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 089FB786C14
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:34:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6eu-0008GF-OT; Thu, 24 Aug 2023 05:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eE-0004WZ-Hu
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:02 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e9-00052c-MP
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:02 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40061928e5aso11356115e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869335; x=1693474135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kf9yPg8uZfo9VqqhLVaMYdusDTk1ucSU7Tw3bTGKmGA=;
 b=uTn++InkXrsFkIq+qczpIaQ/r+S58a0KIbvGBsRkOGrlifp8izx4+y3YkryHa6DNxc
 cM1hFfNvS9/1mUQeFSriSIHXo+Pp5euUpg7D8WINJzW7LukbNZpJo1c4apx6bvhhPzLC
 +dlw7cubL9xRs3JLb1wgdsBhJzPLa0iRA6bcyzI4Ww1k3cOT9mR99mJmsvJCN61bGHlN
 9O5RM1uGktt7F7ZIKfu1RCpVQRPYUqBRXcNe2sypXs+GTAmjBbESd30ZxxdYDcJOHvo6
 qY0zC70P7Z0vv/txwSytXOF/qkUtFzdDn+RxRpbJYb9N0kZ8/7VPBXFdtNjP+3LJDi4e
 ms2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869335; x=1693474135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kf9yPg8uZfo9VqqhLVaMYdusDTk1ucSU7Tw3bTGKmGA=;
 b=gZk7F6Ov022CLs66F5ZTiJmBjvpgRB14elcCLn4KYETKtrNg+v4rNNRj9G3B29hKox
 4yr5ckPwxsaG5VQHaHHtAzjfdL5D4EMZsy5V9Pl/ZkWIfyzYDbw9MGFxGLyxz6pXD15P
 rtYFzz+FqQUn1Pno6U7lR0Dxk8c9cw4TLBOnx5/5RCOxEwUJqictgfRD0lGqX9vSprV4
 4H+kfxh0/LPzlF95OMyMOW5uY0SgIRIK+RpszdEOu9pu2ViHbCbR3jCcPGI5FM2mXIV9
 SJaVTvHwEtcgEWomA7kOrRKvYMRgnSP006jsEJXhp6yGOkReJKG9zR37tVYs6qCMv468
 dHTA==
X-Gm-Message-State: AOJu0YwJA32mtvCmL95MRgvPaKhJ+t5UtsYrizuhc6d/tTQAwnJ8zKxQ
 Q6olnz0cMqQ+J3aXPReDD0oH3qFTUR8THa4S9ks=
X-Google-Smtp-Source: AGHT+IEeKUSBZTkK6J5L+Y8Km4frBQCL5/xrb8nlDbST+yBkfUeHsCF/wTyJPWZP+aAMHOP2VlGiog==
X-Received: by 2002:a7b:c408:0:b0:401:aa8f:7565 with SMTP id
 k8-20020a7bc408000000b00401aa8f7565mr587689wmi.34.1692869334923; 
 Thu, 24 Aug 2023 02:28:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/35] target/arm: Fix 64-bit SSRA
Date: Thu, 24 Aug 2023 10:28:36 +0100
Message-Id: <20230824092836.2239644-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Typo applied byte-wise shift instead of double-word shift.

Cc: qemu-stable@nongnu.org
Fixes: 631e565450c ("target/arm: Create gen_gvec_[us]sra")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1737
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230821022025.397682-1-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index b71ac2d0d53..39541ecdf0a 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3053,7 +3053,7 @@ void gen_gvec_ssra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
           .vece = MO_32 },
         { .fni8 = gen_ssra64_i64,
           .fniv = gen_ssra_vec,
-          .fno = gen_helper_gvec_ssra_b,
+          .fno = gen_helper_gvec_ssra_d,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .opt_opc = vecop_list,
           .load_dest = true,
-- 
2.34.1


