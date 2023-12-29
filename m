Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCF58201E4
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:33:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKPn-0007Qm-8w; Fri, 29 Dec 2023 16:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPk-0007ID-8o
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:08 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPf-0000MU-C4
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:08 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6dc076e9e59so1478170a34.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885341; x=1704490141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aNh1yh21I+GB6YiRXDF7E0H7kYf0QvfrR1nWFgKbksM=;
 b=Qvd4mDicmxBEif2vOlXfGSRfunKUV3hj60ek6kTa3iruemahC36Z5pqyzcBsFlR9ne
 qauXgmaCrxMDVCobHwsx3Tb57H1uZMoMTFN0DylXmUlboGkqfqMrC7dGS6FLHJJUdXU7
 BcjCwd9CL+kpaZSHexJk3d3oL7Xyfv6SxB96Rs7AlTRTQtHh0tC8qSzbp7AO3xyjUm6h
 AkLs+BUr37D2lG+8uAIJe/usTzkULmlowEBxgAnn03DrVqXiHqv/AfW1InXul58OSnJo
 23nrJbA3LOTcuhnprtQ5Emktnnlq+rFDjDtVR951Gt7fAeuqXliVuViSHjtaYyWnCNmN
 2PTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885341; x=1704490141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aNh1yh21I+GB6YiRXDF7E0H7kYf0QvfrR1nWFgKbksM=;
 b=NepfsGJR703BpdD0LyXLBVU2PLQHCnj4+OhqkwXZ9xN81IAGNSQ9ZOELL5XzcUdypt
 H9ng72KL9N20WV6zWgDF60YDFXyapVhzJ24ttvT7p1npcX0qFee8jufiENfLGXQirWDw
 yyHzJTFmPhuI0XLaBKhXDilnMFMDl+WYmB6e8cBm/GgjUC1q43Tms6zwPI8S2iGqyOjs
 U1WdvNOTa2yfEjW3L8RPH2YPAAIWKnj5GWdSTPYvHJzzxWilJm6pCbM8Xa8+4RhaCo5T
 K+f2lkGZ0fc9N5PpXwrHX81FMeoSOuotQHUxe/Mo8hUvDbjX6jomzUMU0cyWCc5Y16Ap
 xncw==
X-Gm-Message-State: AOJu0Yz3nQMadDF+0C4N6pUEqjMqCC965q4axzvnQbcDG1Kplncr5aSE
 h+C420YF7rPCm99SbdCjBo2I955quxtTNszMu4O5ayVWZAj+bg==
X-Google-Smtp-Source: AGHT+IEwAp8AYC0VDgHMN6E5bVgjJ5GaMQHdnxDwEXuwEI5eIEqNqdaYqwJAj4tFfIgouMkcBShdTw==
X-Received: by 2002:a05:6870:63a1:b0:203:e9cc:4878 with SMTP id
 t33-20020a05687063a100b00203e9cc4878mr14659108oap.46.1703885341178; 
 Fri, 29 Dec 2023 13:29:01 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.28.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:29:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/71] hw/sparc: Constify VMState
Date: Sat, 30 Dec 2023 08:23:29 +1100
Message-Id: <20231229212346.147149-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-55-richard.henderson@linaro.org>
---
 hw/sparc/sun4m_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index eb40f9377c..06703b1d96 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -331,7 +331,7 @@ static const VMStateDescription vmstate_iommu = {
     .name = "iommu",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, IOMMUState, IOMMU_NREGS),
         VMSTATE_UINT64(iostart, IOMMUState),
         VMSTATE_END_OF_LIST()
-- 
2.34.1


