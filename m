Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C937C8C98
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:51:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrMJq-0001JV-1r; Fri, 13 Oct 2023 13:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrMJn-0001JC-OA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:51:24 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrMJf-0004kI-MA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:51:22 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6934202b8bdso1937832b3a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697219474; x=1697824274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cU5uBjJU4biukj4ZunYLK2l6Fz6TmkGOVRzFIJRrWC0=;
 b=dOWLjKnQuF0PmgZ9MSzjEmjQ9UnG4hTAo+vd+B6sI8Syl9gZW4NZi+QBYCTvwFTCwA
 Jp0S+xiaanf2aSdmEyKelsQbL3b03NqCt4HNI3oYc+5Xm6IOdz2FtMgqTGYseg1WGDCX
 DmHBj7n4VbYCImeqMWTUHsnEKPM/GbmXvwqP17YwRCwA2YgKXXHi7uH4ZApgVwbvKZ8s
 VcsXXTHqtN22GG1vdN07I8sw9kz6R/+nws0Afen3R8TSFNU1C1jm/lDSOlMgKBDLF5rn
 uEn2mbz4nKskVdAMwMIHpX2l8+7aZsMR0VrySDE/WmQuGl6BLGkdv8Bs99a2Qy3sARdZ
 cd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697219474; x=1697824274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cU5uBjJU4biukj4ZunYLK2l6Fz6TmkGOVRzFIJRrWC0=;
 b=WikDnlEUlzT2+f6bmrC79QLRNq6WYl/NU8Mudkgh4KV/DCItHumzc4ftVP8lmmoAR2
 zeqcPEuV/HBdZfEAfNsUza/7SCh+gBN9pkl5bxjA+WFE3CP/qxu2dqA7TLSpLz6irq26
 +OijmCUPyg5wpPrM8ID0HjuraNJCzi+ZKzkKK8JgMdqAssFQrzXdqUVLbeTHhfvUYLwO
 Jpqu1D65jLpbfMpNLu+hfLprjOCXK2Ea6ptNen27hcYbTJUDMfwnjkAv+zScH/k5jgAF
 So918jkmk2GgFlBF9CuAvm2HmSn+mm1TbXDq8RIpbyX3i1naQwbUoGBr/BydwiIat2ff
 Ug5Q==
X-Gm-Message-State: AOJu0Ywh466YkmokvPO7lx3+uPPEb+TiLPin1OFi7Or14ZNsL0yOMBou
 zPwvpR7siBCWuY7KGv9xuqvB/TCvKOBnR8Nc4XQ=
X-Google-Smtp-Source: AGHT+IG5Dcw5/sii87kopHtFPJt+FPNQObs/K+1rU+R2IdUtLNr4pkTf0qjoaUijY/zMbs9H5OWmgA==
X-Received: by 2002:a05:6a21:3398:b0:169:3eee:624b with SMTP id
 yy24-20020a056a21339800b001693eee624bmr30130246pzb.27.1697219473817; 
 Fri, 13 Oct 2023 10:51:13 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h24-20020a170902ac9800b001c3be750900sm4164324plr.163.2023.10.13.10.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 10:51:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 1/2] tcg: Add tcg_gen_{ld,st}_i128
Date: Fri, 13 Oct 2023 10:51:08 -0700
Message-Id: <20231013175109.124308-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013175109.124308-1-richard.henderson@linaro.org>
References: <20231013175109.124308-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Do not require the translators to jump through concat and
extract of i64 in order to move values to and from  env.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  3 +++
 tcg/tcg-op.c                | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2048f92b5e..56d4e9cb9f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -747,6 +747,9 @@ void tcg_gen_mov_i128(TCGv_i128 dst, TCGv_i128 src);
 void tcg_gen_extr_i128_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i128 arg);
 void tcg_gen_concat_i64_i128(TCGv_i128 ret, TCGv_i64 lo, TCGv_i64 hi);
 
+void tcg_gen_ld_i128(TCGv_i128 ret, TCGv_ptr base, tcg_target_long offset);
+void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset);
+
 static inline void tcg_gen_concat32_i64(TCGv_i64 ret, TCGv_i64 lo, TCGv_i64 hi)
 {
     tcg_gen_deposit_i64(ret, lo, hi, 32, 32);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 393dbcd01c..12bcedf42f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2880,6 +2880,28 @@ void tcg_gen_mov_i128(TCGv_i128 dst, TCGv_i128 src)
     }
 }
 
+void tcg_gen_ld_i128(TCGv_i128 ret, TCGv_ptr base, tcg_target_long offset)
+{
+    if (HOST_BIG_ENDIAN) {
+        tcg_gen_ld_i64(TCGV128_HIGH(ret), base, offset);
+        tcg_gen_ld_i64(TCGV128_LOW(ret), base, offset + 8);
+    } else {
+        tcg_gen_ld_i64(TCGV128_LOW(ret), base, offset);
+        tcg_gen_ld_i64(TCGV128_HIGH(ret), base, offset + 8);
+    }
+}
+
+void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset)
+{
+    if (HOST_BIG_ENDIAN) {
+        tcg_gen_st_i64(TCGV128_HIGH(val), base, offset);
+        tcg_gen_st_i64(TCGV128_LOW(val), base, offset + 8);
+    } else {
+        tcg_gen_st_i64(TCGV128_LOW(val), base, offset);
+        tcg_gen_st_i64(TCGV128_HIGH(val), base, offset + 8);
+    }
+}
+
 /* QEMU specific operations.  */
 
 void tcg_gen_exit_tb(const TranslationBlock *tb, unsigned idx)
-- 
2.34.1


