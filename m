Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CD67FDDEB
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 18:05:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8NzE-00007t-HQ; Wed, 29 Nov 2023 12:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1r8NzB-0008VM-Pj
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 12:04:29 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1r8Nz7-0002zY-PC
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 12:04:29 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d001e4cf7cso16456815ad.2
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 09:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1701277464; x=1701882264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y/52Np4NKh02g/xFTctIbb9Rk3QH3KmZVD4jfr+ROnU=;
 b=BnJC9zFaBTE+KuQi+913fgYgJzyoY01SrjzZE7Yi4ApM/KEjTPxZqvQ+JHn6Ke51iY
 1Xsx4wBbB7O7OCF6p5Tj2gR+H/+nQde6l6YplcVJKfnBZ8ks7lzzye71FXFh4L+h1QxT
 LeawK681sb7E/5M+QfzW6m8OlfFygTbqe5TDoU9EIklscjstMQUmRTH2Zcx/Ud2GJLUZ
 FeeZhFD8b81r43BdrFoqJFDlZP9IT+ugiozmyExW3zXlXJKZvDFExSKxwY61DkkAoVWT
 DLdMGY5DerRVPUTDSBW4FFed5FGyBvHvKPCGeslNJYvp0TNU3l9MFkKBTNOtNRcBictI
 ys2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701277464; x=1701882264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y/52Np4NKh02g/xFTctIbb9Rk3QH3KmZVD4jfr+ROnU=;
 b=r5RPkkbQr0iESuHXO6QQuupq6iHZY/6h/BbfOL7DJp7Oyz6HFm6IXN1EKYZyphkjKp
 r4DILZHE+FBhSt6Zh91DIQ8+oih7dv3dRIUfHJ4gn0sSYv9b42fMx+J/2q5neTH1fAxX
 S09EEBoxxU0Aoyg9wIkiroVp6NhliGFcprDDTyKu1hyJcMihD5noRjfPTKtV+F/42UBk
 AEAbPo09SI+GTuyOXcPPjcFRFJWEprTVxcbLT8x7cb8GqUajGX3SdOLL1+EwsyGGWbDh
 pb56rmheV+WKGTpMCCig/P1QCYrzXiHOpg7kLywUeVXrRPbNTllswrRd+zRH6yBWlUTJ
 lz8A==
X-Gm-Message-State: AOJu0YyV30FrNQe43IXxvSHJXQ32BoKtZEFe6n3zEGl1GMa1Kcb+4aSX
 fVg8Zr0fD/ke6Hs8pmZV/oM0jS35MNRPMifITmC7Mc1qS5y4IFIEupZreRjX6mNq8M+LOwNx1kn
 yeBcxnwVY0AZdefcFrE19uoGxao/63xxCf+lElQqjKpBMbjUyr8vTWF0T4IXt19PpAi/0tkcyIv
 7g
X-Google-Smtp-Source: AGHT+IGPkJTg5S4qK9RbfO9IBCM3zCOpCzFFQO5hQQl/OBPXkd7sDcYYORFcpVhkQWVE7/Dm0AMdqA==
X-Received: by 2002:a17:902:d50f:b0:1cf:eacb:a12c with SMTP id
 b15-20020a170902d50f00b001cfeacba12cmr7898292plg.65.1701277464063; 
 Wed, 29 Nov 2023 09:04:24 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 p5-20020a170902eac500b001cfc6838e30sm6921383pld.308.2023.11.29.09.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 09:04:23 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>
Subject: [PATCH 2/2] target/riscv: The whole vector register move instructions
 depend on vsew
Date: Thu, 30 Nov 2023 01:03:58 +0800
Message-Id: <20231129170400.21251-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129170400.21251-1-max.chou@sifive.com>
References: <20231129170400.21251-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62d.google.com
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

The RISC-V v spec 16.6 section says that the whole vector register move
instructions operate as if EEW=SEW. So it should depends on the vsew
field of vtype register.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 114ad87397f..3871f0ea73d 100644
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
2.34.1


