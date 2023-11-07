Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3867E3374
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:06:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CPG-0007nP-Oc; Mon, 06 Nov 2023 22:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COL-0006fa-Dc
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:38 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO4-0000eJ-14
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:34 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so4027704a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326257; x=1699931057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FgvfDwyIoGSK++AEaNdMmfoRCVSVHMXHgiFS4BjrPMw=;
 b=n2M1CqT/Ujz87SnTW2FineHWiWCH8ypSe/WODqijJgSc6izvfxXX4K3Jv8nP/blrxX
 sGSq56CQupQ7jy4d2eqp8YXeGNhma/xFVLVoePGHhB8Cgry2pkUFWlfFG+T+YOznI2sH
 Ukkkf2dTk4gMfsVqiWaZOOr4GXKK8Tv/zMBdOa6RaGDcQU9XPKU5gnqp+kqBtoCp4ejq
 xcAFKyv2fEWAZRIWncjlm4OEyMHw/UPN7bXwX/vdRdNNasly9FbFpCgTdiMPtJXOxQ+J
 jykMz6Qa+djnnHXQ4EKkI0cAJiZvb0FAYtQ8ykuSErizNUiqUJtEx+y00zkOmuaDVUFd
 KlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326257; x=1699931057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FgvfDwyIoGSK++AEaNdMmfoRCVSVHMXHgiFS4BjrPMw=;
 b=qhskNjHKXQrM2nJWojBnSAXHrXUYHlbnIhRduGBy0ejhHaUKdbClyY0ZEPP317nA/2
 bG6+pZ1wftfB3Vn2iDgeaO+0DqwD0VdMMyBfG+aZCLiidzdMe0qVnO0+5Ea9nPtUX+ck
 p4di1XVtYupcSkKEiy1eAKgTAyO+Sg++WokObWOetGDzi1tAmFuNytbsJvu+dOWIUH0/
 hRFJDV+L4iygEMqwnniwEl/F1GVYTqhGnabFb56TdlUoEJ4phPmxA5V7kJM6mrKtQH9O
 8UUJv0Zvtt46MOTm5BcEcFutiQHsclbEpubokJ+Dk0U6WoC+HpCWMb4oekqlAGqvN/c3
 16Fw==
X-Gm-Message-State: AOJu0YxmTJkTSk6T+dpIQ/8Eqg89U2hM6gB/WM+W5uD2af9+L+5Xokcn
 eGFfCLSxZ8ZmSk9RRxC5lIrnntiN7r9L5mZ2pMY=
X-Google-Smtp-Source: AGHT+IE9pRNogizZg0YfNooeAVG9c0QIqJpA1El9kIR5qqw7eReygB/sKmn0loowkodgb9u4z/N/rg==
X-Received: by 2002:a05:6a20:2589:b0:16b:c20d:f979 with SMTP id
 k9-20020a056a20258900b0016bc20df979mr36753973pzd.13.1699326256971; 
 Mon, 06 Nov 2023 19:04:16 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/85] target/hppa: Fix load in do_load_32
Date: Mon,  6 Nov 2023 19:02:53 -0800
Message-Id: <20231107030407.8979-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

The destination is TCGv_i32, so use tcg_gen_qemu_ld_i32
not tcg_gen_qemu_ld_reg.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index c8384fccd9..20e44ed528 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1430,7 +1430,7 @@ static void do_load_32(DisasContext *ctx, TCGv_i32 dest, unsigned rb,
 
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
              ctx->mmu_idx == MMU_PHYS_IDX);
-    tcg_gen_qemu_ld_reg(dest, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
+    tcg_gen_qemu_ld_i32(dest, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
     if (modify) {
         save_gpr(ctx, rb, ofs);
     }
-- 
2.34.1


