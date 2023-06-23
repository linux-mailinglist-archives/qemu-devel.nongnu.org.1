Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C97A73B747
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:32:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfx9-0001ih-6J; Fri, 23 Jun 2023 08:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx1-0001VE-Gv
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:43 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfwz-0000fE-Sf
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:43 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4f866a3d8e4so745291e87.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523500; x=1690115500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O3giUrXUWlJANB8y5onRyuiewyiTWnhkcbDMbixvBvo=;
 b=daC5cycjdy74xtObdfmz+bxrpcgKvNx/+LoT1z1cBfqn7vaCeOtTYso9WPhl2l0F3M
 PKCh+ahRtRd7A7KrNuWkgpLFx6W096Yb26mirHV+tEmoGREQWxKRMKFTpUt5h6fat28X
 LAM/aJGTehviLyvC8OTI1yS/YXHgAs6Sij4Mr6yvyI2kysr0T8g5/ZdHTNNmyBqgeCvj
 Ck1s4oIS5GkmYQg1opz5CZjz38URuCVLjr/Cx6BsSClQHSHjXFRLeUaFttmcDId0kBxr
 lGiGOB7KMgyly9GeHkpthKLrQeolusc0dH5QKVxAreShTEzVYm03DLhsG/JXulvXIwDj
 dsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523500; x=1690115500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O3giUrXUWlJANB8y5onRyuiewyiTWnhkcbDMbixvBvo=;
 b=aPMQ2j0O5qb2B2XQohigGR5dBUGPU3qEYzjtP7B8CLW5cxRfgCTyy/HFdLiG7WYcGa
 llV6G9U4D7flGn2zFB61MnwUALBLSldSAwCG7j3/4w+W+tZ8RkfYuqwhyAP+Oj4jIkvQ
 h4k3RQh7+P+zyM7v0AiXA/KXezSz71l3NY2ZIqV/faQnOvHJJ7tTb9XfMy78WTOHxh4w
 KYbnSPzKFt1+OFMy0N1XqHpUJQ1t5495mWxdFKx5fsfUvJBDT/s4QE40/EZ4Ra4x2oVq
 0aqbVZrcUfEqxrqjND79lWRxZy6DWyW/kowQBaBwaI2Kq1sUYCR5hrR+V3rrccbewBdO
 joCQ==
X-Gm-Message-State: AC+VfDxsFlwBzmanHqaUvSzcDOy88GT7d6ggNeXNaE8nZ2g3YAYgQluT
 02WJiXbe0VdvfRKoDdiU3F/o/l/PIit7tEtbfwM=
X-Google-Smtp-Source: ACHHUZ5LNCCJM1WyP3LllEfC9r9iHnYaC130nZfxq3ihTqdT2HUWpt1gzG3+bQ+6kS8Zm1Kg9lPMfQ==
X-Received: by 2002:a19:710b:0:b0:4f6:2a02:fc1a with SMTP id
 m11-20020a19710b000000b004f62a02fc1amr12394407lfc.17.1687523500292; 
 Fri, 23 Jun 2023 05:31:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/26] include/exec/memattrs: Add two bits of space to
 MemTxAttrs
Date: Fri, 23 Jun 2023 13:31:15 +0100
Message-Id: <20230623123135.1788191-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

We will need 2 bits to represent ARMSecurityState.

Do not attempt to replace or widen secure, even though it
logically overlaps the new field -- there are uses within
e.g. hw/block/pflash_cfi01.c, which don't know anything
specific about ARM.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230620124418.805717-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memattrs.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 9fb98bc1efd..d04170aa27a 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -29,10 +29,17 @@ typedef struct MemTxAttrs {
      * "didn't specify" if necessary.
      */
     unsigned int unspecified:1;
-    /* ARM/AMBA: TrustZone Secure access
+    /*
+     * ARM/AMBA: TrustZone Secure access
      * x86: System Management Mode access
      */
     unsigned int secure:1;
+    /*
+     * ARM: ArmSecuritySpace.  This partially overlaps secure, but it is
+     * easier to have both fields to assist code that does not understand
+     * ARMv9 RME, or no specific knowledge of ARM at all (e.g. pflash).
+     */
+    unsigned int space:2;
     /* Memory access is usermode (unprivileged) */
     unsigned int user:1;
     /*
-- 
2.34.1


