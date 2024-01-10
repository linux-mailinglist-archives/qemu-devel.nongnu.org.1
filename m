Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D498295B7
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:06:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUPP-0001LC-98; Wed, 10 Jan 2024 03:57:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPM-0001KV-28
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:57:56 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPJ-0003O4-Nj
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:57:55 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5989e464910so91897eaf.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877068; x=1705481868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TP4srHKnHo6XWTW67Om3/pBPwsrh/P1GPdrxjWr4nA0=;
 b=VsvypJ+4GwCCqY/BU68tmc3Gps4M+yzEQsC8TNCkYve4LppYth1INMgaQcH/4IJlDr
 RD2pgUrHkzIk/P+qsYqOJI/q/sklxJhF6ok7sguidNmsEb6TzMiTfMzSyoaTa089eARe
 ptOHopKD0v4YSYeBiCYJw45SFqsok7+nOp3RZLZTuosrXbz4cxEFIuZBtfPsJa0IDfUB
 7ke2qTHqLIqFNkSANxyLy+pIJdc7kU+BWY/TkaU5oX1XvGv86By4dTPsDTEMTIAP/Smw
 URW1K10BHgNnPu4OwtsFtu/jHkfStwi9exL5lmdNMR4SA/fRxk1ZUgiH/ibNNheuinlI
 F5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877068; x=1705481868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TP4srHKnHo6XWTW67Om3/pBPwsrh/P1GPdrxjWr4nA0=;
 b=c+Rie/8Oe1aPHJXPWGIDU5RAn/9rfVb7yHMkvH/981i4VVcETeU4nkZqFLOJqKXuKu
 0gSQLGqt4873oNw/DG6qrPvW5WdH4fRg/Ek0EUJN1fjL3A0aNhalSAff9PR032wcA5hZ
 IUO96+GWsac+F8BMUiu9UBrhqg5/ZBigTnf0ldykm+FmW1Ku5PcEDwJrn8pvyHuGCd1K
 id5yC+otpEb5148rVEBk6LAdn6itSvI5GNxzvyPaYT+06LMDoA2JyEy5jt3qa/j7MGKo
 VyoQKifQn6y6KqXp94vOUOpgqkLxiDS2vDxUOd3kRGSPFcYKgQK9/SNdkgpsI17PKFgC
 VxQA==
X-Gm-Message-State: AOJu0YypoowG+kpxd/DfBtaFeJsO2jkSx3J1P8vOLZ/LE1icIvF0v3si
 GzxGl2wjkxWkN/MjU7/WzPEUlfkng760gD84
X-Google-Smtp-Source: AGHT+IFVWs6FwKtSVXkL92PfPB+hzfSaiMGKn71BmlVDg+sj1d1SxE3MzizmsRkOZ/RpGl9Keb5KaQ==
X-Received: by 2002:a05:6359:7412:b0:175:6b4f:3ff8 with SMTP id
 va18-20020a056359741200b001756b4f3ff8mr506715rwb.27.1704877067905; 
 Wed, 10 Jan 2024 00:57:47 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:57:47 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/65] target/riscv: Add vill check for whole vector register
 move instructions
Date: Wed, 10 Jan 2024 18:56:29 +1000
Message-ID: <20240110085733.1607526-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc2a.google.com
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

From: Max Chou <max.chou@sifive.com>

The ratified version of RISC-V V spec section 16.6 says that
`The instructions operate as if EEW=SEW`.

So the whole vector register move instructions depend on the vtype
register that means the whole vector register move instructions should
raise an illegal-instruction exception when vtype.vill=1.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231129170400.21251-2-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 78bd363310..114ad87397 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3631,13 +3631,14 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
 }
 
 /*
- * Whole Vector Register Move Instructions ignore vtype and vl setting.
- * Thus, we don't need to check vill bit. (Section 16.6)
+ * Whole Vector Register Move Instructions depend on vtype register(vsew).
+ * Thus, we need to check vill bit. (Section 16.6)
  */
 #define GEN_VMV_WHOLE_TRANS(NAME, LEN)                             \
 static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
 {                                                                       \
     if (require_rvv(s) &&                                               \
+        vext_check_isa_ill(s) &&                                        \
         QEMU_IS_ALIGNED(a->rd, LEN) &&                                  \
         QEMU_IS_ALIGNED(a->rs2, LEN)) {                                 \
         uint32_t maxsz = (s->cfg_ptr->vlen >> 3) * LEN;                 \
-- 
2.43.0


