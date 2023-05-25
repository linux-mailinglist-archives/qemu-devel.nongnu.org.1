Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7851371135B
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:12:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQM-0008RS-BG; Thu, 25 May 2023 14:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQK-0008QV-F9
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:52 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQI-0005vE-Rq
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:52 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1ae85b71141so16380915ad.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038249; x=1687630249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vXxyVLt0ER4eun7TxoIx5PWj+GpTU+EF5Iw3Swj2Sbk=;
 b=SdE2Cbw9RCIzeHIs77RN4iWNlfkVnKCrHYo66S3InosFfwUJcjy0Z9QZKkVjkF/vlg
 m28lxwvwWY1v3gx41qBXOfRsIs9yQF1FN2YncFVr/Tr6fHq1gajZlmEBsKHVmSQd2qMV
 g1IliB8eR+iuvGEP1s7AxBlSwgND8RVYs85yEdhMuS6CRfs2enEfbsuvUZymItI3du1l
 Qst0RGAV+dJISG1VWQtdQ59Nb0sk/xSxCBF6y+028flqEm3J2jXcc3xoj4jtoKz46qRY
 9UhOXySUjEv4YzLiV/PDastZCwniCUxWwcXrle9KBzEtRWnHVYItWzR+96An+5DJnj+9
 R6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038249; x=1687630249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vXxyVLt0ER4eun7TxoIx5PWj+GpTU+EF5Iw3Swj2Sbk=;
 b=QggovhB8SWwXK5q9YoG14icZRPdeaBx5KkR4c52XcqJj78S5H4BxtivXbpNuqRZN6g
 pDMchf5j5kCb5+H2LUhiG5HWT+0muGFQRGO/Tx8I7IxxT+tLWI4jdcH8Wo8CFo620EE7
 HXK8wUtvz5hJ/2CaOZn+uEUD7GU4AKwUjVtIBsIRyObSpRlR5irF5Yg73mvgXMhoR5nA
 4cIsBmJ7Urr/ZitE5ueSsQCkqxqPiK9jnEFjOu8ncfqRbkSHprURa08Aj19b954KbAz3
 DDFT7vFmwSMJwaaxpPcQySjYvmfZ3u+DCOKNN4iU2Q6wpSHsXqaGtwqq1EOn5N3nMbT4
 PErA==
X-Gm-Message-State: AC+VfDwNXTxeFeE7H0FYp+3lIir7ux9A9+bnX/b1f0c1FH3F7LE+rh43
 Oy49ac0UwKEioPtnI7Qpx/OuJ/JPH+SmCZlWgxQ=
X-Google-Smtp-Source: ACHHUZ4p+GlNBKCEHFjsNShiv4Iz3Y6/Sc3WdTTe+p5Grao9OrHP90w2t2DNlWE6ahi59408jpeU5Q==
X-Received: by 2002:a17:902:8ec3:b0:1a0:7156:f8d1 with SMTP id
 x3-20020a1709028ec300b001a07156f8d1mr2552485plo.19.1685038248832; 
 Thu, 25 May 2023 11:10:48 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 13/23] disas/riscv: Decode czero.{eqz,nez}
Date: Thu, 25 May 2023 11:10:26 -0700
Message-Id: <20230525181036.1559435-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index e61bda5674..d597161d46 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -962,6 +962,8 @@ typedef enum {
     rv_op_cm_mvsa01 = 786,
     rv_op_cm_jt = 787,
     rv_op_cm_jalt = 788,
+    rv_op_czero_eqz = 789,
+    rv_op_czero_nez = 790,
 } rv_op;
 
 /* structures */
@@ -2119,6 +2121,8 @@ const rv_opcode_data opcode_data[] = {
     { "cm.mvsa01", rv_codec_zcmp_cm_mv, rv_fmt_rd_rs2, NULL, 0, 0, 0 },
     { "cm.jt", rv_codec_zcmt_jt, rv_fmt_zcmt_index, NULL, 0 },
     { "cm.jalt", rv_codec_zcmt_jt, rv_fmt_zcmt_index, NULL, 0 },
+    { "czero.eqz", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "czero.nez", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -2914,6 +2918,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 45: op = rv_op_minu; break;
             case 46: op = rv_op_max; break;
             case 47: op = rv_op_maxu; break;
+            case 075: op = rv_op_czero_eqz; break;
+            case 077: op = rv_op_czero_nez; break;
             case 130: op = rv_op_sh1add; break;
             case 132: op = rv_op_sh2add; break;
             case 134: op = rv_op_sh3add; break;
-- 
2.34.1


