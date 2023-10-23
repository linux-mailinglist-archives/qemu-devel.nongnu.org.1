Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3B57D3EE1
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:17:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzQw-0005Vw-8x; Mon, 23 Oct 2023 14:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQu-0005VE-If
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:44 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQo-00085N-6z
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:44 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3573fa82923so15267695ab.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084816; x=1698689616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8BGO0/K3CdguLDzJsds4aGoMbgLTr4W7qQjeN+mh4IQ=;
 b=KT8nIXk9/7SCVUgvFn09JM33M23yUDID5vqfoYlexNHWSR1rulVuxUpN84RzkWdAwF
 HYTMmosPi1KEDX6/MLxxCixPodxZ/Y9hyKbU1vS0g1LIFHhVzmHSzExie+g2Sbe388rH
 WOe0oCeRRtQnUHbm5kvRRP6odjtYxSEHYxwOnqhSmoFidC3DfP+JNd3qftZ7FDLaA8Uj
 AobW37IZ3T2Ok067ZrbdiyP/SWRYFBP0+bzKHA5XT87VzxALnyL3zgewo/FF9t2ETiXX
 lq40SVtPgJhoYgT3c18wwjJXrAuqEBxDxhM/TK3zym9/1rwOLB/8jEsnyOz8fKtvb/cP
 lccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084816; x=1698689616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8BGO0/K3CdguLDzJsds4aGoMbgLTr4W7qQjeN+mh4IQ=;
 b=Ftuz05nyQFeB9kmRXrr57f5+I30MgbjMbyO+glnPAAJN5819QcnUC28XUCcjwj6zUP
 q21gTNIHQWZMW7kLh7Dvy2xaQpH46nhRoIHYof4yoxirTH9/Nuu+Bta6KuGjlhB0FQqi
 oO3bWyxsnxWb7W1GEwfuSqeICULTJ8iWgv1YfXdkRzT6ePlUSm5Kzreoh+JFdpdVPs+t
 GnjGV74qA82CoPVW/+jvXa7AuHUaihjgM5313Whx+IRX8/ODs/StN/GOL2ajs/Ko0eZK
 gJ3Yx4dWXJ5Q/LY85ih3amqOYoXuHgT4bMpXOAIbRAHDXB8CHMmgkHvSIqDC7mVLMf/c
 YdKw==
X-Gm-Message-State: AOJu0Yz/+a2MLObtWdwXM1sxX6RBFH9crZ1LP/JydCQnko2z/be/Nqkk
 /weirOBAbJjg9zt+bchpiOri1i+TXBRD5e/puFE=
X-Google-Smtp-Source: AGHT+IFJEFDrUQa9JNNrdsYSn2LhxbB1aV5U9AzGb2gSXercHmEowxkiOHm4rzcd9eUF1w7tLGEBYw==
X-Received: by 2002:a05:6e02:548:b0:357:a25a:572a with SMTP id
 i8-20020a056e02054800b00357a25a572amr11610530ils.21.1698084816120; 
 Mon, 23 Oct 2023 11:13:36 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 06/38] tcg/ppc: Use ADDPCIS for the constant pool
Date: Mon, 23 Oct 2023 11:12:57 -0700
Message-Id: <20231023181329.171490-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x135.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 226b5598ac..720f92ff33 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1081,6 +1081,12 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         tcg_out32(s, LD | TAI(ret, TCG_REG_TB, 0));
         return;
     }
+    if (have_isa_3_00) {
+        tcg_out_addpcis(s, TCG_REG_TMP2, 0);
+        new_pool_label(s, arg, R_PPC_REL14, s->code_ptr, 0);
+        tcg_out32(s, LD | TAI(ret, TCG_REG_TMP2, 0));
+        return;
+    }
 
     tmp = arg >> 31 >> 1;
     tcg_out_movi(s, TCG_TYPE_I32, ret, tmp);
@@ -1138,6 +1144,10 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     if (USE_REG_TB) {
         rel = R_PPC_ADDR16;
         add = ppc_tbrel_diff(s, NULL);
+    } else if (have_isa_3_00) {
+        tcg_out_addpcis(s, TCG_REG_TMP1, 0);
+        rel = R_PPC_REL14;
+        add = 0;
     } else {
         rel = R_PPC_ADDR32;
         add = 0;
@@ -1164,6 +1174,8 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     if (USE_REG_TB) {
         tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, 0, 0));
         load_insn |= RA(TCG_REG_TB);
+    } else if (have_isa_3_00) {
+        tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, TCG_REG_TMP1, 0));
     } else {
         tcg_out32(s, ADDIS | TAI(TCG_REG_TMP1, 0, 0));
         tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, TCG_REG_TMP1, 0));
-- 
2.34.1


