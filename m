Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FED2720D5C
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 04:37:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5H7k-0003C5-A8; Fri, 02 Jun 2023 22:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6e-0000cb-BS
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:35:05 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6Q-0004sA-40
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:35:03 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2566f66190dso2373451a91.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 19:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685759688; x=1688351688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jW/LkFvDYs7wuWSeKP7O4G0IgkgaVuXTO9qaWXdUTaM=;
 b=hnPFh4f+AWxBJf5sbiE7g8pqu1YrrALaXeTJJCgO4St7e6bMBIWNOHxZUk97tx2Qj9
 /dwDaOxRJdEKwwVA8MUBdz0TNFlFMP4b9wsZJpraNGTqO44pczDLLXawC3LlGP73+Hst
 mcJipySYYmPK9m2GQ/OUMeGJKtrmuMJIewlUg5YrSCS1s+HninI5yMAyjW+3WldrwIaZ
 iH+Ww38QCpGOGlxwnVVeQnwzuLSLXMamJyuSGkYjOhZuNYsFtNhXOEsoAqdsNMy89CDb
 HXDyDgDVglMZlJatc+hC1LgVaJaOtbf6xwix+7ARTsyrYX+ZXyU1MCapzXBy6GWiAJpW
 t/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685759688; x=1688351688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jW/LkFvDYs7wuWSeKP7O4G0IgkgaVuXTO9qaWXdUTaM=;
 b=Tp6fnGE8qzlSn5Lv8sEs2ZV99Ngt8FszG473Lst7gTFHYIDyklLNZ7ztsmbT3bmnVY
 m0t7OxveuwFbCSeyAnQMi6pywe2VKdabRbBG4JGkloKuSnnjp8mbD73LAUJjWeM6myiY
 GLuivXtXwxdTyMyy/hZ0Mg4IUQAa5R1/flMaUdCbJgANp4oZ0QzO6O6jicvZBtzyo3ZN
 ZXkcdU7wCBuH0Wny6dCGtj0AR6OLQ9yzCO8LHdYPk3NqnD92VG8h01T7zklVfLDaJpDM
 VdJ08H0eyO30e+Q8gs7DfJfd3EMqEGwUoi7P9Njets8z9zPjatcmaCkzKz8xHDccc07H
 D3UA==
X-Gm-Message-State: AC+VfDwKQJtfPJ25A2DBBBO7/CEEkj44S1M46K9uJPaJRMPmizwAHCjj
 5VcOO0Yq0kgI42d6rvu/IQhV7+sA8/oRRbUDTpM=
X-Google-Smtp-Source: ACHHUZ68DEKYRLeblRCSawuJDl/wKRCbCuA3o4wxiR1CDCeIeidKUdR7MICjqBdvdJehFB5FMJi6cQ==
X-Received: by 2002:a17:90b:4c51:b0:258:6e0d:26e3 with SMTP id
 np17-20020a17090b4c5100b002586e0d26e3mr1337673pjb.48.1685759688708; 
 Fri, 02 Jun 2023 19:34:48 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 e91-20020a17090a6fe400b002508d73f4e8sm3914289pjk.57.2023.06.02.19.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 19:34:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH 23/35] target/ppc: Use aesenc_SB_SR_MC_AK
Date: Fri,  2 Jun 2023 19:34:14 -0700
Message-Id: <20230603023426.1064431-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603023426.1064431-1-richard.henderson@linaro.org>
References: <20230603023426.1064431-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This implements the VCIPHER instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 444beb1779..c7f8b39e9a 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2933,17 +2933,11 @@ void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
 
 void helper_vcipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
-    ppc_avr_t result;
-    int i;
+    AESState *ad = (AESState *)r;
+    AESState *st = (AESState *)a;
+    AESState *rk = (AESState *)b;
 
-    VECTOR_FOR_INORDER_I(i, u32) {
-        result.VsrW(i) = b->VsrW(i) ^
-            (AES_Te0[a->VsrB(AES_shifts[4 * i + 0])] ^
-             AES_Te1[a->VsrB(AES_shifts[4 * i + 1])] ^
-             AES_Te2[a->VsrB(AES_shifts[4 * i + 2])] ^
-             AES_Te3[a->VsrB(AES_shifts[4 * i + 3])]);
-    }
-    *r = result;
+    aesenc_SB_SR_MC_AK(ad, st, rk, true);
 }
 
 void helper_vcipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
-- 
2.34.1


