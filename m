Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D007E3303
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:33:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bse-0005v8-JX; Mon, 06 Nov 2023 21:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bsc-0005ri-B1
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:50 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bsa-0002vY-Ek
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:49 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc3388621cso47731715ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324306; x=1699929106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OtwE/W/kGtkF44+Xl3AQKb9bLAFMuHoSpNqdnKmoL3o=;
 b=Z8CSJq1cU6IwXzpRs/K4pRy6mMT1TiPmz9o6Ddlh6fnOEyzzjc5kIeDlA3Qf3wCePS
 X6l9w+ZwRVqtDSD2rejN4qan3d4iLS+Nr0IGDtnRv1Rq4BGeo4uiKExFec/jIKlJWMui
 bNGKY1e78y1i1j3UF5auiZyVH7lP/8FeWZ/XgebYxGJ15zq5XKY1BFFmL4Zf3iDzpSX7
 LOvvQ16WaSvVEKvHgTAr6qJDZznlYuXPQxhMttBBQZ2H5LyFENNzLXkgAFf7z2jVXpP3
 e7eBAgGIQ8xyhgN7F6fsv2jfeZEMqSnOQGN47ki+qAvCORCrwYZlIQQ11tXOhCAwhYcy
 jJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324306; x=1699929106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OtwE/W/kGtkF44+Xl3AQKb9bLAFMuHoSpNqdnKmoL3o=;
 b=rCaLxPLRQZNKTwglKDmpBQA4LPu3VPqTUbNJYICFGEpLpcBkoLOjh6LABpCDFb8KTv
 tBj26HlRM4ogxVPj2ENF9W93dUInLIdwQEPFjqSmLe6g1vJDr0HxiuvHvQyhz6j17x32
 5qYFZuv9XNlMa+/wJMdDFE+1Dz9oG1q5T8bvK92gt0+jDTRHbci1I3AYRA4cNTDKTizC
 BqHc7TQftqlkhee41/f4HuzMq8NuiJdvIupl8Tczu8OWYc2braLLWfpG6x04rQM82086
 x5cEnbUsaR9cXwmrzkHsI43hcbHMHHGih9UwKbJmbo150jmxs+GMHL7637AXDWvN67el
 AKtA==
X-Gm-Message-State: AOJu0YxCEC1XdCXZy5pcsI1qH3m6r1IwmiPBlbaYOmBa2UsFWihnMGLM
 xkx1jEsFGbUzy5jydWyA5QBborz7Wtc8Wg==
X-Google-Smtp-Source: AGHT+IFFFULoww0ftTbtUveY3ni8n+YozDRdaPjvnDv2i5+dCXT19q/f4UINNHszdxFubBZCB4sp3A==
X-Received: by 2002:a17:902:c943:b0:1cc:5468:3284 with SMTP id
 i3-20020a170902c94300b001cc54683284mr1797068pla.23.1699324306641; 
 Mon, 06 Nov 2023 18:31:46 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:31:45 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/49] target/riscv: Replace Zvbb checking by Zvkb
Date: Tue,  7 Nov 2023 12:29:28 +1000
Message-ID: <20231107022946.1055027-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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

The Zvkb extension is a proper subset of the Zvbb extension and includes
following instructions:
  * vandn.[vv,vx]
  * vbrev8.v
  * vrev8.v
  * vrol.[vv,vx]
  * vror.[vv,vx,vi]

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231026151828.754279-5-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvvk.c.inc | 37 +++++++++++++++---------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
index e691519ed7..3801c16829 100644
--- a/target/riscv/insn_trans/trans_rvvk.c.inc
+++ b/target/riscv/insn_trans/trans_rvvk.c.inc
@@ -112,24 +112,27 @@ GEN_VX_MASKED_TRANS(vclmulh_vx, vclmul_vx_check)
         return false;                                            \
     }
 
-static bool zvbb_vv_check(DisasContext *s, arg_rmrr *a)
+static bool zvkb_vv_check(DisasContext *s, arg_rmrr *a)
 {
-    return opivv_check(s, a) && s->cfg_ptr->ext_zvbb == true;
+    return opivv_check(s, a) &&
+           (s->cfg_ptr->ext_zvbb == true || s->cfg_ptr->ext_zvkb == true);
 }
 
-static bool zvbb_vx_check(DisasContext *s, arg_rmrr *a)
+static bool zvkb_vx_check(DisasContext *s, arg_rmrr *a)
 {
-    return opivx_check(s, a) && s->cfg_ptr->ext_zvbb == true;
+    return opivx_check(s, a) &&
+           (s->cfg_ptr->ext_zvbb == true || s->cfg_ptr->ext_zvkb == true);
 }
 
 /* vrol.v[vx] */
-GEN_OPIVV_GVEC_TRANS_CHECK(vrol_vv, rotlv, zvbb_vv_check)
-GEN_OPIVX_GVEC_SHIFT_TRANS_CHECK(vrol_vx, rotls, zvbb_vx_check)
+GEN_OPIVV_GVEC_TRANS_CHECK(vrol_vv, rotlv, zvkb_vv_check)
+GEN_OPIVX_GVEC_SHIFT_TRANS_CHECK(vrol_vx, rotls, zvkb_vx_check)
 
 /* vror.v[vxi] */
-GEN_OPIVV_GVEC_TRANS_CHECK(vror_vv, rotrv, zvbb_vv_check)
-GEN_OPIVX_GVEC_SHIFT_TRANS_CHECK(vror_vx, rotrs, zvbb_vx_check)
-GEN_OPIVI_GVEC_TRANS_CHECK(vror_vi, IMM_TRUNC_SEW, vror_vx, rotri, zvbb_vx_check)
+GEN_OPIVV_GVEC_TRANS_CHECK(vror_vv, rotrv, zvkb_vv_check)
+GEN_OPIVX_GVEC_SHIFT_TRANS_CHECK(vror_vx, rotrs, zvkb_vx_check)
+GEN_OPIVI_GVEC_TRANS_CHECK(vror_vi, IMM_TRUNC_SEW, vror_vx, rotri,
+                           zvkb_vx_check)
 
 #define GEN_OPIVX_GVEC_TRANS_CHECK(NAME, SUF, CHECK)                     \
     static bool trans_##NAME(DisasContext *s, arg_rmrr *a)               \
@@ -147,8 +150,8 @@ GEN_OPIVI_GVEC_TRANS_CHECK(vror_vi, IMM_TRUNC_SEW, vror_vx, rotri, zvbb_vx_check
     }
 
 /* vandn.v[vx] */
-GEN_OPIVV_GVEC_TRANS_CHECK(vandn_vv, andc, zvbb_vv_check)
-GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvbb_vx_check)
+GEN_OPIVV_GVEC_TRANS_CHECK(vandn_vv, andc, zvkb_vv_check)
+GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvkb_vx_check)
 
 #define GEN_OPIV_TRANS(NAME, CHECK)                                        \
     static bool trans_##NAME(DisasContext *s, arg_rmr *a)                  \
@@ -188,8 +191,16 @@ static bool zvbb_opiv_check(DisasContext *s, arg_rmr *a)
            vext_check_ss(s, a->rd, a->rs2, a->vm);
 }
 
-GEN_OPIV_TRANS(vbrev8_v, zvbb_opiv_check)
-GEN_OPIV_TRANS(vrev8_v, zvbb_opiv_check)
+static bool zvkb_opiv_check(DisasContext *s, arg_rmr *a)
+{
+    return (s->cfg_ptr->ext_zvbb == true || s->cfg_ptr->ext_zvkb == true) &&
+           require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_ss(s, a->rd, a->rs2, a->vm);
+}
+
+GEN_OPIV_TRANS(vbrev8_v, zvkb_opiv_check)
+GEN_OPIV_TRANS(vrev8_v, zvkb_opiv_check)
 GEN_OPIV_TRANS(vbrev_v, zvbb_opiv_check)
 GEN_OPIV_TRANS(vclz_v, zvbb_opiv_check)
 GEN_OPIV_TRANS(vctz_v, zvbb_opiv_check)
-- 
2.41.0


