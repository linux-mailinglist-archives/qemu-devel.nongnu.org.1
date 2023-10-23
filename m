Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4B37D3EC2
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:14:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRR-00068H-Sp; Mon, 23 Oct 2023 14:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzR9-0005ee-Do
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:59 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzR6-0008Gq-Gy
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:59 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1ea05b3f228so2498128fac.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084834; x=1698689634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F3d0+LIJRpydd1LcLJpx5zgMPpG2uno1kweVdtXY0oQ=;
 b=i3/hEYS4StqHfyOejKhQszU42wyhsrnSTofC70BYmA06lGBJL3ChQpFL8+FJw5UELU
 Ap1JH314sTDEs0WNZyEn2z4K3UHIfWAc0XStDw5lF6l+8i9Fr//lxO7amYpTSYymvaBF
 ojYc7D0dlSyXAaReHs14NVpmjpmArxCVUS/Ro2/a/1ayaJYYuQMDS0n83uTz6oWWfyi5
 l8UaAvbEPTuSipLsFA0smfr0Ul4F9tJcrzOLsRPUVo9S/bP96GvIAH6zwcseykmnL/hQ
 1W8vwJ/vtURy/F4mOEPOURnjKtdQONVQB3IyiGE40c+5mYCgBqeWH9JjzTCP3Pizpe0N
 cI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084834; x=1698689634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F3d0+LIJRpydd1LcLJpx5zgMPpG2uno1kweVdtXY0oQ=;
 b=YGQXNDac77J06qJ6jv+dp7WqxdPas12cKufqiVn18dsu7NxOHxA/m8OmKt+HnVq5AN
 4Pio1J9LdMCQnuGONZxsc+5TGul8aJ/1UCCR+pMMmaC2UNzhLvwMwzgLnZdfuPshB07O
 TXEDppxzO90eRWbdxe5kzwFXQbnBi+A+dvaiFb5UgM6jcRr0YM246iKJ5AmTDygEWJ9H
 x7ornkteiie+n60sfGiuB6zRsreSA26WThxs5JRa8ONDZtcWbBGa4RgdZpIWJ0DzpGKq
 3QzBST7GQ42gqWjiKNOpC/DOBX1j/X64L/TNW/J21QyDlm5NCMNfPlodhqz2viIx0KY2
 27gA==
X-Gm-Message-State: AOJu0Yy+JppwhFal9AVITfniskEH6uEtZcSHnDa4ZstUJa5zWNOh94Rg
 +hka3BZw4tCXZYLC1xw8S0VPdgE5Pt1A6Up22wg=
X-Google-Smtp-Source: AGHT+IFyd3zrkKyzoB996cnBrGUDZo4svY0P21EGlaTE7rPO1kvwmKBMiUdKlHlJCJQN2uofhntJZQ==
X-Received: by 2002:a05:6871:3316:b0:1e9:9215:3987 with SMTP id
 nf22-20020a056871331600b001e992153987mr12316627oac.16.1698084833812; 
 Mon, 23 Oct 2023 11:13:53 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 26/38] tcg: Use constant zero when expanding with divu2
Date: Mon, 23 Oct 2023 11:13:17 -0700
Message-Id: <20231023181329.171490-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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
 tcg/tcg-op.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 393dbcd01c..c29355b67b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -342,8 +342,8 @@ void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op3_i32(INDEX_op_divu_i32, ret, arg1, arg2);
     } else if (TCG_TARGET_HAS_div2_i32) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_movi_i32(t0, 0);
-        tcg_gen_op5_i32(INDEX_op_divu2_i32, ret, t0, arg1, t0, arg2);
+        TCGv_i32 zero = tcg_constant_i32(0);
+        tcg_gen_op5_i32(INDEX_op_divu2_i32, ret, t0, arg1, zero, arg2);
         tcg_temp_free_i32(t0);
     } else {
         gen_helper_divu_i32(ret, arg1, arg2);
@@ -362,8 +362,8 @@ void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_temp_free_i32(t0);
     } else if (TCG_TARGET_HAS_div2_i32) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_movi_i32(t0, 0);
-        tcg_gen_op5_i32(INDEX_op_divu2_i32, t0, ret, arg1, t0, arg2);
+        TCGv_i32 zero = tcg_constant_i32(0);
+        tcg_gen_op5_i32(INDEX_op_divu2_i32, t0, ret, arg1, zero, arg2);
         tcg_temp_free_i32(t0);
     } else {
         gen_helper_remu_i32(ret, arg1, arg2);
@@ -1674,8 +1674,8 @@ void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op3_i64(INDEX_op_divu_i64, ret, arg1, arg2);
     } else if (TCG_TARGET_HAS_div2_i64) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_movi_i64(t0, 0);
-        tcg_gen_op5_i64(INDEX_op_divu2_i64, ret, t0, arg1, t0, arg2);
+        TCGv_i64 zero = tcg_constant_i64(0);
+        tcg_gen_op5_i64(INDEX_op_divu2_i64, ret, t0, arg1, zero, arg2);
         tcg_temp_free_i64(t0);
     } else {
         gen_helper_divu_i64(ret, arg1, arg2);
@@ -1694,8 +1694,8 @@ void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_temp_free_i64(t0);
     } else if (TCG_TARGET_HAS_div2_i64) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_movi_i64(t0, 0);
-        tcg_gen_op5_i64(INDEX_op_divu2_i64, t0, ret, arg1, t0, arg2);
+        TCGv_i64 zero = tcg_constant_i64(0);
+        tcg_gen_op5_i64(INDEX_op_divu2_i64, t0, ret, arg1, zero, arg2);
         tcg_temp_free_i64(t0);
     } else {
         gen_helper_remu_i64(ret, arg1, arg2);
-- 
2.34.1


