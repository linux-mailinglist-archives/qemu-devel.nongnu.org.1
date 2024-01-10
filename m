Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B5582A437
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:48:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhKh-0004ye-C4; Wed, 10 Jan 2024 17:46:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKC-0004rK-Jz
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:28 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKA-0002w8-EV
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:27 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-429af318342so8665391cf.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926723; x=1705531523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fGroRAMABW6rD6Q1rW6plntl0iLNiILFnyK4nwakVJo=;
 b=NXKtMUaLe38dhg1PSEiB76sdX7DPZcNErV7r7SwTqgg/MteW7aobMbmfjKQOO2PWBX
 QSBbtEHuawjnrlkW/YbsBkygnKIxB9+8dSE9mp6tvFIAJAK5vOBHr3ArW9oAGDXn+JiJ
 Uw5BQkYQ7uhj4ImZ7PePilr3Gn+mz2hU3Wgk133PFfyIclgcGseotHGz/Z00u0x3Rd1p
 PF9DeVnI5+4PZdYYrL0PDnsv/et6MYgdD8YwjT7nuTn7A+dorAs4Fs6xbyoHGN6xYmJ5
 p6IMbuHg/+1q+6DIytS4SLpoR9Zsqe5ao/zdzWsi6jqFyTc2f7FEJ0CxAm/X53gnQ6Gg
 WlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926723; x=1705531523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fGroRAMABW6rD6Q1rW6plntl0iLNiILFnyK4nwakVJo=;
 b=ZLRwb+n07KgZjMyOv9xPucQZQgXa4iJL8fr5pwmlbIa++249Y09SOOVOGcSuMqXEej
 Rg9y29Mt6XUpxTLoRJI7ITdTSyLQIdXV9/QtEdK92d2YEE1RVbJw7ZOw5FEIqzTSrznr
 FX/z826LMvJV9+q3ihNVTb1ugv1AagHaWyWeo6k7B/hDM1Q/a//RBF+28IgOeFNqyoFu
 JSCoBW7NTHehT03JzqSABJadvqkstu8NwgSg6iDTKAvxL8WXDm45wDzdD5XPVarUF8XO
 Bn55ekX43h5pegz89pmASTIEBMv6Q/pByVtx2p4A27mnBXC8Vn6ndjznXxuDscfp37ZS
 bv3Q==
X-Gm-Message-State: AOJu0YyWSOifzyQI+tgSECFejgsIf78q76Teitl3gkS35GnsEXIv/wq9
 cEyCzZSFFmnOF+u11ZO9ZIMCJh8CfYYzu4Q6gYHcYdXU7VBwqC6I
X-Google-Smtp-Source: AGHT+IFV9WQHgoNkQ1Xp5ZUPImEgO3ZA93PxxBoVNEqXdeW7hVyrqKdK8CXGHZj+p2XVX/OIK6M8tg==
X-Received: by 2002:a05:622a:4b:b0:429:af00:8be with SMTP id
 y11-20020a05622a004b00b00429af0008bemr336892qtw.82.1704926723391; 
 Wed, 10 Jan 2024 14:45:23 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:45:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 10/38] target/alpha: Use TCG_COND_TST{EQ, NE} for CMOVLB{C,
 S}
Date: Thu, 11 Jan 2024 09:43:40 +1100
Message-Id: <20240110224408.10444-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x830.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 49e6a7b62d..c7daf46de7 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1676,16 +1676,12 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x14:
             /* CMOVLBS */
-            tmp = tcg_temp_new();
-            tcg_gen_andi_i64(tmp, va, 1);
-            tcg_gen_movcond_i64(TCG_COND_NE, vc, tmp, load_zero(ctx),
+            tcg_gen_movcond_i64(TCG_COND_TSTNE, vc, va, tcg_constant_i64(1),
                                 vb, load_gpr(ctx, rc));
             break;
         case 0x16:
             /* CMOVLBC */
-            tmp = tcg_temp_new();
-            tcg_gen_andi_i64(tmp, va, 1);
-            tcg_gen_movcond_i64(TCG_COND_EQ, vc, tmp, load_zero(ctx),
+            tcg_gen_movcond_i64(TCG_COND_TSTEQ, vc, va, tcg_constant_i64(1),
                                 vb, load_gpr(ctx, rc));
             break;
         case 0x20:
-- 
2.34.1


