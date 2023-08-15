Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FFA77C5AE
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 04:11:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVjW8-0004Xo-SD; Mon, 14 Aug 2023 22:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qVjW4-0004XI-CR
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 22:10:40 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qVjW1-0004sZ-Vy
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 22:10:39 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-686e0213c0bso3211456b3a.1
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 19:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692065436; x=1692670236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2Taahq3fVBKJ94Ffy/oBvlI0n7eavep5mAubrSs2vbc=;
 b=LHJhQgg1X5N/zQt8oBuMOvviw5seuBWsx0zMigf2390s6LZCVnmAfga3msIaMCh0wv
 gyczRMIXTHZ3bzFulTLH6li4rKAjaR6qJDpqAmP79qmDRhYHEsC9H4piphEp5bxiFDZq
 K7SnzmwNi4CK76oVsYpjOUlYsO7J/n09oiv7DQDaNtCuCU4dQgsBMVEmVjuN3ql4tt38
 6KL19LzYkieWJIEzcVm72X6baqd7Q3e2vs4Uma6rDnaDwg+ki+bWS39iXNrfpg/MZVef
 YoFCKYLs5TdNvdMsHCWxMmxqf3CuB2NbpkApptxMusK0ILakTxdDfYoxo9OlivODhCY4
 gdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692065436; x=1692670236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Taahq3fVBKJ94Ffy/oBvlI0n7eavep5mAubrSs2vbc=;
 b=MCuJHOY3pSMrdP7tYuZ2g/YEv5dSxDNDGI7KZODSQsCvCmFrJlpsh8IJfU/D3gkqbq
 ngxKNlJkExeHicuAVyRuogo/KnSjKSewHiX/rwhCNjYYCRnW1XHEPWJmmsuWaKBnbt7m
 m000rNlDe3izLn9D/S2nkn5woYegB9YIAAuLDq/TB0WlAcIZQSZj/dRtwDk6oCyY+BXq
 cjaM5ThlLswpH4sEILVXI8OWaYrMPZqpwMEYKM5Q4H5W34DWYlq6ZIawZZ4SwOekxO+6
 f0jo3TgofXD2W26hATN3MrBA9DD9gNLFxY/bcosDOgfPCH1HPh0bV8MVEiWOfjevxAgH
 XpZA==
X-Gm-Message-State: AOJu0Yz8yRp9jcuaH2rHDAZWO8Nj3xWXDeJz9izvfGnMFWECC5LeFZXH
 6tbvTYCSggcbBMRAdKRZN36xQ8xq2hx4YIHZ9Cc=
X-Google-Smtp-Source: AGHT+IF8L9p85S7XsEg/xf/mvPKynM8kKmaCIYdPOuLQ/bQtxTFTfBPGR7CNXAzhMqOEhFhXNK+pvw==
X-Received: by 2002:a05:6a00:3987:b0:680:f6fe:8908 with SMTP id
 fi7-20020a056a00398700b00680f6fe8908mr9828673pfb.9.1692065435841; 
 Mon, 14 Aug 2023 19:10:35 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:9b47:f2a4:a84:2c9c])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a62be06000000b0066f37665a63sm8535160pff.73.2023.08.14.19.10.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 19:10:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] tcg/i386: Output %gs prefix in tcg_out_vex_opc
Date: Mon, 14 Aug 2023 19:10:33 -0700
Message-Id: <20230815021033.1090676-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815021033.1090676-1-richard.henderson@linaro.org>
References: <20230815021033.1090676-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Missing the segment prefix means that user-only fails
to add guest_base for some 128-bit load/store.

Fixes: 098d0fc10d2 ("tcg/i386: Support 128-bit load/store")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1763
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 77482da070..a6b2eae995 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -595,6 +595,9 @@ static void tcg_out_vex_opc(TCGContext *s, int opc, int r, int v,
 {
     int tmp;
 
+    if (opc & P_GS) {
+        tcg_out8(s, 0x65);
+    }
     /* Use the two byte form if possible, which cannot encode
        VEX.W, VEX.B, VEX.X, or an m-mmmm field other than P_EXT.  */
     if ((opc & (P_EXT | P_EXT38 | P_EXT3A | P_VEXW)) == P_EXT
-- 
2.34.1


