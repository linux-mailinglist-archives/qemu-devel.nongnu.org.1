Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9507DEA58
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:46:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMcn-000165-Rd; Wed, 01 Nov 2023 21:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMay-0006OV-1P
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:04 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMaw-0001vd-Ku
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:03 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5ab94fc098cso298532a12.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888840; x=1699493640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qv/a5qw7IRMvc9+1bsPwBvAxjMkczYjB4ck+5MvAjzA=;
 b=RSqI8Wn/LNxAn1kHwFTf8Cgu3c6ZcUurxNRACwJ6OkYzRv2+ywQ2bFNXJXC0M6F1hi
 XzXe3Iv3K+YTDygHw2cRJ2iXaYd7sPTLLQL+lNVENnzznRG/0fqnJrqg2qnjn62mPRWf
 zhdgU0FoOa92TghtCkNoBdDAq/QT4pqH2Kj24v/qClYbjanguLOgDt6Ak/N9IxJIPYK/
 k6xyHCjjkwtT/xfhHoPod3nnz1MkcCsSEcZWqe18ZMqmQukWrTFPt2uO68BqE/tLIxH8
 vhpYCtPiqKgllNhwK/tUzOgwKNUe6WLSH4lkGNlaFl8kFoNkew8fs/pI29ADMpTO268Y
 ziDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888840; x=1699493640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qv/a5qw7IRMvc9+1bsPwBvAxjMkczYjB4ck+5MvAjzA=;
 b=IPpqaQxBP7rnmVMFtCpA0RU1M3vJy5aRWgPiv32TUGC/sp5BOYNTb2hwqcUWG4xhU5
 QrJst92brgRkHU4dqHscOxBgpPMOnqOgJ4OXTxYXE4HgAs2SvdDqgMKlhG/+0WtVWAac
 tJHrJKAaxIifSpelWHsd13gnoN6HR6T8pWFRe9x6+vP35RNR8JRWDRFjfdVe+754qM6m
 QM+Uz+kxoqLzcZaIxADI/OvvnzyGTSw4WYUF2ezZQOCegnCDsN4UlKDcUjiVmIsYC4wd
 OtLAEBcymGo0duwXVBAXLYmGirW8kzC1IFLsv7wwOGzi7Ct7PLm4uZsSsKxicNIB2ZK6
 Rr8A==
X-Gm-Message-State: AOJu0YyUvsDZ77IVQGCAL57QdaVd2EoB7fghZJneSVGWRFh3adkqbi67
 ZuequMrvUz58wTUKA3UVpwurW3i8lCNFhXOWnp4=
X-Google-Smtp-Source: AGHT+IHbR7qVaEScoTEuXcj4Px+5xlSRdeqxAlVUMtBeWijcVc+YmwXh/LeSt1N3KlHpgAzGx/b1vw==
X-Received: by 2002:a17:902:d2c7:b0:1cc:4efc:c87d with SMTP id
 n7-20020a170902d2c700b001cc4efcc87dmr11620470plc.55.1698888840490; 
 Wed, 01 Nov 2023 18:34:00 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 48/88] target/hppa: Decode ADDB double-word
Date: Wed,  1 Nov 2023 18:29:36 -0700
Message-Id: <20231102013016.369010-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 7f767fea64..1b4fa401ba 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3143,6 +3143,17 @@ static bool do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
     DisasCond cond;
     bool d = false;
 
+    /*
+     * For hppa64, the ADDB conditions change with PSW.W,
+     * dropping ZNV, SV, OD in favor of double-word EQ, LT, LE.
+     */
+    if (ctx->tb_flags & PSW_W) {
+        d = c >= 5;
+        if (d) {
+            c &= 3;
+        }
+    }
+
     in2 = load_gpr(ctx, r);
     dest = tcg_temp_new();
     sv = NULL;
-- 
2.34.1


