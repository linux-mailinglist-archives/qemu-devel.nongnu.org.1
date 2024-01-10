Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF59829589
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:00:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUPR-0001Lf-CF; Wed, 10 Jan 2024 03:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPM-0001KX-6g
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:57:56 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPK-0003OI-Ic
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:57:55 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-59502aa878aso2052462eaf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877071; x=1705481871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWXRjNqIFVf/znuj3TKfRSvkUuguB0wRL87zUAKbFLY=;
 b=VdWdO0xkcxoZKTpIf3PpcJiREA8VA9CsZUTu1n7bQIEmgpQucYaT+QeGfIIKatjKKh
 IMwbYPkGV5Mv9+cFtKKr5vejdffeRRYec/itsram3uIv4xyG1laOc+x3Q3nnYjXkyjaC
 OHTvxCuOaVKEJSkrfhIYTeFw0iM5p+BYWxxocWVGv+4H+2U84LO1alsWM1BB/DbKasyW
 74Fm5CFKRdrLCzackLzQdJJFeFo8h/TqbrCIjQlM2KIcYLEFVrA/94b9vf6SzAdKIay7
 ZE7bpU/DmzcHzVszrcb2YEMnZZITPNBpYbF8N73SSYo51n27u2FATrr3EJzvU4ruq4P0
 lOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877071; x=1705481871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWXRjNqIFVf/znuj3TKfRSvkUuguB0wRL87zUAKbFLY=;
 b=SX/y5znKrfwieqI7jKT1GyA1+xY0U/x0a2fmrwZKtucjyz1nI6jYUpIZ8Z7hX9nRjt
 a5QZG3hHJyoiXZ6HgK8DNhJ43rVLMOfbsCHFAkBR6tg+Wur03H2f/M9/FVlRel1nkav/
 LJEBnRmjTXmmI7JqV24pZKppEpfoaTNh4SkTELer1WkQQaRI46ZLVxUyk3GnsohACUKH
 Lrjaw0MLFIGAsABOFjAhOIZwMJxQzkwBKXpY2pyu9Gxk8eufvC3hmY602Fram7dGDEgG
 T4jIDJDZfdX7JCPguFtaY6TsEkEWA1JJ93lK6RrxpEqG8f74OUOnQDTlpZiWa12Lf0F8
 vH4A==
X-Gm-Message-State: AOJu0Yyvr3oE2ar7flQB8QiUtPEKdXDsX7rY/Mn7Zhu5yeLBe9bOYtTP
 Er7mPMXq7ba6iGEQlGTlNctAEv2gFl2wxVPe
X-Google-Smtp-Source: AGHT+IFdN8kuSd464NfUMAKNQwLW6bcNT0AadOlL6tZ+sCUFTYK7HPcKSDe0H7oo9U9Ub0i9KGb+2w==
X-Received: by 2002:a05:6358:724f:b0:174:f1d9:563a with SMTP id
 i15-20020a056358724f00b00174f1d9563amr710993rwa.47.1704877071446; 
 Wed, 10 Jan 2024 00:57:51 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:57:51 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/65] target/riscv: The whole vector register move
 instructions depend on vsew
Date: Wed, 10 Jan 2024 18:56:30 +1000
Message-ID: <20240110085733.1607526-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc32.google.com
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

The RISC-V v spec 16.6 section says that the whole vector register move
instructions operate as if EEW=SEW. So it should depends on the vsew
field of vtype register.

Signed-off-by: Max Chou <max.chou@sifive.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231129170400.21251-3-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 114ad87397..3871f0ea73 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3643,8 +3643,7 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
         QEMU_IS_ALIGNED(a->rs2, LEN)) {                                 \
         uint32_t maxsz = (s->cfg_ptr->vlen >> 3) * LEN;                 \
         if (s->vstart_eq_zero) {                                        \
-            /* EEW = 8 */                                               \
-            tcg_gen_gvec_mov(MO_8, vreg_ofs(s, a->rd),                  \
+            tcg_gen_gvec_mov(s->sew, vreg_ofs(s, a->rd),                \
                              vreg_ofs(s, a->rs2), maxsz, maxsz);        \
             mark_vs_dirty(s);                                           \
         } else {                                                        \
-- 
2.43.0


