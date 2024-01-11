Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7425F82ACE6
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:08:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssh-0001bC-GQ; Thu, 11 Jan 2024 06:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssE-0001OA-3V
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:25 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssB-0004TD-Pm
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:21 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33761e291c1so3051028f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971118; x=1705575918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eJ2Bh2KqWHFGhwYEJgAtL+OLtHKA2aP7b6zI0XswIFc=;
 b=DsriuO8dhxbadttNkhkihV2kjaBlI3gnEnhwUomciI134r7uChbnBLUNNc68RLOS+3
 zneqOPRRXVcq3TdLNU909eer9zZGsDKIRdJPtG9cEUsKuhcfVV05z3z4CErJWWMXyCxR
 5+st7BqwluPO48wyyei9RoA2VGqfAGMwoUs03H9b2BCkjQ0fa9UYZ79TTQDWpQLSIjcp
 iDJ1AmU9c8wlMmCFM46vyUQc/p3b3RsKbeeyCAZImdpuO3kpGJcJe1hmNN6HCr8IV/uI
 t0L0klLWk/PjYSrEV16bQUpOj4opeH1Uz4e/uhoV77mQDa20xuMyjVHb+ks75w1l9B/I
 gbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971118; x=1705575918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJ2Bh2KqWHFGhwYEJgAtL+OLtHKA2aP7b6zI0XswIFc=;
 b=KkB3ZdZ6gVEOoXw2lRIDRvlOOpA7GnsXpEPglpmEWF4in9RcYfJ96XMhg7//No+rk+
 TkB3OlOKFqwy566Qiguu2v/0L8FEGB3kKDZKW7fkWWjUWuS8cxBbmVOVyll50/NHxuFI
 QZ2ClwkGpF94FtxSdKaJ1EfFkQkXnsOGj+daqxd8A0n5/kI98fMVrh7cq/kCIlnHJZqS
 GRgfTmcJpXHre6R/hI0UPc3DVqzLYxvzFk6BbOPk5fBXlElpCAv/XfLREwIF85tr2F0r
 eHGaCTyD/QeUwr/0YJ9fbsqRiYktYvFIOvSrnv4YZ9OEWABbVKrRezxCP8zX5x1nb7o/
 7oRw==
X-Gm-Message-State: AOJu0Yxe/7/jBPPmg14+e2CYFjknQPEoy7F1svfAsL2tqFFptaGFVdWD
 zq7sNtD3YpL8maRq/32qdT1Vf4SJ0KbYr4eupLVc4LuEYpQ=
X-Google-Smtp-Source: AGHT+IGxFtRsWhV4yNdjp6bYNE+WmJYPJReM9C8o5SvFBJtCtY8oI+fxc92AAwPjDcyIRR8DOcGRIg==
X-Received: by 2002:a05:600c:520d:b0:40e:622f:ebf with SMTP id
 fb13-20020a05600c520d00b0040e622f0ebfmr128544wmb.178.1704971118097; 
 Thu, 11 Jan 2024 03:05:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/41] target/arm: Handle FEAT_NV page table attribute changes
Date: Thu, 11 Jan 2024 11:04:50 +0000
Message-Id: <20240111110505.1563291-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
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

FEAT_NV requires that when HCR_EL2.{NV,NV1} == {1,1} the handling
of some of the page table attribute bits changes for the EL1&0
translation regime:

 * for block and page descriptors:
  - bit [54] holds PXN, not UXN
  - bit [53] is RES0, and the effective value of UXN is 0
  - bit [6], AP[1], is treated as 0
 * for table descriptors, when hierarchical permissions are enabled:
  - bit [60] holds PXNTable, not UXNTable
  - bit [59] is RES0
  - bit [61], APTable[0] is treated as 0

Implement these changes to the page table attribute handling.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/ptw.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 0ecd3a36dad..2d4fa8dbcaf 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1581,6 +1581,12 @@ static bool lpae_block_desc_valid(ARMCPU *cpu, bool ds,
     }
 }
 
+static bool nv_nv1_enabled(CPUARMState *env, S1Translate *ptw)
+{
+    uint64_t hcr = arm_hcr_el2_eff_secstate(env, ptw->in_space);
+    return (hcr & (HCR_NV | HCR_NV1)) == (HCR_NV | HCR_NV1);
+}
+
 /**
  * get_phys_addr_lpae: perform one stage of page table walk, LPAE format
  *
@@ -1989,6 +1995,21 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         xn = extract64(attrs, 54, 1);
         pxn = extract64(attrs, 53, 1);
 
+        if (el == 1 && nv_nv1_enabled(env, ptw)) {
+            /*
+             * With FEAT_NV, when HCR_EL2.{NV,NV1} == {1,1}, the block/page
+             * descriptor bit 54 holds PXN, 53 is RES0, and the effective value
+             * of UXN is 0. Similarly for bits 59 and 60 in table descriptors
+             * (which we have already folded into bits 53 and 54 of attrs).
+             * AP[1] (descriptor bit 6, our ap bit 0) is treated as 0.
+             * Similarly, APTable[0] from the table descriptor is treated as 0;
+             * we already folded this into AP[1] and squashing that to 0 does
+             * the right thing.
+             */
+            pxn = xn;
+            xn = 0;
+            ap &= ~1;
+        }
         /*
          * Note that we modified ptw->in_space earlier for NSTable, but
          * result->f.attrs retains a copy of the original security space.
-- 
2.34.1


