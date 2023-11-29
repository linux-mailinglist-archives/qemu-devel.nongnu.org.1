Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8F57FDDEA
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 18:05:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8NzD-00006a-VA; Wed, 29 Nov 2023 12:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1r8NzB-0008VH-PM
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 12:04:29 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1r8Nz4-0002xS-6u
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 12:04:29 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cfc985c92dso32690725ad.0
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 09:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1701277459; x=1701882259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJELkFuyfQDdSzTxppnb6dbBJrlb+WrSMBGUjwM60Kk=;
 b=BBjqnS1wOQLIg5ryETwt0TqyfjDLKgMzQfRwEMnauf+6o9yLKXvSl8UvsWDGuNtONC
 cG8HFbAJto53VRX5Nwh7VuO7JkFT+Nq3MAu7Z1vgFjiN/55IxsLxBfWVW9FtaAQc2Oan
 +tZ1oI5RfL2PwnrYAaBcGGey5h/iI/xuL32FyujCelkq9TCtxiw2rjnGrC+y3RTkGw3p
 ZTGkDgPonp/xuKyMFlFfpLcnb1X4nqGZZZc+Cj166GqRyIEVhhzRynR0KWzlJvtfT3D4
 oOJIqTno//hlsEiatamxa8JkkIWg2pGlFVvA2cmAz7youo8BJnGnzoGuxWQT5zJRXvgS
 vMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701277459; x=1701882259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJELkFuyfQDdSzTxppnb6dbBJrlb+WrSMBGUjwM60Kk=;
 b=oSbeEMa3l4KclReLfgF+u2Q1rosjnzHdtkNdMN37tqqQmg8pzIyPqKqC1Qk/T/KqMJ
 XASymDGz3MyU0o7Ljf8qYz7cBgWMyvTPVMMiRV5J1DXrGvT/ec4RdlEjyUNOIL5fNYn5
 t25arzsVb6YoHKdOUlCfJio4hvghtzFZLqHlYJ+O/fI2nhSz5Q9vbkjV53GePwtcOFaI
 Jz5yPKFZhEMcopPckr4ZDM577YVDP2fC+YSNn01Psjp9wLjUMko5nYsjKJ/WqnxG47KH
 LyVIpI3UpbXyXBtd87psmUY9iGL72Vv2C6aSnL21DMK54gtA80qhlRoOJNv3s9woIZ8I
 FVsA==
X-Gm-Message-State: AOJu0YyqW+v2EVj7Pr3HSj5pgZNGpiEyZuTTsuWzo3DRcakBIgruOL38
 4AD16zIcb4ulBa3H/GzB42eBg675C7fZJ1OLsNM23iYKnEDq1UxATPCdJaNyJP7vB3ckvmgor7a
 InSQ5eNNvrp0Kxh4CEmS/EY6IqgqDC4oXSf7JFAfdHesD/Z91avX3KpjkE6MJPFl5ZGRKStlonw
 oK
X-Google-Smtp-Source: AGHT+IGtISLNSYYlQnB2orEKvH+favtu3lmmMQSVNmGmJS4HhYsduK6E2/cKOIBHJd9Xz0i1f9bKQg==
X-Received: by 2002:a17:902:db0d:b0:1cf:cc0d:9600 with SMTP id
 m13-20020a170902db0d00b001cfcc0d9600mr12603628plx.24.1701277458610; 
 Wed, 29 Nov 2023 09:04:18 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 p5-20020a170902eac500b001cfc6838e30sm6921383pld.308.2023.11.29.09.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 09:04:18 -0800 (PST)
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
Subject: [PATCH 1/2] target/riscv: Add vill check for whole vector register
 move instructions
Date: Thu, 30 Nov 2023 01:03:57 +0800
Message-Id: <20231129170400.21251-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129170400.21251-1-max.chou@sifive.com>
References: <20231129170400.21251-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x630.google.com
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

The ratified version of RISC-V V spec section 16.6 says that
`The instructions operate as if EEW=SEW`.

So the whole vector register move instructions depend on the vtype
register that means the whole vector register move instructions should
raise an illegal-instruction exception when vtype.vill=1.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 78bd363310d..114ad87397f 100644
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
2.34.1


