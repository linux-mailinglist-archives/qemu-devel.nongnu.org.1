Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCBD7D3EF7
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:18:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzQy-0005X7-IJ; Mon, 23 Oct 2023 14:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQw-0005Wo-Rt
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:46 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQs-00087Z-6B
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:46 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b44befac59so3379131b3a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084820; x=1698689620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eJDwvSu5y6aQI1FUpLq82z/uiGp428KQX4VVdh13eIw=;
 b=H+XHAD7gxLwoPx27mxzQf3mtryZs+gXiGf2F39aXqpMBeFwqbwPDYBRLhTpyasWrKN
 dOtmA72Q//PBXgu+I5mdV3Xxr4n26h2wLsDUjjRrH7x1CCKR3xtDQGlAtXaBGupKGRM3
 J1xMhgzItaLU0Tsp3nIcK535DaoBjE4EZustQ4aSzwySo6aBf9gNVUyyQNGhoVFiUhJp
 p4yS7ES4jV6fLZXIOtJoYvm1xht+aOZUvExIjtRG1IDFxvpGSzN2cP7iatGLvd+V6OR4
 JSG30X22z2CpPRTXWkrAhIdB2VJhCUJq5JIFA0SsotK4RIDSEzxz7erkJDJXfmSA1jF0
 ZPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084820; x=1698689620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJDwvSu5y6aQI1FUpLq82z/uiGp428KQX4VVdh13eIw=;
 b=JtA7Dasg8bdm4Ig5ggoy78uySmDwRjUcHv6wjta+33lESgwL880x9A77l2TCs6LRAL
 S5Ml55PWR8Nxbvowkyk54Vz0TEI1XzeAWodIiB7+t5roY4tVu3+VikBju7Q7+35TGM1c
 7n2h8RFYeZ0tdSbzbFK2/m0C7b7q3DHtfvhyc/grIQFsBb+A8yWODH/xplMmixql6ej9
 TngoPodM7AhQ+ShJqnu4uaf4II6p28tAvHdhJPrMw1KKmVvyQKlVJF6k8325vVWDMXCL
 aoBVrKbeafYpsin/IUst6/dmGJkYyO1gIO1vE/Rfxqfhr/nCWkhl9JgByTmgJnLdtcA7
 DjMQ==
X-Gm-Message-State: AOJu0YxSdjV5Brps5bbuN6GB5W/Cz65RpAmqUSw/rR3ILE/cDLm9Uejx
 SyBW8MbO0itnnmLxCcC1noHWpQq4eadbn9HTNfs=
X-Google-Smtp-Source: AGHT+IFEROEHi84p+qMgpdj18Zkntr0M7ypDRx1IOf8cn5vxLX7DdKwvh56yne/76UhKqZvXLuk08w==
X-Received: by 2002:a05:6a00:35cd:b0:6b1:5d1a:bd0c with SMTP id
 dc13-20020a056a0035cd00b006b15d1abd0cmr17804558pfb.16.1698084820431; 
 Mon, 23 Oct 2023 11:13:40 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 11/38] tcg/ppc: Use prefixed instructions in tcg_out_dupi_vec
Date: Mon, 23 Oct 2023 11:13:02 -0700
Message-Id: <20231023181329.171490-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

The prefixed instructions have a pc-relative form to use here.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 79e82d2f94..db3212083b 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1242,6 +1242,15 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     if (USE_REG_TB) {
         rel = R_PPC_ADDR16;
         add = ppc_tbrel_diff(s, NULL);
+    } else if (have_isa_3_10) {
+        if (type == TCG_TYPE_V64) {
+            tcg_out_8ls_d(s, PLXSD, ret & 31, 0, 0, 1);
+            new_pool_label(s, val, R_PPC64_PCREL34, s->code_ptr - 2, 0);
+        } else {
+            tcg_out_8ls_d(s, PLXV, ret & 31, 0, 0, 1);
+            new_pool_l2(s, R_PPC64_PCREL34, s->code_ptr - 2, 0, val, val);
+        }
+        return;
     } else if (have_isa_3_00) {
         tcg_out_addpcis(s, TCG_REG_TMP1, 0);
         rel = R_PPC_REL14;
-- 
2.34.1


