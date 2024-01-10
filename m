Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A77C2829590
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:01:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNURh-0005Rq-Qp; Wed, 10 Jan 2024 04:00:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQu-0004aP-8p
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:34 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQr-00047S-Le
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:31 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6d9bee259c5so2355621b3a.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877168; x=1705481968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skrIjpTonLy9YNzwgam7TCIyIKFDcGU+qkrH3ZhJDXg=;
 b=Xvd/zM0aXl2x7prj6fQK9VQMdvgkZPW7aSdrlTfGXADkmK27hS4/1sutyfUSnavL7r
 9wEMaPqPKHQQ73pR0UgzUDoTcNxjoeCnhPEtzPvsssNjV31Sp0y8vwr5cJaE8bm2xFb+
 oDFoWk2t2tiy17F48uXK34zGOj89mC7joA0MTcANHdvfPUu9ktkW85C01JIWJCkeFdIZ
 +GdocGRD5L9ZC4KtM/no5lO01qdSIyczADRQCtjnLdMv+9RsLb7B7uwldN6yJmaftmRy
 4xoUBC+yxvQUeQMzm0/l02y14W4FfoqticUnfaEGex80YDiDEHlEZwQiiGxQdkLANllj
 j+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877168; x=1705481968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=skrIjpTonLy9YNzwgam7TCIyIKFDcGU+qkrH3ZhJDXg=;
 b=kzoCMd0USb0/z3Df47WBpyLts+gHVcAmwetD3d1RK+t0SYLQRs0nXDbu0N2/olaN3w
 dWMZC7B+EYl7QhkUz3MHtSh0cNkXsk/lWKflzVMc+V13T6o7RH7RnI5NrzJ8cZ0IIuBY
 DJus20owkjB9X6LVxVp+XWI9j9O6XBUtFKep8YBUJFXXRdNbhiioRbt0T5CI4FzlAdp1
 Z5QQTCLhrYuXple0qFAvkpmR0JqM50+uaoAZsIbCnhQxjrs+6Pne6iq9L9S+6c2MR51c
 rShutjBz3miMv2KEcT3z5dk1suZ+BlGXWSehgPWCV21aqYbo6pP+sTKMskanZ1R79C+g
 ESqg==
X-Gm-Message-State: AOJu0YwAMhYy1vMXoi3xFNf18puuW+iTbtc7CfKNTV48hqPBmLG1ploD
 AW8tQDG4BFjGQdWQmCWgazXEhd+58K6ncnAi
X-Google-Smtp-Source: AGHT+IFdZdk66ABcEg+g6SWlQbeTWR/OnCVeZFXUzUwWw/JsaDCE2T0hVtvVH/vNmYfMUqGuCdnfFw==
X-Received: by 2002:a05:6a00:4f59:b0:6d9:a908:2659 with SMTP id
 lc25-20020a056a004f5900b006d9a9082659mr533963pfb.62.1704877167840; 
 Wed, 10 Jan 2024 00:59:27 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:59:27 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 27/65] disas/riscv: Add amocas.[w,d,q] instructions
Date: Wed, 10 Jan 2024 18:56:55 +1000
Message-ID: <20240110085733.1607526-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Rob Bradford <rbradford@rivosinc.com>

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231207153842.32401-3-rbradford@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index e9458e574b..8a546d5ea5 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -903,6 +903,9 @@ typedef enum {
     rv_op_vwsll_vv = 872,
     rv_op_vwsll_vx = 873,
     rv_op_vwsll_vi = 874,
+    rv_op_amocas_w = 875,
+    rv_op_amocas_d = 876,
+    rv_op_amocas_q = 877,
 } rv_op;
 
 /* register names */
@@ -2090,6 +2093,9 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "vwsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vwsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
     { "vwsll.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "amocas.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -2841,6 +2847,9 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 34: op = rv_op_amoxor_w; break;
             case 35: op = rv_op_amoxor_d; break;
             case 36: op = rv_op_amoxor_q; break;
+            case 42: op = rv_op_amocas_w; break;
+            case 43: op = rv_op_amocas_d; break;
+            case 44: op = rv_op_amocas_q; break;
             case 66: op = rv_op_amoor_w; break;
             case 67: op = rv_op_amoor_d; break;
             case 68: op = rv_op_amoor_q; break;
-- 
2.43.0


