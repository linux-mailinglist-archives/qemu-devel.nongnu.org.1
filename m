Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C4F74099F
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:13:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPLp-00034v-IN; Wed, 28 Jun 2023 03:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPLV-00033n-4i
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:12:10 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPLT-0005Ia-6m
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:12:08 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4fb7dc16ff0so3201746e87.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687936325; x=1690528325;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gnOmqiNt0uuPn7dHfv6gqd6Jo/Wr3kqBk5WYapt4iEA=;
 b=hkl17mDZa3ex7cE1RtllD/TsZ6WNTCWuzAK26kzoKg8kR2JxeIFQq9CfHt+lwN6S84
 wi3xf423DS8N2NRqUIRp/jteyPaIBu2PYM3v4YrktRiwpM0hX/mXHsc/RPTirlHczNxj
 oQL4Y3r/sp9du/T01ZRwbbiEuyj8KsSEQJbqamPb5BM//Sv7zKKTVLHij93lgOvQxsMz
 91FFQ/e8VmlFB+Rz0gkUaWQLxfPWL4WpwJ8DIiSBkwFYC5Jvv3rmK9ReiDhQoAKBqZGh
 D4PnMbaBQ1Fb/2Gy0SsE2Ig81jaOjQisHMCuMz7vtHNpoFPasnMS3FR2sXbxTYiyFyug
 t4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687936325; x=1690528325;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gnOmqiNt0uuPn7dHfv6gqd6Jo/Wr3kqBk5WYapt4iEA=;
 b=KqsvyCjfYKtA1eUo4/z3vgoHTsq1r+J7dWb4hSL3edygBHU0pe/xGjhB03KHyFHClJ
 xqzj0xAUR3LtUUBl/Bk6fzmwpeP1wQe/lcRCuXMKm9uVHypLSocOOkRvAdBbmzHTmr7h
 rgY680Lpyfb9wzC+ewHWJE7qvoyw/yKvzBG/K/dMiEORga6+FpkbRaIiKlZifFzcMYIk
 yALInp6RotQ/CUrwJfdQUM1y6Zo62FwROXwC6DQwHx47daDtAPwHqvBRtWWQqMPBGg2B
 oTAwBjytxKGX66I3T7R7yyw7/3Gv+SIN5Ggct1HTKpDwv8VkBEsHrYSNBcQg9GQXL0iF
 V0yg==
X-Gm-Message-State: AC+VfDzeQO/Zn4d2Qsvy5Lq5BXroaplURpkPOWANb6M/h6hkVO68CE0D
 5D3S0Cd58BKlYEnDqv/qxgkQe1zFCMDgjqu5Ks1MDH3m
X-Google-Smtp-Source: ACHHUZ5bHCxv6gg5iB/vtNVaf+/iy9cAzsjTdzPkexc9Q6jYyvwSvkY3xc/KFdJdOZmKcwThYhaNkQ==
X-Received: by 2002:a05:6512:3e06:b0:4f9:69af:9857 with SMTP id
 i6-20020a0565123e0600b004f969af9857mr13518607lfv.51.1687936324933; 
 Wed, 28 Jun 2023 00:12:04 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a5d5705000000b00313f9a0c521sm4908667wrv.107.2023.06.28.00.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 00:12:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 0/8] target/sparc: Use tcg_gen_lookup_and_goto_ptr
Date: Wed, 28 Jun 2023 09:11:54 +0200
Message-Id: <20230628071202.230991-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x134.google.com
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

Changes from v2:
  * Patch 4 relaxes the checking on NPC:
    (1) save_npc has just asserted that if the low 2 bits are non-zero,
        then we have exactly one of our 3 special cases.
    (2) The difference between DYNAMIC_PC_LOOKUP and DYNAMIC_PC within
        NPC are not relevant to chaining, only those two values within PC.
    Therefore simplify the test in sparc_tr_tb_stop.


r~


Richard Henderson (8):
  target/sparc: Use tcg_gen_lookup_and_goto_ptr in gen_goto_tb
  target/sparc: Fix npc comparison in sparc_tr_insn_start
  target/sparc: Drop inline markers from translate.c
  target/sparc: Introduce DYNAMIC_PC_LOOKUP
  target/sparc: Use DYNAMIC_PC_LOOKUP for conditional branches
  target/sparc: Use DYNAMIC_PC_LOOKUP for JMPL
  target/sparc: Use DYNAMIC_PC_LOOKUP for v9 RETURN
  target/sparc: Use tcg_gen_lookup_and_goto_ptr for v9 WRASI

 target/sparc/translate.c | 402 ++++++++++++++++++++++-----------------
 1 file changed, 225 insertions(+), 177 deletions(-)

-- 
2.34.1


