Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9567808C0A
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 16:40:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBGSq-0005zX-51; Thu, 07 Dec 2023 10:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rBGSn-0005yu-UJ
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 10:38:58 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rBGSi-00087y-17
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 10:38:57 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-333536432e0so989567f8f.3
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 07:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701963530; x=1702568330;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZw+JUiGsn+h8Ah0eCoapNTG4nn0tiSq/PIPn2r1QhI=;
 b=eNxKexhAaD61RhpV5iX/XKY3+lvwnjsJefRzXZT3QQOD9piw5NcWbuwum5TCP7xT0b
 AMOkKYU8yQcB+cJw+OAvyrwy5+KIBFQyWybqWo613L7+eD7nSmctpxti+FV3QGfXWplC
 6svxbeURx4KT9i4bo475d/xTRUavRxG+qFRxhbq4ZIPiRgeimvTMeFp1Iu5hT/9YJXQJ
 Al7dvQ1QVsCK6apecbzRzUYAJUEJY0xeLP7gQ6KFTowH0pRUUMPWWhr0LdFTeGHqOrsi
 OWOhSrpkNBfaHgOR38chXq1FB6X0hXVmDXmW/zlUcQg4nPiYvbSthbu7I0ZuUJbmHdTg
 df5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701963530; x=1702568330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZw+JUiGsn+h8Ah0eCoapNTG4nn0tiSq/PIPn2r1QhI=;
 b=PX7sjOAjsYUCE8opBDuQRIXsiNWAMgQqxtsCjBK1vxn4805Nbi81S85MIXsz26jR98
 YCcY8i+baGJluKGsiQdQhuOQZW2ga7gjzCFRlzeuyiqAqLX1phBkaQWE8ZMNEzkoG82p
 JQOk6Efsp9NKkWshL8lNzRod3cM5YyDgHDdPGGldLZjKPwJTnVtkWB0SWtRiCn3Pu4gc
 IUV9Hwi9bWXYqnblwUoBl2qvDvsVBmglJ7LjQZDlYeUJ0Pjg7GThc0LQW317gTvB1ZGq
 035BoZcSzMTxlGmLP53IUbuqJNGqRwxMwMaYFnYhlLnwUPoqUXdcfRcbBbcpeSy2Y5yN
 0MbQ==
X-Gm-Message-State: AOJu0YyEVxQo7N2VF2ycAjsscnSmQVgNjTTfp5BE2/CfvBW1dF1yT6AQ
 qJlF3D2JlNepaZUZVrYas2fVG7jIqNQeYS3vrbfDMg==
X-Google-Smtp-Source: AGHT+IEcWRDde5CeNOytCjA1B141772By2Dy/wAdEiAkT1pYlQr+PtIHoswvHU96QQc/kZI8LqT1ag==
X-Received: by 2002:adf:f10f:0:b0:333:2fd2:6f74 with SMTP id
 r15-20020adff10f000000b003332fd26f74mr1549114wro.126.1701963530345; 
 Thu, 07 Dec 2023 07:38:50 -0800 (PST)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 b16-20020a5d4b90000000b0033339e03a60sm1711399wrt.59.2023.12.07.07.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 07:38:49 -0800 (PST)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH 2/2] disas/riscv: Add amocas.[w,d,q] instructions
Date: Thu,  7 Dec 2023 15:32:31 +0000
Message-ID: <20231207153842.32401-3-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207153842.32401-1-rbradford@rivosinc.com>
References: <20231207153842.32401-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=rbradford@rivosinc.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
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


