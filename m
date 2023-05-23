Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D07A670E9F4
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 02:03:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1bu8-0004Ou-95; Tue, 23 May 2023 19:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btl-0004J5-Cw
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:37 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btc-0001rp-Dr
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:37 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d5b4c3ffeso102462b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886307; x=1687478307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dmtEq6kmVE3RGdrdH/eSfhix7HRQOKB/pXZ4u4czNE=;
 b=dxMp/su4auZGrrxiQBjq4afhP5rhz+Jao3vaoth+fd3PI9eQcjfG9m4Ug3yCYLw7Qc
 EKoQC/Q/oSIWDLMm8BlgSv/SM5RyV0n8sn2McfQwzkFg+xusYIout824De4/wEtyGuNt
 f/uvfMpmgbvgNpTtT+Vw0BLeiZTEYolc4SL01V7/En1PQx6nw5D8vyC884vGBLp5CPeL
 kgaGHSxMGJValIS9hHgFRLsMXL4HHgRrlxx1I6sQDHSOWgRPu+dJ+ewEDlV1J0ieddxM
 z0FoZ+7oNb/JyIlugY/GaB/xBQ/+olevL/+nJIIN/W99mJaeqeOg4taD/kvV0tnrpfay
 YHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886307; x=1687478307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3dmtEq6kmVE3RGdrdH/eSfhix7HRQOKB/pXZ4u4czNE=;
 b=hW9xuQa4UUNIOOmbgpLksTni7heLcwmjWBhzfvyms4tpG7TQKPV6A8Im5nk57npMVY
 Auq0WGRzrxyajA1weKefURbWfA6Os977eK7IM1iOablN8l521IKKe3jXYDmwN2UYtmIc
 eWTkSIvWQo75JKTMCIC4nj0EHw9eRKPL5Ry8RcMS1zhpPvrbozZ2Op3bzXhRl5663At0
 gEtxkQHyXgcjYZu91Kx65ftQIiKuxuhcMBH0LApMaZop+P+polzEm6o2QSlvfmzHxdYS
 C94vcMW6SUoVLiQIOYargXL/Fddxx2YiY98Vk3bA4L/6JBadZTZtnfRvwHnV79NFqCRH
 esJg==
X-Gm-Message-State: AC+VfDwVq7Z7K1B33utDRvjf+BB54HkzAGDFuShi/R1+v9dxtoiGaUwB
 iZ/MP0kgW23UY54hCHTE6nzulQuXqdP8VUuvorM=
X-Google-Smtp-Source: ACHHUZ7ycotBLApiLL+wOf7czpkQrFmjVqximqsTWdw8mSiK7Y0bLsIMPBBTOXbccyVy9fE6w2dEJg==
X-Received: by 2002:a05:6a00:2d13:b0:64c:b45f:fc86 with SMTP id
 fa19-20020a056a002d1300b0064cb45ffc86mr746573pfb.17.1684886307248; 
 Tue, 23 May 2023 16:58:27 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 25/28] qemu/atomic128: Improve cmpxchg fallback for atomic16_set
Date: Tue, 23 May 2023 16:58:01 -0700
Message-Id: <20230523235804.747803-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523235804.747803-1-richard.henderson@linaro.org>
References: <20230523235804.747803-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Use __sync_bool_compare_and_swap_16 to control the loop,
rather than a separate comparison.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/atomic128-ldst.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/host/include/generic/host/atomic128-ldst.h b/host/include/generic/host/atomic128-ldst.h
index 79d208b7a4..80fff0643a 100644
--- a/host/include/generic/host/atomic128-ldst.h
+++ b/host/include/generic/host/atomic128-ldst.h
@@ -58,11 +58,14 @@ atomic16_read_rw(Int128 *ptr)
 static inline void ATTRIBUTE_ATOMIC128_OPT
 atomic16_set(Int128 *ptr, Int128 val)
 {
-    Int128 old = *ptr, cmp;
+    __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
+    __int128_t old;
+    Int128Alias new;
+
+    new.s = val;
     do {
-        cmp = old;
-        old = atomic16_cmpxchg(ptr, cmp, val);
-    } while (int128_ne(old, cmp));
+        old = *ptr_align;
+    } while (!__sync_bool_compare_and_swap_16(ptr_align, old, new.i));
 }
 
 #else
-- 
2.34.1


