Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6F5735B6F
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:45:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBH4Y-0000Mn-PV; Mon, 19 Jun 2023 11:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBH46-0008Km-Bt
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:45:17 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBH43-0001bu-Bg
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:45:14 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f9b4a715d9so4160845e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687189509; x=1689781509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0IgDTRsgkFHbJj1quZg2A2du+YDx/wUdnTk5cAx5eEI=;
 b=yj8zFDa2y28vrv6Kqx9QdBSUNPf38g7SX+g3CjjTOqFRs5MwY6U2HfwufP/2930xWo
 vnFcO3eInNV5WOvkEkQ39/3JKi4fxKo2J5YQ4bZ2JSd6anM+YjpwsEGzRwGySJIsyp+Q
 6A5/iIkAEKq2YXcT1/Z6k1ZPiqM8rwraeIqjUg2xqnPfaDJhVs7oM5BpBW/jDJcNMBEO
 Bj4T97chjwyUtWsPmPiZwnAZEs9DrFNkgEy1ZNQp+mLnt80ozVN9AOlrZnvEZLMpx1tL
 Mfk8eKlT8554brmVEnGdWERIBfK8RKhGuunyTdmUmuOCLhbNPbrrsVr4H/JDPhbfyvzh
 ksrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687189509; x=1689781509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0IgDTRsgkFHbJj1quZg2A2du+YDx/wUdnTk5cAx5eEI=;
 b=L5ca65kYVA2WOflsY0jjY2kplZ8H/7jNJVFDbuOMeKiL5ncTluh9fhZI6AqkRiDEnP
 oF2VM7Ul8QUGr0C/mS7PvlMZgvjZJ9wKoFW3mzIzT0I11iaGfiTMB+0jgeWyWP6J+74n
 1MVzk0qgJTn8U/31bmt/eDRg9Kv4T2Zjb3OGCpNYLxObKyttBZWqC1zqic9kH7fcLpwV
 z1WIcdTqbwOeCNcaLYE7vf+/Z/NWpFuJHC62QnQwrFMo2zs5o50afEKecXnAnK+YKTbj
 hPX9WN8dKvAYYFNigx9hqJcLJ2ZeKHuvQMJU0mDwRvCdspM3D57wmmcJRBSR5tkWCbow
 4FvA==
X-Gm-Message-State: AC+VfDz2VZ+qDn7pXMMMgKXjfp1+0W0k4nXpS76g7LpxYW02PmyShOcs
 qc50iv+GVFpijgL6qiY3GOfIIhFdqSORw6I28Hw+Uw==
X-Google-Smtp-Source: ACHHUZ7fM+QKPDPaGBFkeE+qInFfr3ntgCxyo0spgLTvW415XsDZlOvZK5PF6YqeXiUABooipK8Wug==
X-Received: by 2002:a05:600c:1d20:b0:3f9:b18c:a1f3 with SMTP id
 l32-20020a05600c1d2000b003f9b18ca1f3mr2230570wms.1.1687189509552; 
 Mon, 19 Jun 2023 08:45:09 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 p21-20020a7bcc95000000b003f739a8bcc8sm48812wma.19.2023.06.19.08.44.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:45:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/34] target/arm/tcg: Extract VFP definitions to
 'helper-vfp.h.inc'
Date: Mon, 19 Jun 2023 17:42:38 +0200
Message-Id: <20230619154302.80350-11-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619154302.80350-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

helper.h is used by all units, but not all require the
VFP definitions. Move them (along with definitions in
helper-a64.h.inc) to a new header; the next commit will
remove it from the common helper.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h             | 167 +---------------------------
 target/arm/tcg/helper-a64.h.inc |   8 --
 target/arm/tcg/helper-vfp.h.inc | 189 ++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+), 174 deletions(-)
 create mode 100644 target/arm/tcg/helper-vfp.h.inc

diff --git a/target/arm/helper.h b/target/arm/helper.h
index dd12fee107..e81ea87d37 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -103,155 +103,6 @@ DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
 
 DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, tl, i32, i32, i32)
 
-DEF_HELPER_1(vfp_get_fpscr, i32, env)
-DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
-
-DEF_HELPER_3(vfp_addh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_adds, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_addd, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_subh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_subs, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_subd, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_mulh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_muls, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_muld, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_divh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_divs, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_divd, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_maxh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_maxs, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_maxd, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_minh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_mins, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_mind, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_maxnumh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_maxnums, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_maxnumd, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_minnumh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_minnums, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_minnumd, f64, f64, f64, ptr)
-DEF_HELPER_1(vfp_negh, f16, f16)
-DEF_HELPER_1(vfp_negs, f32, f32)
-DEF_HELPER_1(vfp_negd, f64, f64)
-DEF_HELPER_1(vfp_absh, f16, f16)
-DEF_HELPER_1(vfp_abss, f32, f32)
-DEF_HELPER_1(vfp_absd, f64, f64)
-DEF_HELPER_2(vfp_sqrth, f16, f16, env)
-DEF_HELPER_2(vfp_sqrts, f32, f32, env)
-DEF_HELPER_2(vfp_sqrtd, f64, f64, env)
-DEF_HELPER_3(vfp_cmph, void, f16, f16, env)
-DEF_HELPER_3(vfp_cmps, void, f32, f32, env)
-DEF_HELPER_3(vfp_cmpd, void, f64, f64, env)
-DEF_HELPER_3(vfp_cmpeh, void, f16, f16, env)
-DEF_HELPER_3(vfp_cmpes, void, f32, f32, env)
-DEF_HELPER_3(vfp_cmped, void, f64, f64, env)
-
-DEF_HELPER_2(vfp_fcvtds, f64, f32, env)
-DEF_HELPER_2(vfp_fcvtsd, f32, f64, env)
-DEF_HELPER_FLAGS_2(bfcvt, TCG_CALL_NO_RWG, i32, f32, ptr)
-DEF_HELPER_FLAGS_2(bfcvt_pair, TCG_CALL_NO_RWG, i32, i64, ptr)
-
-DEF_HELPER_2(vfp_uitoh, f16, i32, ptr)
-DEF_HELPER_2(vfp_uitos, f32, i32, ptr)
-DEF_HELPER_2(vfp_uitod, f64, i32, ptr)
-DEF_HELPER_2(vfp_sitoh, f16, i32, ptr)
-DEF_HELPER_2(vfp_sitos, f32, i32, ptr)
-DEF_HELPER_2(vfp_sitod, f64, i32, ptr)
-
-DEF_HELPER_2(vfp_touih, i32, f16, ptr)
-DEF_HELPER_2(vfp_touis, i32, f32, ptr)
-DEF_HELPER_2(vfp_touid, i32, f64, ptr)
-DEF_HELPER_2(vfp_touizh, i32, f16, ptr)
-DEF_HELPER_2(vfp_touizs, i32, f32, ptr)
-DEF_HELPER_2(vfp_touizd, i32, f64, ptr)
-DEF_HELPER_2(vfp_tosih, s32, f16, ptr)
-DEF_HELPER_2(vfp_tosis, s32, f32, ptr)
-DEF_HELPER_2(vfp_tosid, s32, f64, ptr)
-DEF_HELPER_2(vfp_tosizh, s32, f16, ptr)
-DEF_HELPER_2(vfp_tosizs, s32, f32, ptr)
-DEF_HELPER_2(vfp_tosizd, s32, f64, ptr)
-
-DEF_HELPER_3(vfp_toshh_round_to_zero, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_toslh_round_to_zero, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_touhh_round_to_zero, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_toulh_round_to_zero, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_toshs_round_to_zero, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_tosls_round_to_zero, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_touhs_round_to_zero, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_touls_round_to_zero, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_toshd_round_to_zero, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_tosld_round_to_zero, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_touhd_round_to_zero, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_tould_round_to_zero, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_touhh, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_toshh, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_toulh, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_toslh, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_touqh, i64, f16, i32, ptr)
-DEF_HELPER_3(vfp_tosqh, i64, f16, i32, ptr)
-DEF_HELPER_3(vfp_toshs, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_tosls, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_tosqs, i64, f32, i32, ptr)
-DEF_HELPER_3(vfp_touhs, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_touls, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_touqs, i64, f32, i32, ptr)
-DEF_HELPER_3(vfp_toshd, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_tosld, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_tosqd, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_touhd, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_tould, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_touqd, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_shtos, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_sltos, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_sqtos, f32, i64, i32, ptr)
-DEF_HELPER_3(vfp_uhtos, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_ultos, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_uqtos, f32, i64, i32, ptr)
-DEF_HELPER_3(vfp_shtod, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_sltod, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_sqtod, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_uhtod, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_ultod, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_uqtod, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_shtoh, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_uhtoh, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_sltoh, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_ultoh, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_sqtoh, f16, i64, i32, ptr)
-DEF_HELPER_3(vfp_uqtoh, f16, i64, i32, ptr)
-
-DEF_HELPER_3(vfp_shtos_round_to_nearest, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_sltos_round_to_nearest, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_uhtos_round_to_nearest, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_ultos_round_to_nearest, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_shtod_round_to_nearest, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_sltod_round_to_nearest, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_uhtod_round_to_nearest, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_ultod_round_to_nearest, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_shtoh_round_to_nearest, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_uhtoh_round_to_nearest, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_sltoh_round_to_nearest, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_ultoh_round_to_nearest, f16, i32, i32, ptr)
-
-DEF_HELPER_FLAGS_2(set_rmode, TCG_CALL_NO_RWG, i32, i32, ptr)
-
-DEF_HELPER_FLAGS_3(vfp_fcvt_f16_to_f32, TCG_CALL_NO_RWG, f32, f16, ptr, i32)
-DEF_HELPER_FLAGS_3(vfp_fcvt_f32_to_f16, TCG_CALL_NO_RWG, f16, f32, ptr, i32)
-DEF_HELPER_FLAGS_3(vfp_fcvt_f16_to_f64, TCG_CALL_NO_RWG, f64, f16, ptr, i32)
-DEF_HELPER_FLAGS_3(vfp_fcvt_f64_to_f16, TCG_CALL_NO_RWG, f16, f64, ptr, i32)
-
-DEF_HELPER_4(vfp_muladdd, f64, f64, f64, f64, ptr)
-DEF_HELPER_4(vfp_muladds, f32, f32, f32, f32, ptr)
-DEF_HELPER_4(vfp_muladdh, f16, f16, f16, f16, ptr)
-
-DEF_HELPER_FLAGS_2(recpe_f16, TCG_CALL_NO_RWG, f16, f16, ptr)
-DEF_HELPER_FLAGS_2(recpe_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
-DEF_HELPER_FLAGS_2(recpe_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
-DEF_HELPER_FLAGS_2(rsqrte_f16, TCG_CALL_NO_RWG, f16, f16, ptr)
-DEF_HELPER_FLAGS_2(rsqrte_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
-DEF_HELPER_FLAGS_2(rsqrte_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
-DEF_HELPER_FLAGS_1(recpe_u32, TCG_CALL_NO_RWG, i32, i32)
-DEF_HELPER_FLAGS_1(rsqrte_u32, TCG_CALL_NO_RWG, i32, i32)
 DEF_HELPER_FLAGS_4(neon_tbl, TCG_CALL_NO_RWG, i64, env, i32, i64, i64)
 
 DEF_HELPER_3(shl_cc, i32, env, i32, i32)
@@ -259,18 +110,6 @@ DEF_HELPER_3(shr_cc, i32, env, i32, i32)
 DEF_HELPER_3(sar_cc, i32, env, i32, i32)
 DEF_HELPER_3(ror_cc, i32, env, i32, i32)
 
-DEF_HELPER_FLAGS_2(rinth_exact, TCG_CALL_NO_RWG, f16, f16, ptr)
-DEF_HELPER_FLAGS_2(rints_exact, TCG_CALL_NO_RWG, f32, f32, ptr)
-DEF_HELPER_FLAGS_2(rintd_exact, TCG_CALL_NO_RWG, f64, f64, ptr)
-DEF_HELPER_FLAGS_2(rinth, TCG_CALL_NO_RWG, f16, f16, ptr)
-DEF_HELPER_FLAGS_2(rints, TCG_CALL_NO_RWG, f32, f32, ptr)
-DEF_HELPER_FLAGS_2(rintd, TCG_CALL_NO_RWG, f64, f64, ptr)
-
-DEF_HELPER_FLAGS_2(vjcvt, TCG_CALL_NO_RWG, i32, f64, env)
-DEF_HELPER_FLAGS_2(fjcvtzs, TCG_CALL_NO_RWG, i64, f64, ptr)
-
-DEF_HELPER_FLAGS_3(check_hcr_el2_trap, TCG_CALL_NO_WG, void, env, i32, i32)
-
 /* neon_helper.c */
 DEF_HELPER_FLAGS_3(neon_qadd_u8, TCG_CALL_NO_RWG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(neon_qadd_s8, TCG_CALL_NO_RWG, i32, env, i32, i32)
@@ -750,11 +589,6 @@ DEF_HELPER_FLAGS_5(gvec_fmlal_idx_a32, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_fmlal_idx_a64, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_2(frint32_s, TCG_CALL_NO_RWG, f32, f32, ptr)
-DEF_HELPER_FLAGS_2(frint64_s, TCG_CALL_NO_RWG, f32, f32, ptr)
-DEF_HELPER_FLAGS_2(frint32_d, TCG_CALL_NO_RWG, f64, f64, ptr)
-DEF_HELPER_FLAGS_2(frint64_d, TCG_CALL_NO_RWG, f64, f64, ptr)
-
 DEF_HELPER_FLAGS_3(gvec_ceq0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_ceq0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_clt0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
@@ -949,4 +783,5 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
 #include "tcg/helper-sme.h.inc"
 #endif
 
+#include "tcg/helper-vfp.h.inc"
 #include "tcg/helper-mve.h.inc"
diff --git a/target/arm/tcg/helper-a64.h.inc b/target/arm/tcg/helper-a64.h.inc
index 3d5957c11f..e6c518323e 100644
--- a/target/arm/tcg/helper-a64.h.inc
+++ b/target/arm/tcg/helper-a64.h.inc
@@ -22,15 +22,7 @@ DEF_HELPER_FLAGS_1(rbit64, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_2(msr_i_spsel, void, env, i32)
 DEF_HELPER_2(msr_i_daifset, void, env, i32)
 DEF_HELPER_2(msr_i_daifclear, void, env, i32)
-DEF_HELPER_3(vfp_cmph_a64, i64, f16, f16, ptr)
-DEF_HELPER_3(vfp_cmpeh_a64, i64, f16, f16, ptr)
-DEF_HELPER_3(vfp_cmps_a64, i64, f32, f32, ptr)
-DEF_HELPER_3(vfp_cmpes_a64, i64, f32, f32, ptr)
-DEF_HELPER_3(vfp_cmpd_a64, i64, f64, f64, ptr)
-DEF_HELPER_3(vfp_cmped_a64, i64, f64, f64, ptr)
 DEF_HELPER_FLAGS_4(simd_tblx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(vfp_mulxs, TCG_CALL_NO_RWG, f32, f32, f32, ptr)
-DEF_HELPER_FLAGS_3(vfp_mulxd, TCG_CALL_NO_RWG, f64, f64, f64, ptr)
 DEF_HELPER_FLAGS_3(neon_ceq_f64, TCG_CALL_NO_RWG, i64, i64, i64, ptr)
 DEF_HELPER_FLAGS_3(neon_cge_f64, TCG_CALL_NO_RWG, i64, i64, i64, ptr)
 DEF_HELPER_FLAGS_3(neon_cgt_f64, TCG_CALL_NO_RWG, i64, i64, i64, ptr)
diff --git a/target/arm/tcg/helper-vfp.h.inc b/target/arm/tcg/helper-vfp.h.inc
new file mode 100644
index 0000000000..67f04ea3ee
--- /dev/null
+++ b/target/arm/tcg/helper-vfp.h.inc
@@ -0,0 +1,189 @@
+/*
+ * ARM VFP helper definitions
+ *
+ * Copyright (c) 2007 CodeSourcery.
+ * Written by Paul Brook
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+DEF_HELPER_1(vfp_get_fpscr, i32, env)
+DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
+
+DEF_HELPER_3(vfp_addh, f16, f16, f16, ptr)
+DEF_HELPER_3(vfp_adds, f32, f32, f32, ptr)
+DEF_HELPER_3(vfp_addd, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_subh, f16, f16, f16, ptr)
+DEF_HELPER_3(vfp_subs, f32, f32, f32, ptr)
+DEF_HELPER_3(vfp_subd, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_mulh, f16, f16, f16, ptr)
+DEF_HELPER_3(vfp_muls, f32, f32, f32, ptr)
+DEF_HELPER_3(vfp_muld, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_divh, f16, f16, f16, ptr)
+DEF_HELPER_3(vfp_divs, f32, f32, f32, ptr)
+DEF_HELPER_3(vfp_divd, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_maxh, f16, f16, f16, ptr)
+DEF_HELPER_3(vfp_maxs, f32, f32, f32, ptr)
+DEF_HELPER_3(vfp_maxd, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_minh, f16, f16, f16, ptr)
+DEF_HELPER_3(vfp_mins, f32, f32, f32, ptr)
+DEF_HELPER_3(vfp_mind, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_maxnumh, f16, f16, f16, ptr)
+DEF_HELPER_3(vfp_maxnums, f32, f32, f32, ptr)
+DEF_HELPER_3(vfp_maxnumd, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_minnumh, f16, f16, f16, ptr)
+DEF_HELPER_3(vfp_minnums, f32, f32, f32, ptr)
+DEF_HELPER_3(vfp_minnumd, f64, f64, f64, ptr)
+DEF_HELPER_1(vfp_negh, f16, f16)
+DEF_HELPER_1(vfp_negs, f32, f32)
+DEF_HELPER_1(vfp_negd, f64, f64)
+DEF_HELPER_1(vfp_absh, f16, f16)
+DEF_HELPER_1(vfp_abss, f32, f32)
+DEF_HELPER_1(vfp_absd, f64, f64)
+DEF_HELPER_2(vfp_sqrth, f16, f16, env)
+DEF_HELPER_2(vfp_sqrts, f32, f32, env)
+DEF_HELPER_2(vfp_sqrtd, f64, f64, env)
+DEF_HELPER_3(vfp_cmph, void, f16, f16, env)
+DEF_HELPER_3(vfp_cmps, void, f32, f32, env)
+DEF_HELPER_3(vfp_cmpd, void, f64, f64, env)
+DEF_HELPER_3(vfp_cmpeh, void, f16, f16, env)
+DEF_HELPER_3(vfp_cmpes, void, f32, f32, env)
+DEF_HELPER_3(vfp_cmped, void, f64, f64, env)
+
+DEF_HELPER_2(vfp_fcvtds, f64, f32, env)
+DEF_HELPER_2(vfp_fcvtsd, f32, f64, env)
+DEF_HELPER_FLAGS_2(bfcvt, TCG_CALL_NO_RWG, i32, f32, ptr)
+DEF_HELPER_FLAGS_2(bfcvt_pair, TCG_CALL_NO_RWG, i32, i64, ptr)
+
+DEF_HELPER_2(vfp_uitoh, f16, i32, ptr)
+DEF_HELPER_2(vfp_uitos, f32, i32, ptr)
+DEF_HELPER_2(vfp_uitod, f64, i32, ptr)
+DEF_HELPER_2(vfp_sitoh, f16, i32, ptr)
+DEF_HELPER_2(vfp_sitos, f32, i32, ptr)
+DEF_HELPER_2(vfp_sitod, f64, i32, ptr)
+
+DEF_HELPER_2(vfp_touih, i32, f16, ptr)
+DEF_HELPER_2(vfp_touis, i32, f32, ptr)
+DEF_HELPER_2(vfp_touid, i32, f64, ptr)
+DEF_HELPER_2(vfp_touizh, i32, f16, ptr)
+DEF_HELPER_2(vfp_touizs, i32, f32, ptr)
+DEF_HELPER_2(vfp_touizd, i32, f64, ptr)
+DEF_HELPER_2(vfp_tosih, s32, f16, ptr)
+DEF_HELPER_2(vfp_tosis, s32, f32, ptr)
+DEF_HELPER_2(vfp_tosid, s32, f64, ptr)
+DEF_HELPER_2(vfp_tosizh, s32, f16, ptr)
+DEF_HELPER_2(vfp_tosizs, s32, f32, ptr)
+DEF_HELPER_2(vfp_tosizd, s32, f64, ptr)
+
+DEF_HELPER_3(vfp_toshh_round_to_zero, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_toslh_round_to_zero, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_touhh_round_to_zero, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_toulh_round_to_zero, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_toshs_round_to_zero, i32, f32, i32, ptr)
+DEF_HELPER_3(vfp_tosls_round_to_zero, i32, f32, i32, ptr)
+DEF_HELPER_3(vfp_touhs_round_to_zero, i32, f32, i32, ptr)
+DEF_HELPER_3(vfp_touls_round_to_zero, i32, f32, i32, ptr)
+DEF_HELPER_3(vfp_toshd_round_to_zero, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_tosld_round_to_zero, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_touhd_round_to_zero, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_tould_round_to_zero, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_touhh, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_toshh, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_toulh, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_toslh, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_touqh, i64, f16, i32, ptr)
+DEF_HELPER_3(vfp_tosqh, i64, f16, i32, ptr)
+DEF_HELPER_3(vfp_toshs, i32, f32, i32, ptr)
+DEF_HELPER_3(vfp_tosls, i32, f32, i32, ptr)
+DEF_HELPER_3(vfp_tosqs, i64, f32, i32, ptr)
+DEF_HELPER_3(vfp_touhs, i32, f32, i32, ptr)
+DEF_HELPER_3(vfp_touls, i32, f32, i32, ptr)
+DEF_HELPER_3(vfp_touqs, i64, f32, i32, ptr)
+DEF_HELPER_3(vfp_toshd, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_tosld, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_tosqd, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_touhd, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_tould, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_touqd, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_shtos, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_sltos, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_sqtos, f32, i64, i32, ptr)
+DEF_HELPER_3(vfp_uhtos, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_ultos, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_uqtos, f32, i64, i32, ptr)
+DEF_HELPER_3(vfp_shtod, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_sltod, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_sqtod, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_uhtod, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_ultod, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_uqtod, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_shtoh, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_uhtoh, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_sltoh, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_ultoh, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_sqtoh, f16, i64, i32, ptr)
+DEF_HELPER_3(vfp_uqtoh, f16, i64, i32, ptr)
+
+DEF_HELPER_3(vfp_shtos_round_to_nearest, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_sltos_round_to_nearest, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_uhtos_round_to_nearest, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_ultos_round_to_nearest, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_shtod_round_to_nearest, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_sltod_round_to_nearest, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_uhtod_round_to_nearest, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_ultod_round_to_nearest, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_shtoh_round_to_nearest, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_uhtoh_round_to_nearest, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_sltoh_round_to_nearest, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_ultoh_round_to_nearest, f16, i32, i32, ptr)
+
+DEF_HELPER_FLAGS_2(set_rmode, TCG_CALL_NO_RWG, i32, i32, ptr)
+
+DEF_HELPER_FLAGS_3(vfp_fcvt_f16_to_f32, TCG_CALL_NO_RWG, f32, f16, ptr, i32)
+DEF_HELPER_FLAGS_3(vfp_fcvt_f32_to_f16, TCG_CALL_NO_RWG, f16, f32, ptr, i32)
+DEF_HELPER_FLAGS_3(vfp_fcvt_f16_to_f64, TCG_CALL_NO_RWG, f64, f16, ptr, i32)
+DEF_HELPER_FLAGS_3(vfp_fcvt_f64_to_f16, TCG_CALL_NO_RWG, f16, f64, ptr, i32)
+
+DEF_HELPER_4(vfp_muladdd, f64, f64, f64, f64, ptr)
+DEF_HELPER_4(vfp_muladds, f32, f32, f32, f32, ptr)
+DEF_HELPER_4(vfp_muladdh, f16, f16, f16, f16, ptr)
+
+DEF_HELPER_FLAGS_2(recpe_f16, TCG_CALL_NO_RWG, f16, f16, ptr)
+DEF_HELPER_FLAGS_2(recpe_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
+DEF_HELPER_FLAGS_2(recpe_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
+DEF_HELPER_FLAGS_2(rsqrte_f16, TCG_CALL_NO_RWG, f16, f16, ptr)
+DEF_HELPER_FLAGS_2(rsqrte_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
+DEF_HELPER_FLAGS_2(rsqrte_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
+DEF_HELPER_FLAGS_1(recpe_u32, TCG_CALL_NO_RWG, i32, i32)
+DEF_HELPER_FLAGS_1(rsqrte_u32, TCG_CALL_NO_RWG, i32, i32)
+
+DEF_HELPER_FLAGS_2(rinth_exact, TCG_CALL_NO_RWG, f16, f16, ptr)
+DEF_HELPER_FLAGS_2(rints_exact, TCG_CALL_NO_RWG, f32, f32, ptr)
+DEF_HELPER_FLAGS_2(rintd_exact, TCG_CALL_NO_RWG, f64, f64, ptr)
+DEF_HELPER_FLAGS_2(rinth, TCG_CALL_NO_RWG, f16, f16, ptr)
+DEF_HELPER_FLAGS_2(rints, TCG_CALL_NO_RWG, f32, f32, ptr)
+DEF_HELPER_FLAGS_2(rintd, TCG_CALL_NO_RWG, f64, f64, ptr)
+
+DEF_HELPER_FLAGS_2(vjcvt, TCG_CALL_NO_RWG, i32, f64, env)
+DEF_HELPER_FLAGS_2(fjcvtzs, TCG_CALL_NO_RWG, i64, f64, ptr)
+
+DEF_HELPER_FLAGS_3(check_hcr_el2_trap, TCG_CALL_NO_WG, void, env, i32, i32)
+
+DEF_HELPER_FLAGS_2(frint32_s, TCG_CALL_NO_RWG, f32, f32, ptr)
+DEF_HELPER_FLAGS_2(frint64_s, TCG_CALL_NO_RWG, f32, f32, ptr)
+DEF_HELPER_FLAGS_2(frint32_d, TCG_CALL_NO_RWG, f64, f64, ptr)
+DEF_HELPER_FLAGS_2(frint64_d, TCG_CALL_NO_RWG, f64, f64, ptr)
+
+#ifdef TARGET_AARCH64
+
+DEF_HELPER_3(vfp_cmph_a64, i64, f16, f16, ptr)
+DEF_HELPER_3(vfp_cmpeh_a64, i64, f16, f16, ptr)
+DEF_HELPER_3(vfp_cmps_a64, i64, f32, f32, ptr)
+DEF_HELPER_3(vfp_cmpes_a64, i64, f32, f32, ptr)
+DEF_HELPER_3(vfp_cmpd_a64, i64, f64, f64, ptr)
+DEF_HELPER_3(vfp_cmped_a64, i64, f64, f64, ptr)
+
+DEF_HELPER_FLAGS_3(vfp_mulxs, TCG_CALL_NO_RWG, f32, f32, f32, ptr)
+DEF_HELPER_FLAGS_3(vfp_mulxd, TCG_CALL_NO_RWG, f64, f64, f64, ptr)
+
+#endif
-- 
2.38.1


