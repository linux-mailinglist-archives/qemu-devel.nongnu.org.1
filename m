Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 988337D9BB3
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:41:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0A-0007Do-1y; Fri, 27 Oct 2023 10:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO08-0007Cu-Hb
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:52 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO06-00087k-TD
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:52 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-407da05f05aso16210315e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417588; x=1699022388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ViyXdMoJwR5KQ6odO4W8+Pe+0fluwBTlAfwHWWB/LvM=;
 b=FAwMmTha8FnZqypx+CbrvV/UZscS1CktD0nuh1xGjCCUEV3gXbfnSk91D2OeRYZRWr
 5PkaCuxypRYCo5aItk2NcDUc1m3+QRExslzoEaE5KFrzQyNITtPySlZeXq+x5MF6nfqn
 vE3LN0LP9wCKvroLUnzDr5me1bWzdPpbPhKpplHhmxKg4pLJ8bKypKfEzwEGXUq+UMXI
 jEwmWbhVWCk8WFj6wfKMQBpDepnvUwXQ7enE+gYNvu/0zX9aayukcnbnd+Ye0B1Br75X
 CNW20ZsfBGXnAfqacrDVbAMEOGAAEQhXHLanpga7OF/ytJ8ootR6Ry5eNMZ02yeEa8me
 Cmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417588; x=1699022388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ViyXdMoJwR5KQ6odO4W8+Pe+0fluwBTlAfwHWWB/LvM=;
 b=v8SkQTMCbkOMTqwxco2kyhxIV2aJf3XGCYOpyjQ0wCds8Q8IdQpVBfBZRWa7nXDO5/
 0uqXtBU2oyx3QNYqbiRR2ojvGzSMGszu6KqknsAGA1zXAQbLun4KTJYR6nr3FSkSdFyx
 HORvTHFP98saCMnJGZLLvSmwJZxSfvWZQHlbdDzkdwKK8/arhusa1Pt3UKdiEFYdG3rK
 Ncbqmpkl8iaq/larbfuZQSkFv12IOWuM27Pea3KXdfHJGdbvpCSQT2Nbgvcp2+zWjUsZ
 /U+Ap3xE4/6rCZCYUtsIJNlUlQ+liGqMaP5m6ssjCsi9W/HeD+eQ1NBifdWxp93FGP3D
 74Kg==
X-Gm-Message-State: AOJu0YzR0sevfMIzpZB0LPuWvgbnLiEIsH0jqY1IoqbdjQFKjw8Cqwzx
 Yg5/v/e1/2NLWFsvJgqAey+geHjqRj1JoQ0zwxk=
X-Google-Smtp-Source: AGHT+IFlw8bcnyCfM+zyhx2YDym24hzf/o+/z0w8XSngGeeM6J2knpC9pZ0TNNVk+6SR+4wpfpldxQ==
X-Received: by 2002:a5d:5850:0:b0:32f:71e2:adfb with SMTP id
 i16-20020a5d5850000000b0032f71e2adfbmr1559294wrf.3.1698417588432; 
 Fri, 27 Oct 2023 07:39:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/41] target/arm: Fix syndrome for FGT traps on ERET
Date: Fri, 27 Oct 2023 15:39:10 +0100
Message-Id: <20231027143942.3413881-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

In commit 442c9d682c94fc2 when we converted the ERET, ERETAA, ERETAB
instructions to decodetree, the conversion accidentally lost the
correct setting of the syndrome register when taking a trap because
of the FEAT_FGT HFGITR_EL1.ERET bit.  Instead of reporting a correct
full syndrome value with the EC and IL bits, we only reported the low
two bits of the syndrome, because the call to syn_erettrap() got
dropped.

Fix the syndrome values for these traps by reinstating the
syn_erettrap() calls.

Fixes: 442c9d682c94fc2 ("target/arm: Convert ERET, ERETAA, ERETAB to decodetree")
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231024172438.2990945-1-peter.maydell@linaro.org
---
 target/arm/tcg/translate-a64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ad78b8b1202..41484d8ae54 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1606,7 +1606,7 @@ static bool trans_ERET(DisasContext *s, arg_ERET *a)
         return false;
     }
     if (s->fgt_eret) {
-        gen_exception_insn_el(s, 0, EXCP_UDEF, 0, 2);
+        gen_exception_insn_el(s, 0, EXCP_UDEF, syn_erettrap(0), 2);
         return true;
     }
     dst = tcg_temp_new_i64();
@@ -1633,7 +1633,7 @@ static bool trans_ERETA(DisasContext *s, arg_reta *a)
     }
     /* The FGT trap takes precedence over an auth trap. */
     if (s->fgt_eret) {
-        gen_exception_insn_el(s, 0, EXCP_UDEF, a->m ? 3 : 2, 2);
+        gen_exception_insn_el(s, 0, EXCP_UDEF, syn_erettrap(a->m ? 3 : 2), 2);
         return true;
     }
     dst = tcg_temp_new_i64();
-- 
2.34.1


