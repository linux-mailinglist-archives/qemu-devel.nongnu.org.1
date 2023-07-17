Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BEA75633E
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:52:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNhw-0003fv-T5; Mon, 17 Jul 2023 08:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLNe1-0008Uh-5p
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:48:12 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLNdn-0008TJ-4R
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:48:04 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-315adee6ac8so4377235f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 05:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689598069; x=1692190069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rRttNqKmS3icTZXVSo6Zoczfc48IgD7HZ3JpXissknE=;
 b=G0/XIEWu3T0nWigu0UIAgUQGtMXfORtfnsyVNTXFFOk6t57F0fs8zHr9UAXLWtMY6v
 WwYtJj544PV/eCp0JT/BwCMT9w947DqsngwrT56pK7ppeKNp7fZTPbVnNd31cQZCCxp1
 DdTezd4hwa0G1r+kQ6YzxalMi04YEt4S8d0jZKsyG9lUCv4PQJxWdddpse+1mw9h0rSW
 RVb/Yv76laF2j7w381h42UGxeacZxpvap9EO6d+vAFFv7vx3RnYg7rFkbV4RG9nDtPTQ
 w/+CZlgS1SHI0Fdz4o5ypTQRh02Os/Jjvrk8rRKYopSxyFjdYAHw5WSC0GVZC5pzsfXf
 hyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689598069; x=1692190069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rRttNqKmS3icTZXVSo6Zoczfc48IgD7HZ3JpXissknE=;
 b=UKha7MjGBniUVDaXCGLSL0x5zm2E2cW6KknmB/cFXlccfG53//N1I9+oLAgukeJ4og
 xLRmZxh0GtXeMgt0peregVw4WTJ0w/SrPmWNz+/Gi6NFnaXboTAxdMJRisvRvJHZY07p
 LIruikDTTxVByYHoUYjvK482eizVGrzQcotM5oPUYc44EnqXaeCKTShmgGoPCjHL5qFj
 q+9Vz3PSIUL03UP5Y8Yr+u0jinQncxdJL3ZpB+I5vOkawA5OQjCFWNGH47bIjDVJm/8U
 qeZtCel4QpEvXJ8XWt26M8+SktwCtY06iljM3Y2xAt+efsGohkbR3ji3+Vg18JLNKox+
 mLXQ==
X-Gm-Message-State: ABy/qLZ3RZS4kKp2kE5zHmAOQwUejAUYaZqyPgcj8CdNKIUDUszCP2xq
 9kSdOkZA/xqxAnB2BfwABcRpY08OqATQLt37pTQ=
X-Google-Smtp-Source: APBJJlEc9PTm+7q6FHdY5kaafKdsCW6wfd1qqA6eLjUmrdtielEhYAKmn4tr0yFMOVk5ROxZ3/3e0w==
X-Received: by 2002:a5d:452d:0:b0:315:ad03:a9e0 with SMTP id
 j13-20020a5d452d000000b00315ad03a9e0mr9488850wra.45.1689598069324; 
 Mon, 17 Jul 2023 05:47:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a5d6790000000b003112ab916cdsm19337737wru.73.2023.07.17.05.47.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 05:47:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/7] target/arm/ptw.c: Add comments to S1Translate struct fields
Date: Mon, 17 Jul 2023 13:47:42 +0100
Message-Id: <20230717124746.759085-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717124746.759085-1-peter.maydell@linaro.org>
References: <20230717124746.759085-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add comments to the in_* fields in the S1Translate struct
that explain what they're doing.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230710152130.3928330-2-peter.maydell@linaro.org
---
 target/arm/ptw.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 9aaff1546a6..21749375f97 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -19,10 +19,50 @@
 #endif
 
 typedef struct S1Translate {
+    /*
+     * in_mmu_idx : specifies which TTBR, TCR, etc to use for the walk.
+     * Together with in_space, specifies the architectural translation regime.
+     */
     ARMMMUIdx in_mmu_idx;
+    /*
+     * in_ptw_idx: specifies which mmuidx to use for the actual
+     * page table descriptor load operations. This will be one of the
+     * ARMMMUIdx_Stage2* or one of the ARMMMUIdx_Phys_* indexes.
+     * If a Secure ptw is "downgraded" to NonSecure by an NSTable bit,
+     * this field is updated accordingly.
+     */
     ARMMMUIdx in_ptw_idx;
+    /*
+     * in_space: the security space for this walk. This plus
+     * the in_mmu_idx specify the architectural translation regime.
+     * If a Secure ptw is "downgraded" to NonSecure by an NSTable bit,
+     * this field is updated accordingly.
+     *
+     * Note that the security space for the in_ptw_idx may be different
+     * from that for the in_mmu_idx. We do not need to explicitly track
+     * the in_ptw_idx security space because:
+     *  - if the in_ptw_idx is an ARMMMUIdx_Phys_* then the mmuidx
+     *    itself specifies the security space
+     *  - if the in_ptw_idx is an ARMMMUIdx_Stage2* then the security
+     *    space used for ptw reads is the same as that of the security
+     *    space of the stage 1 translation for all cases except where
+     *    stage 1 is Secure; in that case the only possibilities for
+     *    the ptw read are Secure and NonSecure, and the in_ptw_idx
+     *    value being Stage2 vs Stage2_S distinguishes those.
+     */
     ARMSecuritySpace in_space;
+    /*
+     * in_secure: whether the translation regime is a Secure one.
+     * This is always equal to arm_space_is_secure(in_space).
+     * If a Secure ptw is "downgraded" to NonSecure by an NSTable bit,
+     * this field is updated accordingly.
+     */
     bool in_secure;
+    /*
+     * in_debug: is this a QEMU debug access (gdbstub, etc)? Debug
+     * accesses will not update the guest page table access flags
+     * and will not change the state of the softmmu TLBs.
+     */
     bool in_debug;
     /*
      * If this is stage 2 of a stage 1+2 page table walk, then this must
-- 
2.34.1


