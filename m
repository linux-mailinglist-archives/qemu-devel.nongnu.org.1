Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C8F7E1645
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 21:13:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzjU7-0003O1-8v; Sun, 05 Nov 2023 15:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU5-0003Mi-2M
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:37 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU2-00029V-Iu
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:35 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6ce2b6b3cb6so2542110a34.3
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 12:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699215153; x=1699819953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e5NGkRly/imKlA1fWYWgSM7Jy/zMxKilvyVfLnp3U18=;
 b=dBlWN6Q5SqxfFxjcvxdCHFdDRxzCwh/mtFNXriLSeF37+0BqB/qiV4J0rM9S+/+ewz
 G0R//R6hfR4IxVsnHwH8iFs1MgIgxu2QgsqeaxBLmsFIZ3Fq+FpdRh9cjir1C3O96rAX
 3RUVIYQYsCgwx/NXxfC4yZEYBxFeQ70LmW36Fl9hFTvVr6DyhYudL39JJje1MgMrDHdt
 iq9zgHQWZcOT4fq5Q4KDqRJ3zmzf+WJvCqMmMCakJ3OY2VpYN994ZnUwqr4IpdxtaDrF
 YQNOJCoMPE04idJzqHCIQAxNnVftKZcnyXQMNFZrgSrANNgZInS2/aNnLu20oqKhv7N9
 LZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699215153; x=1699819953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e5NGkRly/imKlA1fWYWgSM7Jy/zMxKilvyVfLnp3U18=;
 b=KV5HqH9Lf1NXUbmWUHWWyekTuhlb8ZMS2NlSSxuA0G2WgYsiAFJQFBwidmiFeFov1O
 hxI2Lz1Ad11IlzbmzhyGpRxf026xHDyNCPB7sy3G/fhqLkkmkK3EQ+btJM//ncZOSukG
 rOzsyCeS45f5k9+M1jpx1TzgCPwCPpyKszFaMHodZ/KlyX2HGwkz1jR3OuxVZejL3/ES
 RZ3jkNYilgfvJesjd2hfqYjRglG9yWsuPTOzx2giOXe3BD6s2fGwqCB3MAIg9qUHU+/J
 VwC6RQWU77Tkn6CFQHzCKCF+cqWZn0E1B8/ge2Ou/u23aQZfZ9ASaq9UXLu6EfjBsXxR
 +JHQ==
X-Gm-Message-State: AOJu0Yz+c9CqZAdihvze+TN/Yb5qhOqOS0zxXtJCUGWYOuJGT8NM/ZLD
 8mpQoDp+SzoqEo8h5o7np9Op+fEflzos3Sgsfkk=
X-Google-Smtp-Source: AGHT+IGeyIKUJboAKluS4sK2RG1pHwDpDWbYw+jBvUEsAbDT10pHh8cUjjKuQSi60E7suZAdqXtLrw==
X-Received: by 2002:a05:6808:1822:b0:3b2:ef72:f59e with SMTP id
 bh34-20020a056808182200b003b2ef72f59emr31421493oib.24.1699215153423; 
 Sun, 05 Nov 2023 12:12:33 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u23-20020a056a00099700b006884549adc8sm4359777pfg.29.2023.11.05.12.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:12:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 11/21] target/sparc: Always copy conditions into a new temporary
Date: Sun,  5 Nov 2023 12:12:12 -0800
Message-Id: <20231105201222.202395-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105201222.202395-1-richard.henderson@linaro.org>
References: <20231105201222.202395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

This will allow the condition to live across changes to
the global cc variables.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index a405512e6c..dd6d43d1f1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1226,8 +1226,9 @@ static const TCGCond gen_tcg_cond_reg[8] = {
 static void gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
 {
     cmp->cond = tcg_invert_cond(gen_tcg_cond_reg[cond]);
-    cmp->c1 = r_src;
+    cmp->c1 = tcg_temp_new();
     cmp->c2 = 0;
+    tcg_gen_mov_tl(cmp->c1, r_src);
 }
 
 static void gen_op_clear_ieee_excp_and_FTT(void)
-- 
2.34.1


