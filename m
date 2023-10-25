Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8E07D708F
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 17:16:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfaW-00057U-IB; Wed, 25 Oct 2023 11:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qvfaV-00057H-Ak
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:14:27 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qvfaT-0003b3-No
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:14:27 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6bd32d1a040so5807868b3a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 08:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1698246863; x=1698851663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CeuH98/Jn7U3mEiXrbYPk6TZIyqSxoArWfMyJGiEIgA=;
 b=jZbkiVQCWED4PyMLll65g+vf8y9qVHJ3/risrvUP87w/NKibJ+puAddTUgZfEd5e6X
 gGQrDvypg2xcXfgeTomtd1gzCUnQ1zXPAozT1FqZnjl0BzFSoBdUDXablnstF1O4Jksj
 H9BnEvCh5tqBaLYRS0fNJjB0KWZ7/9VqfqgtP/HKyXli9UlAhvfaJ7+EJBA9vGzawo6s
 VqtGjw96yBT1Wm6nOa+w+YrNfXuQDGc830H9XY5x1vDMTc2cSvjFP79mnzbIi28dsiNu
 tj5ASoHZhWIpvzZlhMW9q9MsgmMRQl3crzQoEe4msY3XkaRBVtX/D5sSw6sfvnOz9OKC
 u9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698246863; x=1698851663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CeuH98/Jn7U3mEiXrbYPk6TZIyqSxoArWfMyJGiEIgA=;
 b=kJ5OtZCh1Le3UBYyhLAVMQGjoV0dxYedz/fPIyBG18bt+bsydaO811jlx7oh84BGhU
 QxZRpt/YjcWSvJibIcH+zMklbNOsUt9s2p46B1jclTW2VREodSfCJQYX0t2poY1KI7K9
 my5Kmkaa5iPtYYiRmiBhkbuO2XD9a30nZC/Dwy6d8NvCo5DP46JatDE2cn0Q/jhM0IcA
 ksXUKbtJXPd5Oe+r2/71W2K2SxQz/ez0Azl8guNjjUWdSr2/jf4BKkOH182SsgugAAcI
 vQC2S8x8pnO2xGZjQVnwljisCnY+qjhMofFk1AocG8MkBR10YOdaq5WhDVYutQyHWcbP
 bypg==
X-Gm-Message-State: AOJu0YzTNcleB4OwjunxS/Fh0IZsRkErtKogi2w56xXxNEYhyQ3bjtx0
 iN0McGLih2BzJXrXXI+d0Ja2uvI7a2Z2YEUhgGDxpv2JQHiobcFmgLzgW21tRyjRyF+3ObxsXzt
 7NsGCtZlSR4E9xjxEdyielmlLmk/YQhs//9p5mXupyYxublY1FZY3vbBrRoJSiZHkyz7i390opM
 AC
X-Google-Smtp-Source: AGHT+IE89PdMGMXk0zWYEUt1M6ffLvdtSmEBaqCfRzDdk3n479TlV0NuiVRYwf08L5yxC59wPqzcfQ==
X-Received: by 2002:a05:6a00:158c:b0:690:fe13:1d28 with SMTP id
 u12-20020a056a00158c00b00690fe131d28mr18751411pfk.33.1698246862683; 
 Wed, 25 Oct 2023 08:14:22 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 w14-20020a63160e000000b005b8ebef9fa0sm2677807pgl.83.2023.10.25.08.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 08:14:22 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nazar Kazakov <nazar.kazakov@codethink.co.uk>,
 Lawrence Hunter <lawrence.hunter@codethink.co.uk>
Subject: [PATCH 04/14] target/riscv: Replace Zvbb checking by Zvkb
Date: Wed, 25 Oct 2023 23:13:28 +0800
Message-Id: <20231025151341.725477-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025151341.725477-1-max.chou@sifive.com>
References: <20231025151341.725477-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42f.google.com
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

The Zvkb extension is a proper subset of the Zvbb extension and includes
following instructions:
  * vandn.[vv,vx]
  * vbrev8.v
  * vrev8.v
  * vrol.[vv,vx]
  * vror.[vv,vx,vi]

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvvk.c.inc | 37 +++++++++++++++---------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
index e691519ed78..3801c16829d 100644
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
2.34.1


