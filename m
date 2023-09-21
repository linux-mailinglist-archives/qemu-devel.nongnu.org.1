Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B5C7A985B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:41:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcN-00021c-H4; Thu, 21 Sep 2023 13:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcJ-00020X-Sy
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:32 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcE-0007ej-02
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:31 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32155a45957so1265182f8f.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317844; x=1695922644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PKp1eQrVUMTaEf0w4kuHa7A8lBLx9ISnYKLL0swOrb0=;
 b=OtHpPxgB1aFkh732mf/gyrDL+qfEn4md+Mccjy3RlnZ25rNGrNExg7pt6t0W2Nbbyg
 v2j9UohTAxlVEEab5GW6/guMYmz9+hgZl2kHknx5D4owBvtngeGAISUqj+ItdDUVUiUn
 3d3NvT4Oeg6KqPC5KxdeIeqR1cshWmId2BRbfUbpzoACeQOymXh03bnQ4OIFBLGx9BSV
 fQsGkVNrtBrKAQIcbOGVYE5XIjfs9c2NXSNTez5cFm6sP25gjvzXt1C9p7gyDhpJNqmv
 kxHVUIdSzGiQn+q6G1uZNNNWOwxKHHcJTcJnWEu4RYWE6DVBm1if84G4QyQR5tqk0JQI
 O9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317844; x=1695922644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PKp1eQrVUMTaEf0w4kuHa7A8lBLx9ISnYKLL0swOrb0=;
 b=DHlxQcH0FYEpurvUKskHjWfpUOX8AMIxX0h9K3ZPdfUbeWqDFPjiC7cGL1q4lWHjmm
 eS6pgIH2b/1ZiiA6lyuHagGREsP0kvnxJbid2ZxdBD811EOuE8AYxhobAXYSrtdUc2Vw
 BVPK+pyWTqOszvCVcY3d9XKIpZgLCQAKNhPqOPxijcSKbydSAEKWR6C041MlrImDOhRn
 JH0D/xW47wJMN0e9OXNAjrZqdGqhlb+isyEe8FZvig4MjvUew7UQXoR73pHHGK50WKZe
 k9t0ScVP7T1PmkekS+6ubAZVLTramf6L9SR515GGXsEkGXZz8+b04eO7qFbQPYetSWTH
 9xpA==
X-Gm-Message-State: AOJu0YyghE/SSxH1jdvacKcBba/FrlBCqwPf6sbwPAKY557mzlJ/XaX5
 YVA+btT+42uYJwmcEWt6QCn2RjG3P3fM41JhLkQ=
X-Google-Smtp-Source: AGHT+IHluQKW8YPXNvY0VdYSbZvMbeBATCGgMkA9eoRCK7VzASNdPRoJOuOR6n5YbvITZJ24PYVmKQ==
X-Received: by 2002:a5d:452d:0:b0:321:677d:98b0 with SMTP id
 j13-20020a5d452d000000b00321677d98b0mr5195203wra.11.1695317843812; 
 Thu, 21 Sep 2023 10:37:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/30] hw/arm/boot: Set SCR_EL3.FGTEn when booting kernel
Date: Thu, 21 Sep 2023 18:36:53 +0100
Message-Id: <20230921173720.3250581-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Fabian Vogt <fvogt@suse.de>

Just like d7ef5e16a17c sets SCR_EL3.HXEn for FEAT_HCX, this commit
handles SCR_EL3.FGTEn for FEAT_FGT:

When we direct boot a kernel on a CPU which emulates EL3, we need to
set up the EL3 system registers as the Linux kernel documentation
specifies:
    https://www.kernel.org/doc/Documentation/arm64/booting.rst

> For CPUs with the Fine Grained Traps (FEAT_FGT) extension present:
> - If EL3 is present and the kernel is entered at EL2:
>   - SCR_EL3.FGTEn (bit 27) must be initialised to 0b1.

Cc: qemu-stable@nongnu.org
Signed-off-by: Fabian Vogt <fvogt@suse.de>
Message-id: 4831384.GXAFRqVoOG@linux-e202.suse.de
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 720f22531a6..24fa1690600 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -761,6 +761,10 @@ static void do_cpu_reset(void *opaque)
                     if (cpu_isar_feature(aa64_hcx, cpu)) {
                         env->cp15.scr_el3 |= SCR_HXEN;
                     }
+                    if (cpu_isar_feature(aa64_fgt, cpu)) {
+                        env->cp15.scr_el3 |= SCR_FGTEN;
+                    }
+
                     /* AArch64 kernels never boot in secure mode */
                     assert(!info->secure_boot);
                     /* This hook is only supported for AArch32 currently:
-- 
2.34.1


