Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EE07E07AF
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:43:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy8u-0005ML-Kg; Fri, 03 Nov 2023 13:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8B-0005Cp-U7
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:52 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy89-0003Po-Cb
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:50 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc37fb1310so19316105ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699033126; x=1699637926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OdTkIb+503ZSVLnr9dPJXCHToqhEgA9RiLgl/i9QaPQ=;
 b=uY621na4szzzrtYeV6PRQqi/KmYmRV3c88n74dWFqdrQMpWAfD7p7e24fBw56T+2EL
 uQXuIFSwsN9VLkMUHmffL5hMFI8yNvtHYkUprH6ZB4xFPI8xwbiuOH7VwEtBeJ9Y2ssY
 ZFp9JXtwWwWjjcCmIYCqFdYIRY56qHQdE9VqqFD2qoU5DR4IqTaHxqRoIT6iZm45kYN9
 o+89w0CkfVeFtEqU8yJ7Vc0mRyHsWvld8aij5KAlqyeBg3PQL4fBtMH4OChOyIFAQzTC
 v6RTJWxLJ01QLhX6ja/76WBu9d4xIzbASci1ge/45ef7RPNI1/tGMGhdCLwjxAOEb9lo
 731w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033126; x=1699637926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OdTkIb+503ZSVLnr9dPJXCHToqhEgA9RiLgl/i9QaPQ=;
 b=Mj1cu6E7M5WPsp87Or/1Aibabkldmp5Myq0nXaXjN+Tg5mT/YDrxa3EXDyPxS0j88J
 hu/LPOe0evw44XW1floU7RKPr1HD5F4IpCslQyDdz3i1jfjRK/Qk+l7HSQykULO2GMyE
 UktcBAx7UjILREZDyeyh2G4SNjdzwLxJywW5vzGG9lZmsURaa++EbRuD1EbXH+8/07ie
 bhiEPQEBeiBWKotStNAYbEKpTx1DMyxIvvTS6Nl57qytVraUHRgGrOLVuPDS9LCcVk1U
 Pvz14w82j6yXrkuWFBt/fvJ1QrnESDwbDPpNlbZHH7G4OgmyWFkpaOM9nD6bEenrJ1Xy
 2hJw==
X-Gm-Message-State: AOJu0Yyyurcf0hDm+zTlNEgdWreDhn9X2XwWBXc6lhwJeA6w1JQhPWOG
 0fJqLb0t38Ml0lA9IDAO7QID+nS2qBCwqrHiq6U=
X-Google-Smtp-Source: AGHT+IFn/DGM943zafMLx7gST/jiSa3cSoCvBYxDmjgbc1otBg8ND36/eMEK0FF8mERpUacqAVy08g==
X-Received: by 2002:a17:902:6b48:b0:1c5:8401:356c with SMTP id
 g8-20020a1709026b4800b001c58401356cmr17866119plt.62.1699033125929; 
 Fri, 03 Nov 2023 10:38:45 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c10-20020a170902c1ca00b001c0cb2aa2easm1628267plc.121.2023.11.03.10.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:38:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 04/22] target/sparc: Introduce gen_{load,store}_fpr_Q
Date: Fri,  3 Nov 2023 10:38:23 -0700
Message-Id: <20231103173841.33651-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103173841.33651-1-richard.henderson@linaro.org>
References: <20231103173841.33651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Use them for trans_FMOVq.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cdc85be807..0e494d3ebd 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -264,6 +264,22 @@ static TCGv_i64 gen_dest_fpr_D(DisasContext *dc, unsigned int dst)
     return cpu_fpr[DFPREG(dst) / 2];
 }
 
+static TCGv_i128 gen_load_fpr_Q(DisasContext *dc, unsigned int src)
+{
+    TCGv_i128 ret = tcg_temp_new_i128();
+
+    src = QFPREG(src);
+    tcg_gen_concat_i64_i128(ret, cpu_fpr[src / 2 + 1], cpu_fpr[src / 2]);
+    return ret;
+}
+
+static void gen_store_fpr_Q(DisasContext *dc, unsigned int dst, TCGv_i128 v)
+{
+    dst = DFPREG(dst);
+    tcg_gen_extr_i128_i64(cpu_fpr[dst / 2 + 1], cpu_fpr[dst / 2], v);
+    gen_update_fprs_dirty(dc, dst);
+}
+
 static void gen_op_load_fpr_QT0(unsigned int src)
 {
     tcg_gen_st_i64(cpu_fpr[src / 2], tcg_env, offsetof(CPUSPARCState, qt0) +
@@ -4615,7 +4631,7 @@ TRANS(FsTOx, 64, do_env_df, a, gen_helper_fstox)
 
 static bool trans_FMOVq(DisasContext *dc, arg_FMOVq *a)
 {
-    int rd, rs;
+    TCGv_i128 t;
 
     if (!avail_64(dc)) {
         return false;
@@ -4628,11 +4644,8 @@ static bool trans_FMOVq(DisasContext *dc, arg_FMOVq *a)
     }
 
     gen_op_clear_ieee_excp_and_FTT();
-    rd = QFPREG(a->rd);
-    rs = QFPREG(a->rs);
-    tcg_gen_mov_i64(cpu_fpr[rd / 2], cpu_fpr[rs / 2]);
-    tcg_gen_mov_i64(cpu_fpr[rd / 2 + 1], cpu_fpr[rs / 2 + 1]);
-    gen_update_fprs_dirty(dc, rd);
+    t = gen_load_fpr_Q(dc, a->rs);
+    gen_store_fpr_Q(dc, a->rd, t);
     return advance_pc(dc);
 }
 
-- 
2.34.1


