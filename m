Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAFF783ACE
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:22:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLii-0003Sm-Kw; Tue, 22 Aug 2023 03:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLig-0003SL-AR
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:22:30 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLid-0005CS-UF
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:22:30 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31c5c06e8bbso1098676f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688946; x=1693293746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lbOm492kfn2NnT5mbCpnVZcB+ILWfzeNs0XAfBSLLZg=;
 b=XUByU4zHhcDU6XPAiVF7PcVa2Cb5MgwSyY+HIwEuIaGM4orcyidCEMB9BQeRBTP9n4
 oj8NZSkpYD+kBddr2Jj1aOKE9A1P/04wGbTbMnO/ipsKZt+mj6L5SN0qqyDkdlwahdCE
 DUT9KfdsS6C7YWTa6puFPGYTUu7boZGAg4RnVA5SNepVlCR7dd27JSAGg42qqoLVy++9
 wVOqmatrhMIDtMGIBrstAyJ7aILz1oEJ1HI6nguzzwpKdZj/sdY4tvLRq809TXAxw0Ar
 V4Qv9TO/8UeIvlR2lTuxOxEajo/SHgWmd6/kasZX+zGgSQA6804f09EubyGRL2XbO9Kw
 7LtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688946; x=1693293746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lbOm492kfn2NnT5mbCpnVZcB+ILWfzeNs0XAfBSLLZg=;
 b=cRi8IWxMiTP+Uftf6fw1JqYCuuXQ3QpjLaT4JctPLomSPDzK+KooABLkfdskDi2QBd
 gcTPrl2peyMR+N16mvsPir8aJQQVk3AzXQTjo3Dzp0X5LZo5PEm8N/IlSiYF8+53Otxh
 /WFYtLK1iXkFuZaLOt2PlFe9KoDUCW/KJGmscMWX+bQeSGtCBP4ldMvHTZmhA3OyPtJX
 d1b6IMjZwbEPI1ixJ9hRWsTBNXUXcYhJmQecIda4BeTEJGfTB2EYbg/GVYoGjid2M8Dh
 35/YjVIP084ppY0oXglvUsw1XtYcuCtcHC3xtt6b/qaNoCU68fBIcG2jPr/McwE6DfIL
 dfKA==
X-Gm-Message-State: AOJu0Yzbrb8F7XR02VVmsERUnJvK/t6ovF0lK7YMTvZ5oZ6TJFTcCyQ+
 xmYKsReBNAo2jmYjExB0Hx2y5uq6sZ0PWIWhHRZxNw==
X-Google-Smtp-Source: AGHT+IGKXNg/SMtbub3t0isZp0uosgJCeY8eXF2uh7xQ6vunhjnwCs1g98okXPG8rNgLcL8e/lLC+A==
X-Received: by 2002:a5d:4ed2:0:b0:315:ae39:27c with SMTP id
 s18-20020a5d4ed2000000b00315ae39027cmr6906575wrv.70.1692688946407; 
 Tue, 22 Aug 2023 00:22:26 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 17-20020a05600c025100b003fefb94ccc9sm487062wmj.11.2023.08.22.00.22.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:22:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Jiajie Chen <c@jia.je>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH RESEND v5 19/19] target/loongarch: Add avail_IOCSR to check
 iocsr instructions
Date: Tue, 22 Aug 2023 09:22:19 +0200
Message-ID: <20230822072219.35719-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071405.35386-1-philmd@linaro.org>
References: <20230822071405.35386-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Song Gao <gaosong@loongson.cn>

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20230822032724.1353391-16-gaosong@loongson.cn>
---
 target/loongarch/translate.h                     |  2 +-
 .../loongarch/insn_trans/trans_privileged.c.inc  | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index db46e9aa0f..89b49a859e 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -23,7 +23,7 @@
 #define avail_LSPW(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSPW))
 #define avail_LAM(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM))
 #define avail_LSX(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSX))
-
+#define avail_IOCSR(C) (FIELD_EX32((C)->cpucfg1, CPUCFG1, IOCSR))
 
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
diff --git a/target/loongarch/insn_trans/trans_privileged.c.inc b/target/loongarch/insn_trans/trans_privileged.c.inc
index 099cd871f0..4cb701b4b5 100644
--- a/target/loongarch/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/insn_trans/trans_privileged.c.inc
@@ -312,14 +312,14 @@ static bool gen_iocsrwr(DisasContext *ctx, arg_rr *a,
     return true;
 }
 
-TRANS(iocsrrd_b, ALL, gen_iocsrrd, gen_helper_iocsrrd_b)
-TRANS(iocsrrd_h, ALL, gen_iocsrrd, gen_helper_iocsrrd_h)
-TRANS(iocsrrd_w, ALL, gen_iocsrrd, gen_helper_iocsrrd_w)
-TRANS(iocsrrd_d, ALL, gen_iocsrrd, gen_helper_iocsrrd_d)
-TRANS(iocsrwr_b, ALL, gen_iocsrwr, gen_helper_iocsrwr_b)
-TRANS(iocsrwr_h, ALL, gen_iocsrwr, gen_helper_iocsrwr_h)
-TRANS(iocsrwr_w, ALL, gen_iocsrwr, gen_helper_iocsrwr_w)
-TRANS(iocsrwr_d, ALL, gen_iocsrwr, gen_helper_iocsrwr_d)
+TRANS(iocsrrd_b, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_b)
+TRANS(iocsrrd_h, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_h)
+TRANS(iocsrrd_w, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_w)
+TRANS(iocsrrd_d, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_d)
+TRANS(iocsrwr_b, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_b)
+TRANS(iocsrwr_h, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_h)
+TRANS(iocsrwr_w, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_w)
+TRANS(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
 
 static void check_mmu_idx(DisasContext *ctx)
 {
-- 
2.41.0


