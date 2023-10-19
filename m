Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C95717CFB6F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:42:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCe-00036F-SH; Thu, 19 Oct 2023 09:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBw-0001zI-93
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:36:02 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBo-0001EJ-SK
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:57 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32d9552d765so6192090f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722547; x=1698327347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=69JHSg6SM2bIgn/IyTKVkAnCuZSRpe0YGCFy2Ih5E+M=;
 b=iThHszA7JCDzNwltx2paU01yoSJKKjXyK75Duc210TigwknwhtAVx+Pz63jGodlcy3
 ORM1mjiFovuVgsUZ2qc6ixbbCaBSjRSxVFcdjUQkCEiUhWDhTWw9o05yYGTt6PufVmIP
 P/nnpcaUUE0qB9Io9uzjn/SYzwuP4E0RJsQJiOkcLN7R5Jpy0WAkJ2G3DzTcv7cEhs5I
 F5KQ7QjuHOcA9YgjDiogLOl9KgUpl1Ay2vXZBwI9iLfi/3iiOAEjApxRzNcYfL4RdFaB
 kz7m/+BLfbTbe4QSc2rFTWyVoZ5D6m1C+J5mpoUYVz+VkePZHZnmMd3zAnYRWXSUZiV+
 WSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722547; x=1698327347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=69JHSg6SM2bIgn/IyTKVkAnCuZSRpe0YGCFy2Ih5E+M=;
 b=DAE4JZ7MunbbjDEAlN2ScOn4bqZfupSIyvxGlDMUyHSFdN8RllRxgWgLpXaoYqTiFz
 26tBxyiy8kyW7n9OQLtbj3J0EbL3ukcTWdiS/OSFs8YXjc0kyEpUaf7cAoKMKEgnh9kI
 bCfPTe+8X5bMAZIEW+usei4zuEXYQMLbYv/ErF3/c/UcyhVsqjlGYcnkVKpDH1r6gvzj
 TdHio+s+xsvG0CYt2jxepWgDdkzNjyYDj+XD9WtM2Lk+TxuOB4cZPRfIiR325C1xZ2tx
 2vR9sTueC+TOxbiRqb0CAWmbM5g67YBQjFxn4XBID6ofj7KsbH0WkgB5/H0x/YHsqEn+
 R/yw==
X-Gm-Message-State: AOJu0Yzsa7FPBCbSg4Iro7zMIdRtSsi7s3+NwetgF/MJBqq3KURLtTqY
 DV+fXXi0C5Nsw/PYqT6MRLkubI0F0ENvGaN6a3M=
X-Google-Smtp-Source: AGHT+IFEOGf23G6yJcLSL1CDrG2Z/5kPp07aBewK6BeHRK0lfLrKsvcpxUh8iL6Fxyz2GIq+4MCoog==
X-Received: by 2002:a5d:638a:0:b0:32d:b1d7:419f with SMTP id
 p10-20020a5d638a000000b0032db1d7419fmr1656228wru.32.1697722547116; 
 Thu, 19 Oct 2023 06:35:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/24] hw/arm/smmuv3: Advertise SMMUv3.1-XNX feature
Date: Thu, 19 Oct 2023 14:35:31 +0100
Message-Id: <20231019133537.2114929-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

The SMMUv3.1-XNX feature is mandatory for an SMMUv3.1 if S2P is
supported, so we should theoretically have implemented it as part of
the recent S2P work.  Fortunately, for us the implementation is a
no-op.

This feature is about interpretation of the stage 2 page table
descriptor XN bits, which control execute permissions.

For QEMU, the permission bits passed to an IOMMU (via MemTxAttrs and
IOMMUAccessFlags) only indicate read and write; we do not distinguish
data reads from instruction reads outside the CPU proper.  In the
SMMU architecture's terms, our interconnect between the client device
and the SMMU doesn't have the ability to convey the INST attribute,
and we therefore use the default value of "data" for this attribute.

We also do not support the bits in the Stream Table Entry that can
override the on-the-bus transaction attribute permissions (we do not
set SMMU_IDR1.ATTR_PERMS_OVR=1).

These two things together mean that for our implementation, it never
has to deal with transactions with the INST attribute, and so it can
correctly ignore the XN bits entirely.  So we already implement
FEAT_XNX's "XN field is now 2 bits, not 1" behaviour to the extent
that we need to.

Advertise the presence of the feature in SMMU_IDR3.XNX.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20230914145705.1648377-4-peter.maydell@linaro.org
---
 hw/arm/smmuv3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index f03d58300fa..c3871ae067f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -279,6 +279,10 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS,   SMMU_CMDQS);
 
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, HAD, 1);
+    if (FIELD_EX32(s->idr[0], IDR0, S2P)) {
+        /* XNX is a stage-2-specific feature */
+        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, XNX, 1);
+    }
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
 
-- 
2.34.1


