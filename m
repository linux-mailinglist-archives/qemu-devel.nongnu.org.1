Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2327409A1
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:13:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPLq-0003Db-Ks; Wed, 28 Jun 2023 03:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPLW-00034E-Fa
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:12:10 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPLT-0005Ip-Oq
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:12:10 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-313e12db357so5870271f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687936326; x=1690528326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ncyD172GcxUgyS12v0sorDhSDpPgAN4YePMDW3gzv8=;
 b=FGL9ienE7tA0/tgrcYeGeUcqlnozQ0fz2ZoNibDCQ4mA9gMYsFtC0IVUlDPSQy53Xt
 lE3IuwL+RePKsBxGhorJD/nJtpQ4L7stJ5bRtEgvuyFSKCGWyKdc5wScUEHihteNN73F
 vc2EDGL5zfe2xKYD5vSVlo6TffQO5XWLJUxULWd/T9eeygr6lCczYvfeIwzaVCayYZY/
 2UgpZljuJy9wUmmlLdMliYhugX46y6seMRmEm8lpk8aUouO9Xmb143w6GoMPYb9b7DpV
 WhsxcEoWv/M4YXK3r9CDUF+Fyd5tI5F0KQboUEK2MeYLw3Jtk/sf7AFyeBlYRFH9k8JJ
 ISLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687936326; x=1690528326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ncyD172GcxUgyS12v0sorDhSDpPgAN4YePMDW3gzv8=;
 b=DtlOkdsMGZrd66JTvUGNLrOupkTyMCMgD7j0Xsja9sQ2H48XNSRIOkPnc1+zD4SeP/
 GdddXwzSPPKzeNFTxGx2U9gxKvM4fnEQHqfb8t+1d9b00QADkkuPa3nmKyKBomPUnjb0
 aCccdX+itTi1egTvzeR4XKSsKBCZK1dzwXYNJPsdn7kWNz5+mTDVa2e5RPZ6TizIs0rq
 DQ0e8pBDbIrGSW7y7nAmUEnrSNNO77hHBQNOIXWJAJ6mOs0iN2BCGxZ/E/0TDcQFJgW5
 dwDJqwHdKw8DcVMnS9AlLK7s/K/XuUS6iLvAJJ2aqZVNZRMWxeFYjdKOhWYn0DVqRJlT
 jsjg==
X-Gm-Message-State: AC+VfDxANrHwuKNED2Eico0ftGIb6blP2EpcwjM7G6tY7uG6wP+HNJP9
 SVNMgSdUsy7AdoMhqGsrtu018r59EoEUGwOcD0oePUrQ
X-Google-Smtp-Source: ACHHUZ4ZTREcWBGcd+f4PnxS0af9iNqSP7igeExWFIFTjQ0eUfvGLqtzZUsz/735mH5tv0WS/VCKfQ==
X-Received: by 2002:a05:6000:104f:b0:311:110d:5573 with SMTP id
 c15-20020a056000104f00b00311110d5573mr37070810wrx.64.1687936326335; 
 Wed, 28 Jun 2023 00:12:06 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a5d5705000000b00313f9a0c521sm4908667wrv.107.2023.06.28.00.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 00:12:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/8] target/sparc: Fix npc comparison in sparc_tr_insn_start
Date: Wed, 28 Jun 2023 09:11:56 +0200
Message-Id: <20230628071202.230991-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628071202.230991-1-richard.henderson@linaro.org>
References: <20230628071202.230991-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

During translation, npc == address, DYNAMIC_PC, or JUMP_PC.
It is only the encoding between here and sparc_restore_state_to_opc
that considers JUMP_PC to be a bit within a larger value.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 28d4cdb8b4..eec6f9ca67 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5594,7 +5594,7 @@ static void sparc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    if (dc->npc & JUMP_PC) {
+    if (dc->npc == JUMP_PC) {
         assert(dc->jump_pc[1] == dc->pc + 4);
         tcg_gen_insn_start(dc->pc, dc->jump_pc[0] | JUMP_PC);
     } else {
-- 
2.34.1


