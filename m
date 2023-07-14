Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EC4753F43
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 17:48:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKL0b-0007IF-LC; Fri, 14 Jul 2023 11:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0Y-0007G9-7A
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:47:02 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0T-00076k-J0
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:47:01 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-314172bac25so2170090f8f.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 08:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689349615; x=1691941615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mAzSZlytbR1t1ZIQhjeYZyBJFO870QY6aIUEWQM1ovA=;
 b=M6KVwi48oYkjMrtQqacy5uJpo+d28ELanGOwFj21u9zFlTvEfMsd5D3IgE5m5MpA0Z
 X0QJNgmHGXwdVdirzD1U/6cMETxxfjlHHsDwGysEgxjnNyJlUxsqtsqQWsn+I44GzX7f
 ePDzLuDFlbnTTaEOVaR1xr2O7D6ZhgU4b+VbkwVNonWspZ/Cs3PjfQqlE4NDv/oBAPP/
 zsIm7poPfVPBp7+M9HLdO3xNGKPITJduoNS/PG8rWlvs8t9SdfLWIsBHEGMaJ7Gt7so2
 oDkx4ofPyc756rLrDJ170moM4TV3XXHsJ03/ijfjgi2ehlTDyX15dVknFZz9D7oMKnRH
 7t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689349615; x=1691941615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAzSZlytbR1t1ZIQhjeYZyBJFO870QY6aIUEWQM1ovA=;
 b=Pz9+4sHHU806zlPXRZ8x9y2yooyInTe0/cAhxNC/U2S9QrJGAcaEYnD9FnfLZFUzkD
 TE45K67BezqVPkaKM+IZM1lQNYJJDVfJvd8jI/XxfGuUCoIcmG1qbrKxhcOq9b5yaOnD
 RW/YQD1TV71K9zTVCoRJCieiPo+DYMAFFsAMeVDPvsu1A1oVPKiVgnL8UkozoiVVe+oj
 2Zh5uFU4LS4IfW0CYB1yNTu1VWTrSTPQnRCu83DxUIpVDtdkKsEaSz827aJCRbZcTqSE
 pNZTxXfgxAfRVPQeYBbB9GPtIxomZOZrkAjpkxCQ3WfH7c8eERq0OrrJfTPc4Dbbqt/J
 wzIQ==
X-Gm-Message-State: ABy/qLbF8RQbulRr6GAN1ATt2QZPS/1/hCXVzeTEES0yzsaJuwjtNFUI
 pZj8WyADDJpA4dh3DpK9L8m9DiLjG0DDtkYzjvA=
X-Google-Smtp-Source: APBJJlGe3a7TdfdAlCIFcA/vYLGHjiUnVvu7ZgXXzIp6Q83HcnlkTtV5PT1PtcRLRvfJMboxkmvZAg==
X-Received: by 2002:a5d:5087:0:b0:314:3f82:7959 with SMTP id
 a7-20020a5d5087000000b003143f827959mr4147858wrt.14.1689349615756; 
 Fri, 14 Jul 2023 08:46:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a5d49d0000000b003143bb5ecd5sm11214025wrs.69.2023.07.14.08.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 08:46:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 10/14] target/arm/ptw: Drop S1Translate::out_secure
Date: Fri, 14 Jul 2023 16:46:44 +0100
Message-Id: <20230714154648.327466-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714154648.327466-1-peter.maydell@linaro.org>
References: <20230714154648.327466-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

We only use S1Translate::out_secure in two places, where we are
setting up MemTxAttrs for a page table load. We can use
arm_space_is_secure(ptw->out_space) instead, which guarantees
that we're setting the MemTxAttrs secure and space fields
consistently, and allows us to drop the out_secure field in
S1Translate entirely.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 77b8382ceff..2be6bf302b0 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -63,7 +63,6 @@ typedef struct S1Translate {
      * Stage 2 is indicated by in_mmu_idx set to ARMMMUIdx_Stage2{,_S}.
      */
     bool in_s1_is_el0;
-    bool out_secure;
     bool out_rw;
     bool out_be;
     ARMSecuritySpace out_space;
@@ -551,7 +550,6 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         pte_attrs = s2.cacheattrs.attrs;
         ptw->out_host = NULL;
         ptw->out_rw = false;
-        ptw->out_secure = s2.f.attrs.secure;
         ptw->out_space = s2.f.attrs.space;
     } else {
 #ifdef CONFIG_TCG
@@ -570,7 +568,6 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         ptw->out_phys = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
         ptw->out_rw = full->prot & PAGE_WRITE;
         pte_attrs = full->pte_attrs;
-        ptw->out_secure = full->attrs.secure;
         ptw->out_space = full->attrs.space;
 #else
         g_assert_not_reached();
@@ -628,8 +625,8 @@ static uint32_t arm_ldl_ptw(CPUARMState *env, S1Translate *ptw,
     } else {
         /* Page tables are in MMIO. */
         MemTxAttrs attrs = {
-            .secure = ptw->out_secure,
             .space = ptw->out_space,
+            .secure = arm_space_is_secure(ptw->out_space),
         };
         AddressSpace *as = arm_addressspace(cs, attrs);
         MemTxResult result = MEMTX_OK;
@@ -674,8 +671,8 @@ static uint64_t arm_ldq_ptw(CPUARMState *env, S1Translate *ptw,
     } else {
         /* Page tables are in MMIO. */
         MemTxAttrs attrs = {
-            .secure = ptw->out_secure,
             .space = ptw->out_space,
+            .secure = arm_space_is_secure(ptw->out_space),
         };
         AddressSpace *as = arm_addressspace(cs, attrs);
         MemTxResult result = MEMTX_OK;
-- 
2.34.1


