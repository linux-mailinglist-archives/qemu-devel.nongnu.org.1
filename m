Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1087CEA91
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:59:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEVj-0002Ef-VO; Wed, 18 Oct 2023 17:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVi-0002E5-IZ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:26 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVh-000561-0D
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:26 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-57bce354d94so3791014eaf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697666124; x=1698270924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8gelUNFkNxUiOo/PW3mwBHCQ9wwJJl5VkUEA5tOyCI=;
 b=Ylqou8GkiBxYC1OqFb5d9Of59YmiLOVt7RX/p/7BZjUs1gJViOJAlITaVk3Wafxy0F
 j+bPCfqcRs4qAWo3at8fEXXtcNQboYynr4Q2vJtaDBYP2zdQIAHBDcvLM9boenPYGgFk
 PZ/EMB5nmMBZxwmTOUI02JTygDXkaJf9j5C+2BCJdVjtCk0iqZYd6d/Q1RleWDvD78bi
 w4EcFAf5QS7M0kGhXeEAoqXMBi10JVvKGNjK2zMIZo5SezG2VuVW+FyAryh9GIwsC05V
 L+UOiLGtaRCnh+gh4bOYec8uJhlIjd1KYZOQcjajhRFUwjKWL3iopSJIAv7TtUtRacMn
 pEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697666124; x=1698270924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C8gelUNFkNxUiOo/PW3mwBHCQ9wwJJl5VkUEA5tOyCI=;
 b=LktfQGh4PohYIziMerRZQnfWgTN9lf69F5cBXzydybcvhYHoe3vFD3WgFr1n1rqMKj
 uNIBFsmqK2q5nLQBWSwJmOt9Hny28I0rx3t3TeV2gq9s4omE73ECiiJtV41iEdfqbY7P
 4n80+ZuAHPGHhyFhOImO3E7105CmGTR/YUPRtxT6xJP8A8+XTDX864nspl/hjUbjXI67
 8N7k6jha33vlctvzr34KB8Ea3ZZllf7j+ys0l2yNAX1fPGFxSJcIRBpLxNNLeLmSavik
 TXF9R76CeZgJnmqvjzxeHfMIR35c5E31DcDrIiBUh+PxAJqngxxAFv4PM/HV0nu2b1Ba
 IcwQ==
X-Gm-Message-State: AOJu0YyGM2BVgcuG7HcKYBEW3iUSf08Fh8Vn3QXmkWx7jmUAURGn1D9V
 MoVNfqQ5MOEvJP1O57hZDMTEcl/uSYEs5CbhEsA=
X-Google-Smtp-Source: AGHT+IHIEcg4m7ob2BnCuJ/l+z2uhfiiP2BUmOZzkPAoRsn0UuBK1nEWPUG1I5YPawYsHNyS8M9W+g==
X-Received: by 2002:a05:6359:100e:b0:12b:e47a:8191 with SMTP id
 ib14-20020a056359100e00b0012be47a8191mr249750rwb.16.1697666123735; 
 Wed, 18 Oct 2023 14:55:23 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r15-20020aa7962f000000b006889348ba6esm3796263pfg.127.2023.10.18.14.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:55:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 54/61] target/hppa: Implement HSHL, HSHR
Date: Wed, 18 Oct 2023 14:51:28 -0700
Message-Id: <20231018215135.1561375-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode |  5 +++++
 target/hppa/translate.c  | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index fb0f9d6dbd..f0c4866ca2 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -69,6 +69,7 @@
 &rrr_cf         t r1 r2 cf
 &rrr_cf_d       t r1 r2 cf d
 &rrr_cf_d_sh    t r1 r2 cf d sh
+&rri            t r i
 &rri_cf         t r i cf
 &rri_cf_d       t r i cf d
 
@@ -216,6 +217,10 @@ hadd_us         000010 ..... ..... 00000011 00 0 .....  @rrr
 
 havg            000010 ..... ..... 00000010 11 0 .....  @rrr
 
+hshl            111110 00000 r:5   100010 i:4  0 t:5    &rri
+hshr_s          111110 r:5   00000 110011 i:4  0 t:5    &rri
+hshr_u          111110 r:5   00000 110010 i:4  0 t:5    &rri
+
 hsub            000010 ..... ..... 00000001 11 0 .....  @rrr
 hsub_ss         000010 ..... ..... 00000001 01 0 .....  @rrr
 hsub_us         000010 ..... ..... 00000001 00 0 .....  @rrr
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index b3335ba595..b912673531 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2761,6 +2761,26 @@ static bool do_multimedia(DisasContext *ctx, arg_rrr *a,
     return nullify_end(ctx);
 }
 
+static bool do_multimedia_sh(DisasContext *ctx, arg_rri *a,
+                             void (*fn)(TCGv_i64, TCGv_i64, int64_t))
+{
+    TCGv_i64 r, dest;
+
+    if (!ctx->is_pa20) {
+        return false;
+    }
+
+    nullify_over(ctx);
+
+    r = load_gpr(ctx, a->r);
+    dest = dest_gpr(ctx, a->t);
+
+    fn(dest, r, a->i);
+    save_gpr(ctx, a->t, dest);
+
+    return nullify_end(ctx);
+}
+
 static bool trans_hadd(DisasContext *ctx, arg_rrr *a)
 {
     return do_multimedia(ctx, a, tcg_gen_vec_add16_i64);
@@ -2781,6 +2801,21 @@ static bool trans_havg(DisasContext *ctx, arg_rrr *a)
     return do_multimedia(ctx, a, gen_helper_havg);
 }
 
+static bool trans_hshl(DisasContext *ctx, arg_rri *a)
+{
+    return do_multimedia_sh(ctx, a, tcg_gen_vec_shl16i_i64);
+}
+
+static bool trans_hshr_s(DisasContext *ctx, arg_rri *a)
+{
+    return do_multimedia_sh(ctx, a, tcg_gen_vec_sar16i_i64);
+}
+
+static bool trans_hshr_u(DisasContext *ctx, arg_rri *a)
+{
+    return do_multimedia_sh(ctx, a, tcg_gen_vec_shr16i_i64);
+}
+
 static bool trans_hsub(DisasContext *ctx, arg_rrr *a)
 {
     return do_multimedia(ctx, a, tcg_gen_vec_sub16_i64);
-- 
2.34.1


