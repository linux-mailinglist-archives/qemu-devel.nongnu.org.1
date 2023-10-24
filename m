Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 939E77D593E
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:00:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKkg-0000Qr-96; Tue, 24 Oct 2023 12:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKke-0000Oo-CM
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:59:32 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKkc-0002nA-OU
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:59:32 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9c2a0725825so700328466b.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698166769; x=1698771569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jl2Z3AQr2WkKHVAsoHGy9DTdbizbD7vdc1kSkoPPUTk=;
 b=pzANdjR6RnrL5EpZ78eDEcqfSPO9lt6imjSB8QAXJyYyn1Gz4Ixl5uCSws6VlCJdpc
 5aDKlaHylHqtRWaYMfJiTOhFKtYmRofv210wt2+bS4zINtR08mEA7z+aV358E4lsvDmr
 r/Xe4OktsAIVt+lBvyJcdjoUy096Ty26sKUj8B/64S2pnzjXSSO/9ieI/yD5wYbanS0M
 8R4P7AVVEXCYIwJxenF0JmNAF+OrFMgpsq7Ofpq9UtNl0cglknURfxuPB4//jIDKYsnH
 PFW7xk5P3u1C0lgQJJYapS9f1xplpCkyNasT1R1zql12AMffmLeHPDN9205f2JeqRWuX
 0+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698166769; x=1698771569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jl2Z3AQr2WkKHVAsoHGy9DTdbizbD7vdc1kSkoPPUTk=;
 b=lXmHF6jDEs2zyDe2P83r8E2niqiztYOXCAeWzdMWguUYWwjpT9LEyoFrLoP5FTkvEz
 pCKqhI/GsXg+GDSRwYtzsiW0B+G9KT64WTwJerm9JvdX68LDkcrqnOoNGPKds/lbIVYY
 G2l2bstNTx5C9lt0KJJDzAKlcBRoOAb3Gopic0BWeXNcaGPIR+mNFBeKB9fnBuohUz5H
 IqUfLEJcdRfxS/dAN2/aX8W7HUndXZsjS16A+WfKx8/Yhse/5bb8qk4U6GZ4/Ff1gS8h
 9p/55hxOVGfEKkQ8TnOhpW81rRIVWIFXVdnn1KQzjNVVvVqD0y+EdHeK0dlS7b6kLlb5
 fcGA==
X-Gm-Message-State: AOJu0YwZCbKYx2kANA1naVpKlPIFZnccCCh+5tPmcv3y4E4cIxJwQION
 Vlp7TQ9vyjetdHLa3lzlhPzWu3iAfLMcZWXf+D8=
X-Google-Smtp-Source: AGHT+IH5kU0pJwov6BpR894xsgBbH0q1IjmwFd6KQxKSiR05aQGIu2palxM8Qqdf9v8fjcUeICH+PQ==
X-Received: by 2002:a17:907:3206:b0:9be:4af4:f5f4 with SMTP id
 xg6-20020a170907320600b009be4af4f5f4mr10128752ejb.32.1698166768882; 
 Tue, 24 Oct 2023 09:59:28 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 17-20020a170906019100b009ad8d444be4sm8463539ejb.43.2023.10.24.09.59.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 09:59:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PATCH v2 4/9] target/mips: Use tcg_gen_extract_i32
Date: Tue, 24 Oct 2023 18:58:57 +0200
Message-ID: <20231024165903.40861-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024165903.40861-1-philmd@linaro.org>
References: <20231024165903.40861-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

Inspired-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/translate.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 13e43fa3b6..2586d9c85a 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1269,8 +1269,7 @@ static inline void gen_load_srsgpr(int from, int to)
         TCGv_ptr addr = tcg_temp_new_ptr();
 
         tcg_gen_ld_i32(t2, tcg_env, offsetof(CPUMIPSState, CP0_SRSCtl));
-        tcg_gen_shri_i32(t2, t2, CP0SRSCtl_PSS);
-        tcg_gen_andi_i32(t2, t2, 0xf);
+        tcg_gen_extract_i32(t2, t2, CP0SRSCtl_PSS, 4);
         tcg_gen_muli_i32(t2, t2, sizeof(target_ulong) * 32);
         tcg_gen_ext_i32_ptr(addr, t2);
         tcg_gen_add_ptr(addr, tcg_env, addr);
@@ -1289,8 +1288,7 @@ static inline void gen_store_srsgpr(int from, int to)
 
         gen_load_gpr(t0, from);
         tcg_gen_ld_i32(t2, tcg_env, offsetof(CPUMIPSState, CP0_SRSCtl));
-        tcg_gen_shri_i32(t2, t2, CP0SRSCtl_PSS);
-        tcg_gen_andi_i32(t2, t2, 0xf);
+        tcg_gen_extract_i32(t2, t2, CP0SRSCtl_PSS, 4);
         tcg_gen_muli_i32(t2, t2, sizeof(target_ulong) * 32);
         tcg_gen_ext_i32_ptr(addr, t2);
         tcg_gen_add_ptr(addr, tcg_env, addr);
@@ -8981,13 +8979,11 @@ static void gen_compute_branch1(DisasContext *ctx, uint32_t op,
         tcg_gen_extu_i32_tl(bcond, t0);
         goto likely;
     case OPC_BC1T:
-        tcg_gen_shri_i32(t0, fpu_fcr31, get_fp_bit(cc));
-        tcg_gen_andi_i32(t0, t0, 1);
+        tcg_gen_extract_i32(t0, fpu_fcr31, get_fp_bit(cc), 1);
         tcg_gen_extu_i32_tl(bcond, t0);
         goto not_likely;
     case OPC_BC1TL:
-        tcg_gen_shri_i32(t0, fpu_fcr31, get_fp_bit(cc));
-        tcg_gen_andi_i32(t0, t0, 1);
+        tcg_gen_extract_i32(t0, fpu_fcr31, get_fp_bit(cc), 1);
         tcg_gen_extu_i32_tl(bcond, t0);
     likely:
         ctx->hflags |= MIPS_HFLAG_BL;
-- 
2.41.0


