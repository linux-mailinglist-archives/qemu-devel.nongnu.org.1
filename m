Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D969761CA0
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 17:00:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJVP-0003RD-Iv; Tue, 25 Jul 2023 10:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJVN-0003QK-Lg
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:59:17 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJVJ-0001Dh-3x
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:59:17 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fd18b1d924so45472415e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 07:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690297151; x=1690901951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKc1nCq76nawigLZznM8ag7fG6Cw9/XuF4yM8SD334c=;
 b=CPqhoQd6FLmqn1MMGy3g8W4/8T9X+jlPCcQMS0UQOlDgh1o3xo/Qf9WOhkBvDhy0Qh
 UUrZSmxCKGsaMtHk/Bex/hGum32XTjxJ0q4F1FWGDHMpRP3sKHWSCscNA3eFxtNY5CYi
 ZzZo/Y5ByxCnyTTeP7KVF68zR3AT44p7W5MMudy1VYhPVjLVW5R2CefskZ/JswCz0Dip
 E1keItNma0paIsl0W3DFJqqttxC8KPUb9n4CnUpDGRWKQ3hMGaUI75UJe7bsU7FP/WrA
 3TDaPlBlE9tLixQN6m3Elhx7cwKCD5/pTefN/mV/A1RWS0L4r74s3GfUbLLbiz9xXQqe
 wo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690297151; x=1690901951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OKc1nCq76nawigLZznM8ag7fG6Cw9/XuF4yM8SD334c=;
 b=b5zYnnvA+96QYNX2qAEtjBrnjyVLfyxJLWncPeXpIQMDFWGn7oZpir9oXTZDBDFgRA
 L9CNUmuAINJzsKdovi+ODI+/lA5/YXOji9U0K/A7lnzc4LW4sZncCjm/tCYkoBxkk4b7
 4Lp/v+OTV4M2iGGs47od4kmLxZIm6DPtr3HNVSTLRAOR5gWm5tFqJkKAnw22xB1YF97t
 MLO3HcMo6hLCZUdVxCVscYuIz5dlRhXzc6rX3uoofDnisHHHNJpfMGJqqEmqodnTkQp7
 m9WgrrdtdLquHijFIodz3nokKpPNHdpMD0y/EuQaYgB1lqYRoErZiUr6yhZJZYnBHl/3
 hJmA==
X-Gm-Message-State: ABy/qLaDoZVRxFt3Hh89/oa6Rjzs4ICGmK8z8l9IDQQTDktAbXZTA6et
 Rb54lE+afK+taD1ZQhml6MczMoWe9E2SYJbkxuM=
X-Google-Smtp-Source: APBJJlHwoPkCNQ1kYSt21Q6MM+RHJMEmHQEmVgUGt2Y81aSEpt+W/DwlPv52e+Zzjz+Y+vDqaR5mpw==
X-Received: by 2002:a5d:5185:0:b0:314:dea:f1f8 with SMTP id
 k5-20020a5d5185000000b003140deaf1f8mr8847145wrv.11.1690297151578; 
 Tue, 25 Jul 2023 07:59:11 -0700 (PDT)
Received: from localhost.localdomain ([176.187.203.142])
 by smtp.gmail.com with ESMTPSA id
 b17-20020a5d40d1000000b00314417f5272sm16586989wrq.64.2023.07.25.07.59.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Jul 2023 07:59:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/10] target/mips: Pass directory/leaf shift values to
 walk_directory()
Date: Tue, 25 Jul 2023 16:58:26 +0200
Message-Id: <20230725145829.37782-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230725145829.37782-1-philmd@linaro.org>
References: <20230725145829.37782-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

We already evaluated directory_shift and leaf_shift in
page_table_walk_refill(), no need to do that again: pass
as argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20230717213504.24777-2-philmd@linaro.org>
---
 target/mips/tcg/sysemu/tlb_helper.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index e5e1e9dd3f..e7be649b02 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -623,18 +623,13 @@ static uint64_t get_tlb_entry_layout(CPUMIPSState *env, uint64_t entry,
 
 static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
         int directory_index, bool *huge_page, bool *hgpg_directory_hit,
-        uint64_t *pw_entrylo0, uint64_t *pw_entrylo1)
+        uint64_t *pw_entrylo0, uint64_t *pw_entrylo1,
+        int directory_shift, int leaf_shift)
 {
     int dph = (env->CP0_PWCtl >> CP0PC_DPH) & 0x1;
     int psn = (env->CP0_PWCtl >> CP0PC_PSN) & 0x3F;
     int hugepg = (env->CP0_PWCtl >> CP0PC_HUGEPG) & 0x1;
     int pf_ptew = (env->CP0_PWField >> CP0PF_PTEW) & 0x3F;
-    int ptew = (env->CP0_PWSize >> CP0PS_PTEW) & 0x3F;
-    int native_shift = (((env->CP0_PWSize >> CP0PS_PS) & 1) == 0) ? 2 : 3;
-    int directory_shift = (ptew > 1) ? -1 :
-            (hugepg && (ptew == 1)) ? native_shift + 1 : native_shift;
-    int leaf_shift = (ptew > 1) ? -1 :
-            (ptew == 1) ? native_shift + 1 : native_shift;
     uint32_t direntry_size = 1 << (directory_shift + 3);
     uint32_t leafentry_size = 1 << (leaf_shift + 3);
     uint64_t entry;
@@ -779,7 +774,8 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
     if (gdw > 0) {
         vaddr |= goffset;
         switch (walk_directory(env, &vaddr, pf_gdw, &huge_page, &hgpg_gdhit,
-                               &pw_entrylo0, &pw_entrylo1))
+                               &pw_entrylo0, &pw_entrylo1,
+                               directory_shift, leaf_shift))
         {
         case 0:
             return false;
@@ -795,7 +791,8 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
     if (udw > 0) {
         vaddr |= uoffset;
         switch (walk_directory(env, &vaddr, pf_udw, &huge_page, &hgpg_udhit,
-                               &pw_entrylo0, &pw_entrylo1))
+                               &pw_entrylo0, &pw_entrylo1,
+                               directory_shift, leaf_shift))
         {
         case 0:
             return false;
@@ -811,7 +808,8 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
     if (mdw > 0) {
         vaddr |= moffset;
         switch (walk_directory(env, &vaddr, pf_mdw, &huge_page, &hgpg_mdhit,
-                               &pw_entrylo0, &pw_entrylo1))
+                               &pw_entrylo0, &pw_entrylo1,
+                               directory_shift, leaf_shift))
         {
         case 0:
             return false;
-- 
2.38.1


