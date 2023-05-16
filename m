Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 938F97057F6
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:52:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0f9-00047J-Ad; Tue, 16 May 2023 15:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0c0-0008Rr-GS
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:32 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0bv-0003gk-M2
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:31 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1aaebed5bd6so450625ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266326; x=1686858326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBFQEHcsaNEVnrjFS9YpHI6iX7jr4WbeYOSUWmY+ntw=;
 b=twvpdnb0549R7e6OSvB6vlr90hhbIhdPooFvRFj1RdNK5XziHFwQu/URlzMNj2mwMR
 g3fgrCXOL9TLMf4Vo2fYtK/4fHUbBjQwLpXyLtmlZWQuJOoHeBY1ZCBfy2eRv+wysjnI
 Nr+utTvAAHUu5RbjvzZ4RUt8w6P6Pq0e0W9Z8sGHyd8iTkwWXfsUVoBJkbE+sTF3wuG1
 nranBa/EuGs+DaY5HUVwueUvWIgjcrOKPQt/BzK0TZJnjhDvXR1xv7fzTxp641IKD//m
 wsQu9HY3qSIhN8N7bRHuAnqUqzCitroTSDW3HDZIVDuhcGV8VTm30EXE95jjE1Bl4BEa
 IQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266326; x=1686858326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBFQEHcsaNEVnrjFS9YpHI6iX7jr4WbeYOSUWmY+ntw=;
 b=Q640oJp1i6gpstC9AM9yzasLIWRjhH2fqxlU0O0DNcYJXxwPp1tvG10d3EOiMXDo7u
 SiGpsohTTHDlsOy+5Ie/ltvbDponcywhPIcldT0qPlTtyR6dix9Hx8RGWXkQMQu6FtZo
 t++AVWyLDxd7FDgjtMpCOvaN0QFb+idRXhAAll981w8y5uauj41c06aImlaGqRDRtdWs
 MiIOP0NBaNWeQn4vUb/x4bCXO8PHKe0SQ2OpcNPXRiO0I2GCRbuAU27Kzx6KOBzA1bCu
 x7bQDoRCSlgF4SzuZfZbUXif/Qa6uTH7HUG8Q7rMfAtSLnLeqAJm5G9SO8WxzdFDT7np
 BxrA==
X-Gm-Message-State: AC+VfDzT404IfcVP6yTc+9G5mVg2sFRavDNpn89pvDCeIR5XjNmk/K75
 c1m/y5oVf5C8tdvLcxqDJt1dejrb/7RuSUyktOc=
X-Google-Smtp-Source: ACHHUZ7npb445VKv1brEbTvG9Mgh8IYiH+E+R0KEm4liSZs2+RPWmfW+UbCAI4Qu2MIL80nr2DeFBA==
X-Received: by 2002:a17:902:ef96:b0:1aa:ce4d:c77d with SMTP id
 iz22-20020a170902ef9600b001aace4dc77dmr36128283plb.24.1684266326193; 
 Tue, 16 May 2023 12:45:26 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 43/80] tcg/ppc: Use atom_and_align_for_opc
Date: Tue, 16 May 2023 12:41:08 -0700
Message-Id: <20230516194145.1749305-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index b62a163014..b5c49895f3 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2015,6 +2015,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 typedef struct {
     TCGReg base;
     TCGReg index;
+    TCGAtomAlign aa;
 } HostAddress;
 
 bool tcg_target_has_memory_bswap(MemOp memop)
@@ -2034,7 +2035,23 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 {
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
-    unsigned a_bits = get_alignment_bits(opc);
+    MemOp a_bits;
+
+    /*
+     * Book II, Section 1.4, Single-Copy Atomicity, specifies:
+     *
+     * Before 3.0, "An access that is not atomic is performed as a set of
+     * smaller disjoint atomic accesses. In general, the number and alignment
+     * of these accesses are implementation-dependent."  Thus MO_ATOM_IFALIGN.
+     *
+     * As of 3.0, "the non-atomic access is performed as described in
+     * the corresponding list", which matches MO_ATOM_SUBALIGN.
+     */
+    h->aa = atom_and_align_for_opc(s, opc,
+                                   have_isa_3_00 ? MO_ATOM_SUBALIGN
+                                                 : MO_ATOM_IFALIGN,
+                                   false);
+    a_bits = h->aa.align;
 
 #ifdef CONFIG_SOFTMMU
     int mem_index = get_mmuidx(oi);
-- 
2.34.1


