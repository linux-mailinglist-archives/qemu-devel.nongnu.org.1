Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 374887201E0
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 14:18:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q53jD-0004iM-RG; Fri, 02 Jun 2023 08:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1q53j2-0004cu-2h
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:17:51 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1q53iw-00012o-QI
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:17:47 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f122ff663eso2580002e87.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 05:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685708261; x=1688300261; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zt/AkkUF0Oa0v1YU386sd7CtbRuL8ksGvcfUCwl70SM=;
 b=ZJ1u0KJkwldoK02cgyiGzD4kdb4SgwxzZRgknA8Rp20jIPkfpr1VjkEXG5ErsAmiGo
 7CfA9G1+4xEqZqYBlEkt/bkTK3qCOzb1R2UwAmMwf7eEf8VNJmUWJeGHuXiPfoH+PHUh
 0+5QBUzO3MXEn39wRtEZ00rsJdMrGn+xXAUeNj0Xki05kQAr44kKz4M3S2cHV72g2lg+
 sHlTar3LQuj2RAM3IXRph+KJ+bNgaoGJowSSO419ii01xowFLGRTixOu+jrVXQB5j6Me
 o5CMVkLdcc6/s6Z5Ct4dyWW9MpBgFUCKwxKzvZLdTNxNjsT81aqA8ijknxhrBKjm/EcC
 Vwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685708261; x=1688300261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zt/AkkUF0Oa0v1YU386sd7CtbRuL8ksGvcfUCwl70SM=;
 b=Z5v9qXuSDT821U5097MfXnOgsfykxKyLkmclpu97g8ctXpZ0sUo85G066L/pARVXse
 A1oX8sN8m0cNiGJ9st1bqtMIRsqmqfe6D/BVJuVsQ3YmZmJhNjY6DqWrLiJuNsZrICuy
 EpiRbXLrNV0AZ/zUp+7A8+9odnq+ENpBgybtxAj7cgApb6C4H0cRqBz1ctVVAfUNcThC
 vc5qGNX5VWeMfclz7ZO5g9MdbyddK81SiMWRn9PbY07KnjDfbHk97tWJ3w9mhYEaBfex
 XpZuAkJX0HeCOrYCeUMZHUnUuhKnwhkZq7RHi9/nqOzmXoYjRPxTstMjcv39IkPL8Z2p
 nV2w==
X-Gm-Message-State: AC+VfDyT42egFcAfcVS9oLclTsYLWZTWqivFlAiBLwGeu4hj6TiXbR69
 LVAEXLSr+zdoAbeeWIdYB5WNejUKlAGKTQxVXCBzJA==
X-Google-Smtp-Source: ACHHUZ7dCaaSWvNmZPSOf+acPtbh73F9fvVanfzr1EUPCVgUTABDelAklkjBcTkFjGb2WLpyk9kx3g==
X-Received: by 2002:ac2:5dcb:0:b0:4d8:6540:a731 with SMTP id
 x11-20020ac25dcb000000b004d86540a731mr1716610lfq.47.1685708261001; 
 Fri, 02 Jun 2023 05:17:41 -0700 (PDT)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 z16-20020a7bc7d0000000b003f605814850sm5391847wmk.37.2023.06.02.05.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 05:17:40 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Rob Bradford <rbradford@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH 2/2] disas/riscv: Add support for amocas.{w,d,q} instructions
Date: Fri,  2 Jun 2023 13:16:41 +0100
Message-Id: <20230602121638.36342-3-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602121638.36342-1-rbradford@rivosinc.com>
References: <20230602121638.36342-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=rbradford@rivosinc.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
---
 disas/riscv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index d597161d46..dbed2010f8 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -964,6 +964,9 @@ typedef enum {
     rv_op_cm_jalt = 788,
     rv_op_czero_eqz = 789,
     rv_op_czero_nez = 790,
+    rv_op_amocas_w = 791,
+    rv_op_amocas_d = 792,
+    rv_op_amocas_q = 793,
 } rv_op;
 
 /* structures */
@@ -2123,6 +2126,9 @@ const rv_opcode_data opcode_data[] = {
     { "cm.jalt", rv_codec_zcmt_jt, rv_fmt_zcmt_index, NULL, 0 },
     { "czero.eqz", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
     { "czero.nez", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "amoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amoswap.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -2865,6 +2871,9 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
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
2.40.1


