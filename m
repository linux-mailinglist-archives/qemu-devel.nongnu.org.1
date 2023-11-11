Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DD57E879B
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 02:35:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1crL-00025B-7q; Fri, 10 Nov 2023 20:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1crI-00023p-CR
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:32:24 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1crG-0001ai-NU
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:32:24 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6c4884521f6so2419300b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 17:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699666341; x=1700271141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lo0lQlUWSBjMt9Vl8JT1SFLp9AI2+HeOXlIlVWGHESw=;
 b=HWY6gNUAmvN4I1Cm6vdcidCDGZKbe/vRsQSwcaXxRFmBJ3yJ9gz0jEXNK6CQ9OWI43
 W2icdiK8/Smmi2VhqnoWGB3ZmPI2KmK3VjHFrmztzyBpTpihSwM9BKrud8v6tEtsPLHC
 Mbr/0vkqHTuVtwlz3VsnanDkKZ2eHw2ef9wUBamAT7JCWH/gJEC8S7Ab/9CPqP/eotbA
 tWkTm/9ufsFQkDfxakN/3mUsaUtdjD19mj8YPsUU3ZvEUyAgalx7a3NR8zGN5zqqwGbr
 ZlxzJ/rfuzZhzzcH/FWWnHlsbj+bVNZIfl1E1sx4wi0ShnHfEcRXxxTuTWtQ4qWJoFS+
 v1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699666341; x=1700271141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lo0lQlUWSBjMt9Vl8JT1SFLp9AI2+HeOXlIlVWGHESw=;
 b=KKDxGO7V2EioBRq90IIgbNjzXgcWQ+fQtDjTMWr9Yjj5tg6fi3kmIQNTDFwQa7P8is
 HkEavqj5hOLqnaNlibVk8faop0ub7e503dEbQH66OeNy3CzwhExnORo/JzGABM0aPDix
 cRHa8L+qgWMCPcSYrhuB5JO02stEoT9QtGPUK/f1OC+WKQ4eqXjV18R867yHQtAO1E5g
 cIBj4PYNtW2lYTLLTzhwLWlv2mAJUIl49pz1dgK0ENGrPFxu+0rwGGJZ7jARAoI64nRc
 GVq0X+3ZI/fHVzcqJQ8FJxHVbgB0jwHTNYSExvsX99esAv6qbzvNGQV2TCLe5N0flOPz
 BfLQ==
X-Gm-Message-State: AOJu0YxjlPm7AaDBZJth/tNmUHcLXbXkJN9vZaVFWI0Y5DR4Rkh1A0Kp
 hPKNabxz1LP4hgqphCuBR0hHSY7XDfmfnQ40mBU=
X-Google-Smtp-Source: AGHT+IGTPQFJHG2Tnf4z3GJPavkZbYNoyeS2wMj/pYx5PBgj+fKGh/MeNk/aSRQGgOKXh2PXyJaaFQ==
X-Received: by 2002:a05:6a00:1d9b:b0:6bd:705b:56fb with SMTP id
 z27-20020a056a001d9b00b006bd705b56fbmr812005pfw.6.1699666341193; 
 Fri, 10 Nov 2023 17:32:21 -0800 (PST)
Received: from stoup.hsd1.or.comcast.net
 ([2601:1c0:5e02:2a20:a99c:45a6:14e9:ea6])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a62f20b000000b006c1221bc58bsm333502pfh.115.2023.11.10.17.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 17:32:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 05/11] target/hppa: Use PRIV_P_TO_MMU_IDX in helper_probe
Date: Fri, 10 Nov 2023 17:32:06 -0800
Message-Id: <20231111013212.229673-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111013212.229673-1-richard.henderson@linaro.org>
References: <20231111013212.229673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Direct privilege level to mmu_idx mapping has been
false for some time.  Provide the correct value to
hppa_get_physical_address.

Fixes: fa824d99f9b ("target/hppa: Switch to use MMU indices 11-15")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/op_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index a0e31c0c25..7f607c3afd 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -338,7 +338,7 @@ target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
 #ifdef CONFIG_USER_ONLY
     return page_check_range(addr, 1, want);
 #else
-    int prot, excp;
+    int prot, excp, mmu_idx;
     hwaddr phys;
 
     trace_hppa_tlb_probe(addr, level, want);
@@ -347,7 +347,8 @@ target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
         return 0;
     }
 
-    excp = hppa_get_physical_address(env, addr, level, 0, &phys,
+    mmu_idx = PRIV_P_TO_MMU_IDX(level, env->psw & PSW_P);
+    excp = hppa_get_physical_address(env, addr, mmu_idx, 0, &phys,
                                      &prot, NULL);
     if (excp >= 0) {
         if (env->psw & PSW_Q) {
-- 
2.34.1


