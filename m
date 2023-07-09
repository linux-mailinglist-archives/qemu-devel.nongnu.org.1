Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3B074C489
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:02:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxv-0000ve-JO; Sun, 09 Jul 2023 10:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxY-0000Tf-UZ
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:23 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxW-0000ef-6B
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:20 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3142970df44so3380040f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 07:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911214; x=1691503214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=muoNLx2OrRgCzPDttQEHoOl2grqT5w0p62Pb+0kehUU=;
 b=LpwQbET2QueCCB9bLH6Mpj1qA3yIApEX6mQ61Jd3c4ViJXtkaMxwo53UU8FoKy3y5d
 ifi7WIWDkRMDUvGBxJ4vCqYr+y35SdkSIi5pLUMXUtbdKOgeSSPN1MNMugYtc9QmHdXZ
 mCNzA5EhfjIp3w8KvS8FJdsJB/rHcgvnDcf/4E5X1wU36depjUtBFVoo3Lioodgxhngu
 yUZSbKIpwfCL8oJpCW2mpFFn9CPOTcVxCmtp5o9qM3l7eetrOU4LCWM+8mSICBRiQ94y
 8Nb6nx/yZqDoPu23S6dmGw5Z6t+rC7wMNw1xos9VWW9GoTZ5oquUaXw41wXd4CQtfcIJ
 cYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911214; x=1691503214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=muoNLx2OrRgCzPDttQEHoOl2grqT5w0p62Pb+0kehUU=;
 b=SHJLeGZCEKVRtBrpQuPZCePSfq4yszHrArAUcUc50O9wMbSaWwuJYvLqTnuZG5fh7r
 f6Q7wAJgdfxz3ikCO+ogIFbaGu4LvNelDjyA4KtDXRUQGOIEdri0GXP75DBRKJw7PJJL
 Gy6Trrq6P5T/SKJWLw+JJJQzDD/m80K6FNQHTuxPVhQAXz3NjY1Pcw06ilQDsbekA6G+
 wtHK/jqe/gfEExE+CgHN1b4uJNz/426gdBXDC8JjBbHPW27y6RzYxq9Dd2HHJOTVNAXe
 Z0z31O8GsKDpg48vIOZH/7XblOMUczAK0PSQ/2Qx0BOOwGbdMbWt/W+cFTMS+TwkN2cc
 PThA==
X-Gm-Message-State: ABy/qLYqFYQdNnXAlNTg7QpoWkV6GoIh5CFyDKlR2S+5g/iL+ZE9jWc4
 0BqGurLbySmbVVdZp/Y1KM8lZ/mPo+AAZx9fXnRBuQ==
X-Google-Smtp-Source: APBJJlHaPOy85gaPuogoq5W7bP+j2zARB0ks9aAjQQHak7hOAaQpwjBl5Bi/zSWHG7XPjUrGkvpEoQ==
X-Received: by 2002:a5d:5911:0:b0:315:8fc0:9155 with SMTP id
 v17-20020a5d5911000000b003158fc09155mr3235875wrd.44.1688911213927; 
 Sun, 09 Jul 2023 07:00:13 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.07.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 07:00:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/37] target/riscv: Use aesdec_IMC
Date: Sun,  9 Jul 2023 14:59:39 +0100
Message-Id: <20230709135945.250311-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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

This implements the AES64IM instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/crypto_helper.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
index e61f7fe1e5..505166ce5a 100644
--- a/target/riscv/crypto_helper.c
+++ b/target/riscv/crypto_helper.c
@@ -272,17 +272,12 @@ target_ulong HELPER(aes64ks1i)(target_ulong rs1, target_ulong rnum)
 
 target_ulong HELPER(aes64im)(target_ulong rs1)
 {
-    uint64_t RS1 = rs1;
-    uint32_t col_0 = RS1 & 0xFFFFFFFF;
-    uint32_t col_1 = RS1 >> 32;
-    target_ulong result;
+    AESState t;
 
-    col_0 = AES_INVMIXCOLUMN(col_0);
-    col_1 = AES_INVMIXCOLUMN(col_1);
-
-    result = ((uint64_t)col_1 << 32) | col_0;
-
-    return result;
+    t.d[HOST_BIG_ENDIAN] = rs1;
+    t.d[!HOST_BIG_ENDIAN] = 0;
+    aesdec_IMC(&t, &t, false);
+    return t.d[HOST_BIG_ENDIAN];
 }
 
 target_ulong HELPER(sm4ed)(target_ulong rs1, target_ulong rs2,
-- 
2.34.1


