Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 652897E878F
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 02:33:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1crK-000250-I0; Fri, 10 Nov 2023 20:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1crH-00023U-Rz
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:32:23 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1crF-0001ae-VP
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:32:23 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1f0820b7657so1390078fac.2
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 17:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699666340; x=1700271140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2kSN1vwwoam6WYJg09g7VctKW2Wmzq5YomKQb4mTBU=;
 b=xk2BMSx6/WLlLqNsx0nfOmzyAZm4eQYnmZBw9GjME2c7pHWkebzOX9HEXgWCpdRhXA
 c9lsoKlp0KLsT0iVePydpotymV028jhAP2j65RcovBDRVPHAFmUX4E1vJ4iXrhSHLgos
 BhLBdOiNSlfb4abzZs74NSzF0cMNgekX6liHNhgyYaPSkJN3bhvHSv5S1UkbG43JRbBh
 aZv1cIXnCbMor+HEM5uvawhX5YHMhhR68qj4kwH/QVHvlykCb/QruaXxsU/t4Rqh78Uj
 bQlAcV582LaIsqGOjHwultyZOYRe6HMwGdPQq94oLOvHJLjRUmIzI+VKz24U26TX28d/
 q7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699666340; x=1700271140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2kSN1vwwoam6WYJg09g7VctKW2Wmzq5YomKQb4mTBU=;
 b=OuS7dh16YDMHHVumMi5aU1V1D+f8m96wd9JLmSwLz+AB9fswO1kpwj5G+eBGWDJe2l
 Ndv/Du5PWuG7R1Zb2aH7CVBR1fUuWjji5XT10Dh65OnQxRbbmCw09XtR5HsfQg0FrSly
 gJhCweNbNkmJg9jRA34FoPsftjN2XiEZU3pd3F0iejkJMBZU7RnebVRunx3Gm/SpuFIr
 L8kwalu4lbEObLec2Z+WYIvXedd3g7JLbWo1U+ubUU41eeOMZkCrXG+mjkfb4Sms/Pd5
 KQ828n5MIQdCLrA2/Gez1sMgS+jFpNc/e4bS+Dhoe+llUuCdiqYoIIafMkcOPswBQaUD
 l0pA==
X-Gm-Message-State: AOJu0YzaV4Ah7n5mjJJ+q/frAa8nVpqIfxz3JcRIlFVfDEXwdNrAz5X3
 Yv0pLOZ6jENhzsQ+AgW8G/UQkVwXRgAFCPPDfkA=
X-Google-Smtp-Source: AGHT+IEQx04KA62FmVJble2/XXh5H/iLxsPUF4dKXdakuy54p7UEe0y79X9F4fhDlTXv/BGOgC2G5A==
X-Received: by 2002:a05:6870:1ec5:b0:1eb:192b:e75b with SMTP id
 pc5-20020a0568701ec500b001eb192be75bmr1285891oab.40.1699666340354; 
 Fri, 10 Nov 2023 17:32:20 -0800 (PST)
Received: from stoup.hsd1.or.comcast.net
 ([2601:1c0:5e02:2a20:a99c:45a6:14e9:ea6])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a62f20b000000b006c1221bc58bsm333502pfh.115.2023.11.10.17.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 17:32:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 04/11] target/hppa: Use only low 2 immediate bits for PROBEI
Date: Fri, 10 Nov 2023 17:32:05 -0800
Message-Id: <20231111013212.229673-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111013212.229673-1-richard.henderson@linaro.org>
References: <20231111013212.229673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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

During the conversion to decodetree, the 2-bit mask was lost.

Fixes: deee69a19fd ("target/hppa: Convert memory management insns")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index f3b17ba16d..bb1b65fef0 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2297,7 +2297,7 @@ static bool trans_probe(DisasContext *ctx, arg_probe *a)
     form_gva(ctx, &addr, &ofs, a->b, 0, 0, 0, a->sp, 0, false);
 
     if (a->imm) {
-        level = tcg_constant_i32(a->ri);
+        level = tcg_constant_i32(a->ri & 3);
     } else {
         level = tcg_temp_new_i32();
         tcg_gen_extrl_i64_i32(level, load_gpr(ctx, a->ri));
-- 
2.34.1


