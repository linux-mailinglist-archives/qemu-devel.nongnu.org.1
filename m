Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3B37E3393
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:08:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CPH-00085X-Vy; Mon, 06 Nov 2023 22:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COS-0006vf-6t
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:44 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COL-0000gk-4s
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:43 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc131e52f1so48057155ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326269; x=1699931069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nte4AsF0yU49KoFZ5WsKrCyyvXp9Hm4i6B93/Stt4MI=;
 b=OP/Dd8jpuZu2+iSjU0bANT7yY41o511w/QT6tj2nsQgfO31EO+lUvP3ab15ZSdWoIm
 O26U0rJzzwPastiu+LCPzAXEWQJQ4JA2JQVJ+2jMGtbIbS/pmUGgRjuSwu1x7FpkCp4z
 3tojIhvgwMPgEN2erBBtS+iJiJ7nZNuVDXsdzoDaD1VIusll2EUIL523Ttv/ha8KBBkg
 jJ7ffQMSz07lXcEDorJZ2w67Gve3+dLfqjbjfPTmIzC7sXPa9qU6iKhvBrEYFRkJq1W2
 a3On5XFdLyfSiya/COVdLem0Rt0hF2EJkxXDCOcNxX/Q5XqtcSdGEVG/tiT8ajFkUwF+
 Dblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326269; x=1699931069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nte4AsF0yU49KoFZ5WsKrCyyvXp9Hm4i6B93/Stt4MI=;
 b=Om8ZJQ/QKJizv+7Xf6Ye/Olxtx+80zWYiUnYms4jPiDQsdPLEEYXjXaC83/JG2jSfV
 w5SODE2V6J7Ruadm8ahRt3xriA1mRVfD8M/s6HlidCEo9IDCOWz7axJwpY+LOT0UAZmt
 zAXzAqFhPlzhuI6LupPo/UPsFNKGRIbHNgyHUF9XUE1PEx5z/c92ERhTSDDHCbqgN4de
 v2j0WGuFIPla6ACBsuQLOlrAwnWBZoIlWBqCvHSgz3JACa5Jv4S1haoKOOWS2RYfR2uE
 /FG/bJSgKZQb84RDdOk3q4dqm/1fqMpceNBeKelFDx8ZUTmGe5GYpy47cm6uABpEh0fU
 LV6g==
X-Gm-Message-State: AOJu0Yyl07KgHpkzRMubAwxjoMciVQnPgHcHdCdw10PXFVHpDadqCB69
 vxl2QXtxgR9A43jqGGElg6gIAKn2TLX1TaHLTrw=
X-Google-Smtp-Source: AGHT+IFqmTUuF9dSEqhOXYxRk5/ufmpQCHrxP2orE9e6WGjcf0CSuaBK/5ix7ZmyL0bKg9kcWdpaVg==
X-Received: by 2002:a17:902:dac6:b0:1cc:22db:cf3d with SMTP id
 q6-20020a170902dac600b001cc22dbcf3dmr2202497plx.15.1699326268936; 
 Mon, 06 Nov 2023 19:04:28 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/85] target/hppa: Use copy_iaoq_entry for link in do_ibranch
Date: Mon,  6 Nov 2023 19:03:09 -0800
Message-Id: <20231107030407.8979-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

We need to make sure the link is masked properly along the
use_nullify_skip path.  The other three settings of a link
register already use this.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 348fdb75e5..c2db2782f4 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1898,7 +1898,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_reg dest,
 
         nullify_over(ctx);
         if (link != 0) {
-            tcg_gen_movi_reg(cpu_gr[link], ctx->iaoq_n);
+            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
         }
         tcg_gen_lookup_and_goto_ptr();
         return nullify_end(ctx);
-- 
2.34.1


