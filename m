Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC2B7C80DB
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqW-0000OG-9V; Fri, 13 Oct 2023 04:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqA-000849-Lz
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:15 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDq8-00010Z-Rd
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:14 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c50906f941so4616901fa.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186891; x=1697791691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SaTl4X/LIUPDf8cFxBYjjSaOAhLdwEPk6uGYtuIMCng=;
 b=qWb99FniMIiVZJV+92BkF5ksdBePJSlloq95rVVT+UW83fQTj1bN3vGQOvAfaesnTq
 G00ZVRJeQKw0BzsxpnZBmKLYm/E2UmAVIYKfKH2ZOlQjmuWz8cV+4EgD9g+lUn38HB1L
 62V8isL/38nFBP5wcRjeNyRaYUN4VqHG4/kxkiD8cghlkZNuvZIOWBktmj/FXQWoT5Fn
 JFt0v/2/QtYqx+6W1JNcKDU9FACtDEImhGP59yK36CIeX2RXluV/3ITPZeMsS1deLSlO
 iR2edHBhjoGRZ6sODVVaU2WJ/3j+8gWnzKIVbLpXtRTTgLXc1BemUiAmdo7M3wZ1Ey15
 6VwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186891; x=1697791691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SaTl4X/LIUPDf8cFxBYjjSaOAhLdwEPk6uGYtuIMCng=;
 b=FeobDDfOlfI5H2G3DfZURu4hWKaKq+OnzI2IwuU9kPwKT6b13gB0Y7xkIFWxN5kUlB
 SJ+sHFcVxekeuhqt68udGaekGeJfzDMTIUiiDlRnYv6pbETvVMRVRCFCzQ04aQmxFzBj
 RiO0PU5MgWPBoa93SX/B7qqvqq3V3aBT4hH6XDEnymGpN6jdkwTMf/F+Lc9cvZXt/Dry
 UIEfQk7fAi9TmsQ/+nKUGXb/513Bc8gycnjzcgMRjV+Eg1zsvUimoGgWwW0mTe0ezRGk
 lPvqrfevqFlAaBGNNr2hafJ8TvOmuMI8Wz75NEEJkVnHqaO0J7p5kQk2FYX3HA+4p+T4
 W4Yg==
X-Gm-Message-State: AOJu0YxkoWd8DwLR5cR6g7lzLRo0QCYQA3Qskt1qJZWiA+EjruLMGNKa
 vKgIIkzgU/cxngK5vjvet9/SblS15oWUFK3ezj8=
X-Google-Smtp-Source: AGHT+IGaClcqykjuNFKdN8+c9RDFjI9mAxEh22WtFHQgGIgVuN6JCGb2BU4+gQ675mh1B463OpZj/Q==
X-Received: by 2002:a05:6512:2152:b0:504:7f58:6dfd with SMTP id
 s18-20020a056512215200b005047f586dfdmr3407788lfr.2.1697186891024; 
 Fri, 13 Oct 2023 01:48:11 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:10 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [RFC PATCH v3 34/78] target/tricore: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:02 +0300
Message-Id: <58c8ba7fde09d949a71b7d35b9e51e52ebde028f.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22c.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/tricore/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index dd812ec0f0..4e42f06ec8 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -3014,7 +3014,7 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
         break;
     case OPC1_32_B_JLA:
         tcg_gen_movi_tl(cpu_gpr_a[11], ctx->pc_succ_insn);
-        /* fall through */
+        fallthrough;
     case OPC1_32_B_JA:
         gen_goto_tb(ctx, 0, EA_B_ABSOLUT(offset));
         break;
@@ -8452,7 +8452,7 @@ static void tricore_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         break;
     case DISAS_EXIT_UPDATE:
         gen_save_pc(ctx->base.pc_next);
-        /* fall through */
+        fallthrough;
     case DISAS_EXIT:
         tcg_gen_exit_tb(NULL, 0);
         break;
-- 
2.39.2


