Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E79756EFA
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 23:36:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLVsH-0001y4-Pm; Mon, 17 Jul 2023 17:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLVsF-0001xk-5I
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:35:19 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLVsD-0007vT-Co
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:35:18 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-314319c0d3eso5169548f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 14:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689629715; x=1692221715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jzW4mOsCZL10lJkMKofhQQ9/QED2aRg9yunhluc/VfA=;
 b=wZzHGckTZWXBxsu/RvFsRphoBU80S0kjVkP/IQjMwCeo152CyLh7/ePWIySvP6kZG5
 1VXQRwi1/wxOiKkBZ1mQHUeJtg4XMPfSw2Hekv9489+GmWc3r8zCw+HgeAg7ZlmWXVKp
 fz4wvck5hdZkczQnDAoXEweoRnURsCI3I7QUNYafbj4W/T2GZ2NWan1dKZ2B/sJzxqHZ
 nZ9QDuC3E+/IxIyBpLzoLt1CRWZMzktlgAr6gemwS9cTbZmE7MkMW5u1wc/0nuHywdLP
 dsgZhkzMNCB2BHJ2cTx7Pp+Q9+vttVil3/jC4APwjApyL2RDMGk3D9qldXtkduFmmoPL
 guGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689629715; x=1692221715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jzW4mOsCZL10lJkMKofhQQ9/QED2aRg9yunhluc/VfA=;
 b=TjhaX8FRhmxiW33BwC6ENgQbooMy6NGTW7C1blhtWR9EoAY/xZpnPioXt6T7ytGm//
 9305JeTMjF5jlpVrmMyXyoDOQslDrXIhGJdefivzFm3P1iw+Dh9ZcyNVTojKhXzA2mLh
 qm26yJvom5xtdZFHUkvg60F7jnVkYdauXRL9IZvWIpUE4Ltj+7bmRM9/vUY+ZHjZJ3L+
 EY2MN/iwe3WGVIdgmb0U8H3+XswWupeTznqJJveA8YVLodx7VcgMGvG5L883qfMccIjR
 I7UgPV05ng3KMHXv0ZK6Jm0ol1GfdXpCaR28OD79bN1zJYlLGET+PBfwcz0T+BjE0GPq
 cr1Q==
X-Gm-Message-State: ABy/qLaexj804MxtL0erJb9oap4shX1KKoeTNs3EZCe6yixjyT93fbjO
 8pvpcM9BZ9d5PFDJkE20JoziI7wYCuwtO9VGMXo=
X-Google-Smtp-Source: APBJJlFpOnGNwpcaVflN9IjgCal9fW6OFfP0IwTAlRCrl2Ym+zKmoT4blEmu9ik3MyaXepA9CqZfFA==
X-Received: by 2002:a5d:5682:0:b0:314:37a9:f225 with SMTP id
 f2-20020a5d5682000000b0031437a9f225mr13309767wrv.40.1689629715493; 
 Mon, 17 Jul 2023 14:35:15 -0700 (PDT)
Received: from localhost.localdomain ([176.176.144.39])
 by smtp.gmail.com with ESMTPSA id
 w17-20020adfde91000000b00315a57f1128sm447031wrl.115.2023.07.17.14.35.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jul 2023 14:35:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH for-8.1 v2 1/2] target/mips: Pass directory/leaf shift values
 to walk_directory()
Date: Mon, 17 Jul 2023 23:35:03 +0200
Message-Id: <20230717213504.24777-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230717213504.24777-1-philmd@linaro.org>
References: <20230717213504.24777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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


