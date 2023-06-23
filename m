Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD0773B783
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:37:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxn-0003Oa-3X; Fri, 23 Jun 2023 08:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfxB-0001vb-47
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:56 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx8-0000jC-6e
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:52 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3110a5f2832so1709904f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523508; x=1690115508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QlSz0nwgBRElv1Gb5ECXek57n6VkMhtUUggSt4DnbRQ=;
 b=l+Y8hUOL2uWHXO3B84e/xlhxHQ+tgzEs+OJ0ow8jNhK3cZcoE7cq0dpMk76sFvErsd
 o3cv+OL8Zhhzwqj0CCZ/J33fCL3msHa5XSHcHAh01AABuWLD0noC0/PrROqVss86VpS1
 bHhnTCmHMbtUXQsEui11v+HPV43DixynIVvqN8by+dHiyiRQbwYqU+okxjuxg7K0O/qr
 kJ9oy3oRd2TFItqFKetmIgPPblfrnXLqW3h3NEWYiwq1DBFRMLpvS53aVG6JHEi1dtPU
 nPbDGRCcq3F/H3ndn7L/NKsOOGIWqF0YIJTfPI80tNnYiSL+4LLCBKXcEIJAgICuJLcU
 zNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523508; x=1690115508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QlSz0nwgBRElv1Gb5ECXek57n6VkMhtUUggSt4DnbRQ=;
 b=SgpOuZ9yRc29w5IlBCv0wYejIOlVuU989/C88aJxfoJ6qFwTAkQW+QFIgqpNNnjGlU
 UWZ9qN+INd6t19MDqrjOEkrHIg3lSNCWdFIa7Q/ZZATrdHuew4XG++AK8SyDEzCcp5FY
 4GtO+PEaOHVh5vqrV+g56qaqUw0RJQLycEFakOD3OdUvS6N9fgaupsaHjwk+znWwAppI
 atq39FpEd4qacr2FVFZacNj0VJuefzf4p2yS3VkRfKril2lzl7ohaZ1NwgrPgPnRXCqC
 pIxeZzS1ddL/M2R7dCuFfymIlyA7AjifZ8okIe9rPiGXERo8t4pkM2ZMNMwfnOanjwJE
 0ANw==
X-Gm-Message-State: AC+VfDyhQNJy7HXlJzQFQr8RQn5Kg1h2plbTLUmbTa8VQ5bG6b+XtHQj
 Ys8FMCdl96ZN5EGn6p6N5fRXrcMo/rc4CnztFeE=
X-Google-Smtp-Source: ACHHUZ7kVn2/OxIZDPxaj4cQZ8amnz9yeDceYfIwULDf1a2RPcVnW75ILcv+QX3pg3kftCFQPEt0uQ==
X-Received: by 2002:adf:e44b:0:b0:311:8702:9e16 with SMTP id
 t11-20020adfe44b000000b0031187029e16mr13890521wrm.6.1687523508786; 
 Fri, 23 Jun 2023 05:31:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/26] target/arm: Fix sve predicate store, 8 <= VQ <= 15
Date: Fri, 23 Jun 2023 13:31:34 +0100
Message-Id: <20230623123135.1788191-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Brown bag time: store instead of load results in uninitialized temp.


Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1704
Reported-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230620134659.817559-1-richard.henderson@linaro.org
Fixes: e6dd5e782be ("target/arm: Use tcg_gen_qemu_{ld, st}_i128 in gen_sve_{ld, st}r")
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index ff050626e66..225d358922c 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4329,7 +4329,7 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
     /* Predicate register stores can be any multiple of 2.  */
     if (len_remain >= 8) {
         t0 = tcg_temp_new_i64();
-        tcg_gen_st_i64(t0, base, vofs + len_align);
+        tcg_gen_ld_i64(t0, base, vofs + len_align);
         tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUQ | MO_ATOM_NONE);
         len_remain -= 8;
         len_align += 8;
-- 
2.34.1


