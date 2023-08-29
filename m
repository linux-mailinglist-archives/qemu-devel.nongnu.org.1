Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4E478CA1E
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:03:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb27L-0002dS-HV; Tue, 29 Aug 2023 13:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb278-0002T0-4G
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:02:52 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb273-00051r-KT
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:02:48 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68a440a8a20so3985164b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 10:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693328564; x=1693933364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ubwo0TEFtdkb/m6/OLcsmvm92SJ7iM0Jve66C5kvkAs=;
 b=D0jHLErSUKSOK/5+14eaeR1Ng8Tsp9HFtEd5jLGv8XGh+lhlUxZUpMTSR111pHOWgs
 +GfoUURNCGLE6yAm67WvXe7mHQdWg4PscdYwGcoe6r7x7ukM1ZPY+6Z/PUzZGrprwb8r
 wPS1Rhmn596CKb0jJck+rXONcOXHhgkkfhLKj6D5yI5RL196azPCYKkuZwM7iRI3NPb1
 JX+yXB8KehqHIh4xZmFhoGkeQjhh1WkgdnygsFfjvPlrENZc5WrCShOWjX3U6x/GciyP
 0jtsr8bTdAjpDrEXB5IrJyN5l95Xwypv5OZHsf6O4sQRRKuBuv9UA20gNGzGpnl4NJ3W
 aHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693328564; x=1693933364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ubwo0TEFtdkb/m6/OLcsmvm92SJ7iM0Jve66C5kvkAs=;
 b=N+lCysa3DnSmUMeM5DNP5Z1OUv7YgiKgLrwxnc7PsCho+rmWNHP3K80KDscu7g0rF8
 NIMZO2YNTRvrwyuF/5Vps1bgNaCxRSLyBXVmC+2JNR3Kt5iJr4EbWkbreY17FQf5iuFk
 qBmNJDC1ehohnwTcDU/iXMA5I7v4iKtv+zpZHmUdBYr+ch9sHdTRfGO3fR+ie2wLTnve
 z1LKhJ3nJ7VyGsXAL+bvUow0swEUgNKGp1mkrDnWHNdF8qYgzSZiNkEXPDlUiphJY6nN
 1pYExDP6AZU3lIvxfPoHAKZHlZ5+2zQcFqLcgWbZDKsjmG+BoHljjGRds1HvmrkakKmV
 0B4g==
X-Gm-Message-State: AOJu0Yz7ZmfPbMTeFfRv0CzZOo8cydwd3TFIP7xjRlWjb22VxoyZ7PeA
 h2ThwGj1v2i30cA093O3nZRyC1mMGBE5yfA/bqk=
X-Google-Smtp-Source: AGHT+IHVnarea3StNV2FOBOxgqAjB+UbfnrPUaVUSZQRqWGBzbTDObU9bXGsX3EyWWERIZBMpfPt0w==
X-Received: by 2002:a17:90a:9ac:b0:268:60d9:92cc with SMTP id
 41-20020a17090a09ac00b0026860d992ccmr27344337pjo.43.1693328564183; 
 Tue, 29 Aug 2023 10:02:44 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 cv2-20020a17090afd0200b00267b7c5d232sm10989645pjb.48.2023.08.29.10.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 10:02:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/4] tcg: Remove vecop_list check from tcg_gen_not_vec
Date: Tue, 29 Aug 2023 10:02:39 -0700
Message-Id: <20230829170240.765996-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829170240.765996-1-richard.henderson@linaro.org>
References: <20230829170240.765996-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

The not pattern is always available via generic expansion.
See debug block in tcg_can_emit_vecop_list.

Fixes: 11978f6f58 ("tcg: Fix expansion of INDEX_op_not_vec")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index ad8ee08a7e..094298bb27 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -391,12 +391,11 @@ static bool do_op2(unsigned vece, TCGv_vec r, TCGv_vec a, TCGOpcode opc)
 
 void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
 {
-    const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
-
-    if (!TCG_TARGET_HAS_not_vec || !do_op2(vece, r, a, INDEX_op_not_vec)) {
+    if (TCG_TARGET_HAS_not_vec) {
+        vec_gen_op2(INDEX_op_not_vec, 0, r, a);
+    } else {
         tcg_gen_xor_vec(0, r, a, tcg_constant_vec_matching(r, 0, -1));
     }
-    tcg_swap_vecop_list(hold_list);
 }
 
 void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
-- 
2.34.1


