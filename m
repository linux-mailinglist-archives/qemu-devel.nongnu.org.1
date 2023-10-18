Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 857147CEB34
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:28:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzk-0008D0-4K; Wed, 18 Oct 2023 18:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzh-0008BU-DZ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:25 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzf-0002WV-Aj
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:25 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c9e06f058bso1358215ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667982; x=1698272782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F3d0+LIJRpydd1LcLJpx5zgMPpG2uno1kweVdtXY0oQ=;
 b=V9j2CPX8y1qTP9+kc3qjZnEwVesDCi2WV/Wf0XZjas5Te6bhUCkwWFrpAXeV5/ZMGK
 UGDwF6nfcW+H69IJbGSS4CIfiobkr/IYPntGEVi1tNg2SRYAWAr7RjlzzQTA+XW/Tsy/
 jq5G04LeQcCDPTq1N1D7eD+bpbT4P3Doztbos1FZoUx5hWU+N7uAyrTFVw0YRkugHdtC
 NALKDSZy6MrIGYWlVrK2jaHE11XLsofSC//KpmOzBWdne7JVlZPjKXDq2o9esPP9lrts
 ZanlThS1mhgdlf+PURJDCbZWv0pxxGHx52my/ga1hBWeOl/uiLWk0tF9cljHl0D5XQOo
 Vkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667982; x=1698272782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F3d0+LIJRpydd1LcLJpx5zgMPpG2uno1kweVdtXY0oQ=;
 b=hIluTfshbSZM1fsYZuLgnzPkNaRkxV2gsJlo3l17DcHZ/rbNfJ2kJso6XASmBFask3
 +/RDo+QY3PvqXCOzeBRLHnw9B5a8hnkrMS90e2Wotk1WOAoWF8Inu6uFHeLtxxwVFzT6
 bEwrYIl7Xc9HgSkTAPT7/YW2C2CKuftuf9coSReHmA1xybZAzw4nQzFNRr3yHJWLqDf9
 eoLCw/hPMU1MO29zeCFEUErax0GLnN6cEVpHfjrQ01zIJ0Wk731qYtxCd/wEmqL97s9W
 ukH/xyHiksOMNIS93VknwYPiv73zbZAxNYKSmyiUO6sbiIZjRiIbi1o5A8tsCfT8Ootn
 tpxw==
X-Gm-Message-State: AOJu0YyJV64MAianTwiY2lTyccm8YqQGQzq+rbqCv10eSxEt3aCJEwEF
 dZ+ypgaVtLAYKUvUJ3hdF0pk09olgj0GiDCDqSQ=
X-Google-Smtp-Source: AGHT+IFRbtWzNZFOhMNB8KIyUMIR11fXYNh57meFmb5Of2MVWRtsR0tYKJ6s0ptLpjl1BKA3faQDgA==
X-Received: by 2002:a17:903:2288:b0:1c5:9d00:be84 with SMTP id
 b8-20020a170903228800b001c59d00be84mr208479plh.33.1697667982131; 
 Wed, 18 Oct 2023 15:26:22 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/29] tcg: Use constant zero when expanding with divu2
Date: Wed, 18 Oct 2023 15:25:54 -0700
Message-Id: <20231018222557.1562065-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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


