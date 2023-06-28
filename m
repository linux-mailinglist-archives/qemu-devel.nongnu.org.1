Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E91C47409A6
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:14:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPLs-0003KF-Gq; Wed, 28 Jun 2023 03:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPLb-00035D-1u
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:12:21 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPLZ-0005Jv-B7
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:12:14 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-313e34ab99fso4601131f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687936330; x=1690528330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lVxMdYHFaukC6RxhKHYCpwZeKGUEXTZS4jUfSlEXDBo=;
 b=QdVDjh9TDhi2MATF9uknK2hMEq1oIATiyryU3c02MV1WTUK2Tf5lPNA10MkoEb8Tgj
 78do2pgqkechdUlLzrE5EKO59tpG8SqSGpP0axEY+QGDSAaDY04JzLPR/L/4jIcwjL3B
 wceExmfQoErQyr+TD/EdehZVIKe8Ea+otvoUVswpDSyshUSb/WyzaZBn9HQnus0if+co
 rg92niiztLv7cVe0KD/uADayT8jcsmGJQm4pxdkxRLmPIhnTkIgMZ8KUjQoiAgtyNZGU
 8iRDQIVNzLg0AZ9UICEcAGTv5HVRXAzBMqRa7SjRh8MoJSJTHosp++E/o9Ah+gtCOlCW
 yqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687936330; x=1690528330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lVxMdYHFaukC6RxhKHYCpwZeKGUEXTZS4jUfSlEXDBo=;
 b=bR2DHxCJcDE1amZnwRCslA7R1YmWxYInzL7fCh1uBUuJ78s/Ptt5kcU+o5elbjs8mM
 2tUWB5ImGvT5QHaiKpqfDCp6dkjuC08ShWpyI7nR/KKoW+ZoE+kkhgS6rCOJoAFboVBy
 78sTrBbIx/di17dXYkFFZeysdnpHJN7ZD2Xy5ddPVkgwrc145NLTSt8LRNWSfPewi4yb
 YLCnBkOj0edRI3w+K4TncynB2zJMrRrWl+FDKbqk2t3SWrXDAmF+ijwYaF3VCJIfAJVZ
 kd5Ze08mtZt9VOjUALvPxRHnzaNB301jj4XHfPnWP0dtX6lUtArfN/xniCTy41fGwyhz
 XIFw==
X-Gm-Message-State: AC+VfDxgkECDk3iyjyqwMzs8i0HXUq2BseGqFNPcc4vNH+TybiLMcMfr
 kgmGCSRg2gCX4zHdFNthaEo5lpXT+zAM7b2BkcwjLNVV
X-Google-Smtp-Source: ACHHUZ4Vax1EJBsrZXvo5GwkXiZQCFRfHexnSsSjxJrHzVnXENhmdrywZICHoOnnX9h5LtoNKSjelA==
X-Received: by 2002:a5d:6785:0:b0:313:f990:c631 with SMTP id
 v5-20020a5d6785000000b00313f990c631mr3741094wru.44.1687936330083; 
 Wed, 28 Jun 2023 00:12:10 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a5d5705000000b00313f9a0c521sm4908667wrv.107.2023.06.28.00.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 00:12:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 7/8] target/sparc: Use DYNAMIC_PC_LOOKUP for v9 RETURN
Date: Wed, 28 Jun 2023 09:12:01 +0200
Message-Id: <20230628071202.230991-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628071202.230991-1-richard.henderson@linaro.org>
References: <20230628071202.230991-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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

After the register window unwind, this is for a plain indirect
branch with no further side effects.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 17afe98523..9148e33283 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5029,7 +5029,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                 gen_mov_pc_npc(dc);
                 gen_check_align(cpu_tmp0, 3);
                 tcg_gen_mov_tl(cpu_npc, cpu_tmp0);
-                dc->npc = DYNAMIC_PC;
+                dc->npc = DYNAMIC_PC_LOOKUP;
                 goto jmp_insn;
 #endif
             } else {
-- 
2.34.1


