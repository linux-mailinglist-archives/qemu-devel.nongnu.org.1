Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC41711B16
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 02:25:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2LFB-0002Vl-A8; Thu, 25 May 2023 20:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LF7-0002UR-AB
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:41 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LF3-00028L-K8
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:40 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-25376483f66so240999a91.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 17:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685060616; x=1687652616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6cJbzSvYvQOTGDtz8/CCuAgm74mnMDf42v4W8C12Tg=;
 b=bjI4a7DZKzaLg63y9jmQ1vqRt/PVvjdAvq1V3UUxVgb8h1HorQmQl0fKN2e69v+QwM
 CW2azV3Zz6wHhwXWL5julyJ1uo5u98IWahjqcjlr7pbcQKNfTvfgTAV5vDp3fqQPT8cU
 Il8aHv5juxFNOkN8Cz/74kcUMHFSLvUgaMuxpBelbqPVqf2qQqcX7rRddw9PZXR/947E
 Iu4R7jikTOHbkthUSbp5MCfiPHpWgbsIliqrkF2Ph4x/q9VnZOXJg5hyO2lgr4mwmkFQ
 kswjhWLNykBwkRrotYQw/bl1wsNxt1+ACkCi13Sk3GaKAc3TS0+6jc8BoAc1n2+g6y6s
 oN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685060616; x=1687652616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o6cJbzSvYvQOTGDtz8/CCuAgm74mnMDf42v4W8C12Tg=;
 b=At7ic463ox8uRVY0Oc8Gn/kudKQ1iE2y/jvlJwc2GwDl9eChuJ2VIVqALknaoPymKa
 DKPg+Gq0vzv+A9jYHXSot37cY0DNRRgZau1xaTIEai0/fL0UUqutHWPv7oP6ngO7CUVj
 /9Hrj4LeXlrlTB5y/Bbaa8cShf196nHxAmb/IC7W9xnlCh720st6N6UfbEjOrY2sNtWx
 dDyadqyzOmkb/BEWneKvYofnuhFHlHd8pY1rWo+I3Hqt7Fpkded8Ib8Q3/YhX+VgQOnp
 aYYze61doFksrKwaZcd1l5EVb3bvCVdZf+nRPxfU6utOk55LFlv1xZlNq6AKJl0c5BWP
 0RyQ==
X-Gm-Message-State: AC+VfDwl0gb7uXhGypsdZKy7fvphnSGFGKYXkCpQMojOwx2sHemc1SsG
 87bA7FzdIV3xfhaaZTGq/Vc//h/8l9rG7ShXLMA=
X-Google-Smtp-Source: ACHHUZ6K4o1b2w4TYW6flQicGJQodZNNCdqynA0EPKTPBEbxMe2BYenSzcRhLpREkLPLUDUSQ+/oHQ==
X-Received: by 2002:a17:90a:f996:b0:250:faff:e201 with SMTP id
 cq22-20020a17090af99600b00250faffe201mr442321pjb.36.1685060616262; 
 Thu, 25 May 2023 17:23:36 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s188-20020a635ec5000000b0053491d92b65sm1675593pgb.84.2023.05.25.17.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 17:23:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 01/16] tcg: Fix register move type in tcg_out_ld_helper_ret
Date: Thu, 25 May 2023 17:23:19 -0700
Message-Id: <20230526002334.1760495-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526002334.1760495-1-richard.henderson@linaro.org>
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

The first move was incorrectly using TCG_TYPE_I32 while the second
move was correctly using TCG_TYPE_REG.  This prevents a 64-bit host
from moving all 128-bits of the return value.

Fixes: ebebea53ef8 ("tcg: Support TCG_TYPE_I128 in tcg_out_{ld,st}_helper_{args,ret}")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index ac30d484f5..2352ca4ade 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -5736,8 +5736,8 @@ static void tcg_out_ld_helper_ret(TCGContext *s, const TCGLabelQemuLdst *ldst,
     mov[0].dst = ldst->datalo_reg;
     mov[0].src =
         tcg_target_call_oarg_reg(TCG_CALL_RET_NORMAL, HOST_BIG_ENDIAN);
-    mov[0].dst_type = TCG_TYPE_I32;
-    mov[0].src_type = TCG_TYPE_I32;
+    mov[0].dst_type = TCG_TYPE_REG;
+    mov[0].src_type = TCG_TYPE_REG;
     mov[0].src_ext = TCG_TARGET_REG_BITS == 32 ? MO_32 : MO_64;
 
     mov[1].dst = ldst->datahi_reg;
-- 
2.34.1


