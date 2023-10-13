Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A7B7C8140
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:59:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqH-0008Eh-6T; Fri, 13 Oct 2023 04:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDps-0007hK-T4
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:01 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpo-0000qS-2c
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:55 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32d834ec222so1764611f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186870; x=1697791670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oUeLQ5FNtxO4xUul+o67HioGPCgvhPiv+HcAuTgXB3U=;
 b=Gxl0Mu2AG72bXADimHx7dgTWIZN1kw8+klK9sEgmymuxxU0P8l6bXFhhuj8PdDlDEX
 zzozcLX67bR4jvdOWVN7C2O87xpyKg6PnjHQkVjfJVXfHPK/2jWvVcgtf2WzFpYaQG4D
 OsnK3zUf5rJ93nSRJ6mbjak/+C3tc65WMMjstJ7BV9JNFdQwO2K+vQI3aDXIUVnwFvPD
 9sWHWqVoBE70Y/Egmz6Rw0h8JkYgWK7DGKIQX7cJriKMDi0OtQbxPOgEi22VRxDscrTC
 At44+SF7wVMjGTG16COvBIP1qFD90k3P9NY5SqVSKgwBFTiKeT96gVxc/Ven1XwrR1jB
 +w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186870; x=1697791670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oUeLQ5FNtxO4xUul+o67HioGPCgvhPiv+HcAuTgXB3U=;
 b=n9fpb9gW31BZcLIx4qVoDF79w3iRCSNfrB+xJwsZCFj2SLJ7y919OYerYFcbtAaLf6
 25N2TImWo+lJtLlbHhSMm7/+dNYbDaG+RbyIxXPeNhaiL4usLCeHZ0q93hWOBIYHjn80
 apDZqv20SVcDdqQ+8XqXgms1vrLw/nodESzNvyibv0OgJtUEOCD0xK9SQ9nNTGyUtv/F
 tI+8w+44E3GQhp3X47CQFSAt0QR+7nBfaFYf8zxFr6385572Q0NZjvmjptxSHtpSPDiA
 pgwn+h5z4KfrJOB2U/MT+6BKAG96EoMY16vsl/TyKYPqZki4/11G1X8T3l7EZuJXiXHz
 G0kw==
X-Gm-Message-State: AOJu0YysKEfxAcn+U+zWb7kjOcOjbIIi3PBEQR5AwB2D0F4ADWpO00kX
 gR2nfLgeKikKjaGksRlTfOxh3StsrNfn6MyM4Sg=
X-Google-Smtp-Source: AGHT+IHhit1IgBh2JwRzBw4uCeBuMTHvIVaE4lmtnCnEZvBsrtbDhw7XMKiD+uf+hERqlc8C9fuagg==
X-Received: by 2002:a5d:4144:0:b0:31a:d4e4:4f63 with SMTP id
 c4-20020a5d4144000000b0031ad4e44f63mr21662006wrq.18.1697186869927; 
 Fri, 13 Oct 2023 01:47:49 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:49 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [RFC PATCH v3 21/78] target/sparc: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:49 +0300
Message-Id: <57dd1b027f919f1da814d8d7391e39d264723e18.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/sparc/ldst_helper.c | 4 ++--
 target/sparc/mmu_helper.c  | 6 +++---
 target/sparc/translate.c   | 3 ++-
 target/sparc/win_helper.c  | 1 +
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 78b03308ae..b233e40da5 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1522,7 +1522,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
             /* Hyperprivileged access only */
             sparc_raise_mmu_fault(cs, addr, false, false, 1, size, GETPC());
         }
-        /* fall through */
+        fallthrough;
     case ASI_HYP_SCRATCHPAD: /* UA2005 hyperprivileged scratchpad */
         {
             unsigned int i = (addr >> 3) & 0x7;
@@ -1865,7 +1865,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             /* Hyperprivileged access only */
             sparc_raise_mmu_fault(cs, addr, true, false, 1, size, GETPC());
         }
-        /* fall through */
+        fallthrough;
     case ASI_HYP_SCRATCHPAD: /* UA2005 hyperprivileged scratchpad */
         {
             unsigned int i = (addr >> 3) & 0x7;
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 453498c670..13f0430c5d 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -558,13 +558,13 @@ static int get_physical_address_data(CPUSPARCState *env, CPUTLBEntryFull *full,
         g_assert_not_reached();
     case MMU_USER_IDX:
         is_user = true;
-        /* fallthru */
+        fallthrough;
     case MMU_KERNEL_IDX:
         context = env->dmmu.mmu_primary_context & 0x1fff;
         break;
     case MMU_USER_SECONDARY_IDX:
         is_user = true;
-        /* fallthru */
+        fallthrough;
     case MMU_KERNEL_SECONDARY_IDX:
         context = env->dmmu.mmu_secondary_context & 0x1fff;
         break;
@@ -657,7 +657,7 @@ static int get_physical_address_code(CPUSPARCState *env, CPUTLBEntryFull *full,
         g_assert_not_reached();
     case MMU_USER_IDX:
         is_user = true;
-        /* fallthru */
+        fallthrough;
     case MMU_KERNEL_IDX:
         context = env->dmmu.mmu_primary_context & 0x1fff;
         break;
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f92ff80ac8..4f179473d7 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1123,6 +1123,7 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
         gen_helper_compute_psr(tcg_env);
         dc->cc_op = CC_OP_FLAGS;
         /* FALLTHRU */
+        fallthrough;
 
     case CC_OP_FLAGS:
         /* We're going to generate a boolean result.  */
@@ -2204,7 +2205,7 @@ static void gen_st_asi(DisasContext *dc, TCGv src, TCGv addr,
         /* in OpenSPARC T1+ CPUs TWINX ASIs in store instructions
          * are ST_BLKINIT_ ASIs */
 #endif
-        /* fall through */
+        fallthrough;
     case GET_ASI_DIRECT:
         gen_address_mask(dc, addr);
         tcg_gen_qemu_st_tl(src, addr, da.mem_idx, da.memop | MO_ALIGN);
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index 3a7c0ff943..0c54b63938 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -303,6 +303,7 @@ static inline uint64_t *get_gregset(CPUSPARCState *env, uint32_t pstate)
     default:
         trace_win_helper_gregset_error(pstate);
         /* fall through to normal set of global registers */
+        fallthrough;
     case 0:
         return env->bgregs;
     case PS_AG:
-- 
2.39.2


